prompt Conectandose a kfgbdd_s2 como usuario 
connect sys@kfgbdd_s2 as sysdba

prompt Otorgando privilegios

-- permite crear mviews
grant create materialized view to kfg_replica_bdd;
--permite realizar refresh
grant alter any materialized view to kfg_replica_bdd;
-- privilegio para liga privada
grant create database link to kfg_replica_bdd;
-- privilegio para liga pública
grant create public database link to kfg_replica_bdd;