-- ####### 1. Gestión de Sucursales #########
-- a. Crear una nueva sucursal
INSERT INTO sucursal (id_sucursal, ciudad, direccion, telefono_fijo, celular, correo_electronico)
VALUES (NULL, 'Ciudad Ejemplo', 'Direccion Ejemplo', '123456789', '987654321', 'email@example.com');

-- b. Actualizar la información de una sucursal existente
UPDATE sucursal
SET ciudad = 'Nueva Ciudad', direccion = 'Nueva Direccion', telefono_fijo = 'Nuevo Telefono Fijo', celular = 'Nuevo Celular', correo_electronico = 'nuevoemail@example.com'
WHERE id_sucursal = 1;

-- c. Eliminar una sucursal
DELETE FROM sucursal
WHERE id_sucursal = 1;

-- d. Consultar todas las sucursales
SELECT * FROM sucursal;

-- ######### 2. Gestión de Empleados######
-- a. Registrar un nuevo empleado
INSERT INTO empleado (id_empleado, id_sucursal, cedula, nombres, apellidos, direccion, ciudad_residencia, celular, correo_electronico)
VALUES (NULL, 1, '1234567890', 'Nombre Ejemplo', 'Apellido Ejemplo', 'Direccion Ejemplo', 'Ciudad Ejemplo', '987654321', 'email@example.com');

-- b. Actualizar la información de un empleado existente
UPDATE empleado
SET id_sucursal = 2, cedula = '0987654321', nombres = 'Nuevo Nombre', apellidos = 'Nuevo Apellido', direccion = 'Nueva Direccion', ciudad_residencia = 'Nueva Ciudad', celular = 'Nuevo Celular', correo_electronico = 'nuevoemail@example.com'
WHERE id_empleado = 1;

-- c. Eliminar un empleado
DELETE FROM empleado
WHERE id_empleado = 1;

-- d. Consultar todos los empleados
SELECT * FROM empleado;

-- 3. Gestión de Vehículos
-- a. Agregar un nuevo vehículo
INSERT INTO vehiculo (id_vehiculo, tipo_vehiculo, placa, referencia, modelo, puertas, estado, capacidad, sunroof, motor, color)
VALUES (NULL, 'Tipo Ejemplo', 'ABC-123', 'Referencia Ejemplo', '2024', 4, 'Disponible', 5, TRUE, 'Motor Ejemplo', 'Color Ejemplo');

-- b. Actualizar la información de un vehículo existente
UPDATE vehiculo
SET tipo_vehiculo = 'Nuevo Tipo', placa = 'XYZ-789', referencia = 'Nueva Referencia', modelo = '2023', puertas = 4, estado = 'Mantenimiento', capacidad = 5, sunroof = FALSE, motor = 'Nuevo Motor', color = 'Nuevo Color'
WHERE id_vehiculo = 1;

-- c. Eliminar un vehículo
DELETE FROM vehiculo
WHERE id_vehiculo = 1;

-- d. Consultar todos los vehículos 
SELECT * FROM vehiculo;

-- 4. Gestión de Alquileres
-- a. Registrar un nuevo alquiler
INSERT INTO alquiler (id_alquiler, fecha_salida, fecha_llegada, fecha_esperada_llegada, valor_semana, valor_dia, porcentaje_descuento, valor_cotizado, valor_pagado, id_vehiculo, id_cliente, id_empleado, id_sucursal_salida, id_sucursal_llegada)
VALUES (NULL, '2024-07-01', '2024-07-10', '2024-07-10', 700, 100, 10, 900, 800, 1, 1, 1, 1, 2);

-- b. Actualizar la información de un alquiler existente
UPDATE alquiler
SET fecha_salida = '2024-07-02', fecha_llegada = '2024-07-12', fecha_esperada_llegada = '2024-07-12', valor_semana = 750, valor_dia = 105, porcentaje_descuento = 5, valor_cotizado = 950, valor_pagado = 850, id_vehiculo = 2, id_cliente = 2, id_empleado = 2, id_sucursal_salida = 2, id_sucursal_llegada = 3
WHERE id_alquiler = 1;

-- c. Eliminar un alquiler
DELETE FROM alquiler
WHERE id_alquiler = 1;