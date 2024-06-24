show databases;

create database MySQL2_Taller_Dia2;

use MySQL2_Taller_Dia2;

CREATE TABLE departamento (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
gastos DOUBLE UNSIGNED NOT NULL
); 

CREATE TABLE empleado (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nif VARCHAR(9) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
id_departamento INT UNSIGNED,
FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);
    
show tables;

-- ######################################
-- ##### Consultas sobre una tabla ######
-- ######################################
-- 1. Lista el primer apellido de todos los empleados.
DELIMITER //
CREATE PROCEDURE obtener_apellidos()
BEGIN
    SELECT apellido1
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_apellidos();

-- 2. Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
DELIMITER //
CREATE PROCEDURE obtener_apellidos_distintos()
BEGIN
    SELECT DISTINCT apellido1
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_apellidos_distintos();

-- 3. Lista todas las columnas de la tabla empleado.
DELIMITER //
CREATE PROCEDURE obtener_todos_los_empleados()
BEGIN
    SELECT *
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_todos_los_empleados();

-- 4. Lista el nombre y los apellidos de todos los empleados.
DELIMITER //
CREATE PROCEDURE obtener_nombres_y_apellidos()
BEGIN
    SELECT nombre, apellido1, apellido2
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_nombres_y_apellidos();

-- 5. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
DELIMITER //
CREATE PROCEDURE obtener_ids_departamentos()
BEGIN
    SELECT id_departamento
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_ids_departamentos();

-- 6. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos.
DELIMITER //
CREATE PROCEDURE obtener_ids_departamentos_distintos()
BEGIN
    SELECT DISTINCT id_departamento
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_ids_departamentos_distintos();

-- 7. Lista el nombre y apellidos de los empleados en una única columna.
DELIMITER //
CREATE PROCEDURE obtener_nombres_y_apellidos_concatenados()
BEGIN
    SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombresYapellidos
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_nombres_y_apellidos_concatenados();

-- 8. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
DELIMITER //
CREATE PROCEDURE obtener_nombres_y_apellidos_mayuscula()
BEGIN
    SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombresYapellidos
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_nombres_y_apellidos_mayuscula();

-- 9. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
DELIMITER //
CREATE PROCEDURE obtener_nombres_y_apellidos_minuscula()
BEGIN
    SELECT LOWER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombresYapellidos
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_nombres_y_apellidos_minuscula();

-- 10. Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.
DELIMITER //
CREATE PROCEDURE obtener_id_y_nif_desglosado()
BEGIN
    SELECT id, 
           nif, 
           LEFT(nif, LENGTH(nif) - 1) AS nif_digitos, 
           RIGHT(nif, 1) AS nif_letra
    FROM empleado;
END;
//
DELIMITER ;

CALL obtener_id_y_nif_desglosado();


-- 11. Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del
-- presupuesto inicial (columna presupuesto) los gastos que se han generado
-- valores negativos. Utilice un alias apropiado para la nueva columna columna
-- que está calculando.
DELIMITER //
CREATE PROCEDURE obtener_presupuesto_actual()
BEGIN
    SELECT nombre, 
           (presupuesto - gastos) AS presupuesto_Actual
    FROM departamento;
END;
//
DELIMITER ;

CALL obtener_presupuesto_actual();

-- 12. Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
DELIMITER //
CREATE PROCEDURE obtener_presupuesto_actual_ordenado()
BEGIN
    SELECT nombre, 
           (presupuesto - gastos) AS presupuesto_Actual
    FROM departamento
    ORDER BY presupuesto_Actual ASC;
END;
//
DELIMITER ;

CALL obtener_presupuesto_actual_ordenado();

-- 13. Lista el nombre de todos los departamentos ordenados de forma ascendente.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_orden_asc()
BEGIN
    SELECT nombre
    FROM departamento
    ORDER BY nombre ASC;
END;
//
DELIMITER ;

CALL obtener_departamentos_orden_asc();

-- 14. Lista el nombre de todos los departamentos ordenados de forma descendente.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_orden_desc()
BEGIN
    SELECT nombre
    FROM departamento
    ORDER BY nombre DESC;
END;
//
DELIMITER ;

