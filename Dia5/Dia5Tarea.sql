SHOW DATABASES;

CREATE DATABASE Dia4_Taller;
DROP DATABASE Dia4_Taller;

USE Dia4_Taller;

CREATE TABLE sucursal (
    id_sucursal INT PRIMARY KEY,
    ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono_fijo VARCHAR(20) NULL,
    celular VARCHAR(20) NULL,
    correo_electronico VARCHAR(100) NULL
);

CREATE TABLE empleado (
    id_empleado INT PRIMARY KEY,
    id_sucursal INT NOT NULL,
    cedula VARCHAR(20) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    ciudad_residencia VARCHAR(100) NOT NULL,
    celular VARCHAR(20) NULL,
    correo_electronico VARCHAR(100) NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    ciudad_residencia VARCHAR(100) NOT NULL,
    celular VARCHAR(20) NULL,
    correo_electronico VARCHAR(100) NULL
);

CREATE TABLE vehiculo (
    id_vehiculo INT PRIMARY KEY,
    tipo_vehiculo VARCHAR(200) NOT NULL,
    placa VARCHAR(20) NOT NULL,
    referencia VARCHAR(100) NOT NULL,
    modelo VARCHAR(200) NOT NULL,
    puertas INT NOT NULL,
    estado VARCHAR(100),
    capacidad INT NOT NULL,
    sunroof BOOLEAN NOT NULL,
    motor VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL
);

CREATE TABLE alquiler (
    id_alquiler INT PRIMARY KEY,
    fecha_salida DATE NOT NULL,
    fecha_llegada DATE NOT NULL,
    fecha_esperada_llegada DATE NOT NULL,
    valor_semana INT NOT NULL,
    valor_dia INT NOT NULL,
    porcentaje_descuento INT NULL,
    valor_cotizado INT NOT NULL,
    valor_pagado INT NOT NULL,
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    id_sucursal_salida INT NOT NULL,
    id_sucursal_llegada INT NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_sucursal_salida) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_sucursal_llegada) REFERENCES sucursal(id_sucursal)
);


CREATE USER 'cliente'@'%' IDENTIFIED BY 'cliente2024';
GRANT SELECT, INSERT ON Dia4_Taller.vehiculo1 TO 'cliente'@'%';
GRANT SELECT, INSERT ON Dia4_Taller.alquiler TO 'cliente'@'%';
GRANT SELECT, INSERT ON Dia4_Taller.cliente TO 'cliente'@'%';
SHOW GRANTS FOR 'cliente'@'%';

CREATE USER 'Software'@'%' IDENTIFIED BY 'Software2024';
GRANT SELECT, INSERT, UPDATE, DELETE ON AutoRental.* TO 'Software'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'Software'@'%';

CREATE USER 'Android'@'%' IDENTIFIED BY 'cliente2024';

-- 1. Trigger para actualizar la población de la sucursal
DELIMITER //

CREATE TRIGGER after_empleado_insert_update
AFTER INSERT ON empleado
FOR EACH ROW 
BEGIN 
    UPDATE sucursal s
    SET poblacion_total = poblacion_total + 1  -- Incrementa la población total de la sucursal
    WHERE s.id_sucursal = NEW.id_sucursal;
END //

DELIMITER ;

-- 2. Trigger para auditoría de empleados
-- Creación de la tabla de auditoría si no existe
CREATE TABLE IF NOT EXISTS empleado_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    action VARCHAR(10),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- Trigger para auditoría de empleados cuando se inserta un nuevo empleado
DELIMITER //

CREATE TRIGGER after_empleado_insert_audit
AFTER INSERT ON empleado
FOR EACH ROW 
BEGIN
    INSERT INTO empleado_audit(id_empleado, action)
    VALUES (NEW.id_empleado, 'INSERT');
END //

DELIMITER ;

-- Trigger para auditoría de empleados cuando se actualiza un empleado
DELIMITER //

CREATE TRIGGER after_empleado_update_audit
AFTER UPDATE ON empleado
FOR EACH ROW 
BEGIN
    INSERT INTO empleado_audit(id_empleado, action)
    VALUES (OLD.id_empleado, 'UPDATE');
END //

DELIMITER ;

-- Este evento se encargará de realizar copias de seguridad semanales de la tabla de empleados.
DELIMITER //

CREATE EVENT IF NOT EXISTS weekly_empleado_backup 
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    -- Lógica para realizar copia de seguridad de la tabla empleado_backup
    TRUNCATE TABLE empleado_backup;
    INSERT INTO empleado_backup (id_empleado, id_sucursal, cedula, nombres, apellidos, direccion, ciudad_residencia, celular, correo_electronico)
    SELECT id_empleado, id_sucursal, cedula, nombres, apellidos, direccion, ciudad_residencia, celular, correo_electronico FROM empleado;
END; //

DELIMITER ;






SELECT * FROM sucursal;
SELECT * FROM empleado;
SELECT * FROM cliente;
SELECT * FROM vehiculo;
SELECT * FROM alquiler;

-- Desarrollado por Hernan Mendez / 1101685607