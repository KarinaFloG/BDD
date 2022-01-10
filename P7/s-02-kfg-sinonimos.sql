--@Autor: Karina Flores García
--@Fecha creación: 30/11/2021
--@Descripción: Creación de sinónimos

Prompt conectandose a kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
Prompt creando sinónimos en kfgbdd_s1
create or replace synonym pais_1 for f_kfg_pais_1;
create or replace synonym pais_2 for f_kfg_pais_2@kfgbdd_s2;

create or replace synonym banco_1 for f_kfg_banco_1;
create or replace synonym banco_2 for f_kfg_banco_2@kfgbdd_s2;

create or replace synonym empleado_1 for f_kfg_empleado_1;
create or replace synonym empleado_2 for f_kfg_empleado_2@kfgbdd_s2;

create or replace synonym sucursal_1 for f_kfg_sucursal_1;
create or replace synonym sucursal_2 for f_kfg_sucursal_2@kfgbdd_s2;

create or replace synonym cuenta_1 for f_kfg_cuenta_1;
create or replace synonym cuenta_2 for f_kfg_cuenta_2@kfgbdd_s2;
create or replace synonym cuenta_3 for f_kfg_cuenta_3;
create or replace synonym cuenta_4 for f_kfg_cuenta_4@kfgbdd_s2;

create or replace synonym movimiento_1 for f_kfg_movimiento_1@kfgbdd_s2;
create or replace synonym movimiento_2 for f_kfg_movimiento_2;
create or replace synonym movimiento_3 for f_kfg_movimiento_3@kfgbdd_s2;


Prompt conectandose a kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
Prompt creando sinónimos en kfgbdd_s2

create or replace synonym pais_1 for f_kfg_pais_1@kfgbdd_s1;
create or replace synonym pais_2 for f_kfg_pais_2;

create or replace synonym banco_1 for f_kfg_banco_1@kfgbdd_s1;
create or replace synonym banco_2 for f_kfg_banco_2;

create or replace synonym empleado_1 for f_kfg_empleado_1@kfgbdd_s1;
create or replace synonym empleado_2 for f_kfg_empleado_2;

create or replace synonym sucursal_1 for f_kfg_sucursal_1@kfgbdd_s1;
create or replace synonym sucursal_2 for f_kfg_sucursal_2;

create or replace synonym cuenta_1 for f_kfg_cuenta_1@kfgbdd_s1;
create or replace synonym cuenta_2 for f_kfg_cuenta_2;
create or replace synonym cuenta_3 for f_kfg_cuenta_3@kfgbdd_s1;
create or replace synonym cuenta_4 for f_kfg_cuenta_4;

create or replace synonym movimiento_1 for f_kfg_movimiento_1;
create or replace synonym movimiento_2 for f_kfg_movimiento_2@kfgbdd_s1;
create or replace synonym movimiento_3 for f_kfg_movimiento_3;

Prompt Listo!
exit