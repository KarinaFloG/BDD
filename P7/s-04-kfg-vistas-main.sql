--@Autor: Herrera Gandarela Gabriel Alejandro
--@Fecha creación: 26/11/21
--@Descripción: Script de ejecución para crear de vistas
-- en ambas PDBs
Prompt conectandose a kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
Prompt creando vistas en kfgbdd_s1
@s-04-kfg-def-vistas.sql
Prompt conectandose a kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
Prompt creando vistas en kfgbdd_s2
@s-04-kfg-def-vistas.sql
Prompt Listo!
exit