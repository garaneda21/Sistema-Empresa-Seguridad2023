CREATE OR REPLACE PROCEDURE alta_domicilio_cuenta_existente(
	Parametros VARCHAR
) 
AS $$
DECLARE

	-- Datos recibidos de los parametros
    v_direccion varchar;
    v_territorio varchar;
    v_plan varchar;
    v_id_contrato varchar;
    v_tipo_domicilio varchar;
    v_num_cuenta varchar;
    v_id_sucursal varchar;
    v_id_vendedor varchar;
	
	datos varchar[];
	prefijos varchar[] := ARRAY['DIR','TRR','PLN','IDCTR','TDDOM','IDACC','IDSUC','IDVEND'];
	error_detectado bool := false;
BEGIN

	FOR i IN 1..8 LOOP
		datos[i]=obtener_dato(Parametros,prefijos[i],0);
		
		IF datos[i] = 'NO EXISTE' THEN
			error_detectado := true;
		END IF;
		
		--RAISE NOTICE 'dato[%] = %',i,datos[i];
		--RAISE NOTICE 'error detectado = %',error_detectado;
	END LOOP;
	
	IF error_detectado <> true THEN
		RAISE NOTICE 'NO SE DETECTARON ERRORES :)';
	ELSE
		RAISE NOTICE 'HUBO UN ERROR :(';
	END IF;
	
END; $$
LANGUAGE plpgsql;
