use Dia1_Mysql2;

INSERT INTO empleado VALUES (1, 'Juan Pérez', 'Calle Mayor 123', '123456789', 'Madrid', 'Madrid', 28001, '12345678A', '1234567890', 'ATS');
INSERT INTO empleado VALUES (2, 'María Gómez', 'Avenida Libertad 45', '987654321', 'Barcelona', 'Barcelona', 08001, '98765432B', '0987654321', 'Auxiliar de Enfermería');
INSERT INTO empleado VALUES (3, 'Carlos Rodríguez', 'Plaza España 1', '654321987', 'Sevilla', 'Sevilla', 41001, '65432198C', '5678901234', 'Celador');
INSERT INTO empleado VALUES (4, 'Laura Martínez', 'Paseo del Prado 20', '456789012', 'Valencia', 'Valencia', 46001, '45678901D', '4567890123', 'ATS de zona');
INSERT INTO empleado VALUES (5, 'Ana Sánchez', 'Calle Gran Vía 100', '789012345', 'Málaga', 'Málaga', 29001, '78901234E', '3456789012', 'Administrativo');

INSERT INTO medico VALUES (1, 'Dr. Antonio García', 'Av. Libertador 500', '1122334455', 'Buenos Aires', 'Buenos Aires', 1000, 'AR12345678', 'AR87654321', 'AR-MED-001', 'Titular', 1);
INSERT INTO medico VALUES (2, 'Dra. Sofia López', 'Calle Mayor 200', '6677889900', 'Madrid', 'Madrid', 28001, 'ES98765432', 'ES23456789', 'ES-MED-002', 'Interino', 2);
INSERT INTO medico VALUES (3, 'Dr. Giovanni Rossi', 'Via Roma 10', '3344556677', 'Roma', 'Lazio', 00100, 'IT65432198', 'IT76543210', 'IT-MED-003', 'Sustituto', 3);
INSERT INTO medico VALUES (4, 'Dr. Jean Dubois', 'Rue de Rivoli 30', '1122334455', 'París', 'Île-de-France', 75001, 'FR23456789', 'FR87654321', 'FR-MED-004', 'Titular', 4);
INSERT INTO medico VALUES (5, 'Dr. Hans Müller', 'Unter den Linden 15', '9988776655', 'Berlín', 'Berlín', 10115, 'DE87654321', 'DE12345678', 'DE-MED-005', 'Interino', 5);

INSERT INTO horario VALUES (1, 1, '2024-07-01', '2024-07-01 08:00:00', '2024-07-01 16:00:00');
INSERT INTO horario VALUES (2, 2, '2024-07-01', '2024-07-01 09:00:00', '2024-07-01 17:00:00');
INSERT INTO horario VALUES (3, 3, '2024-07-02', '2024-07-02 10:00:00', '2024-07-02 18:00:00');
INSERT INTO horario VALUES (4, 4, '2024-07-02', '2024-07-02 11:00:00', '2024-07-02 19:00:00');
INSERT INTO horario VALUES (5, 5, '2024-07-03', '2024-07-03 12:00:00', '2024-07-03 20:00:00');

INSERT INTO sustitucion VALUES (1, 1, '2024-07-01', '2024-07-15');
INSERT INTO sustitucion VALUES (2, 2, '2024-07-10', '2024-07-24');
INSERT INTO sustitucion VALUES (3, 3, '2024-08-01', '2024-08-15');
INSERT INTO sustitucion VALUES (4, 4, '2024-08-10', '2024-08-24');
INSERT INTO sustitucion VALUES (5, 5, '2024-09-01', '2024-09-15');

INSERT INTO paciente VALUES (1, 'Luis Hernández', 'Calle Alcalá 200', '111222333', 28002, 'ES76543210', 'ES01234567', 1);
INSERT INTO paciente VALUES (2, 'Elena López', 'Av. Diagonal 300', '444555666', 08003, 'ES87654321', 'ES76543210', 2);
INSERT INTO paciente VALUES (3, 'Pedro Martín', 'Carrera 10 20-30', '777888999', 41002, 'ES98765432', 'ES23456789', 3);
INSERT INTO paciente VALUES (4, 'María Rodríguez', 'Paseo de la Castellana 400', '555666777', 46002, 'ES23456789', 'ES87654321', 4);
INSERT INTO paciente VALUES (5, 'Jorge Gutiérrez', 'Calle Gran Vía 500', '888999000', 29002, 'ES34567890', 'ES34567890', 5);

INSERT INTO vacaciones VALUES (1, 1, 1, '2024-07-01', '2024-07-15', 'Planificadas');
INSERT INTO vacaciones VALUES (2, 2, 2, '2024-07-10', '2024-07-24', 'Disfrutadas');
INSERT INTO vacaciones VALUES (3, 3, 3, '2024-08-01', '2024-08-15', 'Planificadas');
INSERT INTO vacaciones VALUES (4, 4, 4, '2024-08-10', '2024-08-24', 'Disfrutadas');
INSERT INTO vacaciones VALUES (5, 5, 5, '2024-09-01', '2024-09-15', 'Planificadas');