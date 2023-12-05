CREATE TABLE territorio(
	id_territorio_padre INTEGER,		--FK
	id_territorio INTEGER not null,		--PK
	nom_territorio varchar(30),
	tipo_territorio varchar(15),
	imp_territorio DECIMAL,
	divisa varchar(15)
);

CREATE TABLE ciclo_facturacion(
	id_ciclo INTEGER not null,		--PK
	dia_inicio integer,
	dia_termino integer
);

CREATE TABLE sucursal(
	id_territorio INTEGER not null,		--FK
	id_sucursal INTEGER not null,		--PK
	dir_sucursal varchar(30)
);

CREATE TABLE vendedor(
	id_vendedor INTEGER not null,		--PK
	nombres varchar(30),
	apellido_paterno varchar(30),
	apellido_materno varchar(30),
	id_sucursal INTEGER not null		--FK
);

CREATE TABLE vendedor_domicilio(
	id_vendedor INTEGER not null,		--PK/FK
	id_domicilio INTEGER not null		--PK/FK
);

CREATE TABLE simcard(
	num_imsi INTEGER not null,		--PK
	num_celular INTEGER,
	estado_sim varchar(15),
	id_sucursal INTEGER not null		--FK
);

CREATE TABLE contrata_articulo(
	id_domicilio INTEGER not null,		--PK/FK
	id_articulo INTEGER not null,		--PK/FK
	id_contrato INTEGER not null,		--PK/FK
	fecha_cont_articulo DATE,
	fecha_descont_articulo DATE,
	num_imsi INTEGER not null,		--FK
	fecha_asig_sim DATE,
	fecha_desasig_sim DATE,
	estado_asignacion varchar(15),
	cobro_mensual INTEGER
);

CREATE TABLE articulo(
	id_articulo INTEGER not null,		--PK
	nom_articulo varchar(30),
	estado_articulo varchar(15),
    usa_simcard boolean,
);

CREATE TABLE pack_de_articulos(
	id_articulo_pack INTEGER NOT NULL, --PK/FK
	id_articulo_contenido INTEGER NOT NULL --PK/FK
);

CREATE TABLE precio(
	id precio INTEGER not null,		--PK
	precio float
);

CREATE TABLE stock_articulo(
	id_articulo INTEGER not null,		--PK/FK
	id_sucursal INTEGER not null,		--PK/FK
	stock_articulo INTEGER
);

CREATE TABLE cliente(
	cedula INTEGER not null,		--PK
	id_territorio integer not null		--FK
	tipo_cedula varchar(15),
	nombres varchar(40),
	apellido_paterno varchar(30),
	apellido_materno varchar(30),
	tipo_cliente varchar(10),
	estado_cliente varchar(10),
    fecha_alta_cliente DATE,
    telefono integer,
);

CREATE TABLE cuenta(
	num_cuenta INTEGER not null,		--PK
	cedula INTEGER not null,		--FK
	id_ciclo INTEGER not null,		--FK
	dir_facturacion varchar(40),
	tipo_facturacion varchar(30),
	correo_electronico varchar(30),
	estado_cuenta varchar(15),
    fecha_alta_cuenta DATE,
	id_territorio integer not null		--FK
);

CREATE TABLE domicilio(
	id_domicilio INTEGER not null,		--PK
	num_cuenta INTEGER not null,		--FK
	tipo_domicilio varchar(30),
    	direccion varchar(50),
	estado_domicilio varchar(15),
    	fecha_alta_domicilio DATE,
	id_contrato integer not null,		--FK
	id_territorio INTEGER not null		--FK
);

CREATE TABLE contrato(
	id_contrato INTEGER not null,		--PK
	dur_contrato time,
);

CREATE TABLE accion_cliente(
	cedula INTEGER not null,		--PK/FK
	id_accion INTEGER not null,);		--PK/FK

CREATE TABLE accion(
	id_accion INTEGER not null,		--PK
	destinatario_accion INTEGER,
	parametros varchar(10000),
	accion_realizar varchar(30),
	comentarios varchar(500),
	fecha_ini_accion DATE,
	fecha_ter_accion DATE,
	id_estado INTEGER not null,		--FK
	fecha_ingreso_accion DATE
);

CREATE TABLE estado_accion(
	id_estado INTEGER not null,		--PK
	descripcion_estado varchar(20)	
);

CREATE TABLE contrata_plan(
	id_plan INTEGER not null,		--PK/FK
	id_domicilio INTEGER not null,		--PK/FK
	fecha_cont_plan DATE,
	fecha_descont_plan DATE,
	id_contrato INTEGER not null		--PK/FK
);

CREATE TABLE plan(
	id_plan INTEGER not null,		--PK
	nombre_plan varchar(30),
	estado_plan varchar(15),
);

CREATE TABLE plan_articulo_ligado(
	id_plan INTEGER not null,		--PK/FK
	id_articulo INTEGER not null		--PK/FK
);

CREATE TABLE plan_articulo_opcional(
	id_plan INTEGER not null,		--PK/FK
	id_articulo INTEGER not null		--PK/FK
);
