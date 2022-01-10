--@Autor: Karina Flores García
--@Fecha creación: 15/12/2021
--@Descripción: Procedimiento almacenado para control de concurrencia pesimista del Tema 6

Prompt Conectando a S1 - kfgbdd_s1
connect tema6_bdd/tema6_bdd@kfgbdd_s1

Prompt Creando procedimiento almacenado para concurrencia pesimista

create or replace procedure disminuyeExistenciasPesimista(
p_prod_id number, p_cantidad number) is
v_actualizados number;
v_existencias number;
begin
loop
    select existencias into v_existencias
    from prod
    where prod_id = p_prod_id
    for update;
    --actualiza el inventario con base a la compra realizada.
    update prod
    set existencias = p_cantidad 
    where prod_id = p_prod_id;
    v_actualizados := sql%rowcount;
    if v_actualizados > 0 then
        exit;
    else
    --no se sale del ciclo, reintenta.
        null;
    end if;
end loop;
end;
/
show errors;
