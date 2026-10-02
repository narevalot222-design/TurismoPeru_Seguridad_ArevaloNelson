USE TURISMOPERU_ATNO;
GO
SET NOCOUNT ON;

PRINT '===== PRUEBAS DE SEGURIDAD =====';

-- Prueba 1: analista PUEDE consultar
BEGIN TRY
    EXECUTE AS USER = 'turismo_analista';
    SELECT TOP 5 * FROM ATNO.pago;
    REVERT;
    PRINT 'PRUEBA 1 OK: el analista puede hacer SELECT en pago.';
END TRY
BEGIN CATCH
    REVERT;
    PRINT 'PRUEBA 1 FALLO (no debería): ' + ERROR_MESSAGE();
END CATCH

-- Prueba 2: analista NO puede insertar
BEGIN TRY
    EXECUTE AS USER = 'turismo_analista';
    INSERT INTO ATNO.pago (id_reserva, id_medio_pago, monto) VALUES (1, 1, 100.00);
    REVERT;
    PRINT 'PRUEBA 2 FALLO: el analista logró insertar.';
END TRY
BEGIN CATCH
    REVERT;
    PRINT 'PRUEBA 2 OK (INSERT rechazado): ' + ERROR_MESSAGE();
END CATCH

-- Prueba 3: vendedor NO puede borrar clientes
BEGIN TRY
    EXECUTE AS USER = 'turismo_vendedor';
    DELETE FROM ATNO.cliente WHERE 1 = 0;
    REVERT;
    PRINT 'PRUEBA 3 FALLO: el vendedor logró borrar clientes.';
END TRY
BEGIN CATCH
    REVERT;
    PRINT 'PRUEBA 3 OK (DELETE rechazado): ' + ERROR_MESSAGE();
END CATCH

-- Prueba 4: vendedor PUEDE consultar clientes
BEGIN TRY
    EXECUTE AS USER = 'turismo_vendedor';
    SELECT TOP 3 * FROM ATNO.cliente;
    REVERT;
    PRINT 'PRUEBA 4 OK: el vendedor puede hacer SELECT en cliente.';
END TRY
BEGIN CATCH
    REVERT;
    PRINT 'PRUEBA 4 FALLO (no debería): ' + ERROR_MESSAGE();
END CATCH
GO