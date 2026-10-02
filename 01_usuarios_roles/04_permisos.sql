USE TURISMOPERU_ATNO;
GO

-- Permisos para rol_vendedor
GRANT SELECT, INSERT ON ATNO.cliente TO rol_vendedor;
GRANT SELECT, INSERT ON ATNO.reserva TO rol_vendedor;
GRANT SELECT ON ATNO.alojamiento TO rol_vendedor;
GRANT SELECT ON ATNO.habitacion TO rol_vendedor;
DENY DELETE ON ATNO.cliente TO rol_vendedor;
DENY DELETE ON ATNO.reserva TO rol_vendedor;

-- Permisos para rol_analista
GRANT SELECT ON ATNO.cliente TO rol_analista;
GRANT SELECT ON ATNO.reserva TO rol_analista;
GRANT SELECT ON ATNO.pago TO rol_analista;
GRANT SELECT ON ATNO.alojamiento TO rol_analista;
GRANT SELECT ON ATNO.habitacion TO rol_analista;
GRANT SELECT ON ATNO.paquete TO rol_analista;
GRANT SELECT ON ATNO.lugar_turistico TO rol_analista;
DENY INSERT, UPDATE, DELETE ON SCHEMA::ATNO TO rol_analista;
GO