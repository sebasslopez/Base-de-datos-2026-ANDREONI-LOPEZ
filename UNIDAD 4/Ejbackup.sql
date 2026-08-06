delete from reporte_ventas;

SHOW BINARY LOGS;

SHOW MASTER STATUS;
SHOW BINLOG EVENTS in 'binlog.000280' LIMIT 10;

select * from performance_schema.error_log
order by LOGGED DESC limit 20;

