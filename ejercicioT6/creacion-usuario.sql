--@Autor: Karina Flores García
--@Fecha creación: 15/12/2021
--@Descripción: Creación de usuario para ejercicio tema 6

prompt Conectandose a kfgbdd_s1 como usuario SYS
connect sys@kfgbdd_s1 as sysdba
prompt creando usuario tema6_bdd en kfgbdd_s1

declare
  v_count number;
  v_username varchar2(30) := 'TEMA6_BDD';
begin
  select count(*) into v_count
  from all_users
  where username = v_username;

  if v_count = 0 then
    -- Creando usuario
    execute immediate 'create user '
    || v_username
    || ' identified by tema6_bdd quota unlimited on users';
    -- Otorgando permisos al usuario
    execute immediate 'grant create table, create session, create sequence, 
    create procedure to '|| v_username;
  else 
    dbms_output.put_line('El usuario '||v_username||' ya existe');
  end if;

end;
/
