
-- database is expected to have been dropped by the owner, so expecting an error msg here:
drop database change_owner_db
go
drop login dba_login
go
drop login new_owner_login
go
drop login new_owner_login2
go
drop login LOGIN63long_345678901234567890123456789012345678901234567890123
go
drop login LOGIN64long_3456789012345678901234567890123456789012345678901234
go
drop procedure p_change_db_owner_1
go
drop procedure p_change_db_owner_2
go
-- should raise error as procedure was not created:
drop procedure p_change_db_owner_3
go