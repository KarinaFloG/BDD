--@Author: Flores García Karina
--@Fecha creación: 18/11/2021
--@Descripción: Lectura y carga de archivos blob


--ruta donde se ubicarán los archivos PDFs
define p_pdf_path='/tmp/bdd/p06'
set verify off

Prompt Limpiando y creando directorio en /tmp/bdd/p06
!rm -rf &p_pdf_path
!mkdir -p &p_pdf_path
!chmod 777 &p_pdf_path

-- Se asume que los archivos PDF se encuentran en el mismo directorio donde se
-- ejecuta este script.
!cp m_archivo_*.pdf &p_pdf_path
!chmod 755 &p_pdf_path/m_archivo_*.pdf
--kfgbdd_s1
Prompt conectando a kfgbdd_s1 como SYS para crear objetos tipo directory
accept p_sys_password default 'system' prompt 'Password de sys [system]: ' hide
connect sys@kfgbdd_s1/&p_sys_password as sysdba
Prompt creando un objeto DIRECTORY para acceder al directorio /tmp/bdd/p06
create or replace directory tmp_dir as '&p_pdf_path';
grant read,write on directory tmp_dir to bancos_bdd;

--kfgbdd_s2
Prompt conectando a kfgbdd_s2 como SYS para crear objetos tipo directory
accept p_sys_password default 'system' prompt 'Password de sys [system]: ' hide
connect sys@kfgbdd_s2/&p_sys_password as sysdba
Prompt creando un objeto DIRECTORY para acceder al directorio /tmp/bdd/p06
create or replace directory tmp_dir as '&p_pdf_path';
grant read,write on directory tmp_dir to bancos_bdd;

------------------ Cargando datos en kfgbdd_s1 ----------------------
Prompt conectando a kfgbdd_s1 con usuario bancos_bdd para cargar datos binarios
connect bancos_bdd/bancos_bdd@kfgbdd_s1
/*
En este sitio se cargarán los siguientes archivos.
F_kfg_MOVIMIENTO_2
NUM_MOVIMIENTO CUENTA_ID COMPROBANTE
-------------- ---------- -----------
2 1 m_archivo_4.pdf
*/
Prompt ejecutando procedimientos para hacer import/export de datos BLOB
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql
Prompt cargando datos binarios
begin
carga_blob_en_bd('TMP_DIR','m_archivo_4.pdf','f_kfg_movimiento_2',
'comprobante','num_movimiento','2','cuenta_id','1');
end;
/
Prompt mostrando el tamaño de los objetos BLOB en BD.
Prompt Para f_kfg_movimiento_2:
select cuenta_id,num_movimiento,dbms_lob.getlength(comprobante) as longitud
from f_kfg_movimiento_2;
Prompt salvando datos BLOB en directorio TMP_DIR
begin
guarda_blob_en_archivo('TMP_DIR','m_export_archivo_4.pdf',
'f_kfg_movimiento_2','comprobante','cuenta_id','1','num_movimiento','2');
end;
/
Prompt mostrando el contenido del directorio para validar la existencia del archivo.
!ls -l &p_pdf_path/m_archivo_*.pdf

------------------ Cargando datos en kfgbdd_s2 ----------------------
--Seguir el mismo procedimiento para kfgbdd_s2
Prompt conectando a kfgbdd_s2 con usuario bancos_bdd para cargar datos binarios
connect bancos_bdd/bancos_bdd@kfgbdd_s2
/*
En este sitio se cargarán los siguientes archivos.
F_KFG_MOVIMIENTO_3
NUM_MOVIMIENTO CUENTA_ID COMPROBANTE
-------------- ---------- -----------
3              2          m_archivo_5.pdf

F_KFG_MOVIMIENTO_1
NUM_MOVIMIENTO CUENTA_ID COMPROBANTE
-------------- ---------- -----------
1              1          m_archivo_3.pdf

F_KFG_CUENTA_2
CUENTA_ID  CONTRATO
---------  ---------
1          m_archivo_1.pdf
2          m_archivo_2.pdf

*/
Prompt ejecutando procedimientos para hacer import/export de datos BLOB
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql
Prompt cargando datos binarios.

begin
carga_blob_en_bd('TMP_DIR','m_archivo_3.pdf','f_kfg_movimiento_1',
'comprobante','num_movimiento','1','cuenta_id','1');
carga_blob_en_bd('TMP_DIR','m_archivo_5.pdf','f_kfg_movimiento_3',
'comprobante','num_movimiento','3','cuenta_id','2');
carga_blob_en_bd('TMP_DIR','m_archivo_1.pdf','f_kfg_cuenta_2',
'contrato','cuenta_id','1',null,null);
carga_blob_en_bd('TMP_DIR','m_archivo_2.pdf','f_kfg_cuenta_2',
'contrato','cuenta_id','2',null,null);
end;
/

Prompt mostrando el tamaño de los objetos BLOB en BD.
Prompt Para f_kfg_movimiento_1:
select cuenta_id,num_movimiento,dbms_lob.getlength(comprobante) as longitud
from f_kfg_movimiento_1;
Prompt Para f_kfg_movimiento_3:
select cuenta_id,num_movimiento,dbms_lob.getlength(comprobante) as longitud
from f_kfg_movimiento_3;
Prompt Para f_kfg_cuenta_2:
select cuenta_id,dbms_lob.getlength(contrato) as longitud
from f_kfg_cuenta_2;
Prompt salvando datos BLOB en directorio TMP_DIR
begin
guarda_blob_en_archivo('TMP_DIR','m_export_archivo_3.pdf',
'f_kfg_movimiento_1','comprobante','cuenta_id','1','num_movimiento','1');

guarda_blob_en_archivo('TMP_DIR','m_export_archivo_5.pdf',
'f_kfg_movimiento_3','comprobante','cuenta_id','2','num_movimiento','3');

guarda_blob_en_archivo('TMP_DIR','m_export_archivo_1.pdf',
'f_kfg_cuenta_2','contrato','cuenta_id','1', null, null);

guarda_blob_en_archivo('TMP_DIR','m_export_archivo_2.pdf',
'f_kfg_cuenta_2','contrato','cuenta_id','2', null, null);
end;
/

Prompt mostrando el contenido del directorio para validar la existencia del archivo.
!ls -l &p_pdf_path/m_export_archivo_*.pdf

Prompt Listo!
whenever sql exit rollback;
disconnect