--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Conexión a PDB y ejecución de scripts

Prompt Conectando a S1 - kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s1
Prompt mostrando lista de fragmentos
select table_name from user_tables order by table_name;

Prompt Conectando a S2 - kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s2
Prompt mostrando lista de fragmentos
select table_name from user_tables order by table_name;

Prompt Listo!
exit