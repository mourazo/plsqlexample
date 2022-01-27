
--	DCL con usuario SYSTEM

-- Creación del tablespace
create tablespace tbl_ventas datafile 'C:\oraclexe\app\oracle\oradata\XE\tbl_ventas.dbf' size 1000M autoextend on;

--Creación del usuario admin y sus privilegios
create user admin identified by "Linkia_FP1" default tablespace tbl_ventas quota unlimited on tbl_ventas;
grant create session to admin;
grant resource to admin;
-- el rol resource no incluye crear vistas, lo añadimos por tanto.
grant create view to admin;

-- Una vez creados espacio de tablas y usuario admin, se conecta con él para continuar
connect admin/Linkia_FP1;

-- Creamos todas las tablas y vistas, e introducimos un registro para cada una

-- Tabla vendedor
create table vendedor(
id_vendedor number(11) NOT NULL primary key, 
nombre_completo varchar2(200), 
correo varchar2(100), 
DNI varchar2(9) UNIQUE 
);

-- Primer registro de la tabla vendedor
INSERT INTO "ADMIN"."VENDEDOR" (ID_VENDEDOR, NOMBRE_COMPLETO, CORREO, DNI)
VALUES ('1', 'Manolo García', 'manolo@gmail.com', '44777111W');
INSERT INTO "ADMIN"."VENDEDOR" (ID_VENDEDOR, NOMBRE_COMPLETO, CORREO, DNI)
VALUES ('2', 'Antonio Flowers', 'antonio@gmail.com', '44772111W');
INSERT INTO "ADMIN"."VENDEDOR" (ID_VENDEDOR, NOMBRE_COMPLETO, CORREO, DNI)
VALUES ('3', 'Luis Ricardo Borriquero', 'borriq@gmail.com', '44737111W');

-- Tabla producto
create table producto(
id_producto number(11) NOT NULL primary key, 
nombre_producto varchar2(200), 
codigo varchar2(10) not null unique, 
precio_unidad number, 
descripcion varchar2(256)
);

-- Primer registro de la tabla producto
INSERT INTO "ADMIN"."PRODUCTO" (ID_PRODUCTO, NOMBRE_PRODUCTO, CODIGO, PRECIO_UNIDAD, DESCRIPCION)
VALUES ('1', 'Pasta de dientes Colgate', 'p001', '2,29', 'Para que tengas los dientes limpicos');
INSERT INTO "ADMIN"."PRODUCTO" (ID_PRODUCTO, NOMBRE_PRODUCTO, CODIGO, PRECIO_UNIDAD, DESCRIPCION)
VALUES ('2', 'Pasta de dientes Licor del Polo', 'p002', '3,29', 'Para que tengas los dientes limpicos');
INSERT INTO "ADMIN"."PRODUCTO" (ID_PRODUCTO, NOMBRE_PRODUCTO, CODIGO, PRECIO_UNIDAD, DESCRIPCION)
VALUES ('3', 'Pasta de dientes Mercadona', 'p003', '0,29', 'Para que tengas los dientes limpicos');
INSERT INTO "ADMIN"."PRODUCTO" (ID_PRODUCTO, NOMBRE_PRODUCTO, CODIGO, PRECIO_UNIDAD, DESCRIPCION)
VALUES ('4', 'Pasta de dientes Palwer', 'p004', '5,29', 'Para que tengas los dientes limpicos');

-- Tabla venta
create table venta(
id_venta number(11) NOT NULL primary key, 
cod_venta varchar2(10) not null unique, 
id_vendedor number(11), 
fecha_venta date, 
descripcion varchar2(256),
constraint fk_vendedor_id foreign key(id_vendedor) references vendedor(id_vendedor)
);

