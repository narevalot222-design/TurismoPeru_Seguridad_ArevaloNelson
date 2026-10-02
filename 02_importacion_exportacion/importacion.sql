USE TURISMOPERU_ATNO;
GO

-- 1. Crear tabla staging/temporal para BCP
IF OBJECT_ID('ATNO.cliente_importacion', 'U') IS NOT NULL 
    DROP TABLE ATNO.cliente_importacion;
GO

CREATE TABLE ATNO.cliente_importacion (
    Documento VARCHAR(20),
    Nombres VARCHAR(100),
    ApellidoPaterno VARCHAR(100),
    ApellidoMaterno VARCHAR(100)
);
GO

/*
-- 2. Comando BCP a ejecutar en la consola CMD de Windows:
bcp TURISMOPERU_ATNO.ATNO.cliente_importacion in "C:\ruta_donde_esta_tu_csv\clientes.csv" -c -t"," -rn -S localhost -T
*/

-- 3. Insertar datos en ATNO.persona evitando duplicados
INSERT INTO ATNO.persona (numero_documento, nombres, apaterno, amaterno)
SELECT DISTINCT 
    stg.Documento, 
    stg.Nombres, 
    stg.ApellidoPaterno, 
    stg.ApellidoMaterno
FROM ATNO.cliente_importacion stg
WHERE stg.Documento IS NOT NULL 
  AND NOT EXISTS (
      SELECT 1 FROM ATNO.persona p WHERE p.numero_documento = stg.Documento
  );
GO

-- 4. Registrar como clientes en ATNO.cliente usando el id_persona creado
INSERT INTO ATNO.cliente (id_persona)
SELECT p.id_persona
FROM ATNO.persona p
INNER JOIN ATNO.cliente_importacion stg ON p.numero_documento = stg.Documento
WHERE NOT EXISTS (
    SELECT 1 FROM ATNO.cliente c WHERE c.id_persona = p.id_persona
);
GO