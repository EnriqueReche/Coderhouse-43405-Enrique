use torneo_futbol;


#INSERTAMOS PRIMER Y UNICO VALOR EN LA TABLA TORNEO
INSERT INTO torneo (id_torneo, nombre, division, sistema)
VALUE (1,'Defensores del Paraná', 'Liga Regional Chaqueña', 'LIGA'); 


#INSERTAMOS UNA MUESTRA DE LOCALIDADES DE LA PROVINCIA DE CHACO
INSERT INTO ciudad(id_ciudad, nombre, provincia, pais, region)
VALUE  (1, 'Juan Jose Castelli', 'Chaco', 'Argentina', 'NEA'),
	    (2, 'Miraflores', 'Chaco', 'Argentina', 'NEA'),
		(3, 'P. Roque Saenz Peña', 'Chaco', 'Argentina', 'NEA'),
		(4, 'Resistencia', 'Chaco', 'Argentina', 'NEA'),
        (5, 'Quitilipi', 'Chaco', 'Argentina', 'NEA'),
        (6, 'Fuerte Esperanza', 'Chaco', 'Argentina', 'NEA'),
        (7, 'Las Palmas', 'Chaco', 'Argentina', 'NEA'),
        (8, 'Charata', 'Chaco', 'Argentina', 'NEA'),
        (9, 'Villa Angela', 'Chaco', 'Argentina', 'NEA'),
        (10, 'Las Garcitas', 'Chaco', 'Argentina', 'NEA');
        
        
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
		(39257206,	'Halee Neal',	'2000-08-19');
        
INSERT INTO directores_tecnicos (national_id, nombre, ciudad_id, fecha_nacimiento)
VALUE	(35676568,	'Sonia Hunt',	1,'2002-10-06'),
		(31101737,	'Samantha Haney',	1,'1986-07-01'),
		(28670963,	'Silas Curtis',	2,'1991-03-01'),
		(41473837,	'Erica Gallegos',	3,'2003-04-17'),
		(38113311,	'Yvonne Houston',	3,'1996-05-14'),
		(35462740,	'Lillian Bowers',	5,'1992-06-20'),
		(28644546,	'Hillary Olson',	7,'1996-04-28'),
		(38285677,	'Yuli Tate',	10,'1987-08-01');
	
INSERT INTO arbitros(national_id, nombre, fecha_nacimineto)
VALUE	(23621644,	'Moana Erickson', '1988-03-29'),
		(24504420,	'Jemima Olsen',	'2003-01-31'),
		(30606064,	'David Brewer',	'2003-12-16'),
		(29126628,	'Simone Romero',	'1995-04-09'),
		(32674303,	'Charity Ellis',	'1991-08-16'),
		(23237675,	'Althea Taylor',	'1986-02-05'),
		(27727807,	'Imogene Rowe',	'1986-09-13'),
		(24800142,	'Tarik Russo',	'2002-09-12'),
		(30803585,	'Kibo Erickson',	'1987-09-27'),
		(31883018,	'Cade Rodgers',	'2003-01-21');
        
INSERT INTO estadios(id_estadio, nombre, ciudad_id,capacidad)
VALUE	(1, 'Arenero', 5, 30000),
		(2, 'Olimpic', 6, 23000),
        (3, 'Coliseo', 2, 36000),
        (4, 'El forestal', 3, 10000);
        
#INSERTAMOS OCHO EQUIPOS EQUIPOS
INSERT INTO equipos (id_equipo, nombre, ciudad,cantidad_jugadores, director_tecnico, estadio)
VALUE	(1, 'Club Bancarios', 2, 15,35676568, NULL),
		(2, 'Fútbol Club Barberán', 3, 20, 31101737, 4),
		(3, 'Club Atlético Central Benítez', 5, 18, 28670963, NULL),
		(4, 'Atlético Central Norte', 7, 19, 38285677, 3),
		(5, 'Chaco For Ever', 1, 20, 41473837, 1),
		(6, 'Universidad del Nordeste', 4, 16, 38113311, NULL),
		(7, 'Defensores de Vilelas', 2, 16, 35462740, NULL),
		(8, 'Social y Deportivo Güiraldes', 1, 17, 28644546, NULL);

