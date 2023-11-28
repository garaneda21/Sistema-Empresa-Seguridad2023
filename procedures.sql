CREATE OR REPLACE PROCEDURE alta_domicilio(
    in p_tipo_domicilio varchar(30),
    in p_direccion varchar(50),
    in p_estado_domicilio varchar(15),
    in p_monto_domicilio integer,
    in p_num_cuenta integer
    in p_fecha_alta_domicilio DATE,
    in p_fecha_baja_domicilio DATE,
    in p_causa_baja_domicilio varchar(100)
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

    insert into domicilio(
        tipo_domicilio,
        direccion,
	    estado_domicilio,
	    monto_domicilio,
	    num_cuenta,
        fecha_alta_domicilio,
        fecha_baja_domicilio,
        causa_baja_domicilio
    )
    values(
        p_tipo_domicilio,
        p_direccion,
        p_estado_domicilio,
        p_monto_domicilio,
        p_num_cuenta,
        p_fecha_alta_domicilio,
        p_fecha_baja_domicilio,
        p_causa_baja_domicilio
    );

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
        'Direccion de domicilio: ' || p_direccion,
        'Alta de domicilio',
        'Domicilio registrado correctamente',
        NULL,
        CURRENT_DATE,
        CURRENT_DATE,
        'Exito'
    );

end;
$$;