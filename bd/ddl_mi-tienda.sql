/*
CREATE SCHEMA referencial;
CREATE SCHEMA dimension;
CREATE SCHEMA hechos;

drop SCHEMA referencial;
drop SCHEMA dimension;
drop SCHEMA hechos; 

*/

drop table hechos.venta;
drop table hechos.visita;
drop table dimension.pedido;
drop table dimension.tienda;
drop table dimension.producto;
drop table dimension.cliente;
drop table dimension.barrio;
drop table dimension.empresa;
drop table dimension.geografia;
drop table dimension.tiempo;
drop table dimension.estado;






create table dimension.estado
(
id_estado bigserial not null,
descripcion varchar(255) NULL,
primary key (id_estado)
);






create table dimension.geografia
(
id_geografia bigserial not null,
id_pais varchar(2) not null,
pais varchar(50) not null,
departamento varchar(50) not null,
ciudad varchar(50) not null,
primary key (id_geografia)
);





create table dimension.empresa
(
id_empresa bigserial not null,
id_geografia bigserial not null,
tipo varchar(1) not null,
nit varchar(50) null,
nombre varchar(255) not null,
id_estado bigserial not null,
primary key (id_empresa)
);

ALTER TABLE dimension.empresa ADD CONSTRAINT empresa_geografia_fk FOREIGN KEY (id_geografia) REFERENCES dimension.geografia (id_geografia);
ALTER TABLE dimension.empresa ADD CONSTRAINT empresa_estado_fk FOREIGN KEY (id_estado) REFERENCES dimension.estado (id_estado);




create table dimension.tiempo
(
id_tiempo integer not null,
fecha date not null,
año smallint not null,
semestre smallint not null,
trimestre smallint not null,
mes smallint not null,
mes_nombre varchar(10) null,
semana smallint not null,
dia_semana varchar(10) null,
fecha_inicio_año date not null,
fecha_fin_año date not null,
fecha_inicio_semestre date not null,
fecha_fin_semestre date not null,
fecha_inicio_trimestre date not null,
fecha_fin_trimestre date not null,
fecha_inicio_mes date not null,
fecha_fin_mes date not null,
fecha_inicio_semana date not null,
fecha_fin_semana date not null,
primary key (id_tiempo)
);







create table dimension.tienda
(
id_tienda bigserial not null,
id_geografia bigserial not null,
id_tiempo_fecha_creacion integer DEFAULT cast(to_char(now(), 'YYYYMMDD') as integer) not null,
nit varchar(50) not null,
nombre varchar(255) not null,
password varchar(255) not null,
direccion varchar(255) not null,
telefono varchar(50) not null,
estado smallint default 1 not null,
primary key (id_tienda)
);

ALTER TABLE dimension.tienda ADD CONSTRAINT tienda_geografia_fk FOREIGN KEY (id_geografia) REFERENCES dimension.geografia (id_geografia);
ALTER TABLE dimension.tienda ADD CONSTRAINT tienda_tiempo_fk FOREIGN KEY (id_tiempo_fecha_creacion) REFERENCES dimension.tiempo (id_tiempo);





create table dimension.producto
(
id_producto bigserial not null,
id_empresa bigserial not null,
id_catalogo smallint not null,
categoria_nivel1 varchar(100) not null,
categoria_nivel2 varchar(100) null,
categoria_nivel3 varchar(100) null,
categoria_nivel4 varchar(100) null,
categoria_nivel5 varchar(100) null,
ean varchar(100) not null,
nombre varchar(100) not null,
nivel smallint not null,
precio numeric(8,2) null,
id_estado bigserial not null,
primary key (id_producto)
);

ALTER TABLE dimension.producto ADD CONSTRAINT producto_empresa_fk FOREIGN KEY (id_empresa) REFERENCES dimension.empresa (id_empresa);
ALTER TABLE dimension.producto ADD CONSTRAINT producto_estado_fk FOREIGN KEY (id_estado) REFERENCES dimension.estado (id_estado);





create table dimension.barrio
(
id_barrio bigserial not null,
nombre varchar(255) not null,
primary key (id_barrio)
);