-- 15. Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.
DELIMITER //
CREATE PROCEDURE obtener_empleados_orden_alfabetico()
BEGIN
    SELECT apellido1, apellido2, nombre
    FROM empleado
    ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
END;
//
DELIMITER ;

CALL obtener_empleados_orden_alfabetico();

-- 16. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_mayor_presupuesto()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    ORDER BY presupuesto DESC
    LIMIT 3;
END;
//
DELIMITER ;

CALL obtener_departamentos_mayor_presupuesto();

-- 17. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_menor_presupuesto()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    ORDER BY presupuesto ASC
    LIMIT 3;
END;
//
DELIMITER ;


-- 18. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_mayor_gasto()
BEGIN
    SELECT nombre, gastos
    FROM departamento
    ORDER BY gastos DESC
    LIMIT 2;
END;
//
DELIMITER ;

CALL obtener_departamentos_mayor_gasto();

-- 19. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_menor_gasto()
BEGIN
    SELECT nombre, gastos
    FROM departamento
    ORDER BY gastos ASC
    LIMIT 2;
END;
//
DELIMITER ;


-- 20. Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.
DELIMITER //
CREATE PROCEDURE obtener_empleados_desde_la_tercera()
BEGIN
    SELECT * 
    FROM empleado
    ORDER BY id
    LIMIT 5 OFFSET 2;
END;
//
DELIMITER ;

CALL obtener_empleados_desde_la_tercera();

-- 21. Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_presupuesto_mayor_igual_150000()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto >= 150000;
END;
//
DELIMITER ;


-- 22. Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_gasto_menor_5000()
BEGIN
    SELECT nombre, gastos
    FROM departamento
    WHERE gastos < 5000;
END;
//
DELIMITER ;

CALL obtener_departamentos_gasto_menor_5000();

-- 23. Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_presupuesto_entre_100000_200000()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto >= 100000 AND presupuesto <= 200000;
END;
//
DELIMITER ;

CALL obtener_departamentos_presupuesto_entre_100000_200000();

-- 24. Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_presupuesto_fuera_100000_200000()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto <= 100000 OR presupuesto >= 200000;
END;
//
DELIMITER ;


-- 25. Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_presupuesto_between_100000_200000()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto BETWEEN 100000 AND 200000;
END;
//
DELIMITER ;

CALL obtener_departamentos_presupuesto_between_100000_200000();

-- 26. Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_presupuesto_not_between_100000_200000()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto NOT BETWEEN 100000 AND 200000;
END;
//
DELIMITER ;


-- 27. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_gastos_mayores_presupuesto()
BEGIN
    SELECT nombre, presupuesto, gastos
    FROM departamento
    WHERE gastos > presupuesto;
END;
//
DELIMITER ;

CALL obtener_departamentos_gastos_mayores_presupuesto();


-- 28. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_gastos_menores_presupuesto()
BEGIN
    SELECT nombre, presupuesto, gastos
    FROM departamento
    WHERE gastos < presupuesto;
END;
//
DELIMITER ;


-- 29. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean iguales al presupuesto del que disponen.
DELIMITER //
CREATE PROCEDURE obtener_departamentos_gastos_igual_presupuesto()
BEGIN
    SELECT nombre, presupuesto, gastos
    FROM departamento
    WHERE gastos = presupuesto;
END;
//
DELIMITER ;

CALL obtener_departamentos_gastos_igual_presupuesto();

-- 30. Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
DELIMITER //
CREATE PROCEDURE obtener_empleados_segundo_apellido_null()
BEGIN
    SELECT *
    FROM empleado
    WHERE apellido2 IS NULL;
END;
//
DELIMITER ;

CALL obtener_empleados_segundo_apellido_null();

-- 31. Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
DELIMITER //
CREATE PROCEDURE obtener_empleados_segundo_apellido_not_null()
BEGIN
    SELECT *
    FROM empleado
    WHERE apellido2 IS NOT NULL;
END;
//
DELIMITER ;

CALL obtener_empleados_segundo_apellido_not_null();

-- 32. Lista todos los datos de los empleados cuyo segundo apellido sea López.
DELIMITER //
CREATE PROCEDURE obtener_empleados_segundo_apellido_lopez()
BEGIN
    SELECT *
    FROM empleado
    WHERE apellido2 = 'López';
