--@Autor: JKarina Flores García
--@Fecha creación: 30/11/2021
--@Descripción: Script encargado de realizar consultas con sinónimos
-- en ambas PDBs

prompt conectando a kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
prompt Realizando conteo de registros
set serveroutput on
start s-03-kfg-consultas-localizacion.sql
prompt conectando a kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
prompt Realizando conteo de registros
set serveroutput on
start s-03-kfg-consultas-localizacion.sql