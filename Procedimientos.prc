--alta domicilio
CREATE OR REPLACE PROCEDURE alta_domicilio()
LANGUAGE plpgsql
AS $$
declare 
    p_num_cuenta integer,
    p_tipo_domicilio varchar(30),
    p_direccion varchar(100),
    p_estado_domicilio varchar(100),
    p_fecha_alta_domicilio DATE,
    p_fecha_baja_domicilio DATE,
    p_causa_baja_domicilio varchar(100),
    p_id_contrato integer
begin
    --prueba 1
    case
        when p_direccion is null or trim(p_direccion) = '' then
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
                2,
                CURRENT_DATE
            );
        --prueba 4
        when p_id_contrato is null then
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
                2,
                CURRENT_DATE
            );
        --prueba 5
        when p_tipo_domicilio is null or trim(p_tipo_domicilio) = '' then
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
                'Tipo de domicilio: ' || coalesce(p_id_contrato, 'No especificado'),
                'Alta de domicilio',
                'No se informa el tipo de domicilio',
                CURRENT_DATE,
                NULL,
                2,
                CURRENT_DATE
            );
        --prueba 6
        when not exists (select 1 from cuenta where num_cuenta = p_num_cuenta) then
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
                'Numero de cuenta: ' || coalesce(p_num_cuenta, 'No especificado'),
                'Alta de domicilio',
                'El cliente no existe',
                CURRENT_DATE,
                NULL,
                2,
                CURRENT_DATE
            );
        else 
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
            fecha_ingreso_accion
        )
        values(
            p_num_cuenta,
            'Direccion de domicilio: ' || p_direccion,
            'Alta de domicilio',
            'Domicilio registrado correctamente',
            CURRENT_DATE,
            CURRENT_DATE,
            1,
            CURRENT_DATE
        );
    end case;
end;
$$;
