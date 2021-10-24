--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Script que muestra las restricciones de referencia en los fragmentos

Prompt mostrando lista de restricciones de referencia
col tabla_padre format A30
col tabla_hija format A30
col nombre_restriccion format A30
set linesize 200

select table_name as tabla_hija,
constraint_name as nombre_restriccion, 
from user_constraints 
where constraint_type='R';