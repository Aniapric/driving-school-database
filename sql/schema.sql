-- Drop existing objects
BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW VW_DETALII_DOSAR_ELEV';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

DROP TABLE REVIZIE_VEHICUL CASCADE CONSTRAINTS;
DROP TABLE LICENTA_INSTRUCTOR CASCADE CONSTRAINTS;
DROP TABLE EXAMEN CASCADE CONSTRAINTS;
DROP TABLE EXAMINATOR CASCADE CONSTRAINTS;
DROP TABLE PARTICIPARE_CURS CASCADE CONSTRAINTS;
DROP TABLE CURS_TEORETIC CASCADE CONSTRAINTS;
DROP TABLE SEDINTA_PRACTICA CASCADE CONSTRAINTS;
DROP TABLE PLATA CASCADE CONSTRAINTS;
DROP TABLE DOSAR_INSCRIERE CASCADE CONSTRAINTS;
DROP TABLE VEHICUL CASCADE CONSTRAINTS;
DROP TABLE INSTRUCTOR CASCADE CONSTRAINTS;
DROP TABLE ELEV CASCADE CONSTRAINTS;

BEGIN
    FOR seq IN (
        SELECT sequence_name 
        FROM user_sequences 
        WHERE sequence_name IN (
            'ELEV_SEQ', 'INSTRUCTOR_SEQ', 'VEHICUL_SEQ', 'DOSAR_SEQ', 
            'PLATA_SEQ', 'SEDINTA_SEQ', 'CURS_SEQ', 'EXAMINATOR_SEQ', 
            'EXAMEN_SEQ', 'REVIZIE_SEQ'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seq.sequence_name;
    END LOOP;
END;
/

-- Sequences
CREATE SEQUENCE elev_seq        START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE instructor_seq  START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE vehicul_seq     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE dosar_seq       START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE plata_seq       START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sedinta_seq     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE curs_seq        START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE examinator_seq  START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE examen_seq      START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE revizie_seq     START WITH 1 INCREMENT BY 1 NOCACHE;

-- 1. Table ELEV
CREATE TABLE ELEV (
    elev_id       NUMBER(10) PRIMARY KEY,
    nume          VARCHAR2(50) NOT NULL,
    prenume       VARCHAR2(50) NOT NULL,
    cnp           CHAR(13) UNIQUE NOT NULL,
    data_nasterii DATE NOT NULL,
    telefon       VARCHAR2(15) NOT NULL,
    email         VARCHAR2(100),
    adresa        VARCHAR2(100),
    CONSTRAINT chk_elev_cnp_len CHECK (LENGTH(cnp) = 13)
);

-- Trigger: check student age >= 18
CREATE OR REPLACE TRIGGER trg_check_varsta_elev
BEFORE INSERT OR UPDATE ON ELEV
FOR EACH ROW
BEGIN
    IF MONTHS_BETWEEN(SYSDATE, :NEW.data_nasterii) / 12 < 18 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Student must be at least 18 years old');
    END IF;
END;
/

-- 2. Table INSTRUCTOR
CREATE TABLE INSTRUCTOR (
    instructor_id NUMBER(10) PRIMARY KEY,
    nume          VARCHAR2(50) NOT NULL,
    prenume       VARCHAR2(50) NOT NULL,
    cnp           CHAR(13) UNIQUE NOT NULL,
    telefon       VARCHAR2(15) NOT NULL,
    email         VARCHAR2(100),
    data_angajare DATE DEFAULT SYSDATE NOT NULL,
    salariu       NUMBER(8,2) NOT NULL CHECK (salariu > 0),
    mentor_id     NUMBER(10),
    CONSTRAINT chk_inst_cnp_len CHECK (LENGTH(cnp) = 13),
    CONSTRAINT fk_inst_mentor FOREIGN KEY (mentor_id) REFERENCES INSTRUCTOR(instructor_id) ON DELETE SET NULL
);

-- Trigger: hire date cannot be in the future
CREATE OR REPLACE TRIGGER trg_check_data_angajare
BEFORE INSERT OR UPDATE ON INSTRUCTOR
FOR EACH ROW
BEGIN
    IF :NEW.data_angajare > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'Hire date cannot be in the future');
    END IF;
END;
/

-- 3. Table VEHICUL
CREATE TABLE VEHICUL (
    vehicul_id       NUMBER(10) PRIMARY KEY,
    marca            VARCHAR2(30) NOT NULL,
    model            VARCHAR2(30) NOT NULL,
    categorie        CHAR(2) NOT NULL CHECK (categorie IN ('A', 'B', 'C', 'D')),
    nr_inmatriculare VARCHAR2(10) UNIQUE NOT NULL,
    itp_expira       DATE NOT NULL,
    an_fabricatie    NUMBER(4) CHECK (an_fabricatie >= 1990)
);

-- 4. Table CURS_TEORETIC
CREATE TABLE CURS_TEORETIC (
    curs_id      NUMBER(10) PRIMARY KEY,
    tema         VARCHAR2(100) NOT NULL,
    durata_ore   NUMBER(2) CHECK (durata_ore > 0),
    data_inceput DATE,
    data_final   DATE
);

-- 5. Table EXAMINATOR
CREATE TABLE EXAMINATOR (
    examinator_id NUMBER(10) PRIMARY KEY,
    nume          VARCHAR2(50) NOT NULL,
    prenume       VARCHAR2(50) NOT NULL,
    cnp           CHAR(13) UNIQUE NOT NULL,
    CONSTRAINT chk_examr_cnp_len CHECK (LENGTH(cnp) = 13)
);

-- 6. Table DOSAR_INSCRIERE
CREATE TABLE DOSAR_INSCRIERE (
    dosar_id         NUMBER(10) PRIMARY KEY,
    elev_id          NUMBER(10) NOT NULL,
    categorie_permis CHAR(2) DEFAULT 'B' NOT NULL CHECK (categorie_permis IN ('A', 'B', 'C', 'D')),
    taxa_totala      NUMBER(8,2) NOT NULL CHECK (taxa_totala > 0),
    suma_achitata    NUMBER(8,2) DEFAULT 0 CHECK (suma_achitata >= 0),
    status_dosar     VARCHAR2(20) DEFAULT 'Incomplet' CHECK (status_dosar IN ('Incomplet', 'Gata', 'Finalizat', 'În verificare')),
    aviz_psihologic  VARCHAR2(20) CHECK (aviz_psihologic IN ('Admis', 'Respins')),
    fisa_medicala    VARCHAR2(20) CHECK (fisa_medicala IN ('Admis', 'Respins')),
    CONSTRAINT fk_dosar_elev FOREIGN KEY (elev_id) REFERENCES ELEV(elev_id) ON DELETE CASCADE
);

-- 7. Table PLATA
CREATE TABLE PLATA (
    plata_id     NUMBER(10) PRIMARY KEY,
    dosar_id     NUMBER(10) NOT NULL,
    suma         NUMBER(8,2) NOT NULL CHECK (suma > 0),
    data_plata   DATE DEFAULT SYSDATE NOT NULL,
    metoda_plata VARCHAR2(20) DEFAULT 'Cash' CHECK (metoda_plata IN ('Cash', 'Card', 'Transfer')),
    CONSTRAINT fk_plata_dosar FOREIGN KEY (dosar_id) REFERENCES DOSAR_INSCRIERE(dosar_id) ON DELETE CASCADE
);

-- 8. Table SEDINTA_PRACTICA
CREATE TABLE SEDINTA_PRACTICA (
    sedinta_id    NUMBER(10) PRIMARY KEY,
    elev_id       NUMBER(10) NOT NULL,
    instructor_id NUMBER(10) NOT NULL,
    vehicul_id    NUMBER(10) NOT NULL,
    data_sedinta  DATE DEFAULT SYSDATE NOT NULL,
    durata_ore    NUMBER(2) DEFAULT 2 NOT NULL CHECK (durata_ore > 0),
    km_parcursi   NUMBER(4) CHECK (km_parcursi > 0),
    status        VARCHAR2(20) DEFAULT 'Programată' CHECK (status IN ('Programată', 'Efectuată', 'Anulată')),
    CONSTRAINT fk_sp_elev FOREIGN KEY (elev_id) REFERENCES ELEV(elev_id) ON DELETE CASCADE,
    CONSTRAINT fk_sp_inst FOREIGN KEY (instructor_id) REFERENCES INSTRUCTOR(instructor_id),
    CONSTRAINT fk_sp_veh  FOREIGN KEY (vehicul_id) REFERENCES VEHICUL(vehicul_id)
);

-- 9. Table PARTICIPARE_CURS (associative M:N)
CREATE TABLE PARTICIPARE_CURS (
    curs_id NUMBER(10) NOT NULL,
    elev_id NUMBER(10) NOT NULL,
    PRIMARY KEY (curs_id, elev_id),
    CONSTRAINT fk_pc_curs FOREIGN KEY (curs_id) REFERENCES CURS_TEORETIC(curs_id) ON DELETE CASCADE,
    CONSTRAINT fk_pc_elev FOREIGN KEY (elev_id) REFERENCES ELEV(elev_id) ON DELETE CASCADE
);

-- 10. Table EXAMEN
CREATE TABLE EXAMEN (
    examen_id     NUMBER(10) PRIMARY KEY,
    elev_id       NUMBER(10) NOT NULL,
    examinator_id NUMBER(10) NOT NULL,
    tip           VARCHAR2(10) NOT NULL CHECK (tip IN ('Sală', 'Traseu')),
    data_examen   DATE NOT NULL,
    punctaj       NUMBER(2) CHECK (punctaj BETWEEN 0 AND 26),
    rezultat      VARCHAR2(10) CHECK (rezultat IN ('Admis', 'Respins')),
    incercare     NUMBER(1) DEFAULT 1 CHECK (incercare BETWEEN 1 AND 5),
    CONSTRAINT fk_ex_elev       FOREIGN KEY (elev_id) REFERENCES ELEV(elev_id) ON DELETE CASCADE,
    CONSTRAINT fk_ex_examinator FOREIGN KEY (examinator_id) REFERENCES EXAMINATOR(examinator_id)
);

-- 11. Table LICENTA_INSTRUCTOR (associative M:N)
CREATE TABLE LICENTA_INSTRUCTOR (
    instructor_id NUMBER(10) NOT NULL,
    categorie     CHAR(2) NOT NULL CHECK (categorie IN ('A', 'B', 'C', 'D')),
    data_obtinere DATE,
    valabila_pana DATE,
    PRIMARY KEY (instructor_id, categorie),
    CONSTRAINT fk_li_instructor FOREIGN KEY (instructor_id) REFERENCES INSTRUCTOR(instructor_id) ON DELETE CASCADE
);

-- 12. Table REVIZIE_VEHICUL
CREATE TABLE REVIZIE_VEHICUL (
    revizie_id   NUMBER(10) PRIMARY KEY,
    vehicul_id   NUMBER(10) NOT NULL,
    data_revizie DATE DEFAULT SYSDATE NOT NULL,
    rezultat     VARCHAR2(20) CHECK (rezultat IN ('Admis', 'Respins')),
    CONSTRAINT fk_rv_vehicul FOREIGN KEY (vehicul_id) REFERENCES VEHICUL(vehicul_id) ON DELETE CASCADE
);
