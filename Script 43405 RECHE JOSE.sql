create schema torneo_futbol;
use torneo_futbol;

#tabla padre "Torneo"
create table torneo (
	id_torneo INT(4) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    division VARCHAR(25),
    sistema VARCHAR(30),
    PRIMARY KEY (id_torneo)
);

CREATE TABLE ciudad (
	id_ciudad INT(4) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    provincia VARCHAR(30) NOT NULL,
    pais VARCHAR(30) NOT NULL,
    region VARCHAR(30),
    PRIMARY KEY(id_ciudad)
);

CREATE TABLE asistentes (
	national_id INT(8) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    PRIMARY KEY(national_id)
);

CREATE TABLE arbitros (
	national_id INT(8) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    fecha_nacimineto DATE NOT NULL,
    PRIMARY KEY(national_id)
);

CREATE TABLE equipos (
	id_equipo INT(4) NOT NULL,
    nombre VARCHAR(35) NOT NULL UNIQUE,
    ciudad INT(4),
    cantidad_jugadores INT(2),
    director_tecnico VARCHAR(35) NOT NULL,
    estadio INT(3),
    PRIMARY KEY(id_equipo),
    FOREIGN KEY(ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE directores_tecnicos (
	national_id INT(8) NOT NULL,
    nombre VARCHAR(35) NOT NULL UNIQUE,
    id_equipo INT(4),
    ciudad_id INT(4),
    fecha_nacimiento DATE,
    PRIMARY KEY(national_id),
	FOREIGN KEY(ciudad_id) REFERENCES ciudad(id_ciudad)
);

/*agrego la llave foranea luego de crear la tabla por existir mutua relacion, lo que las vuelve ecluyentes*/
ALTER TABLE equipos ADD FOREIGN KEY(director_tecnico) REFERENCES directores_tecnicos(nombre);

CREATE TABLE estadios (
	id_estadio INT(3) NOT NULL UNIQUE,
    nombre VARCHAR(35) NOT NULL,
    equipo_local VARCHAR(35) NOT NULL,
    ciudad_id INT(4) NOT NULL,
    capacidad INT(6),
	PRIMARY KEY(id_estadio),
    FOREIGN KEY(equipo_local) REFERENCES equipos(nombre),
	FOREIGN KEY(ciudad_id) REFERENCES ciudad(id_ciudad)
);

/*Agregamos la llave foranea en la tabla equipos para asociar el estadio donde reside*/
ALTER TABLE equipos ADD FOREIGN KEY(estadio) REFERENCES estadios(id_estadio);

CREATE TABLE jugadores (
	national_id INT(8) NOT NULL UNIQUE,
    nombre VARCHAR(35) NOT NULL,
    fecha_nacimiento DATE,
    id_equipo INT(4),
    condicion VARCHAR(25),
    ciudad_id INT(4),
    peso DECIMAL(3,2),
    estatura DECIMAL(3,2),
    PRIMARY KEY(national_id),
    FOREIGN KEY(id_equipo) REFERENCES equipos(id_equipo),
    FOREIGN KEY(ciudad_id) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE partidos (
	id_partido INT(3) NOT NULL AUTO_INCREMENT,
    id_estadio INT(3) NOT NULL,
    fecha DATE,
	goles_local INT(3) NOT NULL,
    goles_visitante INT(3) NOT NULL,
    instancia VARCHAR(30),
    equipo_local VARCHAR(35),
    equipo_visitante VARCHAR(35),
    cuerpo_directivo INT(4) NOT NULL,
    PRIMARY KEY(id_partido),
    FOREIGN KEY(id_estadio) REFERENCES estadios(id_estadio),
    FOREIGN KEY(equipo_local) REFERENCES equipos(nombre),
    FOREIGN KEY(equipo_visitante) REFERENCES equipos(nombre)
);

CREATE TABLE tarjetas (
	id INT(5) NOT NULL AUTO_INCREMENT,
    national_id INT(8) NOT NULL,
    tipo_tarjeta VARCHAR(35) NOT NULL,
    id_partido INT(4) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(national_id) REFERENCES jugadores(national_id),
    FOREIGN KEY(national_id) REFERENCES directores_tecnicos(national_id)
);

CREATE TABLE cuerpo_arbitros (
	id_cuerpo INT(4) NOT NULL UNIQUE,
    arbitro INT(8) NOT NULL,
    asistente_uno INT(8) NOT NULL,
    asistente_dos INT(8) NOT NULL,
    PRIMARY KEY(id_cuerpo),
    FOREIGN KEY(arbitro) REFERENCES arbitros(national_id),
    FOREIGn KEY(asistente_uno) REFERENCES asistentes(national_id),
    FOREIGN KEY(asistente_dos) REFERENCES asistentes(national_id)
);

CREATE TABLE posiciones(
	id_equipo INT(3) NOT NULL,
    partidos_ganados INT(3) NOT NULL,
    partidos_perdidos INT(3)NOT NULL,
    empatados INT(3) NOT NULL,
    puntaje INT(3) NOT NULL,
	PRIMARY KEY(id_equipo),
    FOREIGN KEY(id_equipo) REFERENCES equipos(id_equipo)
);

