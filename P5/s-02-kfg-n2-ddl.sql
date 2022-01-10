--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Creación de fragmento 1 y sus objetos
--Prompt Conectando a kfgbdd_s2
--connect bancos_bdd@kfgbdd_s2 as sysdba

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
	v_movimiento1 varchar2(30)	:= 'F_KFG_MOVIMIENTO_1';
	v_movimiento3 varchar2(30)	:= 'F_KFG_MOVIMIENTO_3';
	v_cuenta2 varchar2(30) 	:= 'F_KFG_CUENTA_2';
	v_cuenta4 varchar2(30)	:= 'F_KFG_CUENTA_4';
	v_sucursal2 varchar2(30) 	:= 'F_KFG_SUCURSAL_2';
	v_banco2 varchar2(30) 	:= 'F_KFG_BANCO_2';
	v_empleado2 varchar2(30) 	:= 'F_KFG_EMPLEADO_2';
	v_pais2 varchar2(30) 		:= 'F_KFG_PAIS_2';
begin
    drop_table_if_exists(v_movimiento1);
	drop_table_if_exists(v_movimiento3);
	drop_table_if_exists(v_cuenta2);
	drop_table_if_exists(v_cuenta4);
	drop_table_if_exists(v_sucursal2);
	drop_table_if_exists(v_banco2);
	drop_table_if_exists(v_empleado2);
	drop_table_if_exists(v_pais2);
end;
/


Prompt Creando objetos para nodo 2


create table f_kfg_pais_2(
    pais_id numeric(10,0),
    clave varchar(5) not null,
    nombre varchar(40) not null,
    zona_economica char(1) not null,
    constraint f_kfg_pais_2_pk primary key(pais_id)
);

create table f_kfg_empleado_2(
    empleado_id numeric(10,0),
    jefe_id numeric(10,0),
    nombre varchar(40) not null,
    ap_paterno varchar(40) not null,
    ap_materno varchar(40) not null,
    folio_certificacion varchar(10),
    constraint f_kfg_empleado_2_pk primary key(empleado_id)
);

create table f_kfg_banco_2(
    banco_id numeric(10,0),
    clave varchar(10) not null,
    nombre varchar(40) not null,
    constraint f_kfg_banco_2_pk primary key(banco_id)
);

create table f_kfg_sucursal_2(
    sucursal_id numeric(10,0),
    num_sucursal numeric(3,0) not null,
    banco_id numeric(10,0) not null,
    pais_id numeric(10,0) not null,
    gerente_id numeric(10,0) not null,
    constraint f_kfg_sucursal_2_pk primary key(sucursal_id),
    constraint f_kfg_sucursal_2_banco_id_fk 
    foreign key (banco_id)
    references f_kfg_banco_2(banco_id)
);

create table f_kfg_cuenta_4(
    cuenta_id numeric(10,0),
    num_cuenta varchar2(18) not null,
    tipo_cuenta char(1) not null,
    sucursal_id numeric(10,0) not null,
    constraint f_kfg_cuenta_4_pk primary key(cuenta_id),
    constraint f_kfg_cuenta_4_sucursal_id_fk foreign key (sucursal_id)
    references f_kfg_sucursal_2(sucursal_id)
);

create table f_kfg_movimiento_3(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob,
    constraint f_kfg_cuenta_4_cuenta_id_fk
    foreign key (cuenta_id)
    references f_kfg_cuenta_4(cuenta_id),
    constraint f_kfg_movimiento_3_pk 
    primary key (num_movimiento,cuenta_id)
);

create table f_kfg_cuenta_2(
    cuenta_id numeric(10,0),
    contrato blob not null,
    sucursal_id numeric(10,0) not null,
    constraint f_kfg_cuenta_2_pk primary key(cuenta_id)
);

create table f_kfg_movimiento_1(
    num_movimiento numeric(10,0),
    cuenta_id numeric(10,0),
    fecha_movimiento date not null,
    tipo_movimiento char(1) not null,
    importe numeric(18,2) not null,
    descripcion varchar(2000) not null,
    comprobante blob, 
    constraint f_kfg_cuenta_2_cuenta_id_fk
    foreign key (cuenta_id)
    references f_kfg_cuenta_2(cuenta_id),
    constraint f_kfg_movimiento_1_pk 
    primary key (num_movimiento,cuenta_id)
);

Prompt Creacion completa n2