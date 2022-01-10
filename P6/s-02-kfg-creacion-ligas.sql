--@Author: Flores García Karina
--@Fecha creación: 18/10/2021
--@Descripción: Creación de ligas privadas a las PDBs

prompt Creando liga en kfgbdd_s1 hacia kfgbdd_s2
connect bancos_bdd/bancos_bdd@kfgbdd_s1
create database link kfgbdd_s2.fi.unam using 'KFGBDD_S2';

prompt Creando liga en kfgbdd_s2 hacia kfgbdd_s1
connect bancos_bdd/bancos_bdd@kfgbdd_s2
create database link kfgbdd_s1.fi.unam using 'KFGBDD_S1';

prompt Listo!
exit
