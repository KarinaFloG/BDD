--@Autor: Karina Flores García
--@Fecha creación: 30/11/2021
--@Descripción: Conteo de registros

Prompt Conectando a S1 - kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
  select 
    (select count(*) from pais) pais, 
    (select count(*) from banco) banco, 
    (select count(*) from empleado) empleado,
    (select count(*) from sucursal) sucursal,
    (select count(*) from cuenta) cuenta,
    (select count(*) from movimiento) movimiento 
from dual;
whenever sqlerror exit rollback;

Prompt Conectando a S2 - kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
select 
    (select count(*) from pais) pais, 
    (select count(*) from banco) banco, 
    (select count(*) from empleado) empleado,
    (select count(*) from sucursal) sucursal,
    (select count(*) from cuenta) cuenta,
    (select count(*) from movimiento) movimiento 
from dual;

whenever sqlerror exit rollback;
