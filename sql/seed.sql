-- 1. Insert into ELEV
INSERT INTO ELEV (elev_id, nume, prenume, cnp, data_nasterii, telefon, email, adresa)
VALUES (elev_seq.NEXTVAL, 'Popescu', 'Andrei', '1850101123456', TO_DATE('1985-01-01', 'YYYY-MM-DD'), '0722111222', 'andrei.popescu@gmail.com', 'Str. Florilor 5, Bucuresti');

INSERT INTO ELEV (elev_id, nume, prenume, cnp, data_nasterii, telefon, email, adresa)
VALUES (elev_seq.NEXTVAL, 'Ionescu', 'Maria', '2900505123456', TO_DATE('1990-05-05', 'YYYY-MM-DD'), '0733444555', 'maria.ionescu@yahoo.com', 'Bd. Unirii 10, Cluj-Napoca');

INSERT INTO ELEV (elev_id, nume, prenume, cnp, data_nasterii, telefon, email, adresa)
VALUES (elev_seq.NEXTVAL, 'Georgescu', 'Dan', '1950303123456', TO_DATE('1995-03-03', 'YYYY-MM-DD'), '0744777888', 'dan.georgescu@outlook.com', 'Calea Victoriei 100, Bucuresti');

INSERT INTO ELEV (elev_id, nume, prenume, cnp, data_nasterii, telefon, email, adresa)
VALUES (elev_seq.NEXTVAL, 'Dumitrescu', 'Elena', '2881212123456', TO_DATE('1988-12-12', 'YYYY-MM-DD'), '0755999000', 'elena.dumitrescu@gmail.com', 'Str. Lalelelor 2, Iasi');

INSERT INTO ELEV (elev_id, nume, prenume, cnp, data_nasterii, telefon, email, adresa)
VALUES (elev_seq.NEXTVAL, 'Constantin', 'Mihai', '1920707123456', TO_DATE('1992-07-07', 'YYYY-MM-DD'), '0766111333', 'mihai.constantin@mail.com', 'Bd. Mamaia 50, Constanta');

INSERT INTO ELEV (elev_id, nume, prenume, cnp, data_nasterii, telefon, email, adresa)
VALUES (elev_seq.NEXTVAL, 'Munteanu', 'Ioana', '2990101123456', TO_DATE('1999-01-01', 'YYYY-MM-DD'), '0799888777', 'ioana.munteanu@gmail.com', 'Str. Soarelui 1, Brasov');

-- 2. Insert into INSTRUCTOR
INSERT INTO INSTRUCTOR (instructor_id, nume, prenume, cnp, telefon, email, data_angajare, salariu)
VALUES (instructor_seq.NEXTVAL, 'Vasile', 'Ion', '1700101111111', '0711000111', 'ion.vasile@scoala.ro', TO_DATE('2018-03-01', 'YYYY-MM-DD'), 4500.00);

INSERT INTO INSTRUCTOR (instructor_id, nume, prenume, cnp, telefon, email, data_angajare, salariu)
VALUES (instructor_seq.NEXTVAL, 'Marin', 'Gheorghe', '1750202222222', '0711000222', 'gheorghe.marin@scoala.ro', TO_DATE('2019-06-15', 'YYYY-MM-DD'), 4800.00);

INSERT INTO INSTRUCTOR (instructor_id, nume, prenume, cnp, telefon, email, data_angajare, salariu)
VALUES (instructor_seq.NEXTVAL, 'Radu', 'Andreea', '2800303333333', '0711000333', 'andreea.radu@scoala.ro', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 4600.00);

INSERT INTO INSTRUCTOR (instructor_id, nume, prenume, cnp, telefon, email, data_angajare, salariu)
VALUES (instructor_seq.NEXTVAL, 'Stoica', 'Cristian', '1820404444444', '0711000444', 'cristi.stoica@scoala.ro', TO_DATE('2016-01-10', 'YYYY-MM-DD'), 5000.00);

INSERT INTO INSTRUCTOR (instructor_id, nume, prenume, cnp, telefon, email, data_angajare, salariu)
VALUES (instructor_seq.NEXTVAL, 'Albu', 'Simona', '2850505555555', '0711000555', 'simona.albu@scoala.ro', TO_DATE('2022-04-20', 'YYYY-MM-DD'), 4700.00);

UPDATE INSTRUCTOR SET mentor_id = 4 WHERE instructor_id IN (1, 3);

