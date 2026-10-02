USE TURISMOPERU_ATNO;
GO

-- Consulta 1: KPIs Principales
SELECT 
    (SELECT COUNT(*) FROM ATNO.reserva) AS Total_Reservas,
    (SELECT ISNULL(SUM(monto), 0) FROM ATNO.pago) AS Total_Ingresos,
    (SELECT COUNT(*) FROM ATNO.cliente) AS Total_Clientes,
    (SELECT ISNULL(SUM(monto), 0) / NULLIF(COUNT(DISTINCT id_reserva), 0) FROM ATNO.pago) AS Ticket_Promedio;

-- Consulta 2: Reservas por Estado
SELECT 
    id_estado_reserva, 
    COUNT(*) AS Total_Reservas
FROM ATNO.reserva
GROUP BY id_estado_reserva;

-- Consulta 3: Ingresos por Medio de Pago
SELECT 
    mp.nombre AS Medio_Pago,
    ISNULL(SUM(p.monto), 0) AS Total_Ingresado
FROM ATNO.pago p
INNER JOIN ATNO.medio_pago mp ON p.id_medio_pago = mp.id_medio_pago
GROUP BY mp.nombre;

-- Consulta 4: Top 10 Clientes con Mayor Gasto
SELECT TOP 10 
    c.id_persona,
    CONCAT(p.nombres, ' ', p.apaterno) AS Nombre_Cliente,
    COUNT(r.id_reserva) AS Cantidad_Reservas,
    ISNULL(SUM(pg.monto), 0) AS Total_Gastado
FROM ATNO.cliente c
INNER JOIN ATNO.persona p ON c.id_persona = p.id_persona
LEFT JOIN ATNO.reserva r ON c.id_persona = r.id_cliente
LEFT JOIN ATNO.pago pg ON r.id_reserva = pg.id_reserva
GROUP BY c.id_persona, p.nombres, p.apaterno
ORDER BY Total_Gastado DESC;
GO