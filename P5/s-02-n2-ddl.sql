--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Creación de fragmento 1 y sus objetos

create table pais_2(
    pais_id numeric(10,0),
    clave varchar(5) not null,
    nombre varchar(40) not null,
    zona_economica char(1) not null,
    constraint pais_2_pk primary key(pais_id)
);

create table empleado_2(
    empleado_id numeric(10,0),
    jefe_id numeric(10,0) not null,
    nombre varchar(40) not null,
    ap_paterno varchar(40) not null,
    ap_materno varchar(40) not null,
    folio_certificacion varchar(10),
    constraint empleado_2_pk primary key(empleado_id)
);

create table banco_2(
    banco_id numeric(10,0),
    clave varchar(10) not null,
    nombre varchar(40) not null,
    constraint banco_2_pk primary key(banco_id)
);

create table sucursal_2(
    sucursal_id numeric(10,0),
    num_sucursal numeric(3,0) not null,
    banco_id numeric(10,0) not null,
    pais_id numeric(10,0) not null,
    gerente_id numeric(10,0) not null,
    constraint sucursal_2_pk primary key(sucursal_id),
    constraint sucursal_2_banco_id_fk 
    foreing key (banco_id)
    references banco_2(banco_id)
);

create table cuenta_4(
    cuenta_id numeric(10,0),
    contrato blob(40) not null,
    sucursal_id numeric(10,0) not null,
    constraint cuenta_4_pk primary key(cuenta_id)
);

create table movimiento_3(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob(40),
    constraint cuenta_4_cuenta_id_fk
    foreing key (cuenta_id)
    references cuenta_4(cuenta_id),
    constraint movimiento_3_pk 
    primary key(num_movimiento,cuenta_id)

);

create table cuenta_2(
    cuenta_id numeric(10,0),
    contrato blob(40) not null,
    sucursal_id numeric(10,0) not null,
    constraint cuenta_2_pk primary key(cuenta_id)
);

create table movimiento_1(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob(40),
    constraint cuenta_2_cuenta_id_fk
    foreing key (cuenta_id)
    references cuenta_2(cuenta_id),
    constraint movimiento_1_pk 
    primary key(num_movimiento,cuenta_id)

);

commit;