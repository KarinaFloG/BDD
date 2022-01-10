--@Author: Karina Flores García
--@Fecha creación:  17/12/2021
--@Descripción: Creacion de ttrigger movimiento en kfgbdd_s2


create or replace trigger t_dml_movimiento
instead of insert or update or delete on movimiento
declare
v_count number;
begin
    case
        when inserting then
            if to_char(:new.fecha_movimiento,'dd/mm/yyyy') < '01/01/2000' then
                    insert into movimiento_1(num_movimiento,cuenta_id,fecha_movimiento,
                    tipo_movimiento,importe,descripcion, comprobante)
                    values (:new.num_movimiento,:new.cuenta_id,:new.fecha_movimiento,
                    :new.tipo_movimiento,:new.importe,:new.descripcion,:new.comprobante);
            elsif to_char(:new.fecha_movimiento,'dd/mm/yyyy') >= '01/01/2000' then
                select count(*) into v_count
                from cuenta_4
                where cuenta_id = :new.cuenta_id;
                --insercion local
                if v_count > 0 then
                    insert into movimiento_3(num_movimiento,cuenta_id,fecha_movimiento,
                    tipo_movimiento,importe,descripcion, comprobante)
                    values (:new.num_movimiento,:new.cuenta_id,:new.fecha_movimiento,
                    :new.tipo_movimiento,:new.importe,:new.descripcion,:new.comprobante);
                --insercion remota
                else
                    select count(*) into v_count
                    from cuenta_3
                    where cuenta_id = :new.cuenta_id;
                    if v_count > 0 then
                        --inserta el binario, uso de una tabla temporal
                        insert into t_movimiento_insert(num_movimiento,cuenta_id,fecha_movimiento,
                        tipo_movimiento,importe,descripcion,comprobante)
                        values(:new.num_movimiento,:new.cuenta_id,:new.fecha_movimiento,
                        :new.tipo_movimiento,:new.importe,:new.descripcion,:new.comprobante);
                        --inserta en el sitio remoto a través de la tabla temporal
                        insert into movimiento_2
                        select * from t_movimiento_insert
                        where num_movimiento = :new.num_movimiento;
                        delete from t_movimiento_insert
                        where num_movimiento = :new.num_movimiento;
                    else
                        raise_application_error(-20001,
                        'Error de integridad para el campo num_movimiento : '
                        || :new.num_movimiento
                        || ' No se encontró el registro padre en fragmentos');
                    end if;
                end if;

            else
                raise_application_error(-20001,
                'Error de integridad para el campo num_movimiento : '
                || :new.num_movimiento
                || ' No se encontró el registro padre en fragmentos');
            end if;

        when updating then
            raise_application_error(-20002,
            'No se puede realizar, la operación update no está soportada');

        when deleting then
            if to_char(:old.fecha_movimiento,'dd/mm/yyyy') < '01/01/2000' then
                delete from movimiento_1 where num_movimiento = :old.num_movimiento;
            elsif to_char(:old.fecha_movimiento,'dd/mm/yyyy') >= '01/01/2000' then
                select count(*) into v_count
                from cuenta_2
                where cuenta_id = :old.cuenta_id;
                --insercion local
                if v_count > 0 then
                    delete from movimiento_3 where num_movimiento = :old.num_movimiento;
                --delete remota
                end if;
                    select count(*) into v_count
                    from cuenta_1
                    where cuenta_id= :old.cuenta_id;
                    if v_count > 0 then
                        delete from movimiento_2 where num_movimiento = :old.num_movimiento;
                    else
                        raise_application_error(-20001,
                        'Error de integridad para el campo num_movimiento : '
                        || :old.num_movimiento
                        || ' No se encontró el registro padre en fragmentos');
                    end if;
                
            else
                raise_application_error(-20001,
                'Valor incorrecto para el campo fecha_movimiento : '
                || :old.num_movimiento
                || ' NO encaja en la fragmentacion ');
            end if;
    end case;
end;
/