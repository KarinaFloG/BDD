--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Conexión a PDB y ejecución de scripts

prompt Conectandose a S1 - kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
prompt Ejecutando script para creacion de objetos
@s-02-kfg-n1-ddl.sql

prompt Conectandose a S2 - kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
prompt Ejecutando script para creacion de objetos
@s-02-kfg-n2-ddl.sql