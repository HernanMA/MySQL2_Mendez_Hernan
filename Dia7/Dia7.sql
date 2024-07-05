-- ###############################
-- ####### Dia 7 - MySQL2 ########
-- ###############################

USE DIA5_MySQL2;

-- Subconsulta Consulta Escalar : Toda subconsulta que devuelve un solo valor (fila y columna)
-- EJEMPLO: Devuelva el nombre del país con la mayor población 
SELECT Name 
fROM country
WHERE Population = (SELECT MAX(Population) FROM country);

-- Subconsulta de columna Única : Devuelve una columna de múltiples filas.
-- EJEMPLO: Encuentre los nombres de todas las ciudades en los paises que tienen un área mayor a 1000000 Km2
SELECT Name 
FROM city
WHERE CountryCode IN (SELECT Code FROM country WHERE SurfaceArea > 1000000);

-- Subconsulta de Múltiples columnas : Devuelve una columna de múltiples filas.
-- EJEMPLO: Encontrar las ciudades que tengan la misma población y distrito que cualquier ciudad del pais. 'USA'
SELECT Name, CountryCode, Disrict, Population
FROM city
WHERE (District, Population) in (SELECT District, Population FROM city WHERE CountryCode = 'USA');

-- 	Subconsulta Correlacionada : Depende de la consulta externa para cada fila procesada.
-- EJEMPLO: Liste las ciudades con una población mayorque el promedio de la población de las ciudades en el mismo país.
SELECT Name, CountryCode, Population
FROM city c1
WHERE Population > (SELECT AVG(Population) FROM city c2 WHERE c1.CountryCode = c2.CountryCode);


-- INDEXACIÓN
SELECT * FROM city;

-- Crear indice en la columna 'NAME' de city.
CREATE INDEX idx_city_name ON city(Name);
SELECT * FROM city;
SELECT Name FROM city;

-- Crear índice compuesto de las columnas 'District' y 'Population'
CREATE INDEX idx_city_district_population ON city (District, Population);

-- TRANSACCIONES 
-- Son secuencias de uno o más operaciones SQL, Las cuales son ejecutadas como una única unidad de trabajo.
-- En otras palabras, las transacciones aseguran que todas las operaciones se realicen de manera correcta antes 
-- de ser ejecutadas en la bbd real, buscando cumplir con las propiedades ACID. (ATOMICIDAD, CONSISTENCIA,
-- AISLAMIENTO, DURABILIDAD).

-- Primer Paso: INICIAR LA TRANSACCIÓN
START TRANSACTION;

-- Segundo Paso: HACER COMANDOS
-- EJEMPLO: Actualizar la población de la ciudad de 'New York'
UPDATE city
SET Population = 9000000
WHERE Name = 'New York';

SELECT 

-- Subconsultas de múltiples columnas : Devuelve múltiples columnas de múltiples filas.
--