-- Primer registro de la tabla VENTA
INSERT INTO "ADMIN"."VENTA" (ID_VENTA, COD_VENTA, ID_VENDEDOR, FECHA_VENTA, DESCRIPCION)
VALUES ('1', 'VEN_1', '1', TO_DATE('2018-07-01 02:23:19', 'YYYY-MM-DD HH24:MI:SS'), 'Venta directa');
INSERT INTO "ADMIN"."VENTA" (ID_VENTA, COD_VENTA, ID_VENDEDOR, FECHA_VENTA, DESCRIPCION)
VALUES ('2', 'VEN_2',  '2', TO_DATE('2018-07-02 02:23:19', 'YYYY-MM-DD HH24:MI:SS'), 'Venta directa');
INSERT INTO "ADMIN"."VENTA" (ID_VENTA, COD_VENTA, ID_VENDEDOR, FECHA_VENTA, DESCRIPCION)
VALUES ('3', 'VEN_3',  '3', TO_DATE('2018-07-03 02:23:19', 'YYYY-MM-DD HH24:MI:SS'), 'Venta web');
INSERT INTO "ADMIN"."VENTA" (ID_VENTA, COD_VENTA, ID_VENDEDOR, FECHA_VENTA, DESCRIPCION)
VALUES ('4', 'VEN_4',  '3', TO_DATE('2017-07-04 02:23:19', 'YYYY-MM-DD HH24:MI:SS'), 'Venta directa');

-- Tabla linea venta
create table linea_venta(
id_linea_venta number(11) NOT NULL primary key, 
id_venta number(11),
id_producto number(11), 
cantidad number(11), 
descuento number(10,2),
constraint fk_venta_id foreign key(id_venta) references venta(id_venta),
constraint fk_producto_id foreign key(id_producto) references producto(id_producto)
);

-- Primer registro de la tabla LINEA_VENTA
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('1', '1', '1', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('2', '1', '2', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('3', '1', '3', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('4', '2', '4', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('5', '2', '1', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('6', '2', '2', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('7', '3', '3', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('8', '3', '4', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('9', '3', '1', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('10', '4', '2', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('11', '4', '3', '1', '0');
INSERT INTO "ADMIN"."LINEA_VENTA" (ID_LINEA_VENTA, ID_VENTA, ID_PRODUCTO, CANTIDAD, DESCUENTO)
VALUES ('12', '4', '4', '1', '0');

-- Creación de los procedimientos

create or replace procedure escribe_linea(id in number)
is
	linea LINEA_VENTA%ROWTYPE;
	nomproducto PRODUCTO.NOMBRE_PRODUCTO%TYPE;
begin
	select * into linea from LINEA_VENTA where id_linea_venta=id;
	select nombre_producto into nomproducto from PRODUCTO where id_producto=linea.id_producto;
	dbms_output.put_line('  '|| nomproducto || ', unidades adquiridas: ' || linea.cantidad || ', descuento: ' || linea.descuento);
end escribe_linea;
/
	
create or replace procedure mostrarVenta(id in number)
is
	laventa VENTA%ROWTYPE;
	lalineaventa LINEA_VENTA%ROWTYPE;
	cursor cLINEA_VENTA(idventa in number) is select * from LINEA_VENTA where id_venta=idventa;
begin
	select * into laventa from VENTA where id_venta=id;
	dbms_output.put_line('Venta con el cod. ' || laventa.cod_venta || ' y fecha ' || laventa.fecha_venta);
	dbms_output.put_line('Productos:');
	open cLINEA_VENTA(id);
	fetch cLINEA_VENTA into lalineaventa;
	while (cLINEA_VENTA%FOUND) loop
		escribe_linea(lalineaventa.id_linea_venta);
		fetch cLINEA_VENTA into lalineaventa;
		end loop;
	close cLINEA_VENTA;
end mostrarVenta;
/

create or replace procedure mostrarVentasVendedor(id in number)
is
	nombre_vendedor VENDEDOR.nombre_completo%TYPE;
	idventa VENTA.id_venta%TYPE;
	cursor cVENTAS_VENDEDOR(idvendedor in number) is select id_venta from venta where id_vendedor=idvendedor;
begin
	select nombre_completo into nombre_vendedor from VENDEDOR where id_vendedor=id;
	dbms_output.put_line('Ventas para el vendedor ' | nombre_vendedor);
	dbms_output.put_line('');
	open cVENTAS_VENDEDOR(id);
	fetch cVENTAS_VENDEDOR into idventa;
	while (cVENTAS_VENDEDOR%FOUND) loop
		mostrarVenta(idventa);
		dbms_output.put_line('');
		fetch cVENTAS_VENDEDOR into idventa;
		end loop;
	close cVENTAS_VENDEDOR;
end mostrarVentasVendedor;
/
