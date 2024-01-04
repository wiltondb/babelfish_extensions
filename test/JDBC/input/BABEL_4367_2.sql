-- Test for DROP stmt inside transaction blocks
-- check for both rollbacks and commit

CREATE TABLE BABEL_4367_1 (
    id INT
)
GO
CREATE TABLE BABEL_4367_2 (
    id INT
)
GO

CREATE VIEW BABEL_4367_V_1 AS SELECT 1
GO
CREATE VIEW BABEL_4367_V_2 AS SELECT 1
GO

CREATE FUNCTION BABEL_4367_F1()
RETURNS BIGINT
AS BEGIN RETURN 10 END
GO
CREATE FUNCTION BABEL_4367_F2()
RETURNS BIGINT
AS BEGIN RETURN 10 END
GO

CREATE TYPE BABEL_4367_T_1 from datetime
GO
CREATE TYPE BABEL_4367_T_2 from datetime
GO

CREATE PROCEDURE BABEL_4367_P_1
AS
SELECT 'dummyProc' 
GO
CREATE PROCEDURE BABEL_4367_P_2
AS
SELECT 'dummyProc'
GO

CREATE SEQUENCE BABEL_4367_S_1
GO
CREATE SEQUENCE BABEL_4367_S_2
GO

-- BEGIN TRANSACTION -- ROLLBACK
BEGIN TRANSACTION
GO

DROP PROCEDURE BABEL_4367_P_1
GO
DROP PROCEDURE IF EXISTS BABEL_4367_P_2
GO

DROP SEQUENCE BABEL_4367_S_1
GO
DROP SEQUENCE IF EXISTS BABEL_4367_S_2
GO

DROP VIEW BABEL_4367_V_1
GO
DROP VIEW IF EXISTS BABEL_4367_V_2
GO

DROP TABLE BABEL_4367_1
GO
DROP TABLE IF EXISTS BABEL_4367_2
GO

DROP FUNCTION BABEL_4367_F1
GO
DROP FUNCTION IF EXISTS BABEL_4367_F2
GO

DROP TYPE BABEL_4367_T_1
GO
DROP TYPE IF EXISTS BABEL_4367_T_2
GO

SELECT @@trancount
GO

SELECT name FROM sys.objects WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO
SELECT name FROM sys.types WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO

ROLLBACK
GO

-- Check if all objects still exists
SELECT name FROM sys.objects WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO
SELECT name FROM sys.types WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO

-- BEGIN TRANSACTION -- COMMIT
BEGIN TRANSACTION
GO

DROP PROCEDURE BABEL_4367_P_1
GO
DROP PROCEDURE IF EXISTS BABEL_4367_P_2
GO

DROP SEQUENCE BABEL_4367_S_1
GO
DROP SEQUENCE IF EXISTS BABEL_4367_S_2
GO

DROP VIEW BABEL_4367_V_1
GO
DROP VIEW IF EXISTS BABEL_4367_V_2
GO

DROP TABLE BABEL_4367_1
GO
DROP TABLE IF EXISTS BABEL_4367_2
GO

DROP FUNCTION BABEL_4367_F1
GO
DROP FUNCTION IF EXISTS BABEL_4367_F2
GO

DROP TYPE BABEL_4367_T_1
GO
DROP TYPE IF EXISTS BABEL_4367_T_2
GO

SELECT @@trancount
GO

SELECT name FROM sys.objects WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO
SELECT name FROM sys.types WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO

COMMIT
GO

-- Check if all objects are dropped
SELECT name FROM sys.objects WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO
SELECT name FROM sys.types WHERE name LIKE 'babel_4367_%' ORDER BY name ASC
GO