END;
//
DELIMITER ;

CALL obtener_empleados_segundo_apellido_lopez();


-- 33. Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operador IN.
DELIMITER //
CREATE PROCEDURE obtener_empleados_segundo_apellido_diaz_moreno()
BEGIN
    SELECT *
    FROM empleado
    WHERE apellido2 = 'Díaz' OR apellido2 = 'Moreno';
END;
//
DELIMITER ;

CALL obtener_empleados_segundo_apellido_diaz_moreno();

-- 34. Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Utilizando el operador IN.
DELIMITER //
CREATE PROCEDURE obtener_empleados_segundo_apellido_diaz_moreno_in()
BEGIN
    SELECT *
    FROM empleado
    WHERE apellido2 IN ('Díaz', 'Moreno');
END;
//
DELIMITER ;

CALL obtener_empleados_segundo_apellido_diaz_moreno_in();

-- 35. Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.
DELIMITER //
CREATE PROCEDURE obtener_empleados_departamento_3()
BEGIN
    SELECT nombre, apellido1, apellido2, nif
    FROM empleado
    WHERE id_departamento = 3;
END;
//
DELIMITER ;

CALL obtener_empleados_departamento_3();

-- 36. Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.
DELIMITER //
CREATE PROCEDURE obtener_empleados_departamentos_2_4_5()
BEGIN
    SELECT nombre, apellido1, apellido2, nif
    FROM empleado
    WHERE id_departamento IN (2, 4, 5);
END;
//
DELIMITER ;

CALL obtener_empleados_departamentos_2_4_5();

-- #######################################################
-- ####### Consultas multitabla (Composición interna) ####
-- #######################################################
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

-- 1. Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
DELIMITER //

CREATE PROCEDURE empleados_con_departamentos()
BEGIN
    SELECT empleado.nombre, departamento.nombre AS nombre_departamento
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id;
END//

DELIMITER ;

CALL empleados_con_departamentos();

-- 2. Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
DELIMITER //

CREATE PROCEDURE empleados_con_departamentos_ordenado()
BEGIN
    SELECT departamento.nombre, empleado.apellido1, empleado.apellido2, empleado.nombre
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id
    ORDER BY departamento.nombre ASC, empleado.apellido1 ASC, empleado.apellido2 ASC, empleado.nombre ASC;
END//

DELIMITER ;

CALL empleados_con_departamentos_ordenado();

-- 3. Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
DELIMITER //

CREATE PROCEDURE departamentos_con_empleados()
BEGIN
    SELECT DISTINCT departamento.id, departamento.nombre
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id;
END//

DELIMITER ;

-- 4. Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo
-- puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).
DELIMITER //

CREATE PROCEDURE presupuesto_departamentos_con_empleados()
BEGIN
    SELECT departamento.id, departamento.nombre, (departamento.presupuesto - departamento.gastos) AS presupuesto_actual
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id;
END//

DELIMITER ;

CALL presupuesto_departamentos_con_empleados();

-- 5. Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
DELIMITER //

CREATE PROCEDURE departamento_empleado_por_nif(IN nif_param VARCHAR(10))
BEGIN
    SELECT departamento.nombre
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id
    WHERE empleado.nif = nif_param;
END//

DELIMITER ;



-- 6. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
select departamento.nombre, empleado.nombre, empleado.apellido1, empleado.apellido2
from empleado
inner join departamento on empleado.id_departamento = departamento.id 
where empleado.nombre = 'Pepe' and empleado.apellido1 = 'Ruiz' and apellido2 = 'Santana';

-- 7. Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
DELIMITER //

CREATE PROCEDURE empleados_en_id()
BEGIN
    SELECT empleado.nombre
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id
    WHERE departamento.nombre = 'I+D'
    ORDER BY empleado.nombre ASC;
END//

DELIMITER ;

CALL empleados_en_id();

-- 8. Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
DELIMITER //

CREATE PROCEDURE empleados_en_varios_departamentos()
BEGIN
    SELECT empleado.nombre
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id
    WHERE departamento.nombre IN ('I+D', 'Sistemas', 'Contabilidad')
    ORDER BY empleado.nombre ASC;