-- 3. Insert into VEHICUL
INSERT INTO VEHICUL (vehicul_id, marca, model, categorie, nr_inmatriculare, itp_expira, an_fabricatie)
VALUES (vehicul_seq.NEXTVAL, 'Dacia', 'Logan', 'B', 'B100ABC', TO_DATE('2025-10-10', 'YYYY-MM-DD'), 2021);

INSERT INTO VEHICUL (vehicul_id, marca, model, categorie, nr_inmatriculare, itp_expira, an_fabricatie)
VALUES (vehicul_seq.NEXTVAL, 'Volkswagen', 'Golf', 'B', 'B200VWG', TO_DATE('2025-12-20', 'YYYY-MM-DD'), 2020);

INSERT INTO VEHICUL (vehicul_id, marca, model, categorie, nr_inmatriculare, itp_expira, an_fabricatie)
VALUES (vehicul_seq.NEXTVAL, 'MAN', 'TGL', 'C', 'B300MAN', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 2019);

INSERT INTO VEHICUL (vehicul_id, marca, model, categorie, nr_inmatriculare, itp_expira, an_fabricatie)
VALUES (vehicul_seq.NEXTVAL, 'Yamaha', 'MT-07', 'A', 'B400YAM', TO_DATE('2025-05-01', 'YYYY-MM-DD'), 2022);

INSERT INTO VEHICUL (vehicul_id, marca, model, categorie, nr_inmatriculare, itp_expira, an_fabricatie)
VALUES (vehicul_seq.NEXTVAL, 'Mercedes-Benz', 'Citaro', 'D', 'B500BUS', TO_DATE('2025-08-30', 'YYYY-MM-DD'), 2018);

-- 4. Insert into CURS_TEORETIC
INSERT INTO CURS_TEORETIC (curs_id, tema, durata_ore, data_inceput, data_final)
VALUES (curs_seq.NEXTVAL, 'General Traffic Legislation', 10, TO_DATE('2024-01-10', 'YYYY-MM-DD'), TO_DATE('2024-01-12', 'YYYY-MM-DD'));

