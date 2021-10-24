--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Creación de usuarios en PDBS

prompt Conectandose a kfgbdd_s1 como usuario SYS
connect sys@kfgbdd_s1 as sysdba
prompt Creando usuario bancos_bdd
create user bancos_bdd identified by bancos_bdd quota unlimited on users;
grant create session, create table, create procedure, create sequence to bancos_bdd;

prompt Conectandose a kfgbdd_s2 como usuario SYS
connect sys@kfgbdd_s2 as sysdba
prompt Creando usuario bancos_bdd
create user bancos_bdd identified by bancos_bdd quota unlimited on users;
grant create session, create table, create procedure, create sequence to bancos_bdd;