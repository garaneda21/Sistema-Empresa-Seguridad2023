--alta domicilio
CREATE OR REPLACE PROCEDURE alta_domicilio(
    in p_num_cuenta integer,
    in p_tipo_domicilio varchar(30),
    in p_direccion varchar(50),
    in p_estado_domicilio varchar(15),
    in p_fecha_alta_domicilio DATE,
    in p_fecha_baja_domicilio DATE,
    in p_causa_baja_domicilio varchar(100)
    in p_id_contrato integer
)
LANGUAGE plpgsql
AS &&
begin

    --prueba 1
    if p_direccion is null or trim(p_direccion) = '' then
        insert into accion(
            destinatario_accion,
	        parametros,
	        accion_realizar,
	        comentarios,
	        fecha_ini_accion,
	        fecha_ter_accion,
	        id_estado,
            fecha_ingreso_accion
        )
        values(
            p_num_cuenta,
            'Direccion de domicilio: ' || coalesce(p_direccion, 'No especificado'),
            'Alta de domicilio',
            'No se informa la direccion',
            CURRENT_DATE,
            NULL,
            --aqui deberia ir el id_estado correspondiente a 'Error'
            --fecha ingreso no seria redundante?
        );
    --prueba 4
    else if p_id_contrato is null then
        insert into accion(
            destinatario_accion,
	        parametros,
	        accion_realizar,
	        comentarios,
	        fecha_ini_accion,
	        fecha_ter_accion,
	        id_estado,
            fecha_ingreso_accion
        )
        values(
            p_num_cuenta,
            'Id_contrato: ' || coalesce(p_id_contrato, 'No especificado'),
            'Alta de domicilio',
            'No se informa el contrato',
            CURRENT_DATE,
            NULL,
            --aqui deberia ir el id_estado correspondiente a 'Error'
            --fecha ingreso no seria redundante?
        );
    end if;

    insert into domicilio(
        num_cuenta,
        tipo_domicilio,
        direccion,
        estado_domicilio,
        fecha_alta_domicilio,
        fecha_baja_domicilio,
        causa_baja_domicilio,
        id_contrato
    )
    values(
        p_num_cuenta,
        p_tipo_domicilio,
        p_direccion,
        p_estado_domicilio,
        p_fecha_alta_domicilio,
        p_fecha_baja_domicilio,
        p_causa_baja_domicilio,
        p_id_contrato
    );

    insert into accion(
        destinatario_accion,
	    parametros,
	    accion_realizar,
	    comentarios,
	    fecha_ini_accion,
	    fecha_ter_accion,
	    id_estado,
        --fecha_ingreso_accion
    )
    values(
        p_num_cuenta,
        'Direccion de domicilio: ' || p_direccion,
        'Alta de domicilio',
        'Domicilio registrado correctamente',
        CURRENT_DATE,
        CURRENT_DATE,
        --aqui deberia ir el id_estado correspondiente a 'Exito'
        CURRENT_DATE
    );

end;
$$;