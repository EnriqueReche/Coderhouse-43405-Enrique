
#TOP 5 PARTIDOS CON MAS AMONESTACIONES
CREATE VIEW partidos_rusticos AS
SELECT PARTIDO, count(*) as TOTAL
FROM tarjetas
GROUP BY partido
ORDER BY TOTAL DESC
LIMIT 5;

#JUGADORES CON MAYOR UMERO DE TARJETAS
CREATE VIEW top_rusticos AS
SELECT j.nombre, count(t.national_id) as total
FROM jugadores j
INNER JOIN tarjetas t
ON j.national_id = t.national_id
GROUP BY j.nombre
ORDER BY total DESC
LIMIT 10;