END//

DELIMITER ;

CALL empleados_en_varios_departamentos();

-- 9. Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
DELIMITER //

CREATE PROCEDURE empleados_con_presupuesto()
BEGIN
    SELECT empleado.nombre
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id
    WHERE departamento.presupuesto NOT BETWEEN 100000 AND 200000;
END//

DELIMITER ;

CALL empleados_con_presupuesto();

-- 10. Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
DELIMITER //

CREATE PROCEDURE departamentos_con_apellido_nulo()
BEGIN
    SELECT DISTINCT departamento.nombre
    FROM empleado
    INNER JOIN departamento ON empleado.id_departamento = departamento.id
    WHERE empleado.apellido2 IS NULL;
END//

DELIMITER ;


-- ###################################################
-- #### Consultas multitabla (Composición externa) ###
-- ###################################################
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- 1. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado.
DELIMITER // 

CREATE PROCEDURE empleados_con_departamentoss()
BEGIN 
	SELECT empleado.nombre, departamento.nombre
    FROM empleado
    LEFT JOIN departamento ON empleado.id_departamento = departamento.id;
END//

DELIMITER ;

CALL empleados_con_departamentoss();

-- 2. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
DELIMITER // 

CREATE PROCEDURE empleados_null_con_departamentos()
BEGIN 
	SELECT empleado.nombre, departamento.nombre
    FROM empleado
    LEFT JOIN departamento ON empleado.id_departamento = departamento.id
    WHERE empleado.id_departamento IS NULL;
END//

DELIMITER ;

CALL empleados_null_con_departamentos();

-- 3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
DELIMITER // 

CREATE PROCEDURE empleados_con_departamentos_null()
BEGIN 
	SELECT empleado.nombre, departamento.nombre
	FROM departamento
	LEFT join empleado on departamento.id = empleado.id_departamento
	WHERE empleado.id is null; 
END//

DELIMITER ;

CALL empleados_con_departamentos_null();
	

-- 4. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe incluir los empleados que no
-- tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
select 
    empleado.id as id_empleado,
    empleado.nif as nif_empleado,
    empleado.nombre as nombre_empleado,
    empleado.apellido1 as apellido1_empleado,
    empleado.apellido2 as apellido2_empleado,
    departamento.id as id_departamento,
    departamento.nombre as nombre_departamento,
    departamento.presupuesto as presupuesto_departamento,
    departamento.gastos as gastos_departamento
from 
    empleado
left join 
    departamento on empleado.id_departamento = departamento.id

union all

select 
    null id_empleado,
    null nif_empleado,
    null nombre_empleado,
    null apellido1_empleado,
    null apellido2_empleado,
    departamento.id id_departamento,
    departamento.nombre nombre_departamento,
    departamento.presupuesto presupuesto_departamento,
    departamento.gastos gastos_departamento
from 
    departamento
left join 
    empleado on departamento.id = empleado.id_departamento

order by 
    nombre_departamento, nombre_empleado;

-- 5. Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
select empleado.nombre as nombre_empleado, departamento.nombre as departamento_nombre
from empleado
left join departamento on empleado.id_departamento = departamento.id
union all
select null, departamento.nombre
from departamento
left join empleado on departamento.id = empleado.id_departamento
order by departamento_nombre;


-- #################################
-- ####### Consultas resumen #######
-- #################################
-- 1. Calcula la suma del presupuesto de todos los departamentos.
DELIMITER //
CREATE PROCEDURE calcular_suma_presupuesto()
BEGIN
    SELECT SUM(presupuesto) AS suma_presupuesto
    FROM departamento;
END;
//
DELIMITER ;

CALL calcular_suma_presupuesto();

-- 2. Calcula la media del presupuesto de todos los departamentos.
DELIMITER //
CREATE PROCEDURE calcular_media_presupuesto()
BEGIN
    SELECT AVG(presupuesto) AS media_presupuesto
    FROM departamento;
END;
//
DELIMITER ;

CALL calcular_media_presupuesto();

-- 3. Calcula el valor mínimo del presupuesto de todos los departamentos.
DELIMITER //
CREATE PROCEDURE calcular_minimo_presupuesto()
BEGIN
    SELECT MIN(presupuesto) AS minimo_presupuesto
    FROM departamento;
