/*
CREATE SCHEMA referencial;
CREATE SCHEMA dimension;
CREATE SCHEMA hechos;

drop SCHEMA referencial;
drop SCHEMA dimension;
drop SCHEMA hechos; 

*/

drop table hechos.pedido;
drop table hechos.visita;
drop table dimension.estado;
drop table dimension.tienda;
drop table dimension.producto;
drop table dimension.cliente;
drop table dimension.barrio;
drop table dimension.empresa;
drop table dimension.geografia;
drop table dimension.tiempo;






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
estado smallint not null,
primary key (id_empresa)
);

ALTER TABLE dimension.empresa ADD CONSTRAINT empresa_geografia_fk FOREIGN KEY (id_geografia) REFERENCES dimension.geografia (id_geografia);




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
--alter table dimension.tienda alter column id_tiempo_fecha_creacion drop not null;




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
estado smallint not null,
primary key (id_producto)
);

ALTER TABLE dimension.producto ADD CONSTRAINT producto_empresa_fk FOREIGN KEY (id_empresa) REFERENCES dimension.empresa (id_empresa);







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
--alter table dimension.cliente alter column id_tiempo_fecha_creacion drop not null;




create table hechos.pedido
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
insert into dimension.tienda(id_geografia,id_tiempo_fecha_creacion,nit,nombre,password,direccion,telefono) values(1,20200702,'777','centro comercial unico','1234','Salomia','3333333');

insert into dimension.tienda(id_geografia,id_tiempo_fecha_creacion,nit,nombre,password,direccion,telefono) values(1,20200702,'888','centro comercial la 14','1234','Lili','44444');





select * from dimension.tienda;

select * from dimension.geografia;

select * from dimension.tiempo;

select * from dimension.barrio;

select * from dimension.cliente order by 1;

select * from hechos.visita order by 2;


select * 
from dimension.cliente c, hechos.visita v
where c.id_cliente = v.id_cliente
--and c.cedula = '2'
--and v.id_tienda = 2
and c.cedula = '4'
order by 1
;


delete from hechos.visita;-- where id_cliente = 3;
delete from dimension.cliente; --where id_cliente = 3;







--create table dimension.tiempo2 as (select * from dimension.tiempo);

--delete from dimension.cliente; 
*/
