--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Creación de fragmento 1 y sus objetos


create or replace procedure drop_table_if_exists(name in varchar2) is
	v_count number;
begin
	select count(*) 
	into v_count 
	from all_tables 
	where table_name = name;
	
	if (v_count > 0) then
       		execute immediate 'drop table ' || name || ' cascade constraints';
	end if;
end;
/

declare
	v_movimiento2 varchar2(30)	:= 'F_KFG_MOVIMIENTO_2';
	v_cuenta3 varchar2(30) 	:= 'F_KFG_CUENTA_3';
	v_cuenta1 varchar2(30)	:= 'F_KFG_CUENTA_1';
	v_sucursal1 varchar2(30) 	:= 'F_KFG_SUCURSAL_1';
	v_banco1 varchar2(30) 	:= 'F_KFG_BANCO_1';
	v_empleado1 varchar2(30) 	:= 'F_KFG_EMPLEADO_1';
	v_pais1 varchar2(30) 		:= 'F_KFG_PAIS_1';
begin
	drop_table_if_exists(v_movimiento2);
	drop_table_if_exists(v_cuenta3);
	drop_table_if_exists(v_cuenta1);
	drop_table_if_exists(v_sucursal1);
	drop_table_if_exists(v_banco1);
	drop_table_if_exists(v_empleado1);
	drop_table_if_exists(v_pais1);
end;
/


Prompt Creando objetos para nodo 1

create table f_kfg_pais_1(
    pais_id numeric(10,0),
    clave varchar(5) not null,
    nombre varchar(40) not null,
    zona_economica char(1) not null,
    constraint f_kfg_pais_1_pk primary key(pais_id)
);

create table f_kfg_empleado_1(
    empleado_id numeric(10,0),
    jefe_id numeric(10,0),
    nombre varchar(40) not null,
    ap_paterno varchar(40) not null,
    ap_materno varchar(40) not null,
    folio_certificacion varchar(10),
    constraint f_kfg_empleado_1_pk primary key(empleado_id)
);

create table f_kfg_banco_1(
    banco_id numeric(10,0),
    clave varchar(10) not null,
    nombre varchar(40) not null,
    constraint f_kfg_banco_1_pk primary key(banco_id)
);

create table f_kfg_sucursal_1(
    sucursal_id numeric(10,0),
    num_sucursal numeric(3,0) not null,
    banco_id numeric(10,0) not null,
    pais_id numeric(10,0) not null,
    gerente_id numeric(10,0) not null,
    constraint f_kfg_sucursal_1_pk primary key(sucursal_id),
    constraint f_kfg_sucursal_1_banco_id_fk foreign key (banco_id)
    references f_kfg_banco_1(banco_id)
);

create table f_kfg_cuenta_3(
    cuenta_id numeric(10,0),
    num_cuenta varchar(18) not null,
    tipo_cuenta char(1) not null,
    sucursal_id numeric(10,0) not null,
    constraint f_kfg_cuenta_3_pk primary key(cuenta_id),
    constraint f_kfg_sucursal_1_sucursal_id_fk
    foreign key (sucursal_id)
    references f_kfg_sucursal_1(sucursal_id)
);

create table f_kfg_cuenta_1(
    cuenta_id numeric(10,0),
    saldo numeric(18,2) not null,
    nip numeric(4,0) not null,
    sucursal_id numeric(10,0) not null,
    constraint f_kfg_cuenta_1_pk primary key(cuenta_id)
);

create table f_kfg_movimiento_2(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob,
    constraint f_kfg_cuenta_3_cuenta_id_fk
    foreign key (cuenta_id)
    references f_kfg_cuenta_3(cuenta_id),
    constraint f_kfg_movimiento_2_pk primary key (num_movimiento, cuenta_id)
);

Prompt Creacion completa n1s