CREATE OR REPLACE FUNCTION obtener_dato(
	cadena VARCHAR,
	str_buscar VARCHAR,
	id_procedimiento INTEGER
)
RETURNS VARCHAR AS $$
DECLARE
	aux varchar;
	pos_busqueda INTEGER;
    resultado varchar;
BEGIN
	-- RAISE NOTICE 'String ingresado: %', cadena;
	
	pos_busqueda:= position(str_buscar || '[' IN cadena);
	
	-- Verificar si se encontró la subcadena
    IF pos_busqueda > 0 THEN
		-- meter subcadena a una variable auxiliar
        aux := substring(cadena FROM pos_busqueda + length(str_buscar) + 1);
		
		--RAISE NOTICE 'AUX: %', aux;
		
		-- ahora buscar el corchete derecho para eliminar el resto
		pos_busqueda := position(']' IN aux);
		
		-- eliminar el resto
		resultado := substring(aux FROM 1 FOR pos_busqueda - 1);
		
		-- Si viene vacio retornar NO EXISTE, si no retornar string
		IF (resultado = '') THEN
			resultado = 'NO EXISTE';
			RETURN resultado;
		ELSE
        	RETURN resultado;
		END IF;
    ELSE
        -- Si no se encuentra la subcadena, retornar NULL
        RETURN 'NO EXISTE';
    END IF;
END;
$$ LANGUAGE plpgsql;
