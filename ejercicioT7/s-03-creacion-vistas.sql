prompt Conectandose a kfgbdd_s2 
connect kfg_replica_bdd/karina@kfgbdd_s2 
prompt Creando de vistas materializadas en base mview (kfgbdd_s2)



--mv_cliente
create materialized view mv_cliente refresh fast with primary key as
select * from cliente@kfgbdd_s1_master
;
--mv_orden_compra_anual
create materialized view mv_orden_compra_anual
refresh fast with primary key as
select * from orden_compra@kfgbdd_s1_master o
where to_char(o.fecha_compra,'yyyy')='2020'
;
--mv_pago_auto_anual
create materialized view mv_pago_auto_anual
refresh fast with primary key as
select * from pago_auto@kfgbdd_s1_master p
where to_char(p.fecha_pago,'yyyy')='2020'
and exists (
select 1
from orden_compra@kfgbdd_s1_master o
where o.orden_compra_id = p.orden_compra_id
and to_char(o.fecha_compra,'yyyy')='2020'
);