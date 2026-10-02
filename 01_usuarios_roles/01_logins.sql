USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'turismo_admin')
    CREATE LOGIN turismo_admin WITH PASSWORD = 'AdminPassword123!';

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'turismo_vendedor')
    CREATE LOGIN turismo_vendedor WITH PASSWORD = 'VendedorPassword123!';

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'turismo_analista')
    CREATE LOGIN turismo_analista WITH PASSWORD = 'AnalistaPassword123!';
GO