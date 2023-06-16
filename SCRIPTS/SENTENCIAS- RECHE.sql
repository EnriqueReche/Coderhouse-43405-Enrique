
use torneo_futbol;
/*..........CREAMOS EL PRIMER USUARIO QUE SOLO POSEE PERMISOS DE LECTURA............*/
create user 'enriquereche' @ 'localhost'
IDENTIFIED BY 'enriquereche';	

GRANT SELECT ON torne_futbol.* TO 'enriquereche' @ 'localhost';
FLUSH PRIVILEGES;

/*.........CREAMOS EL SEGUNDO USUARIO QUE POSEE PERMISOS DE LECTURA, INSERCION Y MODIFICACIÓN DE DATOS...........*/

CREATE USER 'josereche' @ 'localhost'
IDENTIFIED BY 'josereche';

GRANT SELECT, INSERT, UPDATE ON  torneo_futbol.* TO 'josereche' @ 'localhost';
FLUSH PRIVILEGES;
