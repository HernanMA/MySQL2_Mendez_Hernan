SHOW DATABASES;

CREATE DATABASE Dia6_MySQL2;

USE Dia6_MySQL2;

-- ##########################
-- ######## Practica ########
-- ##########################

-- Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida 
-- y que muestre el texto ¡Hola mundo!.
DELIMITER // 

CREATE PROCEDURE hola_mundo()
BEGIN 
	SELECT '¡Hola mundo!';
END //

DELIMITER ;

-- 2. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el
-- número es positivo, negativo o cero.

DELIMITER //

DROP PROCEDURE IF EXISTS DeterminarSigno;
CREATE PROCEDURE DeterminarSigno(IN numero REAL)
BEGIN
    IF numero > 0 THEN
        SELECT 'El número es positivo' AS Mensaje;
    ELSEIF numero < 0 THEN
        SELECT 'El número es negativo' AS Mensaje;
    ELSE
        SELECT 'El número es cero' AS Mensaje;
    END IF;
END //

DELIMITER ;

CALL DeterminarSigno(10);

-- 3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada,
-- con el valor un número real, y un parámetro de salida, con una cadena de caracteres indicando si el nú‑
-- mero es positivo, negativo o cero.

DELIMITER //

DROP PROCEDURE IF EXISTS DeterminarSigno2;
CREATE PROCEDURE DeterminarSigno2(
    IN numero REAL,
    OUT resultado_texto VARCHAR(50)  -- Debes especificar el tipo de dato para la salida
)
BEGIN
    IF numero > 0 THEN
        SET resultado_texto := 'El número es positivo';
    ELSEIF numero < 0 THEN
        SET resultado_texto := 'El número es negativo';
    ELSE
        SET resultado_texto := 'El número es cero';
    END IF;
END //

DELIMITER ;

SET @numero := 70;
SET @resultado := '';

CALL DeterminarSigno2(@numero, @resultado);

-- Mostrar el resultado
SELECT @resultado AS Resultado;


-- 4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de
-- un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes
-- condiciones:
-- [0,5) = Insuficiente
-- [5,6) = Aprobado
-- [6, 7) = Bien
-- [7, 9) = Notable
-- [9, 10] = Sobresaliente
-- En cualquier otro caso la nota no será válida.
DELIMITER //

CREATE PROCEDURE evaluar_nota_alumno(
    IN nota_estudiante REAL
)
BEGIN
    IF nota_estudiante >= 0 AND nota_estudiante < 5 THEN 
        SELECT 'Insuficiente' AS nota;
    ELSEIF nota_estudiante >= 5 AND nota_estudiante < 6 THEN
        SELECT 'Aprobado' AS nota;
    ELSEIF nota_estudiante >= 6 AND nota_estudiante < 7 THEN
        SELECT 'Bien' AS nota;
    ELSEIF nota_estudiante >= 7 AND nota_estudiante < 9 THEN
        SELECT 'Notable' AS nota;
    ELSEIF nota_estudiante >= 9 AND nota_estudiante <= 10 THEN
        SELECT 'Sobresaliente' AS nota;
    ELSE
        SELECT 'No es valida la nota' AS nota;
    END IF;
END //

DELIMITER ;

CALL evaluar_nota_alumno(10);

-- 5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada,
-- con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando
-- la nota correspondiente.

DELIMITER //

CREATE PROCEDURE evaluar_nota_alumno2(
    IN nota_estudiante REAL,
    OUT nota_texto VARCHAR(20)
)
BEGIN
    IF nota_estudiante >= 0 AND nota_estudiante < 5 THEN 
        SET nota_texto = 'Insuficiente';
    ELSEIF nota_estudiante >= 5 AND nota_estudiante < 6 THEN
        SET nota_texto = 'Aprobado';
    ELSEIF nota_estudiante >= 6 AND nota_estudiante < 7 THEN
        SET nota_texto = 'Bien';
    ELSEIF nota_estudiante >= 7 AND nota_estudiante < 9 THEN
        SET nota_texto = 'Notable';
    ELSEIF nota_estudiante >= 9 AND nota_estudiante <= 10 THEN
        SET nota_texto = 'Sobresaliente';
    ELSE
        SET nota_texto = 'No es válida la nota';
    END IF;
END //

DELIMITER ;

SET @nota := 7;
SET @resultado := '';

CALL evaluar_nota_alumno2(@nota, @resultado);

-- Consultar el resultado
SELECT @resultado AS Resultado;

-- 7. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un
-- día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana corres‑
-- pondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes. Resuelva el proce‑
-- dimiento haciendo uso de la estructura de control IF.
DELIMITER //
CREATE PROCEDURE dia_semana(
    IN numero_dia INT
)
BEGIN
    CASE numero_dia
        WHEN 1 THEN SELECT 'Lunes';
        WHEN 2 THEN SELECT 'Martes';
        WHEN 3 THEN SELECT 'Miércoles';
        WHEN 4 THEN SELECT 'Jueves';
        WHEN 5 THEN SELECT 'Viernes';
        WHEN 6 THEN SELECT 'Sábado';
        WHEN 7 THEN SELECT 'Domingo';
        ELSE SELECT 'Día de la semana no válido';
    END CASE;
END //
DELIMITER ;


CALL dia_semana(3);

