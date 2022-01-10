begin
dbms_refresh.add(
name => 'pagos_auto_refresh_g1',
list => 'mv_cliente',
lax => false --true si la vista va a realizar cambio de grupo.
);
end;
/