use torneo_futbol;


/*------------------------------------1) VISTAS TORNEO FUTBOL-----------------------------------------------*/

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


/*..... TABLA DE POSICIONES.......*/
CREATE VIEW TABLA_POSICIONES AS
SELECT e.nombre, p.puntaje, p.partidos_ganados, p.partidos_perdidos, p.partidos_jugados, p.empatados
FROM equipos E
INNER JOIN posiciones p
ON e.id_equipo = p.id_equipo
ORDER BY p.puntaje DESC;

/*-------------------------------2) FUNCIONES PARA UN TORNEO DE FUBTOL ------------------------------*/



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





/*-------------------------------------3) STORED PROCEDURE-------------------------------------*/

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
	

/*------------------------------------TRIGGERS Y TABLAS DE AUDITORIA----------------------------------*/


/*ACTUALIZAMOS LA TABLA POSICIONES A MEDIDA QUE AGREGAN LOS PARTIDOS JUGADOS
LA MISMA PERMITE OBSERVAR EL STATUS DE CADA EQUIPO EN EL TORNEO*/

CREATE TABLE cambios_jugador (
	national_id INT,
    create_user VARCHAR(25),
    modify_user VARCHAR(25),
    create_date DATE,
	update_date DATE,
    update_type VARCHAR(20)
);


DELIMITER $$
CREATE TRIGGER `NUEVO_JUGADOR`
	AFTER INSERT ON jugadores
FOR EACH ROW
BEGIN
	INSERT INTO cambios_jugador (national_id, create_user, modify_user, create_date, update_date, update_type)
    VALUES (NEW.national_id, USER(), USER(), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP(), 'INSERT');
END 
$$

INSERT INTO jugadores (national_id, nombre, fecha_nacimiento, posicion, ciudad_id, estatura, peso)
VALUES (44444444, 'ENRIQUE RECHE', '1999-08-30', 'PROGRAMADOR', 3, 1.85, 75.00)
;

/*ACTUALIZAMOS LA TABLA DE POSICIONES SUMANDO PUNTOS DEPENDIENDO DE LOS RESULTADOS DE LOS PARTIDOS*/
DELIMITER $$
CREATE TRIGGER `ACTUALIZA_TABLA_POSICIONES`
	AFTER INSERT ON partidos
    FOR EACH ROW
BEGIN
	IF NEW.goles_local > NEW.goles_visitante THEN
		UPDATE posiciones
        SET puntaje = puntaje + 3
        WHERE id_equipo = NEW.equipo_local;
        
        UPDATE posiciones
        SET partidos_jugados = partidos_jugados + 1
        WHERE id_equipo = NEW.equipo_local;
        
        
        UPDATE posiciones
        SET partidos_jugados = partidos_jugados + 1
        WHERE id_equipo = NEW.equipo_visitante;
        
        UPDATE posiciones
        SET partidos_perdidos = partidos_perdidos + 1
        WHERE id_equipo = NEW.equipo_visitante;
        
        UPDATE posiciones
        SET partidos_ganados = partidos_ganados +1
        WHERE id_equipo = NEW.equipo_local;
        
	ELSEIF NEW.goles_visitante > NEW.goles_local THEN
    
		UPDATE posiciones
        SET partidos_ganados = partidos_ganados +1
        WHERE id_equipo = NEW.equipo_visitante;
        
		UPDATE posiciones
        SET puntaje = puntaje + 3
        WHERE id_equipo = NEW.equipo_visitante;
        
        UPDATE posiciones
        SET partidos_jugados = partidos_jugados + 1
        WHERE id_equipo = NEW.equipo_local;
        
        UPDATE posiciones
        SET partidos_jugados = partidos_jugados + 1
        WHERE id_equipo = NEW.equipo_visitante;
		
        UPDATE posiciones
        SET partidos_perdidos = partidos_perdidos + 1
        WHERE id_equipo = NEW.equipo_local;
        
	ELSE
		UPDATE posiciones
        SET partidos_jugados = partidos_jugados + 1
        WHERE id_equipo = NEW.equipo_local;
        
        
        UPDATE posiciones
        SET partidos_jugados = partidos_jugados + 1
        WHERE id_equipo = NEW.equipo_visitante;
        
        UPDATE posiciones
        SET empatados = empatados + 1
        WHERE id_equipo = NEW.equipo_visitante;
		
        UPDATE posiciones
        SET empatados = empatados + 1
        WHERE id_equipo = NEW.equipo_local;
	END IF;
END;
$$


            