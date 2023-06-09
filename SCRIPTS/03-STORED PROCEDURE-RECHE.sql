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


/*---------------------------------FUNCIONES PARA UN TORNEO DE FUBTOL ------------------------------*/



/*ESTA FUNCION SOLICITA EL DNI DE UN JUGADOR EN ESPECIFICO Y RETORNA SU NOMBRE SI OBTUVO UNA ROJA*/
DELIMITER $$
CREATE FUNCTION `RETORNA_JUGADOR_SUSPENDIDO` (DNI INT)
    RETURNS VARCHAR(35)
    READS SQL DATA
BEGIN
    DECLARE NOMBRE VARCHAR(35);
	SET NOMBRE = (SELECT j.nombre
				  FROM jugadores j
                  INNER JOIN tarjetas t
                  ON j.national_id = t.national_id
                  WHERE t.tipo_tarjeta = 'ROJA'
                  AND t.national_id = DNI
                  limit 1);
    RETURN NOMBRE;
END
$$


/*ESTA FUNCION RETORNA EL INDICE DE MASA CORPORAL DE UN JUGADOR ESPECIFICO*/
DELIMITER $$
CREATE FUNCTION `RETORNA_IMC` (DNI int)
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE peso_jugador FLOAT;
    DECLARE estatura_jugador FLOAT;
    DECLARE IMC FLOAT;
    SET peso_jugador = (SELECT peso
						FROM jugadores
						WHERE national_id = DNI);
	SET estatura_jugador = (SELECT estatura
						  FROM jugadores
                          WHERE national_id = DNI);
                          
	SET IMC = peso_jugador / POWER(estatura_jugador, 2);
    RETURN IMC;
END
$$





/*---------------------------------------STORED PROCEDURE-------------------------------------*/

/*ESTE PROCEDIMIENTO ALMACENADO TOMA DOS PARAMETROS, UNO INDICANDO 
LA COLUMNA POR QUE ORDENAR, EL OTRO EL METODO DE ORDENACION*/

DELIMITER $$
CREATE PROCEDURE `odenar_jugadores` (columna VARCHAR(25), order_by VARCHAR(35))
BEGIN

	IF columna <> '' THEN
		SET @order = CONCAT('ORDER BY ', columna);
    ELSE
		SET @order = '';
	END IF;
    
IF order_by <> '' THEN
	SET @order_2 = ' DESC';
ELSE 
	SET @order_2 = order_by;
END IF;

	SET @clausula = CONCAT('SELECT * FROM jugadores ', @order, @order_2);
    PREPARE runSQL FROM @clausula;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
END $$




/*MODIFICAR INFORMACION (UPDATE) DE JUGADORES COMO EQUIPO
PESO, ESTATUTA Y POSICION */

DELIMITER $$
CREATE PROCEDURE `MODIFICAR_INFORMACION_JUGADORES`(IN columna VARCHAR(25), nuevo_registro VARCHAR(25), DNI INT)
BEGIN

	DECLARE sentence VARCHAR(1000);
    
    /*encerrar el parametro nuevo_registro entre comillas fue la unica forma de conseguir que tome tanto enteros como strings*/
	SET sentence = CONCAT('UPDATE jugadores SET ', columna, ' = ''', nuevo_registro, ''' WHERE national_id = ', DNI);
    
    SET @clausula = sentence;
    PREPARE runSQL FROM @clausula;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
END $$
	
            
            