--PK
ALTER TABLE territorio ADD CONSTRAINT pk_territorio PRIMARY KEY (id_territorio,id_territorio_padre);
ALTER TABLE ciclo_territorio ADD CONSTRAINT pk_cicloterritorio PRIMARY KEY (id_territorio,id_ciclo);
ALTER TABLE sucursal ADD CONSTRAINT pk_sucursal PRIMARY KEY (id_sucursal);
ALTER TABLE vendedor ADD CONSTRAINT pk_vendedor PRIMARY KEY ();
ALTER TABLE vendedor_domicilio ADD CONSTRAINT pk_vendedordom PRIMARY KEY ();
ALTER TABLE simcard ADD CONSTRAINT pk_simcard PRIMARY KEY (num_imsi);
ALTER TABLE contrata_articulo ADD CONSTRAINT pk_contarticulo PRIMARY KEY (id_domicilio,id_articulo,id_contrato);
ALTER TABLE articulo ADD CONSTRAINT pk_articulo PRIMARY KEY (id_articulo_pack,id_articulo);
ALTER TABLE stock_articulo ADD CONSTRAINT pk_stockarticulo PRIMARY KEY (id_articulo,id_sucursal);
ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY (cedula);
ALTER TABLE cuenta ADD CONSTRAINT pk_cuenta PRIMARY KEY (num_cuenta);
ALTER TABLE domicilio ADD CONSTRAINT pk_domicilio PRIMARY KEY (id_domicilio);
ALTER TABLE contrato ADD CONSTRAINT pk_contrato PRIMARY KEY (id_contrato);
ALTER TABLE descuento_articulo ADD CONSTRAINT pk_descarticulo PRIMARY KEY (id_articulo,id_descuento);
ALTER TABLE accion_cliente ADD CONSTRAINT pk_accioncliente PRIMARY KEY (cedula,id_accion);
ALTER TABLE accion ADD CONSTRAINT pk_accion PRIMARY KEY (id_accion);
ALTER TABLE contrata_plan ADD CONSTRAINT pk_contplan PRIMARY KEY (id_plan,id_domicilio,id_contrato);
ALTER TABLE plan_articulo_opcional ADD CONSTRAINT pk_planarticulo_op PRIMARY KEY (id_plan,id_articulo);
ALTER TABLE descuento ADD CONSTRAINT pk_descuento PRIMARY KEY (id_descuento);
ALTER TABLE plan ADD CONSTRAINT pk_plan PRIMARY KEY (id_plan);
ALTER TABLE plan_articulo_ligado ADD CONSTRAINT pk_planarticulo_li PRIMARY KEY (id_plan,id_articulo);
ALTER TABLE concepto_descuento ADD CONSTRAINT pk_concdescuento PRIMARY KEY (id_conc_fact,id_descuento);

--FK
--ALTER TABLE territorio ADD CONSTRAINT // FOREIGN KEY (//) REFERENCES //(//);

ALTER TABLE ciclo_territorio ADD CONSTRAINT FK_cicloterritorio_territorio FOREIGN KEY (id_territorio) REFERENCES territorio(id_territorio);

ALTER TABLE cuenta ADD CONSTRAINT FK_cuentacliente FOREIGN KEY (cedula) REFERENCES cliente(cedula);

ALTER TABLE accion_cliente ADD CONSTRAINT FK_accliente_cliente FOREIGN KEY (cedula) REFERENCES cliente(cedula);
ALTER TABLE accion_cliente ADD CONSTRAINT FK_accliente_accion FOREIGN KEY (id_accion) REFERENCES accion(id_accion);

ALTER TABLE sucursal ADD CONSTRAINT FK_sucursal_territorio FOREIGN KEY (id_territorio) REFERENCES territorio(id_territorio);

ALTER TABLE vendedor ADD CONSTRAINT FK_vendedor_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursañ(id_sucursal);

ALTER TABLE simcard ADD CONSTRAINT FK_simcard_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);

ALTER TABLE stock_articulo ADD CONSTRAINT FK_stockart_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);
ALTER TABLE stock_articulo ADD CONSTRAINT FK_stockart_articulo FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo);

ALTER TABLE contrata_articulo ADD CONSTRAINT FK_contrata_domicilio FOREIGN KEY (id_domicilio) REFERENCES domicilio(id_domicilio);
ALTER TABLE contrata_articulo ADD CONSTRAINT FK_contrata_articulo FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo);
ALTER TABLE contrata_articulo ADD CONSTRAINT FK_contrata_sim FOREIGN KEY (num_imsi) REFERENCES simcard(num_imsi);
ALTER TABLE contrata_articulo ADD CONSTRAINT FK_contrata_contrato FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato);

ALTER TABLE domicilio ADD CONSTRAINT FK_domicilio_cuenta FOREIGN KEY (num_cuenta) REFERENCES cuenta(num_cuenta);

ALTER TABLE vendedor_domicilio ADD CONSTRAINT FK_vendedordom_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor);
ALTER TABLE vendedor_domicilio ADD CONSTRAINT FK_vendedordom_domicilio FOREIGN KEY (id_domicilio) REFERENCES domicilio(id_domicilio);

ALTER TABLE descuento_articulo ADD CONSTRAINT FK_descarticulo_articulo FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo);
ALTER TABLE descuento_articulo ADD CONSTRAINT FK_descarticulo_descuento FOREIGN KEY (id_descuento) REFERENCES descuento(id_descuento);