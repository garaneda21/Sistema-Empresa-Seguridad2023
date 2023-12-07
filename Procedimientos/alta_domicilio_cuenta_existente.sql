-- [ ] Guardar comentarios en tabla acciones

CREATE OR REPLACE PROCEDURE alta_domicilio_cuenta_existente(
	Parametros VARCHAR,
	var_id_accion integer
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
	DECLARE cursor_plan_articulo_ligado CURSOR FOR
		SELECT *
		FROM plan_articulo_ligado;
			
	datos varchar[];
	prefijos varchar[] := ARRAY['DIR','IDTRR','PLN','IDCTR','TDDOM','IDACC','IDSUC','IDVEND'];
	error_detectado bool := false;
	
	var_id_territorio integer;
	var_max_id_art integer;
	var_comentarios varchar := '';
BEGIN

	FOR i IN 1..8 LOOP
		datos[i]=obtener_dato(Parametros,prefijos[i],0);
		
		IF datos[i] = 'NO EXISTE' THEN
			error_detectado := true;
			CASE i
			WHEN 1 THEN var_comentarios := var_comentarios || 'No se informa la direccion, ';
			WHEN 2 THEN var_comentarios := var_comentarios || 'No se informa la estructura del pais, ';
			WHEN 3 THEN var_comentarios := var_comentarios || 'No se informa el plan, ';
			WHEN 4 THEN var_comentarios := var_comentarios || 'No se informa el contrato, ';
			WHEN 5 THEN var_comentarios := var_comentarios || 'No se informa el tipo de domicilio, ';
			WHEN 6 THEN var_comentarios := var_comentarios || 'No se informa la id del cliente, ';
			WHEN 7 THEN var_comentarios := var_comentarios || 'No se informa la id de la sucursal, ';
			WHEN 8 THEN var_comentarios := var_comentarios || 'No se informa la id del vendedor, ';
			END CASE;
		END IF;		
	END LOOP;
	
	IF error_detectado <> true THEN
		IF existe_cuenta(datos[6]) <> true THEN
			var_comentarios := var_comentarios || 'la id del cliente ingresado no existe';
		ELSE
			-- INSERT DOMICILIO
			INSERT INTO domicilio
			VALUES(nextval('seq_id_dom'),CAST(datos[6] AS INTEGER),datos[5],datos[1],'Activo',CURRENT_DATE,CAST(datos[4] AS INTEGER),CAST(datos[2] AS INTEGER));
			
			-- INSERT CONTRATA PLAN
			INSERT INTO contrata_plan
			VALUES(CAST(datos[3] AS INTEGER), currval('seq_id_dom'),CURRENT_DATE,NULL,CAST(datos[4] AS INTEGER));
			
			-- INSERT ARTICULOS LIGADOS AL PLAN
			FOR reg IN cursor_plan_articulo_ligado LOOP
				IF reg.id_plan = CAST(datos[3] AS INTEGER) THEN
					INSERT INTO contrata_articulo
					VALUES(currval('seq_id_dom'), reg.id_articulo, CAST(datos[4] AS INTEGER), CURRENT_DATE, NULL, 111111, CURRENT_DATE, NULL, 'Asignado', NULL);
				END IF;
			END LOOP;
			
			-- UPDATE TABLA ACCION
			UPDATE accion
			SET fecha_ter_accion = CURRENT_DATE, id_estado = 1, comentarios = 'Operacion realizada con exito'
			WHERE id_accion = var_id_accion;
		END IF;
	ELSE
		-- UPDATE TABLA ACCION
		UPDATE accion
		SET fecha_ter_accion = CURRENT_DATE, id_estado = 2, comentarios = var_comentarios
		WHERE id_accion = var_id_accion;
	END IF;
END; $$
LANGUAGE plpgsql;
