--@Autor: Karina Flores García
--@Fecha creación: 15/12/2021
--@Descripción: Creación de tabla e inserciones ejercicio tema 6

Prompt Conectando a S1 - kfgbdd_s1
connect tema6_bdd/tema6_bdd@kfgbdd_s1


Prompt Creando objetos para ejercicio tema 6

create table prod(
    prod_id number(10,0) not null,
    nombre varchar(40),
    existencias number(10,0),
    constraint prod_pk primary key(prod_id)
);


Prompt Insercion de datos para ejercicio tema 6

insert into prod (prod_id,nombre,existencias) values(1,'estrellas',10);
insert into prod (prod_id,nombre,existencias) values(2,'soles',5);
insert into prod (prod_id,nombre,existencias) values(3,'planetas',3);