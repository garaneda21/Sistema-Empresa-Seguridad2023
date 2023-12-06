CREATE OR REPLACE PROCEDURE alta_domicilio_cuenta_nueva(
	Parametros VARCHAR,
	id_accion_actual integer
) 
AS $$
DECLARE

	-- Datos recibidos de los parametros
    	--datos[1] -> direccion
    	--datos[2] -> id_territorio
    	--datos[3] -> plan
    	--datos[4] -> id_contrato
    	--datos[5] -> tipo_domicilio
	--datos[6] -> id_ciclo
	--datos[7] -> dir_facturacion
	--datos[8] -> correo_electronico
	--datos[9] -> tipo_facturacion
	--datos[10] -> cedula
	comentarios varchar := '';
	
	datos varchar[];
	prefijos varchar[] := ARRAY['DIR','TRR','PLAN','IDCTR','TDOM','IDCICLO','DIRFACT','CORREO','TIPOFACT','CEDULA'];
	error_detectado bool := false;
BEGIN

	FOR i IN 1..10 LOOP
		datos[i]=obtener_dato(Parametros,prefijos[i],0);
		IF datos[i] = 'NO EXISTE' THEN
			error_detectado := true;
			
			CASE i
			WHEN 1 THEN comentarios := comentarios || 'No se informa la direccion, ';
			WHEN 2 THEN comentarios := comentarios || 'No se informa la estructura del pais, ';
			WHEN 3 THEN comentarios := comentarios || 'No se informa el plan, ';
			WHEN 4 THEN comentarios := comentarios || 'No se informa el contrato, ';
			WHEN 5 THEN comentarios := comentarios || 'No se informa el tipo de domicilio, ';
			WHEN 6 THEN comentarios := comentarios || 'No se informa el ciclo de facturacion, ';
			WHEN 7 THEN comentarios := comentarios || 'No se informa la direccion de facturacion, ';
			WHEN 8 THEN comentarios := comentarios || 'No se informa el correo, ';
			WHEN 9 THEN comentarios := comentarios || 'No se informa el tipo de facturacion, ';
			WHEN 10 THEN comentarios := comentarios || 'No se informa la cedula del cliente, ';
			END CASE;
		
		--RAISE NOTICE 'dato[%] = %',i,datos[i];
		--RAISE NOTICE 'error detectado = %',error_detectado;
	END LOOP;
	
	IF error_detectado <> true THEN
		--RAISE NOTICE 'NO SE DETECTARON ERRORES :)';
		
		INSERT INTO cuenta
		VALUES(currval('seq_id_cuenta'),datos[10],datos[6],datos[7],datos[9],datos[8],'Activo',CURRENT_DATE,datos[2]);
		
		INSERT INTO domicilio
		VALUES(nextval('seq_id_dom'),nextval('seq_id_cuenta'),datos[5],datos[1],'Activo',CURRENT_DATE,datos[4],datos[2]);
		
		INSERT INTO contrata_plan
		VALUES(datos[3], currval('seq_id_dom'),CURRENT_DATE,NULL,datos[4]);
		
		UPDATE accion
		SET id_estado = 1
		WHERE id_accion = id_accion_actual
		
	ELSE
		--RAISE NOTICE 'HUBO UN ERROR :(';
	
		UPDATE accion
		SET fecha_ter_accion = CURRENT_DATE,
			id_estado = 2,
			comentarios = comentarios
		WHERE id_accion = id_accion_actual
	END IF;
	
END; $$
LANGUAGE plpgsql;
