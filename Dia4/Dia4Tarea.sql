SHOW DATABASES;

CREATE DATABASE Dia4_Taller;

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

CREATE TABLE vehiculo1 (
    id_vehiculo INT PRIMARY KEY,
    tipo_vehiculo ENUM('Camioneta', 'Deportivo', 'Familiar', 'Carga') NOT NULL,
    placa VARCHAR(20) NOT NULL,
    referencia VARCHAR(100) NOT NULL,
    modelo VARCHAR(200) NOT NULL,
    puertas INT NOT NULL,
    estado ENUM('Vendido', 'Disponible'),
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
    valor_semana DECIMAL(10, 2) NOT NULL,
    valor_dia DECIMAL(10, 2) NOT NULL,
    porcentaje_descuento DECIMAL(5, 2) NULL,
    valor_cotizado DECIMAL(10, 2) NOT NULL,
    valor_pagado DECIMAL(10, 2) NOT NULL,
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    id_sucursal_salida INT NOT NULL,
    id_sucursal_llegada INT NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo1(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_sucursal_salida) REFERENCES sucursal(id_sucursal),
    FOREIGN KEY (id_sucursal_llegada) REFERENCES sucursal(id_sucursal)
);


CREATE USER 'cliente'@'%' IDENTIFIED BY 'cliente2024';
GRANT SELECT ON Dia4_Taller.vehiculo1 TO 'cliente'@'%';
GRANT SELECT ON Dia4_Taller.alquiler TO 'cliente'@'%';
SHOW GRANTS FOR 'cliente'@'%';

CREATE USER 'Software'@'%' IDENTIFIED BY 'cliente2024';


CREATE USER 'Android'@'%' IDENTIFIED BY 'cliente2024';

SELECT * FROM sucursal;
SELECT * FROM empleado;
SELECT * FROM cliente;
SELECT * FROM vehiculo1;
SELECT * FROM alquiler;
