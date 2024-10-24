CREATE TABLE babel_4837_translate_t1(a NCHAR(50), b NCHAR(20), c NCHAR(20))
GO
INSERT INTO babel_4837_translate_t1 VALUES(N'  abc🙂defghi🙂🙂    ', N'ab🙂', N'x🙂y')
INSERT INTO babel_4837_translate_t1 VALUES(N'  比尔·拉莫斯    ', N'比拉斯', N'尔·比')
GO

CREATE TABLE babel_4837_translate_t2(a NVARCHAR(50), b NVARCHAR(20), c NVARCHAR(20))
GO
INSERT INTO babel_4837_translate_t2 VALUES(N'  abc🙂defghi🙂🙂    ', N'ab🙂', N'x🙂y')
GO

CREATE TABLE babel_4837_translate_t3(a VARCHAR(50), b VARCHAR(20), c VARCHAR(20))
GO
INSERT INTO babel_4837_translate_t3 VALUES('  abc🙂defghi🙂🙂    ', 'ab🙂', 'x🙂y')
GO

CREATE TABLE babel_4837_translate_chinese_prc_ci_as(a VARCHAR(50) COLLATE CHINESE_PRC_CI_AS, b VARCHAR(20) COLLATE CHINESE_PRC_CI_AS, c VARCHAR(20) COLLATE CHINESE_PRC_CI_AS)
GO
INSERT INTO babel_4837_translate_chinese_prc_ci_as VALUES(N'  比尔·拉莫斯    ', N'比拉斯', N'尔·比')
GO

CREATE TABLE babel_4837_translate_chinese_prc_cs_as(a VARCHAR(50) COLLATE CHINESE_PRC_CS_AS, b VARCHAR(20) COLLATE CHINESE_PRC_CS_AS, c VARCHAR(20) COLLATE CHINESE_PRC_CS_AS)
GO
INSERT INTO babel_4837_translate_chinese_prc_cs_as VALUES(N'  比尔·拉莫斯    ', N'比拉斯', N'尔·比')
GO

CREATE TABLE babel_4837_translate_chinese_prc_ci_ai(a VARCHAR(50) COLLATE CHINESE_PRC_CI_AI, b VARCHAR(20) COLLATE CHINESE_PRC_CI_AI, c VARCHAR(20) COLLATE CHINESE_PRC_CI_AI)
GO
INSERT INTO babel_4837_translate_chinese_prc_ci_ai VALUES(N'  比尔·拉莫斯    ', N'比拉斯', N'尔·比')
GO

CREATE TABLE babel_4837_translate_arabic_ci_as(a VARCHAR(50) COLLATE ARABIC_CI_AS, b VARCHAR(20) COLLATE ARABIC_CI_AS, c VARCHAR(20) COLLATE ARABIC_CI_AS)
GO
INSERT INTO babel_4837_translate_arabic_ci_as VALUES(N'  الله مع المتقين    ', N'ين', N'مع')
GO

CREATE TABLE babel_4837_translate_arabic_cs_as(a VARCHAR(50) COLLATE ARABIC_CS_AS, b VARCHAR(20) COLLATE ARABIC_CS_AS, c VARCHAR(20) COLLATE ARABIC_CS_AS)
GO
INSERT INTO babel_4837_translate_arabic_cs_as VALUES(N'  الله مع المتقين    ', N'ين', N'مع')
GO

CREATE TABLE babel_4837_translate_arabic_ci_ai(a VARCHAR(50) COLLATE ARABIC_CI_AI, b VARCHAR(20) COLLATE ARABIC_CI_AI, c VARCHAR(20) COLLATE ARABIC_CI_AI)
GO
INSERT INTO babel_4837_translate_arabic_ci_ai VALUES(N'  الله مع المتقين    ', N'ين', N'مع')
GO

CREATE TABLE babel_4837_translate_image(a IMAGE)
GO
INSERT INTO babel_4837_translate_image values(CAST ('6F9619FF-8B86-D011-B42D-00C04FC964FF' AS image))
GO

CREATE TABLE babel_4837_translate_text(a TEXT, b NTEXT, c NTEXT)
GO
INSERT INTO babel_4837_translate_text VALUES (N'  abc🙂defghi🙂🙂    ', N'  abc🙂defghi🙂🙂    ', N'  sbc🙂defjhi🙂🙂    ')
GO

CREATE TYPE dbo.babel_4837_translate_imageUDT FROM image;
GO

CREATE TYPE dbo.babel_4837_translate_varUDT FROM varchar(50);
GO

CREATE TABLE babel_4837_translate_UDT(a dbo.babel_4837_translate_imageUDT, b dbo.babel_4837_translate_varUDT, c dbo.babel_4837_translate_varUDT)
GO
INSERT INTO babel_4837_translate_UDT VALUES(CAST('abcdef' as dbo.babel_4837_translate_imageUDT), CAST('abcdef' as dbo.babel_4837_translate_varUDT), CAST('abcdef' as dbo.babel_4837_translate_varUDT))
GO

CREATE VIEW babel_4837_translate_dep_view AS
    SELECT ('|' + TRANSLATE(a, b, c) + '|') as result FROM babel_4837_translate_t2
GO

CREATE VIEW babel_4837_translate_dep_view1 AS
    SELECT ('|' + TRANSLATE(a, b, c) + '|') as result FROM babel_4837_translate_t3
GO

CREATE PROCEDURE babel_4837_translate_dep_proc AS
    SELECT ('|' + TRANSLATE(a, b, c) + '|') as result FROM babel_4837_translate_t2
GO

CREATE FUNCTION babel_4837_translate_dep_func()
RETURNS NVARCHAR(50)
AS
BEGIN
RETURN (SELECT TOP 1 ('|' + TRANSLATE(a, b, c) + '|') FROM babel_4837_translate_t2)
END
GO

CREATE FUNCTION babel_4837_translate_itvf_func()
RETURNS TABLE
AS
RETURN (SELECT ('|' + TRANSLATE(a, b, c) + '|') as result FROM babel_4837_translate_t2)
GO
