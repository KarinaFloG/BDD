--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Creación de fragmento 1 y sus objetos

create table pais_1(
    pais_id numeric(10,0),
    clave varchar(5) not null,
    nombre varchar(40) not null,
    zona_economica char(1) not null,
    constraint pais_1_pk primary key(pais_id)
);

create table empleado_1(
    empleado_id numeric(10,0),
    jefe_id numeric(10,0) not null,
    nombre varchar(40) not null,
    ap_paterno varchar(40) not null,
    ap_materno varchar(40) not null,
    folio_certificacion varchar(10),
    constraint empleado_1_pk primary key(empleado_id)
);

create table banco_1(
    banco_id numeric(10,0),
    clave varchar(10) not null,
    nombre varchar(40) not null,
    constraint banco_1_pk primary key(banco_id)
);

create table sucursal_1(
    sucursal_id numeric(10,0),
    num_sucursal numeric(3,0) not null,
    banco_id numeric(10,0) not null,
    pais_id numeric(10,0) not null,
    gerente_id numeric(10,0) not null,
    constraint sucursal_1_pk primary key(sucursal_id),
    constraint sucursal_1_banco_id_fk 
    foreing key (banco_id)
    references banco_1(banco_id)
);

create table cuenta_3(
    cuenta_id numeric(10,0),
    num_cuenta varchar(18) not null,
    tipo_cuenta char(1) not null,
    sucursal_id numeric(10,0) not null,
    constraint cuenta_3_pk primary key(cuenta_id),
    constraint sucursal_1_sucursal_id_fk
    foreing key (sucursal_id)
    references sucursal_1(sucursal_id)
);

create table cuenta_1(
    cuenta_id numeric(10,0),
    saldo numeric(18,2) not null,
    nip numeric(4,0) not null,
    sucursal_id numeric(10,0) not null
);

create table movimiento_2(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob(40),
    constraint cuenta_3_cuenta_id_fk
    foreing key (cuenta_id)
    references cuenta_3(cuenta_id),
    constraint movimiento_2_pk 
    primary key(num_movimiento,cuenta_id)

);

commit;
