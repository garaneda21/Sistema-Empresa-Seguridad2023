CREATE TABLE territorio(
	id_territorio_padre INTEGER,		-- ¿Se deberia crear otra tabla con los id_territorio para que no sean NULL?
	id_territorio INTEGER not null,
	nom_territorio varchar(30),
	tipo_territorio varchar(15),
	imp_territorio DECIMAL,
	divisa varchar(15)
);

-- modelar como id_ciclo, dia_inicio, dia_termino
-- asi se puede ingresar un siclo que empieze los dias 3 de cada mes y termine los dias 2 por ejemplo
-- tambien en las observaciones sale que nos falto crear una entitad periodo que se relacione con esta,
-- no creo que sea nesesario agregarla, pero para mas orden se podria.
CREATE TABLE ciclo_facturacion(			-- debe ir el ciclo
	id_ciclo INTEGER not null,
	ciclo_fact varchar(50)
);

CREATE TABLE ciclo_territorio(			-- este igual
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

-- Gerardo: tengo duda con esto, en
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
	id_articulo_pack INTEGER not null, -- Gerardo: este no deberia ir
	id_articulo INTEGER not null,
	nom_articulo varchar(30),
	estado_articulo varchar(15),
    usa_simcard boolean,
    -- precio float		este no deberia ir
);

-- Gerardo: Añadí esta tabla para arreglar el mucho es a muchos
CREATE TABLE pack(
	id_articulo_pack INTEGER NOT NULL, -- PK/FK
	id_articulo_contenido INTEGER NOT NULL --PK/FK
);
-- Gerardo: Añadí esta tabla

-- Gerardo: ¿lo relacionamos con Articulos, Domicilio. Contrato, Planes?
CREATE TABLE precio(				-- deberia ir esta tabla
	id precio INTEGER not null,
	precio float
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
	estado_cliente varchar(10),
    fecha_alta_cliente DATE,
    fecha_baja_cliente DATE,
    causa_baja_cliente varchar(100),
    telefono integer
);

CREATE TABLE cuenta(
	num_cuenta INTEGER not null,
	cedula INTEGER not null,
	id_ciclo INTEGER not null,
	dir_facturacion varchar(40),
	correo_electronico varchar(30),
	estado_cuenta varchar(15),
	monto_total INTEGER, -- Gerardo: ¿Este no deberia ir?
    fecha_alta_cuenta DATE,
    fecha_baja_cuenta DATE,
    causa_baja_cuenta varchar(100)
);

CREATE TABLE domicilio(
	id_domicilio INTEGER not null,
	num_cuenta INTEGER not null,
	tipo_domicilio varchar(30),
    direccion varchar(50),
	estado_domicilio varchar(15),
	monto_domicilio INTEGER,
    fecha_alta_domicilio DATE,
    fecha_baja_domicilio DATE,
    causa_baja_domicilio varchar(100)
);

-- Gerardo: En las Obs. se pide relacionar con Precio
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
	-- fecha_ingreso_accion DATE 		este no deberia ir segun el profe (1)
);

CREATE TABLE accion(
	id_accion INTEGER not null,
	destinatario_accion INTEGER, -- Gerardo: Esto creo que no va
	parametros varchar(100), -- Gerardo: Este debe se un varchar gigante ya que van muchos parametros concatenados
	accion_realizar varchar(30),
	comentarios varchar(500),
	motivo_baja varchar(500), --Gerardo: Este creo que no va
	fecha_ini_accion DATE,
	fecha_ter_accion DATE,
	id_estado INTEGER not null,		-- conecta accion con estado_accion FK
	fecha_ingreso_accion DATE		-- (1) aqui deberia ir
);

CREATE TABLE estado_accion(			-- debe ir 
	id_estado INTEGER not null,
	descripcion_estado varchar(20)	
);

CREATE TABLE contrata_plan(
	id_plan INTEGER not null,
	id_domicilio INTEGER not null,
	fecha_cont_plan DATE,
	fecha_descont_plan DATE,
	id_contrato INTEGER not null
);

/*CREATE TABLE descuento(				-- podriamos quitarla... pq no es necesario en ningun proceso de las altas
	id_descuento INTEGER not null,
	porcentaje DECIMAL,
	motivo_descuento varchar(50)
);*/

CREATE TABLE plan(
	id_plan INTEGER not null,
	nombre_plan varchar(30),
	estado_plan varchar(15),
	precio_plan INTEGER, -- lo mismo de la entidad precio
--	id_conc_fact INTEGER not null		-- podriamos quitarla... pq no es necesario en ningun proceso de las altas
);

CREATE TABLE plan_articulo_ligado(
	id_plan INTEGER not null,
	id_articulo INTEGER not null
);

CREATE TABLE plan_articulo_opcional(
	id_plan INTEGER not null,
	id_articulo INTEGER not null
);
