CREATE OR REPLACE PROCEDURE alta_domicilio_cuenta_existente(
	Parametros VARCHAR
) 
AS $$
DECLARE

	-- Datos recibidos de los parametros
    v_direccion varchar;
    v_territorio varchar;
    v_plan varchar;
    v_id_contrato integer;
    v_tipo_domicilio varchar;
    v_num_cuenta integer;
    v_id_sucursal integer;
    v_id_vendedor integer;
	
	error_detectado bool := false;
BEGIN
	v_direccion := obtener_dato(Parametros,'DIR',0);
	RAISE NOTICE 'direccion obtenida: %', v_direccion;
    
END; $$
LANGUAGE plpgsql;
