USE TURISMOPERU_ATNO;
GO

-- Crear roles
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rol_vendedor' AND type = 'R')
    CREATE ROLE rol_vendedor;

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'rol_analista' AND type = 'R')
    CREATE ROLE rol_analista;

-- Asignar usuarios a los roles
ALTER ROLE rol_vendedor ADD MEMBER turismo_vendedor;
ALTER ROLE rol_analista ADD MEMBER turismo_analista;
ALTER ROLE db_owner ADD MEMBER turismo_admin;
GO