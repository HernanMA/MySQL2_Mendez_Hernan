show databases;

USE Dia7_MySQL2;

create table oficina (
	codigo_oficina varchar(10) primary key,
    ciudad varchar(30) not null,
    pais varchar(50) not null,
    region varchar(50) null,
    codigo_postal varchar(10) not null,
    telefono varchar(20) not null,
    linea_direccion1 varchar(50) not null,
    linea_direccion2 varchar(50) null
);

create table empleado (
	codigo_empleado int(11) primary key,
    nombre varchar(50) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(50) null,
    extension varchar(10) not null,
    email varchar(100) not null,
    codigo_oficina varchar(10) not null,
    foreign key (codigo_oficina) references oficina(codigo_oficina),
    codigo_jefe int(11) null,
    foreign key (codigo_jefe) references empleado(codigo_empleado),
    puesto varchar(50) null
);

create table gama_producto (
	gama varchar(50) primary key,
    descripcion_texto text null,
    descripcion_html text null,
    imagen varchar(256) null
);

create table producto (
	codigo_producto varchar(15) primary key,
    nombre varchar(70) not null,
    gama  varchar(50) not null,
    foreign key (gama) references gama_producto(gama),
    dimensiones varchar(25) null,
    proveedor varchar(50),
    descripcion text null,
    cantidad_en_stock smallint(6) not null,
    precio_venta decimal(15,2) not null,
    precio_proveedor decimal(15,2) null
);

create table cliente (
	codigo_cliente int(11) primary key,
    nombre_cliente varchar(50) not null,
    nombre_contacto varchar(30) null,
    apellido_contacto varchar(30) null,
    telefono varchar(15) not null,
    fax varchar(15) not null,
    linea_direccion1 varchar(50) not null,
    linea_direccion2 varchar(50) null,
    ciudad varchar(50) not null,
    region varchar(50) null,
    pais varchar(50) null,
    codigo_postal varchar(10) null,
    codigo_empleado_rep_ventas int(11) null,
    foreign key (codigo_empleado_rep_ventas) references empleado(codigo_empleado),
    limite_credito decimal (15,2) null
);

create table pedido (
	codigo_pedido int(11) primary key,
    fecha_pedido date not null,
    fecha_esperada date not null,
    fecha_entrega date null,
    estado varchar(15) not null,
    comentarios text null,
    codigo_cliente int(11) not null,
    foreign key (codigo_cliente) references cliente(codigo_cliente)
);

create table detalle_pedido (
	codigo_pedido int(11) not null,
    codigo_producto varchar(15) not null,
    foreign key (codigo_pedido) references pedido(codigo_pedido),
    foreign key (codigo_producto) references producto(codigo_producto),
    cantidad int(11) not null,
    precio_unidad decimal(15,2) not null,
    numero_linea smallint(6)
);

create table pago (
	codigo_cliente int(11) not null,
    forma_pago varchar(40) not null,
    id_transaccion varchar(50) primary key,
    fecha_pago date not null,
    total decimal(15,2) not null,
    foreign key (codigo_cliente) references cliente(codigo_cliente)
);

show tables;

-- 1- Escribe una consulta que permita agrupar los clientes de todos los empleados
-- cuyo puesto sea responsable de ventas. Se requiere que la consulta muestre:
-- Nombre del cliente, teléfono, la ciudad, nombre y primer apellido del responsable
-- de ventas y su email.
-- Crear un índice para optimizar la búsqueda por puesto
CREATE INDEX idx_puesto ON empleado(puesto);

SELECT 
    c.nombre_cliente, 
    c.telefono, 
    c.ciudad, 
    e.nombre, 
    e.apellido1, 
    e.email
FROM 
    cliente c
JOIN 
    empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE 
    e.puesto = 'Representante Ventas';


-- 2- Se necesita obtener los registros de los pedidos entre el 15 de marzo del 2009 y
-- el 15 de julio del 2009, para todos los clientes que sean de la ciudad de
-- Sotogrande. Se requiere mostrar el código del pedido, la fecha del pedido, fecha
-- de entrega, estado, los comentarios y el condigo del cliente que realizo dicho pedido.
-- Crear índices para optimizar las búsquedas por fecha y ciudad
CREATE INDEX idx_fecha_pedido ON pedido(fecha_pedido);
CREATE INDEX idx_ciudad_cliente ON cliente(ciudad);

SELECT 
    p.codigo_pedido, 
    p.fecha_pedido, 
    p.fecha_entrega, 
    p.estado, 
    p.comentarios, 
    p.codigo_cliente,
    c.ciudad
FROM 
    pedido p
JOIN 
    cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE 
    p.fecha_pedido BETWEEN '2009-03-15' AND '2009-07-15'
    AND c.ciudad = 'Sotogrande';


-- 3- Se desea obtener los productos cuya gama pertenezca a las frutas y que el
-- proveedor sea Frutas Talaveras S.A, se desea mostrar el código, nombre,
-- descripción, cantidad en stock, y su precio con 10% de descuento, de igual forma
-- se pide la cantidad en los distintos pedidos que se han hecho.
-- Crear índices para optimizar las búsquedas por gama y proveedor
CREATE INDEX idx_gama_producto ON producto(gama);
CREATE INDEX idx_proveedor_producto ON producto(proveedor);

SELECT 
    pr.codigo_producto, 
    pr.nombre, 
    pr.descripcion, 
    pr.cantidad_en_stock, 
    pr.precio_venta * 0.9 AS precio_con_descuento, 
    dp.cantidad
FROM 
    producto pr
JOIN 
    detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto
WHERE 
    pr.gama = 'Frutales' 
    AND pr.proveedor = 'Frutales Talavera S.A';



-- Desarrollado por Hernan Mendez  /    1101685607