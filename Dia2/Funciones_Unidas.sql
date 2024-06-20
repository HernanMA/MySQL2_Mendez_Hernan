-- ##############################
-- ###### DIA 2 - MySQL 2  ######
-- ##############################
create database mysql2_dia2;
use mysql2_dia2;
-- TITULO : CONSULTAS AVANZADAS
create table productos(
    id int auto_increment,
    nombre varchar(100),
    precio decimal(10,2), 
    primary key(id)
);
-- truncate table productos;
insert into productos values
    (1,"Pepito",23.2),
    (2,"MousePad",100000.21),
    (3,"Espionap",2500.25),
    (4,"BOB-ESPONJA",1500.25),
    (5,"Cary",23540000.23),
    (6,"OvulAPP",198700.23),
    (7,"PapayAPP",2000.00),
    (8,"Menosprecio",3800.00),
    (9,"PerfumeMascotas",2300.00),
    (10,"Perfume La Cumbre", 35000.25),
    (11,"Nevera M800",3000.12),
    (12,"Crema Suave", 2845.00),
    (13,"juego de mesa La Cabellera",9800.00),
    (14,"Cargador iPhone",98000.00);
    
-- Para crear una función la cual me retorne el
-- nombre del producto con el precio mas iva (19%)
-- Donde si vale mas de 1000 se aplica un descuento del 20%
delimiter //
create function TotalConIVA(precio decimal(10,2),iva decimal(5,3))
returns decimal(10,2) deterministic
begin
    if precio > 1000 then
        return (precio+(precio*iva))-((precio+(precio*iva))*0.2);
    else
        return precio+(precio*iva);
    end if;
end//
delimiter ;

-- Utilizar la función TotalConIVA
select TotalConIva(25000,0.19);

-- Eliminar la funcion
drop function TotalConIva;

-- Extrapolar función con datos de la base de datos
select TotalConIva(precio,0.19) from productos;

-- Función para obtener el precio de un producto
-- dado su nombre
delimiter //
Create function obtener_precio_producto(nombre_producto varchar(100))
returns decimal (10,2)
deterministic
begin
    declare precio_producto decimal(10,2);
    select precio into precio_producto from productos 
    where nombre = nombre_producto;
    return precio_producto;
end//
delimiter ;

-- Usar función
select obtener_precio_producto('Pepito') as Precio;

-- Función para obtener el precio de un producto (con su iva y promoción)
-- dado su nombre
delimiter //
Create function obtener_precio_producto_prom(nombre_producto varchar(100))
returns decimal (10,2)
deterministic
begin
    declare precio_producto decimal(10,2);
    select TotalConIva(precio,0.19) into precio_producto from productos 
    where nombre = nombre_producto;
    return precio_producto;
end//
delimiter ;
select obtener_precio_producto_prom('Pepito') as Precio;