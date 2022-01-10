--@Author: Flores García Karina
--@Fecha creación:  18/10/2021
--@Descripción: Cambio de privilegios de usuario 


prompt Conectandose a kfgbdd_s1 como usuario SYS
connect sys@kfgbdd_s1 as sysdba
prompt Asignando permisos a usuario bancos_bdd en kfgbdd_s1
grant create database link, create procedure to bancos_bdd;

prompt Conectandose a kfgbdd_s2 como usuario SYS
connect sys@kfgbdd_s2 as sysdba
prompt Asignando permisos a usuario bancos_bdd en kfgbdd_s2
grant create database link, create procedure to bancos_bdd;

prompt Listo!
exit
 