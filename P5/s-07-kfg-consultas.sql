--@Autor: Flores García Karina
--@Fecha creación: 15/11/2021
--@Descripción: Conteo de registros
Prompt Conectando a S1 - kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
  select 
    (select count(pais_id) from f_kfg_pais_1) as pais_1, 
    (select count(banco_id) from f_kfg_banco_1) as banco_1, 
    (select count(empleado_id) from f_kfg_empleado_1) as empleado_1,
    (select count(sucursal_id) from f_kfg_sucursal_1) as sucursal_1,
    (select count(cuenta_id) from f_kfg_cuenta_1) as cuenta_1,
    (select count(cuenta_id) from f_kfg_cuenta_3) as cuenta_3,
    (select count(num_movimiento) from f_kfg_movimiento_2) as movimiento_2 from dual;
whenever sqlerror exit rollback;

Prompt Conectando a S2 - kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
select 
  (select count(pais_id) from f_kfg_pais_2) as pais_2,
  (select count(banco_id) from f_kfg_banco_2) as banco_2, 
  (select count(empleado_id) from f_kfg_empleado_2) as empleado_2, 
  (select count(sucursal_id) from f_kfg_sucursal_2) as sucursal_2, 
  (select count(cuenta_id) from f_kfg_cuenta_2) as cuenta_2, 
  (select count(cuenta_id) from f_kfg_cuenta_4) as cuenta_4, 
  (select count(num_movimiento) from f_kfg_movimiento_1) as movimiento_1,
  (select count(num_movimiento) from f_kfg_movimiento_3) as movimiento_3
 from dual;

whenever sqlerror exit rollback;