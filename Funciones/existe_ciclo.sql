CREATE OR REPLACE FUNCTION existe_ciclo(var_id_ciclo VARCHAR)
RETURNS BOOL AS $$
DECLARE
	DECLARE cur_ciclo CURSOR FOR
    SELECT id_ciclo
    FROM ciclo_facturacion;
BEGIN
	
	FOR reg IN cur_ciclo LOOP
		IF reg.id_ciclo = CAST(var_id_ciclo AS INTEGER) THEN
			RETURN true;
		END IF;
	END LOOP;
	RETURN false;
END;
$$ LANGUAGE plpgsql;
