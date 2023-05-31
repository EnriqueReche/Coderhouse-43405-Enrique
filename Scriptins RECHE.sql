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



#INSERT INTO posiciones (id_equipo, partidos_jugados, partidos_ganados, partidos_perdidos, empatados, puntaje)
#VALUE	
