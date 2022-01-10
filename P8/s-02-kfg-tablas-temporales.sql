--@Author: Karina Flores García
--@Fecha creación:  17/12/2021
--@Descripción: Creacion de tablas temporales

Prompt Conectando a S1 - kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1 

Prompt creacion de tablas temporales

create global temporary table t_movimiento_insert(
    num_movimiento numeric(10,0) constraint t_movimiento_pk primary key,
    cuenta_id numeric(10,0),
    fecha_movimiento date,
    tipo_movimiento char(1),
    importe numeric(18,2),
    descripcion varchar2(2000),
    comprobante blob
);
create global temporary table t_cuenta_insert(
    cuenta_id numeric(10,0) constraint t_cuenta_pk primary key,
    contrato blob null,
    sucursal_id numeric(10,0) null
);

Prompt Conectando a S2 - kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2

Prompt Creacion de tablas temporales 

create global temporary table t_movimiento_insert(
    num_movimiento numeric(10,0) constraint t_movimiento_pk primary key,
    cuenta_id numeric(10,0),
    fecha_movimiento date,
    tipo_movimiento char(1),
    importe numeric(18,2),
    descripcion varchar2(2000),
    comprobante blob
);
create global temporary table t_cuenta_insert(
    cuenta_id numeric(10,0) constraint t_cuenta_pk primary key,
    contrato blob null,
    sucursal_id numeric(10,0) null 
);