END;
//
DELIMITER ;

CALL calcular_minimo_presupuesto();

-- 4. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
DELIMITER //
CREATE PROCEDURE obtener_departamento_minimo_presupuesto()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto = (SELECT MIN(presupuesto) FROM departamento);
END;
//
DELIMITER ;

CALL obtener_departamento_minimo_presupuesto();

-- 5. Calcula el valor máximo del presupuesto de todos los departamentos.
DELIMITER //
CREATE PROCEDURE calcular_maximo_presupuesto()
BEGIN
    SELECT MAX(presupuesto) AS maximo_presupuesto
    FROM departamento;
END;
//
DELIMITER ;

CALL calcular_maximo_presupuesto();

-- 6. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
DELIMITER //
CREATE PROCEDURE obtener_departamento_maximo_presupuesto()
BEGIN
    SELECT nombre, presupuesto
    FROM departamento
    WHERE presupuesto = (SELECT MAX(presupuesto) FROM departamento);
END;
//
DELIMITER ;

CALL obtener_departamento_maximo_presupuesto();


-- 7. Calcula el número total de empleados que hay en la tabla empleado.
DELIMITER //
CREATE PROCEDURE calcular_total_empleados()
BEGIN
    SELECT COUNT(id) AS total_empleados
    FROM empleado;
END;
//
DELIMITER ;

CALL calcular_total_empleados();

-- 8. Calcula el número de empleados que no tienen NULL en su segundo apellido.
DELIMITER //
CREATE PROCEDURE calcular_empleados_con_segundo_apellido()
BEGIN
    SELECT COUNT(apellido2) AS empleados_con_segundo_apellido
    FROM empleado
    WHERE apellido2 IS NOT NULL;
END;
//
DELIMITER ;

CALL calcular_empleados_con_segundo_apellido();

-- 9. Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.
DELIMITER //
CREATE PROCEDURE calcular_numero_empleados_por_departamento()
BEGIN
    SELECT departamento.nombre, COUNT(empleado.id) AS num_empleados
    FROM empleado
    RIGHT JOIN departamento ON empleado.id_departamento = departamento.id
    GROUP BY departamento.nombre;
END;
//
DELIMITER ;

CALL calcular_numero_empleados_por_departamento();


-- 10. Calcula el nombre de los departamentos que tienen más de 2 empleados. El resultado debe tener dos columnas, una con el nombre del departamento y
-- otra con el número de empleados que tiene asignados.
DELIMITER //
CREATE PROCEDURE calcular_departamentos_mas_de_2_empleados()
BEGIN
    SELECT departamento.nombre, COUNT(empleado.id) AS num_empleados
    FROM empleado
    RIGHT JOIN departamento ON empleado.id_departamento = departamento.id
    GROUP BY departamento.nombre
    HAVING COUNT(empleado.id) > 2;
END;
//
DELIMITER ;

CALL calcular_departamentos_mas_de_2_empleados();

-- 11. Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta consulta también tiene que incluir
-- aquellos departamentos que no tienen ningún empleado asociado.
DELIMITER //
CREATE PROCEDURE calcular_numero_empleados_por_departamento_incluyendo_vacios()
BEGIN
    SELECT departamento.nombre, COUNT(empleado.id) AS num_empleados
    FROM departamento
    LEFT JOIN empleado ON departamento.id = empleado.id_departamento
    GROUP BY departamento.nombre;
END;
//
DELIMITER ;

CALL calcular_numero_empleados_por_departamento_incluyendo_vacios();

-- 12. Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.
DELIMITER //
CREATE PROCEDURE calcular_numero_empleados_departamentos_presupuesto_mayor_200000()
BEGIN
    SELECT departamento.nombre, COUNT(empleado.id) AS num_empleados
    FROM empleado
    RIGHT JOIN departamento ON empleado.id_departamento = departamento.id
    WHERE departamento.presupuesto > 200000
    GROUP BY departamento.nombre;
END;
//
DELIMITER ;

CALL calcular_numero_empleados_departamentos_presupuesto_mayor_200000();



select * from departamento;
select * from empleado;
