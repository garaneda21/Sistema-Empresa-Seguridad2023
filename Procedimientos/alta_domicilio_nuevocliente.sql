CREATE OR REPLACE PROCEDURE alta_domicilio_nuevocliente(
	Parametros VARCHAR
) 
AS $$
DECLARE
/*
	-- Datos recibidos de los parametros
    v_direccion varchar;
    v_territorio varchar;
    v_plan varchar;
    v_id_contrato varchar;
    v_tipo_domicilio varchar;
    v_id_sucursal varchar;
    v_id_vendedor varchar;
	v_cedula integer;
	v_id_territorio integer;
	v_tipo_cedula varchar(100);
	v_nombres varchar(100);
	v_apellido_p varchar(100);
	v_apellido_m varchar(100);
	v_tipo_cliente varchar(100);
	v_estado_cliente varchar(100);
	v_fecha_alta_cliente DATE;
	v_telefono integer;
    v_num_cuenta varchar;
	v_id_ciclo integer;
	v_dir_facturacion varchar(100);
	v_tipo_facturacion varchar(100);
	v_correo_electronico varchar(100);
	v_estado_cuenta varchar(100);
	v_fecha_alta_cuenta DATE;
*/	

	datos varchar[];
	prefijos varchar[] := ARRAY['DIR','TRR','PLN','IDCTR','TDDOM','IDACC','IDSUC','IDVEND','CED','IDTRR','TCED','NOM','APP','APM','TCLI','ESTCLI','FACLI','TEL','NCUE','IDCIC','DIRFACT','TFACT','EMAIL','ESTCUE','FACUE'];
	error_detectado bool := false;
BEGIN

	FOR i IN 1..24 LOOP
		datos[i]=obtener_dato(Parametros,prefijos[i],0);
		IF datos[i] = 'NO EXISTE' THEN
			error_detectado := true;

			CASE i
			WHEN 1 THEN
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
