
-- 1. Complex Queries


-- Instructors with students who passed the theory exam
SELECT i.nume, i.prenume, i.salariu
FROM INSTRUCTOR i
WHERE EXISTS (
    SELECT 1
    FROM SEDINTA_PRACTICA sp
    JOIN EXAMEN ex ON sp.elev_id = ex.elev_id
    WHERE sp.instructor_id = i.instructor_id
      AND ex.tip = 'Sală'
      AND ex.rezultat = 'Admis'
);

-- Fleet usage summary: total sessions and km per vehicle (including unused vehicles)
SELECT v.marca, v.model, v.nr_inmatriculare,
       NVL(sed.nr_sedinte, 0) AS numar_sedinte,
       NVL(sed.total_km, 0) AS total_km
FROM VEHICUL v
LEFT JOIN (
    SELECT vehicul_id, COUNT(sedinta_id) AS nr_sedinte, SUM(km_parcursi) AS total_km
    FROM SEDINTA_PRACTICA
    GROUP BY vehicul_id
) sed ON v.vehicul_id = sed.vehicul_id
ORDER BY total_km DESC;

-- Categories where average tuition exceeds the overall average
SELECT d.categorie_permis, SUM(p.suma) AS total_incasat, AVG(d.taxa_totala) AS medie_taxa
FROM DOSAR_INSCRIERE d
JOIN PLATA p ON d.dosar_id = p.dosar_id
GROUP BY d.categorie_permis
HAVING AVG(d.taxa_totala) > (
    SELECT AVG(taxa_totala) FROM DOSAR_INSCRIERE
)
ORDER BY total_incasat DESC;

-- Student file status and action recommendation using NVL and DECODE
SELECT e.nume || ' ' || e.prenume AS nume_elev,
       NVL(d.aviz_psihologic, 'Lipsă Aviz') AS status_psihologic,
       NVL(d.fisa_medicala, 'Lipsă Fișă') AS status_medical,
       DECODE(d.status_dosar,
              'Gata', 'Poate fi programat la examen',
              'Incomplet', 'Necesită documente/plată',
              'În verificare') AS recomandare_actiune
FROM ELEV e
JOIN DOSAR_INSCRIERE d ON e.elev_id = d.elev_id
ORDER BY e.nume ASC;

-- Instructor seniority and salary categorization using CTE and CASE
WITH Detalii_Instructori AS (
    SELECT nume, prenume, data_angajare, salariu
    FROM INSTRUCTOR
)
SELECT UPPER(nume) || ' ' || SUBSTR(prenume, 1, 3) || '.' AS nume_formatat,
       TO_CHAR(data_angajare, 'DD Month YYYY') AS data_angajare_text,
       ROUND(MONTHS_BETWEEN(SYSDATE, data_angajare)) AS luni_vechime,
       CASE
           WHEN salariu >= 4800 THEN 'Nivel Senior'
           WHEN salariu BETWEEN 4500 AND 4799 THEN 'Nivel Mediu'
           ELSE 'Nivel Junior'
       END AS categorie_salarizare
FROM Detalii_Instructori
ORDER BY luni_vechime DESC;




-- 2. Advanced Operations


-- 4-table outer join (ELEV, SEDINTA_PRACTICA, INSTRUCTOR, VEHICUL)
SELECT e.nume AS nume_elev,
       e.prenume AS prenume_elev,
       sp.data_sedinta,
       i.nume AS nume_instructor,
       v.marca
FROM ELEV e
LEFT OUTER JOIN SEDINTA_PRACTICA sp ON e.elev_id = sp.elev_id
LEFT OUTER JOIN INSTRUCTOR i ON sp.instructor_id = i.instructor_id
LEFT OUTER JOIN VEHICUL v ON sp.vehicul_id = v.vehicul_id
ORDER BY e.nume;

-- Relational division: students who attended all theoretical courses
SELECT e.nume, e.prenume
FROM ELEV e
WHERE NOT EXISTS (
    SELECT 1
    FROM CURS_TEORETIC c
    WHERE NOT EXISTS (
        SELECT 1
        FROM PARTICIPARE_CURS pc
        WHERE pc.curs_id = c.curs_id
          AND pc.elev_id = e.elev_id
    )
);

-- Top-3 instructors by salary
SELECT * FROM (
    SELECT nume, prenume, salariu
    FROM INSTRUCTOR
    ORDER BY salariu DESC
)
WHERE ROWNUM <= 3;



-- 3. Views & DML Operations


-- Student file summary view
CREATE OR REPLACE VIEW VW_DETALII_DOSAR_ELEV AS
SELECT e.elev_id, e.nume, e.prenume,
       d.dosar_id, d.status_dosar,
       (d.taxa_totala - d.suma_achitata) AS rest_de_plata
FROM ELEV e
JOIN DOSAR_INSCRIERE d ON e.elev_id = d.elev_id;

-- Update status through view
UPDATE VW_DETALII_DOSAR_ELEV
SET status_dosar = 'Gata'
WHERE dosar_id = 1;

-- Bonus update for instructors with >= 4 practical hours
UPDATE INSTRUCTOR
SET salariu = salariu + 500
WHERE instructor_id IN (
    SELECT instructor_id
    FROM SEDINTA_PRACTICA
    GROUP BY instructor_id
    HAVING SUM(durata_ore) >= 4
);

-- Correlated update: set file to 'Gata' for students paid in full who passed theory
UPDATE DOSAR_INSCRIERE d
SET status_dosar = 'Gata'
WHERE taxa_totala = suma_achitata
  AND EXISTS (
    SELECT 1
    FROM EXAMEN ex
    WHERE ex.elev_id = d.elev_id
      AND ex.tip = 'Sală'
      AND ex.rezultat = 'Admis'
  );

-- Delete scheduled sessions assigned to failed inspection vehicles
DELETE FROM SEDINTA_PRACTICA
WHERE status = 'Programată'
  AND vehicul_id IN (
    SELECT vehicul_id
    FROM REVIZIE_VEHICUL
    WHERE rezultat = 'Respins'
  );



-- 4. Indexing & Query Tuning


-- Indexes for frequent query paths
CREATE INDEX idx_examen_filtru ON EXAMEN(tip, rezultat); 
CREATE INDEX idx_sp_instructor ON SEDINTA_PRACTICA(instructor_id);

-- Optimized execution plan with hints
EXPLAIN PLAN FOR
SELECT /*+ USE_NL(i sp ex) */ i.nume, i.prenume, i.salariu
FROM INSTRUCTOR i
WHERE EXISTS (
    SELECT /*+ INDEX(ex idx_examen_filtru) INDEX(sp idx_sp_instructor) */ 1
    FROM SEDINTA_PRACTICA sp
    JOIN EXAMEN ex ON sp.elev_id = ex.elev_id
    WHERE sp.instructor_id = i.instructor_id
      AND ex.tip = 'Sală'
      AND ex.rezultat = 'Admis'
);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
