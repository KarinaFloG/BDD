--@Autor: Karina Flores García
--@Fecha creación: 12/11/2021
--@Descripción: Definición de vistas para manejo de BLOBs en la PDB kfgbdd_s2

/*
En este sitio se cargarán los siguientes archivos.

-----Nodo 1
F_KFG_MOVIMIENTO_2
NUM_MOVIMIENTO CUENTA_ID COMPROBANTE
-------------- ---------- -----------
2               1         m_archivo_4.pdf
*/


/* ------ Nodo 2
En kfgbdd_s2 se cargarán los siguientes archivos.

F_KFG_MOVIMIENTO_3
NUM_MOVIMIENTO CUENTA_ID COMPROBANTE
-------------- ---------- -----------
3              2          m_archivo_5.pdf

F_KFG_MOVIMIENTO_1
NUM_MOVIMIENTO CUENTA_ID COMPROBANTE
-------------- ---------- -----------
1              1          m_archivo_3.pdf


Aqui están todos los blobs
F_KFG_CUENTA_2
CUENTA_ID  CONTRATO
---------  ---------
1          m_archivo_1.pdf
2          m_archivo_2.pdf

*/
Prompt connectando a kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2


prompt ---
Prompt Paso 1. creando vistas con columnas BLOB locales.
prompt ---

create or replace view cuenta as
select s2.cuenta_id,s1.nip,s1.saldo, s3.contrato, s2.num_cuenta,s2.tipo_cuenta,s1.sucursal_id
from (
  select cuenta_id, num_cuenta, tipo_cuenta
  from f_kfg_cuenta_3@kfgbdd_s1.fi.unam
  union all
  select cuenta_id, num_cuenta, tipo_cuenta
  from f_kfg_cuenta_4
) s2
join f_kfg_cuenta_1@kfgbdd_s1.fi.unam s1 
on s2.cuenta_id = s1.cuenta_id
join f_kfg_cuenta_2 s3
on s2.cuenta_id = s3.cuenta_id;

--Para movimiento no se puede realizar la vista porque hay blobs remotos

prompt ---
Prompt Paso 2 creando objetos type para vistas que involucran BLOBs remotos

--Tipo de dato para F_KFG_MOVIMIENTO_2
create type comprobante_type_2 as object(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date,
    tipo_movimiento char(1),
    importe numeric(18,2),
    descripcion varchar(2000),
    comprobante blob
);
/
show errors;



prompt ---
Prompt Paso 3 creando objetos table para vistas que involucran BLOBs remotos

--Objeto para F_KFG_MOVIMIENTO_2
create type comprobante_table_2 as table of comprobante_type_2;
/
show errors;



prompt ---
Prompt Paso 4 creando tablas temporales para vistas que involucran BLOBs remotos

--Tabla para F_KFG_MOVIMIENTO_2
create global temporary table t_f_kfg_movimiento_2(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob, 
    constraint t_f_kfg_movimiento_2_pk 
    primary key (num_movimiento,cuenta_id)
) on commit preserve rows;


prompt ---
Prompt Paso 5 Creando funcion con estrategia 1 para vistas que involucran BLOBs remotos


--Tabla para F_KFG_MOVIMIENTO_2
create or replace function get_remote_comprobante_2 return comprobante_table_2 pipelined is
pragma autonomous_transaction;
v_temp_pdf blob;
begin
--Inicia txn autónoma 1.
--asegura que no haya registros
delete from t_f_kfg_movimiento_2;
--inserta los datos obtenidos del fragmento remoto a la tabla temporal.
insert into t_f_kfg_movimiento_2 select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from movimiento_2;
--termina txn autónoma 1 antes de iniciar con la construcción del objeto pdf_table
commit;
--obtiene los registros de la tabla temporal y los regresa como objetos tipo pdf_type
for cur in (select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from t_f_kfg_movimiento_2)
loop
pipe row(comprobante_type_2(cur.num_movimiento,cur.cuenta_id,cur.fecha_movimiento,
cur.tipo_movimiento,cur.importe,cur.descripcion,cur.comprobante));
end loop;
--Inicia txn autónoma 2 para limpiar la tabla
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_movimiento_2;
--termina txn autónoma 2
commit;
return;
exception
when others then
--termina txn autónoma en caso de ocurrir un error
rollback;
--reelanza el error para que sea propagado a quien invoque a esta función
end;
/
show errors;



prompt ---
Prompt Paso 6 Creando funcion con estrategia 2 para vistas que involucran BLOBs remotos


--Tabla para F_KFG_MOVIMIENTO_2
create or replace function get_remote_comprobante_by_id_2(v_num_movimiento in number, v_cuenta_id number ) return blob is
pragma autonomous_transaction;
v_temp_comprobante_2 blob;
begin
--inicia txn autónoma 1
--asegura que no haya registros
delete from t_f_kfg_movimiento_2;
--inserta un solo registro obtenido del fragmento remoto a la tabla temporal.
insert into t_f_kfg_movimiento_2 select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from movimiento_2 where  num_movimiento = v_num_movimiento and cuenta_id = v_cuenta_id;
--obtiene el registro de la tabla temporal y lo regresa como blob
select comprobante into v_temp_comprobante_2 from t_f_kfg_movimiento_2 where num_movimiento = v_num_movimiento and cuenta_id = v_cuenta_id;
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_movimiento_2;
--termina txn autónoma 1.
commit;
return v_temp_comprobante_2;
exception
when others then
rollback;
raise;
end;
/
show errors;



prompt ---
Prompt Paso 7 Crear las vistas con datos BLOB remotos empleando estrategia 1


create or replace view movimiento_e1 as
select q1.num_movimiento,q1.cuenta_id,q1.fecha_movimiento,q1.tipo_movimiento,q1.importe,q1.descripcion,q1.comprobante
from (
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from  movimiento_1
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from table (get_remote_comprobante_2)
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from movimiento_3
) q1;

prompt ---
Prompt Paso 8 Crear las vistas con datos BLOB remotos empleando estrategia 2

create or replace view movimiento_e2 as
select q1.num_movimiento,q1.cuenta_id,q1.fecha_movimiento,q1.tipo_movimiento,q1.importe,q1.descripcion,q1.comprobante
from (
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from movimiento_1
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,
  get_remote_comprobante_by_id_2(num_movimiento,cuenta_id)  as comprobante from movimiento_2
  union all
  select num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
  from movimiento_3
) q1;


prompt ---
Prompt Paso 9 Crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2.

create or replace synonym movimiento for movimiento_e2;
Prompt Listo!
exit