create table dimension.cliente
(
id_cliente bigserial not null,
id_barrio bigserial not null,
id_tiempo_fecha_creacion integer DEFAULT cast(to_char(now(), 'YYYYMMDD') as integer) not null,
cedula varchar(20) null,
nombre varchar(255) not null,
telefono varchar(50) not null,
direccion varchar(255) null,
email varchar(100) null,
fecha_nacimiento date null,
sexo varchar(1) not null,
tipo_cliente varchar(10) not null,
password varchar(255) null,
barrio varchar(255) null,
primary key (id_cliente)
);

ALTER TABLE dimension.cliente ADD CONSTRAINT cliente_barrio_fk FOREIGN KEY (id_barrio) REFERENCES dimension.barrio (id_barrio);
ALTER TABLE dimension.cliente ADD CONSTRAINT cliente_tiempo_fk FOREIGN KEY (id_tiempo_fecha_creacion) REFERENCES dimension.tiempo (id_tiempo);
alter table dimension.cliente alter column id_barrio drop not null;






create table dimension.pedido
(
id_pedido bigserial not null,
id_tienda bigserial not null,
id_estado bigserial not null,
fecha_pedido TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP not null,
primary key (id_pedido)
);

ALTER TABLE dimension.pedido ADD CONSTRAINT pedido_tienda_fk FOREIGN KEY (id_tienda) REFERENCES dimension.tienda (id_tienda);
ALTER TABLE dimension.pedido ADD CONSTRAINT pedido_estado_fk FOREIGN KEY (id_estado) REFERENCES dimension.estado (id_estado);
alter table dimension.pedido alter column id_tienda drop not null;



create table hechos.venta
(
id_venta bigserial not null,
id_pedido bigserial not null,
id_producto bigserial not null,
id_cliente bigserial not null,
id_tiempo integer DEFAULT cast(to_char(now(), 'YYYYMMDD') as integer) not null,
cantidad smallint not null,
valor numeric(8,2) not null,
primary key (id_venta)
);

ALTER TABLE hechos.venta ADD CONSTRAINT venta_pedido_fk FOREIGN KEY (id_pedido) REFERENCES dimension.pedido (id_pedido);
ALTER TABLE hechos.venta ADD CONSTRAINT venta_producto_fk FOREIGN KEY (id_producto) REFERENCES dimension.producto (id_producto);
ALTER TABLE hechos.venta ADD CONSTRAINT venta_cliente_fk FOREIGN KEY (id_cliente) REFERENCES dimension.cliente (id_cliente);
ALTER TABLE hechos.venta ADD CONSTRAINT venta_tiempo_fk FOREIGN KEY (id_tiempo) REFERENCES dimension.tiempo (id_tiempo);





/*
create table hechos.venta
(
id_pedido bigserial not null,
id_tienda bigserial not null,
id_producto bigserial not null,
id_cliente bigserial not null,
id_tiempo integer DEFAULT cast(to_char(now(), 'YYYYMMDD') as integer) not null,
id_estado bigserial not null,
cantidad smallint not null,
valor numeric(8,2) not null,
fecha_pedido TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP not null,
primary key (id_pedido)
);


ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_tienda_fk FOREIGN KEY (id_tienda) REFERENCES dimension.tienda (id_tienda);
ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_producto_fk FOREIGN KEY (id_producto) REFERENCES dimension.producto (id_producto);
ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY (id_cliente) REFERENCES dimension.cliente (id_cliente);
ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_tiempo_fk FOREIGN KEY (id_tiempo) REFERENCES dimension.tiempo (id_tiempo);
ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_estado_fk FOREIGN KEY (id_estado) REFERENCES dimension.estado (id_estado);
alter table hechos.pedido alter column id_tienda drop not null;*/




create table hechos.visita
(
id_visita bigserial not null,
id_cliente bigserial not null,
id_tienda bigserial not null,
id_tiempo integer DEFAULT cast(to_char(now(), 'YYYYMMDD') as integer) not null,
temperatura numeric(4,2) not null,
fecha_visita TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP not null,
primary key (id_visita)
);


