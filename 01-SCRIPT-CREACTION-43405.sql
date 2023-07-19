create schema torneo_futbol;
use torneo_futbol;

#tabla padre "Torneo"
create table torneo (
	id_torneo INT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    division VARCHAR(25),
    sistema VARCHAR(30),
    PRIMARY KEY (id_torneo)
);

CREATE TABLE ciudad (
	id_ciudad INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    provincia VARCHAR(30) NOT NULL,
    pais VARCHAR(30) NOT NULL,
    region VARCHAR(30),
    PRIMARY KEY(id_ciudad)
);

CREATE TABLE asistentes (
	national_id INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY(national_id)
);

CREATE TABLE arbitros (
	national_id INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY(national_id)
);

CREATE TABLE directores_tecnicos (
	national_id INT NOT NULL,
    nombre VARCHAR(35) NOT NULL UNIQUE,
    ciudad_id INT,
    fecha_nacimiento DATE,
    PRIMARY KEY(national_id),
	FOREIGN KEY(ciudad_id) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE estadios (
	id_estadio INT NOT NULL UNIQUE,
    nombre VARCHAR(35) 	NOT NULL,
    ciudad_id INT NOT NULL,
    capacidad INT,
	PRIMARY KEY(id_estadio),
	FOREIGN KEY(ciudad_id) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE equipos (
	id_equipo INT NOT NULL,
    nombre VARCHAR(35) NOT NULL UNIQUE,
    ciudad INT,
    cantidad_jugadores INT,
    director_tecnico INT NOT NULL,
    estadio INT,
    PRIMARY KEY(id_equipo),
    FOREIGN KEY(ciudad) REFERENCES ciudad(id_ciudad),
    FOREIGN KEY(director_tecnico) REFERENCES directores_tecnicos(national_id),
    FOREIGN KEY(estadio) REFERENCES estadios(id_estadio)
);

CREATE TABLE jugadores (
	national_id INT NOT NULL UNIQUE,
    nombre VARCHAR(35) NOT NULL,
    fecha_nacimiento DATE,
    id_equipo INT,
    posicion VARCHAR(25),
    ciudad_id INT,
	estatura DECIMAL(4,2),
    peso DECIMAL(4,2),
    PRIMARY KEY(national_id),
    FOREIGN KEY(id_equipo) REFERENCES equipos(id_equipo),
    FOREIGN KEY(ciudad_id) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE partidos (
	id_partido INT NOT NULL AUTO_INCREMENT,
    id_estadio INT NOT NULL,
    fecha DATE,
	goles_local INT NOT NULL,
    goles_visitante INT NOT NULL,
    instancia VARCHAR(25),
    equipo_local INT,
    equipo_visitante INT,
    cuerpo_directivo INT NOT NULL,
    torneo INT NOT NULL,
    PRIMARY KEY(id_partido),
    FOREIGN KEY(torneo) REFERENCES torneo(id_torneo),
    FOREIGN KEY(id_estadio) REFERENCES estadios(id_estadio),
    FOREIGN KEY(equipo_local) REFERENCES equipos(id_equipo),
    FOREIGN KEY(equipo_visitante) REFERENCES equipos(id_equipo)
);

CREATE TABLE tarjetas (
	tarjeta_id INT NOT NULL AUTO_INCREMENT,
    national_id INT NOT NULL,
    tipo_tarjeta VARCHAR(35) NOT NULL,
    partido INT NOT NULL,
    PRIMARY KEY(tarjeta_id),
    FOREIGN KEY(national_id) REFERENCES jugadores(national_id)
);

CREATE TABLE tarjetas_dt (
	tarjeta_id INT NOT NULL AUTO_INCREMENT,
    national_id INT NOT NULL,
    tipo_tarjeta VARCHAR(35) NOT NULL,
    partido INT NOT NULL,
    PRIMARY KEY(tarjeta_id),
    FOREIGN KEY(national_id) REFERENCES directores_tecnicos(national_id)
);

CREATE TABLE cuerpo_arbitros (
	id_cuerpo INT NOT NULL UNIQUE,
    arbitro INT NOT NULL,
    asistente_uno INT NOT NULL,
    asistente_dos INT NOT NULL,
    PRIMARY KEY(id_cuerpo),
    FOREIGN KEY(arbitro) REFERENCES arbitros(national_id),
    FOREIGn KEY(asistente_uno) REFERENCES asistentes(national_id),
    FOREIGN KEY(asistente_dos) REFERENCES asistentes(national_id)
);

CREATE TABLE posiciones(
	id_equipo INT NOT NULL,
    partidos_jugados INT,
    partidos_ganados INT NOT NULL,
    partidos_perdidos INT NOT NULL,
    empatados INT NOT NULL,
    puntaje INT NOT NULL,
	PRIMARY KEY(id_equipo),
    FOREIGN KEY(id_equipo) REFERENCES equipos(id_equipo)
); 

CREATE TABLE goles(
	id_gol INT NOT NULL,
	id_jugador INT NOT NULL,
    id_partido INT NOT NULL,
    minuto DECIMAL(5,2),
    tipo_gol VARCHAR(30),
    PRIMARY KEY(id_gol),
    FOREIGN KEY(id_jugador) REFERENCES jugadores(national_id),
    FOREIGN KEY(id_partido) REFERENCES partidos(id_partido)
);

CREATE TABLE cambios_jugador (
    id INT AUTO_INCREMENT,
    national_id INT,
    create_user VARCHAR(25),
    modify_user VARCHAR(25),
    create_date DATE,
    update_date DATE,
    update_type VARCHAR(20),
    PRIMARY KEY (id)
);

/*--------------------------------------
INSERCIONES DE DATOS BÁSICOS PARA EL FUNCIONAMIENTO DE LA BASE
---------------------------------------*/

use torneo_futbol;

#INSERTAMOS PRIMER Y UNICO VALOR EN LA TABLA TORNEO
INSERT INTO torneo (id_torneo, nombre, division, sistema)
VALUE (1,'Defensores del Paraná', 'Liga Regional Chaqueña', 'LIGA'); 
        
#INSERTAMOS UNA MUESTRA DE DATOS DE LOS ASISTENTES
INSERT INTO asistentes (national_id, nombre, fecha_nacimiento)
VALUE 	(32930976,	'Colby Sheppard',	'1995-05-18'),
		(37516554,	'Ariana Walter',	'1989-04-04'),
		(40192985,	'Logan Mooney',	'1994-07-06'),
		(31957324,	'Quintessa Hurst',	'1997-02-14'),
		(31848210,	'Hall Moreno',	'1986-10-04'),
		(30676077,	'Vladimir Brooks',	'2000-06-19'),
		(26734847,	'Laith Walter',	'1984-11-21'),
		(34433402,	'Jeremy Bauer',	'1993-07-26'),
		(36969775,	'Neil Dorsey',	'2000-05-02'),
		(39257206,	'Halee Neal',	'2000-08-19'),
        (35831567,	'Jordan Pena',	'1988-05-08'),
		(41920292,	'April Cruz',	'2002-10-13'),
		(28796770,	'Iola Rush',	'1998-05-13'),
		(31504515,	'Branden Webster',	'1988-06-02'),
		(31293939,	'Tiger Robertson',	'1993-12-11'),
		(25177134,	'Hannah Nichols',	'2002-10-29'),
		(29193352,	'Denton Holcomb',	'1989-04-29'),
		(30566576,	'Maya Cantu',	'1993-10-26'),
		(36340982,	'Stephanie Travis',	'1986-01-07'),
		(36954215,	'Ulric Fitzgerald',	'1989-08-25'),
		(30098405,	'Larissa Montoya',	'1997-10-17'),
		(30126929,	'Fallon Bates',	'1985-09-04'),
		(35278833,	'Shana Jefferson',	'2003-09-07'),
		(35316431,	'Shelly Garrett',	'1985-08-14');

INSERT INTO arbitros(national_id, nombre, fecha_nacimiento)
VALUE	(23621644,	'Moana Erickson', '1988-03-29'),
		(24504420,	'Jemima Olsen',	'2003-01-31'),
		(30606064,	'David Brewer',	'2003-12-16'),
		(29126628,	'Simone Romero',	'1995-04-09'),
		(32674303,	'Charity Ellis',	'1991-08-16'),
		(23237675,	'Althea Taylor',	'1986-02-05'),
		(27727807,	'Imogene Rowe',	'1986-09-13'),
		(24800142,	'Tarik Russo',	'2002-09-12'),
		(30803585,	'Kibo Erickson',	'1987-09-27'),
		(31883018,	'Cade Rodgers',	'2003-01-21'),
        (33491020,	'Axel Sawyer',	'1989-05-31'),
        (38907553,	'Kevyn Trujillo',	'2003-12-26');

INSERT INTO cuerpo_arbitros (id_cuerpo, arbitro, asistente_uno, asistente_dos)
VALUES (1, 23621644, 32930976, 30676077),
       (2, 24504420, 37516554, 26734847),
       (3, 30606064, 40192985, 34433402),
       (4, 29126628, 31957324, 36969775),
       (5, 32674303, 31848210, 39257206),
       (6, 23237675, 30676077, 26734847),
       (7, 27727807, 34433402, 36969775),
       (8, 24800142, 36969775, 35831567),
       (9, 30803585, 41920292, 28796770),
       (10, 31883018, 31504515, 31504515),
       (11, 33491020, 25177134, 25177134),
       (12, 38907553, 30566576, 30098405);
       
#mini testeo
#SELECT ca.arbitro, a.nombre
#fROM cuerpo_arbitros ca
#INNER JOIN arbitros a
#ON ca.arbitro = a.national_id;

/*--------------------------------------------------------------------------------------*/
/*                              FUNCIONES-STORED-PROCEDURE-VISTAS                       */
/*------------------------------------1) VISTAS TORNEO FUTBOL---------------------------*/

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
/*ACTUALIZAMOS LA TABLA POSICIONES A MEDIDA QUE AGREGAN LOS PARTIDOS JUGADOS
LA MISMA PERMITE OBSERVAR EL STATUS DE CADA EQUIPO EN EL TORNEO*/
CREATE VIEW TABLA_POSICIONES AS
SELECT e.nombre, p.puntaje, p.partidos_ganados, p.partidos_perdidos, p.partidos_jugados, p.empatados
FROM equipos E
INNER JOIN posiciones p
ON e.id_equipo = p.id_equipo
ORDER BY p.puntaje DESC;


/*..........PROPENSOS AL DESCENSO..........*/

CREATE VIEW PROPENSOS_A_DESCENDER AS
SELECT e.nombre as equipo, p.puntaje, p.partidos_ganados, p.partidos_perdidos,
p.partidos_jugados, p.empatados
FROM equipos e
INNER JOIN posiciones p
ON e.id_equipo = p.id_equipo
ORDER BY p.puntaje ASC,p.partidos_perdidos DESC
LIMIT 5;

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

/*ESTE PROCEDIMIENTO ALMACENADO REALIZA UNA CONSULTA Y ORDENA LOS VALORES QUE NOS RETORNA
TOMA DOS PARAMETROS, UNO INDICANDO LA COLUMNA POR QUE ORDENAR, EL OTRO EL METODO DE ORDENACION*/
	
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

/*TABLA QUE SIRBE DE AUDITORIA AL INGRESAR UN NUEVO JUGADOR A CADA EQUIPO*/
DELIMITER $$
CREATE TRIGGER `NUEVO_JUGADOR`
    AFTER INSERT ON jugadores
FOR EACH ROW
BEGIN
    INSERT INTO cambios_jugador (national_id, create_user, modify_user, create_date, update_date, update_type)
    VALUES (NEW.national_id, USER(), USER(), CURRENT_DATE, CURRENT_DATE, 'INSERT');
END$$
DELIMITER;


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


            





