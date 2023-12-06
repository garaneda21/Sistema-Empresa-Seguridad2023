-- [ ] Guardar comentarios en tabla acciones

CREATE OR REPLACE PROCEDURE alta_domicilio_cuenta_existente(
	Parametros VARCHAR
) 
AS $$
DECLARE
	-- Datos recibidos de los parametros
	-- datos[1]: direccion
	-- datos[2]: id_territorio
	-- datos[3]: plan
	-- datos[4]: id_contrato
	-- datos[5]: tipo_domicilio
	-- datos[6]: num_cuenta
	-- datos[7]: id_sucursal
	-- datos[8]: id_vendedor
	
	datos varchar[];
	prefijos varchar[] := ARRAY['DIR','IDTRR','PLN','IDCTR','TDDOM','IDACC','IDSUC','IDVEND'];
	error_detectado bool := false;
	
	var_id_territorio integer;
	var_max_id_art integer;
	comentarios varchar := '';
BEGIN

	FOR i IN 1..8 LOOP
		datos[i]=obtener_dato(Parametros,prefijos[i],0);
		IF datos[i] = 'NO EXISTE' THEN
			error_detectado := true;
			CASE i
			WHEN 1 THEN comentarios := comentarios || 'No se informa la direccion, ';
			WHEN 2 THEN comentarios := comentarios || 'No se informa la estructura del pais, ';
			WHEN 3 THEN comentarios := comentarios || 'No se informa el plan, ';
			WHEN 4 THEN comentarios := comentarios || 'No se informa el contrato, ';
			WHEN 5 THEN comentarios := comentarios || 'No se informa el tipo de domicilio, ';
			WHEN 6 THEN comentarios := comentarios || 'No se informa la id del cliente, ';
			WHEN 7 THEN comentarios := comentarios || 'No se informa la id de la sucursal, ';
			WHEN 8 THEN comentarios := comentarios || 'No se informa la id del vendedor, ';
			END CASE;
		END IF;
		
		
	END LOOP;
	
	IF error_detectado <> true THEN
		IF existe_cliente(datos[6]) <> true THEN
			raise notice 'no existe el cliente anda a dormir';
			comentarios := comentarios || 'la id del cliente ingresado no existe';
		ELSE
			INSERT INTO domicilio
			VALUES(nextval('seq_id_dom'),datos[6],datos[5],datos[1],'Activo',CURRENT_DATE,datos[4],datos[2]);
			INSERT INTO contrata_plan
			VALUES(datos[3], currval('seq_id_dom'),CURRENT_DATE,NULL,datos[4]);

			DECLARE cursor_plan_articulo_ligado CURSOR FOR
			SELECT *
			FROM plan_articulo_ligado
			WHERE id_plan = datos[3];

			FOR reg IN cursor_plan_articulo_ligado LOOP
				INSERT INTO contrata_articulo
				VALUES(currval('seq_id_dom'), reg.id_articulo, datos[4], CURRENT_DATE, NULL,)
			END LOOP
		END IF;
	ELSE
		RAISE NOTICE 'HUBO UN ERROR :(';
	END IF;

END; $$
LANGUAGE plpgsql;
		   