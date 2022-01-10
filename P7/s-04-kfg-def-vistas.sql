--@Autor: Karina Flores Garcia
--@Fecha creación: 25/11/21
--@Descripción: Script encargado de generar las vistas para implementar transparencia de fragmentacion



--consultando bancos
create or replace view banco as
select q2.banco_id, q2.clave, q2.nombre 
from (
  select banco_id, clave, nombre
  from banco_1
  union all
  select banco_id, clave, nombre
  from banco_2
) q2;

--consultando sucursales
create or replace view sucursal as 
select q3.sucursal_id, q3.num_sucursal, q3.banco_id, q3.pais_id, q3.gerente_id
from (
  select sucursal_id, num_sucursal, banco_id, pais_id, gerente_id
  from sucursal_1
  union all
  select sucursal_id, num_sucursal, banco_id, pais_id, gerente_id
  from sucursal_2
) q3;

--consultando empleados
create or replace view empleado as
select q4.empleado_id, q4.nombre, q4.ap_paterno, q4.ap_materno, q4.folio_certificacion, q4.jefe_id
from (
  select empleado_id, nombre, ap_paterno, ap_materno, folio_certificacion, jefe_id
  from empleado_1
  union all
  select empleado_id, nombre, ap_paterno, ap_materno, folio_certificacion, jefe_id
  from empleado_2
) q4;

--consultando cuentas
create or replace view cuenta as
select s2.cuenta_id, s2.num_cuenta, s2.tipo_cuenta, s1.saldo, s1.nip, s2.sucursal_id
from (
  select cuenta_id, num_cuenta, tipo_cuenta, sucursal_id 
  from cuenta_3
  union all
  select cuenta_id, num_cuenta, tipo_cuenta, sucursal_id
  from cuenta_4
) s2
join cuenta_1 s1 
on s2.cuenta_id = s1.cuenta_id
join cuenta_2 s3
on s2.cuenta_id = s3.cuenta_id;

--consultando paises
create or replace view pais as
select q1.pais_id,q1.clave, q1.nombre, q1.zona_economica
from (
  select pais_id, clave, nombre, zona_economica
  from pais_1
  union all
  select pais_id, clave,  nombre, zona_economica
  from pais_2
) q1;

--consultando movimientos
create or replace view movimiento as 
select q5.num_movimiento, q5.cuenta_id, q5.fecha_movimiento, q5.tipo_movimiento, q5.importe, q5.descripcion
from (
  select num_movimiento, cuenta_id, fecha_movimiento, tipo_movimiento, importe, descripcion
  from movimiento_1
  union all
  select num_movimiento,cuenta_id, fecha_movimiento, tipo_movimiento, importe, descripcion
  from movimiento_2
  union all
  select num_movimiento,cuenta_id, fecha_movimiento, tipo_movimiento, importe, descripcion
  from movimiento_3
) q5;