INSERT INTO CURS_TEORETIC (curs_id, tema, durata_ore, data_inceput, data_final)
VALUES (curs_seq.NEXTVAL, 'First Aid Certification', 4, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-15', 'YYYY-MM-DD'));

INSERT INTO CURS_TEORETIC (curs_id, tema, durata_ore, data_inceput, data_final)
VALUES (curs_seq.NEXTVAL, 'Defensive & Eco Driving', 2, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO CURS_TEORETIC (curs_id, tema, durata_ore, data_inceput, data_final)
VALUES (curs_seq.NEXTVAL, 'Basic Automotive Mechanics', 6, TO_DATE('2024-02-10', 'YYYY-MM-DD'), TO_DATE('2024-02-11', 'YYYY-MM-DD'));

INSERT INTO CURS_TEORETIC (curs_id, tema, durata_ore, data_inceput, data_final)
VALUES (curs_seq.NEXTVAL, 'Road Psychology & Safety Culture', 2, TO_DATE('2024-02-15', 'YYYY-MM-DD'), TO_DATE('2024-02-15', 'YYYY-MM-DD'));

-- 5. Insert into EXAMINATOR
INSERT INTO EXAMINATOR (examinator_id, nume, prenume, cnp)
VALUES (examinator_seq.NEXTVAL, 'Lupu', 'Cornel', '1651010123456');

INSERT INTO EXAMINATOR (examinator_id, nume, prenume, cnp)
VALUES (examinator_seq.NEXTVAL, 'Manea', 'Viorel', '1701111123456');

INSERT INTO EXAMINATOR (examinator_id, nume, prenume, cnp)
VALUES (examinator_seq.NEXTVAL, 'Popa', 'Andreea', '2750808123456');

INSERT INTO EXAMINATOR (examinator_id, nume, prenume, cnp)
VALUES (examinator_seq.NEXTVAL, 'Goran', 'Stefan', '1820202123456');

INSERT INTO EXAMINATOR (examinator_id, nume, prenume, cnp)
VALUES (examinator_seq.NEXTVAL, 'Enache', 'Marius', '1780404123456');

-- 6. Insert into DOSAR_INSCRIERE
INSERT INTO DOSAR_INSCRIERE (dosar_id, elev_id, categorie_permis, taxa_totala, suma_achitata, status_dosar, aviz_psihologic, fisa_medicala)
VALUES (dosar_seq.NEXTVAL, 1, 'B', 2000.00, 2000.00, 'Gata', 'Admis', 'Admis');

INSERT INTO DOSAR_INSCRIERE (dosar_id, elev_id, categorie_permis, taxa_totala, suma_achitata, status_dosar, aviz_psihologic, fisa_medicala)
VALUES (dosar_seq.NEXTVAL, 2, 'B', 2000.00, 1000.00, 'Incomplet', 'Admis', NULL);

INSERT INTO DOSAR_INSCRIERE (dosar_id, elev_id, categorie_permis, taxa_totala, suma_achitata, status_dosar, aviz_psihologic, fisa_medicala)
VALUES (dosar_seq.NEXTVAL, 3, 'C', 3500.00, 3500.00, 'Gata', 'Admis', 'Admis');

INSERT INTO DOSAR_INSCRIERE (dosar_id, elev_id, categorie_permis, taxa_totala, suma_achitata, status_dosar, aviz_psihologic, fisa_medicala)
VALUES (dosar_seq.NEXTVAL, 4, 'A', 1500.00, 500.00, 'Incomplet', NULL, 'Admis');

INSERT INTO DOSAR_INSCRIERE (dosar_id, elev_id, categorie_permis, taxa_totala, suma_achitata, status_dosar, aviz_psihologic, fisa_medicala)
VALUES (dosar_seq.NEXTVAL, 5, 'D', 4000.00, 4000.00, 'Gata', 'Admis', 'Admis');

-- 7. Insert into PLATA
INSERT INTO PLATA (plata_id, dosar_id, suma, data_plata, metoda_plata)
VALUES (plata_seq.NEXTVAL, 1, 2000.00, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'Card');

INSERT INTO PLATA (plata_id, dosar_id, suma, data_plata, metoda_plata)
VALUES (plata_seq.NEXTVAL, 2, 1000.00, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'Cash');

INSERT INTO PLATA (plata_id, dosar_id, suma, data_plata, metoda_plata)
VALUES (plata_seq.NEXTVAL, 3, 3500.00, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Transfer');

INSERT INTO PLATA (plata_id, dosar_id, suma, data_plata, metoda_plata)
VALUES (plata_seq.NEXTVAL, 4, 500.00, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'Card');

INSERT INTO PLATA (plata_id, dosar_id, suma, data_plata, metoda_plata)
VALUES (plata_seq.NEXTVAL, 5, 4000.00, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 'Transfer');

-- 8. Insert into SEDINTA_PRACTICA
INSERT INTO SEDINTA_PRACTICA (sedinta_id, elev_id, instructor_id, vehicul_id, data_sedinta, durata_ore, km_parcursi, status)
VALUES (sedinta_seq.NEXTVAL, 1, 1, 1, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 2, 30, 'Efectuată');

INSERT INTO SEDINTA_PRACTICA (sedinta_id, elev_id, instructor_id, vehicul_id, data_sedinta, durata_ore, km_parcursi, status)
VALUES (sedinta_seq.NEXTVAL, 2, 1, 1, TO_DATE('2024-03-02', 'YYYY-MM-DD'), 2, 25, 'Efectuată');

INSERT INTO SEDINTA_PRACTICA (sedinta_id, elev_id, instructor_id, vehicul_id, data_sedinta, durata_ore, km_parcursi, status)
VALUES (sedinta_seq.NEXTVAL, 3, 2, 3, TO_DATE('2024-03-03', 'YYYY-MM-DD'), 4, 100, 'Efectuată');

INSERT INTO SEDINTA_PRACTICA (sedinta_id, elev_id, instructor_id, vehicul_id, data_sedinta, durata_ore, km_parcursi, status)
VALUES (sedinta_seq.NEXTVAL, 4, 3, 4, TO_DATE('2024-03-04', 'YYYY-MM-DD'), 2, 40, 'Efectuată');

INSERT INTO SEDINTA_PRACTICA (sedinta_id, elev_id, instructor_id, vehicul_id, data_sedinta, durata_ore, km_parcursi, status)
VALUES (sedinta_seq.NEXTVAL, 5, 4, 5, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 4, 120, 'Efectuată');

INSERT INTO SEDINTA_PRACTICA (sedinta_id, elev_id, instructor_id, vehicul_id, data_sedinta, durata_ore, km_parcursi, status)
VALUES (sedinta_seq.NEXTVAL, 2, 1, 1, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 2, NULL, 'Programată');

-- 9. Insert into PARTICIPARE_CURS
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (1, 1);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (2, 1);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (3, 1);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (4, 1);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (5, 1);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (1, 2);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (2, 2);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (1, 3);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (3, 3);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (4, 4);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (4, 5);
INSERT INTO PARTICIPARE_CURS (curs_id, elev_id) VALUES (5, 5);

-- 10. Insert into EXAMEN
INSERT INTO EXAMEN (examen_id, elev_id, examinator_id, tip, data_examen, punctaj, rezultat, incercare)
VALUES (examen_seq.NEXTVAL, 1, 1, 'Sală', TO_DATE('2024-04-10', 'YYYY-MM-DD'), 24, 'Admis', 1);

INSERT INTO EXAMEN (examen_id, elev_id, examinator_id, tip, data_examen, punctaj, rezultat, incercare)
VALUES (examen_seq.NEXTVAL, 3, 2, 'Sală', TO_DATE('2024-04-12', 'YYYY-MM-DD'), 26, 'Admis', 1);

INSERT INTO EXAMEN (examen_id, elev_id, examinator_id, tip, data_examen, punctaj, rezultat, incercare)
VALUES (examen_seq.NEXTVAL, 5, 3, 'Sală', TO_DATE('2024-04-14', 'YYYY-MM-DD'), 21, 'Respins', 1);

INSERT INTO EXAMEN (examen_id, elev_id, examinator_id, tip, data_examen, punctaj, rezultat, incercare)
VALUES (examen_seq.NEXTVAL, 1, 4, 'Traseu', TO_DATE('2024-05-20', 'YYYY-MM-DD'), NULL, 'Admis', 1);

INSERT INTO EXAMEN (examen_id, elev_id, examinator_id, tip, data_examen, punctaj, rezultat, incercare)
VALUES (examen_seq.NEXTVAL, 3, 5, 'Traseu', TO_DATE('2024-05-22', 'YYYY-MM-DD'), NULL, 'Respins', 1);

-- 11. Insert into LICENTA_INSTRUCTOR
INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (1, 'B', TO_DATE('2010-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (1, 'A', TO_DATE('2012-05-10', 'YYYY-MM-DD'), TO_DATE('2032-05-10', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (2, 'B', TO_DATE('2008-03-15', 'YYYY-MM-DD'), TO_DATE('2028-03-15', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (2, 'C', TO_DATE('2015-11-20', 'YYYY-MM-DD'), TO_DATE('2025-11-20', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (3, 'A', TO_DATE('2018-06-01', 'YYYY-MM-DD'), TO_DATE('2028-06-01', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (3, 'B', TO_DATE('2018-06-01', 'YYYY-MM-DD'), TO_DATE('2028-06-01', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (4, 'B', TO_DATE('2005-09-30', 'YYYY-MM-DD'), TO_DATE('2025-09-30', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (4, 'C', TO_DATE('2010-04-12', 'YYYY-MM-DD'), TO_DATE('2030-04-12', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (4, 'D', TO_DATE('2012-01-01', 'YYYY-MM-DD'), TO_DATE('2032-01-01', 'YYYY-MM-DD'));

INSERT INTO LICENTA_INSTRUCTOR (instructor_id, categorie, data_obtinere, valabila_pana)
VALUES (5, 'B', TO_DATE('2020-02-02', 'YYYY-MM-DD'), TO_DATE('2030-02-02', 'YYYY-MM-DD'));

-- 12. Insert into REVIZIE_VEHICUL
INSERT INTO REVIZIE_VEHICUL (revizie_id, vehicul_id, data_revizie, rezultat)
VALUES (revizie_seq.NEXTVAL, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'Admis');

INSERT INTO REVIZIE_VEHICUL (revizie_id, vehicul_id, data_revizie, rezultat)
VALUES (revizie_seq.NEXTVAL, 2, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Admis');

INSERT INTO REVIZIE_VEHICUL (revizie_id, vehicul_id, data_revizie, rezultat)
VALUES (revizie_seq.NEXTVAL, 3, TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Admis');

INSERT INTO REVIZIE_VEHICUL (revizie_id, vehicul_id, data_revizie, rezultat)
VALUES (revizie_seq.NEXTVAL, 4, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Admis');

INSERT INTO REVIZIE_VEHICUL (revizie_id, vehicul_id, data_revizie, rezultat)
VALUES (revizie_seq.NEXTVAL, 5, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Admis');

COMMIT;
