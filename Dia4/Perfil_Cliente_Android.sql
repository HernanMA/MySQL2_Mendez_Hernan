SHOW DATABASES;

USE Dia4_Taller;

SELECT * FROM vehiculo;

-- Consulta para ver la disponibilidad de vehiculos
DELIMITER //

CREATE PROCEDURE ConsultarDisponibilidadVehiculos()
BEGIN
    SELECT vehiculo.id_vehiculo, vehiculo.modelo, alquiler.valor_semana, alquiler.valor_dia, alquiler.fecha_esperada_llegada
    FROM vehiculo
    LEFT JOIN alquiler ON vehiculo.id_vehiculo = alquiler.id_alquiler;
END //

DELIMITER ;

CALL ConsultarDisponibilidadVehiculos();

-- Consulta para ver un historial de los cliente y los empleados que han tenido un vehiculo
DELIMITER //

CREATE PROCEDURE ConsultarHistorialAlquileres()
BEGIN
    SELECT cliente.nombres AS cliente, empleado.nombres AS empleado, vehiculo.id_vehiculo, vehiculo.modelo
    FROM alquiler
    LEFT JOIN vehiculo ON alquiler.id_vehiculo = vehiculo.id_vehiculo
    LEFT JOIN cliente ON cliente.id_cliente = alquiler.id_cliente
    LEFT JOIN empleado ON alquiler.id_empleado = empleado.id_empleado;
END //

DELIMITER ;

CALL ConsultarHistorialAlquileres();

-- Alquilar un vehiculo
INSERT INTO alquiler (id_alquiler, fecha_salida, fecha_llegada, fecha_esperada_llegada, valor_semana, valor_dia, porcentaje_descuento, valor_cotizado, valor_pagado, id_vehiculo, id_cliente, id_empleado, id_sucursal_salida, id_sucursal_llegada)
VALUES (NULL, '2024-07-01', '2024-07-10', '2024-07-10', 700, 100, 10, 900, 800, 1, 1, 1, 1, 2);

SELECT * FROM alquiler;