use torneo_futbol;

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
        WHERE id_equipo = NEW.equipo_local;
        
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
