begin
dbms_refresh.make(
name => 'pagos_auto_refresh_g1',
list => 'mv_orden_compra_anual, mv_pago_auto_anual',
next_date => sysdate,
interval => 'sysdate + 1/(24*60)',
refresh_after_errors => false
);
end;
/