SELECT set_config('babelfishpg_tsql.enable_sll_parse_mode', 'true', false);
GO

DELETE test_babel_4484_t1 OUTPUT test_babel_4484_t1.ced FROM test_babel_4484_t1 INNER JOIN test_babel_4484_t2 ON test_babel_4484_t1.ABC = test_babel_4484_t2.ABC WHERE test_babel_4484_t1.ABC = 1;
GO

DELETE test_babel_4484_t2 OUTPUT test_babel_4484_t2.您您 FROM test_babel_4484_t2 INNER JOIN test_babel_4484_t3 ON test_babel_4484_t2.ABC = test_babel_4484_t3.ABC WHERE test_babel_4484_t2.ABC = 1;
GO

SELECT test_babel_4484_t1.ced FROM test_babel_4484_t1 INNER JOIN test_babel_4484_t2 ON test_babel_4484_t1.ABC = test_babel_4484_t2.ABC WHERE test_babel_4484_t1.ABC = 1;
GO
