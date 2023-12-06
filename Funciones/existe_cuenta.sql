CREATE OR REPLACE FUNCTION existe_cuenta(var_num_cuenta VARCHAR)
RETURNS BOOL AS $$
DECLARE
	DECLARE cur_cuenta CURSOR FOR
    SELECT num_cuenta
    FROM cuenta;
BEGIN
	
	FOR reg IN cur_cuenta LOOP
		IF reg.num_cuenta = CAST(var_num_cuenta AS INTEGER) THEN
			RETURN true;
		END IF;
	END LOOP;
	RETURN false;
END;
$$ LANGUAGE plpgsql;
