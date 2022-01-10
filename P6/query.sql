--@Author: Flores García Karina
--@Fecha creación:  18/10/2021
--@Descripción: --Procedimiento empleado para exportar un el contenido de una columna BLOB a
--un archivo. Se emplea el valor de la llave primaria para localizar el registro.

    v_query := 'select '
		||v_blob_column_name
		||' into :ph_blob '
		||' from '
		||v_table_name
		||' where '
		||v_valid_pk_column_name
		||'= :ph_pk_column_value';

	if v_pk2_column_name is not null then
    	v_query := v_query 
      	|| ' and ' 
      	|| v_valid_pk2_column_name 
      	|| '= :ph_pk2_column_value';
  	end if;

	dbms_output.put_line('done------------');
	--ejecuta query dinámico
	if v_pk2_column_name is not null then
		execute immediate v_query into v_blob using
		v_pk_column_value,v_pk2_column_value;
	else
		execute immediate v_query into v_blob using
		v_pk_column_value;
	end if;
	