ALTER TABLE hechos.visita ADD CONSTRAINT visita_cliente_fk FOREIGN KEY (id_cliente) REFERENCES dimension.cliente (id_cliente);
ALTER TABLE hechos.visita ADD CONSTRAINT visita_tiempo_fk FOREIGN KEY (id_tiempo) REFERENCES dimension.tiempo (id_tiempo);
ALTER TABLE hechos.visita ADD CONSTRAINT visita_tienda_fk FOREIGN KEY (id_tienda) REFERENCES dimension.tienda (id_tienda);


SET timezone TO 'America/Bogota';



insert into dimension.geografia(id_pais,pais,departamento,ciudad) values('CO','Colombia','Valle del Cauca','Cali');
insert into dimension.geografia(id_pais,pais,departamento,ciudad) values('CO','Colombia','Nariño','Pasto');
insert into dimension.barrio(nombre) values('Valle de Lili');
INSERT INTO dimension.tiempo SELECT * FROM dimension.tiempo2;
insert into dimension.tienda(id_geografia,id_tiempo_fecha_creacion,nit,nombre,password,direccion,telefono) values(2,20200701,'900.317.814-5','unicentro','1234','Calle 11 Nº 34-78 Barrio La Aurora de Pasto','3104709828');
insert into dimension.tienda(id_geografia,id_tiempo_fecha_creacion,nit,nombre,password,direccion,telefono) values(1,20200702,'777','Plazolete Lili','1234','Calle 45 # 100 39','3333333');
insert into dimension.estado(id_estado, descripcion) values(100, 'PENDIENTE');
insert into dimension.estado(id_estado, descripcion) values(101, 'ACEPTADO');
insert into dimension.estado(id_estado, descripcion) values(102, 'RECHAZADO');
insert into dimension.estado(id_estado, descripcion) values(103, 'ACTIVO');
insert into dimension.estado(id_estado, descripcion) values(104, 'INACTIVO');
insert into dimension.empresa(id_empresa, id_geografia, tipo, nit, nombre, id_estado) values(100, 1, 'F', '1010', 'Coca Cola', 103);
insert into dimension.empresa(id_empresa, id_geografia, tipo, nit, nombre, id_estado) values(101, 1, 'F', '1010', 'Corner Burger', 103);
insert into dimension.empresa(id_empresa, id_geografia, tipo, nit, nombre, id_estado) values(102, 1, 'F', '1010', 'Cheers', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, categoria_nivel2, ean, nombre, nivel, precio, id_estado) values(100, 100, 100, 'Bebidas', 'Gaseosas', 'ean-cocacola', 'Coca Cola', 2, 1500, 103);
insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, precio, id_estado) values(101, 101, 100, 'Hamburguesas', 'ean-callejera', 'Callejera', 1, 12000, 103);
insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, categoria_nivel2, ean, nombre, nivel, precio, id_estado) values(102, 102, 100, 'Pizzas', 'Tradicional', 'ean-vegetariana', 'Vegana', 2, 21500, 103);







select * from dimension.empresa;

select * from dimension.tienda;

select * from dimension.geografia;

select * from dimension.tiempo;

select * from dimension.barrio;

select * from dimension.estado;

select * from dimension.producto;

select * from dimension.cliente order by 1;

select * from hechos.visita order by 2;


select * from dimension.pedido;

select * from hechos.venta;



select v.id_venta, p.id_pedido, t.nombre tienda, pro.nombre producto, v.cantidad, v.valor, c.nombre cliente, p.fecha_pedido, e.descripcion estado
from hechos.venta v 
inner join dimension.pedido p on p.id_pedido = v.id_pedido
inner join dimension.producto pro on pro.id_producto = v.id_producto
inner join dimension.cliente c on c.id_cliente = v.id_cliente
left outer join dimension.tienda t on t.id_tienda = p.id_tienda
inner join dimension.estado e on e.id_estado = p.id_estado
;


delete from hechos.visita;-- where id_cliente = 3;
delete from dimension.cliente;-- where id_cliente <> 22;



--create table dimension.tiempo2 as (select * from dimension.tiempo);


*/