#INSERTAMOS UNA MUESTRA DE JUGADORES PARA EJEMPLIFICAR
INSERT INTO jugadores(national_id, nombre, fecha_nacimiento, id_equipo, posicion, ciudad_id, estatura, peso)
VALUE	(23521198,	'Fitzgerald Avila',	'2002-06-02',2, 'DELANTERO', 1, 1.87, 79.00),
		(37910822,	'Raven Atkinson',	'1998-06-01',2, 'DELANTERO', 2,1.80,78.00),
		(31345412,	'Daria Daniel',	'1990-04-06',2, 'ARQUERO', 3,1.98, 85.0),
		(35881341,	'Leila Hawkins',	'1984-11-05',2, 'DEFENSOR', 4, 1.89, 80.00),
		(39261322,	'Harding Molina',	'2000-10-08',2, 'DEFENSOR', 5,1.86, 85.00),
		(26253329,	'Liberty West',	'1989-10-31',3, 'ARQUERO', 2, 1.98, 90.00),
		(41720084,	'Sheila Brewer',	'2003-04-10',3, 'DEFENSOR', 8, 1.87, 85.00),
		(39163741,	'Amanda Maddox',	'1986-01-29',3,'DELANTERO', NULL, 1.80, 82.00),
		(24820829,	'Shelley Boyle',	'2002-05-02',3, 'DELANTERO', 6, 1.95, 92.00),
		(33807452,	'Cassidy Spears',	'1994-05-02',3,'ARQUERO', 3, 2.00, 99.00),
		(40236189,	'TaShya Mckay',	'2002-06-30',5, 'DEFENSOR', 2, 1.79, 90.00),
		(33061134,	'Shana Sykes',	'1996-01-08',5, 'DELANTERO', 1, 1.87, 86.00),
		(389140969,	'Piper Dotson',	'1987-07-30',5, 'DEFENSOR', 8,1.90, 90.00),
		(28484029, 'Baxter Marquez',	'1994-04-01',5,'ARQUERO', 5, 1.95, 94.00),
		(29384182,	'Dorian Mooney',	'1995-12-22', 5 , 'ARQUERO', 9, 1.90, 92.00),
		(36089477,	'Brennan Herrera',	'1990-04-19', 6, 'DELANTERO', 6, 1.70, 73.00),
		(28382068,	'Boris Koch',	'1994-05-30', 6, 'DEFENSOR', 2,1.80, 83.00);
        
INSERT INTO cuerpo_arbitros (id_cuerpo, arbitro, asistente_uno, asistente_dos)
VALUES (1, 23621644, 32930976, 30676077),
       (2, 24504420, 37516554, 26734847),
       (3, 30606064, 40192985, 34433402),
       (4, 29126628, 31957324, 36969775),
       (5, 32674303, 31848210, 39257206);

#mini testeo
#SELECT ca.arbitro, a.nombre
#FROM cuerpo_arbitros ca
#INNER JOIN arbitros a
#ON ca.arbitro = a.national_id;

INSERT INTO partidos (id_partido, id_estadio, fecha, goles_local, goles_visitante, instancia, equipo_local, equipo_visitante,cuerpo_directivo, torneo)
VALUE	(1, 4, '2023-02-01' , 1, 0,'FECHA', 'Club Bancarios', 'Defensores de Vilelas',  4, 1), 
		(2, 3, '2023-02-08', 2, 3,'FECHA', 'Atlético Central Norte', 'Social y Deportivo Güiraldes', 2, 1),
        (3, 1, '2023-02-16', 2, 0,'FECHA', 'Club Atlético Central Benítez', 'Chaco For Ever', 3, 1),
        (4, 2, '2023-02-21', 0, 0,'FECHA', 'Universidad del Nordeste', 'Fútbol Club Barberán',  1, 1);

INSERT INTO tarjetas (tarjeta_id, national_id, tipo_tarjeta, partido)
VALUE	(1, 23521198, 'AMARILLA',1),
		(2, 37910822, 'AMARILLA', 1),
		(3, 31345412, 'ROJA',2),
		(4, 35881341, 'AMARILLA',3),
		(5, 39261322, 'ROJA', 3),
        (6, 26253329, 'ROJA',4);
        
INSERT INTO tarjetas_dt (tarjeta_id, national_id, tipo_tarjeta, partido)
VALUE	(1, 35676568, 'AMARILLA',1),
		(2, 31101737, 'AMARILLA', 1),
		(3, 28670963, 'ROJA',2),
		(4, 41473837, 'AMARILLA',3);


INSERT INTO posiciones (id_equipo, partidos_ganados, partidos_perdidos, empatados, puntaje)
VALUE	(1, 1, 0, 0, 3),
		(2, 0, 0, 0, 0),
		(3, 1, 0, 0, 0),
		(4, 0, 1, 0, 0),
		(5, 0, 1, 0, 0),
        (6, 0, 0, 1, 1),
		(7, 0, 1, 0, 0),
		(8, 1, 0, 0, 0);	
        












