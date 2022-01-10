--@Autor: Jorge Rodriguez
--@Fecha creación: dd/mm/yyyy
--@Descripción: Definición de vistas para manejo de BLOBs en la PDB kfgbdd_s1

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
Prompt connectando a kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1


prompt ---
Prompt Paso 1. creando vistas con columnas BLOB locales.
prompt ---

--Aqui no hay construcción de vista porque hay datos blob remotos

prompt ---
Prompt Paso 2 creando objetos type para vistas que involucran BLOBs remotos
--Tipo de dato para F_KFG_MOVIMIENTO_1

create type comprobante_type_1 as object(
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

--Tipo de dato para F_KFG_MOVIMIENTO_3
create type comprobante_type_3 as object(
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

--Tipo de dato para F_KFG_CUENTA_2
create type contrato_type_2 as object(
    cuenta_id numeric(10,0),
    contrato blob,
    sucursal_id numeric(10,0)
);
/
show errors;

prompt ---
Prompt Paso 3 creando objetos table para vistas que involucran BLOBs remotos
prompt ---
--Objeto para F_KFG_MOVIMIENTO_1
create type comprobante_table_1 as table of comprobante_type_1;
/
show errors;
--Objeto para F_KFG_MOVIMIENTO_3
create type comprobante_table_3 as table of comprobante_type_3;
/
show errors;
--Objeto para F_KFG_CUENTA_2
create type contrato_table_2 as table of contrato_type_2;
/
show errors;


prompt ---
Prompt Paso 4 creando tablas temporales para vistas que involucran BLOBs remotos
prompt ---
--Tabla para F_KFG_MOVIMIENTO_1
create global temporary table t_f_kfg_movimiento_1(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob, 
    constraint t_f_kfg_movimiento_1_pk 
    primary key (num_movimiento,cuenta_id)
) on commit preserve rows;

--Tabla para F_KFG_MOVIMIENTO_3
create global temporary table t_f_kfg_movimiento_3(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob,
    constraint t_f_kfg_movimiento_3_pk 
    primary key (num_movimiento,cuenta_id)
) on commit preserve rows;

--Tabla para F_KFG_CUENTA_2
create global temporary table t_f_kfg_cuenta_2(
    cuenta_id numeric(10,0),
    contrato blob not null,
    sucursal_id numeric(10,0),
    constraint t_f_kfg_cuenta_2_pk primary key(cuenta_id)
) on commit preserve rows;


prompt ---
Prompt Paso 5 Creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
prompt ---
--Tabla para F_KFG_MOVIMIENTO_1
create or replace function get_remote_comprobante_1 return comprobante_table_1 pipelined is
pragma autonomous_transaction;
v_temp_pdf blob;
begin
--Inicia txn autónoma 1.
--asegura que no haya registros
delete from t_f_kfg_movimiento_1;
--inserta los datos obtenidos del fragmento remoto a la tabla temporal.
insert into t_f_kfg_movimiento_1 select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from movimiento_1;
--termina txn autónoma 1 antes de iniciar con la construcción del objeto pdf_table
commit;
--obtiene los registros de la tabla temporal y los regresa como objetos tipo pdf_type
for cur in (select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from t_f_kfg_movimiento_1)
loop
pipe row(comprobante_type_1(cur.num_movimiento,cur.cuenta_id,cur.fecha_movimiento,
cur.tipo_movimiento,cur.importe,cur.descripcion,cur.comprobante));
end loop;
--Inicia txn autónoma 2 para limpiar la tabla
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_movimiento_1;
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

--Tabla para F_KFG_MOVIMIENTO_3
create or replace function get_remote_comprobante_3 return comprobante_table_3 pipelined is
pragma autonomous_transaction;
v_temp_pdf blob;
begin
--Inicia txn autónoma 1.
--asegura que no haya registros
delete from t_f_kfg_movimiento_3;
--inserta los datos obtenidos del fragmento remoto a la tabla temporal.
insert into t_f_kfg_movimiento_3 select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from movimiento_3;
--termina txn autónoma 1 antes de iniciar con la construcción del objeto pdf_table
commit;
--obtiene los registros de la tabla temporal y los regresa como objetos tipo pdf_type
for cur in (select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from t_f_kfg_movimiento_3)
loop
pipe row(comprobante_type_3(cur.num_movimiento,cur.cuenta_id,cur.fecha_movimiento,
cur.tipo_movimiento,cur.importe,cur.descripcion,cur.comprobante));
end loop;
--Inicia txn autónoma 2 para limpiar la tabla
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_movimiento_3;
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

--Tabla para F_KFG_CUENTA_2
create or replace function get_remote_contrato_2 return contrato_table_2 pipelined is
pragma autonomous_transaction;
v_temp_pdf blob;
begin
--Inicia txn autónoma 1.
--asegura que no haya registros
delete from t_f_kfg_cuenta_2;
--inserta los datos obtenidos del fragmento remoto a la tabla temporal.
insert into t_f_kfg_cuenta_2 select 
cuenta_id, contrato, sucursal_id
from cuenta_2;
--termina txn autónoma 1 antes de iniciar con la construcción del objeto pdf_table
commit;
--obtiene los registros de la tabla temporal y los regresa como objetos tipo pdf_type
for cur in (select cuenta_id, contrato, sucursal_id
from t_f_kfg_cuenta_2)
loop
pipe row(contrato_type_2(cur.cuenta_id, cur.contrato, cur.sucursal_id));
end loop;
--Inicia txn autónoma 2 para limpiar la tabla
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_cuenta_2;
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

prompt ------
prompt ---
Prompt Paso 6 Creando funcion con estrategia 2 para vistas que involucran BLOBs remotos
prompt ---
--Tabla para F_KFG_MOVIMIENTO_1
create or replace function get_remote_comprobante_by_id_1(v_num_movimiento in number, v_cuenta_id number ) return blob is
pragma autonomous_transaction;
v_temp_comprobante_1 blob;
begin
--inicia txn autónoma 1
--asegura que no haya registros
delete from t_f_kfg_movimiento_1;
--inserta un solo registro obtenido del fragmento remoto a la tabla temporal.
insert into t_f_kfg_movimiento_1 select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from movimiento_1 where  num_movimiento = v_num_movimiento and cuenta_id = v_cuenta_id;
--obtiene el registro de la tabla temporal y lo regresa como blob
select comprobante into v_temp_comprobante_1 from t_f_kfg_movimiento_1 where num_movimiento = v_num_movimiento and cuenta_id = v_cuenta_id;
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_movimiento_1;
--termina txn autónoma 1.
commit;
return v_temp_comprobante_1;
exception
when others then
rollback;
raise;
end;
/
show errors;

--Tabla para F_KFG_MOVIMIENTO_3
create or replace function get_remote_comprobante_by_id_3(v_num_movimiento in number, v_cuenta_id number ) return blob is
pragma autonomous_transaction;
v_temp_comprobante_3 blob;
begin
--inicia txn autónoma 1
--asegura que no haya registros
delete from t_f_kfg_movimiento_3;
--inserta un solo registro obtenido del fragmento remoto a la tabla temporal.
insert into t_f_kfg_movimiento_3 select 
num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante
from movimiento_3 where  num_movimiento = v_num_movimiento and cuenta_id = v_cuenta_id;
--obtiene el registro de la tabla temporal y lo regresa como blob
select comprobante into v_temp_comprobante_3 from t_f_kfg_movimiento_3 where num_movimiento = v_num_movimiento and cuenta_id = v_cuenta_id;
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_movimiento_3;
--termina txn autónoma 1.
commit;
return v_temp_comprobante_3;
exception
when others then
rollback;
raise;
end;
/
show errors;

--Tabla para F_KFG_CUENTA_2
create or replace function get_remote_contrato_by_id(v_cuenta_id in number ) return blob is
pragma autonomous_transaction;
v_temp_contrato blob;
begin
--inicia txn autónoma 1
--asegura que no haya registros
delete from t_f_kfg_cuenta_2;
--inserta un solo registro obtenido del fragmento remoto a la tabla temporal.
insert into t_f_kfg_cuenta_2 select cuenta_id, contrato, sucursal_id
from cuenta_2 where cuenta_id = v_cuenta_id;
--obtiene el registro de la tabla temporal y lo regresa como blob
select contrato into v_temp_contrato from t_f_kfg_cuenta_2 where cuenta_id = v_cuenta_id;
--elimina los registros de la tabla temporal una vez que han sido obtenidos.
delete from t_f_kfg_cuenta_2;
--termina txn autónoma 1.
commit;
return v_temp_contrato;
exception
when others then
rollback;
raise;
end;
/
show errors;


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



Prompt ---
Prompt Paso 9 Crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2.

create or replace synonym movimiento for movimiento_e2;
create or replace synonym cuenta for cuenta_e2;
Prompt Listo!
exit