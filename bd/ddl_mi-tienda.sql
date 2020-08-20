/*
CREATE SCHEMA referencial;
CREATE SCHEMA dimension;
CREATE SCHEMA hechos;


drop SCHEMA referencial;
drop SCHEMA dimension;
drop SCHEMA hechos; 
*/




drop table hechos.visita;
drop table dimension.producto_pedido;
drop table hechos.pedido;
drop table dimension.producto;
drop table dimension.cliente;
drop table dimension.barrio;
drop table dimension.empresa;
drop table dimension.geografia;
--drop table dimension.tiempo;
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
id_geografia bigint not null,
tipo varchar(1) not null,
nit varchar(50) null,
nombre varchar(255) not null,
id_estado bigint not null,
primary key (id_empresa)
);

ALTER TABLE dimension.empresa ADD CONSTRAINT empresa_geografia_fk FOREIGN KEY (id_geografia) REFERENCES dimension.geografia (id_geografia);
ALTER TABLE dimension.empresa ADD CONSTRAINT empresa_estado_fk FOREIGN KEY (id_estado) REFERENCES dimension.estado (id_estado);



/*
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
*/



create table dimension.barrio
(
id_barrio bigserial not null,
nombre varchar(255) not null,
primary key (id_barrio)
);




create table dimension.cliente
(
id_cliente bigserial not null,
id_geografia bigint null,
id_barrio bigint null,
id_tiempo_fecha_creacion integer DEFAULT cast(to_char(NOW()::timestamp, 'YYYYMMDD') as integer) not null,
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
estado smallint default 1 not null,
primary key (id_cliente)
);

ALTER TABLE dimension.cliente ADD CONSTRAINT cliente_barrio_fk FOREIGN KEY (id_barrio) REFERENCES dimension.barrio (id_barrio);
ALTER TABLE dimension.cliente ADD CONSTRAINT cliente_tiempo_fk FOREIGN KEY (id_tiempo_fecha_creacion) REFERENCES dimension.tiempo (id_tiempo);
--alter table dimension.cliente alter column id_barrio drop not null;
ALTER TABLE dimension.cliente ADD CONSTRAINT cliente_geografia_fk FOREIGN KEY (id_geografia) REFERENCES dimension.geografia (id_geografia);
--alter table dimension.cliente alter column id_geografia drop not null;




create table dimension.producto
(
id_producto bigserial not null,
id_empresa bigint not null,
id_catalogo smallint not null,
id_estado bigint not null,
categoria_nivel1 varchar(100) not null,
categoria_nivel2 varchar(100) null,
categoria_nivel3 varchar(100) null,
categoria_nivel4 varchar(100) null,
categoria_nivel5 varchar(100) null,
ean varchar(100) not null,
nombre varchar(100) not null,
nivel smallint not null,
valor numeric(8,2) null,
url_imagen_categoria varchar(4000) null,
url_imagen_producto varchar(4000) null,
primary key (id_producto)
);

ALTER TABLE dimension.producto ADD CONSTRAINT producto_empresa_fk FOREIGN KEY (id_empresa) REFERENCES dimension.empresa (id_empresa);
ALTER TABLE dimension.producto ADD CONSTRAINT producto_estado_fk FOREIGN KEY (id_estado) REFERENCES dimension.estado (id_estado);





create table hechos.pedido
(
id_pedido bigserial not null,
id_tienda bigint null,
id_cliente bigint not null,
id_estado bigint not null,
fecha_pedido TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP not null,
id_tiempo integer DEFAULT cast(to_char(now(), 'YYYYMMDD') as integer) not null,
primary key (id_pedido)
);

ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_tienda_fk  FOREIGN KEY (id_cliente) REFERENCES dimension.cliente (id_cliente);
ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY (id_cliente) REFERENCES dimension.cliente (id_cliente);
ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_estado_fk FOREIGN KEY (id_estado) REFERENCES dimension.estado (id_estado);
ALTER TABLE hechos.pedido ADD CONSTRAINT pedido_tiempo_fk FOREIGN KEY (id_tiempo) REFERENCES dimension.tiempo (id_tiempo);
--alter table hechos.pedido alter column id_tienda drop not null;



