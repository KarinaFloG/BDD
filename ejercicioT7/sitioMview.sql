prompt Conectandose a kfgbdd_s2 como usuario SYS
connect sys@kfgbdd_s2 as sysdba
prompt creando usuario kfg_replica_bdd en kfgbdd_s2

--permite la salida de mensajes a consula empleabo dbms_output.put_line
set serveroutput on

--este bloque anómimo valida la existencia del usuario, si existe lo elimina.
declare 
	v_count number(1,0);
begin
	select count(*) into v_count
	from dba_users
	where username in ('KFG_REPLICA_BDD');
	if v_count > 0 then
		dbms_output.put_line('Eliminando usuario existente');
		execute immediate 'drop user kfg_replica_bdd cascade';
	end if; 	
end;
/

create user kfg_replica_bdd identified by karina quota unlimited on users;
grant create session, create table, create procedure, create sequence,
create trigger, create view to kfg_replica_bdd;
grant create materialized view to kfg_replica_bdd;
grant alter any materialized view to kfg_replica_bdd;
grant create database link to kfg_replica_bdd;
grant create public database link to kfg_replica_bdd;

