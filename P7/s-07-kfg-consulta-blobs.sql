--@Autor: FKarina Flores Garcia
--@Fecha creación: 26/11/21
--@Descripción: Consultas para validar vistas con columnas BLOB

Prompt Conectandose a kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1

Prompt movimiento estrategia 1
select num_movimiento, dbms_lob.getlength(comprobante) as longitud
from movimiento_e1;

Prompt movimiento estrategia 2
select num_movimiento, dbms_lob.getlength(comprobante) as longitud
from movimiento_e2;

Prompt movimiento, uso de sinonimo
select num_movimiento, dbms_lob.getlength(comprobante) as longitud
from movimientos;

Prompt cuenta estrategia 1
select cuenta_id, dbms_lob.getlength(contrato) as longitud
from cuenta_e1;

Prompt cuenta estrategia 2
select cuenta_id, dbms_lob.getlength(contrato) as longitud
from cuenta_e2;

Prompt cuenta, uso de sinonimo
select cuenta_id, dbms_lob.getlength(contrato) as longitud
from cuentas;



Prompt Conectandose a kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
-- En este sitio solo se usa la vista ya que el dato BLOB se encuentra de forma local.

Prompt movimiento estrategia 1
select num_movimiento,dbms_lob.getlength(comprobante) as longitud
from movimiento_e1;

Prompt movimiento estrategia 2
select num_movimiento,dbms_lob.getlength(comprobante) as longitud
from movimiento_e2;

Prompt movimiento, uso de sinonimo
select num_movimiento,dbms_lob.getlength(comprobante) as longitud
from movimientos;

--Cuenta es completamente local 
Prompt cuenta uso de la vista (acceso local al dato BLOB)
select cuenta_id,dbms_lob.getlength(contrato) as longitud
from cuenta;


Prompt Listo!
exit