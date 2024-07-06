SHOW DATABASES;

CREATE DATABASE MySQL2_Dia4;
USE MySQL2_Dia4;

-- creacion de usuario camper con acceso desde cualquier parte
CREATE USER 'camper'@'%' IDENTIFIED BY 'campus2023';

-- Revisar permiso de usuario
SHOW GRANTS FOR 'camper'@'%';

-- crear una tabla persona
CREATE TABLE persona (id INT PRIMARY KEY, nombre VARCHAR(255), apellido VARCHAR(255));
INSERT INTO persona (id, nombre, apellido) VALUES (1, 'Juan', 'Pérez');
INSERT INTO persona (id, nombre, apellido) VALUES (2, 'María', 'Gómez');
INSERT INTO persona (id, nombre, apellido) VALUES (3, 'Carlos', 'Rodríguez');
INSERT INTO persona (id, nombre, apellido) VALUES (4, 'Ana', 'Fernández');
INSERT INTO persona (id, nombre, apellido) VALUES (5, 'Luis', 'Martínez');
INSERT INTO persona (id, nombre, apellido) VALUES (6, 'Elena', 'Sánchez');
INSERT INTO persona (id, nombre, apellido) VALUES (7, 'José', 'López');
INSERT INTO persona (id, nombre, apellido) VALUES (8, 'Laura', 'García');
INSERT INTO persona (id, nombre, apellido) VALUES (9, 'Ricardo', 'Ramírez');
INSERT INTO persona (id, nombre, apellido) VALUES (10, 'Marta', 'Torres');

-- Asignar permisos a x usuario para que acceda a la tabla persona de y 
-- base de datos
GRANT SELECT ON MySQL2_Dia4.persona TO 'camper'@'%';

-- refrescar permisos
FLUSH PRIVILEGES;

-- añadir permisos para hacer CRUD
GRANT UPDATE, INSERT, DELETE ON MySQL2_Dia4.persona TO 'camper'@'%';
-- crea otra tabla 
CREATE TABLE persona2 (id INT PRIMARY KEY, nombre VARCHAR(255), apellido VARCHAR(255));
INSERT INTO persona2 (id, nombre, apellido) VALUES (1, 'Juan', 'Pérez');
INSERT INTO persona2 (id, nombre, apellido) VALUES (2, 'María', 'Gómez');
INSERT INTO persona2 (id, nombre, apellido) VALUES (3, 'Carlos', 'Rodríguez');
INSERT INTO persona2 (id, nombre, apellido) VALUES (4, 'Ana', 'Fernández');
INSERT INTO persona2 (id, nombre, apellido) VALUES (5, 'Luis', 'Martínez');
INSERT INTO persona2 (id, nombre, apellido) VALUES (6, 'Elena', 'Sánchez');
INSERT INTO persona2 (id, nombre, apellido) VALUES (7, 'José', 'López');
INSERT INTO persona2 (id, nombre, apellido) VALUES (8, 'Laura', 'García');
INSERT INTO persona2 (id, nombre, apellido) VALUES (9, 'Ricardo', 'Ramírez');
INSERT INTO persona2 (id, nombre, apellido) VALUES (10, 'Marta', 'Torres');

-- PELIGROSO : CREAR UN USUARIO CON PERMISOS A TODO DESDE CUALQUIER LADO CON MALA CONTRASEÑA
CREATE USER 'todito'@'%' IDENTIFIED BY 'todito';
GRANT ALL ON *.* TO 'todito'@'%';
SHOW GRANTS FOR 'todito'@'%';

-- Denegar todos los permisos 
REVOKE ALL ON *.* FROM 'todito';

-- Crear un usuario con acceso único desde una ip establecida
CREATE USER 'deivid'@'172.16.102.30' IDENTIFIED BY 'deivid123';
GRANT SELECT , UPDATE, INSERT, DELETE ON MySQL2_Dia4.persona TO 'deivid'@'172.16.102.30';
REVOKE ALL ON *.* FROM 'deivid'@'172.16.102.30';

-- Crear un usuario con acceso desde cualquier parte 
CREATE USER 'deivid'@'%' IDENTIFIED BY 'deivid123';
GRANT SELECT ON MySQL2_Dia4.* TO 'deivid'@'%';

-- Crear un límite para que solamente se hagan x consultas por hora
ALTER USER 'camper'@'%' WITH MAX_QUERIES_PER_HOUR 5;
FLUSH PRIVILEGES;

-- Revisar los límites o permisos que tiene un usuario a nivel de motor
SELECT * FROM mysql.user WHERE HOST = '%';

-- Eliminar usuarios
DROP USER 'deivid'@'%';
DROP USER 'deivid'@'172.16.102.30';
DROP USER 'todito'@'%';

-- Revocar todos los permisos de camper
REVOKE ALL ON *.* FROM 'camper'@'%';

-- Solo poner permisos para que consulte una x base de datos, una y una z columna
GRANT SELECT (nombre) ON MySQL2_Dia4.persona TO 'camper'@'%';

-- Desarrollado por Hernan Mendez / 1101685607