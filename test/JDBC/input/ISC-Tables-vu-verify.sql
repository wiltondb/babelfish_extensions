SELECT * FROM information_schema.tables WHERE TABLE_NAME LIKE 'isc_tables%' ORDER BY TABLE_NAME
SELECT * FROM information_schema.tables WHERE TABLE_NAME LIKE 'ISC_TABLES%' ORDER BY TABLE_NAME
GO

SELECT * FROM information_schema.tables WHERE TABLE_SCHEMA = 'isc_tables_sc1' ORDER BY TABLE_NAME DESC
SELECT * FROM information_schema.tables WHERE TABLE_SCHEMA = 'ISC_TABLES_SC1' ORDER BY TABLE_NAME DESC
GO

EXEC isc_tables_vu_prepare_p1
GO

SELECT * FROM isc_tables_vu_prepare_f1()
SELECT * FROM isc_tables_vu_prepare_f2()
GO

SELECT * FROM isc_tables_vu_prepare_v1
GO
