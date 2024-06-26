SHOW DATABASES;

USE Dia4_Taller;

SELECT * FROM vehiculo;

SELECT vehiculo.id_vehiculo, vehiculo.modelo, alquiler.valor_semana, alquiler.valor_dia, alquiler.fecha_esperada_llegada
FROM vehiculo
LEFT JOIN alquiler ON vehiculo.id_vehiculo = alquiler.id_alquiler;