create table dimension.producto_pedido
(
id_producto_pedido bigserial not null,
id_pedido bigint not null,
id_producto bigint not null,
cantidad smallint not null,
valor numeric(8,2) not null,
primary key (id_producto_pedido)
);

ALTER TABLE dimension.producto_pedido ADD CONSTRAINT productopedido_pedido_fk FOREIGN KEY (id_pedido) REFERENCES hechos.pedido (id_pedido);
ALTER TABLE dimension.producto_pedido ADD CONSTRAINT productopedido_producto_fk FOREIGN KEY (id_producto) REFERENCES dimension.producto (id_producto);








create table hechos.visita
(
id_visita bigserial not null,
id_cliente bigint not null,
id_tienda bigint not null,
id_tiempo integer DEFAULT cast(to_char(now(), 'YYYYMMDD') as integer) not null,
temperatura numeric(4,2) not null,
fecha_visita TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP not null,
primary key (id_visita)
);


ALTER TABLE hechos.visita ADD CONSTRAINT visita_cliente_fk FOREIGN KEY (id_cliente) REFERENCES dimension.cliente (id_cliente);
ALTER TABLE hechos.visita ADD CONSTRAINT visita_tienda_fk  FOREIGN KEY (id_cliente) REFERENCES dimension.cliente (id_cliente);
ALTER TABLE hechos.visita ADD CONSTRAINT visita_tiempo_fk  FOREIGN KEY (id_tiempo) REFERENCES dimension.tiempo (id_tiempo);


SET timezone TO 'America/Bogota';



commit;

insert into dimension.geografia(id_pais,pais,departamento,ciudad) values('CO','Colombia','Valle del Cauca','Cali');
insert into dimension.geografia(id_pais,pais,departamento,ciudad) values('CO','Colombia','Nariño','Pasto');
insert into dimension.barrio(nombre) values('Valle de Lili');
insert into dimension.cliente (id_geografia,id_tiempo_fecha_creacion,cedula,nombre,password,direccion,telefono, email, tipo_cliente, sexo, id_barrio, barrio ) values(2,20200701,'900.317.814-5','unicentro','1234','Calle 11 Nº 34-78 Barrio La Aurora de Pasto','3104709828', 'unicentro@unicentro.com', 'tienda', 'M', 1, 'Valle de Lili');
insert into dimension.cliente (id_geografia,id_tiempo_fecha_creacion,cedula,nombre,password,direccion,telefono, email, tipo_cliente, sexo, id_barrio, barrio ) values(1,20200702,'777','Plazolete Lili','1234','Calle 45 # 100 39','3333333', 'plazoleta@gmail.com', 'tienda', 'M', 1, 'Valle de Lili');
insert into dimension.estado(id_estado, descripcion) values(100, 'PENDIENTE');
insert into dimension.estado(id_estado, descripcion) values(101, 'ACEPTADO');
insert into dimension.estado(id_estado, descripcion) values(102, 'CANCELADO');
insert into dimension.estado(id_estado, descripcion) values(103, 'ACTIVO');
insert into dimension.estado(id_estado, descripcion) values(104, 'INACTIVO');
insert into dimension.estado(id_estado, descripcion) values(105, 'DESPACHADO');
insert into dimension.empresa(id_empresa, id_geografia, tipo, nit, nombre, id_estado) values(100, 1, 'F', '1010', 'Coca Cola', 103);
insert into dimension.empresa(id_empresa, id_geografia, tipo, nit, nombre, id_estado) values(101, 1, 'F', '1010', 'Corner Burger', 103);
insert into dimension.empresa(id_empresa, id_geografia, tipo, nit, nombre, id_estado) values(102, 1, 'F', '1010', 'Cheers', 103);
commit;


insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(100, 101, 100, 'American', 'ean-Beef Grill', 'Beef Grill', 1, 24, 'http://tutofox.com/foodapp//categories/american.png', 'http://tutofox.com/foodapp//food/american/beef-grill.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(101, 101, 100, 'American', 'ean-Chicken Picatta', 'Chicken Picatta', 1, 20, 'http://tutofox.com/foodapp//categories/american.png', 'http://tutofox.com/foodapp//food/american/chicken-piccata.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(102, 101, 100, 'American', 'ean-Chicken Romesco', 'Chicken Romesco', 1, 21, 'http://tutofox.com/foodapp//categories/american.png', 'http://tutofox.com/foodapp//food/american/chicken-romesco.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(103, 101, 100, 'American', 'ean-Chicken Grill', 'Chicken Grill', 1, 22, 'http://tutofox.com/foodapp//categories/american.png', 'http://tutofox.com/foodapp//food/american/chicken-grill.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(104, 101, 100, 'American', 'ean-Salmon Grill', 'Salmon Grill', 1, 26, 'http://tutofox.com/foodapp//categories/american.png', 'http://tutofox.com/foodapp//food/american/salmon-grill.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(105, 101, 100, 'American', 'ean-Salmon Romesco', 'Salmon Romesco', 1, 25, 'http://tutofox.com/foodapp//categories/american.png', 'http://tutofox.com/foodapp//food/american/salmon-romesco', 103);




insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(106, 101, 100, 'Burger', 'ean-Burger Home', 'Burger Home', 1, 16, 'http://tutofox.com/foodapp//categories/burger.png', 'http://tutofox.com/foodapp//food/burger/burger-1.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(107, 101, 100, 'Burger', 'ean-MegaBurger', 'MegaBurger', 1, 16, 'http://tutofox.com/foodapp//categories/burger.png', 'http://tutofox.com/foodapp//food/burger/burger-2.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(108, 101, 100, 'Burger', 'ean-Burger Special', 'Burger Special', 1, 17, 'http://tutofox.com/foodapp//categories/burger.png', 'http://tutofox.com/foodapp//food/burger/burger-3.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(109, 101, 100, 'Burger', 'ean-Burger Cheese', 'Burger Cheese', 1, 18, 'http://tutofox.com/foodapp//categories/burger.png', 'http://tutofox.com/foodapp//food/burger/burger-4.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(110, 101, 100, 'Burger', 'ean-Burger Farmer', 'Burger Farmer', 1, 19, 'http://tutofox.com/foodapp//categories/burger.png', 'http://tutofox.com/foodapp//food/burger/burger-5.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(111, 101, 100, 'Burger', 'ean-Mini Burger', 'Mini Burger', 1, 10, 'http://tutofox.com/foodapp//categories/burger.png', 'http://tutofox.com/foodapp//food/burger/burger-6.png', 103);


insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(112, 101, 100, 'Pizza', 'ean-Pizza Vegan', 'Pizza Vegan', 1, 14, 'http://tutofox.com/foodapp//categories/pizza.png', 'http://tutofox.com/foodapp//food/pizza/pizza-1.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(113, 101, 100, 'Pizza', 'ean-Pizza Bufalisimo', 'Pizza Bufalisimo', 1, 15, 'http://tutofox.com/foodapp//categories/pizza.png', 'http://tutofox.com/foodapp//food/pizza/pizza-2.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(114, 101, 100, 'Pizza', 'ean-Pizza Haiwaiana', 'Pizza Haiwaiana', 1, 16, 'http://tutofox.com/foodapp//categories/pizza.png', 'http://tutofox.com/foodapp//food/pizza/pizza-3.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(115, 101, 100, 'Pizza', 'ean-Pizza Peperoni', 'Pizza Peperoni', 1, 17, 'http://tutofox.com/foodapp//categories/pizza.png', 'http://tutofox.com/foodapp//food/pizza/pizza-4.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(116, 101, 100, 'Pizza', 'ean-Pizza Vegan 2', 'Pizza Vegan 2', 1, 33, 'http://tutofox.com/foodapp//categories/pizza.png', 'http://tutofox.com/foodapp//food/pizza/pizza-5.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(117, 101, 100, 'Pizza', 'ean-Pizza Napolitana', 'Pizza Napolitana', 1, 30, 'http://tutofox.com/foodapp//categories/pizza.png', 'http://tutofox.com/foodapp//food/pizza/pizza-6.png', 103);


insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(118, 101, 100, 'Drink', 'ean-Coca cola', 'Coca cola', 1, 30, 'http://tutofox.com/foodapp//categories/drink.png', 'http://tutofox.com/foodapp//food/drink/cocacola.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(119, 101, 100, 'Drink', 'ean-Pepsi', 'Pepsi', 1, 30, 'http://tutofox.com/foodapp//categories/drink.png', 'http://tutofox.com/foodapp//food/drink/pepsi.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(120, 101, 100, 'Drink', 'ean-Quatro', 'Quatro', 1, 30, 'http://tutofox.com/foodapp//categories/drink.png', 'http://tutofox.com/foodapp//food/drink/quatro.png', 103);

insert into dimension.producto(id_producto, id_empresa, id_catalogo, categoria_nivel1, ean, nombre, nivel, valor, url_imagen_categoria, url_imagen_producto, id_estado) values(121, 101, 100, 'Drink', 'ean-Sprite', 'Sprite', 1, 30, 'http://tutofox.com/foodapp//categories/drink.png', 'http://tutofox.com/foodapp//food/drink/sprite.png', 103);


commit;



select * from dimension.cliente order by 1 desc;

select * from dimension.cliente where sexo = '' or sexo is null order by 1 desc;

update dimension.cliente set sexo = 'M' where id_cliente in(3554,3525);

update dimension.cliente set sexo = 'F' where sexo = '';


select * from dimension.empresa;

select * from dimension.geografia;

select * from dimension.tiempo;

select * from dimension.barrio;

select * from dimension.estado;

select * from dimension.producto;

select * from dimension.cliente order by 1 desc;

select * from hechos.visita order by 2;


update hechos.pedido set id_tienda = null, id_estado = 100 where id_pedido in (1,2,3,4,5,6,7);



select * from hechos.pedido;

select * from dimension.producto_pedido;

truncate table hechos.pedido;

delete from dimension.cliente where id_cliente > 4;

select p.id_pedido, t.nombre tienda, pro.nombre producto, pp.cantidad, pp.valor, c.nombre cliente, p.fecha_pedido, e.descripcion estado, e.id_estado 
from hechos.pedido p 
inner join dimension.producto_pedido pp on pp.id_pedido = p.id_pedido
inner join dimension.producto pro on pro.id_producto = pp.id_producto
inner join dimension.cliente c on c.id_cliente = p.id_cliente
left outer join dimension.cliente t on t.id_cliente = p.id_tienda
inner join dimension.estado e on e.id_estado = p.id_estado
where 1=1
--and p.id_tienda is null
--and p.id_pedido = 14
;


--Usuario: registrounicentropasto@gmail.com
--Clave: Registrounicentropasto*2020




select count(1) from dimension.cliente c where c.id_tiempo_fecha_creacion = 20200819
union all
select count(1) from hechos.visita v where v.id_tiempo = 20200819;



SELECT * --table_name AS "Tabla", ROUND(((data_length + index_length) / 1024 / 1024), 2) AS "Tamaño (MB)"
FROM information_schema.TABLES
--WHERE table_schema in ("dimension", "hechos")
--ORDER BY (data_length + index_length) DESC
;  




GRANT ALL PRIVILEGES ON DATABASE dbg8dhdal4qvec TO vrhygmcmqapxkw;

SELECT
pg_database.datname,
pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database;

--delete from hechos.visita;-- where id_cliente = 3;
--delete from dimension.cliente;-- where id_cliente <> 22;



--create table dimension.tiempo2 as (select * from dimension.tiempo);
--create table dimension.cliente2 as (select * from dimension.cliente);


--nextval('dimeid_clientension.cliente_id_cliente_seq'::regclass)

--select nextval('dimension.cliente_id_cliente_seq');

--SELECT * FROM pg_class c WHERE c.relkind = 'S';

select sum(numero_registros) 
from (
select count(1) as numero_registros from dimension.barrio
union all
select count(1) as numero_registros from dimension.cliente
union all
select count(1) as numero_registros from dimension.empresa
union all
select count(1) as numero_registros from dimension.estado
union all
select count(1) as numero_registros from dimension.geografia
union all
select count(1) as numero_registros from dimension.producto
union all
select count(1) as numero_registros from dimension.producto_pedido
union all
select count(1) as numero_registros from dimension.tiempo
union all
select count(1) as numero_registros from dimension.tienda
union all
select count(1) as numero_registros from hechos.pedido
union all
select count(1) as numero_registros from hechos.visita
) as tabla
;






npm i @stomp/stompjs


delete from hechos.visita where id_cliente in (3335,3338);
delete from dimension.cliente  where id_cliente in (3335,3338);

select * from hechos.visita 
where 1=1
and id_tiempo = 20200812
--and id_cliente = 3208
order by 1 desc;


select * from dimension.cliente 
where tipo_cliente= 'covid'
--and (sexo = '' or sexo is null)
--and cedula = '2'
--and (barrio is null or barrio = '')
order by 1 asc;

--59813483


SELECT count(id_visita) FROM hechos.visita WHERE id_tiempo = 20200811;

select 
count( v.id_visita ) 
--c.cedula, c.nombre, c.telefono, c.sexo, c.barrio, v.temperatura, v.fecha_visita, v.id_tiempo, c.barrio 
from hechos.visita v, dimension.cliente c
where v.id_cliente = c.id_cliente 
and c.tipo_cliente = 'covid'
and v.id_tiempo = 20200811
--and c.sexo = 'F'
--and c.cedula = '13072207'
--order by v.fecha_visita desc
;






https://unicentrobi1.us.qlikcloud.com

Email: asesor1biteam1@gmail.com	

Password: Asesor1biteam1










<Container>
        <Content contentContainerStyle={styles.contentProductos}>
          <View style={styles.viewBanner}>
            <Swiper style={styles.swiperBanner} showsButtons={false} autoplay={false} autoplayTimeout={2}>
            {
              this.state.arrayBanner.map((banner, index)=>
              {
                return( <Image style={styles.imageBanner} resizeMode="contain" source={{uri: banner}} key={index}/> )
              })
            }
            </Swiper>
            <View style={{height:20}	} />
          </View>

          <View style={styles.viewCategoriasProductos}>
            <FlatList
              data={this.state.arrayCategorias}
              renderItem={ ({ item }) => this.visualizarCategorias(item) }
              horizontal={ true }
              keyExtractor={ (item) => item.idCategoria.toString() }
            />

            <FlatList 
              data={this.state.arrayProductos}
              renderItem={ ({ item }) => this.visualizarProductos(item) }
              numColumns={2}
              keyExtractor={ (item) => item.idProducto.toString() }
            />
          </View>
        </Content>
      </Container>
      
      
      
      
      <FlatList
        ListHeaderComponent=
        {(
          <>
            <Content contentContainerStyle={styles.contentProductos}>
              <View style={styles.viewBanner}>
                <Swiper style={styles.swiperBanner} showsButtons={false} autoplay={false} autoplayTimeout={2}>
                {
                  this.state.arrayBanner.map((banner, index)=>
                  {
                    return( <Image style={styles.imageBanner} resizeMode="contain" source={{uri: banner}} key={index}/> )
                  })
                }
                </Swiper>
                <View style={{height:20}} />
              </View>
            </Content>
          </>
        )}
        data={this.state.arrayCategorias}
        renderItem={ ({ item }) => this.visualizarCategorias(item) }
        horizontal={ true }
        keyExtractor={ (item) => item.idCategoria.toString() }
      />
*/