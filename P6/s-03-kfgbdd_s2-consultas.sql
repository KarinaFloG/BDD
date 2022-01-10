--@Author: Flores García Karina
--@Fecha creación:  18/10/2021
--@Descripción: Script encargado de realizar consultas para comprobar ligas kfgbdd_s2

prompt conectando a kfgbdd_s2
connect bancos_bdd@kfgbdd_s2
prompt Realizando conteo de registros
set serveroutput on
--La consulta se lanza en kfgBDD_S2
declare
v_num_paises      number;
v_num_bancos      number;
v_num_sucursales  number;
v_num_empleados   number;
v_num_cuentas     number;
v_num_movimientos number;
--completar
begin
dbms_output.put_line('Realizando consulta empleando ligas');
--consultando paises
select count(*) as into v_num_paises
from (
  select pais_id
  from f_kfg_pais_1@kfgbdd_s1.fi.unam
  union all
  select pais_id
  from f_kfg_pais_2
) q1;

--consultando bancos
select count(*) as into v_num_bancos
from (
  select banco_id
  from f_kfg_banco_1@kfgbdd_s1.fi.unam
  union all
  select banco_id
  from f_kfg_banco_2
) q2;

--consultando sucursales
select count(*) as into v_num_sucursales
from (
  select sucursal_id
  from f_kfg_sucursal_1@kfgbdd_s1.fi.unam
  union all
  select sucursal_id
  from f_kfg_sucursal_2
) q3;

--consultando empleados
select count(*) as into v_num_empleados
from (
  select empleado_id
  from f_kfg_empleado_1@kfgbdd_s1.fi.unam
  union all
  select empleado_id
  from f_kfg_empleado_2
) q4;

--consultando cuentas
select count(*) as into v_num_cuentas
from (
  select cuenta_id
  from f_kfg_cuenta_3@kfgbdd_s1.fi.unam
  union all
  select cuenta_id 
  from f_kfg_cuenta_4
) s2
join f_kfg_cuenta_1@kfgbdd_s1.fi.unam s1 
on s2.cuenta_id = s1.cuenta_id
join f_kfg_cuenta_2 s3
on s2.cuenta_id = s3.cuenta_id;

--consultando movimientos
select count(*) as into v_num_movimientos
from (
  select num_movimiento
  from f_kfg_movimiento_1
  union all
  select num_movimiento
  from f_kfg_movimiento_2@kfgbdd_s1.fi.unam
  union all
  select num_movimiento
  from f_kfg_movimiento_3
) q5;

-- realizar el mismo procedimiento para las demás tablas.
dbms_output.put_line('Resultado del conteo de registros');
dbms_output.put_line('Paises: '||     v_num_paises);
dbms_output.put_line('Bancos: '||     v_num_bancos);
dbms_output.put_line('Sucursales: '|| v_num_sucursales);
dbms_output.put_line('Empleados: '||  v_num_empleados);
dbms_output.put_line('Cuentas: '||    v_num_cuentas);
dbms_output.put_line('Movimientos: '||v_num_movimientos);
--completar con las demás tablas.
end;
/

Prompt Listo!
exit