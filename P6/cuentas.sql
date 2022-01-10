--@Author: Flores García Karina
--@Fecha creación:  18/10/2021
--@Descripción: Consulta de fragmento cuentas en s1 y s2

--consultando cuentas en s1
select count(*) as into v_num_cuentas
from (
  select cuenta_id
  from f_kfg_cuenta_3
  union all
  select cuenta_id 
  from f_kfg_cuenta_4@kfgbdd_s2.fi.unam
) s2
join f_kfg_cuenta_1 s1 
on s2.cuenta_id = s1.cuenta_id
join f_kfg_cuenta_2@kfgbdd_s2.fi.unam s3
on s2.cuenta_id = s3.cuenta_id;

--consultando cuentas en s2
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