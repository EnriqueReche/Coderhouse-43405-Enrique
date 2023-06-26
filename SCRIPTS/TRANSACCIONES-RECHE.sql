use torneo_futbol;


/*--------------------------------TRANSACCIONES--------------------------------*/

/*Aqui comprobamos si alguno de los equipos de un partido quedo sin insertar*/
DELIMITER $$;
CREATE PROCEDURE registrar_partido()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK TO registro_partidos;
        SELECT 'Ocurrió un error en el registro de partidos' AS mensaje;
        RESIGNAL;
    END;

    START TRANSACTION;

    SAVEPOINT registro_partidos;

    INSERT INTO partidos (id_partido, id_estadio, fecha, goles_local, goles_visitante, instancia, equipo_local, equipo_visitante, cuerpo_directivo, torneo)
    VALUES (25, 2, '2023-06-19', 1, 3, 'FECHA', 2, NULL, 4, 1);

    IF (SELECT equipo_local FROM partidos WHERE id_partido = 25) IS NULL OR
       (SELECT equipo_visitante FROM partidos WHERE id_partido = 25) IS NULL THEN
        SELECT 'No puedes ingresar un partido donde uno o ambos equipos sean nulos.' AS mensaje;
        ROLLBACK TO registro_partidos;
    ELSE
        COMMIT;
        SELECT 'Todos los valores fueron ingresados correctamente' AS mensaje;
    END IF;
END $$;


CALL registrar_partido();


/*Aqui chequeamos si el la edad de un jugador sobrepasa el limite de edad, que por reglamento es 40 años*/

DELIMITER $$;
CREATE PROCEDURE verificar_edad_jugador()
BEGIN
    DECLARE mensaje VARCHAR(100);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK TO registro_jugador;
        SELECT 'Ocurrió un error en el registro de jugadores' AS mensaje;
    END;

    START TRANSACTION;

    SAVEPOINT registro_jugador;

    INSERT INTO jugadores (national_id, nombre, fecha_nacimiento, id_equipo, posicion, ciudad_id, estatura, peso)
    VALUES (12222222, 'Juan Gomez', '1980-12-01', 3, 'MEDIOCAMPISTA', 4, 1.90, 92);

    IF DATEDIFF('2023-06-06', (SELECT fecha_nacimiento FROM jugadores WHERE national_id = 12222222)) >= 40 THEN
        ROLLBACK TO registro_jugador;
        SET mensaje = 'No puede participar del torneo un jugador mayor a 40 años.';
    ELSE
        SET mensaje = 'Todos los valores de la inserción fueron ingresados correctamente.';
        COMMIT;
    END IF;

    SELECT mensaje;
END $$;


CALL verificar_edad_jugador();




		