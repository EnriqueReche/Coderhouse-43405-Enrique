use torneo_futbol;


/*---------------------------------FUNCIONES PARA UN TORNEO DE FUBTOL ------------------------------*/

/*ESTA FUNCION SOLICITA EL DNI DE UN JUGADOR EN ESPECIFICO Y RETORNA SU NOMBRE SI OBTUVO UNA ROJA*/
DELIMITER $$
CREATE FUNCTION `jugador_suspendido_una_fecha` (DNI INT)
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
CREATE FUNCTION `indice_masa_corporal` (DNI int)
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

