create or replace trigger t_dml_sucursal
instead of insert or update or delete on sucursal
declare
v_count number;
begin
    case
        when inserting then
            --verifica si hay correspondencia local para evitar acceso remoto
            select count(*) into v_count
            from pais_1
            where pais_id = :new.pais_id;
            --insercion local
            if v_count > 0 then
                dbms_output.put_line('insertando en el sitio 01');
                insert into sucursal_1(sucursal_id,num_sucursal,banco_id,pais_id)
                values(:new.sucursal_id,:new.num_sucursal,:new.banco_id,:new.pais_id);
            --insercion remota
            else
                select count(*) into v_count
                from pais_2
                where pais_id = :new.pais_id;
                if v_count > 0 then
                    insert into sucursal_2(sucursal_id,num_sucursal,pais_id, banco_id)
                    values(:new.sucursal_id,:new.num_sucursal,:new.pais_id, :new.banco_id);
                else
                    raise_application_error(-20001,
                    'Error de integridad para el campo pais_id : '
                    || :new.pais_id
                    || ' No se encontró el registro padre en fragmentos');
                end if;
            end if;
        when updating then
            raise_application_error(-20002,
            'No se puede realizar la operación update');

        when deleting then
            select count(*) into v_count
            from pais_1
            where pais_id =:old.pais_id;
            if v_count > 0 then
                delete from sucursal_1 where sucursal_id = :old.sucursal_id;
            else
                select count(*) into v_count
                from pais_2
                where pais_id =:old.pais_id;
                if v_count > 0 then
                    delete from sucursal_2  where sucursal_id = :old.sucursal_id;
                else
                    raise_application_error(-20001,
                    'Error de integridad para el campo pais_id : '
                    || :old.pais_id
                    || ' No se encontró el registro padre en fragmentos');
                end if;
            end if;
    end case;
end;
/