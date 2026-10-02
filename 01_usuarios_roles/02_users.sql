USE TURISMOPERU_ATNO;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'turismo_admin')
    CREATE USER turismo_admin FOR LOGIN turismo_admin;

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'turismo_vendedor')
    CREATE USER turismo_vendedor WITHOUT LOGIN;

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'turismo_analista')
    CREATE USER turismo_analista WITHOUT LOGIN;
GO