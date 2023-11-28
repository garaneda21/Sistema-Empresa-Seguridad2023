CREATE OR REPLACE PROCEDURE alta_domicilio(
    in p_tipo_domicilio varchar(30),
    in p_direccion varchar(50),
    in p_estado_domicilio varchar(15),
    in p_monto_domicilio integer,
    in p_num_cuenta integer
)
LANGUAGE plpgsql
AS &&
begin

    if p_direccion is null or trim(p_direccion) = '' then
        insert into accion(
            destinatario_accion,
	        parametros,
	        accion_realizar,
	        comentarios,
	        motivo_baja,
	        fecha_ini_accion,
	        fecha_ter_accion,
	        estado_accion
        )
        values(
            p_num_cuenta,
            'Direccion de domicilio: ' || coalesce(p_direccion, 'No especificado'),
            'Alta de domicilio',
            'No se informa la direccion',
            NULL,
            CURRENT_DATE,
            NULL,
            'ERROR'
        );
        return;
    end if;
end;
$$;