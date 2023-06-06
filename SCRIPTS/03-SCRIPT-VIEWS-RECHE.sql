use torneo_futbol;

/*---------------------------------------VISTAS TORNEO FUTBOL-----------------------------------------------*/
#TOP 5 PARTIDOS CON MAS AMONESTACIONES
CREATE VIEW partidos_rusticos AS
SELECT 
	PARTIDO,
    count(*) as TOTAL
FROM tarjetas
GROUP BY partido
ORDER BY TOTAL DESC
LIMIT 5;

#JUGADORES CON MAYOR UMERO DE TARJETAS
CREATE VIEW top_rusticos AS
SELECT 
	j.nombre,
    count(DISTINCT partido) as total
FROM jugadores j
LEFT JOIN tarjetas t
ON j.national_id = t.national_id
GROUP BY j.nombre
ORDER BY total DESC
limit 5;




#TOP GOLEADORES DEL TORNEO
CREATE VIEW TOP_GOLEADORES AS
SELECT 
	j.nombre, 
    count(g.id_jugador) as cantidad,
    COUNT(DISTINCT g.id_partido) as partidos_jugados,
    COUNT(g.id_jugador) / COUNT(DISTINCT g.id_partido) AS promedio
FROM jugadores j
RIGHT JOIN goles g
ON j.national_id = g.id_jugador
GROUP BY j.nombre
ORDER BY cantidad DESC
LIMIT 10;



