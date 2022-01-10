--@Autor: Karina Flores García
--@Fecha creación: 15/10/2021
--@Descripción: Archivo de carga inicial en kfg-pc

Prompt Conectando a S1 - kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
--si ocurre un error, la ejecución se detiene.
whenever sqlerror exit rollback;
Prompt limpiando.
delete from f_kfg_pais_1;
delete from f_kfg_banco_1;
delete from f_kfg_empleado_1;
delete from f_kfg_sucursal_1;
delete from f_kfg_cuenta_1;
delete from f_kfg_cuenta_3;
delete from f_kfg_movimiento_2;

Prompt Cargando datos
insert into f_kfg_pais_1(pais_id,clave,nombre,zona_economica) values (1,'MX','MEXICO','A');
insert into f_kfg_banco_1(banco_id,clave,nombre) values (1,'BB003','Banco Azteca');
insert into f_kfg_empleado_1(empleado_id,nombre,ap_paterno,ap_materno,folio_certificacion,jefe_id) values (1,'JUAN','LOPEZ','LARA',null,null);
insert into f_kfg_sucursal_1(sucursal_id,num_sucursal,banco_id,pais_id,gerente_id) values (1,100,1,1,1);
insert into f_kfg_sucursal_1(sucursal_id,num_sucursal,banco_id,pais_id,gerente_id) values (2,200,1,2,2);
insert into f_kfg_cuenta_1(cuenta_id,nip,saldo,sucursal_id) values (1,1234,45894.23,1);
insert into f_kfg_cuenta_3(cuenta_id,num_cuenta,tipo_cuenta,sucursal_id) values (1,800600400,'D',1);
insert into f_kfg_cuenta_1(cuenta_id,nip,saldo,sucursal_id) values (2,4321,100500.56,4);
insert into f_kfg_movimiento_2(num_movimiento, cuenta_id, fecha_movimiento, tipo_movimiento, importe, descripcion) values (2, 1, to_date('01-01-2015 12:00:15','dd-mm-yyyy hh24:mi:ss'), 'D', 500596.25, 'PAGO BONO PRODUCTIVIDAD');
--hacer commit al terminar
commit;

Prompt Conectando a S2 - kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
--si ocurre un error, la ejecución se detiene.
whenever sqlerror exit rollback;
Prompt limpiando.
delete from f_kfg_pais_2;
delete from f_kfg_banco_2;
delete from f_kfg_empleado_2;
delete from f_kfg_sucursal_2;
delete from f_kfg_cuenta_2;
delete from f_kfg_cuenta_4;
delete from f_kfg_movimiento_1;
delete from f_kfg_movimiento_3;


Prompt Cargando datos
insert into f_kfg_pais_2(pais_id,clave,nombre,zona_economica) values (2,'JAP','JAPON','B');
insert into f_kfg_banco_2(banco_id,clave,nombre) values (2,'SS032','BBVA');
insert into f_kfg_empleado_2(empleado_id,nombre,ap_paterno,ap_materno,folio_certificacion,jefe_id) values (2,'CARLOS','BAEZ','AGUIRRE',900200,1);
insert into f_kfg_sucursal_2(sucursal_id,num_sucursal,banco_id,pais_id,gerente_id) values (3,300,2,1,1);
insert into f_kfg_sucursal_2(sucursal_id,num_sucursal,banco_id,pais_id,gerente_id) values (4,400,2,2,2);
insert into f_kfg_cuenta_2(cuenta_id,contrato,sucursal_id) values (1,empty_blob(),1);
insert into f_kfg_cuenta_2(cuenta_id,contrato,sucursal_id) values (2,empty_blob(),4);
insert into f_kfg_cuenta_4(cuenta_id,num_cuenta,tipo_cuenta,sucursal_id) values (2,900700500,'V',4);
insert into f_kfg_movimiento_1(num_movimiento,cuenta_id,fecha_movimiento,tipo_movimiento,importe,descripcion,comprobante) values (1,1,to_date('01-01-1980 14:55:31','dd-mm-yyyy hh24:mi:ss'),'D',85745.56,'PAGO AGUINALDO',empty_blob());
insert into f_kfg_movimiento_3(num_movimiento, cuenta_id, fecha_movimiento, tipo_movimiento, importe, descripcion) values (3, 2, to_date('01/01/2016 19:05:04','dd/mm/yyyy hh24:mi:ss' ), 'R', 40200.32, 'RETIRA LETRA AUTO');
commit;
Prompt Listo!
exit