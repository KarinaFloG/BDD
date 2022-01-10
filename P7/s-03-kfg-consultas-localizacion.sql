--@Autor: Herrera Gandarela Gabriel Alejandro
--@Fecha creación: 25/11/21
--@Descripción: Script encargado de realizar consultas con sinonimos.
-- El script de puede ejecutar el cualquier PDB.

declare
v_num_paises      number;
v_num_bancos      number;
v_num_sucursales  number;
v_num_empleados   number;
v_num_cuentas     number;
v_num_movimientos number;
begin
dbms_output.put_line('Realizando consulta empleando sinonimos');
--consultando paises
select count(*) into v_num_paises
from (
select pais_id
from pais_1
union all
select pais_id
from pais_2
) q1;

--consultando bancos
select count(*) as into v_num_bancos
from (
  select banco_id
  from banco_1
  union all
  select banco_id
  from banco_2
) q2;

--consultando sucursales
select count(*) as into v_num_sucursales
from (
  select sucursal_id
  from sucursal_1
  union all
  select sucursal_id
  from sucursal_2
) q3;

--consultando empleados
select count(*) as into v_num_empleados
from (
  select empleado_id
  from empleado_1
  union all
  select empleado_id
  from empleado_2
) q4;

--consultando cuentas
select count(*) as into v_num_cuentas
from (
  select cuenta_id
  from cuenta_3
  union all
  select cuenta_id 
  from cuenta_4
) s2
join cuenta_1 s1 
on s2.cuenta_id = s1.cuenta_id
join cuenta_2 s3
on s2.cuenta_id = s3.cuenta_id;

--consultando movimientos
select count(*) as into v_num_movimientos
from (
  select num_movimiento
  from movimiento_1
  union all
  select num_movimiento
  from movimiento_2
  union all
  select num_movimiento
  from movimiento_3
) q5;

-- realizar el mismo procedimiento para las demás tablas
dbms_output.put_line('Resultado del conteo de registros');
dbms_output.put_line('Paises: '||     v_num_paises);
dbms_output.put_line('Bancos: '||     v_num_bancos);
dbms_output.put_line('Sucursales: ' || v_num_sucursales);
dbms_output.put_line('Empleados: ' ||  v_num_empleados);
dbms_output.put_line('Cuentas: ' ||    v_num_cuentas);
dbms_output.put_line('Movimientos: ' || v_num_movimientos);

end;
/