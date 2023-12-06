CREATE OR REPLACE FUNCTION existe_cliente(var_cedula VARCHAR)
RETURNS BOOL AS $$
DECLARE
	DECLARE cur_cliente CURSOR FOR
    SELECT cedula
    FROM cliente;
BEGIN
	
	FOR reg IN cur_cliente LOOP
		IF reg.cedula = CAST(var_cedula AS INTEGER) THEN
			RETURN true;
		END IF;
	END LOOP;
	RETURN false;
END;
$$ LANGUAGE plpgsql;
