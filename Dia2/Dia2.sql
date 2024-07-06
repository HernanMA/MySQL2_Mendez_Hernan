show databases;

create database Dia2_MySQL2;

use Dia2_MySQL2;

-- ##################################
-- ###### Consultas avanzadas #######
-- ##################################

create table productos (
	id int auto_increment primary key,
    nombre varchar(100) not null,
    precio decimal(10,2) not null
);

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
    
-- Para crear  una funcion la cual me retorne el nombre del producto con el precio mas iva (19%) Donde si vale mas de 1000 se aplica un descuento del 20%
delimiter //

create function total_con_iva(precio decimal(10,2), iva decimal(5,3))
returns varchar(255) deterministic
begin
    if precio > 1000 then
        return CONCAT("Tu precio con el descuento es de:", (precio + (precio*iva) ) - ( (precio + (precio * iva) ) * 0.2) );
    else
        return CONCAT("Tu precio completo es de:", precio + (precio*iva) );
    end if;
end//

delimiter ;

-- Eliminar una funcion
drop function total_con_iva;

-- Utilizar la funcion total_con_iva 
select total_con_iva(25000, 0.19);

-- Extrapolar función con datos de la base de datos
select total_con_iva(precio,0.19) from productos;

-- Funcion para obtener el precio de un producto dado su nombre
delimiter // 
create function obtener_precio_producto(nombre_producto varchar(100))
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

-- funcion para calcular el precio promedio de todos los productos
delimiter //
create function precio_promedio_productos()
returns decimal(10,2)
deterministic
begin
	declare promedio decimal(10,2);
    select avg(precio) into promedio from productos;
    return promedio;
end //
delimiter ;

-- Usar fución
select precio_promedio_productos();


-- ################################################################################
-- ################## Procedimiento para insertar un nuevo producto ###############
-- ################################################################################

delimiter //
create procedure insertar_producto(in nombre_producto varchar(100)
, in precio_producto decimal(10,2))
begin
	insert into productos (nombre,precio)
    values (nombre_producto,precio_producto);
end //
delimiter ;

call insertar_producto('Gorra', 50000.00);

-- Crear procedimiento para eliminar un producto dado su nombre
delimiter //
create procedure eliminar_producto(in nombre_producto varchar(100))
begin 
	delete from productos where nombre = nombre_producto;
end //
delimiter ;

-- Para que funcione hay que desactivar una funcion de workbench
call eliminar_producto('Gorra');



select * from productos;

-- Desarrollado por Hernan Mendez / 1101685607