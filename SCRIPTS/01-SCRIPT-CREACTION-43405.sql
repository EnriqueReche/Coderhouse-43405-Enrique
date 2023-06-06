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
    nombre VARCHAR(35) NOT NULL,
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
    instancia VARCHAR(30),
    equipo_local VARCHAR(35),
    equipo_visitante VARCHAR(35),
    cuerpo_directivo INT NOT NULL,
    torneo INT NOT NULL,
    PRIMARY KEY(id_partido),
    FOREIGN KEY(torneo) REFERENCES torneo(id_torneo),
    FOREIGN KEY(id_estadio) REFERENCES estadios(id_estadio),
    FOREIGN KEY(equipo_local) REFERENCES equipos(nombre),
    FOREIGN KEY(equipo_visitante) REFERENCES equipos(nombre)
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
	id_jugador INT NOT NULL,
    id_partido INT NOT NULL,
    minuto DECIMAL(5,2),
    tipo_gol VARCHAR(30),
    PRIMARY KEY(id_jugador),
    FOREIGN KEY(id_jugador) REFERENCES jugadores(national_id),
    FOREIGN KEY(id_partido) REFERENCES partidos(id_partido)
);