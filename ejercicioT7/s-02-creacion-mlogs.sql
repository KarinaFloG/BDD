prompt Conectandose a kfgbdd_s1 

connect kfg_replica_bdd/karina@kfgbdd_s1 
prompt Creando mlogs en base master


create materialized view log on cliente;
create materialized view log on orden_compra
with primary key (fecha_compra);
create materialized view log on pago_auto;

select log_owner,master,log_table,primary_key,
filter_columns,last_purge_date
from user_mview_logs;