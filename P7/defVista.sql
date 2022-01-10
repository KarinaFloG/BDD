
--Definición de la vista cuenta (fragmentación hibrida)
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