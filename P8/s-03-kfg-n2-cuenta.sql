--connect bancos_bdd/bancos_bdd@ahgbdd_s1 

create or replace trigger t_dml_cuenta
instead of insert or update or delete on cuenta
declare
v_count number;
begin
    case
        when inserting then
            --verifica si hay correspondencia local para evitar acceso remoto
            select count(*) into v_count
            from sucursal_2
            where sucursal_id =:new.sucursal_id;
            --insercion local
            if v_count > 0 then
                insert into cuenta_4(cuenta_id,num_cuenta,tipo_cuenta,sucursal_id)
                values(:new.cuenta_id,:new.num_cuenta,:new.tipo_cuenta,:new.sucursal_id);
            --insercion remota
            else
                select count(*) into v_count
                from sucursal_1
                where sucursal_id =:new.sucursal_id;
                if v_count > 0 then
                    insert into cuenta_3(cuenta_id,num_cuenta,tipo_cuenta,sucursal_id)
                    values(:new.cuenta_id,:new.num_cuenta,:new.tipo_cuenta,:new.sucursal_id);
                else
                    raise_application_error(-20001,
                    'Error de integridad para el campo cuenta_id : '
                    || :new.cuenta_id
                    || ' No se encontró el registro padre en fragmentos');
                end if;
            end if;
            --Fragmento vertical
            insert into cuenta_1(cuenta_id,nip,saldo, sucursal_id)
            values(:new.cuenta_id,:new.nip,:new.saldo,:new.sucursal_id);
            --Fragmento vertical local
            insert into cuenta_2(cuenta_id,contrato, sucursal_id)
            values(:new.cuenta_id,:new.contrato, :new.sucursal_id);

        when updating then
            raise_application_error(-20002,
            'No se puede realizar, la operación update no está soportada');
        when deleting then
             --verifica si hay correspondencia local para evitar acceso remoto
             select count(*) into v_count
             from sucursal_2
             where sucursal_id =:old.sucursal_id;
             --insercion local
             if v_count > 0 then
                 delete from cuenta_4 where cuenta_id = :old.cuenta_id;
            --insercion remota
             else
                 select count(*) into v_count
                 from sucursal_1
                 where sucursal_id =:old.sucursal_id;
                 if v_count > 0 then
                     delete from cuenta_3 where cuenta_id = :old.cuenta_id;
            else
                 raise_application_error(-20001,
                 'Error de integridad para el campo cuenta_id : '
                 || :old.sucursal_id
                 || ' No se encontró el registro padre en fragmentos');
                 end if;
            end if;
            delete from cuenta_1 where cuenta_id = :old.cuenta_id;
            delete from cuenta_2 where cuenta_id = :old.cuenta_id;  
            
            
    end case;
end;
/