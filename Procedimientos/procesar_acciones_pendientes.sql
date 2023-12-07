CREATE OR REPLACE PROCEDURE procesar_acciones_pendientes() AS $$
DECLARE

	DECLARE cursor_accion CURSOR FOR
    SELECT *
    FROM accion;
BEGIN
	FOR reg IN cursor_accion LOOP
		IF reg.id_estado <> 0 THEN
		ELSE
			CASE reg.id_accion_realizar
			WHEN 0 THEN 
				UPDATE accion SET fecha_ini_accion = now() WHERE id_accion = reg.id_accion;
				CALL alta_domicilio_cuenta_existente(reg.parametros_concat,reg.id_accion);
			WHEN 1 THEN 
				CALL alta_domicilio_cuenta_nueva(reg.parametros_concat,reg.id_accion);
			WHEN 2 THEN 
			WHEN 3 THEN
			END CASE;
		END IF;
	END LOOP;
	
END; $$
LANGUAGE plpgsql;
