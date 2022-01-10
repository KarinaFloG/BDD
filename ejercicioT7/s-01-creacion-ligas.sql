
prompt Conectandose a kfgbdd_s2 

connect kfg_replica_bdd/karina@kfgbdd_s2 

prompt Creando ligas en kfgbdd_s2

--liga administrativa
create public database link kfgbdd_s1_master.fi.unam using 'KFGBDD_S1';

--liga privada, no requiere hacer uso de USING
create database link kfgbdd_s1_master.fi.unam
connect to kfg_replica_bdd identified by karina;