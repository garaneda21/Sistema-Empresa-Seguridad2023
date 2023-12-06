CREATE OR REPLACE PROCEDURE procesar_acciones_pendientes() AS $$
DECLARE

	DECLARE cursor_accion CURSOR FOR
    SELECT *
    FROM accion;

BEGIN
	FOR reg IN cursor_accion LOOP
		IF reg.id_estado <> 0 THEN
			RAISE NOTICE 'accion[%] procesada o con error', reg.id_accion;
		ELSE
			CASE reg.id_accion
			WHEN 0 THEN 
				-- accion 0
				RAISE NOTICE 'accion[%] ejecuta alta cuenta existente', reg.id_accion;
			WHEN 1 THEN 
				-- accion 1
				RAISE NOTICE 'accion[%] ejecuta alta cuenta nueva', reg.id_accion;
			WHEN 2 THEN 
				-- accion 2
				RAISE NOTICE 'accion[%] ejecuta alta nuevo cliente', reg.id_accion;
			WHEN 3 THEN
				-- accion 3
				RAISE NOTICE 'accion[%] ejecuta alta de un articulo', reg.id_accion;
			ELSE 
				--else_result 
			END CASE;
		END IF;
	END LOOP;
	
END; $$
LANGUAGE plpgsql;
