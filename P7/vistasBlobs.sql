--@Autor: Karina Flores García
--@Fecha creación: 15/12/2021
--@Descripción: Definición de vistas para manejo de BLOBs en la PDB kfgbdd_s1

prompt ---
Prompt Paso 7 Crear las vistas con datos BLOB remotos empleando estrategia 1
prompt ---
--Para tabla F_KFG_MOVIMIENTO
create or replace view movimiento_e1 as
select q1.num_movimiento,q1.cuenta_id,q1.fecha_movimiento,q1.tipo_movimiento,q1.importe,q1.descripcion,q1.comprobante
from (
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from table (get_remote_comprobante_1)
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from movimiento_2
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from table (get_remote_comprobante_3)
) q1;

--Para tabla F_KFG_CUENTA_
create or replace view cuenta_e1 as
select s1.cuenta_id, s1.nip, s1.saldo, s3.contrato, s2.num_cuenta, s2.tipo_cuenta, s1.sucursal_id
from (
  select cuenta_id,sucursal_id, num_cuenta,tipo_cuenta
  from cuenta_3
  union all
  select cuenta_id,sucursal_id, num_cuenta,tipo_cuenta
  from cuenta_4
) s2
join cuenta_1 s1 
on s2.cuenta_id = s1.cuenta_id
join (
    select cuenta_id, contrato, sucursal_id from table (get_remote_contrato_2)
)s3 on s2.cuenta_id = s3.cuenta_id;




prompt ---
Prompt Paso 8 Crear las vistas con datos BLOB remotos empleando estrategia 2
prompt ---

create or replace view movimiento_e2 as
select q1.num_movimiento,q1.cuenta_id,q1.fecha_movimiento,q1.tipo_movimiento,q1.importe,q1.descripcion,q1.comprobante
from (
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,
  get_remote_comprobante_by_id_1(num_movimiento,cuenta_id) as comprobante from movimiento_1
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from movimiento_2
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,
  get_remote_comprobante_by_id_3(num_movimiento,cuenta_id) as comprobante from movimiento_3
) q1;

create or replace view cuenta_e2 as
select s1.cuenta_id, s1.nip, s1.saldo, s3.contrato, s2.num_cuenta, s2.tipo_cuenta, s1.sucursal_id
from (
  select cuenta_id,sucursal_id,num_cuenta,tipo_cuenta
  from cuenta_3
  union all
  select cuenta_id,sucursal_id,num_cuenta,tipo_cuenta
  from cuenta_4
) s2
join cuenta_1 s1 
on s2.cuenta_id = s1.cuenta_id
join (
    select cuenta_id, get_remote_contrato_by_id(cuenta_id) as contrato
    from cuenta_2
) s3 
on s2.cuenta_id = s3.cuenta_id;
