--@Autor: Karina Fores García
--@Fecha creación: 17/12/2021
--@Descripción: Creación de triggers

whenever sqlerror exit rollback
Prompt =================================
Prompt creando triggers en S1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
Prompt =================================
Prompt creando trigger para pais
@s-03-kfg-pais-trigger.sql
show errors

Prompt creando trigger para sucursal
@s-03-kfg-n1-sucursal-trigger.sql
show errors

Prompt creando trigger para cuenta
@s-03-kfg-n1-cuenta.sql
show errors

Prompt creando trigger para movimiento
@s-03-kfg-n1-movimiento-trigger.sql
show errors

Prompt =================================
Prompt creando triggers en S2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
Prompt =================================
Prompt creando trigger para pais
@s-03-kfg-pais-trigger.sql
show errors

Prompt creando trigger para sucursal
@s-03-kfg-n2-sucursal-trigger.sql
show errors

Prompt creando trigger para cuenta
@s-03-kfg-n2-cuenta.sql
show errors

Prompt creando trigger para movimiento
@s-03-kfg-n2-movimiento-trigger.sql
show errors

Prompt Listo!
exit