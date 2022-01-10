--@Autor: Karina Flores García
--@Fecha creación: octubre 2021
--@Descripción: Consulta de restricciones de referencia en jrc-pc

Prompt Conectando a S1 - kfg_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
--ejecuta la misma consulta en ambas pdbs
@s-05-kfg-consulta-restricciones.sql
Prompt Conectando a S2 - kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s1
--ejecuta la misma consulta en ambas pdbs
@s-05-kfg-consulta-restricciones.sql
Prompt Listo!
exit