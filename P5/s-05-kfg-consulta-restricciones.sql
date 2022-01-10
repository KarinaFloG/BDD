--@Autor: Flores García Karina
--@Fecha creación: octubre 2021
--@Descripción: Script que muestra las restricciones de referencia en los fragmentos

Prompt mostrando lista de restricciones de referencia
col tabla_padre format A30
col tabla_hija format A30
col nombre_restriccion format A30
set linesize 200

select h.table_name as tabla_hija,
h.constraint_name as nombre_restriccion, 
p.table_name as tabla_padre,
h.constraint_type
from user_constraints h
join user_constraints p
on h.r_constraint_name = p.constraint_name
where h.constraint_type='R';