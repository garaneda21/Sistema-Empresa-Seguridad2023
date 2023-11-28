CREATE TABLE territorio(
	id_territorio_padre INTEGER not null,
	id_territorio INTEGER not null,
	nom_territorio varchar(30),
	tipo_territorio varchar(15),
	imp_territorio DECIMAL,
	divisa varchar(15)
);

CREATE TABLE ciclo_territorio(
	id_territorio INTEGER not null,
	id_ciclo INTEGER not null
);

CREATE TABLE sucursal(
	id_territorio INTEGER not null,
	id_sucursal INTEGER not null,
	dir_sucursal varchar(30)
);

CREATE TABLE vendedor(
	id_vendedor INTEGER not null,
	nombres varchar(30),
	apellido_paterno varchar(30),
	apellido_materno varchar(30),
	comision DECIMAL,
	id_sucursal INTEGER not null
);

CREATE TABLE vendedor_domicilio(
	id_vendedor INTEGER not null,
	id_domicilio INTEGER not null
);

CREATE TABLE simcard(
	num_imsi INTEGER not null,
	num_celular INTEGER,
	estado_sim varchar(15),
	id_sucursal INTEGER not null
);

CREATE TABLE contrata_articulo(
	id_domicilio INTEGER not null,
	id_articulo INTEGER not null,
	id_contrato INTEGER not null,
	fecha_cont_articulo DATE,
	fecha_descont_articulo DATE,
	num_imsi INTEGER not null,
	fecha_asig_sim DATE,
	fecha_desasig_sim DATE,
	estado_asignacion varchar(15),
	cobro_mensual INTEGER
);

CREATE TABLE articulo(
	id_articulo_pack INTEGER not null,
	id_articulo INTEGER not null,
	nom_articulo varchar(30),
	estado_articulo
);

CREATE TABLE stock_articulo(
	id_articulo INTEGER not null,
	id_sucursal INTEGER not null,
	stock_articulo INTEGER
);

CREATE TABLE cliente(
	cedula INTEGER not null,
	tipo_cedula varchar(15),
	nombres varchar(40),
	apellido_paterno varchar(30),
	apellido_materno varchar(30),
	tipo_cliente varchar(10),
	estado_cliente varchar(10)	
);

CREATE TABLE cuenta(
	num_cuenta INTEGER not null,
	dir_facturacion varchar(40),
	correo_electronico varchar(30),
	estado_cuenta varchar(15),
	monto_total INTEGER,
	cedula INTEGER not null,
	id_ciclo INTEGER not null	
);

CREATE TABLE domicilio(
	id_domicilio INTEGER not null,
	tipo_domicilio varchar(30),
	estado_domicilio varchar(15),
	monto_domicilio INTEGER,
	num_cuenta INTEGER not null
);

CREATE TABLE contrato(
	id_contrato INTEGER not null,
	dur_contrato time
);

CREATE TABLE descuento_articulo(
	id_articulo INTEGER not null,
	id_descuento INTEGER not null
);

CREATE TABLE accion_cliente(
	cedula INTEGER not null,
	id_accion INTEGER not null,
	fecha_ingreso_accion DATE
);

CREATE TABLE accion(
	id_accion INTEGER not null,
	destinatario_accion INTEGER,
	parametros varchar(100),
	accion_realizar varchar(30),
	comentarios varchar(500),
	motivo_baja varchar(500),
	fecha_ini_accion DATE,
	fecha_ter_accion DATE,
	estado_accion varchar(15)
);

CREATE TABLE contrata_plan(
	id_plan INTEGER not null,
	id_domicilio INTEGER not null,
	fecha_cont_plan DATE,
	fecha_descont_plan DATE,
	id_contrato INTEGER not null
);

CREATE TABLE plan_articulo_opcional(
	id_plan INTEGER not null,
	id_articulo INTEGER not null
);

CREATE TABLE descuento(
	id_descuento INTEGER not null,
	porcentaje DECIMAL,
	motivo_descuento varchar(50)
);

CREATE TABLE plan(
	id_plan INTEGER not null,
	nombre_plan varchar(30),
	estado_plan varchar(15),
	precio_plan INTEGER,
	id_conc_fact INTEGER not null
);

CREATE TABLE plan_articulo_ligado(
	id_plan INTEGER not null,
	id_articulo INTEGER not null
);
