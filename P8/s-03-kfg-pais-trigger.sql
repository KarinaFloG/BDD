--@Author: Flores García Karina
--@Fecha creación:  17/12/2021
--@Descripción: Trigger para insert,update y delete de pais

create or replace trigger t_dml_pais
instead of insert or update or delete on pais   
declare
begin
case
    when inserting then
        if :new.zona_economica = 'A' then
            insert into pais_1(pais_id,clave,nombre, zona_economica)
            values(:new.pais_id,:new.clave,:new.nombre, :new.zona_economica);
        elsif :new.zona_economica = 'B' then
            insert into pais_2(pais_id,clave,nombre, zona_economica)
            values(:new.pais_id,:new.clave,:new.nombre, :new.zona_economica);
        else
            raise_application_error(-20001,
            'Valor incorrecto para el campo zona_economica : '
            || :new.zona_economica
            || ' Solo se permiten los valores A , B ');
        end if;
    when updating then
        --el registro se queda en el sitio A
        if :new.zona_economica = 'A' and :old.zona_economica = 'A' then
            update pais_1 set pais_id = :new.pais_id,clave = :new.clave,
            nombre = :new.nombre, zona_economica = :new.zona_economica
            where pais_id = :old.pais_id;
        --el registro cambia de sitio S2->S1
        elsif :new.zona_economica = 'A' and :old.zona_economica = 'A' then
            delete from pais_2 where pais_id = :old.pais_id;
            insert into pais_1(pais_id,zona_economica,nombre, clave)
            values(:new.pais_id,:new.zona_economica,:new.nombre, :new.clave);
         --el registro se queda en el sitio B
        elsif :new.zona_economica = 'B' and :old.zona_economica = 'B' then
            update pais_2 set pais_id = :new.pais_id,
            zona_economica=:new.zona_economica,nombre=:new.nombre, clave = :new.clave
            where pais_id = :old.pais_id;
        --el registro cambia de sitio S1->S2
        elsif :new.zona_economica= 'B' and :old.zona_economica = 'A' then
            delete from pais_1 where pais_id = :old.pais_id;
            insert into pais_2(pais_id,zona_economica,nombre, clave)
            values(:new.pais_id,:new.zona_economica,:new.nombre, :new.clave);
        --valores invalidos
        else
            raise_application_error(-20001,
            'Valor incorrecto para el campo zona_economica : '
            || :new.zona_economica
            || ' Solo se permiten los valores A , B ');
        end if;
when deleting then
    if :old.zona_economica = 'A' then
        delete from pais_1 where pais_id = :old.pais_id;
    elsif :old.zona_economica= 'B' then
        delete from pais_2 where pais_id = :old.pais_id;
    else
        raise_application_error(-20001,
        'Valor incorrecto para el campo tipo : '
        || :old.zona_economica
        || ' Solo se permiten los valores A , B ');
        end if;

    end case;
end;
/   