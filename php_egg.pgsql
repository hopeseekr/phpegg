------------------------------------------------------------------
-- My2Pg $Revision: 1.19 translated dump
--
------------------------------------------------------------------


--
-- Sequences for table BANS
--

CREATE SEQUENCE bans_ban_id_seq;

-- MySQL dump 8.12
--
-- Host: localhost    Database: egg_final
----------------------------------------------------------
-- Server version	3.23.33

--
-- Table structure for table 'bans'
--

CREATE TABLE "bans" (
  "ban_id" INT4 DEFAULT nextval('bans_ban_id_seq'),
  "chan_name" varchar(50) NOT NULL DEFAULT '',
  "ban_mask" varchar(100) NOT NULL DEFAULT '',
  "set_by" varchar(20) NOT NULL DEFAULT '',
  "ban_date" INT4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("ban_id")

);

--
-- Dumping data for table 'bans'
--


--
-- Table structure for table 'chan_bans'
--



--
-- Sequences for table CHAN_BANS
--

CREATE SEQUENCE chan_bans_cb_id_seq;

CREATE TABLE "chan_bans" (
  "cb_id" INT4 DEFAULT nextval('chan_bans_cb_id_seq'),
  "chan" varchar(100) NOT NULL DEFAULT '',
  "flag" varchar(10) NOT NULL DEFAULT '',
  "host_mask" varchar(255) NOT NULL DEFAULT '',
  "created" varchar(15) NOT NULL DEFAULT '',
  "last_used" varchar(15) DEFAULT NULL,
  "set_by" varchar(20) NOT NULL DEFAULT '',
  "reason" varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY ("cb_id")

);

--
-- Dumping data for table 'chan_bans'
--


--
-- Table structure for table 'chan_users'
--



--
-- Sequences for table CHAN_USERS
--

CREATE SEQUENCE chan_users_cu_id_seq;


---
--- Types for table CHAN_USERS
---

CREATE FUNCTION set_chan_users_o_in (opaque)
	RETURNS set_chan_users_o
	AS '/phpegg/libtypes.so'
	LANGUAGE 'c';

CREATE FUNCTION set_chan_users_o_out (opaque)
	RETURNS opaque
	AS '/phpegg/libtypes.so'
	LANGUAGE 'c';

CREATE TYPE set_chan_users_o (
	internallength = 2,
	input = set_chan_users_o_in,
	output = set_chan_users_o_out
);

CREATE FUNCTION set_chan_users_o_eq (set_chan_users_o,set_chan_users_o)
	RETURNS bool
	AS '/phpegg/libtypes.so'
	LANGUAGE 'c';

CREATE FUNCTION find_in_set (set_chan_users_o,set_chan_users_o)
	RETURNS bool
	AS '/phpegg/libtypes.so'
	LANGUAGE 'c';

CREATE OPERATOR = (
	leftarg = set_chan_users_o,
	rightarg = set_chan_users_o,
	commutator = =,
	procedure = set_chan_users_o_eq
);

CREATE OPERATOR <> (
	leftarg = set_chan_users_o,
	rightarg = set_chan_users_o,
	commutator = <>,
	negator = =,
	procedure = set_chan_users_o_eq
);


CREATE TABLE "chan_users" (
  "cu_id" INT4 DEFAULT nextval('chan_users_cu_id_seq'),
  "chan_name" varchar(20) NOT NULL DEFAULT '',
  "nick" varchar(10) NOT NULL DEFAULT '',
  "date" TIMESTAMP NOT NULL,
  "mode" "set_chan_users_o" DEFAULT NULL,
  "reason" varchar(100) DEFAULT NULL,
  "ident" varchar(30) DEFAULT NULL,
  "host_mask" varchar(60) DEFAULT NULL,
  "last_spoke" TIMESTAMP NOT NULL,
  PRIMARY KEY ("cu_id")

);

--
-- Dumping data for table 'chan_users'
--


--
-- Table structure for table 'channels'
--



--
-- Sequences for table CHANNELS
--

CREATE SEQUENCE channels_channels_id_seq;

CREATE TABLE "channels" (
  "channels_id" INT4 DEFAULT nextval('channels_channels_id_seq'),
  "chan_name" varchar(50) NOT NULL DEFAULT '',
  "topic" varchar(100) NOT NULL DEFAULT '',
  "topic_set_by" varchar(20) NOT NULL DEFAULT '',
  "topic_set_date" INT4 NOT NULL DEFAULT '0',
  "active" INT4 NOT NULL DEFAULT '1',
  "last_in" INT4 DEFAULT NULL,
  "in_chan" INT4 NOT NULL DEFAULT '0',
  "auto_voice" INT4 NOT NULL DEFAULT '1',
  "on_join" INT4 NOT NULL DEFAULT '0',
  "on_part" INT4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("channels_id")

);

--
-- Dumping data for table 'channels'
--


--
-- Table structure for table 'dcc_connections'
--



--
-- Sequences for table DCC_CONNECTIONS
--

CREATE SEQUENCE dcc_connections_id_seq;

CREATE TABLE "dcc_connections" (
  "id" INT4 DEFAULT nextval('dcc_connections_id_seq'),
  "nick" "text" NOT NULL,
  "time" INT4 NOT NULL DEFAULT '0',
  "login" varchar(50) DEFAULT NULL,
  "password" INT4 NOT NULL DEFAULT '0',
  "hostmask" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("id")

);

--
-- Dumping data for table 'dcc_connections'
--


--
-- Table structure for table 'join_msg'
--



--
-- Sequences for table JOIN_MSG
--

CREATE SEQUENCE join_msg_join_msg_id_seq;

CREATE TABLE "join_msg" (
  "join_msg_id" INT4 DEFAULT nextval('join_msg_join_msg_id_seq'),
  "chan_name" varchar(50) NOT NULL DEFAULT '',
  "msg" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("join_msg_id")

);

--
-- Dumping data for table 'join_msg'
--


--
-- Table structure for table 'manual'
--

CREATE TABLE "manual" (
  "m_id" INT4 DEFAULT nextval('manual_m_id_seq'),
  "search" varchar(255) NOT NULL DEFAULT '',
  "help" "text" NOT NULL,
  "example" varchar(255) DEFAULT NULL,
  "url" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("m_id")

);

--
-- Dumping data for table 'manual'
--

INSERT INTO "manual" VALUES (1,'SELECT INTO TABLE','ANSI SQL syntax INSERT INTO ... SELECT ..., which is basically\nthe same thing.\nAlternatively, you can use SELECT INTO OUTFILE... or CREATE\nTABLE ... SELECT to solve your problem.\nAs MySQL does nowadays support transactions, the following\ndiscussion is only valid if you are only using the non-transaction-safe\ntable types. COMMIT.\n','','http://www.mysql.com/doc/C/o/Commit-rollback.html');
INSERT INTO "manual" VALUES (2,'ROLLBACK','The following mostly applies only for ISAM, MyISAM, and\ntables) in an a update, you can do COMMIT and ROLLBACK also\nwith MySQL.  COMMIT.\nThe problem with handling COMMIT-ROLLBACK efficiently with\nthe above table types would require a completely different table layout\nthan MySQL uses today.  The table type would also need extra\nthreads that do automatic cleanups on the tables, and the disk usage\n','','http://www.mysql.com/doc/C/o/Commit-rollback.html');
INSERT INTO "DEFAULT" nextval('manual_insert_seq') column\nand either the SQL function LAST_INSERT_ID() or the C API function\nAt MySQL AB, we have never had any need for row-level locking because we have\nalways been able to code around it. Some cases really need row\nlocking, but they are very few. If you want row-level locking, you\n','mysql> FLUSH PRIVILEGES;','http://www.mysql.com/doc/P/a/Password_security.html');
INSERT INTO "manual" VALUES (4,'-password option','The @samp{* characters represent your password.\nIt is more secure to enter your password this way than to specify it on the\ncommand line because it is not visible to other users.  However, this method\nof entering a password is suitable only for programs that you run\ninteractively.  If you want to invoke a client from a script that runs\nnon-interactively, there is no opportunity to enter the password from the\nterminal. On some systems, you may even find that the first line of your\n','mysql> SELECT PI()*2;','http://www.mysql.com/doc/C/o/Connection_access.html');
INSERT INTO "manual" VALUES (5,'PASSWORD()','Non-blank Password values represent encrypted passwords.\nsee.  Rather, the password supplied by a user who is attempting to\nconnect is encrypted (using the PASSWORD() function). The\nencrypted password is then used when the client/server is checking if\nthe password is correct (This is done without the encrypted password\never traveling over the connection.)  Note that from MySQL\'s\npoint of view the encrypted password is the FLOAT8password, so you should\n','mysql> SET PASSWORD FOR root=PASSWORD(\'new_password\');','http://www.mysql.com/doc/D/e/Default_privileges.html');
INSERT INTO "manual" VALUES (6,'statements, GRANT','You can add users two different ways: by using GRANT statements\nor by manipulating the MySQL grant tables directly.  The\npreferred method is to use GRANT statements, because they are\nmore concise and less error-prone.\nThe examples below show how to use the mysql client to set up new\nusers.  These examples assume that privileges are set up according to the\nDEFAULTs described in the previous section.  This means that to make changes,\n','mysql> GRANT USAGE ON *.* TO dummy@@localhost;','http://www.mysql.com/doc/A/d/Adding_users.html');
INSERT INTO "manual" VALUES (7,'statements, INSERT','You can also add the same user access information directly by issuing\ntables:\nDepending on your MySQL version, you may have to use a different\nnumber of \'Y\' values above (versions prior to Version 3.22.11 had fewer\nprivilege columns).  For the admin user, the more readable extended\nNote that to set up a superuser, you need only create a user table\nentry with the privilege fields set to \'Y\'.  No db or\n','mysql> FLUSH PRIVILEGES;','http://www.mysql.com/doc/A/d/Adding_users.html');
INSERT INTO "manual" VALUES (8,'SET PASSWORD statement','In most cases you should use GRANT to set up your users/passwords,\nso the following only applies for advanced users. GRANT, , GRANT.\nThe examples in the preceding sections illustrate an important principle:\nwhen you store a non-empty password using INSERT or UPDATE\nstatements, you must use the PASSWORD() function to encrypt it.  This\nis because the user table stores passwords in encrypted form, not as\nplaintext.  If you forget that fact, you are likely to attempt to set\n','mysql> SELECT * FROM user;','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (9,'NUL','An ASCII 0 (NUL) character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (10,'newline (\\n)','A newline character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (11,'tab (\\t)','A tab character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (12,'carriage return (\\r)','A carriage return character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (13,'backspace (\\b)','A backspace character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (14,'single quote (\\\')','A single quote (@samp{\') character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (15,'FLOAT8quote (\\\")','A double quote (@samp{\") character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (16,'escape (\\\\)','A backslash (@samp{\\) character.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (17,'Wild card character (%)','A @samp{% character. This is used to search for literal instances of\nas a wild-card character. String comparison functions.\n','','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (18,'Wild card character (_)','A @samp{_ character. This is used to search for literal instances of\nas a wild-card character. String comparison functions.\nNote that if you use @samp{\\% or @samp{\\_ in some string contexts, these\nwill return the strings @samp{\\% and @samp{\\_ and not @samp{% and\nThere are several ways to include quotes within a string:\nA @samp{\' inside a string quoted with @samp{\' may be written as @samp{\'\'.\nA @samp{\" inside a string quoted with @samp{\" may be written as @samp{\"\".\n','mysql> SELECT \"This\\nIs\\nFour\\nlines\";','http://www.mysql.com/doc/S/t/String_syntax.html');
INSERT INTO "manual" VALUES (19,'DBI->quote','If you write C code, you can use the C API function\nstatement.  C API function overview.  In Perl, you can use the\ncharacters to the proper escape sequences.  Perl DBI Class, , Perl\nYou should use an escape function on any string that might contain any of the\nspecial characters listed above!\nIntegers are represented as a sequence of digits. Floats use @samp{. as a\ndecimal separator.  Either type of number may be preceded by @samp{- to\n','mysql> select MOD(29,9);','http://www.mysql.com/doc/G/r/Grouping_functions.html');
INSERT INTO "manual" VALUES (20,'parentheses ( and )','Parentheses. Use these to force the order of evaluation in an expression:\nThe usual arithmetic operators are available. Note that in the case of\n','mysql> select (1+2)*3;','http://www.mysql.com/doc/A/r/Arithmetic_functions.html');
INSERT INTO "manual" VALUES (21,'addition (+)','Addition:\n','mysql> select 3+5;','http://www.mysql.com/doc/A/r/Arithmetic_functions.html');
INSERT INTO "manual" VALUES (22,'subtraction (-)','Subtraction:\n','mysql> select 3-5;','http://www.mysql.com/doc/A/r/Arithmetic_functions.html');
INSERT INTO "manual" VALUES (23,'multiplication (*)','Multiplication:\nThe result of the last expression is incorrect because the result of the integer\nmultiplication exceeds the 64-bit range of BIGINT calculations.\n','mysql> select '18014398 509481'984*'18014398 509481'984;','http://www.mysql.com/doc/A/r/Arithmetic_functions.html');
INSERT INTO "manual" VALUES (24,'division (/)','Division:\nDivision by zero produces a NULL result:\nA division will be calculated with BIGINT arithmetic only if performed\nin a context where its result is converted to an integer!\n','mysql> select 102/(1-1);','http://www.mysql.com/doc/A/r/Arithmetic_functions.html');
INSERT INTO "manual" VALUES (25,'functions, bit','these operators have a maximum range of 64 bits.\n','','http://www.mysql.com/doc/B/i/Bit_functions.html');
INSERT INTO "manual" VALUES (26,'OR, bitwise','Bitwise OR:\n','mysql> select 29 | 15;','http://www.mysql.com/doc/B/i/Bit_functions.html');
INSERT INTO "manual" VALUES (27,'AND, bitwise','Bitwise AND:\n','mysql> select 29 & 15;','http://www.mysql.com/doc/B/i/Bit_functions.html');
INSERT INTO "manual" VALUES (28,'<< (left shift)','Shifts a longlong (BIGINT) number to the left:\n','mysql> select 1 << 2','http://www.mysql.com/doc/B/i/Bit_functions.html');
INSERT INTO "manual" VALUES (29,'>> (right shift)','Shifts a longlong (BIGINT) number to the right:\n','mysql> select 4 >> 2','http://www.mysql.com/doc/B/i/Bit_functions.html');
INSERT INTO "manual" VALUES (30,'~','Invert all bits:\n','mysql> select 5 & ~1','http://www.mysql.com/doc/B/i/Bit_functions.html');
INSERT INTO "manual" VALUES (31,'BIT_COUNT()','Returns the number of bits that are set in the argument N:\n','mysql> select BIT_COUNT(29);','http://www.mysql.com/doc/B/i/Bit_functions.html');
INSERT INTO "manual" VALUES (32,'Functions, logical','All logical functions return 1 (TRUE), 0 (FALSE) or\n','','http://www.mysql.com/doc/L/o/Logical_functions.html');
INSERT INTO "manual" VALUES (33,'! (logical NOT)','Logical NOT. Returns 1 if the argument is 0, otherwise returns\nException: NOT NULL returns NULL:\nThe last example returns 1 because the expression evaluates\nthe same way as (!1)+1.\n','mysql> select ! 1+1;','http://www.mysql.com/doc/L/o/Logical_functions.html');
INSERT INTO "manual" VALUES (34,'|| (logical OR)','Logical OR. Returns 1 if either argument is not 0 and not\n','mysql> select 1 || NULL;','http://www.mysql.com/doc/L/o/Logical_functions.html');
INSERT INTO "manual" VALUES (35,'&& (logical AND)','Logical AND. Returns 0 if either argument is 0 or NULL,\notherwise returns 1:\n','mysql> select 1 && 0;','http://www.mysql.com/doc/L/o/Logical_functions.html');
INSERT INTO "manual" VALUES (36,'comparison operators','Comparison operations result in a value of 1 (TRUE), 0 (FALSE),\nor NULL. These functions work for both numbers and strings.  Strings\nare automatically converted to numbers and numbers to strings as needed (as\nin Perl).\nrules:\nIf one or both arguments are NULL, the result of the comparison\nis NULL, except for the <=> operator.\n','mysql> SELECT 0 = \'x6\';','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (37,'equal (=)','Equal:\n','mysql> select \'.01\' = 0.01;','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (38,'not equal (!=)','Not equal:\n','mysql> select \'zapp\' <> \'zappp\';','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (39,'less than or equal (<=)','Less than or equal:\n','mysql> select 0.1 <= 2;','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (40,'less than (<)','Less than:\n','mysql> select 2 <= 2;','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (41,'greater than or equal (>=)','Greater than or equal:\n','mysql> select 2 >= 2;','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (42,'greater than (>)','Greater than:\n','mysql> select 2 > 2;','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (43,'<=> (Equal to)','Null safe equal:\n','mysql> select 1 <=> 1, NULL <=> NULL, 1 <=> NULL;','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (44,'IS NOT NULL','Test whether or not a value is or is not NULL:\n','mysql> select 1 IS NOT NULL, 0 IS NOT NULL, NULL IS NOT NULL;','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (45,'BETWEEN ... AND','If expr is greater than or equal to min and expr is\nless than or equal to max, BETWEEN returns 1,\notherwise it returns 0.  This is equivalent to the expression\nsame type.  The first argument (expr) determines how the\ncomparison is performed as follows:\nIf expr is a TIMESTAMP, DATE, or DATETIME\ncolumn, MIN() and MAX() are formatted to the same format if\n','mysql> select 2 BETWEEN 2 AND \'x-3\';','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (46,'IN','Returns 1 if expr is any of the values in the IN list,\nelse returns 0.  If all values are constants, then all values are\nevaluated according to the type of expr and sorted. The search for the\nitem is then done using a binary search. This means IN is very quick\nif the IN value list consists entirely of constants.  If expr\nis a case-sensitive string expression, the string comparison is performed in\ncase-sensitive fashion:\n','mysql> select \'wefwf\' IN (0,3,5,\'wefwf\');','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (47,'NOT IN','Same as NOT (expr IN (value,...)).\n','','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (48,'ISNULL()','If expr is NULL, ISNULL() returns 1, otherwise\nit returns 0:\nNote that a comparison of NULL values using = will always be\nfalse!\n','mysql> select ISNULL(1/0);','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (49,'COALESCE()','Returns first non-NULL element in list:\n','mysql> select COALESCE(NULL,NULL,NULL);','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (50,'INTERVAL()','Returns 0 if N < N1, 1 if N < N2\nand so on. All arguments are treated as integers.  It is required that\nto work correctly. This is because a binary search is used (very fast):\n','mysql> select INTERVAL(22, 23, 30, 44, 200);','http://www.mysql.com/doc/C/o/Comparison_functions.html');
INSERT INTO "manual" VALUES (51,'functions, string comparison','Normally, if any expression in a string comparison is case sensitive, the\ncomparison is performed in case-sensitive fashion.\n','','http://www.mysql.com/doc/S/t/String_comparison_functions.html');
INSERT INTO "manual" VALUES (52,'LIKE','Pattern matching using\nSQL simple regular expression comparison. Returns 1 (TRUE) or 0\n(FALSE).  With LIKE you can use the following two wild-card characters\nin the pattern:\nTo test for literal instances of a wild-card character, precede the character\nwith the escape character.  If you don\'t specify the ESCAPE character,\nTo specify a different escape character, use the ESCAPE clause:\n','mysql> select 10 LIKE \'1%\';','http://www.mysql.com/doc/S/t/String_comparison_functions.html');
INSERT INTO "manual" VALUES (53,'NOT LIKE','Same as NOT (expr LIKE pat [ESCAPE \'escape-char\']).\n','','http://www.mysql.com/doc/S/t/String_comparison_functions.html');
INSERT INTO "manual" VALUES (54,'RLIKE','Performs a pattern match of a string expression expr against a pattern\nreturns 0.  RLIKE is a synonym for REGEXP, provided for\nsyntax in strings (for example, @samp{\\n), you must FLOAT8any @samp{\\ that\nyou use in your REGEXP strings.  As of MySQL Version 3.23.4,\nLatin1 by DEFAULT) when deciding the type of a character.\n','mysql> select \"a\" REGEXP \"^[a-d]\";','http://www.mysql.com/doc/S/t/String_comparison_functions.html');
INSERT INTO "manual" VALUES (55,'NOT REGEXP','Same as NOT (expr REGEXP pat).\n','','http://www.mysql.com/doc/S/t/String_comparison_functions.html');
INSERT INTO "manual" VALUES (56,'STRCMP()','returns 0 if the strings are the same, -1 if the first\nargument is smaller than the second according to the current sort order,\nand 1 otherwise:\n','mysql> select STRCMP(\'text\', \'text\');','http://www.mysql.com/doc/S/t/String_comparison_functions.html');
INSERT INTO "manual" VALUES (57,'MATCH ... AGAINST()','relevance - similarity measure between the text in columns\npositive floating-point number. Zero relevance means no similarity.\nFor MATCH ... AGAINST() to work, a FULLTEXT index\nmust be created first. CREATE TABLE, , CREATE TABLE.\n3.23.23 or later. For details and usage examples\n','','http://www.mysql.com/doc/S/t/String_comparison_functions.html');
INSERT INTO "manual" VALUES (58,'BINARY','The BINARY operator casts the string following it to a binary string.\nThis is an easy way to force a column comparison to be case sensitive even\nif the column isn\'t defined as BINARY or text:\nNote that in some context MySQL will not be able to use the\nindex efficiently when you cast an indexed column to BINARY.\nIf you want to compare a blob case-insensitively you can always convert\nthe blob to upper case before doing the comparison:\n','mysql> select BINARY \"a\" = \"A\";','http://www.mysql.com/doc/C/a/Casts.html');
INSERT INTO "manual" VALUES (59,'IFNULL()','If expr1 is not NULL, IFNULL() returns expr1,\nelse it returns expr2.  IFNULL() returns a numeric or string\nvalue, depending on the context in which it is used:\n','mysql> select IFNULL(1/0,\'yes\');','http://www.mysql.com/doc/C/o/Control_flow_functions.html');
INSERT INTO "manual" VALUES (60,'NULLIF()','If expr1 = expr2 is true, return NULL else return expr1.\nThis is the same as CASE WHEN x = y THEN NULL ELSE x END:\nNote that expr1 is evaluated twice in MySQL if the arguments\nare equal.\n','mysql> select NULLIF(1,2);','http://www.mysql.com/doc/C/o/Control_flow_functions.html');
INSERT INTO "manual" VALUES (61,'IF()','If expr1 is TRUE (expr1 <> 0 and expr1 <> NULL) then\nin which it is used:\ntesting floating-point or string values, you should do so using a comparison\noperation:\nIn the first case above, IF(0.1) returns 0 because 0.1\nis converted to an integer value, resulting in a test of IF(0).  This\nmay not be what you expect.  In the second case, the comparison tests the\n','mysql> select IF(0.1<>0,1,0);','http://www.mysql.com/doc/C/o/Control_flow_functions.html');
INSERT INTO "manual" VALUES (62,'CASE','The first version returns the result where\nthe first condition, which is true. If there was no matching result\nvalue, then the result after ELSE is returned. If there is no\nThe type of the return value (INTEGER, FLOAT8or\nexpression after the first THEN).\n','mysql> SELECT CASE BINARY \"B\" when \"a\" then 1 when \"b\" then 2 END;','http://www.mysql.com/doc/C/o/Control_flow_functions.html');
INSERT INTO "manual" VALUES (63,'functions, mathematical','All mathematical functions return NULL in case of an error.\n','','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (64,'unary minus (-)','Unary minus. Changes the sign of the argument:\nNote that if this operator is used with a BIGINT, the return value is a\nmay have the value of -2^63!\n','mysql> select - 2;','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (65,'ABS()','Returns the absolute value of X:\nThis function is safe to use with BIGINT values.\n','mysql> select ABS(-32);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (66,'SIGN()','Returns the sign of the argument as -1, 0, or 1, depending\non whether X is negative, zero, or positive:\n','mysql> select SIGN(234);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (67,'modulo (%)','Modulo (like the % operator in C).\nReturns the remainder of N divided by M:\nThis function is safe to use with BIGINT values.\n','mysql> select MOD(29,9);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (68,'FLOOR()','Returns the largest integer value not greater than X:\nNote that the return value is converted to a BIGINT!\n','mysql> select FLOOR(-1.23);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (69,'CEILING()','Returns the smallest integer value not less than X:\nNote that the return value is converted to a BIGINT!\n','mysql> select CEILING(-1.23);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (70,'ROUND()','Returns the argument X, rounded to the nearest integer:\n','mysql> select ROUND(1.58);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (71,'ROUND()','Returns the argument X, rounded to a number with D decimals.\nIf D is 0, the result will have no decimal point or fractional\npart:\n','mysql> select ROUND(1.298, 0);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (72,'EXP()','Returns the value of e (the base of natural logarithms) raised to\nthe power of X:\n','mysql> select EXP(-2);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (73,'LOG()','Returns the natural logarithm of X:\nIf you want the log of a number X to some arbitary base B, use\nthe formula LOG(X)/LOG(B).\n','mysql> select LOG(-2);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (74,'LOG10()','Returns the base-10 logarithm of X:\n','mysql> select LOG10(-100);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (75,'POWER()','Returns the value of X raised to the power of Y:\n','mysql> select POW(2,-2);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (76,'SQRT()','Returns the non-negative square root of X:\n','mysql> select SQRT(20);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (77,'PI()','Returns the value of PI:\n','mysql> select PI();','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (78,'COS()','Returns the cosine of X, where X is given in radians:\n','mysql> select COS(PI());','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (79,'SIN()','Returns the sine of X, where X is given in radians:\n','mysql> select SIN(PI());','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (80,'TAN()','Returns the tangent of X, where X is given in radians:\n','mysql> select TAN(PI()+1);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (81,'ACOS()','Returns the arc cosine of X, that is, the value whose cosine is\n','mysql> select ACOS(0);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (82,'ASIN()','Returns the arc sine of X, that is, the value whose sine is\n','mysql> select ASIN(\'foo\');','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (83,'ATAN()','Returns the arc tangent of X, that is, the value whose tangent is\n','mysql> select ATAN(-2);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (84,'ATAN2()','Returns the arc tangent of the two variables X and Y. It is\nsimilar to calculating the arc tangent of Y / X, except that the\nsigns of both arguments are used to determine the quadrant of the\nresult:\n','mysql> select ATAN(PI(),0);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (85,'COT()','Returns the cotangent of X:\n','mysql> select COT(0);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (86,'RAND()','Returns a random floating-point value in the range 0 to 1.0.\nIf an integer argument N is specified, it is used as the seed value:\nYou can\'t use a column with RAND() values in an ORDER BY\nclause, because ORDER BY would evaluate the column multiple times.\nIn MySQL Version 3.23, you can, however, do:\nThis is useful to get a random sample of a set SELECT * FROM\ntable1,table2 WHERE a=b AND c<d ORDER BY RAND() LIMIT 1000.\n','mysql> select RAND();','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (87,'LEAST()','With two or more arguments, returns the smallest (minimum-valued) argument.\nThe arguments are compared using the following rules:\nIf the return value is used in an INTEGER context, or all arguments\nare integer-valued, they are compared as integers.\nIf the return value is used in a FLOAT8context, or all arguments are\nreal-valued, they are compared as reals.\nIf any argument is a case-sensitive string, the arguments are compared\n','mysql> select LEAST(\"B\",\"A\",\"C\");','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (88,'GREATEST()','Returns the largest (maximum-valued) argument.\nThe arguments are compared using the same rules as for LEAST:\nIn MySQL versions prior to Version 3.22.5, you can use MAX()\ninstead of GREATEST.\n','mysql> select GREATEST(\"B\",\"A\",\"C\");','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (89,'DEGREES()','Returns the argument X, converted from radians to degrees:\n','mysql> select DEGREES(PI());','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (90,'RADIANS()','Returns the argument X, converted from degrees to radians:\n','mysql> select RADIANS(90);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (91,'TRUNCATE()','Returns the number X, truncated to D decimals.  If D\nis 0, the result will have no decimal point or fractional part:\n','mysql> select TRUNCATE(1.999,0);','http://www.mysql.com/doc/M/a/Mathematical_functions.html');
INSERT INTO "manual" VALUES (92,'functions, string','String-valued functions return NULL if the length of the result would\nbe greater than the max_allowed_packet server parameter.  Server\nparameters.\nFor functions that operate on string positions,\nthe first position is numbered 1.\n','','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (93,'ASCII()','Returns the ASCII code value of the leftmost character of the string\nSee also the ORD() function.\n','mysql> select ASCII(\'dx\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (94,'ORD()','If the leftmost character of the string str is a multi-byte character,\nreturns the code of multi-byte character by returning the ASCII code value\nof the character in the format of:\nIf the leftmost character is not a multi-byte character, returns the same\nvalue as the like ASCII() function does:\n','mysql> select ORD(\'2\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (95,'CONV()','Converts numbers between different number bases.  Returns a string\nrepresentation of the number N, converted from base from_base\nto base to_base.  Returns NULL if any argument is NULL.\nThe argument N is interpreted as an integer, but may be specified as\nan integer or a string.  The minimum base is 2 and the maximum base is\nsigned number.  Otherwise, N is treated as .  CONV works\nwith 64-bit precision:\n','mysql> select CONV(10+\"10\"+\'10\'+0xa,10,10);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (96,'BIN()','Returns a string representation of the binary value of N, where\n','mysql> select BIN(12);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (97,'OCT()','Returns a string representation of the octal value of N, where\nReturns NULL if N is NULL:\n','mysql> select OCT(12);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (98,'HEX()','Returns a string representation of the hexadecimal value of N, where\n','mysql> select HEX(255);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (99,'CHAR()','consisting of the characters given by the ASCII code values of those\nintegers. NULL values are skipped:\n','mysql> select CHAR(77,77.3,\'77.3\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (100,'CONCAT()','Returns the string that results from concatenating the arguments.  Returns\nA numeric argument is converted to the equivalent string form:\n','mysql> select CONCAT(14.3);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (101,'CONCAT_WS()','arguments. The separator can be a string as well as the rest of the\narguments. If the separator is NULL, the result will be NULL.\nThe function will skip any NULLs and empty strings, after the\nseparator argument. The separator will be added between the strings to be\nconcatenated:\n','mysql> select CONCAT_WS(\",\",\"First name\",NULL,\"Last Name\");','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (102,'CHARACTER_LENGTH()','Returns the length of the string str:\nNote that for CHAR_LENGTH(), multi-byte characters are only counted\nonce.\n','mysql> select OCTET_LENGTH(\'text\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (103,'POSITION()','Returns the position of the first occurrence of substring substr\nin string str. Returns 0 if substr is not in str:\nThis function is multi-byte safe.\n','mysql> select LOCATE(\'xbar\', \'foobar\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (104,'LOCATE()','Returns the position of the first occurrence of substring substr in\nstring str, starting at position pos.\nReturns 0 if substr is not in str:\nThis function is multi-byte safe.\n','mysql> select LOCATE(\'bar\', \'foobarbar\',5);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (105,'INSTR()','Returns the position of the first occurrence of substring substr in\nstring str. This is the same as the two-argument form of\nThis function is multi-byte safe.\n','mysql> select INSTR(\'xbar\', \'foobar\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (106,'LPAD()','Returns the string str, left-padded with the string padstr\nuntil str is len characters long. If str is longer\nthan len\' then it will be shortened to len characters.\n','mysql> select LPAD(\'hi\',4,\'??\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (107,'RPAD()','Returns the string str, right-padded with the string\n','mysql> select RPAD(\'hi\',5,\'?\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (108,'LEFT()','Returns the leftmost len characters from the string str:\nThis function is multi-byte safe.\n','mysql> select LEFT(\'foobarbar\', 5);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (109,'RIGHT()','Returns the rightmost len characters from the string str:\nThis function is multi-byte safe.\n','mysql> select RIGHT(\'foobarbar\', 4);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (110,'MID()','Returns a substring len characters long from string str,\nstarting at position pos.\nThe variant form that uses FROM is ANSI SQL92 syntax:\nThis function is multi-byte safe.\n','mysql> select SUBSTRING(\'Quadratically\',5,6);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (111,'SUBSTRING()','Returns a substring from string str starting at position pos:\nThis function is multi-byte safe.\n','mysql> select SUBSTRING(\'foobarbar\' FROM 4);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (112,'SUBSTRING_INDEX()','Returns the substring from string str before count\noccurrences of the delimiter delim.\nIf count is positive, everything to the left of the final delimiter\n(counting from the left) is returned.\nIf count is negative, everything to the right of the final delimiter\n(counting from the right) is returned:\nThis function is multi-byte safe.\n','mysql> select SUBSTRING_INDEX(\'www.mysql.com\', \'.\', -2);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (113,'LTRIM()','Returns the string str with leading space characters removed:\n','mysql> select LTRIM(\'  barbar\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (114,'RTRIM()','Returns the string str with trailing space characters removed:\nThis function is multi-byte safe.\n','mysql> select RTRIM(\'barbar   \');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (115,'TRIM()','Returns the string str with all remstr prefixes and/or suffixes\nremoved. If none of the specifiers BOTH, LEADING or\nspecified, spaces are removed:\nThis function is multi-byte safe.\n','mysql> select TRIM(TRAILING \'xyz\' FROM \'barxxyz\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (116,'SOUNDEX()','Returns a soundex string from str. Two strings that sound almost the\nsame should have identical soundex strings. A standard soundex string\nis 4 characters long, but the SOUNDEX() function returns an\narbitrarily long string. You can use SUBSTRING() on the result to get\na standard soundex string.  All non-alphanumeric characters are ignored\nin the given string. All international alpha characters outside the A-Z range\nare treated as vowels:\n','mysql> select SOUNDEX(\'Quadratically\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (117,'SPACE()','Returns a string consisting of N space characters:\n','mysql> select SPACE(6);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (118,'REPLACE()','Returns the string str with all all occurrences of the string\nThis function is multi-byte safe.\n','mysql> select REPLACE(\'www.mysql.com\', \'w\', \'Ww\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (119,'REPEAT()','Returns a string consisting of the string str repeated count\ntimes. If count <= 0, returns an empty string. Returns NULL if\n','mysql> select REPEAT(\'MySQL\', 3);','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (120,'REVERSE()','Returns the string str with the order of the characters reversed:\nThis function is multi-byte safe.\n','mysql> select REVERSE(\'abc\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (121,'INSERT()','Returns the string str, with the substring beginning at position\nThis function is multi-byte safe.\n','mysql> select INSERT(\'Quadratic\', 3, 4, \'What\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (122,'ELT()','Returns str1 if N = 1, str2 if N =\nor greater than the number of arguments.  ELT() is the complement of\n','mysql> select ELT(4, \'ej\', \'Heja\', \'hej\', \'foo\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (123,'FIELD()','Returns the index of str in the str1, str2,\nReturns 0 if str is not found.\n','mysql> select FIELD(\'fo\', \'Hej\', \'ej\', \'Heja\', \'hej\', \'foo\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (124,'FIND_IN_SET()','Returns a value 1 to N if the string str is in the list\ncomposed of substrings separated by @samp{, characters. If the first\nargument is a constant string and the second is a column of type SET,\nthe FIND_IN_SET() function is optimized to use bit arithmetic!\nReturns 0 if str is not in strlist or if strlist\nis the empty string.  Returns NULL if either argument is NULL.\nThis function will not work properly if the first argument contains a\n','mysql> SELECT FIND_IN_SET(\'b\',\'a,b,c,d\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (125,'MAKE_SET()','Returns a set (a string containing substrings separated by @samp{,\ncharacters) consisting of the strings that have the corresponding bit in\netc.  NULL strings in str1, str2, ...\nare not appended to the result:\n','mysql> SELECT MAKE_SET(0,\'a\',\'b\',\'c\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (126,'EXPORT_SET()','Returns a string where for every bit set in \'bit\', you get an \'on\' string\nand for every reset bit you get an \'off\' string. Each string is separated\nwith \'separator\' (DEFAULT \',\') and only \'number_of_bits\' (default 64) of\n\'bits\' is used:\n','mysql> select EXPORT_SET(5,\'Y\',\'N\',\',\',4)','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (127,'LOWER()','Returns the string str with all characters changed to lowercase\naccording to the current character set mapping (the DEFAULT is ISO-8859-1\nLatin1):\nThis function is multi-byte safe.\n','mysql> select LCASE(\'QUADRATICALLY\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (128,'UPPER()','Returns the string str with all characters changed to uppercase\naccording to the current character set mapping (the DEFAULT is ISO-8859-1\nLatin1):\nThis function is multi-byte safe.\n','mysql> select UCASE(\'Hej\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (129,'LOAD_FILE()','Reads the file and returns the file contents as a string.  The file\nmust be on the server, you must specify the full pathname to the\nfile, and you must have the file privilege.  The file must\nbe readable by all and be smaller than max_allowed_packet.\nIf the file doesn\'t exist or can\'t be read due to one of the above reasons,\nthe function returns NULL:\nIf you are not using MySQL Version 3.23, you have to do the reading\n','mysql> SELECT CONCAT(2,\' test\');','http://www.mysql.com/doc/S/t/String_functions.html');
INSERT INTO "manual" VALUES (130,'functions, date and time','See Date and time types for a description of the range of values\neach type has and the valid formats in which date and time values may be\nspecified.\nHere is an example that uses date functions.  The query below selects\nall records with a date_col value from within the last 30 days:\n','mysql> SELECT something FROM table','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (131,'DAYOFWEEK()','Returns the weekday index\nfor date (1 = Sunday, 2 = Monday, ... 7 =\nSaturday).  These index values correspond to the ODBC standard:\n','mysql> select DAYOFWEEK(\'1998-02-03\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (132,'WEEKDAY()','Returns the weekday index for\n','mysql> select WEEKDAY(\'1997-11-05\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (133,'DAYOFMONTH()','Returns the day of the month for date, in the range 1 to\n','mysql> select DAYOFMONTH(\'1998-02-03\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (134,'DAYOFYEAR()','Returns the day of the year for date, in the range 1 to\n','mysql> select DAYOFYEAR(\'1998-02-03\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (135,'MONTH()','Returns the month for date, in the range 1 to 12:\n','mysql> select MONTH(\'1998-02-03\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (136,'DAYNAME()','Returns the name of the weekday for date:\n','mysql> select DAYNAME(\"1998-02-05\");','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (137,'MONTHNAME()','Returns the name of the month for date:\n','mysql> select MONTHNAME(\"1998-02-05\");','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (138,'QUARTER()','Returns the quarter of the year for date, in the range 1\nto 4:\n','mysql> select QUARTER(\'98-04-01\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (139,'WEEK()','With a single argument, returns the week for date, in the range\nfor locations where Sunday is the first day of the week.  The\ntwo-argument form of WEEK() allows you to specify whether the\nweek starts on Sunday or Monday.  The week starts on Sunday if the\nsecond argument is 0, on Monday if the second argument is\n','mysql> select WEEK(\'1998-12-31\',1);','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (140,'YEAR()','Returns the year for date, in the range 1000 to 9999:\nReturns year and week for a date.  The second arguments works exactly\nlike the second argument to WEEK().  Note that the year may be\ndifferent from the year in the date argument for the first and the last\nweek of the year:\n','mysql> select YEARWEEK(\'1987-01-01\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (141,'HOUR()','Returns the hour for time, in the range 0 to 23:\n','mysql> select HOUR(\'10:05:03\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (142,'MINUTE()','Returns the minute for time, in the range 0 to 59:\n','mysql> select MINUTE(\'98-02-03 10:05:03\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (143,'SECOND()','Returns the second for time, in the range 0 to 59:\n','mysql> select SECOND(\'10:05:03\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (144,'PERIOD_ADD()','Adds N months to period P (in the format YYMM or\nNote that the period argument P is not a date value:\n','mysql> select PERIOD_ADD(9801,2);','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (145,'PERIOD_DIFF()','Returns the number of months between periods P1 and P2.\nNote that the period arguments P1 and P2 are not\ndate values:\n','mysql> select PERIOD_DIFF(9802,199703);','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (146,'EXTRACT(type FROM date)','These functions perform date arithmetic.  They are new for MySQL\nVersion 3.22.  ADDDATE() and SUBDATE() are synonyms for\nIn MySQL Version 3.23, you can use + and - instead of\na date or TIMESTAMP column. (See example)\ndate.  expr is an expression specifying the interval value to be added\nor substracted from the starting date.  expr is a string; it may start\nwith a @samp{- for negative intervals.  type is a keyword indicating\n','mysql> select DATE_ADD(\'1998-01-30\', Interval 1 month);','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (147,'TO_DAYS()','Given a date date, returns a daynumber (the number of days since year\n0):\nof the Gregorian calendar (1582), because it doesn\'t take into account the\ndays that were lost when the calender was changed.\n','mysql> select TO_DAYS(\'1997-10-07\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (148,'FROM_DAYS()','Given a daynumber N, returns a DATE value:\nadvent of the Gregorian calendar (1582), because it doesn\'t take into account\nthe days that were lost when the calender was changed.\n','mysql> select FROM_DAYS(729669);','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (149,'DATE_FORMAT()','Formats the date value according to the format string. The\nfollowing specifiers may be used in the format string:\nAll other characters are just copied to the result without interpretation:\nAs of MySQL Version 3.23, the @samp{% character is required before\nformat specifier characters.  In earlier versions of MySQL,\n','mysql> select DATE_FORMAT(\'1999-01-01\', \'%X %V\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (150,'TIME_FORMAT()','This is used like the DATE_FORMAT() function above, but the\nhours, minutes, and seconds.  Other specifiers produce a NULL value or\n','','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (151,'CURRENT_DATE','Returns today\'s date as a value in \'YYYY-MM-DD\' or YYYYMMDD\nformat, depending on whether the function is used in a string or numeric\ncontext:\n','mysql> select CURDATE() + 0;','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (152,'CURRENT_TIME','Returns the current time as a value in \'HH:MM:SS\' or HHMMSS\nformat, depending on whether the function is used in a string or numeric\ncontext:\n','mysql> select CURTIME() + 0;','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (153,'CURRENT_TIMESTAMP','Returns the current date and time as a value in \'YYYY-MM-DD HH:MM:SS\'\nor YYYYMMDDHHMMSS format, depending on whether the function is used in\na string or numeric context:\n','mysql> select NOW() + 0;','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (154,'UNIX_TIMESTAMP()','If called with no argument, returns a Unix timestamp (seconds since\na date argument, it returns the value of the argument as seconds since\na DATETIME string, a TIMESTAMP, or a number in the format\nWhen UNIX_TIMESTAMP is used on a TIMESTAMP column, the function\nwill receive the value directly, with no implicit\n``string-to-unix-timestamp\'\' conversion.\nIf you give UNIX_TIMESTAMP() a wrong or out-of-range date, it will\n','mysql> select UNIX_TIMESTAMP(\'1997-10-04 22:23:00\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (155,'FROM_UNIXTIME()','Returns a representation of the unix_timestamp argument as a value in\nwhether the function is used in a string or numeric context:\n','mysql> select FROM_UNIXTIME(875996580) + 0;','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (156,'FROM_UNIXTIME()','Returns a string representation of the Unix timestamp, formatted according to\nthe format string. format may contain the same specifiers as\nthose listed in the entry for the DATE_FORMAT() function:\n','mysql> select FROM_UNIXTIME(UNIX_TIMESTAMP(),','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (157,'SEC_TO_TIME()','Returns the seconds argument, converted to hours, minutes, and seconds,\nas a value in \'HH:MM:SS\' or HHMMSS format, depending on whether\nthe function is used in a string or numeric context:\n','mysql> select SEC_TO_TIME(2378) + 0;','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (158,'TIME_TO_SEC()','Returns the time argument, converted to seconds:\n','mysql> select TIME_TO_SEC(\'00:39:38\');','http://www.mysql.com/doc/D/a/Date_and_time_functions.html');
INSERT INTO "manual" VALUES (159,'DATABASE()','Returns the current database name:\nIf there is no current database, DATABASE() returns the empty string.\n','mysql> select DATABASE();','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (160,'SESSION_USER()','Returns the current MySQL user name:\nIn MySQL Version 3.22.11 or later, this includes the client hostname\nas well  as the user name.  You can extract just the user name part like this\n(which works whether or not the value includes a hostname part):\n','mysql> select substring_index(USER(),\"@@\",1);','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (161,'PASSWORD()','Calculates a password string from the plaintext password str. This is\nthe function that is used for encrypting MySQL passwords for storage\nin the Password column of the user grant table:\nUnix passwords are encrypted.  You should not assume that if your Unix\npassword and your MySQL password are the same, PASSWORD()\nwill result in the same encrypted value as is stored in the Unix password\nfile.  See ENCRYPT().\n','mysql> select PASSWORD(\'badpwd\');','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (162,'ENCRYPT()','Encrypt str using the Unix crypt() system call. The\n(As of MySQL Version 3.22.16, salt may be longer than two characters.):\nIf crypt() is not available on your system, ENCRYPT() always\nreturns NULL.\nleast on some systems.  This will be determined by the behavior of the\nunderlying crypt() system call.\n','mysql> select ENCRYPT(\"hello\");','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (163,'ENCODE()','Encrypt str using pass_str as the password.\nTo decrypt the result, use DECODE().\nThe results is a binary string of the same length as string.\nIf you want to save it in a column, use a text column type.\n','','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (164,'DECODE()','Descrypts the encrypted string crypt_str using pass_str as the\npassword.  crypt_str should be a string returned from\n','','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (165,'MD5()','Calculates a MD5 checksum for the string. Value is returned as a 32 long\nhex number that may, for example, be used as a hash key:\nThis is an \"RSA Data Security, Inc. MD5 Message-Digest Algorithm\".\n','mysql> select MD5(\"testing\")','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "DEFAULT" nextval('') column with a\nnon-magic value (that is, a value that is not NULL and not 0).\nIf expr is given as an argument to LAST_INSERT_ID() in an\nFirst create the table:\n','mysql> update sequence set id=LAST_INSERT_ID(id+1);','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (167,'FORMAT()','Formats the number X to a format like \'#,###,###.##\', rounded\nto D decimals.  If D is 0, the result will have no\ndecimal point or fractional part:\n','mysql> select FORMAT(12332.2,0);','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (168,'VERSION()','Returns a string indicating the MySQL server version:\nNote that if your version ends with -log this means that logging is\nenabled.\n','mysql> select VERSION();','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (169,'CONNECTION_ID()','Returns the connection id (thread_id) for the connection.\nEvery connection has its own unique id:\n','mysql> select CONNECTION_ID();','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (170,'GET_LOCK()','Tries to obtain a lock with a name given by the string str, with a\ntimeout of timeout seconds.  Returns 1 if the lock was obtained\nsuccessfully, 0 if the attempt timed out, or NULL if an error\noccurred (such as running out of memory or the thread was killed with\nterminates.  This function can be used to implement application locks or to\nsimulate record locks.  It blocks requests by other clients for locks with\nthe same name; clients that agree on a given lock string name can use the\n','mysql> select RELEASE_LOCK(\"lock1\");','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (171,'RELEASE_LOCK()','Releases the lock named by the string str that was obtained with\nlock wasn\'t locked by this thread (in which case the lock is not released),\nand NULL if the named lock didn\'t exist.  The lock will not exist if\nit was never obtained by a call to GET_LOCK() or if it already has\nbeen released.\n','','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (172,'BENCHMARK()','The BENCHMARK() function executes the expression expr\nrepeatedly count times.  It may be used to time how fast MySQL\nprocesses the expression.  The result value is always 0.  The intended\nuse is in the mysql client, which reports query execution times:\nThe time reported is elapsed time on the client end, not CPU time on the\nserver end.  It may be advisable to execute BENCHMARK() several\ntimes, and interpret the result with regard to how heavily loaded the\n','mysql> select BENCHMARK(1000000,encode(\"hello\",\"goodbye\"));','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (173,'INET_NTOA()','Returns the network address (4 or 8 byte) for the numeric expression:\n','mysql> select INET_NTOA(3520061480);','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (174,'INET_ATON()','Returns an integer that represents the numeric value for a network address.\nAddresses may be 4 or 8 byte addresses:\n','mysql> select INET_ATON(\"209.207.224.40\");','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (175,'MASTER_POS_WAIT()','Blocks until the slave reaches the specified position in the master log during\nreplication. If master information is not initialized, returns NULL. If the\nslave is not running, will block and wait until it is started and goes to or\npast\nthe specified postion. If the slave is already past the specified postion,\nreturns immediately. The return value is the number of log events it had to\nwait to get to the specified position, or NULL in case of error. Useful for\n','','http://www.mysql.com/doc/M/i/Miscellaneous_functions.html');
INSERT INTO "manual" VALUES (176,'functions, GROUP BY','If you use a group function in a statement containing no GROUP BY\nclause, it is equivalent to grouping on all rows.\n','','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (177,'COUNT()','Returns a count of the number of non-NULL values in the rows\nretrieved by a SELECT statement:\nthe number of rows retrieved, whether or not they contain NULL\nvalues.\nreturn very quickly if the SELECT retrieves from one table, no\nother columns are retrieved, and there is no WHERE clause.\nFor example:\n','mysql> select COUNT(*) from student;','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (178,'DISTINCT','Returns a count of the number of different non-NULL values:\nIn MySQL you can get the number of distinct expression\ncombinations that don\'t contain NULL by giving a list of expressions.\nIn ANSI SQL you would have to do a concatenation of all expressions\ninside CODE(DISTINCT ..).\n','mysql> select COUNT(DISTINCT results) from student;','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (179,'AVG()','Returns the average value of expr:\n','mysql> select student_name, AVG(test_score)','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (180,'MAX()','Returns the minimum or maximum value of expr.  MIN() and\nminimum or maximum string value. MySQL indexes.\n','mysql> select student_name, MIN(test_score), MAX(test_score)','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (181,'SUM()','Returns the sum of expr.  Note that if the return set has no rows,\nit returns NULL!\n','','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (182,'STDDEV()','Returns the standard deviation of expr. This is an extension to\nANSI SQL. The STDDEV() form of this function is provided for Oracle\ncompatability.\n','','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (183,'BIT_OR()','Returns the bitwise OR of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\n','','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (184,'BIT_AND()','Returns the bitwise AND of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\ncalculations in the SELECT expressions that don\'t appear in\nthe GROUP BY part. This stands for any possible value for this\ngroup.  You can use this to get better performance by avoiding sorting and\ngrouping on unnecessary items.  For example, you don\'t need to group on\nIn ANSI SQL, you would have to add customer.name to the GROUP\n','mysql> SELECT id,FLOOR(value/100) FROM tbl_name ORDER BY RAND();','http://www.mysql.com/doc/G/r/Group_by_functions.html');
INSERT INTO "manual" VALUES (185,'CREATE DATABASE','allowable database names are given in Legal names.  An error occurs if\nthe database already exists and you didn\'t specify IF NOT EXISTS.\nDatabases in MySQL are implemented as directories containing files\nthat correspond to tables in the database.  Because there are no tables in a\ndatabase when it is initially created, the CREATE DATABASE statement\nonly creates a directory under the MySQL data directory.\nYou can also create databases with mysqladmin.\n','','http://www.mysql.com/doc/C/R/CREATE_DATABASE.html');
INSERT INTO "manual" VALUES (186,'DROP DATABASE','database.  If you do a DROP DATABASE on a symbolic linked\ndatabase, both the link and the original database is deleted. Be\nVERY careful with this command!\nthe database directory.  Normally, this is three times the number of\ntables, because normally each table corresponds to a .MYD file, a\nThe DROP DATABASE command removes from the given database\ndirectory all files with the following extensions:\n','','http://www.mysql.com/doc/D/R/DROP_DATABASE.html');
INSERT INTO "DEFAULT" nextval(''),','http://www.mysql.com/doc/S/i/Silent_column_changes.html');
INSERT INTO "manual" VALUES (188,'ALTER TABLE','For example, you can add or delete columns, create or destroy indexes, change\nthe type of existing columns, or rename columns or the table itself.  You can\nalso change the comment for the table and type of the table.\nIf you use ALTER TABLE to change a column specification but\npossible that MySQL ignored your modification for one of the reasons\ndescribed in Silent column changes.  For example, if you try to change\na VARCHAR column to CHAR, MySQL will still use\n','mysql> ALTER TABLE t1 MODIFY b BIGINT NOT NULL;','http://www.mysql.com/doc/A/L/ALTER_TABLE.html');
INSERT INTO "manual" VALUES (189,'ALTER COLUMN','or removes the old DEFAULT value.\nIf the old default is removed and the column can be NULL, the new\ndefault is NULL. If the column cannot be NULL, MySQL\nassigns a default value.\nDefault value assignment is described in\n','','http://www.mysql.com/doc/A/L/ALTER_TABLE.html');
INSERT INTO "manual" VALUES (190,'DROP INDEX','ANSI SQL92.\nIf columns are dropped from a table, the columns are also removed from any\nindex of which they are a part.  If all columns that make up an index are\ndropped, the index is dropped as well.\n','','http://www.mysql.com/doc/A/L/ALTER_TABLE.html');
INSERT INTO "manual" VALUES (191,'DROP PRIMARY KEY','index exists, it drops the first UNIQUE index in the table.\n(MySQL marks the first UNIQUE key as the PRIMARY KEY\nif no PRIMARY KEY was specified explicitly.)\n','','http://www.mysql.com/doc/A/L/ALTER_TABLE.html');
INSERT INTO "manual" VALUES (192,'ORDER BY','specific order.  Note that the table will not remain in this order after\ninserts and deletes.  In some cases, it may make sorting easier for\norder it by later.  This option is mainly useful when you know that you\nare mostly going to query the rows in a certain order; By using this\noption after big changes to the table, you may be able to get higher\nperformance.\n','','http://www.mysql.com/doc/A/L/ALTER_TABLE.html');
INSERT INTO "manual" VALUES (193,'ALTER TABLE','If you use ALTER TABLE on a MyISAM table, all non-unique\nindexes are created in a separate batch (like in REPAIR).\nThis should make ALTER TABLE much faster when you have many indexes.\n','','http://www.mysql.com/doc/A/L/ALTER_TABLE.html');
INSERT INTO "DEFAULT" nextval(''),','http://www.mysql.com/doc/A/L/ALTER_TABLE.html');
INSERT INTO "manual" VALUES (195,'RENAME TABLE','The rename is done atomically, which means that no other thread can\naccess any of the tables while the rename is running. This makes it\npossible to replace a table with an empty one:\nThe rename is done from left to right, which means that if you want to\nswap two tables names, you have to:\nAs long as two databases are on the same disk you can also rename\nfrom one database to another:\n','','http://www.mysql.com/doc/R/E/RENAME_TABLE.html');
INSERT INTO "manual" VALUES (196,'DROP TABLE','definition are removed, so be careful with this command!\nIn MySQL Version 3.22 or later, you can use the keywords\nexist.\nFor the moment they don\'t do anything.\nautomaticly commit any active transactions.\n','','http://www.mysql.com/doc/D/R/DROP_TABLE.html');
INSERT INTO "manual" VALUES (197,'OPTIMIZE TABLE','table or if you have made many changes to a table with variable-length rows\n(tables that have VARCHAR, text, or TEXT columns).\nDeleted records are maintained in a linked list and subsequent INSERT\noperations reuse old record positions. You can use OPTIMIZE TABLE to\nreclaim the unused space and to defragment the data file.\nFor the moment OPTIMIZE TABLE only works on MyISAM and\ncurrently mapped to ANALYZE TABLE. ANALYZE TABLE.\n','','http://www.mysql.com/doc/O/P/OPTIMIZE_TABLE.html');
INSERT INTO "manual" VALUES (198,'CHECK TABLE','table_name on the table.\nIf you don\'t specify any option MEDIUM is used.\nChecks the table(s) for errors. For MyISAM tables the key statistics\nis updated. The command returns a table with the following columns:\nNote that you can get many rows of information for each checked\ntable. The last row will be of Msg_type status and should\nnormally be OK.  If you don\'t get OK, or Not\n','','http://www.mysql.com/doc/C/H/CHECK_TABLE.html');
INSERT INTO "manual" VALUES (199,'BACKUP TABLE','Make a copy of all the table files to the backup directory that are the\nminimum needed to restore it. Currenlty only works for MyISAM\ntables. For MyISAM table, copies .frm (definition)  and\nDuring the backup, read lock will be held for each table, one at time,\nas they are being backed up. If you want to backup several tables as\na snapshot, you must first issue LOCK TABLES obtaining a read\nlock for each table in the group.\n','','http://www.mysql.com/doc/B/A/BACKUP_TABLE.html');
INSERT INTO "manual" VALUES (200,'RESTORE TABLE','Restores the table(s) from the backup that was made with\ntry to restore over an existing table, you will get an error. Restore\nwill take  longer than BACKUP due to the need to rebuilt the index. The\nmore keys you have, the longer it is going to take. Just as\nThe command returns a table with the following columns:\n','','http://www.mysql.com/doc/R/E/RESTORE_TABLE.html');
INSERT INTO "manual" VALUES (201,'ANALYZE TABLE','Analyze and store the key distribution for the table.  During the\nanalyze the table is locked with a read lock.  This works on\nThis is equivalent to running myisamchk -a on the table.\ntables should be joined when one does a join on something else than a\nconstant.\nThe command returns a table with the following columns:\nYou can check the stored key distribution with the SHOW INDEX command.\n','','http://www.mysql.com/doc/A/N/ANALYZE_TABLE.html');
INSERT INTO "manual" VALUES (202,'REPAIR TABLE','as running myisamchk -r table_name on the table.\nRepair the corrupted table. The command returns a table with the following\ncolumns:\nNote that you can get many rows of information for each repaired\ntable. The last one row will be of Msg_type status and should\nnormally be OK.  If you don\'t get OK, you should try\nrepairing the table with myisamchk -o, as REPAIR TABLE\n','','http://www.mysql.com/doc/R/E/REPAIR_TABLE.html');
INSERT INTO "manual" VALUES (203,'DELETE','given by where_definition, and returns the number of records deleted.\nIf you issue a DELETE with no WHERE clause, all rows are\ndeleted.  If you do this in AUTOCOMMIT mode, this works as\nthis will be fixed in 4.0.\nIf you really want to know how many records are deleted when you are deleting\nall rows, and are willing to suffer a speed penalty, you can use a\nNote that this is MUCH slower than DELETE FROM tbl_name with no\n','mysql> DELETE FROM tbl_name WHERE 1>0;','http://www.mysql.com/doc/D/E/DELETE.html');
INSERT INTO "manual" VALUES (204,'TRUNCATE','Is in 3.23 and the same thing as DELETE FROM table_name. DELETE.\nThe differences are:\nImplemented as a drop and re-create of the table, which makes this\nmuch faster when deleting many rows.\nNot transaction-safe; TRUNCATE TABLE will automaticly end the current\ntransaction as if COMMIT would have been called.\nDoesn\'t return the number of deleted rows.\n','','http://www.mysql.com/doc/T/R/TRUNCATE.html');
INSERT INTO "manual" VALUES (205,'SELECT','any table.  For example:\nAll keywords used must be given in exactly the order shown above. For example,\na HAVING clause must come after any GROUP BY clause and before\nany ORDER BY clause.\nA SELECT expression may be given an alias using AS. The alias\nis used as the expression\'s column name and can be used with\nThe FROM table_references clause indicates the tables from which to\n','mysql> select * from table LIMIT 5;     # Retrieve first 5 rows','http://www.mysql.com/doc/S/E/SELECT.html');
INSERT INTO "manual" VALUES (206,'DUMPFILE','If you use INTO DUMPFILE instead of INTO OUTFILE, MySQL\nwill only write one row into the file, without any column or line\nterminations and without any escaping.  This is useful if you want to\nstore a text in a file.\n','','http://www.mysql.com/doc/S/E/SELECT.html');
INSERT INTO "manual" VALUES (207,'STRAIGHT_JOIN','Where table_reference is defined as:\nand join_condition is defined as:\nNote that in versions before Version 3.23.16, the INNER JOIN didn\'t take\na join condition!\nThe last LEFT OUTER JOIN syntax shown above exists only for\ncompatibility with ODBC:\nA table reference may be aliased using tbl_name AS alias_name or\n','mysql> select * from table1 IGNORE INDEX (key3) WHERE key1=1 and key2=2 AND','http://www.mysql.com/doc/J/O/JOIN.html');
INSERT INTO "manual" VALUES (208,'INSERT','VALUES form of the statement inserts rows based on explicitly specified\nvalues.  The INSERT ... SELECT form inserts rows selected from another\ntable or tables.  The INSERT ... VALUES form with multiple value lists\nis supported in MySQL Version 3.22.5 or later.  The\nlater.\nname list or the SET clause indicates which columns the statement\nspecifies values for:\n','mysql> INSERT INTO tbl_name (col1,col2) VALUES(col2*2,15);','http://www.mysql.com/doc/I/N/INSERT.html');
INSERT INTO "manual" VALUES (209,'mysql_info()','If you use INSERT ... SELECT or an INSERT ... VALUES\nstatement with multiple value lists, you can use the C API function\ninformation string is shown below:\nbecause they would duplicate some existing unique index value.\nwere problematic in some way. Warnings can occur under any of the following\nconditions:\nInserting NULL into a column that has been declared NOT NULL.\n','','http://www.mysql.com/doc/I/N/INSERT.html');
INSERT INTO "manual" VALUES (210,'DELAYED','The DELAYED option\nfor the\nuseful if you have clients that can\'t wait for the INSERT to complete.\nThis is a common problem when you use MySQL for logging and you also\nperiodically run SELECT statements that take a long time to complete.\nWhen you use INSERT DELAYED, the client will get an OK at once\nand the row will be inserted when the table is not in use by any other thread.\n','','http://www.mysql.com/doc/I/N/INSERT.html');
INSERT INTO "manual" VALUES (211,'REPLACE','record in the table has the same value as a new record on a unique index,\nthe old record is deleted before the new record is inserted.\nIn other words, you can\'t access the values of the old row from a\nlike you could do this, but that was a bug that has been corrected.\n','','http://www.mysql.com/doc/R/E/REPLACE.html');
INSERT INTO "manual" VALUES (212,'LOAD DATA INFILE','The LOAD DATA INFILE statement reads rows from a text file into a\ntable at a very high speed.  If the LOCAL keyword is specified, the\nfile is read from the client host.  If LOCAL is not specified, the\nfile must be located on the server.  (LOCAL is available in\nFor security reasons, when reading text files located on the server, the\nfiles must either reside in the database directory or be readable by all.\nAlso, to use LOAD DATA INFILE on server files, you must have the\n','mysql> LOAD DATA INFILE \'persondata.txt\'','http://www.mysql.com/doc/L/O/LOAD_DATA.html');
INSERT INTO "manual" VALUES (213,'mysql_info()','If you are using the C API, you can get information about the query by\ncalling the API function mysql_info() when the LOAD DATA INFILE\nquery finishes.  The format of the information string is shown below:\nWarnings occur under the same circumstances as when values are inserted\nvia the INSERT statement (@pxref{INSERT, , INSERT), except\nthat LOAD DATA INFILE also generates warnings when there are too few\nor too many fields in the input row.  The warnings are not stored anywhere;\n','','http://www.mysql.com/doc/L/O/LOAD_DATA.html');
INSERT INTO "manual" VALUES (214,'UPDATE','The SET clause indicates which columns to modify and the values\nthey should be given.  The WHERE clause, if given, specifies\nwhich rows should be updated.  Otherwise all rows are updated. If the\norder that is specified.\nIf you specify the keyword LOW_PRIORITY, execution of the\nIf you specify the keyword IGNORE, the update statement will not\nabort even if we get duplicate key errors during the update.  Rows that\n','mysql> UPDATE persondata SET age=age*2, age=age+1;','http://www.mysql.com/doc/U/P/UPDATE.html');
INSERT INTO "manual" VALUES (215,'mysql_info()','In MySQL Version 3.22 or later, the C API function mysql_info()\nreturns the number of rows that were matched and updated and the number of\nwarnings that occurred during the UPDATE.\nIn MySQL Version 3.23, you can use LIMIT # to ensure that\nonly a given number of rows are changed.\n','','http://www.mysql.com/doc/U/P/UPDATE.html');
INSERT INTO "manual" VALUES (216,'USE','The USE db_name statement tells MySQL to use the db_name\ndatabase as the DEFAULT database for subsequent queries.  The database remains\ncurrent until the end of the session or until another USE statement\nis issued:\nMaking a particular database current by means of the USE statement\ndoes not preclude you from accessing tables in other databases.  The example\nbelow accesses the author table from the db1 database and the\n','mysql> SELECT author_name,editor_name FROM author,db2.editor','http://www.mysql.com/doc/U/S/USE.html');
INSERT INTO "manual" VALUES (217,'FLUSH','You should use the FLUSH command if you want to clear some of the\ninternal caches MySQL uses.  To execute FLUSH, you must have\nthe reload privilege.\nhost tables if some of your hosts change IP number or if you get the\nerror message Host ... is blocked.  When more than\nconnection to the MySQL server, MySQL assumes\nsomething is wrong and blocks the host from further connection requests.\n','','http://www.mysql.com/doc/F/L/FLUSH.html');
INSERT INTO "manual" VALUES (218,'KILL','Each connection to mysqld runs in a separate thread.  You can see\nwhich threads are running with the SHOW PROCESSLIST command and kill\na thread with the KILL thread_id command.\nIf you have the process privilege, you can see and kill all threads.\nOtherwise, you can see and kill only your own threads.\nYou can also use the mysqladmin processlist and mysqladmin kill\ncommands to examine and kill threads.\n','','http://www.mysql.com/doc/K/I/KILL.html');
INSERT INTO "manual" VALUES (219,'SHOW CREATE TABLE','status information about the server. If the LIKE wild part is\nused, the wild string can be a string that uses the SQL @samp{%\nand @samp{_ wild-card characters.\n','','http://www.mysql.com/doc/S/H/SHOW.html');
INSERT INTO "manual" VALUES (327,'make_binary_distribution','Makes a binary release of a compiled MySQL. This could be sent by FTP to `/pub/mysql/Incoming\' on support.mysql.com for the convenience of other MySQL users.',NULL,NULL);
INSERT INTO "manual" VALUES (220,'SHOW KEYS','* SHOW DATABASE INFO::          \n* SHOW TABLE STATUS::           \n* SHOW STATUS::                 \n* SHOW VARIABLES::              \n* SHOW LOGS::                   \n* SHOW PROCESSLIST::            \n* SHOW GRANTS::                 \n','mysql> SHOW INDEX FROM mydb.mytable;','http://www.mhttp://www.mysql.com/doc/S/H/SHOW_LOGS.html');
INSERT INTO "manual" VALUES (221,'PROCESSLIST','also get this information using the mysqladmin processlist\ncommand.  If you have the process privilege, you can see all\nthreads.  Otherwise, you can see only your own threads.  KILL, ,\nthe first 100 characters of each query will be shown.\nThis command is very useful if you get the \'too many connections\' error\nmessage and want to find out what\'s going on. MySQL reserves\none extra connection for a client with the Process_priv privilege\n','mysql> show create table t\\G','http://www.mysql.com/doc/S/H/SHOW_CREATE_TABLE.html');
INSERT INTO "manual" VALUES (222,'SELECT, optimizing','When you precede a SELECT statement with the keyword EXPLAIN,\ninformation about how tables are joined and in which order.\nWith the help of EXPLAIN, you can see when you must add indexes\nto tables to get a faster SELECT that uses indexes to find the\nrecords. You can also see if the optimizer joins the tables in an optimal\norder. To force the optimizer to use a specific join order for a\nFor non-simple joins, EXPLAIN returns a row of information for each\n','mysql> ALTER TABLE tt MODIFY AssignedPC VARCHAR(15),','http://www.mysql.com/doc/E/X/EXPLAIN.html');
INSERT INTO "manual" VALUES (223,'DESCRIBE','may be a column name or a string containing the SQL @samp{% and @samp{_\nwild-card characters.\nIf the column types are different than you expect them to be based on a\nchanges column types.  Silent column changes.\nThis statement is provided for Oracle compatibility.\nThe SHOW statement provides similar information.\n','','http://www.mysql.com/doc/D/E/DESCRIBE.html');
INSERT INTO "manual" VALUES (224,'ROLLBACK','By DEFAULT, MySQL runs in autocommit mode. This means that\nas soon as you execute an update, MySQL will store the update on\ndisk.\nIf you are using BDB tables, you can put MySQL into\nnon-autocommit mode with the following command:\nAfter this you must use COMMIT to store your changes to disk or\nthe beginning of your transaction.\n','','http://www.mysql.com/doc/C/O/COMMIT.html');
INSERT INTO "manual" VALUES (225,'UNLOCK TABLES','TABLES releases any locks held by the current thread.  All tables that\nare locked by the current thread are automatically unlocked when the\nthread issues another LOCK TABLES, or when the connection to the\nserver is closed.\nIf a thread obtains a READ lock on a table, that thread (and all other\nthreads) can only read from the table. If a thread obtains a WRITE\nlock on a table, then only the thread holding the lock can READ from\n','mysql> UNLOCK TABLES;','http://www.mysql.com/doc/L/O/LOCK_TABLES.html');
INSERT INTO "manual" VALUES (226,'SET OPTION','server or your client.  Any option you set remains in effect until the\ncurrent session ends, or until you set the option to a different value.\nThis maps all strings from and to the client with the given mapping.\nCurrently the only option for character_set_name is\nDEFAULT mapping can be restored by using a character_set_name value of\nNote that the syntax for setting the CHARACTER SET option differs\nfrom the syntax for setting the other options.\n','mysql> UPDATE mysql.user SET password=PASSWORD(\"newpass\") where user=\"bob\' and host=\"%.loc.gov\";','http://www.mysql.com/doc/S/E/SET_OPTION.html');
INSERT INTO "manual" VALUES (227,'REVOKE','earlier MySQL versions, the GRANT statement does nothing.\nThe GRANT and REVOKE commands allow system administrators to\ngrant and revoke rights to MySQL users at four privilege levels:\nGlobal privileges apply to all databases on a given server. These privileges\nare stored in the mysql.user table.\nDatabase privileges apply to all tables in a given database. These privileges\nare stored in the mysql.db and mysql.host tables.\n','mysql> SELECT Host,User FROM mysql.user WHERE User=\'\';','http://www.mysql.com/doc/G/R/GRANT.html');
INSERT INTO "manual" VALUES (228,'CREATE INDEX','The CREATE INDEX statement doesn\'t do anything in MySQL prior\nto Version 3.22.  In Version 3.22 or later, CREATE INDEX is mapped to an\nNormally, you create all indexes on a table at the time the table itself\nis created with CREATE TABLE.\nA column list of the form (col1,col2,...) creates a multiple-column\nindex.  Index values are formed by concatenating the values of the given\ncolumns.\n','mysql> CREATE INDEX part_of_name ON customer (name(10));','http://www.mysql.com/doc/C/R/CREATE_INDEX.html');
INSERT INTO "manual" VALUES (229,'DROP INDEX','prior to Version 3.22.  In Version 3.22 or later, DROP INDEX is mapped to an\n','','http://www.mysql.com/doc/D/R/DROP_INDEX.html');
INSERT INTO "manual" VALUES (230,'Comment syntax','The MySQL server supports the # to end of line, --\nto end of line and /* in-line or multiple-line */ comment\nstyles:\nNote that the -- comment style requires you to have at least one space\nafter the --!\nAlthough the server understands the comment syntax just described,\nthere are some limitations on the way that the mysql client\n','mysql> select 1+','http://www.mysql.com/doc/C/o/Comments.html');
INSERT INTO "manual" VALUES (231,'Functions, user-defined','A user-definable function (UDF) is a way to extend MySQL with a new\nfunction that works like native (built in) MySQL functions such as\nname in the mysql.func system table.  You must have the\nto create and drop functions.\nAll active functions are reloaded each time the server starts, unless\nyou start mysqld with the --skip-grant-tables option.  In\nthis case, UDF initialization is skipped and UDFs are unavailable.\n','mysql> SELECT * FROM shop;','http://www.mysql.com/doc/U/s/Using_foreign_keys.html');
INSERT INTO "manual" VALUES (232,'UNION','keys combined with OR (Searching on one key with different OR\nparts is optimized quite good):\nThe reason is that we haven\'t yet had time to come up with an efficient\nway to handle this in the general case. (The AND handling is,\nin comparison, now completely general and works very well).\nFor the moment you can solve this very efficently by using a\nyou are using very complicated queries where the SQL server does the\n','mysql> SELECT owner FROM pet;','http://www.mysql.com/doc/R/e/Retrieving_information_from_a_table.html');
INSERT INTO "manual" VALUES (233,'DISTINCT','However, notice that the query simply retrieves the owner field from\neach record, and some of them appear more than once.  To minimize the output,\nretrieve each unique output record just once by adding the keyword\nYou can use a WHERE clause to combine row selection with column\nselection.  For example, to get birth dates for dogs and cats only,\nuse this query:\nYou may have noticed in the preceding examples that the result rows are\n','mysql> SELECT name, birth FROM pet','http://www.mysql.com/doc/R/e/Retrieving_information_from_a_table.html');
INSERT INTO "manual" VALUES (234,'NULL','The NULL value can be surprising until you get used to it.\nConceptually, NULL means missing value or unknown value and it\nis treated somewhat differently than other values.  To test for NULL,\nyou cannot use the arithmetic comparison operators such as =, <,\nor !=.  To demonstrate this for yourself, try the following query:\nClearly you get no meaningful results from these comparisons.  Use\nthe IS NULL and IS NOT NULL operators instead:\n','mysql> SELECT p1.name, p1.sex, p2.name, p2.sex, p1.species','http://www.mysql.com/doc/U/s/Using_more_than_one_table.html');
INSERT INTO "manual" VALUES (235,'DESCRIBE','What if you forget the name of a database or table, or what the structure of\na given table is (for example, what its columns are called)?  MySQL\naddresses this problem through several statements that provide information\nabout the databases and tables it supports.\nYou have already seen SHOW DATABASES, which lists the databases\nmanaged by the server.  To find out which database is currently selected,\nuse the DATABASE() function:\n','mysql> DESCRIBE pet;','http://www.mysql.com/doc/T/u/Tuning_server_parameters.html');
INSERT INTO "manual" VALUES (236,'table_cache','affect the maximum number of files the server keeps open.  If you\nincrease one or both of these values, you may run up against a limit\nimposed by your operating system on the per-process number of open file\ndescriptors.  However, you can increase the limit on many systems.\nConsult your OS documentation to find out how to do this, because the\nmethod for changing the limit varies widely from system to system.\nfor 200 concurrent running connections, you should have a table cache of\n','mysql> SELECT * FROM tbl_name WHERE col2=val2 AND col3=val3;','http://www.mysql.com/doc/H/o/How_mysql_uses_indexes.html');
INSERT INTO "manual" VALUES (237,'LIKE, and wildcards','to LIKE is a constant string that doesn\'t start with a wild-card\ncharacter.  For example, the following SELECT statements use indexes:\nIn the first statement, only rows with \"Patrick\" <= key_col <\n\"Patricl\" are considered.  In the second statement, only rows with\nThe following SELECT statements will not use indexes:\nIn the first statement, the LIKE value begins with a wild-card\ncharacter.  In the second statement, the LIKE value is not a\n','mysql> select * from tbl_name where key_col LIKE other_col;','http://www.mysql.com/doc/H/o/How_mysql_uses_indexes.html');
INSERT INTO "manual" VALUES (238,'IS NULL, and indexes','Searching using column_name IS NULL will use indexes if column_name\nis an index.\nindex is used for columns that you compare with the following operators:\nAny index that doesn\'t span all AND levels in the WHERE clause\nis not used to optimize the query. In other words:  To be able to use an\nindex, a prefix of the index must be used in every AND group.\nThe following WHERE clauses use indexes:\n','mysql> select benchmark(1000000,1+1);','http://www.mysql.com/doc/E/s/Estimating_query_performance.html');
INSERT INTO "manual" VALUES (239,'SELECT speed','In general, when you want to make a slow SELECT ... WHERE faster, the\nfirst thing to check is whether or not you can add an index. MySQL\nindexes, , MySQL indexes. All references between different tables\nshould usually be done with indexes. You can use the EXPLAIN command\nto determine which indexes are used for a SELECT.\nSome general tips:\nTo help MySQL optimize queries better, run myisamchk\n','','http://www.mysql.com/doc/S/p/Speed_of_select_queries.html');
INSERT INTO "manual" VALUES (240,'WHERE','The WHERE optimizations are put in the SELECT part here because\nthey are mostly used with SELECT, but the same optimizations apply for\nAlso note that this section is incomplete. MySQL does many\noptimizations, and we have not had time to document them all.\nSome of the optimizations performed by MySQL are listed below:\nRemoval of unnecessary parentheses:\nConstant folding:\n','mysql> SELECT ... FROM tbl_name ORDER BY key_part1 DESC,key_part2 DESC,...','http://www.mysql.com/doc/H/o/How_mysql_optimizes_where_clauses.html');
INSERT INTO "manual" VALUES (241,'DISTINCT','need a temporary table.\nWhen combining LIMIT # with DISTINCT, MySQL will stop\nas soon as it finds # unique rows.\nIf you don\'t use columns from all used tables, MySQL will stop\nthe scanning of the not used tables as soon as it has found the first match.\nIn the case, assuming t1 is used before t2 (check with EXPLAIN), then\nwhen the first row in t2 is found.\n','','http://www.mysql.com/doc/H/o/How_mysql_optimizes_distinct.html');
INSERT INTO "manual" VALUES (242,'LEFT JOIN','The table B is set to be dependent on table A and all tables\nthat A is dependent on.\nThe table A is set to be dependent on all tables (except B)\nthat are used in the LEFT JOIN condition.\nAll LEFT JOIN conditions are moved to the WHERE clause.\nAll standard join optimizations are done, with the exception that a table is\nalways read after all tables it is dependent on.  If there is a circular\n','','http://www.mysql.com/doc/H/o/How_mysql_optimizes_left_join_and_right_join.html');
INSERT INTO "manual" VALUES (243,'LIMIT','In some cases MySQL will handle the query differently when you are\nusing LIMIT # and not using HAVING:\nIf you are selecting only a few rows with LIMIT, MySQL\nwill use indexes in some cases when it normally would prefer to do a\nfull table scan.\nIf you use LIMIT # with ORDER BY, MySQL will end the\nsorting as soon as it has found the first # lines instead of sorting\n','mysql> DROP FUNCTION reverse_lookup;','http://www.mysql.com/doc/I/g/Ignoring_user_error.html');
INSERT INTO "manual" VALUES (244,'PASSWORD()','You have specified a password in the user table without using the\nfunction:\nIf you get the error Table \'xxx\' doesn\'t exist or Can\'t\nfind file: \'xxx\' (errno: 2), this means that no table exists\nin the current database with the name xxx.\nNote that as MySQL uses directories and files to store databases and\ntables, the database and table names are case sensitive!\n','mysql> update user set password=PASSWORD(\'your password\')','http://www.mysql.com/doc/F/i/File_not_found.html');
INSERT INTO "manual" VALUES (245,'DATE','The format of a DATE value is \'YYYY-MM-DD\'. According to ANSI\nSQL, no other format is allowed. You should use this format in UPDATE\nexpressions and in the WHERE clause of SELECT statements.  For\nexample:\nAs a convenience, MySQL automatically converts a date to a number if\nthe date is used in a numeric context (and vice versa). It is also smart\nenough to allow a ``relaxed\'\' string form when updating and in a WHERE\n','mysql> SELECT * FROM my_table WHERE phone = \"\";','http://www.mysql.com/doc/P/r/Problems_with_null_values.html');
INSERT INTO "manual" VALUES (246,'LOAD DATA INFILE','When reading data with LOAD DATA INFILE, empty columns are updated\nwith \'\'. If you want a NULL value in a column, you should use\nunder some circumstances.\nWhen using ORDER BY, NULL values are presented first. If you\nsort in descending order using DESC, NULL values are presented\nlast.  When using GROUP BY, all NULL values are regarded as\nequal.\n','mysql> SELECT * FROM table_name WHERE float_column between 3.45 and 3.55;','http://www.mysql.com/doc/C/ /C_api_function_descriptions.html');
INSERT INTO "manual" VALUES (247,'mysql_affected_rows()','Returns the number of rows affected (changed) by the last UPDATE,\nstatements.  For SELECT statements, mysql_affected_rows()\nworks like mysql_num_rows().\nAn integer greater than zero indicates the number of rows affected or\nretrieved.  Zero indicates that no records matched the WHERE clause in\nthe query or that no query has yet been executed.  -1 indicates that the\nquery returned an error or that, for a SELECT query,\n','','http://www.mysql.com/doc/m/y/mysql_affected_rows.html');
INSERT INTO "manual" VALUES (248,'mysql_close()','Closes a previously opened connection.  mysql_close() also deallocates\nthe connection handle pointed to by mysql if the handle was allocated\nautomatically by mysql_init() or mysql_connect().\nNone.\nNone.\n','','http://www.mysql.com/doc/m/y/mysql_close.html');
INSERT INTO "manual" VALUES (249,'mysql_connect()','This function is deprecated.  It is preferable to use\ndatabase engine running on host.  mysql_connect() must complete\nsuccessfully before you can execute any of the other API functions, with the\nexception of mysql_get_client_info().\nThe meanings of the parameters are the same as for the corresponding\nparameters for mysql_real_connect() with the difference that the\nconnection parameter may be NULL. In this case the C API\n','','http://www.mysql.com/doc/m/y/mysql_connect.html');
INSERT INTO "manual" VALUES (250,'mysql_change_user()','char *password, const char *db)\nChanges the user and causes the database specified by db to\nbecome the DEFAULT (current) database on the connection specified by\ntable references that do not include an explicit database specifier.\nThis function was introduced in MySQL Version 3.23.3.\nauthenticated or if he doesn\'t have permission to use the database.  In\nthis case the user and database are not changed\n','','http://www.mysql.com/doc/m/y/mysql_change_user.html');
INSERT INTO "manual" VALUES (251,'mysql_character_set_name()','Returns the DEFAULT character set for the current connection.\nThe default character set\nNone.\n','','http://www.mysql.com/doc/m/y/mysql_character_set_name.html');
INSERT INTO "manual" VALUES (252,'mysql_create_db()','Creates the database named by the db parameter.\nThis function is deprecated.  It is preferable to use mysql_query()\nto issue a SQL CREATE DATABASE statement instead.\nZero if the database was created successfully. Non-zero if an error\noccurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\n','','http://www.mysql.com/doc/m/y/mysql_create_db.html');
INSERT INTO "manual" VALUES (253,'mysql_data_seek()','Seeks to an arbitrary row in a query result set.  This requires that the\nresult set structure contains the entire result of the query, so\nThe offset should be a value in the range from 0 to\nNone.\nNone.\n','','http://www.mysql.com/doc/m/y/mysql_data_seek.html');
INSERT INTO "manual" VALUES (254,'mysql_debug()','Does a DBUG_PUSH with the given string. mysql_debug() uses the\nFred Fish debug library. To use this function, you must compile the client\nlibrary to support debugging.\nNone.\nNone.\nThe call shown below causes the client library to generate a trace file in\n','','http://www.mysql.com/doc/m/y/mysql_debug.html');
INSERT INTO "manual" VALUES (255,'mysql_drop_db()','Drops the database named by the db parameter.\nThis function is deprecated.  It is preferable to use mysql_query()\nto issue a SQL DROP DATABASE statement instead.\nZero if the database was dropped successfully. Non-zero if an error\noccurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\n','','http://www.mysql.com/doc/m/y/mysql_drop_db.html');
INSERT INTO "manual" VALUES (256,'mysql_dump_debug_info()','Instructs the server to write some debug information to the log.  The\nconnected user must have the process privilege for this to work.\nZero if the command was successful. Non-zero if an error occurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\nThe connection to the server was lost during the query.\nAn unknown error occurred.\n','','http://www.mysql.com/doc/M/y/Mysql_dump_debug_info.html');
INSERT INTO "manual" VALUES (257,'mysql_eof()','This function is deprecated.  mysql_errno() or mysql_error()\nmay be used instead.\nset has been read.\nIf you acquire a result set from a successful call to\noperation.  In this case, a NULL return from mysql_fetch_row()\nalways means the end of the result set has been reached and it is\nunnecessary to call mysql_eof().\n','','http://www.mysql.com/doc/M/y/Mysql_eof.html');
INSERT INTO "manual" VALUES (258,'mysql_errno()','For the connection specified by mysql, mysql_errno() returns\nthe error code for the most recently invoked API function that can succeed\nor fail.  A return value of zero means that no error occurred. Client error\nmessage numbers are listed in the MySQL errmsg.h header file.\nServer error message numbers are listed in mysqld_error.h. In the\nerror messages and error numbers in the file Docs/mysqld_error.txt.\nAn error code value. Zero if no error occurred.\n','','http://www.mysql.com/doc/M/y/Mysql_errno.html');
INSERT INTO "manual" VALUES (259,'mysql_error()','For the connection specified by mysql, mysql_error() returns\nthe error message for the most recently invoked API function that can succeed\nor fail.  An empty string (\"\") is returned if no error occurred.\nThis means the following two tests are equivalent:\nThe language of the client error messages may be changed by\nrecompiling the MySQL client library. Currently you can choose\nerror messages in several different languages.\n','','http://www.mysql.com/doc/M/y/Mysql_error.html');
INSERT INTO "manual" VALUES (260,'mysql_escape_string()','You should use mysql_real_escape_string() instead!\nThis is identical to mysql_real_escape_string() except that it takes\nthe connection as the first argument. mysql_real_escape_string()\nwill escape the string according to the current character set while mysql_escape_string()\ndoes not respect the current charset setting.\n','','http://www.mysql.com/doc/M/y/Mysql_escape_string.html');
INSERT INTO "manual" VALUES (261,'mysql_fetch_field()','Returns the definition of one column of a result set as a MYSQL_FIELD\nstructure. Call this function repeatedly to retrieve information about all\ncolumns in the result set.  mysql_fetch_field() returns NULL\nwhen no more fields are left.\nfield each time you execute a new SELECT query.  The field returned by\nIf you\'ve called mysql_query() to perform a SELECT on a table\nbut have not called mysql_store_result(), MySQL returns the\n','','http://www.mysql.com/doc/M/y/Mysql_fetch_field.html');
INSERT INTO "manual" VALUES (262,'mysql_fetch_fields()','Returns an array of all MYSQL_FIELD structures for a result set.\nEach structure provides the field definition for one column of the result\nset.\nAn array of MYSQL_FIELD structures for all columns of a result set.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_fetch_fields.html');
INSERT INTO "manual" VALUES (263,'mysql_fetch_field_direct()','Given a field number fieldnr for a column within a result set, returns\nthat column\'s field definition as a MYSQL_FIELD structure. You may use\nthis function to retrieve the definition for an arbitrary column.  The value\nof fieldnr should be in the range from 0 to\nThe MYSQL_FIELD structure for the specified column.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_fetch_field_direct.html');
INSERT INTO "manual" VALUES (264,'mysql_fetch_lengths()','Returns the lengths of the columns of the current row within a result set.\nIf you plan to copy field values, this length information is also useful for\noptimization, because you can avoid calling strlen().  In addition, if\nthe result set contains binary data, you must use this function to\ndetermine the size of the data, because strlen() returns incorrect\nresults for any field containing null characters.\nThe length for empty columns and for columns containing NULL values is\n','','http://www.mysql.com/doc/M/y/Mysql_fetch_lengths.html');
INSERT INTO "manual" VALUES (265,'mysql_fetch_row()','Retrieves the next row of a result set. When used after\nwhen there are no more rows to retrieve.  When used after\nthere are no more rows to retrieve or if an error occurred.\nThe number of values in the row is given by mysql_num_fields(result).\nIf row holds the return value from a call to mysql_fetch_row(),\npointers to the values are accessed as row[0] to\nindicated by NULL pointers.\n','','http://www.mysql.com/doc/M/y/Mysql_fetch_row.html');
INSERT INTO "manual" VALUES (266,'mysql_field_count()','If you are using a version of MySQL earlier than Version 3.22.24, you\nshould use  int mysql_num_fields(MYSQL *mysql) instead.\nReturns the number of columns for the most recent query on the connection.\nThe normal use of this function is when mysql_store_result()\nreturned NULL (and thus you have no result set pointer).\nIn this case, you can call mysql_field_count() to\ndetermine whether or not mysql_store_result() should have produced a\n','','http://www.mysql.com/doc/M/y/Mysql_field_count.html');
INSERT INTO "manual" VALUES (267,'mysql_field_seek()','Sets the field cursor to the given offset.   The next call to\nassociated with that offset.\nTo seek to the beginning of a row, pass an offset value of zero.\nThe previous value of the field cursor.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_field_seek.html');
INSERT INTO "manual" VALUES (268,'mysql_field_tell()','Returns the position of the field cursor used for the last\nThe current offset of the field cursor.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_field_tell.html');
INSERT INTO "manual" VALUES (269,'mysql_free_result()','Frees the memory allocated for a result set by mysql_store_result(),\nwith a result set, you must free the memory it uses by calling\nNone.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_free_result.html');
INSERT INTO "manual" VALUES (270,'mysql_get_client_info()','Returns a string that represents the client library version.\nA character string that represents the MySQL client library version.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_get_client_info.html');
INSERT INTO "manual" VALUES (271,'mysql_get_host_info()','Returns a string describing the type of connection in use, including the\nserver host name.\nA character string representing the server host name and the connection type.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_get_host_info.html');
INSERT INTO "manual" VALUES (272,'mysql_get_proto_info()','Returns the protocol version used by current connection.\nAn  integer representing the protocol version used by the current\nconnection.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_get_proto_info.html');
INSERT INTO "manual" VALUES (273,'mysql_get_server_info()','Returns a string that represents the server version number.\nA character string that represents the server version number.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_get_server_info.html');
INSERT INTO "manual" VALUES (274,'mysql_info()','Retrieves a string providing information about the most recently executed\nquery, but only for the statements listed below.  For other statements,\ndepending on the type of query, as described below.  The numbers are\nillustrative only; the string will contain values appropriate for the query.\nString format: Records: 100 Duplicates: 0 Warnings: 0\nString format: Records: 3  Duplicates: 0  Warnings: 0\nString format: Records: 1 Deleted: 0 Skipped: 0 Warnings: 0\n','','http://www.mysql.com/doc/M/y/Mysql_info.html');
INSERT INTO "manual" VALUES (275,'mysql_init()','Allocates or initializes a MYSQL object suitable for\nfunction allocates, initializes, and returns a new object.  Otherwise the\nobject is initialized and the address of the object is returned.  If\nAn initialized MYSQL* handle.  NULL if there was\ninsufficient memory to allocate a new object.\nIn case of insufficient memory, NULL is returned.\n','','http://www.mysql.com/doc/M/y/Mysql_init.html');
INSERT INTO "DEFAULT" nextval('') value.  If you need to save\nthe value for later, be sure to call mysql_insert_id() immediately\nafter the query that generates the value.\n','','http://www.mysql.com/doc/M/y/Mysql_insert_id.html');
INSERT INTO "manual" VALUES (277,'mysql_kill()','Asks the server to kill the thread specified by pid.\nZero for success.  Non-zero if an error occurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\nThe connection to the server was lost during the query.\nAn unknown error occurred.\n','','http://www.mysql.com/doc/M/y/Mysql_kill.html');
INSERT INTO "manual" VALUES (278,'mysql_list_dbs()','Returns a result set consisting of database names on the server that match\nthe simple regular expression specified by the wild parameter.\nbe a NULL pointer to match all databases.  Calling\ndatabases [LIKE wild].\nYou must free the result set with mysql_free_result().\nA MYSQL_RES result set for success.  NULL if an error occurred.\nCommands were executed in an improper order.\n','','http://www.mysql.com/doc/M/y/Mysql_list_dbs.html');
INSERT INTO "manual" VALUES (279,'mysql_list_fields()','Returns a result set consisting of field names in the given table that match\nthe simple regular expression specified by the wild parameter.\nbe a NULL pointer to match all fields.  Calling\nCOLUMNS FROM tbl_name [LIKE wild].\nNote that it\'s recommended that you use SHOW COLUMNS FROM tbl_name\ninstead of mysql_list_fields().\nYou must free the result set with mysql_free_result().\n','','http://www.mysql.com/doc/ /m/_mysql_list_fields.html');
INSERT INTO "manual" VALUES (280,'mysql_list_processes()','Returns a result set describing the current server threads.  This is the same\nkind of information as that reported by mysqladmin processlist or\na SHOW PROCESSLIST query.\nYou must free the result set with mysql_free_result().\nA MYSQL_RES result set for success.  NULL if an error occurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\n','','http://www.mysql.com/doc/M/y/Mysql_list_processes.html');
INSERT INTO "manual" VALUES (281,'mysql_list_tables()','Returns a result set consisting of table names in the current database that\nmatch the simple regular expression specified by the wild parameter.\nbe a NULL pointer to match all tables.  Calling\ntables [LIKE wild].\nYou must free the result set with mysql_free_result().\nA MYSQL_RES result set for success.  NULL if an error occurred.\nCommands were executed in an improper order.\n','','http://www.mysql.com/doc/M/y/Mysql_list_tables.html');
INSERT INTO "manual" VALUES (282,'mysql_field_count()','or\nThe second form doesn\'t work on MySQL Version 3.22.24 or newer.  To pass a\nReturns the number of columns in a result set.\nNote that you can get the number of columns either from a pointer to a result\nset or to a connection handle.  You would use the connection handle if\ncall mysql_field_count() to determine whether or not\nallows the client program to take proper action without knowing whether or\n','','http://www.mysql.com/doc/M/y/Mysql_num_fields.html');
INSERT INTO "manual" VALUES (283,'mysql_num_rows()','Returns the number of rows in the result set.\nThe use of mysql_num_rows() depends on whether you use\nset.  If you use mysql_store_result(), mysql_num_rows() may be\ncalled immediately.  If you use mysql_use_result(),\nin the result set have been retrieved.\nThe number of rows in the result set.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_num_rows.html');
INSERT INTO "manual" VALUES (284,'mysql_options()','Can be used to set extra connect options and affect behavior for a connection.\nThis function may be called multiple times to set several options.\nThe option argument is the option that you want to set; the arg\nargument is the value for the option. If the option is an integer, then\nPossible options values:\nNote that the group client is always read if you use\nThe specified group in the option file may contain the following options:\n','','http://www.mysql.com/doc/M/y/Mysql_options.html');
INSERT INTO "manual" VALUES (285,'mysql_ping()','Checks whether or not the connection to the server is working. If it has gone\ndown, an automatic reconnection is attempted.\nThis function can be used by clients that remain idle for a long while,\nto check whether or not the server has closed the connection and reconnect\nif necessary.\nZero if the server is alive. Non-zero if an error occurred.\nCommands were executed in an improper order.\n','','http://www.mysql.com/doc/M/y/Mysql_ping.html');
INSERT INTO "manual" VALUES (286,'mysql_query()','Executes the SQL query pointed to by the null-terminated string query.\nThe query must consist of a single SQL statement.  You should not add\na terminating semicolon (@samp{;) or \\g to the statement.\nshould use mysql_real_query() instead.  (Binary data may contain the\nquery string.)\nIf you want to know if the query should return a result set or not, you can\nuse mysql_field_count() to check for this.\n','','http://www.mysql.com/doc/M/y/Mysql_query.html');
INSERT INTO "manual" VALUES (287,'mysql_real_connect()','                          const char *user, const char *passwd, const char *db,\n                           int port, const char *unix_socket,\n                          unsigned int client_flag)\nany of the other API functions, with the exception of\nThe parameters are specified as follows:\nThe first parameter should be the address of an existing MYSQL\nstructure.  Before calling mysql_real_connect() you must call\n','','http://www.mysql.com/doc/M/y/Mysql_real_connect.html');
INSERT INTO "manual" VALUES (288,'mysql_real_escape_string()','Encodes the string in from to an escaped SQL string, taking into\naccount the current charset of the connection, that can be sent to the\nserver in a SQL statement, places the result in to, and adds a\nterminating null byte.  Characters encoded are NUL (ASCII 0),\n(@pxref{Literals).\nThe string pointed to by from must be length bytes long.  You\nmust allocate the to buffer to be at least length*2+1 bytes\n','','http://www.mysql.com/doc/M/y/Mysql_real_escape_string.html');
INSERT INTO "manual" VALUES (289,'mysql_real_query()','Executes the SQL query pointed to by query, which should be a string\nYou should not add a terminating semicolon (@samp{;) or \\g to the\nstatement.\nYou must use mysql_real_query() rather than\nmay contain the @samp{\\0 character.  In addition, mysql_real_query()\nis faster than mysql_query() because it does not call strlen() on\nthe query string.\n','','http://www.mysql.com/doc/M/y/Mysql_real_query.html');
INSERT INTO "manual" VALUES (290,'mysql_reload()','Asks the MySQL server to reload the grant tables. The\nconnected user must have the reload privilege.\nThis function is deprecated.  It is preferable to use mysql_query()\nto issue a SQL FLUSH PRIVILEGES statement instead.\nZero for success.  Non-zero if an error occurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\n','','http://www.mysql.com/doc/M/y/Mysql_reload.html');
INSERT INTO "manual" VALUES (291,'mysql_row_seek()','Sets the row cursor to an arbitrary row in a query result set.  This requires\nthat the result set structure contains the entire result of the query, so\nThe offset should be a value returned from a call to mysql_row_tell()\nor to mysql_row_seek().  This value is not simply a row number; if you\nwant to seek to a row within a result set using a row number, use\nThe previous value of the row cursor.  This value may be passed to a\nsubsequent call to mysql_row_seek().\n','','http://www.mysql.com/doc/M/y/Mysql_row_seek.html');
INSERT INTO "manual" VALUES (292,'mysql_row_tell()','Returns the current position of the row cursor for the last\nYou should use mysql_row_tell() only after mysql_store_result(),\nnot after mysql_use_result().\nThe current offset of the row cursor.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_row_tell.html');
INSERT INTO "manual" VALUES (293,'mysql_select_db()','Causes the database specified by db to become the DEFAULT (current)\ndatabase on the connection specified by mysql.  In subsequent queries,\nthis database is the default for table references that do not include an\nexplicit database specifier.\nas having permission to use the database.\nZero for success.  Non-zero if an error occurred.\nCommands were executed in an improper order.\n','','http://www.mysql.com/doc/M/y/Mysql_select_db.html');
INSERT INTO "manual" VALUES (294,'mysql_shutdown()','Asks the database server to shut down. The connected user must have\nZero for success.  Non-zero if an error occurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\nThe connection to the server was lost during the query.\nAn unknown error occurred.\n','','http://www.mysql.com/doc/M/y/Mysql_shutdown.html');
INSERT INTO "manual" VALUES (295,'mysql_stat()','Returns a character string containing information similar to that provided by\nthe mysqladmin status command.  This includes uptime in seconds and\nthe number of running threads, questions, reloads, and open tables.\nA character string describing the server status. NULL if an\nerror occurred.\nCommands were executed in an improper order.\nThe MySQL server has gone away.\n','','http://www.mysql.com/doc/M/y/Mysql_stat.html');
INSERT INTO "manual" VALUES (296,'mysql_store_result()','You must call mysql_store_result() or mysql_use_result()\nfor every query that successfully retrieves data (SELECT,\nIf you want to know if the query should return a result set or not, you can\nuse mysql_field_count() to check for this.\nallocates a MYSQL_RES structure, and places the result into this\nstructure.\na result set (if the query was, for example, an INSERT statement).\n','','http://www.mysql.com/doc/M/y/Mysql_store_result.html');
INSERT INTO "manual" VALUES (297,'mysql_thread_id()','Returns the thread ID of the current connection.  This value can be used as\nan argument to mysql_kill() to kill the thread.\nIf the connection is lost and you reconnect with mysql_ping(), the\nthread ID will change.  This means you should not get the thread ID and store\nit for later. You should get it when you need it.\nThe thread ID of the current connection.\nNone.\n','','http://www.mysql.com/doc/M/y/Mysql_thread_id.html');
INSERT INTO "manual" VALUES (298,'mysql_use_result()','You must call mysql_store_result() or mysql_use_result() for\nevery query that successfully retrieves data (SELECT, SHOW,\nactually read the result set into the client like mysql_store_result()\ndoes.  Instead, each row must be retrieved individually by making calls to\nserver without storing it in a temporary table or local buffer, which is\nsomewhat faster and uses much less memory than mysql_store_result().\nThe client will only allocate memory for the current row and a communication\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (299,'connect() DBI method','Use the connect method to make a database connection to the data\nsource. The $data_source value should begin with\nExample uses of connect with the DBD::mysql driver:\nIf the user name and/or password are undefined, DBI uses the\nvalues of the DBI_USER and DBI_PASS environment variables,\nrespectively. If you don\'t specify a hostname, it DEFAULTs to\ndefault MySQL port (@value{default_port).\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (300,'disconnect DBI method','The disconnect method disconnects the database handle from the database.\nThis is typically called right before you exit from the program.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (301,'prepare() DBI method','Prepares a SQL statement for execution by the database engine\nand returns a statement handle ($sth), which you can use to invoke\nthe execute method.\nTypically you handle SELECT statements (and SELECT-like statements\nsuch as SHOW, DESCRIBE, and EXPLAIN) by means of\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (302,'execute DBI method','The execute method executes a prepared statement. For\nnon-SELECT statements, execute returns the number of rows\naffected.  If no rows are affected, execute returns \"0E0\",\nwhich Perl treats as zero but regards as true. If an error occurs,\nof the fetch_* methods described below to retrieve the data.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (303,'do() DBI method','The do method prepares and executes a SQL statement and returns the\nnumber of rows affected.  If no rows are affected, do returns\ngenerally used for non-SELECT statements that cannot be prepared in\nadvance (due to driver limitations) or that do not need to be executed more\nthan once (inserts, deletes, etc.). Example:\nGenerally the \'do\' statement is MUCH faster (and is preferable)\nthan prepare/execute for statements that don\'t contain parameters.\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (304,'quote() DBI method','The quote method is used to \"escape\" any special characters contained in\nthe string and to add the required outer quotation marks.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (305,'fetchrow_array DBI method','This method fetches the next row of data and returns it as an array of\nfield values.  Example:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (306,'fetchrow_arrayref DBI method','This method fetches the next row of data and returns it as a reference\nto an array of field values. Example:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (307,'fetchrow_hashref DBI method','This method fetches a row of data and returns a reference to a hash\ntable containing field name/value pairs. This method is not nearly as\nefficient as using array references as demonstrated above. Example:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (308,'fetchall_arrayref DBI method','This method is used to get all the data (rows) to be returned from the\nSQL statement. It returns a reference to an array of references to arrays\nfor each row. You access or print the data by using a nested\nloop. Example:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (309,'finish DBI method','Indicates that no more data will be fetched from this statement\nhandle. You call this method to free up the statement handle and any\nsystem resources associated with it.  Example:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (310,'rows DBI method','Returns the number of rows changed (updated, deleted, etc.) by the last\ncommand.  This is usually used after a non-SELECT execute\nstatement.  Example:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (311,'NULLABLE DBI method','Returns a reference to an array of boolean values; for each element of\nthe array, a value of TRUE indicates that this\ncolumn may contain NULL values.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (312,'NUM_OF_FIELDS DBI method','This attribute indicates\nthe number of fields returned by a SELECT or SHOW FIELDS\nstatement.  You may use this for checking whether a statement returned a\nresult: A zero value indicates a non-SELECT statement like\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (313,'data_sources() DBI method','This method returns an array containing names of databases available to the\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (314,'ChopBlanks DBI method','This attribute determines whether the fetchrow_* methods will chop\nleading and trailing blanks from the returned values.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (315,'trace DBI method','The trace method enables or disables tracing.  When invoked as a\na database or statement handle method, it affects tracing for the given\nhandle (and any future children of the handle).  Setting $trace_level\nto 2 provides detailed trace information.  Setting $trace_level to 0\ndisables tracing.  Trace output goes to the standard error output by\nDEFAULT.  If $trace_filename is specified, the file is opened in\nappend mode and output for all traced handles is written to that\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "DEFAULT" nextval('') feature of MySQL, the new\nauto-incremented values will be stored here.\nExample:\nAs an alternative, you can use $dbh->@{\'mysql_insertid\'@.\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (317,'text DBI method','Returns a reference to an array of boolean values; for each element of the\narray, a value of TRUE indicates that the\nrespective column is a BLOB.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (318,'is_key DBI method','Returns a reference to an array of boolean values; for each element of the\narray, a value of TRUE indicates that the\nrespective column is a key.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (319,'is_num DBI method','Returns a reference to an array of boolean values; for each element of the\narray, a value of TRUE indicates that the\nrespective column contains numeric values.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (320,'is_pri_key DBI method','Returns a reference to an array of boolean values; for each element of the\narray, a value of TRUE indicates that the respective column is a primary key.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (321,'is_not_null DBI method','Returns a reference to an array of boolean values; for each element of the\narray, a value of FALSE indicates that this column may contain NULL\nvalues.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (322,'max_length DBI method','Each of these methods returns a reference to an array of column sizes.  The\nbe (as declared in the table description).  The max_length array\nindicates the maximum sizes actually present in the result table.  Example:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (323,'NAME DBI method','Returns a reference to an array of column names.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (324,'table DBI method','Returns a reference to an array of table names.\nExample:\n','','http://www.mysql.com/doc/T/h/The_dbi_interface.html');
INSERT INTO "manual" VALUES (325,'type DBI method','Returns a reference to an array of column types.\nExample:\nYou can use the perldoc command to get more information about\nYou can also use the pod2man, pod2html, etc., tools to\ntranslate to other formats.\nYou can find the latest DBI information at\nthe DBI Web page:\n','mysql> UPDATE tbl_name SET KEY=KEY+1 WHERE KEY+0 > 100;','http://www.mysql.com/doc/M/y/Mysql_test_suite.html');
INSERT INTO "manual" VALUES (326,'trace DBI method','If you are using the Perl DBI interface, you can turn on\ndebugging information by using the trace method or by\nsetting the DBI_TRACE environment variable.\nOn some operating systems, the error log will contain a stack trace if\nmaybe why) mysqld died. Error log.  To get a stack trace,\nyou should NOT compile mysqld with the\nIf the error file contains something like the following:\n','mysql> select \"weeknights\" REGEXP \"^(wee|week)(knights|nights)$\"; -> 1','http://www.mysql.com/doc/M/y/Mysql_test_suite.html');
INSERT INTO "manual" VALUES (328,'msql2mysql','A shell script that converts mSQL programs to MySQL. It doesn\'t handle all cases, but it gives a good start when converting. ',NULL,NULL);
INSERT INTO "manual" VALUES (329,'mysqlaccess','A script that checks the access privileges for a host, user, and database combination.',NULL,NULL);
INSERT INTO "manual" VALUES (330,'mysqladmin','Utility for performing administrative operations, such as creating or dropping databases, reloading the grant tables, flushing tables to disk, and reopening log files. mysqladmin can also be used to retrieve version, process, and status information from the server. See section 14.5 Administering a MySQL Server. ',NULL,NULL);
INSERT INTO "manual" VALUES (331,'mysqlbug','The MySQL bug report script. This script should always be used when filing a bug report to the MySQL list.',NULL,NULL);
INSERT INTO "manual" VALUES (332,'mysqld','The SQL daemon. This should always be running.',NULL,NULL);
INSERT INTO "manual" VALUES (333,'mysqldump','Dumps a MySQL database into a file as SQL statements or as tab-separated text files. Enhanced freeware originally by Igor Romanenko. See section 14.6 Dumping the Structure and\n      Data from MySQL Databases and Tables. ',NULL,NULL);
INSERT INTO "manual" VALUES (334,'mysqlimport','Imports text files into their respective tables using LOAD DATA INFILE. See section 14.8 Importing Data from Text Files. ',NULL,NULL);
INSERT INTO "manual" VALUES (335,'mysqlshow','Displays information about databases, tables, columns, and indexes.',NULL,NULL);
INSERT INTO "manual" VALUES (336,'mysql_install_db','Creates the MySQL grant tables with DEFAULT privileges. This is usually executed only once, when first installing MySQL on a system. ',NULL,NULL);
INSERT INTO "manual" VALUES (337,'replace','A utility program that is used by msql2mysql, but that has more general applicability as well. replace changes strings in place in files or on the standard input. Uses a finite state  machine to match longer strings first. Can be used to swap strings. For example, this command swaps a and b in the given files: ',NULL,NULL);

--
-- Table structure for table 'mode_data'
--



--
-- Sequences for table MODE_DATA
--

CREATE SEQUENCE mode_data_mode_data_id_seq;

CREATE TABLE "mode_data" (
  "mode_data_id" INT4 DEFAULT nextval('mode_data_mode_data_id_seq'),
  "chan_name" varchar(100) NOT NULL DEFAULT '',
  "action" varchar(100) NOT NULL DEFAULT '',
  "date_inserted" TIMESTAMP NOT NULL,
  "added_by" varchar(100) DEFAULT NULL,
  PRIMARY KEY ("mode_data_id")

);

--
-- Dumping data for table 'mode_data'
--


--
-- Table structure for table 'module_binds'
--



--
-- Sequences for table MODULE_BINDS
--

CREATE SEQUENCE module_binds_module_binds_id;

CREATE TABLE "module_binds" (
  "module_binds_id" INT4 DEFAULT nextval('module_binds_module_binds_id'),
  "token" char(10),
  "bind" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("module_binds_id")

);

--
-- Dumping data for table 'module_binds'
--

INSERT INTO "module_binds" VALUES (1,'','MODE');
INSERT INTO "module_binds" VALUES (2,'','TOPIC');
INSERT INTO "module_binds" VALUES (3,'','PRIVMSG');
INSERT INTO "module_binds" VALUES (4,'','CHANMSG');
INSERT INTO "module_binds" VALUES (5,'/msg','BOTMSG');
INSERT INTO "module_binds" VALUES (6,'','NOTICE');
INSERT INTO "module_binds" VALUES (7,'','PART');
INSERT INTO "module_binds" VALUES (8,'','QUIT');
INSERT INTO "module_binds" VALUES (9,'','JOIN');
INSERT INTO "module_binds" VALUES (10,'','NICK');
INSERT INTO "module_binds" VALUES (11,'','BOT_JOIN_TOPIC_SETBY');
INSERT INTO "module_binds" VALUES (12,'','BOT_JOIN_TOPIC');
INSERT INTO "module_binds" VALUES (13,'','BOT_JOIN_NAMES');
INSERT INTO "module_binds" VALUES (14,'!','!_COMMAND');
INSERT INTO "module_binds" VALUES (15,'?','?_COMMAND');
INSERT INTO "module_binds" VALUES (16,'','SHOW');
INSERT INTO "module_binds" VALUES (17,'','ONKICK');
INSERT INTO "module_binds" VALUES (18,'','DCC');

--
-- Table structure for table 'modules'
--



--
-- Sequences for table MODULES
--

CREATE SEQUENCE modules_modules_id_seq;

CREATE TABLE "modules" (
  "modules_id" INT4 DEFAULT nextval('modules_modules_id_seq'),
  "module_binds_id" INT4 NOT NULL DEFAULT '0',
  "module_name" varchar(255) NOT NULL DEFAULT '',
  "module_desc" varchar(255) NOT NULL DEFAULT '',
  "module_file_name" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("modules_id")

);

--
-- Dumping data for table 'modules'
--

INSERT INTO "modules" VALUES (1,14,'die','forces the bot to quit irc close db connection and exits the script','modules/die.mdl');
INSERT INTO "modules" VALUES (2,5,'ctcp','controls all ctcp commands','modules/ctcp.mdl');
INSERT INTO "modules" VALUES (3,1,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (7,7,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (8,8,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (9,9,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (10,10,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (11,11,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (12,12,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (13,13,'server_msgs','mode part quit and some others','modules/server_msgs.mdl');
INSERT INTO "modules" VALUES (14,15,'help','?php ?mysql and ?perl','modules/help.mdl');
INSERT INTO "modules" VALUES (15,9,'auto_voice','auto voices people with v and f global or chan level in chans they join if the chan is set to auto voice','modules/auto_voice.mdl');
INSERT INTO "modules" VALUES (16,18,'dot_functions','all the functions that start with a .','modules/dot_functions.mdl');
INSERT INTO "modules" VALUES (17,14,'chanel_commands','all the channel commands that start with a !','modules/channel_commands.mdl');
INSERT INTO "modules" VALUES (18,9,'tclbotautoop','ops bots set with bo global only matches nick against user and hostmask to be sure.','modules/tclbotautoop.mdl');
INSERT INTO "modules" VALUES (19,16,'help_show','converts all the show php show mysql and show perl to to user sending show command','modules/helpshow.mdl');
INSERT INTO "modules" VALUES (20,17,'onkick','updates chan users when someone gets kicked','modules/onkick.mdl');
INSERT INTO "modules" VALUES (21,5,'msg_help','sends nice little help on all the msg functions','modules/msghelp.mdl');
INSERT INTO "modules" VALUES (22,5,'msgcommands','goes with all the msgs in helpmsg','modules/msgcommands.mdl');

--
-- Table structure for table 'part_msg'
--



--
-- Sequences for table PART_MSG
--

CREATE SEQUENCE part_msg_part_msg_id_seq;

CREATE TABLE "part_msg" (
  "part_msg_id" INT4 DEFAULT nextval('part_msg_part_msg_id_seq'),
  "chan_name" varchar(50) NOT NULL DEFAULT '',
  "msg" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("part_msg_id")

);

--
-- Dumping data for table 'part_msg'
--


--
-- Table structure for table 'perl_manual'
--



--
-- Sequences for table PERL_MANUAL
--

CREATE SEQUENCE perl_manual_id_seq;

CREATE TABLE "perl_manual" (
  ID INT4 DEFAULT nextval('perl_manual_id_seq'),
  "command" varchar(255) NOT NULL DEFAULT '',
  "dscr" varchar(255) NOT NULL DEFAULT '',
  "ex" varchar(255) DEFAULT NULL,
  PRIMARY KEY ("ID")

);

--
-- Dumping data for table 'perl_manual'
--

INSERT INTO "perl_manual" VALUES (1,'$!','If used in a numeric context, yields the current value of errno, with all the usual caveats, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (2,'$#','The output format for printed numbers, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (3,'$#array','the last index of @array. scalar(@array) returns the length of the array (scalar(@array) == $#array - $[ + 1). Which means that scalar(@array) is equivalent to the next available index of the array. http://www.perl.com/CPAN-local/doc/manual/html/pod/perld',NULL);
INSERT INTO "perl_manual" VALUES (4,'$$','The process number of the Perl running this script, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (5,'$%','The current page number of the currently selected output channel, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (6,'$&','The string matched by the last successful pattern match (not counting any matches hidden within a BLOCK or eval() enclosed by the current BLOCK), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (7,'$\'','The string following whatever was matched by the last successful pattern match, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (8,'$(','The FLOAT8gid of this process, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (9,'$)','The effective gid of this process, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (10,'$*','Set to 1 to do multi-line matching within a string, 0 to tell Perl that it can assume that strings contain a single line, for the purpose of optimizing pattern matches, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for patte',NULL);
INSERT INTO "perl_manual" VALUES (11,'$+','The last bracket matched by the last search pattern, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (12,'$,','The output field separator for the print operator, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (13,'$-','The number of lines left on the page of the currently selected output channel, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (14,'$.','The current input line number for the last file handle from which you read (or performed a seek or tell on), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (15,'$/','The input record separator, newline by DEFAULT, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (16,'$0','Contains the name of the file containing the Perl script being executed, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (17,'$:','The current set of characters after which a string may be broken to fill continuation fields (starting with ^) in a format, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (18,'$;','The subscript separator for multidimensional array emulation, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (19,'$<','The FLOAT8uid of this process, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (20,'$=','The current page length (printable lines) of the currently selected output channel, DEFAULT is 60, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (21,'$>','The effective uid of this process, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (22,'$?','The status returned by the last pipe close, backtick (``) command, or system() operator, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (23,'$@','The Perl syntax error message from the last eval() command, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (24,'$[','The index of the first element in an array, and of the first character in a substring, DEFAULT is 0, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (25,'$','The output record separator for the print operator, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (26,'$]','The version + patchlevel / 1000 of the Perl interpreter, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html',NULL);
INSERT INTO "perl_manual" VALUES (27,'$^','The name of the current top-of-page format for the currently selected output channel, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (28,'$^a','The current value of the write() accumulator for format() lines, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (29,'$^d','The current value of the debugging flags, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (30,'$^e','Error information specific to the current operating system, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (31,'$^f','The maximum system file descriptor, ordinarily 2, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (32,'$^h','The current set of syntax checks enabled by use strict and other block scoped compiler hints, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (33,'$^i','The current value of the inplace-edit extension, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (34,'$^l','What formats output to perform a form feed. Default is f, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (35,'$^o','The name of the operating system under which this copy of Perl was built, as determined during the configuration process, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (36,'$^p','The internal variable for debugging support, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (37,'$^r','The result of evaluation of the last successful (?{ code }) regular expression assertion, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (38,'$^s','Current state of the interpreter, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (39,'$^t','The time at which the script began running, in seconds since the epoch (beginning of 1970), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (40,'$^w','The current value of the warning switch, either TRUE or FALSE, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (41,'$^x','The name that the Perl binary itself was executed, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (42,'$_','The DEFAULT input and pattern-searching space, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (43,'$`','The string preceding whatever was matched by the last successful pattern match, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (44,'$arg','The DEFAULT input and pattern-searching space, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (45,'$argv','Contains the name of the current file when reading from <>, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (46,'$|','If set to nonzero, forces a flush right away and after every write or print on the currently selected output channel, DEFAULT is 0, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (47,'$~','The name of the current report format for the currently selected output channel, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html (Search page for pattern)\n',NULL);
INSERT INTO "perl_manual" VALUES (48,'%env','Hash that holds environmental variables accessible for perl. (To see what is available on you server get http://www.dgits.com/scripts/misc/env.txt -> upload cgi-bin as env.cgi -> chmod 755 -> access with browser), http://www.dgits.com/cgi-local/etc/env.cg',NULL);
INSERT INTO "perl_manual" VALUES (49,'%inc','The hash %INC contains entries for each filename that has been included via do or require, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (50,'%sig','The hash %SIG is used to set signal handlers for various signals, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (51,'-a','Perl command line options: turns on autosplit mode when used with a -n or -p. An implicit split command to the @F array is done as the first thing inside the implicit while loop produced by the -n or -p, http://www.perl.com/CPAN-local/doc/manual/html/pod/',NULL);
INSERT INTO "perl_manual" VALUES (52,'-c','Perl command line options: causes Perl to check the syntax of the script and then exit without executing it. Actually, it will execute BEGIN, END, and use blocks, because these are considered as occurring outside the execution of your program, http://www.',NULL);
INSERT INTO "perl_manual" VALUES (53,'-d','Perl command line options: runs the script under the Perl debugger. See the perldebug manpage, http://www.perl.com/CPAN-local/doc/manual/html/pod/perldebug.html\n',NULL);
INSERT INTO "perl_manual" VALUES (54,'-e','Perl command line options: may be used to enter one line of script. If -e is given, Perl will not look for a script filename in the argument list. Multiple -e commands may be given to build up a multi-line script. Make sure to use semicolons where you wou',NULL);
INSERT INTO "perl_manual" VALUES (55,'-l','Perl command line options (-l [octnum]): enables automatic line-ending processing - assigns $ (the output record separator) to have the value of [octnum] or automatically chops $/ (the input record separator) if used with -n or -p, http://www.perl.com/CPA',NULL);
INSERT INTO "perl_manual" VALUES (56,'-m','Perl command line options: -Mmodule executes use module ; before executing your script. You can use quotes to add extra code after the module name, e.g., -M\'module qw(foo bar)\', http://www.perl.com/CPAN-local/doc/manual/html/pod/perlrun.html\n',NULL);
INSERT INTO "perl_manual" VALUES (57,'-n','Perl command line options: causes Perl to assume the following loop around your script, which makes it iterate over filename arguments somewhat like sed -n or awk: while (<>) { ... }, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlrun.html\n',NULL);
INSERT INTO "perl_manual" VALUES (58,'-s','Perl command line options: enables some rudimentary switch parsing for switches on the command line after the script name but before any filename arguments (or before a --), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlrun.html\n',NULL);
INSERT INTO "perl_manual" VALUES (59,'-t','Perl command line options: forces ``taint\'\' checks to be turned on so you can test them, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlrun.html\n',NULL);
INSERT INTO "perl_manual" VALUES (60,'-w','Perl command line options: prints warnings about variable names that are mentioned only once, and scalar variables that are used before being set. Also warns about redefined subroutines, and references to undefined filehandles or filehandles opened read-o',NULL);
INSERT INTO "perl_manual" VALUES (61,'-x','Test associated file for various conditions, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/_X.html\n',NULL);
INSERT INTO "perl_manual" VALUES (62,'500','a general server error, which occurs when script cannot be compiled for one reason or another. The reason might be wrong upload mode (must be \'ascii\') or syntax error (for scripts written in perl or other interpreted languages), invalid file permissions (',NULL);
INSERT INTO "perl_manual" VALUES (63,';','the symbol that signifies the end of a command. The most common syntax error is missing a \';\' on a previous line. You may have to check back a couple of lines, but you\'re probably missing one somewhere.\n',NULL);
INSERT INTO "perl_manual" VALUES (64,'<>','Null filehandle, which can be used to emulate the behavior of sed and awk. Input comes either from standard input, or from each file listed on the command line, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlop.html#I_O_Operators\n',NULL);
INSERT INTO "perl_manual" VALUES (65,'<keyword>','replace <keyword> with what you want help on. :)\n',NULL);
INSERT INTO "perl_manual" VALUES (66,'=~','the Perl binding operator. It binds a scalar expression to a pattern match, substitution, or translation.\n',NULL);
INSERT INTO "perl_manual" VALUES (67,'@_','the array within a subroutine containing the parameters passed to the subroutine (see perlsub), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (68,'@argv','The array @ARGV contains the command line arguments intended for the script, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (69,'@inc','Array which contains the list of places to look for Perl scripts to be evaluated by the do EXPR, require, or use constructs, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (70,'q','Quote and Quote-like Operators, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlop.html#Quote_and_Quote_like_Operators\n',NULL);
INSERT INTO "perl_manual" VALUES (71,'abs','Absolute value function, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/abs.html\n',NULL);
INSERT INTO "perl_manual" VALUES (72,'accept','Accept an incoming socket connect, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/accept.html\n',NULL);
INSERT INTO "perl_manual" VALUES (73,'accessprobe','nice log analyzer, http://www.accessprobe.com\n',NULL);
INSERT INTO "perl_manual" VALUES (74,'activeperl','Perl for win32 platforms, http://www.activestate.com\n',NULL);
INSERT INTO "perl_manual" VALUES (75,'alarm','Schedule a SIGALRM, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/alarm.html\n',NULL);
INSERT INTO "perl_manual" VALUES (76,'ansi c','ANSI C Reference, http://slique.net/vikrum/reference/c,\n',NULL);
INSERT INTO "perl_manual" VALUES (77,'anydbm_file','Provide framework for multiple DBMs, http://www.perl.com/CPAN-local/doc/manual/html/lib/AnyDBM_File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (78,'apache','Apache server perl modules, http://theory.uwinnipeg.ca/CPAN/by-category/23_Miscellaneous_Modules.html\n',NULL);
INSERT INTO "perl_manual" VALUES (79,'apache binaries','Location to download apache server binaries for various platforms, http://www.apache.org/dist/binaries/\n',NULL);
INSERT INTO "perl_manual" VALUES (80,'apache dso','Apache Dynamic Shared Object (DSO) Support, http://www.apache.org/docs/dso.html\n',NULL);
INSERT INTO "perl_manual" VALUES (81,'apache faq','Frequently Asked Questions for Apache Web server, http://www.apache.org/docs/misc/FAQ.html\n',NULL);
INSERT INTO "perl_manual" VALUES (82,'apache java','Apache Java support - the Jakarta project, http://jakarta.apache.org/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (83,'apache log format','Apache 1.3 HTTP access log format documentation (mod_log_config), http://www.apache.org/docs/mod/mod_log_config.html\n',NULL);
INSERT INTO "perl_manual" VALUES (84,'apache modules','Apache server modules, http://www.apache.org/docs/mod/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (85,'apache performance','Hints on running Apache as high-performance web server, http://www.apache.org/docs/misc/perf.html\n',NULL);
INSERT INTO "perl_manual" VALUES (86,'apache runtime','Apache\'s run-time configuration directives, http://www.apache.org/docs/\n',NULL);
INSERT INTO "perl_manual" VALUES (87,'apache security','Security tips for Apache server configuration, http://www.apache.org/docs/misc/security_tips.html\n',NULL);
INSERT INTO "perl_manual" VALUES (88,'apache server','Most popular webserver for UNIX (also available for Win32 platform), http://www.apache.org\n',NULL);
INSERT INTO "perl_manual" VALUES (89,'apache ssi','Q: How do I enable SSI execution on my Apache server?, http://www.apache.org/docs/misc/FAQ.html#ssi-part-i\n',NULL);
INSERT INTO "perl_manual" VALUES (90,'apache tricks','Cool Tricks With Perl and Apache, http://stein.cshl.org/WWW/docs/handout.html\n',NULL);
INSERT INTO "perl_manual" VALUES (91,'apache tuning','Some Apache webserver performance tuning tips, http://www.apache.org/docs/misc/perf-tuning.html\n',NULL);
INSERT INTO "perl_manual" VALUES (92,'apache tutorials','a collection of tutorials, written by third-parties, to help configure and run Apache. http://www.apache.org/docs/misc/tutorials.html\n',NULL);
INSERT INTO "perl_manual" VALUES (93,'apache::dbi','Initiate a persistent database connection with perl and Apache server, http://search.cpan.org/doc/MERGL/ApacheDBI-0.88/DBI.pm\n',NULL);
INSERT INTO "perl_manual" VALUES (94,'apache::ssi','Perl module to implement Server Side Includes in Perl, http://theoryx5.uwinnipeg.ca/CPAN/data/Apache-SSI/SSI.html\n',NULL);
INSERT INTO "perl_manual" VALUES (95,'aquitaine','a #cgi channel regular from India whose rye comments often risk getting himself kicked\n',NULL);
INSERT INTO "perl_manual" VALUES (96,'archive::zip','a perl library to provide an interface to ZIP archive files,  http://theoryx5.uwinnipeg.ca/CPAN/data/Archive-Zip/Archive/Zip.html\n',NULL);
INSERT INTO "perl_manual" VALUES (97,'ascii set','The ASCII Character Set table, http://www.cis.udel.edu/~totten/ascii/\n',NULL);
INSERT INTO "perl_manual" VALUES (98,'ask','\'...Don\'t ask to ask.. just ask!..\'\n',NULL);
INSERT INTO "perl_manual" VALUES (99,'atan2','Arctangent of Y/X, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/atan2.html\n',NULL);
INSERT INTO "perl_manual" VALUES (100,'attrs','Set/get attributes of a subroutine, http://www.perl.com/CPAN-local/doc/manual/html/lib/attrs.html\n',NULL);
INSERT INTO "perl_manual" VALUES (101,'audio','Audio related perl modules, http://theory.uwinnipeg.ca/CPAN/by-category/23_Miscellaneous_Modules.html\n',NULL);
INSERT INTO "perl_manual" VALUES (102,'autoloader','Load subroutines only on demand, http://www.perl.com/CPAN-local/doc/manual/html/lib/AutoLoader.html\n',NULL);
INSERT INTO "perl_manual" VALUES (103,'autosplit','Split a package for autoloading, http://www.perl.com/CPAN-local/doc/manual/html/lib/AutoSplit.html\n',NULL);
INSERT INTO "perl_manual" VALUES (104,'autouse','Postpone load of modules until a function is used, http://www.perl.com/CPAN-local/doc/manual/html/lib/autouse.html\n',NULL);
INSERT INTO "perl_manual" VALUES (105,'b','The module used for <A, http://www.perl.com/CPAN-local/doc/manual/html/lib/B.html\n',NULL);
INSERT INTO "perl_manual" VALUES (106,'b::asmdata','Autogenerated data about Perl ops, used to generate bytecode, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Asmdata.html\n',NULL);
INSERT INTO "perl_manual" VALUES (107,'b::assembler','Assemble Perl bytecode, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Assembler.html\n',NULL);
INSERT INTO "perl_manual" VALUES (108,'b::bblock','Walk basic blocks, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Bblock.html\n',NULL);
INSERT INTO "perl_manual" VALUES (109,'b::bytecode','Perl compiler\'s bytecode backend, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Bytecode.html\n',NULL);
INSERT INTO "perl_manual" VALUES (110,'b::c','Perl compiler\'s  C backend, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/C.html\n',NULL);
INSERT INTO "perl_manual" VALUES (111,'b::cc','Perl compiler\'s optimized  C translation backend, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/CC.html\n',NULL);
INSERT INTO "perl_manual" VALUES (112,'b::debug','Walk Perl syntax tree, printing debug info about ops, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Debug.html\n',NULL);
INSERT INTO "perl_manual" VALUES (113,'b::deparse','Perl compiler backend to produce perl code, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Deparse.html\n',NULL);
INSERT INTO "perl_manual" VALUES (114,'b::disassembler','Disassemble Perl bytecode, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Disassembler.html\n',NULL);
INSERT INTO "perl_manual" VALUES (115,'b::lint','Perl lint, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Lint.html\n',NULL);
INSERT INTO "perl_manual" VALUES (116,'b::showlex','Show lexical variables used in functions or files, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Showlex.html\n',NULL);
INSERT INTO "perl_manual" VALUES (117,'b::stackobj','Helper module for  CC backend, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Stackobj.html\n',NULL);
INSERT INTO "perl_manual" VALUES (118,'b::terse','Walk Perl syntax tree, printing terse info about ops, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Terse.html\n',NULL);
INSERT INTO "perl_manual" VALUES (119,'b::xref','Generates cross reference reports for Perl programs, http://www.perl.com/CPAN-local/doc/manual/html/lib/B/Xref.html\n',NULL);
INSERT INTO "perl_manual" VALUES (120,'babelfish','WWW::Babelfish - Perl extension for translation via babelfish, http://theory.uwinnipeg.ca/CPAN/data/WWW-Babelfish/Babelfish.html\n',NULL);
INSERT INTO "perl_manual" VALUES (121,'backtracking','Explanation on bactracking, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/back.html\n',NULL);
INSERT INTO "perl_manual" VALUES (122,'bad code','How To Write Unmaintainable Code and can be found at http://mindprod.com/unmain.html\n',NULL);
INSERT INTO "perl_manual" VALUES (123,'bad habits','Sex, drugs, rock\'n\'roll and American dream... geez, who writes this stuff\n',NULL);
INSERT INTO "perl_manual" VALUES (124,'base','Establish , http://www.perl.com/CPAN-local/doc/manual/html/lib/base.html\n',NULL);
INSERT INTO "perl_manual" VALUES (125,'bash','Bourne Again Shell (Overview Documentation for Bash), http://wwwinfo.cern.ch/dis/texi2html/gnu/bash-1.14.6/features_toc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (126,'benchmark','Benchmark running times of code, http://www.perl.com/CPAN-local/doc/manual/html/lib/Benchmark.html\n',NULL);
INSERT INTO "perl_manual" VALUES (127,'best perl book','\'Object Oriented Perl\' by Damian Conway',NULL);
INSERT INTO "perl_manual" VALUES (128,'biglug th','is a test\n',NULL);
INSERT INTO "perl_manual" VALUES (129,'bind','Binds an address to a socket, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/bind.html\n',NULL);
INSERT INTO "perl_manual" VALUES (130,'binmode','Prepare binary files on old systems, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/binmode.html\n',NULL);
INSERT INTO "perl_manual" VALUES (131,'bitchx','IRC (Internet Relay Chat) client, http://www.bitchx.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (132,'blackbox','simplistic, laconic yet functional window manager for the Open Group\'s X Window System, with professionally finished interface design and very low memory consumption, http://blackbox.alug.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (133,'bless','Create an object, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/bless.html\n',NULL);
INSERT INTO "perl_manual" VALUES (134,'blib','Use MakeMaker\'s uninstalled version of a package, http://www.perl.com/CPAN-local/doc/manual/html/lib/blib.html\n',NULL);
INSERT INTO "perl_manual" VALUES (135,'bofh','Bastard Operator From Hel\n',NULL);
INSERT INTO "perl_manual" VALUES (136,'books','O\'Reilly and Associates publishing, http://perl.ora.com - there is also a reasonable book on cgi available online at http://www.itknowledge.com/reference/archive/1575211963/ewtoc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (137,'browsers','Web Browsers OpenFAQ, http://www.boutell.com/openfaq/browsers/\n',NULL);
INSERT INTO "perl_manual" VALUES (138,'business','Business related perl modules, http://theory.uwinnipeg.ca/CPAN/by-category/23_Miscellaneous_Modules.html\n',NULL);
INSERT INTO "perl_manual" VALUES (139,'caller','Get context of the current subroutine call, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/caller.html\n',NULL);
INSERT INTO "perl_manual" VALUES (140,'camel','either of two large ruminant mammals (genus Camelus) used as draft and saddle animals in desert regions especially of Africa and Asia: the one-humped camel (Camelus dromedarius) extant only as a domestic or feral animal - called also dromedary',NULL);
INSERT INTO "perl_manual" VALUES (141,'carp','Warn of errors (from perspective of caller), http://www.perl.com/CPAN-local/doc/manual/html/lib/Carp.html\n',NULL);
INSERT INTO "perl_manual" VALUES (142,'cgi','Common Gateway Interface standard for external gateway programs to interface with information servers such as HTTP servers, http://hoohoo.ncsa.uiuc.edu/cgi/overview.html',NULL);
INSERT INTO "perl_manual" VALUES (143,'cgi c/c++','Some CGI programming resources in C/C++, http://cgi.resourceindex.com/Documentation/Programming_in_C_and_C++/\n',NULL);
INSERT INTO "perl_manual" VALUES (144,'cgi faq','CGI Programming OpenFAQ, http://www.boutell.com/openfaq/cgi/\n',NULL);
INSERT INTO "perl_manual" VALUES (145,'cgi on','qick tip on How to enable CGI execution under Apache server: Add the following line to httpd.conf - AddHandler cgi-scrip *.cgi - (http://httpd.apache.org/docs/mod/mod_mime.html#addhandler), restart server.\n',NULL);
INSERT INTO "perl_manual" VALUES (146,'cgi security','CGI Security FAQ which is at http://www.w3.org/Security/Faq/www-security-faq.html and http://www.insecure.org/news/P55-07.txt\n',NULL);
INSERT INTO "perl_manual" VALUES (147,'cgi subdomain','How to setup subdomain redirection with CGI, http://library.thinkquest.org/26297/perl/subdomainsCGI.shtml\n',NULL);
INSERT INTO "perl_manual" VALUES (148,'cgi-lib.pl','is outdated perl library consists of common CGI-related routines. The new standard CGI library (part of the perl\'s core since version 5) is CGI.pm... Nonetheless, you can still find cgi-lib and its documentation at http://cgi-lib.berkeley.edu/.\n',NULL);
INSERT INTO "perl_manual" VALUES (149,'cgi.pm','perl Object-Oriented interface to the most common CGI routines (form generation and parsing, cookies, file upload, etc.), http://stein.cshl.org/WWW/software/CGI/cgi_docs.html',NULL);
INSERT INTO "perl_manual" VALUES (150,'cgi.pm cookies','Using CGI.pm cookie processing features..., http://stein.cshl.org/WWW/software/CGI/cgi_docs.html#cookies\n',NULL);
INSERT INTO "perl_manual" VALUES (151,'cgi::apache','Make things work with CGI.pm against Perl-Apache  API, http://www.perl.com/CPAN-local/doc/manual/html/lib/CGI/Apache.html\n',NULL);
INSERT INTO "perl_manual" VALUES (152,'cgi::carp','CGI routines for writing to the  HTTPD (or other) error log, http://www.perl.com/CPAN-local/doc/manual/html/lib/CGI/Carp.html\n',NULL);
INSERT INTO "perl_manual" VALUES (153,'cgi::cookie','Interface to Netscape Cookies, http://www.perl.com/CPAN-local/doc/manual/html/lib/CGI/Cookie.html\n',NULL);
INSERT INTO "perl_manual" VALUES (154,'cgi::fast','CGI Interface for Fast  CGI, http://www.perl.com/CPAN-local/doc/manual/html/lib/CGI/Fast.html\n',NULL);
INSERT INTO "perl_manual" VALUES (155,'cgi::lite','Perl module to process and decode WWW forms and cookies, http://theoryx5.uwinnipeg.ca/CPAN/data/CGI-Lite/Lite.html\n',NULL);
INSERT INTO "perl_manual" VALUES (156,'cgi::pretty','Module to produce nicely formatted HTML code (part of CGI.pm bundle), http://theoryx5.uwinnipeg.ca/CPAN/data/CGI.pm/CGI/Pretty.html\n',NULL);
INSERT INTO "perl_manual" VALUES (157,'cgi::push','Simple Interface to Server Push, http://www.perl.com/CPAN-local/doc/manual/html/lib/CGI/Push.html\n',NULL);
INSERT INTO "perl_manual" VALUES (158,'cgi::switch','Try more than one constructors and return the first object available, http://www.perl.com/CPAN-local/doc/manual/html/lib/CGI/Switch.html\n',NULL);
INSERT INTO "perl_manual" VALUES (159,'cgicc','A C++ class library for writing CGI applications, http://www.gnu.org/software/cgicc/cgicc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (160,'cgiwrap','CGIWrap is a gateway program that allows general users to use CGI scripts and HTML forms without compromising the security of the http server, http://www.unixtools.org/cgiwrap/\n',NULL);
INSERT INTO "perl_manual" VALUES (161,'chdir','Change your current working directory, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/chdir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (162,'chmod','Changes the permissions on a list of files, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/chmod.html\n',NULL);
INSERT INTO "perl_manual" VALUES (163,'choices','1. You can search the web and try to find something that is close to what you need; 2. You can learn cgi and try to write whatever you need yourself; 3. You can pay someone to write it for you. And, of course, choice is always yours..\n',NULL);
INSERT INTO "perl_manual" VALUES (164,'chomp','Remove a trailing record separator from a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/chomp.html\n',NULL);
INSERT INTO "perl_manual" VALUES (165,'chop','Remove the last character from a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/chop.html\n',NULL);
INSERT INTO "perl_manual" VALUES (166,'chown','Change the owership on a list of files, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/chown.html\n',NULL);
INSERT INTO "perl_manual" VALUES (167,'chr','Get character this number represents, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/chr.html\n',NULL);
INSERT INTO "perl_manual" VALUES (168,'chroot','Make directory new root for path lookups, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/chroot.html\n',NULL);
INSERT INTO "perl_manual" VALUES (169,'class::struct','Declare struct-like datatypes as Perl classes, http://www.perl.com/CPAN-local/doc/manual/html/lib/Class/Struct.html\n',NULL);
INSERT INTO "perl_manual" VALUES (170,'close','Close file (or pipe or socket) handle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/close.html\n',NULL);
INSERT INTO "perl_manual" VALUES (171,'closedir','Close directory handle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/closedir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (172,'cmcd','',NULL);
INSERT INTO "perl_manual" VALUES (173,'codemagic','Useful win32 source code editor, http://www.petes-place.com/codemagic.html\n',NULL);
INSERT INTO "perl_manual" VALUES (174,'coder_','An op in Undernet #cgi and is a developer for CodeMagic (Blue Square Group). He can be reached via email @ thart@ramfans.com or icq (6639976)., http://coder.axess.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (175,'coder_ sex','Slap her leg up on your shoulder... she\'ll definitely like that\n',NULL);
INSERT INTO "perl_manual" VALUES (176,'compress','Archiving and Compression, http://theory.uwinnipeg.ca/CPAN/by-category/17_Archiving_and_Compression.html\n',NULL);
INSERT INTO "perl_manual" VALUES (177,'config','Access Perl configuration information, http://www.perl.com/CPAN-local/doc/manual/html/lib/Config.html\n',NULL);
INSERT INTO "perl_manual" VALUES (178,'config::inifiles','a module for reading .ini-style configuration files. http://dev.rcbowen.com/iniconf/\n',NULL);
INSERT INTO "perl_manual" VALUES (179,'connect','Connect to a remove socket, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/connect.html\n',NULL);
INSERT INTO "perl_manual" VALUES (180,'conseal','Windows 95/98/NT Firewall, http://www.signal9.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (181,'constant','Perl pragma to declare constants, http://www.perl.com/CPAN-local/doc/manual/html/lib/constant.html\n',NULL);
INSERT INTO "perl_manual" VALUES (182,'continue','Optional trailing block in a while or foreach, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/continue.html\n',NULL);
INSERT INTO "perl_manual" VALUES (183,'convert','the standard Unix image conversion program. It converts images from different formats, optionally performing standard image manipulation operations on it. It\'s synopsis is convert [ options ... ] file [ file... ] file - see section 1 of your Unix manual\n',NULL);
INSERT INTO "perl_manual" VALUES (184,'cookie-lib','is a perl library, written in the spirit of cgi-lib.pl to help developers use cookies in web applications and can be found at http://www.egr.uri.edu/~kovacsp/cookie-lib\n',NULL);
INSERT INTO "perl_manual" VALUES (185,'cookies','HTTP Cookies related resources, http://www.cgi101.com/class/ch15/, http://cgi.resourceindex.com/Documentation/HTTP_Cookies/, http://www.freeperlcode.com/guide/Cookies/',NULL);
INSERT INTO "perl_manual" VALUES (186,'corba','The Common Object Request Broker Architecture, http://www.cs.wustl.edu/~schmidt/corba.html\n',NULL);
INSERT INTO "perl_manual" VALUES (187,'corba tutorials','Collection of CORBA (Common Object Request Broker Architecture) tutorials, http://www.cs.wustl.edu/~schmidt/tutorials-corba.html\n',NULL);
INSERT INTO "perl_manual" VALUES (188,'cos','Cosine function, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/cos.html\n',NULL);
INSERT INTO "perl_manual" VALUES (189,'cpan','Comprehensive Perl Archive Network, http://www.cpan.org (search CPAN database at http://theory.uwinnipeg.ca/search/cpan-search.html)\n',NULL);
INSERT INTO "perl_manual" VALUES (190,'cpan module','Query, download and build perl modules from CPAN sites, http://www.perl.com/CPAN-local/doc/manual/html/lib/CPAN.html\n',NULL);
INSERT INTO "perl_manual" VALUES (191,'cpan::firsttime','Utility for CPAN::Config file Initialization, http://www.perl.com/CPAN-local/doc/manual/html/lib/CPAN/FirstTime.html\n',NULL);
INSERT INTO "perl_manual" VALUES (192,'cpan::nox','Wrapper around CPAN.pm without using any  XS module, http://www.perl.com/CPAN-local/doc/manual/html/lib/CPAN/Nox.html\n',NULL);
INSERT INTO "perl_manual" VALUES (193,'crc','Method for checking the accuracy of a digital transmission over a communications link, http://www.rad.com/networks/1994/err_con/crc.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (194,'cron','Program that allows users to create jobs that will run at a given time, http://nerc-online.com/support/www/crontab.html\n',NULL);
INSERT INTO "perl_manual" VALUES (195,'crontab','the cron daemon is a long-running process that executes commands at specific dates and times and can be found at http://kb.indiana.edu/data/afiz.html',NULL);
INSERT INTO "perl_manual" VALUES (196,'crypt','One-way passwd-style encryption, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/crypt.html\n',NULL);
INSERT INTO "perl_manual" VALUES (197,'crypto','Security and Encryption, http://theory.uwinnipeg.ca/CPAN/by-category/14_Security_and_Encryption.html\n',NULL);
INSERT INTO "perl_manual" VALUES (198,'css','Cascading Style Sheets, http://www.wdvl.com/Authoring/Style/Sheets/\n',NULL);
INSERT INTO "perl_manual" VALUES (199,'css reference','Cascading Style Sheets reference table, http://www.builder.com/Authoring/CSS/table.html\n',NULL);
INSERT INTO "perl_manual" VALUES (200,'cvsi','Compilation vs. Interpretation, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/comp-vs-interp.html\n',NULL);
INSERT INTO "perl_manual" VALUES (201,'cwd','Get pathname of current working directory, http://www.perl.com/CPAN-local/doc/manual/html/lib/Cwd.html\n',NULL);
INSERT INTO "perl_manual" VALUES (202,'data::dumper','Stringified perl data structures, suitable for both printing and eval, http://www.perl.com/CPAN-local/doc/manual/html/lib/Data/Dumper.html\n',NULL);
INSERT INTO "perl_manual" VALUES (203,'database design','Fundamentals of Database Design, http://www.citilink.com/~jgarrick/vbasic/database/fundamentals.html\n',NULL);
INSERT INTO "perl_manual" VALUES (204,'datatype','Data Type Utilities, http://theory.uwinnipeg.ca/CPAN/by-category/06_Data_Type_Utilities.html\n',NULL);
INSERT INTO "perl_manual" VALUES (205,'date::calc','Gregorian calendar date calculations, http://theoryx5.uwinnipeg.ca/CPAN/data/Date-Calc/Calc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (206,'date::manip','Date manipulation routines, http://theoryx5.uwinnipeg.ca/CPAN/data/DateManip/Manip.html\n',NULL);
INSERT INTO "perl_manual" VALUES (207,'db','Database Interfaces, http://theory.uwinnipeg.ca/CPAN/by-category/07_Database_Interfaces.html\n',NULL);
INSERT INTO "perl_manual" VALUES (208,'db_file','Perl5 access to Berkeley  DB version 1.x, http://www.perl.com/CPAN-local/doc/manual/html/lib/DB_File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (209,'dbd::odbc','ODBC driver for DBI, http://theoryx5.uwinnipeg.ca/CPAN/data/DBD-ODBC/ODBC.html\n',NULL);
INSERT INTO "perl_manual" VALUES (210,'dbi','Various SQL databases access perl modules and drivers, http://www.symbolstone.org/technology/perl/DBI/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (211,'dbi info','DBI tutorial, http://www.opensourceit.com/url/990426perl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (212,'dbi tutorial','CodeData\'s Perl/DBI tutorial: http://codedata.box.sk/perl/tut1/13.txt\n',NULL);
INSERT INTO "perl_manual" VALUES (213,'dbm','DB_File - Perl5 access to Berkeley DB version 1.x, ftp://ftp.ou.edu/mirrors/CPAN/doc/manual/html/lib/DB_File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (214,'dbmclose','Breaks binding on a tied dbm file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/dbmclose.html\n',NULL);
INSERT INTO "perl_manual" VALUES (215,'dbmopen','Create binding on a tied dbm file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/dbmopen.html\n',NULL);
INSERT INTO "perl_manual" VALUES (216,'defined','Test whether a value, variable, or function is defined, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/defined.html\n',NULL);
INSERT INTO "perl_manual" VALUES (217,'delete','Deletes a value from a hash, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/delete.html\n',NULL);
INSERT INTO "perl_manual" VALUES (218,'devel','Development Support, http://theory.uwinnipeg.ca/CPAN/by-category/03_Development_Support.html\n',NULL);
INSERT INTO "perl_manual" VALUES (219,'devel::selfstubber','Generate stubs for a SelfLoading module, http://www.perl.com/CPAN-local/doc/manual/html/lib/Devel/SelfStubber.html\n',NULL);
INSERT INTO "perl_manual" VALUES (220,'diagnostics','Perl compiler pragma to force verbose warning diagnostics, http://www.perl.com/CPAN-local/doc/manual/html/lib/diagnostics.html\n',NULL);
INSERT INTO "perl_manual" VALUES (221,'die','Raise an exception or bail out, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/die.html\n',NULL);
INSERT INTO "perl_manual" VALUES (222,'dirhandle','Supply object methods for directory handles, http://www.perl.com/CPAN-local/doc/manual/html/lib/DirHandle.html\n',NULL);
INSERT INTO "perl_manual" VALUES (223,'do','Turn a BLOCK into a TERM, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/do.html\n',NULL);
INSERT INTO "perl_manual" VALUES (224,'dprof','a Perl code profiler, http://search.cpan.org/search?dist=DProf\n',NULL);
INSERT INTO "perl_manual" VALUES (225,'dsl','Digital Subscriber Line and its variations, , info: http://whatis.com/dsl.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (226,'dump','Create an immediate core dump, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/dump.html\n',NULL);
INSERT INTO "perl_manual" VALUES (227,'dynaloader','Dynamically load  C libraries into Perl code, http://www.perl.com/CPAN-local/doc/manual/html/lib/DynaLoader.html\n',NULL);
INSERT INTO "perl_manual" VALUES (228,'each','Retrieve the next key/value pair from a hash, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/each.html\n',NULL);
INSERT INTO "perl_manual" VALUES (229,'easy','\'..This is not about to make it easy - this is about to make it right!..\'\n',NULL);
INSERT INTO "perl_manual" VALUES (230,'editpad','a replacement for the standard windows Notepad (much much better) and can be found at http://www.editpadpro.com/editpadclassic.html\n',NULL);
INSERT INTO "perl_manual" VALUES (231,'efnet #perl','A channel full of the \'3 great virtues of a programmer\' 1) Laziness 2) Impatience 3) Hubris.. AND MORE!!  part there today!\n',NULL);
INSERT INTO "perl_manual" VALUES (232,'email check','How do I check a valid mail address?, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq9.html#How_do_I_check_a_valid_mail_addr\n',NULL);
INSERT INTO "perl_manual" VALUES (233,'embedperl','Embed Perl in Your HTML documents, http://perl.apache.org/embperl/\n',NULL);
INSERT INTO "perl_manual" VALUES (234,'encrypt','a simple utility to generate strings using UNIX style one-way encryption mechanism, http://www.dgits.com/cgi-local/etc/encrypt.cgi or  http://www.beatnik.uklinux.net/webcrypt.html\n',NULL);
INSERT INTO "perl_manual" VALUES (235,'endgrent','Be done using group file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/endgrent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (236,'endhostent','Be done using hosts file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/endhostent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (237,'endnetent','Be done using networks file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/endnetent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (238,'endprotoent','Be done using protocols file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/endprotoent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (239,'endpwent','Be done using passwd file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/endpwent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (240,'endservent','Be done using services file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/endservent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (241,'english','Use nice English (or awk) names for ugly punctuation variables, http://www.perl.com/CPAN-local/doc/manual/html/lib/English.html\n',NULL);
INSERT INTO "perl_manual" VALUES (242,'env','Perl module that imports environment variables, http://www.perl.com/CPAN-local/doc/manual/html/lib/Env.html\n',NULL);
INSERT INTO "perl_manual" VALUES (243,'env vars','Environmental variable accessible for cgi. (To see what is available on your server get http://www.dgits.com/scripts/misc/env.txt -> upload in cgi-bin as env.cgi -> chmod 755 -> access with browser), http://www.dgits.com/cgi-local/etc/env.cgi\n',NULL);
INSERT INTO "perl_manual" VALUES (244,'env.cgi','Environment variables are a series of hidden values that the web server sends to every CGI you run',NULL);
INSERT INTO "perl_manual" VALUES (245,'eof','Test a filehandle for its end, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/eof.html\n',NULL);
INSERT INTO "perl_manual" VALUES (246,'errno','System errno constants, http://www.perl.com/CPAN-local/doc/manual/html/lib/Errno.html\n',NULL);
INSERT INTO "perl_manual" VALUES (247,'error check','the way to output errors into the browser window - just add the following line right after #!/usr/bin/perl (or whatever path to perl you have): use CGI::Carp qw/fatalsToBrowser/; (requires perl 5+, see CGI::Carp for more info), http://www.perl.com/CPAN-lo',NULL);
INSERT INTO "perl_manual" VALUES (248,'error out','a good debugging technique in CGI environment. To output errors occuring in perl-written programs add the following right after first line, which specifies path to perl executable: use CGI::Carp qw/fatalsToBrowser/; (see CGI::Carp for more information).\n',NULL);
INSERT INTO "perl_manual" VALUES (249,'errordocument','Apache run-time configuration directive, http://httpd.apache.org/docs/mod/core.html#errordocument\n',NULL);
INSERT INTO "perl_manual" VALUES (250,'eval','Catch exceptions or compile code, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/eval.html\n',NULL);
INSERT INTO "perl_manual" VALUES (251,'exec','Abandon this program to run another, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/exec.html\n',NULL);
INSERT INTO "perl_manual" VALUES (252,'exists','Test whether a hash key is present, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/exists.html\n',NULL);
INSERT INTO "perl_manual" VALUES (253,'exit','Terminate this program, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/exit.html\n',NULL);
INSERT INTO "perl_manual" VALUES (254,'exp','Raise e to a power, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/exp.html\n',NULL);
INSERT INTO "perl_manual" VALUES (255,'expect','Expect, http://theory.uwinnipeg.ca/CPAN/by-category/21_File_Handle_Input_Output.html\n',NULL);
INSERT INTO "perl_manual" VALUES (256,'exporter','Implements DEFAULT import method for modules, http://www.perl.com/CPAN-local/doc/manual/html/lib/Exporter.html\n',NULL);
INSERT INTO "perl_manual" VALUES (257,'extutils::command','Utilities to replace common  UNIX commands in Makefiles etc., http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Command.html\n',NULL);
INSERT INTO "perl_manual" VALUES (258,'extutils::embed','Utilities for embedding Perl in  C/C++ applications, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Embed.html\n',NULL);
INSERT INTO "perl_manual" VALUES (259,'extutils::install','Install files from here to there, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Install.html\n',NULL);
INSERT INTO "perl_manual" VALUES (260,'extutils::installed','Inventory management of installed modules, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Installed.html\n',NULL);
INSERT INTO "perl_manual" VALUES (261,'extutils::liblist','Determine libraries to use and how to use them, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Liblist.html\n',NULL);
INSERT INTO "perl_manual" VALUES (262,'extutils::makemaker','Create an extension Makefile, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/MakeMaker.html\n',NULL);
INSERT INTO "perl_manual" VALUES (263,'extutils::manifest','Utilities to write and check a  MANIFEST file, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Manifest.html\n',NULL);
INSERT INTO "perl_manual" VALUES (264,'extutils::miniperl, writemain','Write the  C code for perlmain.c, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Miniperl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (265,'extutils::mkbootstrap','Make a bootstrap file for use by DynaLoader, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Mkbootstrap.html\n',NULL);
INSERT INTO "perl_manual" VALUES (266,'extutils::mksymlists','Write linker options files for dynamic extension, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Mksymlists.html\n',NULL);
INSERT INTO "perl_manual" VALUES (267,'extutils::mm_os2','Methods to override  UN*X behaviour in ExtUtils::MakeMaker, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/MM_OS2.html\n',NULL);
INSERT INTO "perl_manual" VALUES (268,'extutils::mm_unix','Methods used by ExtUtils::MakeMaker, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/MM_Unix.html\n',NULL);
INSERT INTO "perl_manual" VALUES (269,'extutils::mm_vms','Methods to override  UN*X behaviour in ExtUtils::MakeMaker, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/MM_VMS.html\n',NULL);
INSERT INTO "perl_manual" VALUES (270,'extutils::mm_win32','Methods to override  UN*X behaviour in ExtUtils::MakeMaker, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/MM_Win32.html\n',NULL);
INSERT INTO "perl_manual" VALUES (271,'extutils::packlist','Manage .packlist files, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/Packlist.html\n',NULL);
INSERT INTO "perl_manual" VALUES (272,'extutils::testlib','Add blib/* directories to @INC, http://www.perl.com/CPAN-local/doc/manual/html/lib/ExtUtils/testlib.html\n',NULL);
INSERT INTO "perl_manual" VALUES (273,'faq','the #cgi faq. It is currently being worked on and will be finished in due course. At the moment, it can be found at http://cgi.testserver.ch\n',NULL);
INSERT INTO "perl_manual" VALUES (274,'fastcgi','Language independent, scalable, open extension to CGI that provides high performance without the limitations of server specific APIs, http://fastcgi.idle.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (275,'fatal','Replace functions with equivalents which succeed or die, http://www.perl.com/CPAN-local/doc/manual/html/lib/Fatal.html\n',NULL);
INSERT INTO "perl_manual" VALUES (276,'favicon','the code to put a little 16X16 icon before your url on microsoft 5+ and can be found at http://www.favicon.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (277,'fcntl','Load the  C Fcntl.h defines, http://www.perl.com/CPAN-local/doc/manual/html/lib/Fcntl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (278,'fields','Compile-time class fields, http://www.perl.com/CPAN-local/doc/manual/html/lib/fields.html\n',NULL);
INSERT INTO "perl_manual" VALUES (279,'file upload','Using CGI.pm file upload feature..., http://stein.cshl.org/WWW/software/CGI/cgi_docs.html#upload_caveats\n',NULL);
INSERT INTO "perl_manual" VALUES (280,'file-counterfile','File::CounterFile, a module for all you guys that need/want to make counters, http://www.perl.com/CPAN-local/modules/by-module/File/\n',NULL);
INSERT INTO "perl_manual" VALUES (281,'file::basename','Split a pathname into pieces, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Basename.html\n',NULL);
INSERT INTO "perl_manual" VALUES (282,'file::checktree','Run many filetest checks on a tree, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/CheckTree.html\n',NULL);
INSERT INTO "perl_manual" VALUES (283,'file::compare','Compare files or filehandles, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Compare.html\n',NULL);
INSERT INTO "perl_manual" VALUES (284,'file::copy','Copy files or filehandles, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Copy.html\n',NULL);
INSERT INTO "perl_manual" VALUES (285,'file::dosglob','DOS like globbing and then some, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/DosGlob.html\n',NULL);
INSERT INTO "perl_manual" VALUES (286,'file::find','Traverse a file tree, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Find.html\n',NULL);
INSERT INTO "perl_manual" VALUES (287,'file::path','Create or remove a series of directories, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Path.html\n',NULL);
INSERT INTO "perl_manual" VALUES (288,'file::spec','Portably perform operations on file names, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Spec.html\n',NULL);
INSERT INTO "perl_manual" VALUES (289,'file::spec::mac','File::Spec for MacOS, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Spec/Mac.html\n',NULL);
INSERT INTO "perl_manual" VALUES (290,'file::spec::os2','Methods for  OS/2 file specs, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Spec/OS2.html\n',NULL);
INSERT INTO "perl_manual" VALUES (291,'file::spec::unix','Methods used by File::Spec, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Spec/Unix.html\n',NULL);
INSERT INTO "perl_manual" VALUES (292,'file::spec::vms','Methods for  VMS file specs, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Spec/VMS.html\n',NULL);
INSERT INTO "perl_manual" VALUES (293,'file::spec::win32','Methods for Win32 file specs, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/Spec/Win32.html\n',NULL);
INSERT INTO "perl_manual" VALUES (294,'file::stat','By-name interface to Perl\'s built-in  stat() functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/File/stat.html\n',NULL);
INSERT INTO "perl_manual" VALUES (295,'filecache','Keep more files open than the system permits, http://www.perl.com/CPAN-local/doc/manual/html/lib/FileCache.html\n',NULL);
INSERT INTO "perl_manual" VALUES (296,'filehandle','Supply object methods for filehandles, http://www.perl.com/CPAN-local/doc/manual/html/lib/FileHandle.html\n',NULL);
INSERT INTO "perl_manual" VALUES (297,'fileno','Return file descriptor from filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/fileno.html\n',NULL);
INSERT INTO "perl_manual" VALUES (298,'findbin','Locate directory of original perl script, http://www.perl.com/CPAN-local/doc/manual/html/lib/FindBin.html\n',NULL);
INSERT INTO "perl_manual" VALUES (299,'flock','Lock an entire file with an advisory lock, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/flock.html\n',NULL);
INSERT INTO "perl_manual" VALUES (300,'fly','an outdated GIF manipulation library which is at http://martin.gleeson.com/fly/\n',NULL);
INSERT INTO "perl_manual" VALUES (301,'fmteyewtk','\'Far More Than Everything You\'ve Ever Wanted to Know About...\', by Tom Christiansen - collection of usefull perl stuff, http://www.perl.com/CPAN-local/doc/FMTEYEWTK/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (302,'for','Perl\'s C-style for loop. http://www.perl.com/CPAN-local/doc/manual/html/pod/perlsyn.html#For_Loops\n',NULL);
INSERT INTO "perl_manual" VALUES (303,'foreach','a loop command that iterates over an array and sets a variable to be each element of the list in turn. http://www.perl.com/CPAN-local/doc/manual/html/pod/perlsyn.html#Foreach_Loops\n',NULL);
INSERT INTO "perl_manual" VALUES (304,'fork','Create a new process just like this one, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/fork.html\n',NULL);
INSERT INTO "perl_manual" VALUES (305,'format','Declare a picture format with use by the write() function, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/format.html\n',NULL);
INSERT INTO "perl_manual" VALUES (306,'formatting numbers','easy with Number::Format -- http://search.cpan.org/doc/WRW/Number-Format-1.42/Format.pm\n',NULL);
INSERT INTO "perl_manual" VALUES (307,'formline','Internal function used for formats, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/formline.html\n',NULL);
INSERT INTO "perl_manual" VALUES (308,'formmail','Generic WWW form to e-mail gateway by Matt Wright, http://www.worldwidemart.com/scripts/formmail.shtml\n',NULL);
INSERT INTO "perl_manual" VALUES (309,'free asp','Free ASP hosting, http://www.aspin.com/home/sites/asphosts/freeasph\n',NULL);
INSERT INTO "perl_manual" VALUES (310,'free database','FREE Web database service, http://www.bitlocker.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (311,'free databases','a list of free databases, ftp://ftp.idiom.com/pub/free-databases\n',NULL);
INSERT INTO "perl_manual" VALUES (312,'free dns','Free DNS service, http://www.dyndns.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (313,'free hosts','Free CGI-enabled hosting services: http://www.hypermart.net, http://www.myfreedomain.com, http://www.virtualave.net, http://www.riftwar.com, http://www.internet-club.com, http://www.codename.com, http://free.prohosting.com\n',NULL);
INSERT INTO "perl_manual" VALUES (314,'freebsd','an advanced BSD UNIX operating system for the Intel compatible (x86), DEC Alpha, and PC-98 architectures, http://www.freebsd.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (315,'french perl','the Perldocs translated to french, http://www.perl-gratuit.com/traduction/doc_fr.html\n',NULL);
INSERT INTO "perl_manual" VALUES (316,'gcc','The GNU C Compiler, http://www.gnu.org/software/gcc/gcc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (317,'gd','Perl interface to Gd Graphics Library for XPM, PNG image formats manipulation, http://theory.uwinnipeg.ca/CPAN/data/GD/GD.html\n',NULL);
INSERT INTO "perl_manual" VALUES (318,'gd.pm','Perl interface to Gd Graphics Library for XPM, PNG image formats manipulation, http://theory.uwinnipeg.ca/CPAN/data/GD/GD.html\n',NULL);
INSERT INTO "perl_manual" VALUES (319,'gd::graph','a perl5 module to create charts using the GD module http://www.perldoc.com/cpan/GD/Graph.html\n',NULL);
INSERT INTO "perl_manual" VALUES (320,'gdbm_file','Perl5 access to the gdbm library., http://www.perl.com/CPAN-local/doc/manual/html/lib/GDBM_File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (321,'get vs post','the difference between the main two methods that can be performed on the resource identified by the Request-URI. See section 8 of RFC 1945: http://www.faqs.org/rfcs/rfc1945.html\n',NULL);
INSERT INTO "perl_manual" VALUES (322,'getc','Get the next character from the filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (323,'getgrent','Get next group record, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getgrent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (324,'getgrgid','Get group record given group user ID, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getgrgid.html\n',NULL);
INSERT INTO "perl_manual" VALUES (325,'getgrnam','Get group record given group name, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getgrnam.html\n',NULL);
INSERT INTO "perl_manual" VALUES (326,'gethostbyaddr','Get host record given its address, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/gethostbyaddr.html\n',NULL);
INSERT INTO "perl_manual" VALUES (327,'gethostbyname','Get host record given name, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/gethostbyname.html\n',NULL);
INSERT INTO "perl_manual" VALUES (328,'gethostent','Get next hosts record, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/gethostent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (329,'getlogin','Return who logged in at this tty, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getlogin.html\n',NULL);
INSERT INTO "perl_manual" VALUES (330,'getnetbyaddr','Get network record given its address, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getnetbyaddr.html\n',NULL);
INSERT INTO "perl_manual" VALUES (331,'getnetbyname','Get networks record given name, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getnetbyname.html\n',NULL);
INSERT INTO "perl_manual" VALUES (332,'getnetent','Get next networks record, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getnetent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (333,'getopt::std','Process single-character switches with switch clustering, http://www.perl.com/CPAN-local/doc/manual/html/lib/Getopt/Std.html\n',NULL);
INSERT INTO "perl_manual" VALUES (334,'getoptions','Extended processing of command line options, http://www.perl.com/CPAN-local/doc/manual/html/lib/Getopt/Long.html\n',NULL);
INSERT INTO "perl_manual" VALUES (335,'getpeername','Find the other hend of a socket connection, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getpeername.html\n',NULL);
INSERT INTO "perl_manual" VALUES (336,'getpgrp','Get process group, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getpgrp.html\n',NULL);
INSERT INTO "perl_manual" VALUES (337,'getppid','Get parent process ID, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getppid.html\n',NULL);
INSERT INTO "perl_manual" VALUES (338,'getpriority','Get current nice value, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getpriority.html\n',NULL);
INSERT INTO "perl_manual" VALUES (339,'getprotobyname','Get protocol record given name, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getprotobyname.html\n',NULL);
INSERT INTO "perl_manual" VALUES (340,'getprotobynumber','Get protocol record numeric protocol, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getprotobynumber.html\n',NULL);
INSERT INTO "perl_manual" VALUES (341,'getprotoent','Get next protocols record, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getprotoent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (342,'getpwent','Get next passwd record, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getpwent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (343,'getpwnam','Get passwd record given user login name, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getpwnam.html\n',NULL);
INSERT INTO "perl_manual" VALUES (344,'getpwuid','Get passwd record given user ID, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getpwuid.html\n',NULL);
INSERT INTO "perl_manual" VALUES (345,'getservbyname','Get services record given its name, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getservbyname.html\n',NULL);
INSERT INTO "perl_manual" VALUES (346,'getservbyport','Get services record given numeric port, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getservbyport.html\n',NULL);
INSERT INTO "perl_manual" VALUES (347,'getservent','Get next services record, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getservent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (348,'getsockname','Retrieve the sockaddr for a given socket, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getsockname.html\n',NULL);
INSERT INTO "perl_manual" VALUES (349,'getsockopt','Get socket options on a given socket, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/getsockopt.html\n',NULL);
INSERT INTO "perl_manual" VALUES (350,'gimp','the GNU Image Manipulation Program, suitable for such tasks as photo retouching, image composition and image authoring, http://www.gimp.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (351,'glimmer','an X based code editor with syntax highlighting for a dozen languages, http://glimmer.sourceforge.net\n',NULL);
INSERT INTO "perl_manual" VALUES (352,'glimpse','A tool to search entire file systems, http://glimpse.cs.arizona.edu/\n',NULL);
INSERT INTO "perl_manual" VALUES (353,'glob','Expand filenames using wildcards, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/glob.html\n',NULL);
INSERT INTO "perl_manual" VALUES (354,'gmtime','Convert UNIX time into record or string using Greenwich time, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/gmtime.html\n',NULL);
INSERT INTO "perl_manual" VALUES (355,'gnome','The GNOME project has buit a complete free and easy-to-use desktop environment for the user, as well as powerfull application framework for the sorftware developer, http://www.gnome.org\n',NULL);
INSERT INTO "perl_manual" VALUES (356,'gnuplot','Command-driven interactive function and data plotting program, http://www.geocities.com/SiliconValley/Foothills/6647/,\n',NULL);
INSERT INTO "perl_manual" VALUES (357,'goto','Create spaghetti code, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/goto.html\n',NULL);
INSERT INTO "perl_manual" VALUES (358,'gpl','GNU General Public License, http://www.gnu.org/copyleft/gpl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (359,'grep','Locate elements in a list test true against a given criterion, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/grep.html\n',NULL);
INSERT INTO "perl_manual" VALUES (360,'gui','User Interfaces, http://theory.uwinnipeg.ca/CPAN/by-category/08_User_Interfaces.html\n',NULL);
INSERT INTO "perl_manual" VALUES (361,'gzip','Gzip (GNU zip) is a compression utility designed to be a replacement for compress, http://www.gzip.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (362,'h2xs','Build perl module interface, http://www.perl.com/CPAN-local/doc/manual/html/utils/h2xs.html\n',NULL);
INSERT INTO "perl_manual" VALUES (363,'hang around','what you should do if you want help.\n',NULL);
INSERT INTO "perl_manual" VALUES (364,'harvest','Web Indexing system/search interface, http://www.tardis.ed.ac.uk/~harvest/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (365,'helix gnome','Improved version of Gnome, http://www.helixcode.com/desktop/\n',NULL);
INSERT INTO "perl_manual" VALUES (366,'here-doc','a line-oriented form of quoting based on the shell \'here-doc\' syntax. Following a << you specify a string to terminate quoted material, all lines following the current line to the terminating string are the value of the item.,',NULL);
INSERT INTO "perl_manual" VALUES (367,'hex','Convert a string to a hexadecimal number, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/hex.html\n',NULL);
INSERT INTO "perl_manual" VALUES (368,'history','Public release history for Data::Dumper, http://www.perl.com/CPAN-local/doc/manual/html/lib/Dumper/Changes.html\n',NULL);
INSERT INTO "perl_manual" VALUES (369,'htaccess','Apache\'s directory access restriction file, http://www.psoft.net/htaccess.html',NULL);
INSERT INTO "perl_manual" VALUES (370,'htdig','WWW Search Engine Software, http://www.htdig.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (371,'html','HyperText Markup Language, http://www.w3.org/MarkUp\n',NULL);
INSERT INTO "perl_manual" VALUES (372,'html characters','HTML special characters List, http://www.utoronto.ca/webdocs/HTMLdocs/NewHTML/iso_table.html\n',NULL);
INSERT INTO "perl_manual" VALUES (373,'html reference','an alphabetical list of all HTML 4.0 elements, http://www.htmlhelp.com/reference/html40/alist.html',NULL);
INSERT INTO "perl_manual" VALUES (374,'html::parser','HTML XS based Parser class, http://theoryx5.uwinnipeg.ca/CPAN/data/HTML-Parser/Parser.html\n',NULL);
INSERT INTO "perl_manual" VALUES (375,'http','W3 HTTP protocol specification and related information, http://www.w3.org/Protocols/',NULL);
INSERT INTO "perl_manual" VALUES (376,'http codes','HTTP status response codes, http://www.w3.org/Protocols/HTTP/HTRESP.html\n',NULL);
INSERT INTO "perl_manual" VALUES (377,'http header','a string is to be return to a client by cgi program, which must contain valid MIME (see MIME) type or \'Content-Type\' of the stream that follows (\'text/html\', for example) terminated by FLOAT8newline characters (\012\015 on UNIX)',NULL);
INSERT INTO "perl_manual" VALUES (378,'http::request','Class encapsulating HTTP Requests, http://theoryx5.uwinnipeg.ca/CPAN/data/libwww-perl/HTTP/Request.html\n',NULL);
INSERT INTO "perl_manual" VALUES (379,'hypermart perl','located in two places: Perl 4 is at /usr/bin/perl while Perl 5 is at #!/usr/local/bin/perl\n',NULL);
INSERT INTO "perl_manual" VALUES (380,'i18n::collate','Compare 8-bit scalar data according to the current locale, http://www.perl.com/CPAN-local/doc/manual/html/lib/I18N/Collate.html\n',NULL);
INSERT INTO "perl_manual" VALUES (381,'idiot cgi','The Idiot\'s Guide to Solving Perl CGI Problems, http://www.perl.com/CPAN/doc/FAQs/cgi/idiots-guide.html\n',NULL);
INSERT INTO "perl_manual" VALUES (382,'if','a flow-controlling compound statement. It executes code based on the \'truth\' of an expression. http://www.perl.com/CPAN-local/doc/manual/html/pod/perlsyn.html#Compound_statements\n',NULL);
INSERT INTO "perl_manual" VALUES (383,'image','Images, Pixmaps and Bitmaps, http://theory.uwinnipeg.ca/CPAN/by-category/18_Images_Pixmaps_Bitmaps.html\n',NULL);
INSERT INTO "perl_manual" VALUES (384,'image::info','Extract information from image files and can be found at http://search.cpan.org/doc/GAAS/Image-Info-0.04/lib/Image/Info.pm\n',NULL);
INSERT INTO "perl_manual" VALUES (385,'image::magick','Perl extension for calling ImageMagick\'s libmagick routines, http://www.simplesystems.org/ImageMagick/\n',NULL);
INSERT INTO "perl_manual" VALUES (386,'import','Patch a module\'s namespace into your own, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/import.html\n',NULL);
INSERT INTO "perl_manual" VALUES (387,'in flames','One of the most distinguished heavy metal bands on the ninetees in the field of Progressive Metal, http://www.inflames.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (388,'index','Perl function to search string for substring (left to right). Returns substring position. Unfortunately, there is no manual page for this function on CPAN therefore see rindex() manual page, which is similar to index() but works right to left, http://www.',NULL);
INSERT INTO "perl_manual" VALUES (389,'indigo','ActivePerl with integrated Apache and GUI Package manager, http://www.indigostar.com/indigoperl.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (390,'indigo perl','IndigoPerl is a binary build of Perl 5.6 for Win32 with an integrated Apache webserver for testing and developing CGI scripts, http://www.indigostar.com\n',NULL);
INSERT INTO "perl_manual" VALUES (391,'informix','Commercial RDBMS server software, http://www.informix.com/informix/products/ids/\n',NULL);
INSERT INTO "perl_manual" VALUES (392,'ingres','a Relational Database Management System (RDBMS) that can be found at http://www.ca.com/products/ingres.htm - compare with MySQL, PostGreSQL, Oracle and mSQL\n',NULL);
INSERT INTO "perl_manual" VALUES (393,'iniconf','now replaced by Config::IniFiles\n',NULL);
INSERT INTO "perl_manual" VALUES (394,'inline','a module to write Perl subroutines in other programming languages.\n',NULL);
INSERT INTO "perl_manual" VALUES (395,'int','Get the integer portion of a number, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/int.html\n',NULL);
INSERT INTO "perl_manual" VALUES (396,'integer','Perl pragma to compute arithmetic in integer instead of FLOAT8 http://www.perl.com/CPAN-local/doc/manual/html/lib/integer.html\n',NULL);
INSERT INTO "perl_manual" VALUES (397,'interface','...An Interface is a contract in the form of a collection of method and constant declarations.\n',NULL);
INSERT INTO "perl_manual" VALUES (398,'io','Load various  IO modules, http://www.perl.com/CPAN-local/doc/manual/html/lib/IO.html\n',NULL);
INSERT INTO "perl_manual" VALUES (399,'io::file','Supply object methods for filehandles, http://www.perl.com/CPAN-local/doc/manual/html/lib/IO/File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (400,'io::handle','Supply object methods for  I/O handles, http://www.perl.com/CPAN-local/doc/manual/html/lib/IO/Handle.html\n',NULL);
INSERT INTO "perl_manual" VALUES (401,'io::pipe','Supply object methods for pipes, http://www.perl.com/CPAN-local/doc/manual/html/lib/IO/Pipe.html\n',NULL);
INSERT INTO "perl_manual" VALUES (402,'io::seekable','Supply seek based methods for  I/O objects, http://www.perl.com/CPAN-local/doc/manual/html/lib/IO/Seekable.html\n',NULL);
INSERT INTO "perl_manual" VALUES (403,'io::select','OO interface to the select system call, http://www.perl.com/CPAN-local/doc/manual/html/lib/IO/Select.html\n',NULL);
INSERT INTO "perl_manual" VALUES (404,'io::socket','Object interface to socket communications, http://www.perl.com/CPAN-local/doc/manual/html/lib/IO/Socket.html\n',NULL);
INSERT INTO "perl_manual" VALUES (405,'ioctl','System-dependent device control system call, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/ioctl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (406,'ipc::msg','SysV Msg  IPC object class, http://www.perl.com/CPAN-local/doc/manual/html/lib/IPC/Msg.html\n',NULL);
INSERT INTO "perl_manual" VALUES (407,'ipc::open2, open2','Open a process for both reading and writing, http://www.perl.com/CPAN-local/doc/manual/html/lib/IPC/Open2.html\n',NULL);
INSERT INTO "perl_manual" VALUES (408,'ipc::open3, open3','Open a process for reading, writing, and error handling, http://www.perl.com/CPAN-local/doc/manual/html/lib/IPC/Open3.html\n',NULL);
INSERT INTO "perl_manual" VALUES (409,'ipc::semaphore','SysV Semaphore  IPC object class, http://www.perl.com/CPAN-local/doc/manual/html/lib/IPC/Semaphore.html\n',NULL);
INSERT INTO "perl_manual" VALUES (410,'ipc::sysv','SysV  IPC constants, http://www.perl.com/CPAN-local/doc/manual/html/lib/IPC/SysV.html\n',NULL);
INSERT INTO "perl_manual" VALUES (411,'ipchains','Enhanced IP firewalling chains software for Linux, http://www.rustcorp.com/linux/ipchains/\n',NULL);
INSERT INTO "perl_manual" VALUES (412,'ipchains docs','How to install and configure the enhanced IP firewalling chains software for Linux, http://www.rustcorp.com/linux/ipchains/HOWTO.html\n',NULL);
INSERT INTO "perl_manual" VALUES (413,'ipfwadm','Ipfwadm is a utility to administer the IP accounting and firewall services offered by the Linux kernel, http://www.xos.nl/linux/ipfwadm/\n',NULL);
INSERT INTO "perl_manual" VALUES (414,'isps','Internet service providers resources, http://webisplist.internetlist.com/,\n',NULL);
INSERT INTO "perl_manual" VALUES (415,'java','simple, object-oriented, distributed, interpreted, robust, secure, architecture-neutral, portable, high-performance, multithreaded, dynamic programming language by Sun, excellent tutorial on which can be found at: http://java.sun.com/docs/books/tutorial/\n',NULL);
INSERT INTO "perl_manual" VALUES (416,'javascript','Netscape\'s cross-platform, object-oriented scripting language, http://developer.netscape.com/docs/manuals/js/client/jsguide/intro.htm#09369, http://rummelplatz.uni-mannheim.de/~skoch/js/tutorial.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (417,'join','Join a list into a string using a separator, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/join.html\n',NULL);
INSERT INTO "perl_manual" VALUES (418,'js','JavaScript - client and server side embedded language, http://rummelplatz.uni-mannheim.de/~skoch/js/tutorial.htm,\n',NULL);
INSERT INTO "perl_manual" VALUES (419,'kde','A powerful graphical desktop environment for Unix, http://www.kde.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (420,'keys','Retrieve list of indices from a hash, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/keys.html\n',NULL);
INSERT INTO "perl_manual" VALUES (421,'keywords','keywords to ask me, http://home.dgits.com/html/keys.html\n',NULL);
INSERT INTO "perl_manual" VALUES (422,'kill','Send a signal to a process or process group, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/kill.html\n',NULL);
INSERT INTO "perl_manual" VALUES (423,'lamer','someone who asks the bot ignorant questions repeatedly',NULL);
INSERT INTO "perl_manual" VALUES (424,'last','Exit a block prematurely, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/last.html\n',NULL);
INSERT INTO "perl_manual" VALUES (425,'lazy','Only Ops are allowed to be lazy in *THIS* channel\n',NULL);
INSERT INTO "perl_manual" VALUES (426,'lc','Return lower-case version of a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/lc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (427,'lcc-win32','A free compiler system for Windows, http://www.cs.virginia.edu/~lcc-win32/\n',NULL);
INSERT INTO "perl_manual" VALUES (428,'lcfirst','Return a string with just the next letter in lower case, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/lcfirst.html\n',NULL);
INSERT INTO "perl_manual" VALUES (429,'ldap','Lightweight Directory Access Protocol, http://www.ldapcentral.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (430,'length','Return the number of bytes in a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/length.html\n',NULL);
INSERT INTO "perl_manual" VALUES (431,'less','Perl pragma to request less of something from the compiler, http://www.perl.com/CPAN-local/doc/manual/html/lib/less.html\n',NULL);
INSERT INTO "perl_manual" VALUES (432,'lib','Standard Perl Pragmata, http://www.perl.com/CPAN-local/doc/manual/html/lib/\n',NULL);
INSERT INTO "perl_manual" VALUES (433,'libnet','CPAN Bundle for libnet and its dependencies, http://theory.uwinnipeg.ca/CPAN/data/Bundle-libnet/README.html\n',NULL);
INSERT INTO "perl_manual" VALUES (434,'libwww','WWW Protocol Library for Perl, http://www.ics.uci.edu/pub/websoft/libwww-perl/\n',NULL);
INSERT INTO "perl_manual" VALUES (435,'lilo','The most used Linux Loader for the x86 flavour of Linux, http://www.linux.org/help/ldp/mini/LILO.html\n',NULL);
INSERT INTO "perl_manual" VALUES (436,'lingua::ispell','A module encapsulating access to the Ispell program, http://theoryx5.uwinnipeg.ca/CPAN/data/Lingua-Ispell/Lingua/Ispell.html\n',NULL);
INSERT INTO "perl_manual" VALUES (437,'link','Create a hard link in the filesytem, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/link.html\n',NULL);
INSERT INTO "perl_manual" VALUES (438,'linux','Free UNIX-like Operating System',NULL);
INSERT INTO "perl_manual" VALUES (439,'linux chicks','chicks that dig linux, one such example is http://pirater.homeip.net:50000/copine.jpg\n',NULL);
INSERT INTO "perl_manual" VALUES (440,'linux dsl','How to setup a Linux System to work with Asymmetric Digital Subscriber Loop (ADSL), http://metalab.unc.edu/LDP/HOWTO/mini/ADSL.html\n',NULL);
INSERT INTO "perl_manual" VALUES (441,'linux rdbms','Relational Database Management System (Linux), , how-to: http://metalab.unc.edu/LDP/HOWTO/PostgreSQL-HOWTO.html\n',NULL);
INSERT INTO "perl_manual" VALUES (442,'linuxapps','Linux software archives, http://www.linuxapps.com/,\n',NULL);
INSERT INTO "perl_manual" VALUES (443,'listen','Register your socket as a server, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/listen.html\n',NULL);
INSERT INTO "perl_manual" VALUES (444,'lj','Linux Journal - The Premier Linux Magazine, http://www.linuxjournal.com.\n',NULL);
INSERT INTO "perl_manual" VALUES (445,'local','Create a temporary value for a global variable (dynamic scoping), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/local.html\n',NULL);
INSERT INTO "perl_manual" VALUES (446,'local modules','How to install perl modules into user home directory: perl Makefile.PL PREFIX=~ INSTALLSITELIB=~/lib/site_perl INSTALLSITEARCH=~/lib/perl5/5.005/i386-linux INSTALLMAN1DIR=~/man/man1 INSTALLMAN3DIR=~/man/man3. Appropriate directories must be created prior',NULL);
INSERT INTO "perl_manual" VALUES (447,'local script','...To run CGI scripts on Windows you need download, install and configure ActivePerl - perl port to win32 (http://www.activestate.com) and Apache webserver (http://www.apache.org, recommended) or server of your choice from ServerWatch (http://serverwatch.',NULL);
INSERT INTO "perl_manual" VALUES (448,'locale','Perl pragma to use and avoid , http://www.perl.com/CPAN-local/doc/manual/html/lib/locale.html\n',NULL);
INSERT INTO "perl_manual" VALUES (449,'localtime','Convert UNIX time into record or string using local time, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/localtime.html\n',NULL);
INSERT INTO "perl_manual" VALUES (450,'log','Retrieve the natural logarithm for a number, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/log.html\n',NULL);
INSERT INTO "perl_manual" VALUES (451,'lstat','Stat a symbolic link, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/lstat.html\n',NULL);
INSERT INTO "perl_manual" VALUES (452,'lwp','Collection of Perl modules which provides a simple and consistent API to the World-Wide Web, http://theory.uwinnipeg.ca/CPAN/data/libwww-perl/LWP.html\n',NULL);
INSERT INTO "perl_manual" VALUES (453,'lwp cookbook','LWP perl Cookbook - some examples that show typical usage of the libwww-perl library, http://theory.uwinnipeg.ca/CPAN/data/libwww-perl/lwpcook.html\n',NULL);
INSERT INTO "perl_manual" VALUES (454,'lynx','a text browser for the world wide web for Unix/Linux, Win32, and VMS platforms, http://lynx.browser.org\n',NULL);
INSERT INTO "perl_manual" VALUES (455,'lzh','the iron-fisted ruler of #perl - he is pretty cluey, but is also extremely arrogant, impolite and anti-social. Many flee from his wrath to the much friendlier people in #cgi\n',NULL);
INSERT INTO "perl_manual" VALUES (456,'m//','Match a string with a regular expression pattern, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/m.html\n',NULL);
INSERT INTO "perl_manual" VALUES (457,'mac linux','a Linux replacements for your MacOS: BeOS (http://www.be.com), Yellow Dog Linux (http://www.yellowdoglinux.com) and LinuxPPC (http://www.linuxppc.com)\n',NULL);
INSERT INTO "perl_manual" VALUES (458,'mail','Mail and Usenet News, http://theory.uwinnipeg.ca/CPAN/by-category/19_Mail_and_Usenet_News.html\n',NULL);
INSERT INTO "perl_manual" VALUES (459,'majordomo','Mail list management software, http://www.greatcircle.com/majordomo/\n',NULL);
INSERT INTO "perl_manual" VALUES (460,'majordomo faq','Mail list management software FAQ, http://www.greatcircle.com/majordomo/FAQ.html\n',NULL);
INSERT INTO "perl_manual" VALUES (461,'map','Apply a change to a list to get back a new list with the changes, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/map.html\n',NULL);
INSERT INTO "perl_manual" VALUES (462,'math','Math Modules, http://theory.uwinnipeg.ca/CPAN/by-category/06_Data_Type_Utilities.html\n',NULL);
INSERT INTO "perl_manual" VALUES (463,'math::bigfloat','Arbitrary length float math package, http://www.perl.com/CPAN-local/doc/manual/html/lib/Math/BigFloat.html\n',NULL);
INSERT INTO "perl_manual" VALUES (464,'math::bigint','Arbitrary size integer math package, http://www.perl.com/CPAN-local/doc/manual/html/lib/Math/BigInt.html\n',NULL);
INSERT INTO "perl_manual" VALUES (465,'math::complex','Complex numbers and associated mathematical functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/Math/Complex.html\n',NULL);
INSERT INTO "perl_manual" VALUES (466,'math::trig','Trigonometric functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/Math/Trig.html\n',NULL);
INSERT INTO "perl_manual" VALUES (467,'meta tags','A Dictionary of HTML META Tags, http://vancouver-webpages.com/META/\n',NULL);
INSERT INTO "perl_manual" VALUES (468,'mime','Multipurpose Internet Mail Extensions, http://www.oac.uci.edu/indiv/ehood/MIME/MIME.html\n',NULL);
INSERT INTO "perl_manual" VALUES (469,'mime::base64','Encoding and decoding of base64 strings, http://theory.uwinnipeg.ca/CPAN/data/MIME-Base64/Base64.html\n',NULL);
INSERT INTO "perl_manual" VALUES (470,'mime::entity','Class for parsed-and-decoded MIME message, http://theory.uwinnipeg.ca/CPAN/data/MIME-tools/MIME/Entity.html\n',NULL);
INSERT INTO "perl_manual" VALUES (471,'mime::lite','Low-calorie MIME generator, http://theory.uwinnipeg.ca/CPAN/data/MIME-Lite/MIME/Lite.html\n',NULL);
INSERT INTO "perl_manual" VALUES (472,'mime::parser','experimental class for parsing MIME streams, http://theoryx5.uwinnipeg.ca/CPAN/data/MIME-tools/MIME/Parser.html',NULL);
INSERT INTO "perl_manual" VALUES (473,'mime::tools','Modules for parsing (and creating!) MIME entities, http://theoryx5.uwinnipeg.ca/scripts/CPAN/authors/id/ERYQ/MIME-tools-4.124.tar.gz\n',NULL);
INSERT INTO "perl_manual" VALUES (474,'mime::toolutils','MIME-tools kit configuration and utilities, http://theory.uwinnipeg.ca/CPAN/data/MIME-tools/MIME/ToolUtils.html\n',NULL);
INSERT INTO "perl_manual" VALUES (475,'minivend','The most powerful free shopping cart system, http://www.minivend.com/iri/mvend.html\n',NULL);
INSERT INTO "perl_manual" VALUES (476,'mkdir','Create a directory, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/mkdir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (477,'mldbm','Perl Module to store multi-level hash structure in single level tied hash, http://theoryx5.uwinnipeg.ca/CPAN/data/MLDBM/MLDBM.html\n',NULL);
INSERT INTO "perl_manual" VALUES (478,'mod_perl','The Apache/Perl integration module, http://perl.apache.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (479,'mod_perl guide','Mod_perl Guide - Deploying mod_perl technology to give a rocket speed to your CGI/perl scripts, http://perl.apache.org/guide/\n',NULL);
INSERT INTO "perl_manual" VALUES (480,'mod_rewrite','URL Rewriting Engine (Apache server module), http://www.apache.org/docs/mod/mod_rewrite.html\n',NULL);
INSERT INTO "perl_manual" VALUES (481,'mod_so','Apache Dynamic Shared Object (DSO) Support module, http://www.apache.org/docs/mod/mod_so.html\n',NULL);
INSERT INTO "perl_manual" VALUES (482,'module','a external perl library - set of methods (subroutines) written with Object-Oriented approach and therefore encapsulated in its own namespace, which can be loaded into main code with use() or require() and import(). See: perlobj, perlref, perlmod, perlmodl',NULL);
INSERT INTO "perl_manual" VALUES (483,'module list','CPAN\'s modules distributions list, http://www.perl.com/CPAN/modules/01modules.index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (484,'mortum','(aka klimt aka degas) the much-liked ruler of #cgi, and the writer of hex.\n',NULL);
INSERT INTO "perl_manual" VALUES (485,'mortum (aka klimt aka degas)','the much-liked ruler of #cgi, and the writer of hex.\n',NULL);
INSERT INTO "perl_manual" VALUES (486,'motto','#CGI\'s motto: The error is in the code. (also see TMTOWTDI)\n',NULL);
INSERT INTO "perl_manual" VALUES (487,'mp3::info','Manipulate MP3 audio files info, http://theoryx5.uwinnipeg.ca/CPAN/data/MPEG-MP3Info/MP3Info.html\n',NULL);
INSERT INTO "perl_manual" VALUES (488,'mre','Mastering Regular Expression (an ORA book) available at http://www.ora.com.  A good regex book.  This book is also now available online, http://public.yahoo.com/~jfriedl/regex/\n',NULL);
INSERT INTO "perl_manual" VALUES (489,'msa','Matt\'s Script Archive, a collection of generic CGI scripts, http://worldwidemart.com/scripts\n',NULL);
INSERT INTO "perl_manual" VALUES (490,'msgctl','SysV IPC message control operations, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/msgctl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (491,'msgget','Get SysV IPC message queue, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/msgget.html\n',NULL);
INSERT INTO "perl_manual" VALUES (492,'msgrcv','Receive a SysV IPC message from a message queue, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/msgrcv.html\n',NULL);
INSERT INTO "perl_manual" VALUES (493,'msgsnd','Send a SysV IPC message to a message queue, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/msgsnd.html\n',NULL);
INSERT INTO "perl_manual" VALUES (494,'msql','Mini SQL (mSQL) -> a light weight relational database management system, http://www.hughes.com.au/\n',NULL);
INSERT INTO "perl_manual" VALUES (495,'msqlperl','The Msql Perl Adaptor, http://msql.mbh.org/Contrib/mSQLPerl/\n',NULL);
INSERT INTO "perl_manual" VALUES (496,'my','Declare and assign a local variable (lexical scoping), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/my.html\n',NULL);
INSERT INTO "perl_manual" VALUES (497,'mysql','Multi-threaded, lightweight SQL database server with its own authentication scheme, http://www.mysql.com',NULL);
INSERT INTO "perl_manual" VALUES (498,'mysql docs','MySQL assorted documentation, http://www.devshed.com/Server_Side/MySQL/\n',NULL);
INSERT INTO "perl_manual" VALUES (499,'mysql faq','MySQL Frequently Asked Questions, http://www.bitbybit.dk/mysqlfaq/faq.html\n',NULL);
INSERT INTO "perl_manual" VALUES (500,'mysql perl','MySQL interaction perl modules, http://www.mysql.com/downloads/api-dbi.html\n',NULL);
INSERT INTO "perl_manual" VALUES (501,'ncsa faq','NCSA HTTPd\'s Frequently Asked Questions, http://hoohoo.ncsa.uiuc.edu/docs/FAQ.html\n',NULL);
INSERT INTO "perl_manual" VALUES (502,'ncsa install','NCSA httpd server installation and configuration instructions, http://hoohoo.ncsa.uiuc.edu/docs/setup/Install.html\n',NULL);
INSERT INTO "perl_manual" VALUES (503,'ndbm_file','Tied access to ndbm files, http://www.perl.com/CPAN-local/doc/manual/html/lib/NDBM_File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (504,'net::ftp','A class implementing a simple FTP client in Perl as described in RFC959. It provides wrappers for a subset of the RFC959 commands, http://theory.uwinnipeg.ca/CPAN/data/libnet/Net/FTP.html\n',NULL);
INSERT INTO "perl_manual" VALUES (505,'net::hostent','By-name interface to Perl\'s built-in gethost*() functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/Net/hostent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (506,'net::irc','Perl interface to the Internet Relay Chat protocol, http://theory.uwinnipeg.ca/CPAN/data/Net-IRC/IRC.html\n',NULL);
INSERT INTO "perl_manual" VALUES (507,'net::netent','By-name interface to Perl\'s built-in getnet*() functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/Net/netent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (508,'net::ping','Check a remote host for reachability, http://www.perl.com/CPAN-local/doc/manual/html/lib/Net/Ping.html\n',NULL);
INSERT INTO "perl_manual" VALUES (509,'net::pop3','Post Office Protocol 3 Client class (RFC1081), http://theoryx5.uwinnipeg.ca/CPAN/data/libnet/Net/POP3.html\n',NULL);
INSERT INTO "perl_manual" VALUES (510,'net::protoent','By-name interface to Perl\'s built-in getproto*() functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/Net/protoent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (511,'net::servent','By-name interface to Perl\'s built-in getserv*() functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/Net/servent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (512,'net::smtp','Perl interface to Simple Mail Transfer Protocol (SMTP), http://theoryx5.uwinnipeg.ca/CPAN/data/libnet/Net/SMTP.html\n',NULL);
INSERT INTO "perl_manual" VALUES (513,'net::ssleay','Perl extension for using OpenSSL, http://theoryx5.uwinnipeg.ca/CPAN/data/Net_SSLeay.pm/SSLeay.html\n',NULL);
INSERT INTO "perl_manual" VALUES (514,'net::telnet','Interact with TELNET port or other TCP ports, http://theory.uwinnipeg.ca/CPAN/data/Net-Telnet/Net/Telnet.html\n',NULL);
INSERT INTO "perl_manual" VALUES (515,'net::whois','Get and parse *whois* domain data from InterNIC, http://theoryx5.uwinnipeg.ca/CPAN/data/Net-Whois/Whois.html\n',NULL);
INSERT INTO "perl_manual" VALUES (516,'netcraft','a free statistical site providing service to find out various information about specified website (platform, server software, etc.), http://www.netcraft.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (517,'network shell','NSH - Bourne Again Shell based shell with ablility to manage distributed computer system, http://www.networkshell.com\n',NULL);
INSERT INTO "perl_manual" VALUES (518,'newspro','a script for automating the proccess of posting news on a site, http://amphibian.gagames.com/newspro\n',NULL);
INSERT INTO "perl_manual" VALUES (519,'next','Iterate a block prematurely, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/next.html\n',NULL);
INSERT INTO "perl_manual" VALUES (520,'no','Unimport some module symbols or semantics at compile time, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/no.html\n',NULL);
INSERT INTO "perl_manual" VALUES (521,'nt cgi','NT CGI Scripts and Server Functionality, http://www.shore.net/services/support/ntscripts/\n',NULL);
INSERT INTO "perl_manual" VALUES (522,'nt sendmail','NT replacement for sendmail - the UNIX mailer, http://www.ntsendmail.com\n',NULL);
INSERT INTO "perl_manual" VALUES (523,'o','Generic interface to Perl Compiler backends, http://www.perl.com/CPAN-local/doc/manual/html/lib/O.html\n',NULL);
INSERT INTO "perl_manual" VALUES (524,'oct','Convert a string to an octal number, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/oct.html\n',NULL);
INSERT INTO "perl_manual" VALUES (525,'odbm_file','Tied access to odbm files, http://www.perl.com/CPAN-local/doc/manual/html/lib/ODBM_File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (526,'one liner','a small chunk of perl code, which can be executed in shell as: perl -wle \'...code here...\' (see perlrun page for more command line options), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlrun.html',NULL);
INSERT INTO "perl_manual" VALUES (527,'oop','Object-Oriented programming (concepts), http://www.objectcentral.com/oobook/webcont.htm',NULL);
INSERT INTO "perl_manual" VALUES (528,'opcode','Disable named opcodes when compiling perl code, http://www.perl.com/CPAN-local/doc/manual/html/lib/Opcode.html\n',NULL);
INSERT INTO "perl_manual" VALUES (529,'open','Open a file, pipe, or descriptor, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/open.html\n',NULL);
INSERT INTO "perl_manual" VALUES (530,'openbook','The O\'Reilly open book project, which can be found at http://www.oreilly.com/openbook\n',NULL);
INSERT INTO "perl_manual" VALUES (531,'opendir','Open a directory, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/opendir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (532,'ops','Perl pragma to restrict unsafe operations when compiling, http://www.perl.com/CPAN-local/doc/manual/html/lib/ops.html\n',NULL);
INSERT INTO "perl_manual" VALUES (533,'ora','O\'Reilly and Associates, http://www.oreilly.com also see http://perl.ora.com\n',NULL);
INSERT INTO "perl_manual" VALUES (534,'oracle','Oracle 8i - complete, integrated platform for building and deploying mission-critical applications for the internet, http://www.oracle.com/database/oracle8i/\n',NULL);
INSERT INTO "perl_manual" VALUES (535,'ord','Find a character\'s numeric representation, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/ord.html\n',NULL);
INSERT INTO "perl_manual" VALUES (536,'os','Operating System Interfaces, http://theory.uwinnipeg.ca/CPAN/by-category/04_Operating_System_Interfaces.html\n',NULL);
INSERT INTO "perl_manual" VALUES (537,'overload','Package for overloading perl operations, http://www.perl.com/CPAN-local/doc/manual/html/lib/overload.html\n',NULL);
INSERT INTO "perl_manual" VALUES (538,'pack','Convert a list into a binary representation, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/pack.html\n',NULL);
INSERT INTO "perl_manual" VALUES (539,'package','Declare a separate global namespace, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/package.html\n',NULL);
INSERT INTO "perl_manual" VALUES (540,'patterns','Design Patterns, Pattern Languages, and Frameworks, http://www.cs.wustl.edu/~schmidt/patterns.html\n',NULL);
INSERT INTO "perl_manual" VALUES (541,'paypal','an easy-to-use credit card payment system available in the United States and a number of other countries. Paypal can be found at http://www.paypal.com\n',NULL);
INSERT INTO "perl_manual" VALUES (542,'penguin','any of various erect short-legged flightless aquatic birds (family Spheniscidae) of the southern hemisphere.\n',NULL);
INSERT INTO "perl_manual" VALUES (543,'perl','Practical Extraction and Report Language, http://www.perl.com/CPAN-local/doc/manual/html/pod/perl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (544,'perl cd bookshelf','the ultimate Perl resource. Containing CD editions of Perl in a Nutshell, Programming Perl, Perl Cookbook, Advanced Perl Programming, Learning Perl, and Learning Perl on Win32 Systems. http://www.amazon.com/exec/obidos/ASIN/1565924622\n',NULL);
INSERT INTO "perl_manual" VALUES (545,'perl functions','Perl built-in functions manual pages, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/use.html\n',NULL);
INSERT INTO "perl_manual" VALUES (546,'perl gnome','Programming GNOME Applications with Perl,  which is at http://www.perl.com/pub/2000/10/gnome.html and http://www.perl.com/pub/2000/11/gnome2.html\n',NULL);
INSERT INTO "perl_manual" VALUES (547,'perl iaq','a few Infrequently Asked Questions (jokes) and can be found at http://www.plover.com/~mjd/perl/IAQ/IAQlist.html\n',NULL);
INSERT INTO "perl_manual" VALUES (548,'perl kde','Programming KDE Applications with Perl, which is at http://www.accessone.com/~jql/\n',NULL);
INSERT INTO "perl_manual" VALUES (549,'perl motto','There Is More Than One Way To Do It\n',NULL);
INSERT INTO "perl_manual" VALUES (550,'perl on pws','step-by-step instructional manual on how to configure perl to work with Microsoft Personal Webserver, http://dynamicnet.net/support/fp/perlwithPWS.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (551,'perl oop','documented in perlbot (Bag\'o Object Tricks) http://www.perl.com/CPAN-local/doc/manual/html/pod/perlbot.html\n',NULL);
INSERT INTO "perl_manual" VALUES (552,'perl reference','Rex Swain\'s HTMLified Perl 5 Reference Guide, http://burks.bton.ac.uk/burks/language/perl/perlref.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (553,'perl utilities','Perl utilities, http://www.perl.com/CPAN-local/doc/manual/html/utils/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (554,'perl vs','Perl versus... Some comparative language discussions by T. Christiansen, http://www.perl.com/pub/language/versus/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (555,'perl\'s switch','Perl imulation of C\'s \'case\' statement, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq7.html#How_do_I_create_a_switch_or_case\n',NULL);
INSERT INTO "perl_manual" VALUES (556,'perl2exe','Command line utility for converting perl scripts to exe files, http://www.demobuilder.com/perl2exe.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (557,'perl4to5','Perl4 to Perl5 traps, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/perl425.html\n',NULL);
INSERT INTO "perl_manual" VALUES (558,'perlapio','Perl\'s IO abstraction interface, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlapio.html\n',NULL);
INSERT INTO "perl_manual" VALUES (559,'perlbook','Perl book information, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlbook.html\n',NULL);
INSERT INTO "perl_manual" VALUES (560,'perlbot','Bag\'o Object Tricks (the BOT), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlbot.html\n',NULL);
INSERT INTO "perl_manual" VALUES (561,'perlbuilder','Complete, integrated development environment (IDE) for Perl, http://www.solutionsoft.com/perl.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (562,'perlcall','Perl calling conventions from C, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlcall.html\n',NULL);
INSERT INTO "perl_manual" VALUES (563,'perlcc','Frontend for perl compiler, http://www.perl.com/CPAN/doc/manual/html/utils/perlcc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (564,'perldata','Perl data types, http://www.perl.com/CPAN-local/doc/manual/html/pod/perldata.html\n',NULL);
INSERT INTO "perl_manual" VALUES (565,'perldebug','Perl debugging, http://www.perl.com/CPAN-local/doc/manual/html/pod/perldebug.html\n',NULL);
INSERT INTO "perl_manual" VALUES (566,'perldelta','What\'s new for perl5.005, http://www.perl.com/CPAN-local/doc/manual/html/pod/perldelta.html\n',NULL);
INSERT INTO "perl_manual" VALUES (567,'perldiag','Various Perl diagnostics, http://www.perl.com/CPAN-local/doc/manual/html/pod/perldiag.html\n',NULL);
INSERT INTO "perl_manual" VALUES (568,'perldsc','Perl Data Structures Cookbook, http://www.perl.com/CPAN-local/doc/manual/html/pod/perldsc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (569,'perlembed','How to embed perl in your C program, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlembed.html\n',NULL);
INSERT INTO "perl_manual" VALUES (570,'perlfaq','Frequently asked questions about Perl, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq.html\n',NULL);
INSERT INTO "perl_manual" VALUES (571,'perlfaq1','General Questions About Perl, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq1.html\n',NULL);
INSERT INTO "perl_manual" VALUES (572,'perlfaq2','Obtaining and Learning about Perl, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq2.html\n',NULL);
INSERT INTO "perl_manual" VALUES (573,'perlfaq3','Programming Tools, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq3.html\n',NULL);
INSERT INTO "perl_manual" VALUES (574,'perlfaq4','Data Manipulation, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq4.html\n',NULL);
INSERT INTO "perl_manual" VALUES (575,'perlfaq5','Files and Formats, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq5.html\n',NULL);
INSERT INTO "perl_manual" VALUES (576,'perlfaq6','Regexps, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq6.html\n',NULL);
INSERT INTO "perl_manual" VALUES (577,'perlfaq7','Perl Language Issues, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq7.html\n',NULL);
INSERT INTO "perl_manual" VALUES (578,'perlfaq8','System Interaction, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq8.html\n',NULL);
INSERT INTO "perl_manual" VALUES (579,'perlfaq9','Networking, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq9.html\n',NULL);
INSERT INTO "perl_manual" VALUES (580,'perlform','Perl formats, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlform.html\n',NULL);
INSERT INTO "perl_manual" VALUES (581,'perlfunc','Perl builtin functions, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (582,'perlguts','Perl\'s Internal Functions, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlguts.html\n',NULL);
INSERT INTO "perl_manual" VALUES (583,'perlhist','The Perl history records, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlhist.html\n',NULL);
INSERT INTO "perl_manual" VALUES (584,'perlipc','Perl interprocess communication, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlipc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (585,'perllocale','Perl locale handling (internationalization and localization), http://www.perl.com/CPAN-local/doc/manual/html/pod/perllocale.html\n',NULL);
INSERT INTO "perl_manual" VALUES (586,'perllol','Manipulating Lists of Lists in Perl, http://www.perl.com/CPAN-local/doc/manual/html/pod/perllol.html\n',NULL);
INSERT INTO "perl_manual" VALUES (587,'perlmagic','Win32 port of true core perl, http://www.petes-place.com/cmperl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (588,'perlmod','Perl modules (packages and symbol tables), http://www.perl.com/CPAN-local/doc/manual/html/pod/perlmod.html\n',NULL);
INSERT INTO "perl_manual" VALUES (589,'perlmodinstall','Installing CPAN Modules, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlmodinstall.html\n',NULL);
INSERT INTO "perl_manual" VALUES (590,'perlmodlib','Constructing new Perl modules and finding existing ones, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlmodlib.html\n',NULL);
INSERT INTO "perl_manual" VALUES (591,'perlobj','Perl objects, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlobj.html\n',NULL);
INSERT INTO "perl_manual" VALUES (592,'perlop','Perl operators and precedence, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlop.html\n',NULL);
INSERT INTO "perl_manual" VALUES (593,'perlpod','Plain old documentation, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlpod.html\n',NULL);
INSERT INTO "perl_manual" VALUES (594,'perlport','Writing portable Perl, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlport.html\n',NULL);
INSERT INTO "perl_manual" VALUES (595,'perlqt','Perl interface to TrollTech\'s Qt C++ graphic user interface libraries, for perl-based GUI development, http://www.accessone.com/~jql/perlqt.html\n',NULL);
INSERT INTO "perl_manual" VALUES (596,'perlre','Perl regular expressions, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlre.html\n',NULL);
INSERT INTO "perl_manual" VALUES (597,'perlref','Perl references and nested data structures, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlref.html\n',NULL);
INSERT INTO "perl_manual" VALUES (598,'perlrun','How to execute the Perl interpreter, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlrun.html\n',NULL);
INSERT INTO "perl_manual" VALUES (599,'perlsec','Perl security, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlsec.html\n',NULL);
INSERT INTO "perl_manual" VALUES (600,'perlstyle','Perl style guide, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlstyle.html\n',NULL);
INSERT INTO "perl_manual" VALUES (601,'perlsub','Perl subroutines, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlsub.html\n',NULL);
INSERT INTO "perl_manual" VALUES (602,'perlsyn','Perl syntax, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlsyn.html\n',NULL);
INSERT INTO "perl_manual" VALUES (603,'perltie','How to hide an object class in a simple variable, http://www.perl.com/CPAN-local/doc/manual/html/pod/perltie.html\n',NULL);
INSERT INTO "perl_manual" VALUES (604,'perltk','Perl interface to the UNIX Tk widget toolkit, http://w4.lns.cornell.edu/~pvhp/ptk/doc/,\n',NULL);
INSERT INTO "perl_manual" VALUES (605,'perltoc','Perl documentation table of contents, http://www.perl.com/CPAN-local/doc/manual/html/pod/perltoc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (606,'perltoot','Tom\'s object-oriented tutorial for perl, http://www.perl.com/CPAN-local/doc/manual/html/pod/perltoot.html\n',NULL);
INSERT INTO "perl_manual" VALUES (607,'perltrap','Perl traps for the unwary, http://www.perl.com/CPAN-local/doc/manual/html/pod/perltrap.html\n',NULL);
INSERT INTO "perl_manual" VALUES (608,'perlvar','Perl predefined variables, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlvar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (609,'perlxml','a basic overview on how to handle XML with Perl, http://perlxml.com\n',NULL);
INSERT INTO "perl_manual" VALUES (610,'perlxs','XS language reference manual, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlxs.html\n',NULL);
INSERT INTO "perl_manual" VALUES (611,'perlxstut','Tutorial for XSUBs, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlxstut.html\n',NULL);
INSERT INTO "perl_manual" VALUES (612,'perms','File & Directory permissions, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/file-dir-perms\n',NULL);
INSERT INTO "perl_manual" VALUES (613,'pesh','Premature end of script headers, http://www.apache.org/docs/misc/FAQ.html#premature-script-headers\n',NULL);
INSERT INTO "perl_manual" VALUES (614,'php','Free server-side HTML embedded scripting language, http://www.php.net/,\n',NULL);
INSERT INTO "perl_manual" VALUES (615,'php code','PHP3 Code exchange, http://px.sklar.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (616,'php docs','PHP3 Documentation, http://www.php.net/docs.php3\n',NULL);
INSERT INTO "perl_manual" VALUES (617,'php3','Free server-side HTML embedded scripting language, http://www.php.net/,\n',NULL);
INSERT INTO "perl_manual" VALUES (618,'pipe','Open a pair of connected filehandles, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/pipe.html\n',NULL);
INSERT INTO "perl_manual" VALUES (619,'pod2html','utility to convert perl .pod (Plain Old Documentation) files to .html, ftp://ftp.ou.edu/mirrors/CPAN/doc/manual/html/utils/pod2html.html\n',NULL);
INSERT INTO "perl_manual" VALUES (620,'pod::html','Module to convert pod files to  HTML, http://www.perl.com/CPAN-local/doc/manual/html/lib/Pod/Html.html\n',NULL);
INSERT INTO "perl_manual" VALUES (621,'pod::text','Convert  POD data to formatted  ASCII text, http://www.perl.com/CPAN-local/doc/manual/html/lib/Pod/Text.html\n',NULL);
INSERT INTO "perl_manual" VALUES (622,'poe','the Perl Object Environment, an event driven system for Perl - can be found at http://poe.perl.org\n',NULL);
INSERT INTO "perl_manual" VALUES (623,'poe means the perl object environment, a mechan','m for event handling in Perl. Can be found at http://poe.perl.org\n',NULL);
INSERT INTO "perl_manual" VALUES (624,'pop','Remove the last element from an array and return it, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/pop.html\n',NULL);
INSERT INTO "perl_manual" VALUES (625,'pos','Find or set the offset for the last/next m//g search, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/pos.html\n',NULL);
INSERT INTO "perl_manual" VALUES (626,'posix','Perl interface to  IEEE Std 1003.1, http://www.perl.com/CPAN-local/doc/manual/html/lib/POSIX.html\n',NULL);
INSERT INTO "perl_manual" VALUES (627,'post not allowed','Apache misconfiguration event, http://www.apache.org/docs/misc/FAQ.html#POSTnotallowed\n',NULL);
INSERT INTO "perl_manual" VALUES (628,'postgresql','Most advanced open-source Object-Relational Database Management system, http://www.postgresql.org',NULL);
INSERT INTO "perl_manual" VALUES (629,'ppm','a group of functions intended to simplify the tasks of locating, installing, upgrading and removing software',NULL);
INSERT INTO "perl_manual" VALUES (630,'premature end','Premature end of script headers means that the server was expecting a complete set of HTTP headers (one or more followed by a blank line), and didn\'t get them, http://apache.org/docs/misc/FAQ.html#premature-script-headers\n',NULL);
INSERT INTO "perl_manual" VALUES (631,'print','Output a list to a filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/print.html\n',NULL);
INSERT INTO "perl_manual" VALUES (632,'printf','Output a formatted list to a filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/printf.html\n',NULL);
INSERT INTO "perl_manual" VALUES (633,'prototype','Get the prototype (if any) of a subroutine, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/prototype.html\n',NULL);
INSERT INTO "perl_manual" VALUES (634,'ptkdb','a Perl/TK debugger with fancy features, which can be found at http://search.cpan.org/search?dist=Devel-ptkdb\n',NULL);
INSERT INTO "perl_manual" VALUES (635,'push','Append one or more elements to an array, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/push.html\n',NULL);
INSERT INTO "perl_manual" VALUES (636,'putty','a win32 ssh/telnet client, http://www.chiark.greenend.org.uk/~sgtatham/putty\n',NULL);
INSERT INTO "perl_manual" VALUES (637,'pws','Microsoft Personal Web Server, http://www.microsoft.com/windows/ie/pws/DEFAULT.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (638,'python','Perl vs Python, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/versus/python\n',NULL);
INSERT INTO "perl_manual" VALUES (639,'q//','Singly quote a string -> q/STRING/, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/qSTRING.html\n',NULL);
INSERT INTO "perl_manual" VALUES (640,'qq//','Doubly quote a string -> qq/STRING/, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/qqSTRING.html\n',NULL);
INSERT INTO "perl_manual" VALUES (641,'quotemeta','Quote regular expression magic characters, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/quotemeta.html\n',NULL);
INSERT INTO "perl_manual" VALUES (642,'quotes','Larry Wall et al. Quotes, http://use.perl.org/quotes.txt\n',NULL);
INSERT INTO "perl_manual" VALUES (643,'qw//','Quote a list of words -> qw/STRING/, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/qwSTRING.html\n',NULL);
INSERT INTO "perl_manual" VALUES (644,'qx//','Backquote quote a string -> qx/STRING/, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/qxSTRING.html\n',NULL);
INSERT INTO "perl_manual" VALUES (645,'rand','Retrieve the next pseudorandom number, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/rand.html\n',NULL);
INSERT INTO "perl_manual" VALUES (646,'random','Random numbers generator, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/random\n',NULL);
INSERT INTO "perl_manual" VALUES (647,'re','Perl pragma to alter regular expression behaviour, http://www.perl.com/CPAN-local/doc/manual/html/lib/re.html\n',NULL);
INSERT INTO "perl_manual" VALUES (648,'read','Fixed-length buffered input from a filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/read.html\n',NULL);
INSERT INTO "perl_manual" VALUES (649,'readdir','Get a directory from a directory handle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/readdir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (650,'readline','read a line or lines from a specific filehandle, http://theoryx5.uwinnipeg.ca/CPAN/perl/pod/perlfunc/readline.html\n',NULL);
INSERT INTO "perl_manual" VALUES (651,'readlink','Determine where a symbolic link is pointing, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/readlink.html\n',NULL);
INSERT INTO "perl_manual" VALUES (652,'recv','Receive a message over a Socket, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/recv.html\n',NULL);
INSERT INTO "perl_manual" VALUES (653,'red flag','Program Repair Shop and Red Flags, which can be found at http://www.perl.com/pub/2000/11/repair3.html and http://www.perl.com/pub/2000/11/repair3x.html\n',NULL);
INSERT INTO "perl_manual" VALUES (654,'redirect','How to redirect to another page, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq9.html#How_do_I_redirect_to_another_pag\n',NULL);
INSERT INTO "perl_manual" VALUES (655,'redo','Start this loop iteration over again, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/redo.html\n',NULL);
INSERT INTO "perl_manual" VALUES (656,'ref','Find out the type of thing being referenced, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/ref.html\n',NULL);
INSERT INTO "perl_manual" VALUES (657,'refresh','How to refresh HTML page with META tag, http://dgits.com/scripts/misc/redirect.txt\n',NULL);
INSERT INTO "perl_manual" VALUES (658,'regex','What makes Perl\'s regular expressions dynamite, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/regexps\n',NULL);
INSERT INTO "perl_manual" VALUES (659,'regexp','Perl regular expressions, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlre.html\n',NULL);
INSERT INTO "perl_manual" VALUES (660,'regexp options','basic explanation for four most usable regular expression options: [g] apply global on multiple occurancies/[e] treat pattern being matched as legitimate perl executable code/[s] treat incoming data as a single line (\n be surpressed)/[o] optimize mathing',NULL);
INSERT INTO "perl_manual" VALUES (661,'remote x','Remote X Apps mini-HOWTO, http://www.xs4all.nl/~zweije/xauth.html\n',NULL);
INSERT INTO "perl_manual" VALUES (662,'remove html','PerlFAQ9 -> How to remove HTML tags from a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq9.html#How_do_I_remove_HTML_from_a_stri\n',NULL);
INSERT INTO "perl_manual" VALUES (663,'rename','Change a filename, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/rename.html\n',NULL);
INSERT INTO "perl_manual" VALUES (664,'require','Load in external functions from a library at runtime, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/require.html\n',NULL);
INSERT INTO "perl_manual" VALUES (665,'reset','Clear all variables of a given name, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/reset.html\n',NULL);
INSERT INTO "perl_manual" VALUES (666,'return','Get out of a function early, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/return.html\n',NULL);
INSERT INTO "perl_manual" VALUES (667,'reverse','Flip a string or a list, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/reverse.html\n',NULL);
INSERT INTO "perl_manual" VALUES (668,'rewinddir','Reset directory handle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/rewinddir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (669,'rfc','The Requests for Comments, http://www.rfc-editor.org/, http://www.faqs.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (670,'rijndael','the Crypt-Rijndael encryption module (AES), http://search.cpan.org/search?dist=Crypt-Rijndael\n',NULL);
INSERT INTO "perl_manual" VALUES (671,'rindex','Right-to-left substring search, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/rindex.html\n',NULL);
INSERT INTO "perl_manual" VALUES (672,'rmdir','Remove a directory, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/rmdir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (673,'round','PerlFAQ 4: Does perl have a round function?, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq4.html#Does_perl_have_a_round_function_\n',NULL);
INSERT INTO "perl_manual" VALUES (674,'rss','RDF Site Summary, a netscape XML format to describe web-based metadata, http://www.perl.com/pub/2000/01/rss.html and http://search.cpan.org/search?dist=XML-RSS\n',NULL);
INSERT INTO "perl_manual" VALUES (675,'rtfm','READ THE F*CKING MANUAL!!\n',NULL);
INSERT INTO "perl_manual" VALUES (676,'rules','DON\'T: send private messages to channel operators, use autoaway feature, paste code (more than 3 lines), use text decorations (bold, color, etc.), abuse channel\'s bot!\n',NULL);
INSERT INTO "perl_manual" VALUES (677,'s///','Replace a pattern with a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/s.html\n',NULL);
INSERT INTO "perl_manual" VALUES (678,'safe','Compile and execute code in restricted compartments, http://www.perl.com/CPAN-local/doc/manual/html/lib/Safe.html\n',NULL);
INSERT INTO "perl_manual" VALUES (679,'sans','The SANS (System Administration, Networking, and Security) Institute is a cooperative research and education organization intended to help in system administration solutions, http://www.sans.org/newlook/home.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (680,'scalar','Force a scalar context, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/scalar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (681,'scripts','Free CGI scripts archives: http://www.cgi-resources.com, http://www.scriptsearch.com, http://www.freecode.com, http://www.itm.com/cgicollection\n',NULL);
INSERT INTO "perl_manual" VALUES (682,'sdbm_file','Tied access to sdbm files, http://www.perl.com/CPAN-local/doc/manual/html/lib/SDBM_File.html\n',NULL);
INSERT INTO "perl_manual" VALUES (683,'search','Comprehensive Perl Archive Network main search engine, http://theory.uwinnipeg.ca/search/cpan-search.html\n',NULL);
INSERT INTO "perl_manual" VALUES (684,'search::dict, look','Search for key in dictionary file, http://www.perl.com/CPAN-local/doc/manual/html/lib/Search/Dict.html\n',NULL);
INSERT INTO "perl_manual" VALUES (685,'secure cgi','Some CGI security basics, http://www.go2net.com/people/paulp/cgi-security/safe-cgi.txt\n',NULL);
INSERT INTO "perl_manual" VALUES (686,'sed','the stream editor - originally written and designed for Unix, sed has been ported over to CP/M, MS-DOS, Windows 9x/NT, OS/2, and other operating systems, http://www.cornerstonemag.com/sed/\n',NULL);
INSERT INTO "perl_manual" VALUES (687,'seek','Reposition file pointer for random-access I/O, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/seek.html\n',NULL);
INSERT INTO "perl_manual" VALUES (688,'seekdir','Reposition directory pointer, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/seekdir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (689,'select','Reset DEFAULT output or do I/O multiplexing, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/select.html\n',NULL);
INSERT INTO "perl_manual" VALUES (690,'selectsaver','Save and restore selected file handle, http://www.perl.com/CPAN-local/doc/manual/html/lib/SelectSaver.html\n',NULL);
INSERT INTO "perl_manual" VALUES (691,'selfloader','Load functions only on demand, http://www.perl.com/CPAN-local/doc/manual/html/lib/SelfLoader.html\n',NULL);
INSERT INTO "perl_manual" VALUES (692,'semctl','SysV semaphore control operations, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/semctl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (693,'semget','Get set of SysV semaphores, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/semget.html\n',NULL);
INSERT INTO "perl_manual" VALUES (694,'semop','SysV semaphore operations, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/semop.html\n',NULL);
INSERT INTO "perl_manual" VALUES (695,'send','Send a message over a socket, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/send.html\n',NULL);
INSERT INTO "perl_manual" VALUES (696,'sendmail','the most popular UNIX mailer program, http://www.sendmail.org\n',NULL);
INSERT INTO "perl_manual" VALUES (697,'server utilities','Server and Daemon Utilities, http://theory.uwinnipeg.ca/CPAN/by-category/16_Server_and_Daemon_Utilities.html\n',NULL);
INSERT INTO "perl_manual" VALUES (698,'setgrent','Prepare group file for use, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setgrent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (699,'sethostent','Prepare hosts file for use, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sethostent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (700,'setnetent','Prepare networks file for use, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setnetent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (701,'setpgrp','Set the process group of a process, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setpgrp.html\n',NULL);
INSERT INTO "perl_manual" VALUES (702,'setpriority','Set a process\'s nice value, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setpriority.html\n',NULL);
INSERT INTO "perl_manual" VALUES (703,'setprotoent','Prepare protocols file for use, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setprotoent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (704,'setpwent','Prepare passwd file for use, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setpwent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (705,'setservent','Prepare services file for use, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setservent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (706,'setsockopt','Set some socket options, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/setsockopt.html\n',NULL);
INSERT INTO "perl_manual" VALUES (707,'sex','Heterogeneous recombination of Perl Packages, http://theoryx5.uwinnipeg.ca/CPAN/data/Sex/Sex.html\n',NULL);
INSERT INTO "perl_manual" VALUES (708,'shell','Run shell commands transparently within perl, http://www.perl.com/CPAN-local/doc/manual/html/lib/Shell.html\n',NULL);
INSERT INTO "perl_manual" VALUES (709,'shift','Remove the first element of an array, and return it, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/shift.html\n',NULL);
INSERT INTO "perl_manual" VALUES (710,'shmctl','SysV shared memory operations, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/shmctl.html\n',NULL);
INSERT INTO "perl_manual" VALUES (711,'shmget','Get SysV shared memory segment identifier, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/shmget.html\n',NULL);
INSERT INTO "perl_manual" VALUES (712,'shmread','Read SysV shared memory, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/shmread.html\n',NULL);
INSERT INTO "perl_manual" VALUES (713,'shmwrite','Write SysV shared memory, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/shmwrite.html\n',NULL);
INSERT INTO "perl_manual" VALUES (714,'shutdown','Close down just half of a socket connection, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/shutdown.html\n',NULL);
INSERT INTO "perl_manual" VALUES (715,'signals','Signals, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/IPC/signals.html\n',NULL);
INSERT INTO "perl_manual" VALUES (716,'sigtrap','Perl pragma to enable simple signal handling, http://www.perl.com/CPAN-local/doc/manual/html/lib/sigtrap.html\n',NULL);
INSERT INTO "perl_manual" VALUES (717,'sin','Return the sin of a number, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sin.html\n',NULL);
INSERT INTO "perl_manual" VALUES (718,'sins','The Seven Deadly Sins of Perl, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/versus/perl\n',NULL);
INSERT INTO "perl_manual" VALUES (719,'sleep','Block for some number of seconds, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sleep.html\n',NULL);
INSERT INTO "perl_manual" VALUES (720,'snmp','SNMP modules, http://theory.uwinnipeg.ca/CPAN/by-category/23_Miscellaneous_Modules.html\n',NULL);
INSERT INTO "perl_manual" VALUES (721,'socket','Create a socket, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/socket.html\n',NULL);
INSERT INTO "perl_manual" VALUES (722,'socket, sockaddr_in, sockaddr_un, inet_aton, inet_ntoa','Load the  C socket.h defines and structure manipulators , http://www.perl.com/CPAN-local/doc/manual/html/lib/Socket.html\n',NULL);
INSERT INTO "perl_manual" VALUES (723,'socketpair','Create a pair of sockets, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/socketpair.html\n',NULL);
INSERT INTO "perl_manual" VALUES (724,'sort','Sort a list of values, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sort.html\n',NULL);
INSERT INTO "perl_manual" VALUES (725,'sort::fields','Sort lines containing delimited fields, http://theory.uwinnipeg.ca/CPAN/data/Sort-Fields/Fields.html\n',NULL);
INSERT INTO "perl_manual" VALUES (726,'sorting','Far More Than Everything You\'ve Ever Wanted to Know About Sorting, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/sort.html\n',NULL);
INSERT INTO "perl_manual" VALUES (727,'source code','IRCBot source code *** This application comes with neither warranty nor technical support *** http://www.dgits.com/ircbot/ (pick latest version).\n',NULL);
INSERT INTO "perl_manual" VALUES (728,'spine','a webbased content management script and can be found at http://spine.sourceforge.net\n',NULL);
INSERT INTO "perl_manual" VALUES (729,'splice','Add or remove elements anywhere in an array, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/splice.html\n',NULL);
INSERT INTO "perl_manual" VALUES (730,'split','Split up a string using a regexp delimiter, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/split.html\n',NULL);
INSERT INTO "perl_manual" VALUES (731,'sprintf','Formatted print into a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sprintf.html\n',NULL);
INSERT INTO "perl_manual" VALUES (732,'sql','Structured Query Language, http://w3.one.net/~jhoffman/sqltut.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (733,'sql standard','the resource devoted to SQL (Structured Query Language) standards, http://www.jcc.com/SQLPages/jccs_sql.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (734,'sql standards','Central source of information about the SQL standards process and its current state, http://www.jcc.com/SQLPages/jccs_sql.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (735,'sqrt','Square root function, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sqrt.html\n',NULL);
INSERT INTO "perl_manual" VALUES (736,'srand','Seed the random number generator, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/srand.html\n',NULL);
INSERT INTO "perl_manual" VALUES (737,'ssh','Secure Shell, encrypted remote connection protocol, http://www.ssh.fi/\n',NULL);
INSERT INTO "perl_manual" VALUES (738,'ssi','Server Side Includes, http://www.sonic.net/~nbs/unix/www/ssi/ssireferences/\n',NULL);
INSERT INTO "perl_manual" VALUES (739,'ssi how-to','How do I enable SSI (parsed HTML)?, http://apache.org/docs/misc/FAQ.html#ssi-part-i\n',NULL);
INSERT INTO "perl_manual" VALUES (740,'ssi test','a simple (no #exec) test to check whether SSI are enabled on the server: save as ssi_test.shtml, upload, try. http://dgits.com/scripts/misc/ssi_test.txt\n',NULL);
INSERT INTO "perl_manual" VALUES (741,'ssi2work','Q: How do I enable SSI execution on my Apache server?, , A: http://www.apache.org/docs/misc/FAQ.html#ssi-part-i\n',NULL);
INSERT INTO "perl_manual" VALUES (742,'ssl','Secure Socket Layer, http://www.ssl.com/FAQ_s___Documentation/About_SSL/about_ssl.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (743,'ssp','Server Side Push, http://www1.acm.org:82/~hlb/publications/push/push.html\n',NULL);
INSERT INTO "perl_manual" VALUES (744,'ssp architecture','A Reference Architecture for Push Systems, http://www.infosys.tuwien.ac.at/Staff/pooh/papers/PushArch/\n',NULL);
INSERT INTO "perl_manual" VALUES (745,'stat','Get a file\'s status information, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/stat.html\n',NULL);
INSERT INTO "perl_manual" VALUES (746,'stats','Web server statistic packages, http://www.mrunix.net/webalizer/\n',NULL);
INSERT INTO "perl_manual" VALUES (747,'stderr','where errors go. If you\'re executing something that sends stuff to STDERR rather than STDOUT you might like to read http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq8.html#How_can_I_capture_STDERR_from_an\n',NULL);
INSERT INTO "perl_manual" VALUES (748,'strict','Perl pragma to restrict unsafe constructs, http://www.perl.com/CPAN-local/doc/manual/html/lib/strict.html\n',NULL);
INSERT INTO "perl_manual" VALUES (749,'string','String, http://theory.uwinnipeg.ca/CPAN/by-category/11_String_Lang_Text_Proc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (750,'strip html','How do I remove HTML from a string?, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq9.html#How_do_I_remove_HTML_from_a_stri\n',NULL);
INSERT INTO "perl_manual" VALUES (751,'study','Optimize input data for repeated searches, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/study.html\n',NULL);
INSERT INTO "perl_manual" VALUES (752,'style','Perl Style, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/style/slide-index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (753,'sub','Declare a subroutine, possibly anonymously, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sub.html\n',NULL);
INSERT INTO "perl_manual" VALUES (754,'subs','Perl pragma to predeclare sub names, http://www.perl.com/CPAN-local/doc/manual/html/lib/subs.html\n',NULL);
INSERT INTO "perl_manual" VALUES (755,'substr','Get or alter a portion of a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/substr.html\n',NULL);
INSERT INTO "perl_manual" VALUES (756,'suck and see','often the best way to find out how something works. You\'ll not only feel good because you found out for yourself, but you\'ll also save both yourself and the rest of us time and energy. If you want to test a one line perl statement type this at the command',NULL);
INSERT INTO "perl_manual" VALUES (757,'swish-e','Simple web indexing system for humans - Enhanced, , usr: http://sunsite.berkeley.edu/SWISH-E/\n',NULL);
INSERT INTO "perl_manual" VALUES (758,'switch','Switch statemets in perl, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/switch_statements\n',NULL);
INSERT INTO "perl_manual" VALUES (759,'symbol','Manipulate Perl symbols and their names, http://www.perl.com/CPAN-local/doc/manual/html/lib/Symbol.html\n',NULL);
INSERT INTO "perl_manual" VALUES (760,'symlink','Create a symbolic link to a file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/symlink.html\n',NULL);
INSERT INTO "perl_manual" VALUES (761,'sys::hostname','Try every conceivable way to get hostname, http://www.perl.com/CPAN-local/doc/manual/html/lib/Sys/Hostname.html\n',NULL);
INSERT INTO "perl_manual" VALUES (762,'sys::syslog','Perl interface to the  UNIX  syslog(3) calls, http://www.perl.com/CPAN-local/doc/manual/html/lib/Sys/Syslog.html\n',NULL);
INSERT INTO "perl_manual" VALUES (763,'sys::syslog, openlog, closelog, setlogmask, syslog','Perl interface to the  UNIX  syslog(3) calls, http://www.perl.com/CPAN-local/doc/manual/html/lib/Sys/Syslog.html\n',NULL);
INSERT INTO "perl_manual" VALUES (764,'syscall','Execute an arbitrary system call, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/syscall.html\n',NULL);
INSERT INTO "perl_manual" VALUES (765,'sysread','Fixed-length unbuffered input from a filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/sysread.html\n',NULL);
INSERT INTO "perl_manual" VALUES (766,'system','Run a separate program, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/system.html\n',NULL);
INSERT INTO "perl_manual" VALUES (767,'syswrite','Fixed-length unbuffered output to a filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/syswrite.html\n',NULL);
INSERT INTO "perl_manual" VALUES (768,'taint checking','Perl taint checking, the -T option to Perl enables Perl to check for possible security vulnerabilities in cgi scripts. Can be found at http://www.perl.com/pub/doc/FAQs/cgi/wwwsf5.html\n',NULL);
INSERT INTO "perl_manual" VALUES (769,'tar','GNU tar - an archiver tool, http://www.gnu.org/manual/tar/html_mono/tar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (770,'tcl','Perl vs Tcl, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/versus/\n',NULL);
INSERT INTO "perl_manual" VALUES (771,'tell','Get current seekpointer on a filehandle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/tell.html\n',NULL);
INSERT INTO "perl_manual" VALUES (772,'telldir','Get current seekpointer on a directory handle, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/telldir.html\n',NULL);
INSERT INTO "perl_manual" VALUES (773,'telnet','Telnet is a protocol that enables remote login, http://www.ag.uiuc.edu/~iproject/telnet.html\n',NULL);
INSERT INTO "perl_manual" VALUES (774,'term::ansicolor','Perl library to colorize screen output using ANSI escape sequences, http://theoryx5.uwinnipeg.ca/CPAN/data/ANSIColor/ANSIColor.html\n',NULL);
INSERT INTO "perl_manual" VALUES (775,'term::cap','Perl termcap interface, http://www.perl.com/CPAN-local/doc/manual/html/lib/Term/Cap.html\n',NULL);
INSERT INTO "perl_manual" VALUES (776,'term::complete','Perl word completion module, http://www.perl.com/CPAN-local/doc/manual/html/lib/Term/Complete.html\n',NULL);
INSERT INTO "perl_manual" VALUES (777,'term::readkey','A perl module for simple terminal control, http://theoryx5.uwinnipeg.ca/CPAN/data/TermReadKey/ReadKey.html\n',NULL);
INSERT INTO "perl_manual" VALUES (778,'term::readline','Perl interface to various readline packages. If no FLOAT8package is found, substitutes stubs instead of basic functions., http://www.perl.com/CPAN-local/doc/manual/html/lib/Term/ReadLine.html\n',NULL);
INSERT INTO "perl_manual" VALUES (779,'test','Provides a simple, http://www.perl.com/CPAN-local/doc/manual/html/lib/Test.html\n',NULL);
INSERT INTO "perl_manual" VALUES (780,'test::harness','Run perl standard test scripts with statistics, http://www.perl.com/CPAN-local/doc/manual/html/lib/Test/Harness.html\n',NULL);
INSERT INTO "perl_manual" VALUES (781,'text::abbrev','Create an abbreviation table from a list, http://www.perl.com/CPAN-local/doc/manual/html/lib/Text/Abbrev.html\n',NULL);
INSERT INTO "perl_manual" VALUES (782,'text::parsewords','Parse text into an array of tokens or array of arrays, http://www.perl.com/CPAN-local/doc/manual/html/lib/Text/ParseWords.html\n',NULL);
INSERT INTO "perl_manual" VALUES (783,'text::soundex','Implementation of the Soundex Algorithm as Described by Knuth, http://www.perl.com/CPAN-local/doc/manual/html/lib/Text/Soundex.html\n',NULL);
INSERT INTO "perl_manual" VALUES (784,'text::tabs','Expand and unexpand tabs per the unix  expand(1) and  unexpand(1), http://www.perl.com/CPAN-local/doc/manual/html/lib/Text/Tabs.html\n',NULL);
INSERT INTO "perl_manual" VALUES (785,'text::wrap','Line wrapping to form simple paragraphs, http://www.perl.com/CPAN-local/doc/manual/html/lib/Text/Wrap.html\n',NULL);
INSERT INTO "perl_manual" VALUES (786,'textpad','a Win32 text editor, http://www.textpad.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (787,'thread','Multithreading, http://www.perl.com/CPAN-local/doc/manual/html/lib/Thread.html\n',NULL);
INSERT INTO "perl_manual" VALUES (788,'thread::queue','Thread-safe queues, http://www.perl.com/CPAN-local/doc/manual/html/lib/Thread/Queue.html\n',NULL);
INSERT INTO "perl_manual" VALUES (789,'thread::semaphore','Thread-safe semaphores, http://www.perl.com/CPAN-local/doc/manual/html/lib/Thread/Semaphore.html\n',NULL);
INSERT INTO "perl_manual" VALUES (790,'thread::signal','Start a thread which runs signal handlers reliably, http://www.perl.com/CPAN-local/doc/manual/html/lib/Thread/Signal.html\n',NULL);
INSERT INTO "perl_manual" VALUES (791,'thread::specific','Thread-specific keys, http://www.perl.com/CPAN-local/doc/manual/html/lib/Thread/Specific.html\n',NULL);
INSERT INTO "perl_manual" VALUES (792,'tie','Bind a variable to an object class, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/tie.html\n',NULL);
INSERT INTO "perl_manual" VALUES (793,'tie::array','Base class for tied arrays, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/Array.html\n',NULL);
INSERT INTO "perl_manual" VALUES (794,'tie::handle','Base class definitions for tied handles, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/Handle.html\n',NULL);
INSERT INTO "perl_manual" VALUES (795,'tie::hash','Base class definitions for tied hashes, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/Hash.html\n',NULL);
INSERT INTO "perl_manual" VALUES (796,'tie::hash, tie::stdhash','Base class definitions for tied hashes, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/Hash.html\n',NULL);
INSERT INTO "perl_manual" VALUES (797,'tie::refhash','Use references as hash keys, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/RefHash.html\n',NULL);
INSERT INTO "perl_manual" VALUES (798,'tie::scalar','Base class definitions for tied scalars, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/Scalar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (799,'tie::scalar, tie::stdscalar','Base class definitions for tied scalars, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/Scalar.html\n',NULL);
INSERT INTO "perl_manual" VALUES (800,'tie::substrhash','Fixed-table-size, fixed-key-length hashing, http://www.perl.com/CPAN-local/doc/manual/html/lib/Tie/SubstrHash.html\n',NULL);
INSERT INTO "perl_manual" VALUES (801,'time','Return number of seconds since 1970, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/time.html\n',NULL);
INSERT INTO "perl_manual" VALUES (802,'time::gmtime','By-name interface to Perl\'s built-in  gmtime() function, http://www.perl.com/CPAN-local/doc/manual/html/lib/Time/gmtime.html\n',NULL);
INSERT INTO "perl_manual" VALUES (803,'time::local','Efficiently compute time from local and  GMT time, http://www.perl.com/CPAN-local/doc/manual/html/lib/Time/Local.html\n',NULL);
INSERT INTO "perl_manual" VALUES (804,'time::localtime','By-name interface to Perl\'s built-in  localtime() function, http://www.perl.com/CPAN-local/doc/manual/html/lib/Time/localtime.html\n',NULL);
INSERT INTO "perl_manual" VALUES (805,'time::tm','Internal object used by Time::gmtime and Time::localtime, http://www.perl.com/CPAN-local/doc/manual/html/lib/Time/tm.html\n',NULL);
INSERT INTO "perl_manual" VALUES (806,'times','Return elapsed time for self and child processes, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/times.html\n',NULL);
INSERT INTO "perl_manual" VALUES (807,'timtowtdi','Perl motto: \'There Is More Than One Way To Do It!\'...\n',NULL);
INSERT INTO "perl_manual" VALUES (808,'tk','Tk stuff, http://theory.uwinnipeg.ca/CPAN/by-category/99_Not_In_Modulelist.html\n',NULL);
INSERT INTO "perl_manual" VALUES (809,'tmtowtdi','the *official* <cough> way to spell TIMTOWTDI - perl\'s motto \'There\'s more than one way to do it\'. A motto self-proving by the \'more than one\' way to spell it\'s motto. http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfaq1.html#Is_Perl_difficult_to_l',NULL);
INSERT INTO "perl_manual" VALUES (810,'tr///','Transliterate a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/tr.html,\n',NULL);
INSERT INTO "perl_manual" VALUES (811,'trinity os','A guide to configuring your linux server for Performance, Security, and Managability, http://solefald.linuxinside.com/trinity/TrinityOS-101500c.html\n',NULL);
INSERT INTO "perl_manual" VALUES (812,'truncate','Shorten a file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/truncate.html\n',NULL);
INSERT INTO "perl_manual" VALUES (813,'tutorial','Perl programming url, http://wdvl.internet.com/Authoring/Languages/Perl/\n',NULL);
INSERT INTO "perl_manual" VALUES (814,'txt search','How to search through ascii delimited file (from CGI101 tutorial), http://www.cgi101.com/class/old6/\n',NULL);
INSERT INTO "perl_manual" VALUES (815,'ubb','Ultimate Bulletin Board, The most popular CGI/Perl bulletin board script,  http://www.ultimatebb.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (816,'uc','Return upper-case version of a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/uc.html\n',NULL);
INSERT INTO "perl_manual" VALUES (817,'ucfirst','Return a string with just the next letter in upper case, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/ucfirst.html\n',NULL);
INSERT INTO "perl_manual" VALUES (818,'ui','User Interfaces, http://theory.uwinnipeg.ca/CPAN/by-category/08_User_Interfaces.html\n',NULL);
INSERT INTO "perl_manual" VALUES (819,'umask','Set file creation mode mask, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/umask.html\n',NULL);
INSERT INTO "perl_manual" VALUES (820,'undef','Remove a variable or function definition, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/undef.html\n',NULL);
INSERT INTO "perl_manual" VALUES (821,'universal','Base class for  ALL classes (blessed references), http://www.perl.com/CPAN-local/doc/manual/html/lib/UNIVERSAL.html\n',NULL);
INSERT INTO "perl_manual" VALUES (822,'unix','UNIX - operating system with multitasking support and more, , some help for users: http://www.win.tue.nl/unixhelp/\n',NULL);
INSERT INTO "perl_manual" VALUES (823,'unix asp','Microsoft ASP ports for various platforms by Chili!Soft, http://www.chilisoft.com\n',NULL);
INSERT INTO "perl_manual" VALUES (824,'unix man','On-Line manual pages lookup and listing for OpenBSD (good for general UNIX as well), http://www.openbsd.org/cgi-bin/man.cgi\n',NULL);
INSERT INTO "perl_manual" VALUES (825,'unlink','Remove one link to a file, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/unlink.html\n',NULL);
INSERT INTO "perl_manual" VALUES (826,'unpack','Convert binary structure into normal perl variables, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/unpack.html\n',NULL);
INSERT INTO "perl_manual" VALUES (827,'unshift','Prepend more elements to the beginning of a list, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/unshift.html\n',NULL);
INSERT INTO "perl_manual" VALUES (828,'untie','Break a tie binding to a variable, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/untie.html\n',NULL);
INSERT INTO "perl_manual" VALUES (829,'uri::escape','Escape and unescape unsafe characters in string (part of libwww), http://theory.uwinnipeg.ca/CPAN/data/URI/URI/Escape.html\n',NULL);
INSERT INTO "perl_manual" VALUES (830,'use','Load in a module at compile time, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/use.html\n',NULL);
INSERT INTO "perl_manual" VALUES (831,'use lib','Manipulate @INC content at compile time, http://www.perl.com/CPAN-local/doc/manual/html/lib/lib.html\n',NULL);
INSERT INTO "perl_manual" VALUES (832,'use vs require','Use vs. Require, http://ftp.digital.com/pub/plan/perl/CPAN/doc/FMTEYEWTK/use_vs_require\n',NULL);
INSERT INTO "perl_manual" VALUES (833,'usenet','Mail and Usenet News, http://theory.uwinnipeg.ca/CPAN/by-category/19_Mail_and_Usenet_News.html\n',NULL);
INSERT INTO "perl_manual" VALUES (834,'user::grent','By-name interface to Perl\'s built-in getgr*() functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/User/grent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (835,'user::pwent','By-name interface to Perl\'s built-in getpw*() functions, http://www.perl.com/CPAN-local/doc/manual/html/lib/User/pwent.html\n',NULL);
INSERT INTO "perl_manual" VALUES (836,'utime','Set a file\'s last access and modify times, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/utime.html\n',NULL);
INSERT INTO "perl_manual" VALUES (837,'v','ual is just say no\n',NULL);
INSERT INTO "perl_manual" VALUES (838,'values','Return a list of the values in a hash, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/values.html\n',NULL);
INSERT INTO "perl_manual" VALUES (839,'vars','Perl pragma to predeclare global variable names, http://www.perl.com/CPAN-local/doc/manual/html/lib/vars.html\n',NULL);
INSERT INTO "perl_manual" VALUES (840,'vb programmer','An oxymoronic phrase..., http://www.microsoft.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (841,'vec','Test or set particular bits in a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/vec.html\n',NULL);
INSERT INTO "perl_manual" VALUES (842,'versus','A comparison of perl with other languages.. *note* I in no way condone anything that Tom Christiansen has to say, but its a decent doc!, http://language.perl.com/versus/\n',NULL);
INSERT INTO "perl_manual" VALUES (843,'vhost','Apache Virtual Host documentation, http://www.apache.org/docs/vhosts/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (844,'vi','Standard, simple but yet powerful UNIX text editor available by DEFAULT on virtually all flavors of UNIX and GNU/Linux, http://www.vim.org/\n',NULL);
INSERT INTO "perl_manual" VALUES (845,'vim','vi improved; see vi\n',NULL);
INSERT INTO "perl_manual" VALUES (846,'virtual hosts','Apache Virtual Host documentation, http://apache.org/docs/vhosts/index.html\n',NULL);
INSERT INTO "perl_manual" VALUES (847,'vmware','Software layer that allows multiple operating system environments to run concurrently using the same hardware resources, http://www.vmware.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (848,'w','z is too cheap to buy software and too lazy to look into GPL\n',NULL);
INSERT INTO "perl_manual" VALUES (849,'wait','Wait for any child process to die, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/wait.html\n',NULL);
INSERT INTO "perl_manual" VALUES (850,'waitpid','Wait for a particular child process to die, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/waitpid.html\n',NULL);
INSERT INTO "perl_manual" VALUES (851,'wantarray','Get list vs array context of current subroutine call, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/wantarray.html\n',NULL);
INSERT INTO "perl_manual" VALUES (852,'warn','Print debugging info, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/warn.html\n',NULL);
INSERT INTO "perl_manual" VALUES (853,'watchguard','WatchGuard is a leading provider of dynamic, comprehensive Internet security solutions designed to protect small- to medium-sized enterprises, or SMEs, that use the Internet for electronic commerce and communications, http://www.watchguard.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (854,'web database','Databases and the World Wide Web, http://cdr.cs.uiuc.edu/pubs/de97tutorial/index.htm\n',NULL);
INSERT INTO "perl_manual" VALUES (855,'webalizer','Free, open source, fast (C written) server log analyzer, http://www.mrunix.net/webalizer/\n',NULL);
INSERT INTO "perl_manual" VALUES (856,'webfetch','Perl module to download and save information from the Web, http://theory.uwinnipeg.ca/CPAN/data/WebFetch/WebFetch.html\n',NULL);
INSERT INTO "perl_manual" VALUES (857,'webmin','a web-based interface for system administration for Unix. Using any browser that supports tables and forms (and Java for the File Manager module), you can setup user accounts, Apache, DNS, file sharing and so on. http://www.webmin.com/webmin/\n',NULL);
INSERT INTO "perl_manual" VALUES (858,'website','the cgi website. It is currently in the planning phase, but should be up sometime in the future, at http://www.cgichannel.com - suggestions are most welcome\n',NULL);
INSERT INTO "perl_manual" VALUES (859,'webster','Miriam Webster On-Line - the language center (English Dictionary and Tresaurus), http://www.m-w.com\n',NULL);
INSERT INTO "perl_manual" VALUES (860,'welcome','how you should feel in coming to our channel. We\'re here to help so long as you ask a specific question. Dont just say \'my script doesn\'t work\'. Also please abide by our rules: Don\'t message the ops, don\'t use autoaway, don\'t use text decorations, don\'t p',NULL);
INSERT INTO "perl_manual" VALUES (861,'wh','key is its too early to get drunk\n',NULL);
INSERT INTO "perl_manual" VALUES (862,'wheel','a round object fashioned in such a way as a vehicle is easily moved. If you want to re-invent it you\'re not going to make it any better. Perl relevancy? Use someone else\'s script. (see keyword \'scripts\')\n',NULL);
INSERT INTO "perl_manual" VALUES (863,'while','the statement that executes a block as long as an expression is true (does not evaluate to the null string (\'\') or 0 or \'0\'). http://www.perl.com/CPAN-local/doc/manual/html/pod/perlsyn.html#Compound_statements\n',NULL);
INSERT INTO "perl_manual" VALUES (864,'win32','Win32 related perl modules, http://theory.uwinnipeg.ca/CPAN/by-category/22_Microsoft_Windows_Modules.html\n',NULL);
INSERT INTO "perl_manual" VALUES (865,'win32 apache','Using Apache With Microsoft Windows, http://www.apache.org/docs/windows.html\n',NULL);
INSERT INTO "perl_manual" VALUES (866,'win32 sendmail','a webpage listing different Windows programs for command line email. http://winfiles.cnet.com/apps/98/mail-command.html\n',NULL);
INSERT INTO "perl_manual" VALUES (867,'win32 ssh','SecureCRT software by Van Dyke Technologies - combines the secure login and data transfer capabilities of Secure Shell the reliability, usability and configurability of a proven Windows terminal emulator, http://www.vandyke.com/products/securecrt/\n',NULL);
INSERT INTO "perl_manual" VALUES (868,'wine','Implementation of the Windows 3.x and Win32 APIs on top of X and Unix, http://www.winehq.com\n',NULL);
INSERT INTO "perl_manual" VALUES (869,'winperl','Perl for win32 platform, http://www.activestate.com\n',NULL);
INSERT INTO "perl_manual" VALUES (870,'worst topics','music, religion, and linux vs. windows\n',NULL);
INSERT INTO "perl_manual" VALUES (871,'write','Print a picture record, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/write.html\n',NULL);
INSERT INTO "perl_manual" VALUES (872,'xml','Extensible Markup Language designed to enable the use of SGML on the World Wide Web, http://www.xml.com and http://www.w3schools.com/xml/\n',NULL);
INSERT INTO "perl_manual" VALUES (873,'xml::parser','A perl module for parsing XML documents, http://theoryx5.uwinnipeg.ca/CPAN/data/XML-Parser/Parser.html\n',NULL);
INSERT INTO "perl_manual" VALUES (874,'xmms','X Multimedia System - player for Unix (Linux): eqalizer and playlist editor; configurable interface, skins, multiple file formats, source code; http://www.xmms.org/',NULL);
INSERT INTO "perl_manual" VALUES (875,'y///','Transliterate a string, http://www.perl.com/CPAN-local/doc/manual/html/pod/perlfunc/y.html\n',NULL);
INSERT INTO "perl_manual" VALUES (876,'zend','A rewrite of the PHP 3.0 scripting engine with a different techology to obtain much better performance, http://www.zend.com/\n',NULL);
INSERT INTO "perl_manual" VALUES (877,'zeus','One of the fastest web server software titles by Zeus UK, http://www.zeus.co.uk/products/zeus3/\n',NULL);
INSERT INTO "perl_manual" VALUES (878,'zope','Zope is the leading Open Source web application server, http://www.zope.org/\n',NULL);

--
-- Table structure for table 'php_manual'
--



--
-- Sequences for table PHP_MANUAL
--

CREATE SEQUENCE php_manual_m_id_seq;

CREATE TABLE "php_manual" (
  "m_id" INT4 DEFAULT nextval('php_manual_m_id_seq'),
  "command" varchar(255) NOT NULL DEFAULT '',
  "dscr" varchar(255) NOT NULL DEFAULT '',
  "ex" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("m_id")

);

--
-- Dumping data for table 'php_manual'
--

INSERT INTO "php_manual" VALUES (1,'apache_lookup_uri','  Perform a partial request for the specified URI','   class apache_lookup_uri (string filename)');
INSERT INTO "php_manual" VALUES (2,'apache_note',' Get and set apache request notes','   string apache_note (string note_name [, string note_value])');
INSERT INTO "php_manual" VALUES (3,'getallheaders',' Fetch all HTTP request headers','   array getallheaders (void)');
INSERT INTO "php_manual" VALUES (4,'virtual',' Perform an Apache sub-request','   int virtual (string filename)');
INSERT INTO "php_manual" VALUES (5,'ascii2ebcdic',' Translate string from ASCII to EBCDIC','   int ascii2ebcdic (string ascii_str)');
INSERT INTO "php_manual" VALUES (6,'ebcdic2ascii',' Translate string from EBCDIC to ASCII','   int ebcdic2ascii (string ebcdic_str)');
INSERT INTO "php_manual" VALUES (7,'array','  Create an array','   array array ([mixed ...])');
INSERT INTO "php_manual" VALUES (8,'array_count_values',' Counts all the values of an array','   array array_count_values (array input)');
INSERT INTO "php_manual" VALUES (9,'array_diff',' Computes the difference of arrays','   array array_diff (array array1, array array2 [, array ...])');
INSERT INTO "php_manual" VALUES (10,'array_flip',' Flip all the values of an array','   array array_flip (array trans)');
INSERT INTO "php_manual" VALUES (11,'array_intersect',' Computes the intersection of arrays','   array array_intersect (array array1, array array2 [, array ...])');
INSERT INTO "php_manual" VALUES (12,'array_keys',' Return all the keys of an array','   array array_keys (array input [, mixed search_value])');
INSERT INTO "php_manual" VALUES (13,'array_merge',' Merge two or more arrays','   array array_merge (array array1, array array2 [, array ...])');
INSERT INTO "php_manual" VALUES (14,'array_merge_recursive',' Merge two or more arrays recursively','   array array_merge_recursive (array array1, array array2 [, array ...])');
INSERT INTO "php_manual" VALUES (15,'array_multisort',' Sort multiple or multi-dimensional arrays','   bool array_multisort (array ar1 [, mixed arg [, mixed ... [, array');
INSERT INTO "php_manual" VALUES (16,'array_pad','  Pad array to the specified length with a value','   array array_pad (array input, int pad_size, mixed pad_value)');
INSERT INTO "php_manual" VALUES (17,'array_pop',' Pop the element off the end of array','   mixed array_pop (array array)');
INSERT INTO "php_manual" VALUES (18,'array_push','  Push one or more elements onto the end of array','   int array_push (array array, mixed var [, mixed ...])');
INSERT INTO "php_manual" VALUES (19,'array_rand','  Pick one or more random entries out of an array','   mixed array_rand (array input [, int num_req])');
INSERT INTO "php_manual" VALUES (20,'array_reverse','  Return an array with elements in reverse order','   array array_reverse (array array [, bool preserve_keys])');
INSERT INTO "php_manual" VALUES (21,'array_shift','  Pop an element off the beginning of array','   mixed array_shift (array array)');
INSERT INTO "php_manual" VALUES (22,'array_slice',' Extract a slice of the array','   array array_slice (array array, int offset [, int length])');
INSERT INTO "php_manual" VALUES (23,'array_splice','  Remove a portion of the array and replace it with','   array array_splice (array input, int offset [, int length [, array');
INSERT INTO "php_manual" VALUES (24,'array_sum','  Calculate the sum of values in an array.','   mixed array_sum (array arr)');
INSERT INTO "php_manual" VALUES (25,'array_unique',' Removes duplicate values from an array','   array array_unique (array array)');
INSERT INTO "php_manual" VALUES (26,'array_unshift','  Push one or more elements onto the beginning of','   int array_unshift (array array, mixed var [, mixed ...])');
INSERT INTO "php_manual" VALUES (27,'array_values',' Return all the values of an array','   array array_values (array input)');
INSERT INTO "php_manual" VALUES (28,'array_walk','  Apply a user function to every member of an array','   int array_walk (array arr, string func, mixed userdata)');
INSERT INTO "php_manual" VALUES (29,'arsort','  Sort an array in reverse order and maintain index','   void arsort (array array [, int sort_flags])');
INSERT INTO "php_manual" VALUES (30,'asort',' Sort an array and maintain index association','   void asort (array array [, int sort_flags])');
INSERT INTO "php_manual" VALUES (31,'compact','  Create array containing variables and their values','   array compact (mixed varname [, mixed ...])');
INSERT INTO "php_manual" VALUES (32,'count',' Count elements in a variable','   int count (mixed var)');
INSERT INTO "php_manual" VALUES (33,'current',' Return the current element in an array','   mixed current (array array)');
INSERT INTO "php_manual" VALUES (34,'each','  Return the next key and value pair from an array','   array each (array array)');
INSERT INTO "php_manual" VALUES (35,'end','  Set the internal pointer of an array to its last element','   mixed end (array array)');
INSERT INTO "php_manual" VALUES (36,'extract','  Import variables into the symbol table from an array','   int extract (array var_array [, int extract_type [, string prefix]])');
INSERT INTO "php_manual" VALUES (37,'in_array',' Return TRUE if a value exists in an array','   bool in_array (mixed needle, array haystack, bool strict)');
INSERT INTO "php_manual" VALUES (38,'array_search','  Searches the array for a given value and returns the','   mixed array_search (mixed needle, array haystack, bool strict)');
INSERT INTO "php_manual" VALUES (39,'key',' Fetch a key from an associative array','   mixed key (array array)');
INSERT INTO "php_manual" VALUES (40,'krsort',' Sort an array by key in reverse order','   int krsort (array array [, int sort_flags])');
INSERT INTO "php_manual" VALUES (41,'ksort',' Sort an array by key','   int ksort (array array [, int sort_flags])');
INSERT INTO "php_manual" VALUES (42,'list','  Assign variables as if they were an array','   void list(...);');
INSERT INTO "php_manual" VALUES (43,'natsort','  Sort an array using a \"natural order\" algorithm','   void natsort (array array)');
INSERT INTO "php_manual" VALUES (44,'natcasesort','  Sort an array using a case insensitive \"natural order\"','   void natcasesort (array array)');
INSERT INTO "php_manual" VALUES (45,'next','  Advance the internal array pointer of an array','   mixed next (array array)');
INSERT INTO "php_manual" VALUES (46,'pos',' Get the current element from an array','   mixed pos (array array)');
INSERT INTO "php_manual" VALUES (47,'prev',' Rewind the internal array pointer','   mixed prev (array array)');
INSERT INTO "php_manual" VALUES (48,'range','  Create an array containing a range of integers','   array range (int low, int high)');
INSERT INTO "php_manual" VALUES (49,'reset','  Set the internal pointer of an array to its first element','   mixed reset (array array)');
INSERT INTO "php_manual" VALUES (50,'rsort',' Sort an array in reverse order','   void rsort (array array [, int sort_flags])');
INSERT INTO "php_manual" VALUES (51,'shuffle',' Shuffle an array','   void shuffle (array array)');
INSERT INTO "php_manual" VALUES (52,'sizeof',' Get the number of elements in an array','   int sizeof (array array)');
INSERT INTO "php_manual" VALUES (53,'sort',' Sort an array','   void sort (array array [, int sort_flags])');
INSERT INTO "php_manual" VALUES (54,'uasort','  Sort an array with a user-defined comparison function and','   void uasort (array array, function cmp_function)');
INSERT INTO "php_manual" VALUES (55,'uksort','  Sort an array by keys using a user-defined comparison','   void uksort (array array, function cmp_function)');
INSERT INTO "php_manual" VALUES (56,'usort','  Sort an array by values using a user-defined comparison','   void usort (array array, string cmp_function)');
INSERT INTO "php_manual" VALUES (57,'aspell_new',' Load a new dictionary','   int aspell_new (string master, string personal)');
INSERT INTO "php_manual" VALUES (58,'aspell_check',' Check a word','   boolean aspell_check (int dictionary_link, string word)');
INSERT INTO "php_manual" VALUES (59,'aspell_check_raw','  Check a word without changing its case or trying','   boolean aspell_check_raw (int dictionary_link, string word)');
INSERT INTO "php_manual" VALUES (60,'aspell_suggest',' Suggest spellings of a word','   array aspell_suggest (int dictionary_link, string word)');
INSERT INTO "php_manual" VALUES (61,'bcadd',' Add two arbitrary precision numbers','   string bcadd (string left operand, string right operand [, int scale])');
INSERT INTO "php_manual" VALUES (62,'bccomp',' Compare two arbitrary precision numbers','   int bccomp (string left operand, string right operand [, int scale])');
INSERT INTO "php_manual" VALUES (63,'bcdiv',' Divide two arbitrary precision numbers','   string bcdiv (string left operand, string right operand [, int scale])');
INSERT INTO "php_manual" VALUES (64,'bcmod','  Get modulus of an arbitrary precision number','   string bcmod (string left operand, string modulus)');
INSERT INTO "php_manual" VALUES (65,'bcmul',' Multiply two arbitrary precision number','   string bcmul (string left operand, string right operand [, int scale])');
INSERT INTO "php_manual" VALUES (66,'bcpow','  Raise an arbitrary precision number to another','   string bcpow (string x, string y [, int scale])');
INSERT INTO "php_manual" VALUES (67,'bcscale','  Set DEFAULT scale parameter for all bc math functions','   string bcscale (int scale)');
INSERT INTO "php_manual" VALUES (68,'bcsqrt','  Get the square root of an arbitray precision number','   string bcsqrt (string operand [, int scale])');
INSERT INTO "php_manual" VALUES (69,'bcsub','  Subtract one arbitrary precision number from another','   string bcsub (string left operand, string right operand [, int scale])');
INSERT INTO "php_manual" VALUES (70,'bzclose',' Close a bzip2 file pointer','   int bzclose (int bz)');
INSERT INTO "php_manual" VALUES (71,'bzcompress',' Compress a string into bzip2 encoded data','   string bzcompress (string source [, int blocksize [, int workfactor]])');
INSERT INTO "php_manual" VALUES (72,'bzdecompress',' Decompresses bzip2 encoded data','   string bzdecompress (string source [, int small])');
INSERT INTO "php_manual" VALUES (73,'bzerrno',' Returns a bzip2 error number','   int bzerrno (int bz)');
INSERT INTO "php_manual" VALUES (74,'bzerror',' Returns the bzip2 error number and error string in an array','   array bzerror (int bz)');
INSERT INTO "php_manual" VALUES (75,'bzerrstr',' Returns a bzip2 error string','   string bzerrstr (int bz)');
INSERT INTO "php_manual" VALUES (76,'bzflush',' Force a write of all buffered data','   int bzflush (int bz)');
INSERT INTO "php_manual" VALUES (77,'bzopen',' Open a bzip2 compressed file','   int bzopen (string filename, string mode)');
INSERT INTO "php_manual" VALUES (78,'bzread',' Binary safe bzip2 file read','   string bzread (int bz [, int length])');
INSERT INTO "php_manual" VALUES (79,'bzwrite',' Binary safe bzip2 file write','   int bzwrite (int bz, string data [, int length])');
INSERT INTO "php_manual" VALUES (80,'JDToGregorian',' Converts Julian Day Count to Gregorian date','   string jdtogregorian (int julianday)');
INSERT INTO "php_manual" VALUES (81,'GregorianToJD','  Converts a Gregorian date to Julian Day Count','   int gregoriantojd (int month, int day, int year)');
INSERT INTO "php_manual" VALUES (82,'JDToJulian','  Converts a Julian Day Count to a Julian Calendar Date','   string jdtojulian (int julianday)');
INSERT INTO "php_manual" VALUES (83,'JulianToJD','  Converts a Julian Calendar date to Julian Day Count','   int juliantojd (int month, int day, int year)');
INSERT INTO "php_manual" VALUES (84,'JDToJewish','  Converts a Julian Day Count to the Jewish Calendar','   string jdtojewish (int julianday)');
INSERT INTO "php_manual" VALUES (85,'JewishToJD','  Converts a date in the Jewish Calendar to Julian Day','   int jewishtojd (int month, int day, int year)');
INSERT INTO "php_manual" VALUES (86,'JDToFrench','  Converts a Julian Day Count to the French Republican','   string jdtofrench (int juliandaycount)');
INSERT INTO "php_manual" VALUES (87,'FrenchToJD','  Converts a date from the French Republican Calendar to','   int frenchtojd (int month, int day, int year)');
INSERT INTO "php_manual" VALUES (88,'JDMonthName',' Returns a month name','   string jdmonthname (int julianday, int mode)');
INSERT INTO "php_manual" VALUES (89,'JDDayOfWeek',' Returns the day of the week','   mixed jddayofweek (int julianday, int mode)');
INSERT INTO "php_manual" VALUES (90,'easter_date','  Get UNIX timestamp for midnight on Easter of a given','   int easter_date (int year)');
INSERT INTO "php_manual" VALUES (91,'easter_days','  Get number of days after March 21 on which Easter','   int easter_days (int year)');
INSERT INTO "php_manual" VALUES (92,'unixtojd',' Convert UNIX timestamp to Julian Day','   int unixtojd ([int timestamp])');
INSERT INTO "php_manual" VALUES (93,'jdtounix',' Convert Julian Day to UNIX timestamp','   int jdtounix (int jday)');
INSERT INTO "php_manual" VALUES (94,'com_load','  Creates a new reference to a COM component','   string com_load (string module name [, string server name])');
INSERT INTO "php_manual" VALUES (95,'com_invoke','  Calls a COM component\'s method.','   mixed com_invoke (resource com_object, string function_name [, mixed');
INSERT INTO "php_manual" VALUES (96,'com_propget','  Gets the value of a COM Component\'s property','   mixed com_propget (resource com_object, string property)');
INSERT INTO "php_manual" VALUES (97,'com_get','  Gets the value of a COM Component\'s property','   mixed com_get (resource com_object, string property)');
INSERT INTO "php_manual" VALUES (98,'com_propput','  Assigns a value to a COM component\'s property','   void com_propput (resource com_object, string property, mixed value)');
INSERT INTO "php_manual" VALUES (99,'com_propset','  Assigns a value to a COM component\'s property','   void com_propset (resource com_object, string property, mixed value)');
INSERT INTO "php_manual" VALUES (100,'com_set','  Assigns a value to a COM component\'s property','   void com_set (resource com_object, string property, mixed value)');
INSERT INTO "php_manual" VALUES (101,'call_user_method_array','  Call a user method given with an array of','   mixed call_user_method_array (string method_name, object obj [, array');
INSERT INTO "php_manual" VALUES (102,'call_user_method','  Call a user method on an specific object','   mixed call_user_method (string method_name, object obj [, mixed');
INSERT INTO "php_manual" VALUES (103,'class_exists',' Checks if the class has been defined','   bool class_exists (string class_name)');
INSERT INTO "php_manual" VALUES (104,'get_class',' Returns the name of the class of an object','   string get_class (object obj)');
INSERT INTO "php_manual" VALUES (105,'get_class_methods',' Returns an array of class methods\' names','   array get_class_methods (string class_name)');
INSERT INTO "php_manual" VALUES (106,'get_class_vars','  Returns an array of DEFAULT properties of the class','   array get_class_vars (string class_name)');
INSERT INTO "php_manual" VALUES (107,'get_declared_classes',' Returns an array with the name of the defined','   array get_declared_classes (void)');
INSERT INTO "php_manual" VALUES (108,'get_object_vars',' Returns an associative array of object properties','   array get_object_vars (object obj)');
INSERT INTO "php_manual" VALUES (109,'get_parent_class',' Returns the name of the parent class of an object','   string get_parent_class (object obj)');
INSERT INTO "php_manual" VALUES (110,'is_subclass_of','  Determines if an object belongs to a subclass of','   bool is_subclass_of (object obj, string superclass)');
INSERT INTO "php_manual" VALUES (111,'method_exists',' Checks if the class method exists','   bool method_exists (object object, string method_name)');
INSERT INTO "php_manual" VALUES (112,'cpdf_global_set_document_limits',' Sets document limits for any pdf','   void cpdf_global_set_document_limits (int maxpages, int maxfonts, int');
INSERT INTO "php_manual" VALUES (113,'cpdf_set_creator',' Sets the creator field in the pdf document','   void cpdf_set_creator (string creator)');
INSERT INTO "php_manual" VALUES (114,'cpdf_set_title',' Sets the title field of the pdf document','   void cpdf_set_title (string title)');
INSERT INTO "php_manual" VALUES (115,'cpdf_set_subject',' Sets the subject field of the pdf document','   void cpdf_set_subject (string subject)');
INSERT INTO "php_manual" VALUES (116,'cpdf_set_keywords',' Sets the keywords field of the pdf document','   void cpdf_set_keywords (string keywords)');
INSERT INTO "php_manual" VALUES (117,'cpdf_open',' Opens a new pdf document','   int cpdf_open (int compression [, string filename])');
INSERT INTO "php_manual" VALUES (118,'cpdf_close',' Closes the pdf document','   void cpdf_close (int pdf document)');
INSERT INTO "php_manual" VALUES (119,'cpdf_page_init',' Starts new page','   void cpdf_page_init (int pdf document, int page number, int');
INSERT INTO "php_manual" VALUES (120,'cpdf_finalize_page',' Ends page','   void cpdf_finalize_page (int pdf document, int page number)');
INSERT INTO "php_manual" VALUES (121,'cpdf_finalize',' Ends document','   void cpdf_finalize (int pdf document)');
INSERT INTO "php_manual" VALUES (122,'cpdf_output_buffer',' Outputs the pdf document in memory buffer','   void cpdf_output_buffer (int pdf document)');
INSERT INTO "php_manual" VALUES (123,'cpdf_save_to_file',' Writes the pdf document into a file','   void cpdf_save_to_file (int pdf document, string filename)');
INSERT INTO "php_manual" VALUES (124,'cpdf_set_current_page',' Sets current page','   void cpdf_set_current_page (int pdf document, int page number)');
INSERT INTO "php_manual" VALUES (125,'cpdf_begin_text',' Starts text section','   void cpdf_begin_text (int pdf document)');
INSERT INTO "php_manual" VALUES (126,'cpdf_end_text',' Ends text section','   void cpdf_end_text (int pdf document)');
INSERT INTO "php_manual" VALUES (127,'cpdf_show',' Output text at current position','   void cpdf_show (int pdf document, string text)');
INSERT INTO "php_manual" VALUES (128,'cpdf_show_xy',' Output text at position','   void cpdf_show_xy (int pdf document, string text, FLOAT8x-coor,');
INSERT INTO "php_manual" VALUES (129,'cpdf_text',' Output text with parameters','   void cpdf_text (int pdf document, string text, FLOAT8x-coor, double');
INSERT INTO "php_manual" VALUES (130,'cpdf_set_font',' Select the current font face and size','   void cpdf_set_font (int pdf document, string font name, FLOAT8size,');
INSERT INTO "php_manual" VALUES (131,'cpdf_set_leading',' Sets distance between text lines','   void cpdf_set leading (int pdf document, FLOAT8distance)');
INSERT INTO "php_manual" VALUES (132,'cpdf_set_text_rendering',' Determines how text is rendered','   void cpdf_set_text_rendering (int pdf document, int mode)');
INSERT INTO "php_manual" VALUES (133,'cpdf_set_horiz_scaling',' Sets horizontal scaling of text','   void cpdf_set_horiz_scaling (int pdf document, FLOAT8scale)');
INSERT INTO "php_manual" VALUES (134,'cpdf_set_text_rise',' Sets the text rise','   void cpdf_set_text_rise (int pdf document, FLOAT8value)');
INSERT INTO "php_manual" VALUES (135,'cpdf_set_text_matrix',' Sets the text matrix','   void cpdf_set_text_matrix (int pdf document, array matrix)');
INSERT INTO "php_manual" VALUES (136,'cpdf_set_text_pos',' Sets text position','   void cpdf_set_text_pos (int pdf document, FLOAT8x-coor, double y-coor');
INSERT INTO "php_manual" VALUES (137,'cpdf_set_char_spacing',' Sets character spacing','   void cpdf_set_char_spacing (int pdf document, FLOAT8space)');
INSERT INTO "php_manual" VALUES (138,'cpdf_set_word_spacing',' Sets spacing between words','   void cpdf_set_word_spacing (int pdf document, FLOAT8space)');
INSERT INTO "php_manual" VALUES (139,'cpdf_continue_text',' Output text in next line','   void cpdf_continue_text (int pdf document, string text)');
INSERT INTO "php_manual" VALUES (140,'cpdf_stringwidth',' Returns width of text in current font','   FLOAT8cpdf_stringwidth (int pdf document, string text)');
INSERT INTO "php_manual" VALUES (141,'cpdf_save',' Saves current enviroment','   void cpdf_save (int pdf document)');
INSERT INTO "php_manual" VALUES (142,'cpdf_restore',' Restores formerly saved enviroment','   void cpdf_restore (int pdf document)');
INSERT INTO "php_manual" VALUES (143,'cpdf_translate',' Sets origin of coordinate system','   void cpdf_translate (int pdf document, FLOAT8x-coor, double y-coor [,');
INSERT INTO "php_manual" VALUES (144,'cpdf_scale',' Sets scaling','   void cpdf_scale (int pdf document, FLOAT8x-scale, double y-scale)');
INSERT INTO "php_manual" VALUES (145,'cpdf_rotate',' Sets rotation','   void cpdf_rotate (int pdf document, FLOAT8angle)');
INSERT INTO "php_manual" VALUES (146,'cpdf_setflat',' Sets flatness','   void cpdf_setflat (int pdf document, FLOAT8value)');
INSERT INTO "php_manual" VALUES (147,'cpdf_setlinejoin',' Sets linejoin parameter','   void cpdf_setlinejoin (int pdf document, long value)');
INSERT INTO "php_manual" VALUES (148,'cpdf_setlinecap',' Sets linecap parameter','   void cpdf_setlinecap (int pdf document, int value)');
INSERT INTO "php_manual" VALUES (149,'cpdf_setmiterlimit',' Sets miter limit','   void cpdf_setmiterlimit (int pdf document, FLOAT8value)');
INSERT INTO "php_manual" VALUES (150,'cpdf_setlinewidth',' Sets line width','   void cpdf_setlinewidth (int pdf document, FLOAT8width)');
INSERT INTO "php_manual" VALUES (151,'cpdf_setdash',' Sets dash pattern','   void cpdf_setdash (int pdf document, FLOAT8white, double black)');
INSERT INTO "php_manual" VALUES (152,'cpdf_newpath',' Starts a new path','   void cpdf_newpath (int pdf document)');
INSERT INTO "php_manual" VALUES (153,'cpdf_moveto',' Sets current point','   void cpdf_moveto (int pdf document, FLOAT8x-coor, double y-coor [,');
INSERT INTO "php_manual" VALUES (154,'cpdf_rmoveto',' Sets current point','   void cpdf_rmoveto (int pdf document, FLOAT8x-coor, double y-coor [,');
INSERT INTO "php_manual" VALUES (155,'cpdf_curveto',' Draws a curve','   void cpdf_curveto (int pdf document, FLOAT8x1, double y1, double x2,');
INSERT INTO "php_manual" VALUES (156,'cpdf_lineto',' Draws a line','   void cpdf_lineto (int pdf document, FLOAT8x-coor, double y-coor [,');
INSERT INTO "php_manual" VALUES (157,'cpdf_rlineto',' Draws a line','   void cpdf_rlineto (int pdf document, FLOAT8x-coor, double y-coor [,');
INSERT INTO "php_manual" VALUES (158,'cpdf_circle',' Draw a circle','   void cpdf_circle (int pdf document, FLOAT8x-coor, double y-coor,');
INSERT INTO "php_manual" VALUES (159,'cpdf_arc',' Draws an arc','   void cpdf_arc (int pdf document, FLOAT8x-coor, double y-coor, double');
INSERT INTO "php_manual" VALUES (160,'cpdf_rect',' Draw a rectangle','   void cpdf_rect (int pdf document, FLOAT8x-coor, double y-coor, double');
INSERT INTO "php_manual" VALUES (161,'cpdf_closepath',' Close path','   void cpdf_closepath (int pdf document)');
INSERT INTO "php_manual" VALUES (162,'cpdf_stroke',' Draw line along path','   void cpdf_stroke (int pdf document)');
INSERT INTO "php_manual" VALUES (163,'cpdf_closepath_stroke',' Close path and draw line along path','   void cpdf_closepath_stroke (int pdf document)');
INSERT INTO "php_manual" VALUES (164,'cpdf_fill',' Fill current path','   void cpdf_fill (int pdf document)');
INSERT INTO "php_manual" VALUES (165,'cpdf_fill_stroke',' Fill and stroke current path','   void cpdf_fill_stroke (int pdf document)');
INSERT INTO "php_manual" VALUES (166,'cpdf_closepath_fill_stroke',' Close, fill and stroke current path','   void cpdf_closepath_fill_stroke (int pdf document)');
INSERT INTO "php_manual" VALUES (167,'cpdf_clip',' Clips to current path','   void cpdf_clip (int pdf document)');
INSERT INTO "php_manual" VALUES (168,'cpdf_setgray_fill',' Sets filling color to gray value','   void cpdf_setgray_fill (int pdf document, FLOAT8value)');
INSERT INTO "php_manual" VALUES (169,'cpdf_setgray_stroke',' Sets drawing color to gray value','   void cpdf_setgray_stroke (int pdf document, FLOAT8gray value)');
INSERT INTO "php_manual" VALUES (170,'cpdf_setgray',' Sets drawing and filling color to gray value','   void cpdf_setgray (int pdf document, FLOAT8gray value)');
INSERT INTO "php_manual" VALUES (171,'cpdf_setrgbcolor_fill',' Sets filling color to rgb color value','   void cpdf_setrgbcolor_fill (int pdf document, FLOAT8red value, double');
INSERT INTO "php_manual" VALUES (172,'cpdf_setrgbcolor_stroke',' Sets drawing color to rgb color value','   void cpdf_setrgbcolor_stroke (int pdf document, FLOAT8red value,');
INSERT INTO "php_manual" VALUES (173,'cpdf_setrgbcolor',' Sets drawing and filling color to rgb color value','   void cpdf_setrgbcolor (int pdf document, FLOAT8red value, double');
INSERT INTO "php_manual" VALUES (174,'cpdf_add_outline',' Adds bookmark for current page','   void cpdf_add_outline (int pdf document, string text)');
INSERT INTO "php_manual" VALUES (175,'cpdf_set_page_animation',' Sets duration between pages','   void cpdf_set_page_animation (int pdf document, int transition, FLOAT8);
INSERT INTO "php_manual" VALUES (176,'cpdf_import_jpeg',' Opens a JPEG image','   int cpdf_import_jpeg (int pdf document, string file name, FLOAT8);
INSERT INTO "php_manual" VALUES (177,'cpdf_place_inline_image',' Places an image on the page','   void cpdf_place_inline_image (int pdf document, int image, FLOAT8);
INSERT INTO "php_manual" VALUES (178,'cpdf_add_annotation',' Adds annotation','   void cpdf_add_annotation (int pdf document, FLOAT8llx, double lly,');
INSERT INTO "php_manual" VALUES (179,'curl_init',' Initialize a CURL session','   int curl_init ([string url])');
INSERT INTO "php_manual" VALUES (180,'curl_setopt',' Set an option for a CURL transfer','   bool curl_setopt (int ch, string option, mixed value)');
INSERT INTO "php_manual" VALUES (181,'curl_exec',' Perform a CURL session','   bool curl_exec (int ch)');
INSERT INTO "php_manual" VALUES (182,'curl_close',' Close a CURL session','   void curl_close (int ch)');
INSERT INTO "php_manual" VALUES (183,'curl_version',' Return the current CURL version','   string curl_version (void);');
INSERT INTO "php_manual" VALUES (184,'cybercash_encr',' ???','   array cybercash_encr (string wmk, string sk, string inbuff)');
INSERT INTO "php_manual" VALUES (185,'cybercash_decr',' ???','   array cybercash_decr (string wmk, string sk, string inbuff)');
INSERT INTO "php_manual" VALUES (186,'cybercash_base64_encode',' ???','   string cybercash_base64_encode (string inbuff)');
INSERT INTO "php_manual" VALUES (187,'cybercash_base64_decode','','   string cybercash_base64_decode (string inbuff)');
INSERT INTO "php_manual" VALUES (188,'ctype_alnum',' Check for alphanumeric character(s)','   bool ctype_alnum (string c)');
INSERT INTO "php_manual" VALUES (189,'ctype_alpha',' Check for alphabetic character(s)','   bool ctype_alpha (string c)');
INSERT INTO "php_manual" VALUES (190,'ctype_cntrl',' Check for control character(s)','   bool ctype_cntrl (string c)');
INSERT INTO "php_manual" VALUES (191,'ctype_digit',' Check for numeric character(s)','   bool ctype_digit (string c)');
INSERT INTO "php_manual" VALUES (192,'ctype_lower',' Check for lowercase character(s)','   bool ctype_lower (string c)');
INSERT INTO "php_manual" VALUES (193,'ctype_graph',' Check for any printable character(s) except space','   bool ctype_graph (string c)');
INSERT INTO "php_manual" VALUES (194,'ctype_print',' Check for printable character(s)','   bool ctype_print (string c)');
INSERT INTO "php_manual" VALUES (195,'ctype_punct','  Check for any printable character which is not','   bool ctype_punct (string c)');
INSERT INTO "php_manual" VALUES (196,'ctype_space',' Check for whitespace character(s)','   bool ctype_space (string c)');
INSERT INTO "php_manual" VALUES (197,'ctype_upper',' Check for uppercase character(s)','   bool ctype_upper (string c)');
INSERT INTO "php_manual" VALUES (198,'ctype_xdigit','  Check for character(s) representing a hexadecimal','   bool ctype_xdigit (string c)');
INSERT INTO "php_manual" VALUES (199,'dba_close',' Close database','   void dba_close (int handle)');
INSERT INTO "php_manual" VALUES (200,'dba_delete',' Delete entry specified by key','   string dba_delete (string key, int handle)');
INSERT INTO "php_manual" VALUES (201,'dba_exists',' Check whether key exists','   bool dba_exists (string key, int handle)');
INSERT INTO "php_manual" VALUES (202,'dba_fetch',' Fetch data specified by key','   string dba_fetch (string key, int handle)');
INSERT INTO "php_manual" VALUES (203,'dba_firstkey',' Fetch first key','   string dba_firstkey (int handle)');
INSERT INTO "php_manual" VALUES (204,'dba_insert',' Insert entry','   bool dba_insert (string key, string value, int handle)');
INSERT INTO "php_manual" VALUES (205,'dba_nextkey',' Fetch next key','   string dba_nextkey (int handle)');
INSERT INTO "php_manual" VALUES (206,'dba_popen',' Open database persistently','   int dba_popen (string path, string mode, string handler [, ...])');
INSERT INTO "php_manual" VALUES (207,'dba_open',' Open database','   int dba_open (string path, string mode, string handler [, ...])');
INSERT INTO "php_manual" VALUES (208,'dba_optimize',' Optimize database','   bool dba_optimize (int handle)');
INSERT INTO "php_manual" VALUES (209,'dba_replace',' Replace or insert entry','   bool dba_replace (string key, string value, int handle)');
INSERT INTO "php_manual" VALUES (210,'dba_sync',' Synchronize database','   bool dba_sync (int handle)');
INSERT INTO "php_manual" VALUES (211,'checkdate',' Validate a gregorian date/time','   int checkdate (int month, int day, int year)');
INSERT INTO "php_manual" VALUES (212,'date',' Format a local time/date','   string date (string format [, int timestamp])');
INSERT INTO "php_manual" VALUES (213,'getdate',' Get date/time information','   array getdate ([int timestamp])');
INSERT INTO "php_manual" VALUES (214,'gettimeofday',' Get current time','   array gettimeofday (void)');
INSERT INTO "php_manual" VALUES (215,'gmdate',' Format a GMT/CUT date/time','   string gmdate (string format [, int timestamp])');
INSERT INTO "php_manual" VALUES (216,'gmmktime',' Get UNIX timestamp for a GMT date','   int gmmktime (int hour, int minute, int second, int month, int day,');
INSERT INTO "php_manual" VALUES (217,'gmstrftime','  Format a GMT/CUT time/date according to locale settings','   string gmstrftime (string format [, int timestamp])');
INSERT INTO "php_manual" VALUES (218,'localtime',' Get the local time','   array localtime ([int timestamp [, bool is_associative]])');
INSERT INTO "php_manual" VALUES (219,'microtime','  Return current UNIX timestamp with microseconds','   string microtime(void);');
INSERT INTO "php_manual" VALUES (220,'mktime',' Get UNIX timestamp for a date','   int mktime (int hour, int minute, int second, int month, int day, int');
INSERT INTO "php_manual" VALUES (221,'strftime','  Format a local time/date according to locale settings','   string strftime (string format [, int timestamp])');
INSERT INTO "php_manual" VALUES (222,'time',' Return current UNIX timestamp','   int time(void);');
INSERT INTO "php_manual" VALUES (223,'strtotime','  Parse about any english textual TIMESTAMP description','   int strtotime (string time [, int now])');
INSERT INTO "php_manual" VALUES (224,'dbase_create',' Creates a dBase database','   int dbase_create (string filename, array fields)');
INSERT INTO "php_manual" VALUES (225,'dbase_open',' Opens a dBase database','   int dbase_open (string filename, int flags)');
INSERT INTO "php_manual" VALUES (226,'dbase_close',' Close a dBase database','   bool dbase_close (int dbase_identifier)');
INSERT INTO "php_manual" VALUES (227,'dbase_pack',' Packs a dBase database','   bool dbase_pack (int dbase_identifier)');
INSERT INTO "php_manual" VALUES (228,'dbase_add_record',' Add a record to a dBase database','   bool dbase_add_record (int dbase_identifier, array record)');
INSERT INTO "php_manual" VALUES (229,'dbase_replace_record',' Replace a record in a dBase database','   bool dbase_replace_record (int dbase_identifier, array record, int');
INSERT INTO "php_manual" VALUES (230,'dbase_delete_record',' Deletes a record from a dBase database','   bool dbase_delete_record (int dbase_identifier, int record)');
INSERT INTO "php_manual" VALUES (231,'dbase_get_record',' Gets a record from a dBase database','   array dbase_get_record (int dbase_identifier, int record)');
INSERT INTO "php_manual" VALUES (232,'dbase_get_record_with_names','  Gets a record from a dBase database as','   array dbase_get_record_with_names (int dbase_identifier, int record)');
INSERT INTO "php_manual" VALUES (233,'dbase_numfields','  Find out how many fields are in a dBase database','   int dbase_numfields (int dbase_identifier)');
INSERT INTO "php_manual" VALUES (234,'dbase_numrecords','  Find out how many records are in a dBase database','   int dbase_numrecords (int dbase_identifier)');
INSERT INTO "php_manual" VALUES (235,'dbmopen',' Opens a DBM database','   int dbmopen (string filename, string flags)');
INSERT INTO "php_manual" VALUES (236,'dbmclose',' Closes a dbm database','   bool dbmclose (int dbm_identifier)');
INSERT INTO "php_manual" VALUES (237,'dbmexists','  Tells if a value exists for a key in a DBM database','   bool dbmexists (int dbm_identifier, string key)');
INSERT INTO "php_manual" VALUES (238,'dbmfetch','  Fetches a value for a key from a DBM database','   string dbmfetch (int dbm_identifier, string key)');
INSERT INTO "php_manual" VALUES (239,'dbminsert','  Inserts a value for a key in a DBM database','   int dbminsert (int dbm_identifier, string key, string value)');
INSERT INTO "php_manual" VALUES (240,'dbmreplace','  Replaces the value for a key in a DBM database','   bool dbmreplace (int dbm_identifier, string key, string value)');
INSERT INTO "php_manual" VALUES (241,'dbmdelete','  Deletes the value for a key from a DBM database','   bool dbmdelete (int dbm_identifier, string key)');
INSERT INTO "php_manual" VALUES (242,'dbmfirstkey','  Retrieves the first key from a DBM database','   string dbmfirstkey (int dbm_identifier)');
INSERT INTO "php_manual" VALUES (243,'dbmnextkey','  Retrieves the next key from a DBM database','   string dbmnextkey (int dbm_identifier, string key)');
INSERT INTO "php_manual" VALUES (244,'dblist','  Describes the DBM-compatible library being used','   string dblist (void)');
INSERT INTO "php_manual" VALUES (245,'chroot',' change the root directory','   int chroot (string directory)');
INSERT INTO "php_manual" VALUES (246,'chdir',' change directory','   int chdir (string directory)');
INSERT INTO "php_manual" VALUES (247,'dir',' directory class','   new dir (string directory)');
INSERT INTO "php_manual" VALUES (248,'closedir',' close directory handle','   void closedir (int dir_handle)');
INSERT INTO "php_manual" VALUES (249,'getcwd',' gets the current working directory','   string getcwd(void);');
INSERT INTO "php_manual" VALUES (250,'opendir',' open directory handle','   int opendir (string path)');
INSERT INTO "php_manual" VALUES (251,'readdir',' read entry from directory handle','   string readdir (int dir_handle)');
INSERT INTO "php_manual" VALUES (252,'rewinddir',' rewind directory handle','   void rewinddir (int dir_handle)');
INSERT INTO "php_manual" VALUES (253,'xmldoc',' Creates a DOM object of an XML document','   object xmldoc (string str)');
INSERT INTO "php_manual" VALUES (254,'xmldocfile',' Creates a DOM object from XML file','   object xmldocfile (string filename)');
INSERT INTO "php_manual" VALUES (255,'xmltree','  Creates a tree of php objects from XML document','   object xmltree (string str)');
INSERT INTO "php_manual" VALUES (256,'domxml_root','  Returns root element node','   object domxml_root (array doc)');
INSERT INTO "php_manual" VALUES (257,'domxml_add_root','  Adds a further root node','   resource domxml_add_root (resource doc, string name)');
INSERT INTO "php_manual" VALUES (258,'domxml_dumpmem','  Dumps the internal XML tree back into a string','   string domxml_dumpmem (resource doc)');
INSERT INTO "php_manual" VALUES (259,'domxml_attributes','  Returns an array of attributes of a node','   array domxml_attributes (resource node)');
INSERT INTO "php_manual" VALUES (260,'domxml_get_attribute','  Returns a certain attribute of a node','   object domxml_get_attribute (resource node, string name)');
INSERT INTO "php_manual" VALUES (261,'domxml_set_attribute','','   object domxml_set_attribute (resource node, string name, string value)');
INSERT INTO "php_manual" VALUES (262,'domxml_children','  Returns children of a node or document','   array domxml_children (object doc|node)');
INSERT INTO "php_manual" VALUES (263,'domxml_new_child','  Adds new child node','   resource domxml_new_child (string name, string content)');
INSERT INTO "php_manual" VALUES (264,'domxml_new_xmldoc','  Creates new empty XML document','   object domxml_new_xmldoc (string version)');
INSERT INTO "php_manual" VALUES (265,'xpath_new_context','  Creates new xpath context','   object xpath_new_context (object dom document)');
INSERT INTO "php_manual" VALUES (266,'xpath_eval','  Evaluates an xpath expression','   array xpath_eval (object xpath context)');
INSERT INTO "php_manual" VALUES (267,'error_log',' send an error message somewhere','   int error_log (string message, int message_type [, string destination');
INSERT INTO "php_manual" VALUES (268,'error_reporting',' set which PHP errors are reported','   int error_reporting ([int level])');
INSERT INTO "php_manual" VALUES (269,'restore_error_handler','  Restores the previous error handler function','   void restore_error_handler (void)');
INSERT INTO "php_manual" VALUES (270,'set_error_handler','  Sets a user-defined error handler function.','   string set_error_handler (string error_handler)');
INSERT INTO "php_manual" VALUES (271,'trigger_error','  Generates a user-level error/warning/notice message','   void trigger_error (string error_msg [, int error_type])');
INSERT INTO "php_manual" VALUES (272,'user_error','  Generates a user-level error/warning/notice message','   void user_error (string error_msg [, int error_type])');
INSERT INTO "php_manual" VALUES (273,'filepro',' read and verify the map file','   bool filepro (string directory)');
INSERT INTO "php_manual" VALUES (274,'filepro_fieldname',' gets the name of a field','   string filepro_fieldname (int field_number)');
INSERT INTO "php_manual" VALUES (275,'filepro_fieldtype',' gets the type of a field','   string filepro_fieldtype (int field_number)');
INSERT INTO "php_manual" VALUES (276,'filepro_fieldwidth',' gets the width of a field','   int filepro_fieldwidth (int field_number)');
INSERT INTO "php_manual" VALUES (277,'filepro_retrieve',' retrieves data from a filePro database','   string filepro_retrieve (int row_number, int field_number)');
INSERT INTO "php_manual" VALUES (278,'filepro_fieldcount',' find out how many fields are in a filePro','   int filepro_fieldcount(void);');
INSERT INTO "php_manual" VALUES (279,'filepro_rowcount',' find out how many rows are in a filePro database','   int filepro_rowcount(void);');
INSERT INTO "php_manual" VALUES (280,'basename','  Returns filename component of path','   string basename (string path)');
INSERT INTO "php_manual" VALUES (281,'chgrp',' Changes file group','   int chgrp (string filename, mixed group)');
INSERT INTO "php_manual" VALUES (282,'chmod',' Changes file mode','   int chmod (string filename, int mode)');
INSERT INTO "php_manual" VALUES (283,'chown',' Changes file owner','   int chown (string filename, mixed user)');
INSERT INTO "php_manual" VALUES (284,'clearstatcache',' Clears file stat cache','   void clearstatcache(void);');
INSERT INTO "php_manual" VALUES (285,'copy',' Copies file','   int copy (string source, string dest)');
INSERT INTO "php_manual" VALUES (286,'delete',' A dummy manual entry','   void delete (string file)');
INSERT INTO "php_manual" VALUES (287,'dirname',' Returns directory name component of path','   string dirname (string path)');
INSERT INTO "php_manual" VALUES (288,'diskfreespace',' Returns available space in directory','   float diskfreespace (string directory)');
INSERT INTO "php_manual" VALUES (289,'fclose',' Closes an open file pointer','   int fclose (int fp)');
INSERT INTO "php_manual" VALUES (290,'feof',' Tests for end-of-file on a file pointer','   int feof (int fp)');
INSERT INTO "php_manual" VALUES (291,'fflush',' Flushes the output to a file','   int fflush (int fp)');
INSERT INTO "php_manual" VALUES (292,'fgetc',' Gets character from file pointer','   string fgetc (int fp)');
INSERT INTO "php_manual" VALUES (293,'fgetcsv','  Gets line from file pointer and parse for CSV fields','   array fgetcsv (int fp, int length [, string delimiter])');
INSERT INTO "php_manual" VALUES (294,'fgets',' Gets line from file pointer','   string fgets (int fp, int length)');
INSERT INTO "php_manual" VALUES (295,'fgetss','  Gets line from file pointer and strip HTML tags','   string fgetss (int fp, int length [, string allowable_tags])');
INSERT INTO "php_manual" VALUES (296,'file',' Reads entire file into an array','   array file (string filename [, int use_include_path])');
INSERT INTO "php_manual" VALUES (297,'file_exists',' Checks whether a file exists','   bool file_exists (string filename)');
INSERT INTO "php_manual" VALUES (298,'fileatime',' Gets last access time of file','   int fileatime (string filename)');
INSERT INTO "php_manual" VALUES (299,'filectime',' Gets inode change time of file','   int filectime (string filename)');
INSERT INTO "php_manual" VALUES (300,'filegroup',' Gets file group','   int filegroup (string filename)');
INSERT INTO "php_manual" VALUES (301,'fileinode',' Gets file inode','   int fileinode (string filename)');
INSERT INTO "php_manual" VALUES (302,'filemtime',' Gets file modification time','   int filemtime (string filename)');
INSERT INTO "php_manual" VALUES (303,'fileowner',' Gets file owner','   int fileowner (string filename)');
INSERT INTO "php_manual" VALUES (304,'fileperms',' Gets file permissions','   int fileperms (string filename)');
INSERT INTO "php_manual" VALUES (305,'filesize',' Gets file size','   int filesize (string filename)');
INSERT INTO "php_manual" VALUES (306,'filetype',' Gets file type','   string filetype (string filename)');
INSERT INTO "php_manual" VALUES (307,'flock',' Portable advisory file locking','   bool flock (int fp, int operation [, int wouldblock])');
INSERT INTO "php_manual" VALUES (308,'fopen',' Opens file or URL','   int fopen (string filename, string mode [, int use_include_path])');
INSERT INTO "php_manual" VALUES (309,'fpassthru','  Output all remaining data on a file pointer','   int fpassthru (int fp)');
INSERT INTO "php_manual" VALUES (310,'fputs',' Writes to a file pointer','   int fputs (int fp, string str [, int length])');
INSERT INTO "php_manual" VALUES (311,'fread',' Binary-safe file read','   string fread (int fp, int length)');
INSERT INTO "php_manual" VALUES (312,'fscanf',' Parses input from a file according to a format','   mixed fscanf (int handle, string format [, string var1...])');
INSERT INTO "php_manual" VALUES (313,'fseek',' Seeks on a file pointer','   int fseek (int fp, int offset [, int whence])');
INSERT INTO "php_manual" VALUES (314,'fstat','  Gets information about a file using an open file pointer','   array fstat (int fp)');
INSERT INTO "php_manual" VALUES (315,'ftell',' Tells file pointer read/write position','   int ftell (int fp)');
INSERT INTO "php_manual" VALUES (316,'ftruncate','  Truncates a file to a given length.','   int ftruncate (int fp, int size)');
INSERT INTO "php_manual" VALUES (317,'fwrite',' Binary-safe file write','   int fwrite (int fp, string string [, int length])');
INSERT INTO "php_manual" VALUES (318,'set_file_buffer','  Sets file buffering on the given file pointer','   int set_file_buffer (int fp, int buffer)');
INSERT INTO "php_manual" VALUES (319,'is_dir',' Tells whether the filename is a directory','   bool is_dir (string filename)');
INSERT INTO "php_manual" VALUES (320,'is_executable',' Tells whether the filename is executable','   bool is_executable (string filename)');
INSERT INTO "php_manual" VALUES (321,'is_file','  Tells whether the filename is a regular file','   bool is_file (string filename)');
INSERT INTO "php_manual" VALUES (322,'is_link','  Tells whether the filename is a symbolic link','   bool is_link (string filename)');
INSERT INTO "php_manual" VALUES (323,'is_readable','  Tells whether the filename is readable','   bool is_readable (string filename)');
INSERT INTO "php_manual" VALUES (324,'is_writable',' Tells whether the filename is writable','   bool is_writable (string filename)');
INSERT INTO "php_manual" VALUES (325,'is_writeable',' Tells whether the filename is writable','   bool is_writeable (string filename)');
INSERT INTO "php_manual" VALUES (326,'is_uploaded_file',' Tells whether the file was uploaded via HTTP POST.','   bool is_uploaded_file (string filename)');
INSERT INTO "php_manual" VALUES (327,'link',' Create a hard link','   int link (string target, string link)');
INSERT INTO "php_manual" VALUES (328,'linkinfo',' Gets information about a link','   int linkinfo (string path)');
INSERT INTO "php_manual" VALUES (329,'mkdir',' Makes directory','   int mkdir (string pathname, int mode)');
INSERT INTO "php_manual" VALUES (330,'move_uploaded_file',' Moves an uploaded file to a new location.','   bool move_uploaded_file (string filename, string destination)');
INSERT INTO "php_manual" VALUES (331,'pclose',' Closes process file pointer','   int pclose (int fp)');
INSERT INTO "php_manual" VALUES (332,'popen',' Opens process file pointer','   int popen (string command, string mode)');
INSERT INTO "php_manual" VALUES (333,'readfile',' Outputs a file','   int readfile (string filename [, int use_include_path])');
INSERT INTO "php_manual" VALUES (334,'readlink',' Returns the target of a symbolic link','   string readlink (string path)');
INSERT INTO "php_manual" VALUES (335,'rename',' Renames a file','   int rename (string oldname, string newname)');
INSERT INTO "php_manual" VALUES (336,'rewind',' Rewind the position of a file pointer','   int rewind (int fp)');
INSERT INTO "php_manual" VALUES (337,'rmdir',' Removes directory','   int rmdir (string dirname)');
INSERT INTO "php_manual" VALUES (338,'stat',' Gives information about a file','   array stat (string filename)');
INSERT INTO "php_manual" VALUES (339,'lstat','  Gives information about a file or symbolic link','   array lstat (string filename)');
INSERT INTO "php_manual" VALUES (340,'realpath',' Returns canonicalized absolute pathname','   string realpath (string path)');
INSERT INTO "php_manual" VALUES (341,'symlink',' Creates a symbolic link','   int symlink (string target, string link)');
INSERT INTO "php_manual" VALUES (342,'tempnam',' Creates unique file name','   string tempnam (string dir, string prefix)');
INSERT INTO "php_manual" VALUES (343,'tmpfile',' Creates a temporary file','   int tmpfile (void)');
INSERT INTO "php_manual" VALUES (344,'touch',' Sets modification time of file','   int touch (string filename [, int time])');
INSERT INTO "php_manual" VALUES (345,'umask',' Changes the current umask','   int umask (int mask)');
INSERT INTO "php_manual" VALUES (346,'unlink',' Deletes a file','   int unlink (string filename)');
INSERT INTO "php_manual" VALUES (347,'fdf_open',' Open a FDF document','   int fdf_open (string filename)');
INSERT INTO "php_manual" VALUES (348,'fdf_close',' Close an FDF document','   boolean fdf_close (int fdf_document)');
INSERT INTO "php_manual" VALUES (349,'fdf_create',' Create a new FDF document','   int fdf_create (void )');
INSERT INTO "php_manual" VALUES (350,'fdf_save',' Save a FDF document','   int fdf_save (string filename)');
INSERT INTO "php_manual" VALUES (351,'fdf_get_value',' Get the value of a field','   string fdf_get_value (int fdf_document, string fieldname)');
INSERT INTO "php_manual" VALUES (352,'fdf_set_value',' Set the value of a field','   boolean fdf_set_value (int fdf_document, string fieldname, string');
INSERT INTO "php_manual" VALUES (353,'fdf_next_field_name',' Get the next field name','   string fdf_next_field_name (int fdf_document, string fieldname)');
INSERT INTO "php_manual" VALUES (354,'fdf_set_ap',' Set the appearance of a field','   boolean fdf_set_ap (int fdf_document, string field_name, int face,');
INSERT INTO "php_manual" VALUES (355,'fdf_set_status',' Set the value of the /STATUS key','   boolean fdf_set_status (int fdf_document, string status)');
INSERT INTO "php_manual" VALUES (356,'fdf_get_status',' Get the value of the /STATUS key','   string fdf_get_status (int fdf_document)');
INSERT INTO "php_manual" VALUES (357,'fdf_set_file',' Set the value of the /F key','   boolean fdf_set_file (int fdf_document, string filename)');
INSERT INTO "php_manual" VALUES (358,'fdf_get_file',' Get the value of the /F key','   string fdf_get_file (int fdf_document)');
INSERT INTO "php_manual" VALUES (359,'fdf_set_flags',' Sets a flag of a field','   boolean fdf_set_flags (int fdf_document, string fieldname, int');
INSERT INTO "php_manual" VALUES (360,'fdf_set_opt',' Sets an option of a field','   boolean fdf_set_opt (int fdf_document, string fieldname, int element,');
INSERT INTO "php_manual" VALUES (361,'fdf_set_submit_form_action',' Sets an javascript action of a field','   boolean fdf_set_submit_form_action (int fdf_document, string');
INSERT INTO "php_manual" VALUES (362,'fdf_set_javascript_action',' Sets an javascript action of a field','   boolean fdf_set_javascript_action (int fdf_document, string fieldname,');
INSERT INTO "php_manual" VALUES (363,'ftp_connect',' Opens up an FTP connection','   int ftp_connect (string host [, int port])');
INSERT INTO "php_manual" VALUES (364,'ftp_login',' Logs in an FTP connection','   int ftp_login (int ftp_stream, string username, string password)');
INSERT INTO "php_manual" VALUES (365,'ftp_pwd',' Returns the current directory name','   string ftp_pwd (int ftp_stream)');
INSERT INTO "php_manual" VALUES (366,'ftp_cdup',' Changes to the parent directory','   int ftp_cdup (int ftp_stream)');
INSERT INTO "php_manual" VALUES (367,'ftp_chdir',' Changes directories on a FTP server','   int ftp_chdir (int ftp_stream, string directory)');
INSERT INTO "php_manual" VALUES (368,'ftp_mkdir',' Creates a directory','   string ftp_mkdir (int ftp_stream, string directory)');
INSERT INTO "php_manual" VALUES (369,'ftp_rmdir',' Removes a directory','   int ftp_rmdir (int ftp_stream, string directory)');
INSERT INTO "php_manual" VALUES (370,'ftp_nlist',' Returns a list of files in the given directory.','   array ftp_nlist (int ftp_stream, string directory)');
INSERT INTO "php_manual" VALUES (371,'ftp_rawlist','  Returns a detailed list of files in the given','   array ftp_rawlist (int ftp_stream, string directory)');
INSERT INTO "php_manual" VALUES (372,'ftp_systype','  Returns the system type identifier of the remote FTP','   string ftp_systype (int ftp_stream)');
INSERT INTO "php_manual" VALUES (373,'ftp_pasv',' Turns passive mode on or off.','   int ftp_pasv (int ftp_stream, int pasv)');
INSERT INTO "php_manual" VALUES (374,'ftp_get',' Downloads a file from the FTP server.','   int ftp_get (int ftp_stream, string local_file, string remote_file,');
INSERT INTO "php_manual" VALUES (375,'ftp_fget',' Downloads a file from the FTP server and saves to an open','   int ftp_fget (int ftp_stream, int fp, string remote_file, int mode)');
INSERT INTO "php_manual" VALUES (376,'ftp_put',' Uploads a file to the FTP server.','   int ftp_put (int ftp_stream, string remote_file, string local_file,');
INSERT INTO "php_manual" VALUES (377,'ftp_fput',' Uploads from an open file to the FTP server.','   int ftp_fput (int ftp_stream, string remote_file, int fp, int mode)');
INSERT INTO "php_manual" VALUES (378,'ftp_size',' Returns the size of the given file.','   int ftp_size (int ftp_stream, string remote_file)');
INSERT INTO "php_manual" VALUES (379,'ftp_mdtm',' Returns the last modified time of the given file.','   int ftp_mdtm (int ftp_stream, string remote_file)');
INSERT INTO "php_manual" VALUES (380,'ftp_rename',' Renames a file on the ftp server.','   int ftp_rename (int ftp_stream, string from, string to)');
INSERT INTO "php_manual" VALUES (381,'ftp_delete',' Deletes a file on the ftp server.','   int ftp_delete (int ftp_stream, string path)');
INSERT INTO "php_manual" VALUES (382,'ftp_site',' Sends a SITE command to the server.','   int ftp_site (int ftp_stream, string cmd)');
INSERT INTO "php_manual" VALUES (383,'ftp_quit',' Closes an FTP connection','   int ftp_quit (int ftp_stream)');
INSERT INTO "php_manual" VALUES (384,'call_user_func_array','  Call a user function given with an array of','   mixed call_user_func_array (string function_name [, array paramarr])');
INSERT INTO "php_manual" VALUES (385,'call_user_func','  Call a user function given by the first parameter','   mixed call_user_func (string function_name [, mixed parameter [, mixed');
INSERT INTO "php_manual" VALUES (386,'create_function',' Create an anonymous (lambda-style) function','   string create_function (string args, string code)');
INSERT INTO "php_manual" VALUES (387,'func_get_arg',' Return an item from the argument list','   mixed func_get_arg (int arg_num)');
INSERT INTO "php_manual" VALUES (388,'func_get_args','  Returns an array comprising a function\'s argument','   array func_get_args (void )');
INSERT INTO "php_manual" VALUES (389,'func_num_args','  Returns the number of arguments passed to the','   int func_num_args (void )');
INSERT INTO "php_manual" VALUES (390,'function_exists','  Return true if the given function has been defined','   bool function_exists (string function_name)');
INSERT INTO "php_manual" VALUES (391,'get_defined_functions','  Returns an array of all defined functions','   array get_defined_functions (void )');
INSERT INTO "php_manual" VALUES (392,'register_shutdown_function','  Register a function for execution on','   int register_shutdown_function (string func)');
INSERT INTO "php_manual" VALUES (393,'bindtextdomain',' Sets the path for a domain','   string bindtextdomain (string domain, string directory)');
INSERT INTO "php_manual" VALUES (394,'dcgettext',' Overrides the domain for a single lookup','   string dcgettext (string domain, string message, int category)');
INSERT INTO "php_manual" VALUES (395,'dgettext',' Override the current domain','   string dgettext (string domain, string message)');
INSERT INTO "php_manual" VALUES (396,'gettext',' Lookup a message in the current domain','   string gettext (string message)');
INSERT INTO "php_manual" VALUES (397,'textdomain',' Sets the DEFAULT domain','   string textdomain (string text_domain)');
INSERT INTO "php_manual" VALUES (398,'gmp_init',' Create GMP number','   resource gmp_init (mixed number)');
INSERT INTO "php_manual" VALUES (399,'gmp_intval',' Convert GMP number to integer','   int gmp_intval (resource gmpnumber)');
INSERT INTO "php_manual" VALUES (400,'gmp_strval',' Convert GMP number to string','   string gmp_strval (resource gmpnumber [, int base])');
INSERT INTO "php_manual" VALUES (401,'gmp_add',' Add numbers','   resource gmp_add (resource a, resource b)');
INSERT INTO "php_manual" VALUES (402,'gmp_sub',' Subtract numbers','   resource gmp_sub (resource a, resource b)');
INSERT INTO "php_manual" VALUES (403,'gmp_mul',' Multiply numbers','   resource gmp_mul (resource a, resource b)');
INSERT INTO "php_manual" VALUES (404,'gmp_div_q',' Divide numbers','   resource gmp_div_q (resource a, resource b [, int round])');
INSERT INTO "php_manual" VALUES (405,'gmp_div_r',' Remainder of the division of numbers','   resource gmp_div_r (resource n, resource d [, int round])');
INSERT INTO "php_manual" VALUES (406,'gmp_div_qr',' Divide numbers and get quotient and remainder','   array gmp_div_qr (resource n, resource d [, int round])');
INSERT INTO "php_manual" VALUES (407,'gmp_div',' Divide numbers','   resource gmp_div (resource a, resource b)');
INSERT INTO "php_manual" VALUES (408,'gmp_mod',' Modulo operation','   resource gmp_mod (resource n, resource d)');
INSERT INTO "php_manual" VALUES (409,'gmp_divexact',' Exact division of numbers','   resource gmp_divexact (resource n, resource d)');
INSERT INTO "php_manual" VALUES (410,'gmp_cmp',' Compare numbers','   int gmp_cmp (resource a, resource b)');
INSERT INTO "php_manual" VALUES (411,'gmp_neg',' Negate number','   resource gmp_neg (resource a)');
INSERT INTO "php_manual" VALUES (412,'gmp_abs',' Absolute value','   resource gmp_abs (resource a)');
INSERT INTO "php_manual" VALUES (413,'gmp_sign',' Sign of number','   int gmp_sign (resource a)');
INSERT INTO "php_manual" VALUES (414,'gmp_fact',' Factorial','   resource gmp_fact (int a)');
INSERT INTO "php_manual" VALUES (415,'gmp_sqrt',' Square root','   resource gmp_sqrt (resource a)');
INSERT INTO "php_manual" VALUES (416,'gmp_sqrtrm',' Square root with remainder','   array gmp_sqrtrm (resource a)');
INSERT INTO "php_manual" VALUES (417,'gmp_perfect_square',' Perfect square check','   bool gmp_perfect_square (resource a)');
INSERT INTO "php_manual" VALUES (418,'gmp_pow',' Raise number into power','   resource gmp_pow (resource base, int exp)');
INSERT INTO "php_manual" VALUES (419,'gmp_powm',' Raise number into power with modulo','   resource gmp_powm (resource base, resource exp, resource mod)');
INSERT INTO "php_manual" VALUES (420,'gmp_prob_prime',' Check if number is \"probably prime\"','   int gmp_prob_prime (resource a [, int reps])');
INSERT INTO "php_manual" VALUES (421,'gmp_gcd',' Calculate GCD','   resource gmp_gcd (resource a, resource b)');
INSERT INTO "php_manual" VALUES (422,'gmp_gcdext',' Calculate GCD and multipliers','   array gmp_gcdext (resource a, resource b)');
INSERT INTO "php_manual" VALUES (423,'gmp_invert',' Inverse by modulo','   resource gmp_invert (resource a, resource b)');
INSERT INTO "php_manual" VALUES (424,'gmp_legendre',' Legendre symbol','   int gmp_legendre (resource a, resource p)');
INSERT INTO "php_manual" VALUES (425,'gmp_jacobi',' Jacobi symbol','   int gmp_jacobi (resource a, resource p)');
INSERT INTO "php_manual" VALUES (426,'gmp_random',' Random number','   resource gmp_random (int limiter)');
INSERT INTO "php_manual" VALUES (427,'gmp_and',' Logical AND','   resource gmp_and (resource a, resource b)');
INSERT INTO "php_manual" VALUES (428,'gmp_or',' Logical OR','   resource gmp_or (resource a, resource b)');
INSERT INTO "php_manual" VALUES (429,'gmp_xor',' Logical XOR','   resource gmp_xor (resource a, resource b)');
INSERT INTO "php_manual" VALUES (430,'gmp_setbit',' Set bit','   resource gmp_setbit (resource &a, int index [, bool set_clear])');
INSERT INTO "php_manual" VALUES (431,'gmp_clrbit',' Clear bit','   resource gmp_clrbit (resource &a, int index)');
INSERT INTO "php_manual" VALUES (432,'gmp_scan0',' Scan for 0','   int gmp_scan0 (resource a, int start)');
INSERT INTO "php_manual" VALUES (433,'gmp_scan1',' Scan for 1','   int gmp_scan1 (resource a, int start)');
INSERT INTO "php_manual" VALUES (434,'gmp_popcount',' Population count','   int gmp_popcount (resource a)');
INSERT INTO "php_manual" VALUES (435,'gmp_hamdist',' Hamming distance','   int gmp_hamdist (resource a, resource b)');
INSERT INTO "php_manual" VALUES (436,'header',' Send a raw HTTP header','   int header (string string)');
INSERT INTO "php_manual" VALUES (437,'headers_sent',' Returns true if headers have been sent','   boolean headers_sent (void)');
INSERT INTO "php_manual" VALUES (438,'setcookie',' Send a cookie','   int setcookie (string name [, string value [, int expire [, string');
INSERT INTO "php_manual" VALUES (439,'hw_Array2Objrec',' convert attributes from object array to object','   strin hw_array2objrec (array object_array)');
INSERT INTO "php_manual" VALUES (440,'hw_Children',' object ids of children','   array hw_children (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (441,'hw_ChildrenObj',' object records of children','   array hw_childrenobj (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (442,'hw_Close',' closes the Hyperwave connection','   int hw_close (int connection)');
INSERT INTO "php_manual" VALUES (443,'hw_Connect',' opens a connection','   int hw_connect (string host, int port, string username, string');
INSERT INTO "php_manual" VALUES (444,'hw_Cp',' copies objects','   int hw_cp (int connection, array object_id_array, int destination id)');
INSERT INTO "php_manual" VALUES (445,'hw_Deleteobject',' deletes object','   int hw_deleteobject (int connection, int object_to_delete)');
INSERT INTO "php_manual" VALUES (446,'hw_DocByAnchor',' object id object belonging to anchor','   int hw_docbyanchor (int connection, int anchorID)');
INSERT INTO "php_manual" VALUES (447,'hw_DocByAnchorObj',' object record object belonging to anchor','   string hw_docbyanchorobj (int connection, int anchorID)');
INSERT INTO "php_manual" VALUES (448,'hw_Document_Attributes',' object record of hw_document','   string hw_document_attributes (int hw_document)');
INSERT INTO "php_manual" VALUES (449,'hw_Document_BodyTag',' body tag of hw_document','   string hw_document_bodytag (int hw_document)');
INSERT INTO "php_manual" VALUES (450,'hw_Document_Content',' returns content of hw_document','   string hw_document_content (int hw_document)');
INSERT INTO "php_manual" VALUES (451,'hw_Document_SetContent',' sets/replaces content of hw_document','   string hw_document_setcontent (int hw_document, string content)');
INSERT INTO "php_manual" VALUES (452,'hw_Document_Size',' size of hw_document','   int hw_document_size (int hw_document)');
INSERT INTO "php_manual" VALUES (453,'hw_ErrorMsg',' returns error message','   string hw_errormsg (int connection)');
INSERT INTO "php_manual" VALUES (454,'hw_EditText',' retrieve text document','   int hw_edittext (int connection, int hw_document)');
INSERT INTO "php_manual" VALUES (455,'hw_Error',' error number','   int hw_error (int connection)');
INSERT INTO "php_manual" VALUES (456,'hw_Free_Document',' frees hw_document','   int hw_free_document (int hw_document)');
INSERT INTO "php_manual" VALUES (457,'hw_GetParents',' object ids of parents','   array hw_getparents (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (458,'hw_GetParentsObj',' object records of parents','   array hw_getparentsobj (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (459,'hw_GetChildColl',' object ids of child collections','   array hw_getchildcoll (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (460,'hw_GetChildCollObj',' object records of child collections','   array hw_getchildcollobj (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (461,'hw_GetRemote',' Gets a remote document','   int hw_getremote (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (462,'hw_GetRemoteChildren',' Gets children of remote document','   int hw_getremotechildren (int connection, string object record)');
INSERT INTO "php_manual" VALUES (463,'hw_GetSrcByDestObj',' Returns anchors pointing at object','   array hw_getsrcbydestobj (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (464,'hw_GetObject',' object record','   array hw_getobject (int connection, [int|array] objectID, string');
INSERT INTO "php_manual" VALUES (465,'hw_GetAndLock',' return bject record and lock object','   string hw_getandlock (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (466,'hw_GetText',' retrieve text document','   int hw_gettext (int connection, int objectID [, mixed rootID/prefix])');
INSERT INTO "php_manual" VALUES (467,'hw_GetObjectByQuery',' search object','   array hw_getobjectbyquery (int connection, string query, int max_hits)');
INSERT INTO "php_manual" VALUES (468,'hw_GetObjectByQueryObj',' search object','   array hw_getobjectbyqueryobj (int connection, string query, int');
INSERT INTO "php_manual" VALUES (469,'hw_GetObjectByQueryColl',' search object in collection','   array hw_getobjectbyquerycoll (int connection, int objectID, string');
INSERT INTO "php_manual" VALUES (470,'hw_GetObjectByQueryCollObj',' search object in collection','   array hw_getobjectbyquerycollobj (int connection, int objectID, string');
INSERT INTO "php_manual" VALUES (471,'hw_GetChildDocColl',' object ids of child documents of collection','   array hw_getchilddoccoll (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (472,'hw_GetChildDocCollObj',' object records of child documents of','   array hw_getchilddoccollobj (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (473,'hw_GetAnchors',' object ids of anchors of document','   array hw_getanchors (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (474,'hw_GetAnchorsObj',' object records of anchors of document','   array hw_getanchorsobj (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (475,'hw_Mv',' moves objects','   int hw_mv (int connection, array object id array, int source id, int');
INSERT INTO "php_manual" VALUES (476,'hw_Identify',' identifies as user','   int hw_identify (string username, string password)');
INSERT INTO "php_manual" VALUES (477,'hw_InCollections',' check if object ids in collections','   array hw_incollections (int connection, array object_id_array, array');
INSERT INTO "php_manual" VALUES (478,'hw_Info',' info about connection','   string hw_info (int connection)');
INSERT INTO "php_manual" VALUES (479,'hw_InsColl',' insert collection','   int hw_inscoll (int connection, int objectID, array object_array)');
INSERT INTO "php_manual" VALUES (480,'hw_InsDoc',' insert document','   int hw_insdoc (int connection, int parentID, string object_record,');
INSERT INTO "php_manual" VALUES (481,'hw_InsertDocument',' upload any document','   int hw_insertdocument (int connection, int parent_id, int hw_document)');
INSERT INTO "php_manual" VALUES (482,'hw_InsertObject',' inserts an object record','   int hw_insertobject (int connection, string object rec, string');
INSERT INTO "php_manual" VALUES (483,'hw_mapid',' Maps global id on virtual local id','   int hw_mapid (int connection, int server id, int object id)');
INSERT INTO "php_manual" VALUES (484,'hw_Modifyobject',' modifies object record','   int hw_modifyobject (int connection, int object_to_change, array');
INSERT INTO "php_manual" VALUES (485,'hw_New_Document',' create new document','   int hw_new_document (string object_record, string document_data, int');
INSERT INTO "php_manual" VALUES (486,'hw_Objrec2Array',' convert attributes from object record to object','   array hw_objrec2array (string object_record [, array format])');
INSERT INTO "php_manual" VALUES (487,'hw_Output_Document',' prints hw_document','   int hw_output_document (int hw_document)');
INSERT INTO "php_manual" VALUES (488,'hw_pConnect',' make a persistent database connection','   int hw_pconnect (string host, int port, string username, string');
INSERT INTO "php_manual" VALUES (489,'hw_PipeDocument',' retrieve any document','   int hw_pipedocument (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (490,'hw_Root',' root object id','   int hw_root ()');
INSERT INTO "php_manual" VALUES (491,'hw_Unlock',' unlock object','   int hw_unlock (int connection, int objectID)');
INSERT INTO "php_manual" VALUES (492,'hw_Who',' List of currently logged in users','   int hw_who (int connection)');
INSERT INTO "php_manual" VALUES (493,'hw_getusername',' name of currently logged in user','   string hw_getusername (int connection)');
INSERT INTO "php_manual" VALUES (494,'icap_open',' Opens up an ICAP connection','   stream icap_open (string calendar, string username, string password,');
INSERT INTO "php_manual" VALUES (495,'icap_close',' Close an ICAP stream','   int icap_close (int icap_stream [, int flags])');
INSERT INTO "php_manual" VALUES (496,'icap_fetch_event',' Fetches an event from the calendar stream/','   int icap_fetch_event (int stream_id, int event_id [, int options])');
INSERT INTO "php_manual" VALUES (497,'icap_list_events','  Return a list of events between two given','   array icap_list_events (int stream_id, int begin_date [, int');
INSERT INTO "php_manual" VALUES (498,'icap_store_event',' Store an event into an ICAP calendar','   string icap_store_event (int stream_id, object event)');
INSERT INTO "php_manual" VALUES (499,'icap_delete_event',' Delete an event from an ICAP calendar','   string icap_delete_event (int sream_id, int uid)');
INSERT INTO "php_manual" VALUES (500,'icap_snooze',' Snooze an alarm','   string icap_snooze (int stream_id, int uid)');
INSERT INTO "php_manual" VALUES (501,'icap_list_alarms','  Return a list of events that has an alarm','   int icap_list_alarms (int stream_id, array date, array time)');
INSERT INTO "php_manual" VALUES (502,'GetImageSize',' Get the size of a GIF, JPEG, PNG or SWF image','   array getimagesize (string filename [, array imageinfo])');
INSERT INTO "php_manual" VALUES (503,'ImageArc',' Draw a partial ellipse','   int imagearc (int im, int cx, int cy, int w, int h, int s, int e, int');
INSERT INTO "php_manual" VALUES (504,'ImageChar',' Draw a character horizontally','   int imagechar (int im, int font, int x, int y, string c, int col)');
INSERT INTO "php_manual" VALUES (505,'ImageCharUp',' Draw a character vertically','   int imagecharup (int im, int font, int x, int y, string c, int col)');
INSERT INTO "php_manual" VALUES (506,'ImageColorAllocate',' Allocate a color for an image','   int imagecolorallocate (int im, int red, int green, int blue)');
INSERT INTO "php_manual" VALUES (507,'ImageColorDeAllocate','  De-allocate a color for an image','   int imagecolordeallocate (int im, int index)');
INSERT INTO "php_manual" VALUES (508,'ImageColorAt',' Get the index of the color of a pixel','   int imagecolorat (int im, int x, int y)');
INSERT INTO "php_manual" VALUES (509,'ImageColorClosest','  Get the index of the closest color to the','   int imagecolorclosest (int im, int red, int green, int blue)');
INSERT INTO "php_manual" VALUES (510,'ImageColorExact',' Get the index of the specified color','   int imagecolorexact (int im, int red, int green, int blue)');
INSERT INTO "php_manual" VALUES (511,'ImageColorResolve','  Get the index of the specified color or its','   int imagecolorresolve (int im, int red, int green, int blue)');
INSERT INTO "php_manual" VALUES (512,'ImageGammaCorrect','  Apply a gamma correction to a GD image','   int imagegammacorrect (int im, FLOAT8inputgamma, double outputgamma)');
INSERT INTO "php_manual" VALUES (513,'ImageColorSet','  Set the color for the specified palette index','   bool imagecolorset (int im, int index, int red, int green, int blue)');
INSERT INTO "php_manual" VALUES (514,'ImageColorsForIndex',' Get the colors for an index','   array imagecolorsforindex (int im, int index)');
INSERT INTO "php_manual" VALUES (515,'ImageColorsTotal','  Find out the number of colors in an image\'s','   int imagecolorstotal (int im)');
INSERT INTO "php_manual" VALUES (516,'ImageColorTransparent',' Define a color as transparent','   int imagecolortransparent (int im [, int col])');
INSERT INTO "php_manual" VALUES (517,'ImageCopy','  Copy part of an image','   int ImageCopy (int dst_im, int src_im, int dst_x, int dst_y, int');
INSERT INTO "php_manual" VALUES (518,'ImageCopyResized',' Copy and resize part of an image','   int imagecopyresized (int dst_im, int src_im, int dstX, int dstY, int');
INSERT INTO "php_manual" VALUES (519,'ImageCreate',' Create a new image','   int imagecreate (int x_size, int y_size)');
INSERT INTO "php_manual" VALUES (520,'ImageCreateFromGIF',' Create a new image from file or URL','   int imagecreatefromgif (string filename)');
INSERT INTO "php_manual" VALUES (521,'ImageCreateFromJPEG',' Create a new image from file or URL','   int imagecreatefromjpeg (string filename)');
INSERT INTO "php_manual" VALUES (522,'ImageCreateFromPNG',' Create a new image from file or URL','   int imagecreatefrompng (string filename)');
INSERT INTO "php_manual" VALUES (523,'ImageCreateFromWBMP',' Create a new image from file or URL','   int imagecreatefromwbmp (string filename)');
INSERT INTO "php_manual" VALUES (524,'ImageCreateFromString',' Create a new image from the image stream in','   int imagecreatefromstring (string image)');
INSERT INTO "php_manual" VALUES (525,'ImageDashedLine',' Draw a dashed line','   int imagedashedline (int im, int x1, int y1, int x2, int y2, int col)');
INSERT INTO "php_manual" VALUES (526,'ImageDestroy',' Destroy an image','   int imagedestroy (int im)');
INSERT INTO "php_manual" VALUES (527,'ImageFill',' Flood fill','   int imagefill (int im, int x, int y, int col)');
INSERT INTO "php_manual" VALUES (528,'ImageFilledPolygon',' Draw a filled polygon','   int imagefilledpolygon (int im, array points, int num_points, int col)');
INSERT INTO "php_manual" VALUES (529,'ImageFilledRectangle',' Draw a filled rectangle','   int imagefilledrectangle (int im, int x1, int y1, int x2, int y2, int');
INSERT INTO "php_manual" VALUES (530,'ImageFillToBorder',' Flood fill to specific color','   int imagefilltoborder (int im, int x, int y, int border, int col)');
INSERT INTO "php_manual" VALUES (531,'ImageFontHeight',' Get font height','   int imagefontheight (int font)');
INSERT INTO "php_manual" VALUES (532,'ImageFontWidth',' Get font width','   int imagefontwidth (int font)');
INSERT INTO "php_manual" VALUES (533,'ImageGIF',' Output image to browser or file','   int imagegif (int im [, string filename])');
INSERT INTO "php_manual" VALUES (534,'ImagePNG','  Output a PNG image to either the browser or a file','   int imagepng (int im [, string filename])');
INSERT INTO "php_manual" VALUES (535,'ImageJPEG',' Output image to browser or file','   int imagejpeg (int im [, string filename [, int quality]])');
INSERT INTO "php_manual" VALUES (536,'ImageWBMP',' Output image to browser or file','   int imageWBMP (int im [, string filename])');
INSERT INTO "php_manual" VALUES (537,'ImageInterlace',' Enable or disable interlace','   int imageinterlace (int im [, int interlace])');
INSERT INTO "php_manual" VALUES (538,'ImageLine',' Draw a line','   int imageline (int im, int x1, int y1, int x2, int y2, int col)');
INSERT INTO "php_manual" VALUES (539,'ImageLoadFont',' Load a new font','   int imageloadfont (string file)');
INSERT INTO "php_manual" VALUES (540,'ImagePolygon',' Draw a polygon','   int imagepolygon (int im, array points, int num_points, int col)');
INSERT INTO "php_manual" VALUES (541,'ImagePSBBox','  Give the bounding box of a text rectangle using','   array imagepsbbox (string text, int font, int size [, int space [, int');
INSERT INTO "php_manual" VALUES (542,'ImagePSEncodeFont','  Change the character encoding vector of a font','   int imagepsencodefont (int font_index, string encodingfile)');
INSERT INTO "php_manual" VALUES (543,'ImagePSFreeFont',' Free memory used by a PostScript Type 1 font','   void imagepsfreefont (int fontindex)');
INSERT INTO "php_manual" VALUES (544,'ImagePSLoadFont',' Load a PostScript Type 1 font from file','   int imagepsloadfont (string filename)');
INSERT INTO "php_manual" VALUES (545,'ImagePsExtendFont','  Extend or condense a font','   bool imagepsextendfont (int font_index, FLOAT8extend)');
INSERT INTO "php_manual" VALUES (546,'ImagePsSlantFont','  Slant a font','   bool imagepsslantfont (int font_index, FLOAT8slant)');
INSERT INTO "php_manual" VALUES (547,'ImagePSText','  To draw a text string over an image using PostScript','   array imagepstext (int image, string text, int font, int size, int');
INSERT INTO "php_manual" VALUES (548,'ImageRectangle',' Draw a rectangle','   int imagerectangle (int im, int x1, int y1, int x2, int y2, int col)');
INSERT INTO "php_manual" VALUES (549,'ImageSetPixel',' Set a single pixel','   int imagesetpixel (int im, int x, int y, int col)');
INSERT INTO "php_manual" VALUES (550,'ImageString',' Draw a string horizontally','   int imagestring (int im, int font, int x, int y, string s, int col)');
INSERT INTO "php_manual" VALUES (551,'ImageStringUp',' Draw a string vertically','   int imagestringup (int im, int font, int x, int y, string s, int col)');
INSERT INTO "php_manual" VALUES (552,'ImageSX',' Get image width','   int imagesx (int im)');
INSERT INTO "php_manual" VALUES (553,'ImageSY',' Get image height','   int imagesy (int im)');
INSERT INTO "php_manual" VALUES (554,'ImageTTFBBox','  Give the bounding box of a text using TypeType fonts','   array imagettfbbox (int size, int angle, string fontfile, string text)');
INSERT INTO "php_manual" VALUES (555,'ImageTTFText','  Write text to the image using TrueType fonts','   array imagettftext (int im, int size, int angle, int x, int y, int');
INSERT INTO "php_manual" VALUES (556,'ImageTypes','  Return the image types supported by this PHP build','   int imagetypes(void);');
INSERT INTO "php_manual" VALUES (557,'read_exif_data',' Read the EXIF headers from a JPEG','   array read_exif_data (string filename)');
INSERT INTO "php_manual" VALUES (558,'imap_append','  Append a string message to a specified mailbox','   int imap_append (int imap_stream, string mbox, string message [,');
INSERT INTO "php_manual" VALUES (559,'imap_base64',' Decode BASE64 encoded text','   string imap_base64 (string text)');
INSERT INTO "php_manual" VALUES (560,'imap_body',' Read the message body','   string imap_body (int imap_stream, int msg_number [, int flags])');
INSERT INTO "php_manual" VALUES (561,'imap_check',' Check current mailbox','   object imap_check (int imap_stream)');
INSERT INTO "php_manual" VALUES (562,'imap_close',' Close an IMAP stream','   int imap_close (int imap_stream [, int flags])');
INSERT INTO "php_manual" VALUES (563,'imap_createmailbox',' Create a new mailbox','   int imap_createmailbox (int imap_stream, string mbox)');
INSERT INTO "php_manual" VALUES (564,'imap_delete','  Mark a messge for deletion from current mailbox','   int imap_delete (int imap_stream, int msg_number [, int flags])');
INSERT INTO "php_manual" VALUES (565,'imap_deletemailbox',' Delete a mailbox','   int imap_deletemailbox (int imap_stream, string mbox)');
INSERT INTO "php_manual" VALUES (566,'imap_expunge',' Delete all messages marked for deletion','   int imap_expunge (int imap_stream)');
INSERT INTO "php_manual" VALUES (567,'imap_fetchbody','  Fetch a particular section of the body of the','   string imap_fetchbody (int imap_stream, int msg_number, string');
INSERT INTO "php_manual" VALUES (568,'imap_fetchstructure','  Read the structure of a particular message','   object imap_fetchstructure (int imap_stream, int msg_number [, int');
INSERT INTO "php_manual" VALUES (569,'imap_headerinfo',' Read the header of the message','   object imap_headerinfo (int imap_stream, int msg_number [, int');
INSERT INTO "php_manual" VALUES (570,'imap_header',' Read the header of the message','   object imap_header (int imap_stream, int msg_number [, int fromlength');
INSERT INTO "php_manual" VALUES (571,'imap_rfc822_parse_headers',' Parse mail headers from a string','   object imap_rfc822_parse_headers (string headers [, string');
INSERT INTO "php_manual" VALUES (572,'imap_headers','  Returns headers for all messages in a mailbox','   array imap_headers (int imap_stream)');
INSERT INTO "php_manual" VALUES (573,'imap_listmailbox',' Read the list of mailboxes','   array imap_listmailbox (int imap_stream, string ref, string pattern)');
INSERT INTO "php_manual" VALUES (574,'imap_getmailboxes','  Read the list of mailboxes, returning detailed','   array imap_getmailboxes (int imap_stream, string ref, string pattern)');
INSERT INTO "php_manual" VALUES (575,'imap_get_quota','  Retrieve the quota level settings, and usage','   array imap_get_quota (int imap_stream, string quota_root)');
INSERT INTO "php_manual" VALUES (576,'imap_listsubscribed',' List all the subscribed mailboxes','   array imap_listsubscribed (int imap_stream, string ref, string');
INSERT INTO "php_manual" VALUES (577,'imap_getsubscribed',' List all the subscribed mailboxes','   array imap_getsubscribed (int imap_stream, string ref, string pattern)');
INSERT INTO "php_manual" VALUES (578,'imap_mail_copy',' Copy specified messages to a mailbox','   int imap_mail_copy (int imap_stream, string msglist, string mbox [,');
INSERT INTO "php_manual" VALUES (579,'imap_mail_move',' Move specified messages to a mailbox','   int imap_mail_move (int imap_stream, string msglist, string mbox [,');
INSERT INTO "php_manual" VALUES (580,'imap_num_msg','  Gives the number of messages in the current mailbox','   int imap_num_msg (int imap_stream)');
INSERT INTO "php_manual" VALUES (581,'imap_num_recent',' Gives the number of recent messages in current','   int imap_num_recent (int imap_stream)');
INSERT INTO "php_manual" VALUES (582,'imap_open',' Open an IMAP stream to a mailbox','   int imap_open (string mailbox, string username, string password [, int');
INSERT INTO "php_manual" VALUES (583,'imap_ping',' Check if the IMAP stream is still active','   int imap_ping (int imap_stream)');
INSERT INTO "php_manual" VALUES (584,'imap_renamemailbox',' Rename an old mailbox to new mailbox','   int imap_renamemailbox (int imap_stream, string old_mbox, string');
INSERT INTO "php_manual" VALUES (585,'imap_reopen',' Reopen IMAP stream to new mailbox','   int imap_reopen (int imap_stream, string mailbox [, string flags])');
INSERT INTO "php_manual" VALUES (586,'imap_set_quota',' Sets a quota for a given mailbox','   int imap_set_quota (int imap_stream, string quota_root, int');
INSERT INTO "php_manual" VALUES (587,'imap_subscribe',' Subscribe to a mailbox','   int imap_subscribe (int imap_stream, string mbox)');
INSERT INTO "php_manual" VALUES (588,'imap_undelete','  Unmark the message which is marked deleted','   int imap_undelete (int imap_stream, int msg_number)');
INSERT INTO "php_manual" VALUES (589,'imap_unsubscribe',' Unsubscribe from a mailbox','   int imap_unsubscribe (int imap_stream, string mbox)');
INSERT INTO "php_manual" VALUES (590,'imap_qprint',' Convert a quoted-printable string to an 8 bit string','   string imap_qprint (string string)');
INSERT INTO "php_manual" VALUES (591,'imap_8bit','  Convert an 8bit string to a quoted-printable string','   string imap_8bit (string string)');
INSERT INTO "php_manual" VALUES (592,'imap_binary','  Convert an 8bit string to a base64 string','   string imap_binary (string string)');
INSERT INTO "php_manual" VALUES (593,'imap_scanmailbox','  Read the list of mailboxes, takes a string to','   array imap_scanmailbox (int imap_stream, string ref, string pattern,');
INSERT INTO "php_manual" VALUES (594,'imap_mailboxmsginfo',' Get information about the current mailbox','   object imap_mailboxmsginfo (int imap_stream)');
INSERT INTO "php_manual" VALUES (595,'imap_rfc822_write_address','  Returns a properly formatted email','   string imap_rfc822_write_address (string mailbox, string host, string');
INSERT INTO "php_manual" VALUES (596,'imap_rfc822_parse_adrlist',' Parses an address string','   array imap_rfc822_parse_adrlist (string address, string DEFAULT_host)');
INSERT INTO "php_manual" VALUES (597,'imap_setflag_full',' Sets flags on messages','   string imap_setflag_full (int stream, string sequence, string flag,');
INSERT INTO "php_manual" VALUES (598,'imap_clearflag_full',' Clears flags on messages','   string imap_clearflag_full (int stream, string sequence, string flag,');
INSERT INTO "php_manual" VALUES (599,'imap_sort',' Sort an array of message headers','   array imap_sort (int stream, int criteria, int reverse, int options)');
INSERT INTO "php_manual" VALUES (600,'imap_fetchheader',' Returns header for a message','   string imap_fetchheader (int imap_stream, int msgno, int flags)');
INSERT INTO "php_manual" VALUES (601,'imap_uid','  This function returns the UID for the given message','   int imap_uid (int imap_stream, int msgno)');
INSERT INTO "php_manual" VALUES (602,'imap_msgno','  This function returns the message sequence number for','   int imap_msgno (int imap_stream, int uid)');
INSERT INTO "php_manual" VALUES (603,'imap_search','  This function returns an array of messages matching','   array imap_search (int imap_stream, string criteria, int flags)');
INSERT INTO "php_manual" VALUES (604,'imap_last_error','  This function returns the last IMAP error (if any)','   string imap_last_error (void)');
INSERT INTO "php_manual" VALUES (605,'imap_errors','  This function returns all of the IMAP errors (if any)','   array imap_errors (void)');
INSERT INTO "php_manual" VALUES (606,'imap_alerts','  This function returns all IMAP alert messages (if any)','   array imap_alerts (void)');
INSERT INTO "php_manual" VALUES (607,'imap_status','  This function returns status information on a mailbox','   object imap_status (int imap_stream, string mailbox, int options)');
INSERT INTO "php_manual" VALUES (608,'imap_utf7_decode','  Decodes a modified UTF-7 encoded string.','   string imap_utf7_decode (string text)');
INSERT INTO "php_manual" VALUES (609,'imap_utf7_encode','  Converts 8bit data to modified UTF-7 text.','   string imap_utf7_encode (string data)');
INSERT INTO "php_manual" VALUES (610,'imap_utf8','  Converts text to UTF8','   string imap_utf8 (string text)');
INSERT INTO "php_manual" VALUES (611,'imap_fetch_overview','  Read an overview of the information in the','   array imap_fetch_overview (int imap_stream, string sequence [, int');
INSERT INTO "php_manual" VALUES (612,'imap_mime_header_decode',' Decode MIME header elements','   array imap_header_decode (string text)');
INSERT INTO "php_manual" VALUES (613,'imap_mail_compose','  Create a MIME message based on given envelope','   string imap_mail_compose (array envelope, array body)');
INSERT INTO "php_manual" VALUES (614,'imap_mail','  Send an email message','   string imap_mail (string to, string subject, string message [, string');
INSERT INTO "php_manual" VALUES (615,'ifx_connect',' Open Informix server connection','   int ifx_connect ([string database [, string userid [, string');
INSERT INTO "php_manual" VALUES (616,'ifx_pconnect',' Open persistent Informix connection','   int ifx_pconnect ([string database [, string userid [, string');
INSERT INTO "php_manual" VALUES (617,'ifx_close',' Close Informix connection','   int ifx_close ([int link_identifier])');
INSERT INTO "php_manual" VALUES (618,'ifx_query',' Send Informix query','   int ifx_query (string query [, int link_identifier [, int cursor_type');
INSERT INTO "php_manual" VALUES (619,'ifx_prepare',' Prepare an SQL-statement for execution','   int ifx_prepare (string query, int conn_id [, int cursor_def, mixed');
INSERT INTO "php_manual" VALUES (620,'ifx_do','  Execute a previously prepared SQL-statement','   int ifx_do (int result_id)');
INSERT INTO "php_manual" VALUES (621,'ifx_error',' Returns error code of last Informix call','   string ifx_error(void);');
INSERT INTO "php_manual" VALUES (622,'ifx_errormsg',' Returns error message of last Informix call','   string ifx_errormsg ([int errorcode])');
INSERT INTO "php_manual" VALUES (623,'ifx_affected_rows',' Get number of rows affected by a query','   int ifx_affected_rows (int result_id)');
INSERT INTO "php_manual" VALUES (624,'ifx_getsqlca','  Get the contents of sqlca.sqlerrd[0..5] after a query','   array ifx_getsqlca (int result_id)');
INSERT INTO "php_manual" VALUES (625,'ifx_fetch_row',' Get row as enumerated array','   array ifx_fetch_row (int result_id [, mixed position])');
INSERT INTO "php_manual" VALUES (626,'ifx_htmltbl_result','  Formats all rows of a query into a HTML table','   int ifx_htmltbl_result (int result_id [, string html_table_options])');
INSERT INTO "php_manual" VALUES (627,'ifx_fieldtypes',' List of Informix SQL fields','   array ifx_fieldtypes (int result_id)');
INSERT INTO "php_manual" VALUES (628,'ifx_fieldproperties',' List of SQL fieldproperties','   array ifx_fieldproperties (int result_id)');
INSERT INTO "php_manual" VALUES (629,'ifx_num_fields',' Returns the number of columns in the query','   int ifx_num_fields (int result_id)');
INSERT INTO "php_manual" VALUES (630,'ifx_num_rows',' Count the rows already fetched from a query','   int ifx_num_rows (int result_id)');
INSERT INTO "php_manual" VALUES (631,'ifx_free_result',' Releases resources for the query','   int ifx_free_result (int result_id)');
INSERT INTO "php_manual" VALUES (632,'ifx_create_char',' Creates an char object','   int ifx_create_char (string param)');
INSERT INTO "php_manual" VALUES (633,'ifx_free_char',' Deletes the char object','   int ifx_free_char (int bid)');
INSERT INTO "php_manual" VALUES (634,'ifx_update_char',' Updates the content of the char object','   int ifx_update_char (int bid, string content)');
INSERT INTO "php_manual" VALUES (635,'ifx_get_char',' Return the content of the char object','   int ifx_get_char (int bid)');
INSERT INTO "php_manual" VALUES (636,'text',' Creates an blob object','   int ifx_create_blob (int type, int mode, string param)');
INSERT INTO "php_manual" VALUES (637,'text',' Duplicates the given blob object','   int ifx_copy_blob (int bid)');
INSERT INTO "php_manual" VALUES (638,'text',' Deletes the blob object','   int ifx_free_blob (int bid)');
INSERT INTO "php_manual" VALUES (639,'text',' Return the content of a blob object','   int ifx_get_blob (int bid)');
INSERT INTO "php_manual" VALUES (640,'text',' Updates the content of the blob object','   ifx_update_blob (int bid, string content)');
INSERT INTO "php_manual" VALUES (641,'textinfile_mode',' Set the DEFAULT blob mode for all select','   void ifx_blobinfile_mode (int mode)');
INSERT INTO "php_manual" VALUES (642,'ifx_textasvarchar',' Set the DEFAULT text mode','   void ifx_textasvarchar (int mode)');
INSERT INTO "php_manual" VALUES (643,'ifx_byteasvarchar',' Set the DEFAULT byte mode','   void ifx_byteasvarchar (int mode)');
INSERT INTO "php_manual" VALUES (644,'ifx_nullformat','  Sets the DEFAULT return value on a fetch row','   void ifx_nullformat (int mode)');
INSERT INTO "php_manual" VALUES (645,'ifxus_create_slob',' Creates an slob object and opens it','   int ifxus_create_slob (int mode)');
INSERT INTO "php_manual" VALUES (646,'ifxus_free_slob',' Deletes the slob object','   int ifxus_free_slob (int bid)');
INSERT INTO "php_manual" VALUES (647,'ifxus_close_slob',' Deletes the slob object','   int ifxus_close_slob (int bid)');
INSERT INTO "php_manual" VALUES (648,'ifxus_open_slob',' Opens an slob object','   int ifxus_open_slob (long bid, int mode)');
INSERT INTO "php_manual" VALUES (649,'ifxus_tell_slob',' Returns the current file or seek position','   int ifxus_tell_slob (long bid)');
INSERT INTO "php_manual" VALUES (650,'ifxus_seek_slob',' Sets the current file or seek position','   int text (long bid, int mode, long offset)');
INSERT INTO "php_manual" VALUES (651,'ifxus_read_slob',' Reads nbytes of the slob object','   int ifxus_read_slob (long bid, long nbytes)');
INSERT INTO "php_manual" VALUES (652,'ifxus_write_slob',' Writes a string into the slob object','   int ifxus_write_slob (long bid, string content)');
INSERT INTO "php_manual" VALUES (653,'ibase_connect','  Open a connection to an InterBase database','   int ibase_connect (string database [, string username [, string');
INSERT INTO "php_manual" VALUES (654,'ibase_pconnect','  Creates an persistent connection to an InterBase','   int ibase_pconnect (string database [, string username [, string');
INSERT INTO "php_manual" VALUES (655,'ibase_close','  Close a connection to an InterBase database','   int ibase_close ([int connection_id])');
INSERT INTO "php_manual" VALUES (656,'ibase_query',' Execute a query on an InterBase database','   int ibase_query ([int link_identifier, string query [, int');
INSERT INTO "php_manual" VALUES (657,'ibase_fetch_row',' Fetch a row from an InterBase database','   array ibase_fetch_row (int result_identifier)');
INSERT INTO "php_manual" VALUES (658,'ibase_fetch_object',' Get an object from a InterBase database','   object ibase_fetch_object (int result_id)');
INSERT INTO "php_manual" VALUES (659,'ibase_field_info','  Get information about a field','   array ibase_field_info (int result, int field number)');
INSERT INTO "php_manual" VALUES (660,'ibase_free_result',' Free a result set','   int ibase_free_result (int result_identifier)');
INSERT INTO "php_manual" VALUES (661,'ibase_prepare','  Prepare a query for later binding of parameter','   int ibase_prepare ([int link_identifier, string query])');
INSERT INTO "php_manual" VALUES (662,'ibase_execute',' Execute a previously prepared query','   int ibase_execute (int query [, int bind_args])');
INSERT INTO "php_manual" VALUES (663,'ibase_trans',' Begin a transaction','   int ibase_trans ([int trans_args [, int link_identifier]])');
INSERT INTO "php_manual" VALUES (664,'ibase_commit',' Commit a transaction','   int ibase_commit ([int link_identifier, int trans_number])');
INSERT INTO "php_manual" VALUES (665,'ibase_rollback',' Rolls back a transaction','   int ibase_rollback ([int link_identifier, int trans_number])');
INSERT INTO "php_manual" VALUES (666,'ibase_free_query','  Free memory allocated by a prepared query','   int ibase_free_query (int query)');
INSERT INTO "php_manual" VALUES (667,'ibase_timefmt','  Sets the format of timestamp, date and time type','   int ibase_timefmt (string format [, int columntype])');
INSERT INTO "php_manual" VALUES (668,'ibase_num_fields','  Get the number of fields in a result set','   int ibase_num_fields (int result_id)');
INSERT INTO "php_manual" VALUES (669,'ibase_errmsg','  Returns error messages','   string ibase_errmsg (void )');
INSERT INTO "php_manual" VALUES (670,'ingres_connect',' Open a connection to an Ingres II database.','   resource ingres_connect ([string database [, string username [, string');
INSERT INTO "php_manual" VALUES (671,'ingres_pconnect','  Open a persistent connection to an Ingres II','   resource ingres_pconnect ([string database [, string username [,');
INSERT INTO "php_manual" VALUES (672,'ingres_close',' Close an Ingres II database connection','   boolingres_close ([resource link])');
INSERT INTO "php_manual" VALUES (673,'ingres_query',' Send a SQL query to Ingres II','   boolingres_query (string query [, resource link])');
INSERT INTO "php_manual" VALUES (674,'ingres_num_rows','  Get the number of rows affected or returned by the','   intingres_num_rows ([resource link])');
INSERT INTO "php_manual" VALUES (675,'ingres_num_fields','  Get the number of fields returned by the last','   intingres_num_fields ([resource link])');
INSERT INTO "php_manual" VALUES (676,'ingres_field_name',' Get the name of a field in a query result.','   stringingres_field_name (int index [, resource link])');
INSERT INTO "php_manual" VALUES (677,'ingres_field_type',' Get the type of a field in a query result.','   stringingres_field_type (int index [, resource link])');
INSERT INTO "php_manual" VALUES (678,'ingres_field_nullable',' Test if a field is nullable.','   boolingres_field_nullable (int index [, resource link])');
INSERT INTO "php_manual" VALUES (679,'ingres_field_length',' Get the length of a field.','   intingres_field_length (int index [, resource link])');
INSERT INTO "php_manual" VALUES (680,'ingres_field_precision',' Get the precision of a field.','   intingres_field_precision (int index [, resource link])');
INSERT INTO "php_manual" VALUES (681,'ingres_field_scale',' Get the scale of a field.','   intingres_field_scale (int index [, resource link])');
INSERT INTO "php_manual" VALUES (682,'ingres_fetch_array',' Fetch a row of result into an array.','   arrayingres_fetch_array ([int result_type [, resource link]])');
INSERT INTO "php_manual" VALUES (683,'ingres_fetch_row',' Fetch a row of result into an enumerated array.','   arrayingres_fetch_row ([resource link])');
INSERT INTO "php_manual" VALUES (684,'ingres_fetch_object',' Fetch a row of result into an object.','   objectingres_fetch_object ([int result_type [, resource link]])');
INSERT INTO "php_manual" VALUES (685,'ingres_rollback',' Roll back a transaction.','   boolingres_rollback ([resource link])');
INSERT INTO "php_manual" VALUES (686,'ingres_commit',' Commit a transaction.','   boolingres_commit ([resource link])');
INSERT INTO "php_manual" VALUES (687,'ingres_autocommit',' Switch autocommit on or off.','   boolingres_autocommit ([resource link])');
INSERT INTO "php_manual" VALUES (688,'ldap_add',' Add entries to LDAP directory','   int ldap_add (int link_identifier, string dn, array entry)');
INSERT INTO "php_manual" VALUES (689,'ldap_bind',' Bind to LDAP directory','   int ldap_bind (int link_identifier [, string bind_rdn [, string');
INSERT INTO "php_manual" VALUES (690,'ldap_close',' Close link to LDAP server','   int ldap_close (int link_identifier)');
INSERT INTO "php_manual" VALUES (691,'ldap_compare',' Compare value of attribute found in entry specified','   int ldap_compare (int link_identifier, string dn, string attribute,');
INSERT INTO "php_manual" VALUES (692,'ldap_connect',' Connect to an LDAP server','   int ldap_connect ([string hostname [, int port]])');
INSERT INTO "php_manual" VALUES (693,'ldap_count_entries',' Count the number of entries in a search','   int ldap_count_entries (int link_identifier, int result_identifier)');
INSERT INTO "php_manual" VALUES (694,'ldap_delete',' Delete an entry from a directory','   int ldap_delete (int link_identifier, string dn)');
INSERT INTO "php_manual" VALUES (695,'ldap_dn2ufn',' Convert DN to User Friendly Naming format','   string ldap_dn2ufn (string dn)');
INSERT INTO "php_manual" VALUES (696,'ldap_err2str','  Convert LDAP error number into string error message','   string ldap_err2str (int errno)');
INSERT INTO "php_manual" VALUES (697,'ldap_errno','  Return the LDAP error number of the last LDAP command','   int ldap_errno (int link_id)');
INSERT INTO "php_manual" VALUES (698,'ldap_error','  Return the LDAP error message of the last LDAP command','   string ldap_error (int link_id)');
INSERT INTO "php_manual" VALUES (699,'ldap_explode_dn',' Splits DN into its component parts','   array ldap_explode_dn (string dn, int with_attrib)');
INSERT INTO "php_manual" VALUES (700,'ldap_first_attribute',' Return first attribute','   string ldap_first_attribute (int link_identifier, int');
INSERT INTO "php_manual" VALUES (701,'ldap_first_entry',' Return first result id','   int ldap_first_entry (int link_identifier, int result_identifier)');
INSERT INTO "php_manual" VALUES (702,'ldap_free_result',' Free result memory','   int ldap_free_result (int result_identifier)');
INSERT INTO "php_manual" VALUES (703,'ldap_get_attributes',' Get attributes from a search result entry','   array ldap_get_attributes (int link_identifier, int');
INSERT INTO "php_manual" VALUES (704,'ldap_get_dn',' Get the DN of a result entry','   string ldap_get_dn (int link_identifier, int result_entry_identifier)');
INSERT INTO "php_manual" VALUES (705,'ldap_get_entries',' Get all result entries','   array ldap_get_entries (int link_identifier, int result_identifier)');
INSERT INTO "php_manual" VALUES (706,'ldap_get_option',' Get the current value for given option','   boolean ldap_get_option (int link_identifier, int option, mixed');
INSERT INTO "php_manual" VALUES (707,'ldap_get_values',' Get all values from a result entry','   array ldap_get_values (int link_identifier, int');
INSERT INTO "php_manual" VALUES (708,'ldap_get_values_len',' Get all binary values from a result entry','   array ldap_get_values_len (int link_identifier, int');
INSERT INTO "php_manual" VALUES (709,'ldap_list',' Single-level search','   int ldap_list (int link_identifier, string base_dn, string filter [,');
INSERT INTO "php_manual" VALUES (710,'ldap_modify',' Modify an LDAP entry','   int ldap_modify (int link_identifier, string dn, array entry)');
INSERT INTO "php_manual" VALUES (711,'ldap_mod_add',' Add attribute values to current attributes','   int ldap_mod_add (int link_identifier, string dn, array entry)');
INSERT INTO "php_manual" VALUES (712,'ldap_mod_del',' Delete attribute values from current attributes','   int ldap_mod_del (int link_identifier, string dn, array entry)');
INSERT INTO "php_manual" VALUES (713,'ldap_mod_replace',' Replace attribute values with new ones','   int ldap_mod_replace (int link_identifier, string dn, array entry)');
INSERT INTO "php_manual" VALUES (714,'ldap_next_attribute',' Get the next attribute in result','   string ldap_next_attribute (int link_identifier, int');
INSERT INTO "php_manual" VALUES (715,'ldap_next_entry',' Get next result entry','   int ldap_next_entry (int link_identifier, int result_entry_identifier)');
INSERT INTO "php_manual" VALUES (716,'ldap_read',' Read an entry','   int ldap_read (int link_identifier, string base_dn, string filter [,');
INSERT INTO "php_manual" VALUES (717,'ldap_search',' Search LDAP tree','   int ldap_search (int link_identifier, string base_dn, string filter [,');
INSERT INTO "php_manual" VALUES (718,'ldap_set_option',' Set the value of the given option','   boolean ldap_set_option (int link_identifier, int option, mixed');
INSERT INTO "php_manual" VALUES (719,'ldap_unbind',' Unbind from LDAP directory','   int ldap_unbind (int link_identifier)');
INSERT INTO "php_manual" VALUES (720,'mail',' send mail','   bool mail (string to, string subject, string message [, string');
INSERT INTO "php_manual" VALUES (721,'ezmlm_hash',' Calculate the hash value needed by EZMLM','   int ezmlm_hash (string addr)');
INSERT INTO "php_manual" VALUES (722,'abs',' Absolute value','   mixed abs (mixed number)');
INSERT INTO "php_manual" VALUES (723,'acos',' Arc cosine','   float acos (float arg)');
INSERT INTO "php_manual" VALUES (724,'asin',' Arc sine','   float asin (float arg)');
INSERT INTO "php_manual" VALUES (725,'atan',' Arc tangent','   float atan (float arg)');
INSERT INTO "php_manual" VALUES (726,'atan2',' arc tangent of two variables','   float atan2 (float y, float x)');
INSERT INTO "php_manual" VALUES (727,'base_convert',' Convert a number between arbitrary bases','   string base_convert (string number, int frombase, int tobase)');
INSERT INTO "php_manual" VALUES (728,'bindec',' Binary to decimal','   int bindec (string binary_string)');
INSERT INTO "php_manual" VALUES (729,'ceil',' Round fractions up','   int ceil (float number)');
INSERT INTO "php_manual" VALUES (730,'cos',' Cosine','   float cos (float arg)');
INSERT INTO "php_manual" VALUES (731,'decbin',' Decimal to binary','   string decbin (int number)');
INSERT INTO "php_manual" VALUES (732,'dechex',' Decimal to hexadecimal','   string dechex (int number)');
INSERT INTO "php_manual" VALUES (733,'decoct',' Decimal to octal','   string decoct (int number)');
INSERT INTO "php_manual" VALUES (734,'deg2rad','  Converts the number in degrees to the radian equivalent','   FLOAT8deg2rad (double number)');
INSERT INTO "php_manual" VALUES (735,'exp',' e to the power of ...','   float exp (float arg)');
INSERT INTO "php_manual" VALUES (736,'floor',' Round fractions down','   int floor (float number)');
INSERT INTO "php_manual" VALUES (737,'getrandmax',' Show largest possible random value','   int getrandmax (void)');
INSERT INTO "php_manual" VALUES (738,'hexdec',' Hexadecimal to decimal','   int hexdec (string hex_string)');
INSERT INTO "php_manual" VALUES (739,'lcg_value',' Combined linear congruential generator','   FLOAT8lcg_value(void);');
INSERT INTO "php_manual" VALUES (740,'log',' Natural logarithm','   float log (float arg)');
INSERT INTO "php_manual" VALUES (741,'log10',' Base-10 logarithm','   float log10 (float arg)');
INSERT INTO "php_manual" VALUES (742,'max',' Find highest value','   mixed max (mixed arg1, mixed arg2, mixed argn)');
INSERT INTO "php_manual" VALUES (743,'min',' Find lowest value','   mixed min (mixed arg1, mixed arg2, mixed argn)');
INSERT INTO "php_manual" VALUES (744,'mt_rand',' Generate a better random value','   int mt_rand ([int min [, int max]])');
INSERT INTO "php_manual" VALUES (745,'mt_srand',' Seed the better random number generator','   void mt_srand (int seed)');
INSERT INTO "php_manual" VALUES (746,'mt_getrandmax',' Show largest possible random value','   int mt_getrandmax (void)');
INSERT INTO "php_manual" VALUES (747,'number_format',' Format a number with grouped thousands','   string number_format (float number, int decimals, string dec_point,');
INSERT INTO "php_manual" VALUES (748,'octdec',' Octal to decimal','   int octdec (string octal_string)');
INSERT INTO "php_manual" VALUES (749,'pi',' Get value of pi','   FLOAT8pi (void)');
INSERT INTO "php_manual" VALUES (750,'pow',' Exponential expression','   float pow (float base, float exp)');
INSERT INTO "php_manual" VALUES (751,'rad2deg','  Converts the radian number to the equivalent number in','   FLOAT8rad2deg (double number)');
INSERT INTO "php_manual" VALUES (752,'rand',' Generate a random value','   int rand ([int min [, int max]])');
INSERT INTO "php_manual" VALUES (753,'round',' Rounds a float','   FLOAT8round (double val [, int precision])');
INSERT INTO "php_manual" VALUES (754,'sin',' Sine','   float sin (float arg)');
INSERT INTO "php_manual" VALUES (755,'sqrt',' Square root','   float sqrt (float arg)');
INSERT INTO "php_manual" VALUES (756,'srand',' Seed the random number generator','   void srand (int seed)');
INSERT INTO "php_manual" VALUES (757,'tan',' Tangent','   float tan (float arg)');
INSERT INTO "php_manual" VALUES (758,'mcal_open',' Opens up an MCAL connection','   int mcal_open (string calendar, string username, string password, int');
INSERT INTO "php_manual" VALUES (759,'mcal_popen',' Opens up a persistant MCAL connection','   int mcal_popen (string calendar, string username, string password, int');
INSERT INTO "php_manual" VALUES (760,'mcal_reopen',' Reopens an MCAL connection','   int mcal_reopen (string calendar, int options)');
INSERT INTO "php_manual" VALUES (761,'mcal_close',' Close an MCAL stream','   int mcal_close (int mcal_stream, int flags)');
INSERT INTO "php_manual" VALUES (762,'mcal_create_calendar',' Create a new MCAL calendar','   string mcal_create_calendar (int stream, string calendar)');
INSERT INTO "php_manual" VALUES (763,'mcal_rename_calendar',' Rename an MCAL calendar','   string mcal_rename_calendar (int stream, string old_name, string');
INSERT INTO "php_manual" VALUES (764,'mcal_delete_calendar',' Delete an MCAL calendar','   string mcal_delete_calendar (int stream, string calendar)');
INSERT INTO "php_manual" VALUES (765,'mcal_fetch_event','  Fetches an event from the calendar stream','   object mcal_fetch_event (int mcal_stream, int event_id [, int');
INSERT INTO "php_manual" VALUES (766,'mcal_list_events','  Return a list of IDs for a date or a range of','   array mcal_list_events (int mcal_stream, objectbegin_date [, object');
INSERT INTO "php_manual" VALUES (767,'mcal_append_event',' Store a new event into an MCAL calendar','   int mcal_append_event (int mcal_stream)');
INSERT INTO "php_manual" VALUES (768,'mcal_store_event',' Modify an existing event in an MCAL calendar','   int mcal_store_event (int mcal_stream)');
INSERT INTO "php_manual" VALUES (769,'mcal_delete_event',' Delete an event from an MCAL calendar','   int mcal_delete_event (int mcal_stream [, int event_id])');
INSERT INTO "php_manual" VALUES (770,'mcal_snooze',' Turn off an alarm for an event','   int mcal_snooze (int id)');
INSERT INTO "php_manual" VALUES (771,'mcal_list_alarms','  Return a list of events that has an alarm','   array mcal_list_alarms (int mcal_stream [, int begin_year [, int');
INSERT INTO "php_manual" VALUES (772,'mcal_event_init','  Initializes a streams global event structure','   int mcal_event_init (int stream)');
INSERT INTO "php_manual" VALUES (773,'mcal_event_set_category','  Sets the category of the streams global','   int mcal_event_set_category (int stream, string category)');
INSERT INTO "php_manual" VALUES (774,'mcal_event_set_title','  Sets the title of the streams global event','   int mcal_event_set_title (int stream, string title)');
INSERT INTO "php_manual" VALUES (775,'mcal_event_set_description','  Sets the description of the streams','   int mcal_event_set_description (int stream, string description)');
INSERT INTO "php_manual" VALUES (776,'mcal_event_set_start','  Sets the start date and time of the streams','   int mcal_event_set_start (int stream, int year, int month [, int day');
INSERT INTO "php_manual" VALUES (777,'mcal_event_set_end','  Sets the end date and time of the streams','   int mcal_event_set_end (int stream, int year, int month [, int day [,');
INSERT INTO "php_manual" VALUES (778,'mcal_event_set_alarm','  Sets the alarm of the streams global event','   int mcal_event_set_alarm (int stream, int alarm)');
INSERT INTO "php_manual" VALUES (779,'mcal_event_set_class','  Sets the class of the streams global event','   int mcal_event_set_class (int stream, int class)');
INSERT INTO "php_manual" VALUES (780,'mcal_is_leap_year','  Returns if the given year is a leap year or not','   int mcal_is_leap_year (int year)');
INSERT INTO "php_manual" VALUES (781,'mcal_days_in_month','  Returns the number of days in the given month','   int mcal_days_in_month (int month, int leap year)');
INSERT INTO "php_manual" VALUES (782,'mcal_date_valid','  Returns true if the given year, month, day is a','   int mcal_date_valid (int year, int month, int day)');
INSERT INTO "php_manual" VALUES (783,'mcal_time_valid','  Returns true if the given year, month, day is a','   int mcal_time_valid (int hour, int minutes, int seconds)');
INSERT INTO "php_manual" VALUES (784,'mcal_day_of_week','  Returns the day of the week of the given date','   int mcal_day_of_week (int year, int month, int day)');
INSERT INTO "php_manual" VALUES (785,'mcal_day_of_year','  Returns the day of the year of the given date','   int mcal_ (int year, int month, int day)');
INSERT INTO "php_manual" VALUES (786,'mcal_date_compare',' Compares two dates','   int mcal_date_compare (int a_year, int a_month, int a_day, int b_year,');
INSERT INTO "php_manual" VALUES (787,'mcal_next_recurrence',' Returns the next recurrence of the event','   int mcal_next_recurrence (int stream, int weekstart, array next)');
INSERT INTO "php_manual" VALUES (788,'mcal_event_set_recur_none','  Sets the recurrence of the streams','   int mcal_event_set_recur_none (int stream)');
INSERT INTO "php_manual" VALUES (789,'mcal_event_set_recur_daily','  Sets the recurrence of the streams','   int mcal_event_set_recur_daily (int stream, int year, int month, int');
INSERT INTO "php_manual" VALUES (790,'mcal_event_set_recur_weekly','  Sets the recurrence of the streams','   int mcal_event_set_recur_weekly (int stream, int year, int month, int');
INSERT INTO "php_manual" VALUES (791,'mcal_event_set_recur_monthly_mday','  Sets the recurrence of the','   int mcal_event_set_recur_monthly_mday (int stream, int year, int');
INSERT INTO "php_manual" VALUES (792,'mcal_event_set_recur_monthly_wday','  Sets the recurrence of the','   int mcal_event_set_recur_monthly_wday (int stream, int year, int');
INSERT INTO "php_manual" VALUES (793,'mcal_event_set_recur_yearly','  Sets the recurrence of the streams','   int mcal_event_set_recur_yearly (int stream, int year, int month, int');
INSERT INTO "php_manual" VALUES (794,'mcal_fetch_current_stream_event','  Returns an object containing the','   object mcal_fetch_current_stream_event (int stream)');
INSERT INTO "php_manual" VALUES (795,'mcal_event_add_attribute','  Adds an attribute and a value to the','   void mcal_event_add_attribute (int stream, string attribute, string');
INSERT INTO "php_manual" VALUES (796,'mcal_expunge','  Deletes all events marked for being expunged.','   int mcal_expunge (int stream)');
INSERT INTO "php_manual" VALUES (797,'mcrypt_get_cipher_name',' Get the name of the specified cipher','   string mcrypt_get_cipher_name (int cipher)');
INSERT INTO "php_manual" VALUES (798,'mcrypt_get_block_size',' Get the block size of the specified cipher','   int mcrypt_get_block_size (int cipher)');
INSERT INTO "php_manual" VALUES (799,'mcrypt_get_key_size',' Get the key size of the specified cipher','   int mcrypt_get_key_size (int cipher)');
INSERT INTO "php_manual" VALUES (800,'mcrypt_create_iv','  Create an initialization vector (IV) from a','   string mcrypt_create_iv (int size, int source)');
INSERT INTO "php_manual" VALUES (801,'mcrypt_cbc',' Encrypt/decrypt data in CBC mode','   string mcrypt_cbc (int cipher, string key, string data, int mode [,');
INSERT INTO "php_manual" VALUES (802,'mcrypt_cfb',' Encrypt/decrypt data in CFB mode','   string mcrypt_cfb (int cipher, string key, string data, int mode,');
INSERT INTO "php_manual" VALUES (803,'mcrypt_ecb',' Encrypt/decrypt data in ECB mode','   string mcrypt_ecb (int cipher, string key, string data, int mode)');
INSERT INTO "php_manual" VALUES (804,'mcrypt_ofb',' Encrypt/decrypt data in OFB mode','   string mcrypt_ofb (int cipher, string key, string data, int mode,');
INSERT INTO "php_manual" VALUES (805,'mcrypt_list_algorithms',' Get an array of all supported ciphers','   array mcrypt_list_algorithms ([string lib_dir])');
INSERT INTO "php_manual" VALUES (806,'mcrypt_list_modes',' Get an array of all supported modes','   array mcrypt_list_modes ([string lib_dir])');
INSERT INTO "php_manual" VALUES (807,'mcrypt_get_iv_size',' Returns the size of the IV belonging to a','   int mcrypt_get_iv_size (string cipher, string mode)');
INSERT INTO "php_manual" VALUES (808,'mcrypt_encrypt',' Encrypts plaintext with given parameters','   string mcrypt_encrypt (string cipher, string key, string data, string');
INSERT INTO "php_manual" VALUES (809,'mcrypt_decrypt',' Decrypts crypttext with given parameters','   string mcrypt_decrypt (string cipher, string key, string data, string');
INSERT INTO "php_manual" VALUES (810,'mcrypt_module_open',' This function opens the module of the algorithm','   resource mcrypt_module_open (string algorithm, string');
INSERT INTO "php_manual" VALUES (811,'mcrypt_generic_init',' This function initializes all buffers needed','   int mcrypt_generic_init (resource td, string key, string iv)');
INSERT INTO "php_manual" VALUES (812,'mcrypt_generic',' This function encrypts data','   string mcrypt_generic (resource td, string data)');
INSERT INTO "php_manual" VALUES (813,'mdecrypt_generic',' This function decrypts data','   string mdecrypt_generic (resource td, string data)');
INSERT INTO "php_manual" VALUES (814,'mcrypt_generic_end',' This function terminates encryption','   bool mcrypt_generic_end (resource td)');
INSERT INTO "php_manual" VALUES (815,'mcrypt_enc_self_test',' This function runs a self test on the opened','   int mcrypt_enc_self_test (resource td)');
INSERT INTO "php_manual" VALUES (816,'mcrypt_enc_is_block_algorithm_mode',' Checks whether the encryption of','   int mcrypt_enc_is_block_algorithm_mode (resource td)');
INSERT INTO "php_manual" VALUES (817,'mcrypt_enc_is_block_algorithm',' Checks whether the algorithm of the','   int mcrypt_enc_is_block_algorithm (resource td)');
INSERT INTO "php_manual" VALUES (818,'mcrypt_enc_is_block_mode',' Checks whether the opened mode outputs','   int mcrypt_enc_is_block_mode (resource td)');
INSERT INTO "php_manual" VALUES (819,'mcrypt_enc_get_block_size',' Returns the blocksize of the opened','   int mcrypt_enc_get_block_size (resource td)');
INSERT INTO "php_manual" VALUES (820,'mcrypt_enc_get_key_size',' Returns the maximum supported keysize of','   int mcrypt_enc_get_key_size (resource td)');
INSERT INTO "php_manual" VALUES (821,'mcrypt_enc_get_supported_key_sizes',' Returns an array with the','   array mcrypt_enc_get_supported_key_sizes (resource td)');
INSERT INTO "php_manual" VALUES (822,'mcrypt_enc_get_iv_size',' Returns the size of the IV of the opened','   int mcrypt_enc_get_iv_size (resource td)');
INSERT INTO "php_manual" VALUES (823,'mcrypt_enc_get_algorithms_name',' Returns the name of the opened','   string mcrypt_enc_get_algorithms_name (resource td)');
INSERT INTO "php_manual" VALUES (824,'mcrypt_enc_get_modes_name',' Returns the name of the opened mode','   string mcrypt_enc_get_modes_name (resource td)');
INSERT INTO "php_manual" VALUES (825,'mcrypt_module_self_test',' This function runs a self test on the','   bool mcrypt_module_self_test (string algorithm [, string lib_dir])');
INSERT INTO "php_manual" VALUES (826,'mcrypt_module_is_block_algorithm_mode',' This function returns if the','   bool mcrypt_module_is_block_algorithm_mode (string mode [, string');
INSERT INTO "php_manual" VALUES (827,'mcrypt_module_is_block_algorithm',' This function checks whether the','   bool mcrypt_module_is_block_algorithm (string algorithm [, string');
INSERT INTO "php_manual" VALUES (828,'mcrypt_module_is_block_mode',' This function returns if the the','   bool mcrypt_module_is_block_mode (string mode [, string lib_dir])');
INSERT INTO "php_manual" VALUES (829,'mcrypt_module_get_algo_block_size',' Returns the blocksize of the','   int mcrypt_module_get_algo_block_size (string algorithm [, string');
INSERT INTO "php_manual" VALUES (830,'mcrypt_module_get_algo_key_size',' Returns the maximum supported','   int mcrypt_module_get_algo_key_size (string algorithm [, string');
INSERT INTO "php_manual" VALUES (831,'mcrypt_module_get_algo_supported_key_sizes',' Returns an array with','   array mcrypt_module_enc_get_algo_supported_key_sizes (string algorithm');
INSERT INTO "php_manual" VALUES (832,'mhash_get_hash_name',' Get the name of the specified hash','   string mhash_get_hash_name (int hash)');
INSERT INTO "php_manual" VALUES (833,'mhash_get_block_size',' Get the block size of the specified hash','   int mhash_get_block_size (int hash)');
INSERT INTO "php_manual" VALUES (834,'mhash_count',' Get the highest available hash id','   int mhash_count (void)');
INSERT INTO "php_manual" VALUES (835,'mhash',' Compute hash','   string mhash (int hash, string data, string [ key ])');
INSERT INTO "php_manual" VALUES (836,'mhash_keygen_s2k',' Generates a key','   string mhash_keygen_s2k (int hash, string password, string salt, int');
INSERT INTO "php_manual" VALUES (837,'mssql_close',' Close MS SQL Server connection','   int mssql_close ([int link_identifier])');
INSERT INTO "php_manual" VALUES (838,'mssql_connect',' Open MS SQL server connection','   int mssql_connect ([string servername [, string username [, string');
INSERT INTO "php_manual" VALUES (839,'mssql_data_seek',' Move internal row pointer','   int mssql_data_seek (int result_identifier, int row_number)');
INSERT INTO "php_manual" VALUES (840,'mssql_fetch_array',' Fetch row as array','   int mssql_fetch_array (int result)');
INSERT INTO "php_manual" VALUES (841,'mssql_fetch_field',' Get field information','   object mssql_fetch_field (int result [, int field_offset])');
INSERT INTO "php_manual" VALUES (842,'mssql_fetch_object',' Fetch row as object','   int mssql_fetch_object (int result)');
INSERT INTO "php_manual" VALUES (843,'mssql_fetch_row',' Get row as enumerated array','   array mssql_fetch_row (int result)');
INSERT INTO "php_manual" VALUES (844,'mssql_field_length',' Get the length of a field','   int mssql_field_length (int result [, int offset])');
INSERT INTO "php_manual" VALUES (845,'mssql_field_name',' Get the name of a field','   int mssql_field_name (int result [, int offset])');
INSERT INTO "php_manual" VALUES (846,'mssql_field_seek',' Set field offset','   int mssql_field_seek (int result, int field_offset)');
INSERT INTO "php_manual" VALUES (847,'mssql_field_type',' Get the type of a field','   string mssql_field_type (int result [, int offset])');
INSERT INTO "php_manual" VALUES (848,'mssql_free_result',' Free result memory','   int mssql_free_result (int result)');
INSERT INTO "php_manual" VALUES (849,'mssql_get_last_message','  Returns the last message from server (over','   string mssql_get_last_message (void )');
INSERT INTO "php_manual" VALUES (850,'mssql_min_error_severity',' Sets the lower error severity','   void mssql_min_error_severity (int severity)');
INSERT INTO "php_manual" VALUES (851,'mssql_min_message_severity',' Sets the lower message severity','   void mssql_min_message_severity (int severity)');
INSERT INTO "php_manual" VALUES (852,'mssql_num_fields',' Get number of fields in result','   int mssql_num_fields (int result)');
INSERT INTO "php_manual" VALUES (853,'mssql_num_rows',' Get number of rows in result','   int mssql_num_rows (string result)');
INSERT INTO "php_manual" VALUES (854,'mssql_pconnect',' Open persistent MS SQL connection','   int mssql_pconnect ([string servername [, string username [, string');
INSERT INTO "php_manual" VALUES (855,'mssql_query',' Send MS SQL query','   int mssql_query (string query [, int link_identifier])');
INSERT INTO "php_manual" VALUES (856,'mssql_result',' Get result data','   int mssql_result (int result, int i, mixed field)');
INSERT INTO "php_manual" VALUES (857,'mssql_select_db',' Select MS SQL database','   int mssql_select_db (string database_name [, int link_identifier])');
INSERT INTO "php_manual" VALUES (858,'SWFMovie',' Creates a new movie object, representing an SWF version 4','   new swfmovie (void)');
INSERT INTO "php_manual" VALUES (859,'SWFMovie->output',' Dumps your lovingly prepared movie out.','   string swfmovie->output (void)');
INSERT INTO "php_manual" VALUES (860,'SWFMovie->save',' Saves your movie in a file.','   string swfmovie->save (string filename)');
INSERT INTO "php_manual" VALUES (861,'SWFMovie->add',' Adds any type of data to a movie.','   string swfmovie->add (ressource instance)');
INSERT INTO "php_manual" VALUES (862,'SWFMovie->remove',' Removes the object instance from the display list.','   string swfmovie->remove (ressource instance)');
INSERT INTO "php_manual" VALUES (863,'SWFMovie->setbackground',' Sets the background color.','   string swfmovie->setbackground (int red, int green, int blue)');
INSERT INTO "php_manual" VALUES (864,'SWFMovie->setrate',' Sets the animation\'s frame rate.','   string swfmovie->setrate (int rate)');
INSERT INTO "php_manual" VALUES (865,'SWFMovie->setdimension',' Sets the movie\'s width and height.','   string swfmovie->setdimension (int width, int height)');
INSERT INTO "php_manual" VALUES (866,'SWFMovie->setframes',' Sets the total number of frames in the','   string swfmovie->setframes (string numberofframes)');
INSERT INTO "php_manual" VALUES (867,'SWFMovie->nextframe',' Moves to the next frame of the animation.','   string swfmovie->nextframe (void)');
INSERT INTO "php_manual" VALUES (868,'SWFMovie->streammp3',' Streams a MP3 file.','   string swfmovie->streammp3 (string mp3FileName)');
INSERT INTO "php_manual" VALUES (869,'SWFDisplayItem',' Creates a new displayitem object.','   new swfdisplayitem (void)');
INSERT INTO "php_manual" VALUES (870,'SWFDisplayItem->moveTo',' Moves object in global coordinates.','   bool swfdisplayitem->moveto (int x, int y)');
INSERT INTO "php_manual" VALUES (871,'SWFDisplayItem->move',' Moves object in relative coordinates.','   bool swfdisplayitem->move (int dx, int dy)');
INSERT INTO "php_manual" VALUES (872,'SWFDisplayItem->scaleTo',' Scales the object in global coordinates.','   bool swfdisplayitem->scaleto (int x, int y)');
INSERT INTO "php_manual" VALUES (873,'SWFDisplayItem->scale',' Scales the object in relative coordinates.','   bool swfdisplayitem->scale (int dx, int dy)');
INSERT INTO "php_manual" VALUES (874,'SWFDisplayItem->rotateTo',' Rotates the object in global coordinates.','   bool swfdisplayitem->rotateto (FLOAT8degrees)');
INSERT INTO "php_manual" VALUES (875,'SWFDisplayItem->Rotate',' Rotates in relative coordinates.','   bool swfdisplayitem->rotate (FLOAT8ddegrees)');
INSERT INTO "php_manual" VALUES (876,'SWFDisplayItem->skewXTo',' Sets the X-skew.','   bool swfdisplayitem->skewxto (FLOAT8degrees)');
INSERT INTO "php_manual" VALUES (877,'SWFDisplayItem->skewX',' Sets the X-skew.','   bool swfdisplayitem->skewx (FLOAT8ddegrees)');
INSERT INTO "php_manual" VALUES (878,'SWFDisplayItem->skewYTo',' Sets the Y-skew.','   bool swfdisplayitem->skewyto (FLOAT8degrees)');
INSERT INTO "php_manual" VALUES (879,'SWFDisplayItem->skewY',' Sets the Y-skew.','   bool swfdisplayitem->skewy (FLOAT8ddegrees)');
INSERT INTO "php_manual" VALUES (880,'SWFDisplayItem->setDepth',' Sets z-order','   bool swfdisplayitem->setdepth (FLOAT8depth)');
INSERT INTO "php_manual" VALUES (881,'SWFDisplayItem->remove',' Removes the object from the movie','   bool swfdisplayitem->remove (void)');
INSERT INTO "php_manual" VALUES (882,'SWFDisplayItem->setName',' Sets the object\'s name','   bool swfdisplayitem->setname (string name)');
INSERT INTO "php_manual" VALUES (883,'SWFDisplayItem->setRatio',' Sets the object\'s ratio to ratio.','   void swfdisplayitem->setratio (FLOAT8ratio)');
INSERT INTO "php_manual" VALUES (884,'SWFDisplayItem->addColor',' Adds the given color to this item\'s color','   bool swfdisplayitem->addcolor ([integer red [, integer green [,');
INSERT INTO "php_manual" VALUES (885,'SWFDisplayItem->multColor',' Multiplies the item\'s color transform.','   bool swfdisplayitem->multcolor ([integer red [, integer green [,');
INSERT INTO "php_manual" VALUES (886,'SWFShape',' Creates a new shape object.','   new swfshape (void)');
INSERT INTO "php_manual" VALUES (887,'SWFShape->setLine',' Sets the shape\'s line style.','   bool swfshape->setline (int width [, integer red [, integer green [,');
INSERT INTO "php_manual" VALUES (888,'SWFShape->addFill',' Adds a solid fill to the shape.','   string swfshape->addfill (integer red, integer green, integer blue [,');
INSERT INTO "php_manual" VALUES (889,'SWFShape->setLeftFill',' Sets left rasterizing color.','   string swfshape->setleftfill (swfgradient fill)');
INSERT INTO "php_manual" VALUES (890,'SWFShape->setRightFill',' Sets right rasterizing color.','   string swfshape->setrightfill (swfgradient fill)');
INSERT INTO "php_manual" VALUES (891,'SWFShape->movePenTo',' Moves the shape\'s pen.','   string swfshape->movepento (integer x, integer y)');
INSERT INTO "php_manual" VALUES (892,'SWFShape->movePen',' Moves the shape\'s pen (relative).','   string swfshape->movepen (integer dx, integer dy)');
INSERT INTO "php_manual" VALUES (893,'SWFShape->drawLineTo',' Draws a line.','   string swfshape->drawlineto (integer x, integer y)');
INSERT INTO "php_manual" VALUES (894,'SWFShape->drawLine',' Draws a line (relative).','   string swfshape->drawline (integer dx, integer dy)');
INSERT INTO "php_manual" VALUES (895,'SWFShape->drawCurveTo',' Draws a curve.','   string swfshape->drawcurveto (integer controlx, integer controly,');
INSERT INTO "php_manual" VALUES (896,'SWFShape->drawCurve',' Draws a curve (relative).','   string swfshape->drawcurve (integer controldx, integer controldy,');
INSERT INTO "php_manual" VALUES (897,'SWFGradient',' Loads a font definition','   new swfgradient (void)');
INSERT INTO "php_manual" VALUES (898,'SWFGradient->addEntry',' Adds an entry to the gradient list.','   string swfgradient->addentry (FLOAT8ratio, integer red, integer');
INSERT INTO "php_manual" VALUES (899,'SWFBitmap',' Loads Bitmap object','   new swfbitmap (string filename [, integer alphafilename])');
INSERT INTO "php_manual" VALUES (900,'SWFBitmap->getWidth',' Returns the bitmap\'s width.','   int swfbitmap->getwidth (void)');
INSERT INTO "php_manual" VALUES (901,'SWFBitmap->getHeight',' Returns the bitmap\'s height.','   int swfbitmap->getheight (void)');
INSERT INTO "php_manual" VALUES (902,'SWFFill',' Loads SWFFill object','   The swffill() object allows you to transform (scale, skew, rotate)');
INSERT INTO "php_manual" VALUES (903,'SWFFill->moveTo',' Moves fill origin','   int swffill->moveto (integer x, integer y)');
INSERT INTO "php_manual" VALUES (904,'SWFFill->scaleTo',' Sets fill\'s scale','   int swffill->scaleto (integer x, integer y)');
INSERT INTO "php_manual" VALUES (905,'SWFFill->rotateTo',' Sets fill\'s rotation','   int swffill->rotateto (FLOAT8degrees)');
INSERT INTO "php_manual" VALUES (906,'SWFFill->skewXTo',' Sets fill x-skew','   int swffill->skewxto (FLOAT8x)');
INSERT INTO "php_manual" VALUES (907,'SWFFill->skewYTo',' Sets fill y-skew','   int swffill->skewyto (FLOAT8y)');
INSERT INTO "php_manual" VALUES (908,'SWFMorph',' Creates a new SWFMorph object.','   new swfmorph (void)');
INSERT INTO "php_manual" VALUES (909,'SWFMorph->getshape1',' Gets a handle to the starting shape','   int swfmorph->getshape1 (void)');
INSERT INTO "php_manual" VALUES (910,'SWFMorph->getshape2',' Gets a handle to the ending shape','   int swfmorph->getshape2 (void)');
INSERT INTO "php_manual" VALUES (911,'SWFMorph',' Creates a new SWFText object.','   new swftext (void)');
INSERT INTO "php_manual" VALUES (912,'SWFText->setFont',' Sets the current font','   int swftext->setfont (string font)');
INSERT INTO "php_manual" VALUES (913,'SWFText->setHeight',' Sets the current font heigh','   int swftext->setheight (integer height)');
INSERT INTO "php_manual" VALUES (914,'SWFText->setSpacing',' Sets the current font spacing','   int swftext->setspacing (FLOAT8spacing)');
INSERT INTO "php_manual" VALUES (915,'SWFText->setColor',' Sets the current font heigh','   int swftext->setcolor (integer red, integer green, integer blue [,');
INSERT INTO "php_manual" VALUES (916,'SWFText->moveTo',' Moves the pen','   int swftext->moveto (integer x, integer y)');
INSERT INTO "php_manual" VALUES (917,'SWFText->addString',' Draws a string','   int swftext->addstring (string string)');
INSERT INTO "php_manual" VALUES (918,'SWFText->getWidth',' Computes string\'s width','   int swftext->addstring (string string)');
INSERT INTO "php_manual" VALUES (919,'SWFFont',' Loads a font definition','   new swffont (string filename)');
INSERT INTO "php_manual" VALUES (920,'getwidth',' Returns the string\'s width','   string swffont->getwidth (string string)');
INSERT INTO "php_manual" VALUES (921,'SWFTextField',' Creates a text field object','   new swftextfield ([int flags])');
INSERT INTO "php_manual" VALUES (922,'SWFTextField->setFont',' Sets the text field font','   int swftextfield->setfont (string font)');
INSERT INTO "php_manual" VALUES (923,'SWFTextField->setbounds',' Sets the text field width and height','   int swftextfield->setbounds (int width, int height)');
INSERT INTO "php_manual" VALUES (924,'SWFTextField->align',' Sets the text field width and height','   int swftextfield->align (int alignement)');
INSERT INTO "php_manual" VALUES (925,'SWFTextField->setHeight',' Sets the font height of this text field','   int swftextfield->setheight (int height)');
INSERT INTO "php_manual" VALUES (926,'SWFTextField->setLeftMargin',' Sets the left margin width of the text','   int swftextfield->setleftmargin (int width)');
INSERT INTO "php_manual" VALUES (927,'SWFTextField->setrightMargin',' Sets the right margin width of the','   int swftextfield->setrightmargin (int width)');
INSERT INTO "php_manual" VALUES (928,'SWFTextField->setMargins',' Sets the margins width of the text field.','   int swftextfield->setmargins (int left, int right)');
INSERT INTO "php_manual" VALUES (929,'SWFTextField->setindentation',' Sets the indentation of the first','   int swftextfield->setindentation (int width)');
INSERT INTO "php_manual" VALUES (930,'SWFTextField->setLineSpacing',' Sets the line spacing of the text','   int swftextfield->setlinespacing (int height)');
INSERT INTO "php_manual" VALUES (931,'SWFTextField->setcolor',' Sets the color of the text field.','   int swftextfield->setcolor (integer red, integer green, integer blue');
INSERT INTO "php_manual" VALUES (932,'SWFTextField->setname',' Sets the variable name','   int swftextfield->setname (string name)');
INSERT INTO "php_manual" VALUES (933,'SWFTextField->addstring',' Concatenates the given string to the text','   int swftextfield->addstring (string string)');
INSERT INTO "php_manual" VALUES (934,'SWFSprite',' Creates a movie clip (a sprite)','   new swfsprite (void)');
INSERT INTO "php_manual" VALUES (935,'SWFSprite->add',' Adds an object to a sprite','   string swfsprite->add (ressource object)');
INSERT INTO "php_manual" VALUES (936,'SWFSprite->remove',' Removes an object to a sprite','   string swfsprite->remove (ressource object)');
INSERT INTO "php_manual" VALUES (937,'SWFSprite->setframes',' Sets the total number of frames in the','   string swfsprite->setframes (string numberofframes)');
INSERT INTO "php_manual" VALUES (938,'SWFSprite->nextframe',' Moves to the next frame of the animation.','   string swfsprite->nextframe (void)');
INSERT INTO "php_manual" VALUES (939,'SWFbutton',' Creates a new Button.','   new swfbutton (void)');
INSERT INTO "php_manual" VALUES (940,'SWFbutton->addShape',' Adds an object to a sprite','   string swfbutton->addshape (ressource shape, integer flags)');
INSERT INTO "php_manual" VALUES (941,'SWFbutton->setUp',' Alias for addShape(shape, SWFBUTTON_UP)','   string swfbutton->setup (ressource shape)');
INSERT INTO "php_manual" VALUES (942,'SWFbutton->setOver',' Alias for addShape(shape, SWFBUTTON_OVER)','   string swfbutton->setover (ressource shape)');
INSERT INTO "php_manual" VALUES (943,'SWFbutton->setHit',' Alias for addShape(shape, SWFBUTTON_HIT)','   string swfbutton->sethit (ressource shape)');
INSERT INTO "php_manual" VALUES (944,'SWFbutton->setAction',' Sets the action','   string swfbutton->setaction (ressource action)');
INSERT INTO "php_manual" VALUES (945,'SWFAction',' Creates a new Action.','   new swfbutton (string script)');
INSERT INTO "php_manual" VALUES (946,'connection_aborted',' Returns true if client disconnected','   int connection_aborted (void )');
INSERT INTO "php_manual" VALUES (947,'connection_status',' Returns connection status bitfield','   int connection_status (void )');
INSERT INTO "php_manual" VALUES (948,'connection_timeout',' Return true if script timed out','   int connection_timeout (void )');
INSERT INTO "php_manual" VALUES (949,'constant',' Returns the value of a constant','   mixed constant (string name)');
INSERT INTO "php_manual" VALUES (950,'define',' Defines a named constant.','   int define (string name, mixed value [, int case_insensitive])');
INSERT INTO "php_manual" VALUES (951,'defined','  Checks whether a given named constant exists','   int defined (string name)');
INSERT INTO "php_manual" VALUES (952,'die','  Output a message and terminate the current script','   void die (string message)');
INSERT INTO "php_manual" VALUES (953,'eval',' Evaluate a string as PHP code','   mixed eval (string code_str)');
INSERT INTO "php_manual" VALUES (954,'exit',' Terminate current script','   void exit(void);');
INSERT INTO "php_manual" VALUES (955,'get_browser','  Tells what the user\'s browser is capable of','   object get_browser ([string user_agent])');
INSERT INTO "php_manual" VALUES (956,'highlight_file',' Syntax highlighting of a file','   boolean highlight_file (string filename)');
INSERT INTO "php_manual" VALUES (957,'highlight_string',' Syntax highlighting of a string','   boolean highlight_string (string str)');
INSERT INTO "php_manual" VALUES (958,'ignore_user_abort','  Set whether a client disconnect should abort','   int ignore_user_abort ([int setting])');
INSERT INTO "php_manual" VALUES (959,'iptcparse','  Parse a binary IPTC http://www.iptc.org/ block into','   array iptcparse (string iptcblock)');
INSERT INTO "php_manual" VALUES (960,'leak',' Leak memory','   void leak (int bytes)');
INSERT INTO "php_manual" VALUES (961,'pack',' Pack data into binary string.','   string pack (string format [, mixed args ...])');
INSERT INTO "php_manual" VALUES (962,'show_source',' Syntax highlighting of a file','   boolean show_source (string filename)');
INSERT INTO "php_manual" VALUES (963,'sleep',' Delay execution','   void sleep (int seconds)');
INSERT INTO "php_manual" VALUES (964,'uniqid',' Generate a unique id','   int uniqid (string prefix [, boolean lcg])');
INSERT INTO "php_manual" VALUES (965,'unpack',' Unpack data from binary string','   array unpack (string format, string data)');
INSERT INTO "php_manual" VALUES (966,'usleep',' Delay execution in microseconds','   void usleep (int micro_seconds)');
INSERT INTO "php_manual" VALUES (967,'udm_add_search_limit',' Add various search limits','   int udm_add_search_limit (int agent, int var, string val)');
INSERT INTO "php_manual" VALUES (968,'udm_alloc_agent',' Allocate mnoGoSearch session','   int udm_alloc_agent (string dbaddr [, string dbmode])');
INSERT INTO "php_manual" VALUES (969,'udm_api_version',' Get mnoGoSearch API version.','   int udm_api_version ()');
INSERT INTO "php_manual" VALUES (970,'\"<br>\\n\";','','   int udm_clear_search_limits (int agent)');
INSERT INTO "php_manual" VALUES (971,'udm_errno',' Get mnoGoSearch error number','   int udm_errno (int agent)');
INSERT INTO "php_manual" VALUES (972,'udm_error',' Get mnoGoSearch error message','   string udm_error (int agent)');
INSERT INTO "php_manual" VALUES (973,'udm_find',' Perform search','   int udm_find (int agent, string query)');
INSERT INTO "php_manual" VALUES (974,'udm_free_agent',' Free mnoGoSearch session','   int udm_free_agent (int agent)');
INSERT INTO "php_manual" VALUES (975,'udm_free_ispell_data',' Free memory allocated for ispell data','   int udm_free_ispell_data (int agent)');
INSERT INTO "php_manual" VALUES (976,'udm_free_res',' Free mnoGoSearch result','   int udm_free_res (int res)');
INSERT INTO "php_manual" VALUES (977,'udm_get_doc_count',' Get total number of documents in database.','   int udm_get_doc_count (int agent)');
INSERT INTO "php_manual" VALUES (978,'udm_get_res_field',' Fetch mnoGoSearch result field','   string udm_get_res_field (int res, int row, int field)');
INSERT INTO "php_manual" VALUES (979,'udm_get_res_param',' Get mnoGoSearch result parameters','   string udm_get_res_param (int res, int param)');
INSERT INTO "php_manual" VALUES (980,'udm_load_ispell_data',' Load ispell data','   int udm_load_ispell_data (int agent, int var, string val1, string');
INSERT INTO "php_manual" VALUES (981,'udm_set_agent_param',' Set mnoGoSearch agent session parameters','   int udm_set_agent_param (int agent, int var, string val)');
INSERT INTO "php_manual" VALUES (982,'msql',' Send mSQL query','   int msql (string database, string query, int link_identifier)');
INSERT INTO "php_manual" VALUES (983,'msql_affected_rows',' Returns number of affected rows','   int msql_affected_rows (int query_identifier)');
INSERT INTO "php_manual" VALUES (984,'msql_close',' Close mSQL connection','   int msql_close (int link_identifier)');
INSERT INTO "php_manual" VALUES (985,'msql_connect',' Open mSQL connection','   int msql_connect ([string hostname [, string hostname[:port] [, string');
INSERT INTO "php_manual" VALUES (986,'msql_create_db',' Create mSQL database','   int msql_create_db (string database name [, int link_identifier])');
INSERT INTO "php_manual" VALUES (987,'msql_createdb',' Create mSQL database','   int msql_createdb (string database name [, int link_identifier])');
INSERT INTO "php_manual" VALUES (988,'msql_data_seek',' Move internal row pointer','   int msql_data_seek (int query_identifier, int row_number)');
INSERT INTO "php_manual" VALUES (989,'msql_dbname',' Get current mSQL database name','   string msql_dbname (int query_identifier, int i)');
INSERT INTO "php_manual" VALUES (990,'msql_drop_db',' Drop (delete) mSQL database','   int msql_drop_db (string database_name, int link_identifier)');
INSERT INTO "php_manual" VALUES (991,'msql_dropdb',' Drop (delete) mSQL database','   See msql_drop_db().');
INSERT INTO "php_manual" VALUES (992,'msql_error',' Returns error message of last msql call','   string msql_error ()');
INSERT INTO "php_manual" VALUES (993,'msql_fetch_array',' Fetch row as array','   int msql_fetch_array (int query_identifier [, int result_type])');
INSERT INTO "php_manual" VALUES (994,'msql_fetch_field',' Get field information','   object msql_fetch_field (int query_identifier, int field_offset)');
INSERT INTO "php_manual" VALUES (995,'msql_fetch_object',' Fetch row as object','   int msql_fetch_object (int query_identifier [, int result_type])');
INSERT INTO "php_manual" VALUES (996,'msql_fetch_row',' Get row as enumerated array','   array msql_fetch_row (int query_identifier)');
INSERT INTO "php_manual" VALUES (997,'msql_fieldname',' Get field name','   string msql_fieldname (int query_identifier, int field)');
INSERT INTO "php_manual" VALUES (998,'msql_field_seek',' Set field offset','   int msql_field_seek (int query_identifier, int field_offset)');
INSERT INTO "php_manual" VALUES (999,'msql_fieldtable',' Get table name for field','   int msql_fieldtable (int query_identifier, int field)');
INSERT INTO "php_manual" VALUES (1000,'msql_fieldtype',' Get field type','   string msql_fieldtype (int query_identifier, int i)');
INSERT INTO "php_manual" VALUES (1001,'msql_fieldflags',' Get field flags','   string msql_fieldflags (int query_identifier, int i)');
INSERT INTO "php_manual" VALUES (1002,'msql_fieldlen',' Get field length','   int msql_fieldlen (int query_identifier, int i)');
INSERT INTO "php_manual" VALUES (1003,'msql_free_result',' Free result memory','   int msql_free_result (int query_identifier)');
INSERT INTO "php_manual" VALUES (1004,'msql_freeresult',' Free result memory','   See msql_free_result()');
INSERT INTO "php_manual" VALUES (1005,'msql_list_fields',' List result fields','   int msql_list_fields (string database, string tablename)');
INSERT INTO "php_manual" VALUES (1006,'msql_listfields',' List result fields','   See msql_list_fields().');
INSERT INTO "php_manual" VALUES (1007,'msql_list_dbs',' List mSQL databases on server','   int msql_list_dbs(void);');
INSERT INTO "php_manual" VALUES (1008,'msql_listdbs',' List mSQL databases on server','   See msql_list_dbs().');
INSERT INTO "php_manual" VALUES (1009,'msql_list_tables',' List tables in an mSQL database','   int msql_list_tables (string database)');
INSERT INTO "php_manual" VALUES (1010,'msql_listtables',' List tables in an mSQL database','   See msql_list_tables().');
INSERT INTO "php_manual" VALUES (1011,'msql_num_fields',' Get number of fields in result','   int msql_num_fields (int query_identifier)');
INSERT INTO "php_manual" VALUES (1012,'msql_num_rows',' Get number of rows in result','   int msql_num_rows (int query_identifier)');
INSERT INTO "php_manual" VALUES (1013,'msql_numfields',' Get number of fields in result','   int msql_numfields (int query_identifier)');
INSERT INTO "php_manual" VALUES (1014,'msql_numrows',' Get number of rows in result','   int msql_numrows(void);');
INSERT INTO "php_manual" VALUES (1015,'msql_pconnect',' Open persistent mSQL connection','   int msql_pconnect ([string hostname [, string hostname[:port] [,');
INSERT INTO "php_manual" VALUES (1016,'msql_query',' Send mSQL query','   int msql_query (string query, int link_identifier)');
INSERT INTO "php_manual" VALUES (1017,'msql_regcase','  Make regular expression for case insensitive match','   See sql_regcase().');
INSERT INTO "php_manual" VALUES (1018,'msql_result',' Get result data','   int msql_result (int query_identifier, int i, mixed field)');
INSERT INTO "php_manual" VALUES (1019,'msql_select_db',' Select mSQL database','   int msql_select_db (string database_name, int link_identifier)');
INSERT INTO "php_manual" VALUES (1020,'msql_selectdb',' Select mSQL database','   See msql_select_db().');
INSERT INTO "php_manual" VALUES (1021,'msql_tablename',' Get table name of field','   string msql_tablename (int query_identifier, int field)');
INSERT INTO "php_manual" VALUES (1022,'mysql_affected_rows',' Get number of affected rows in previous MySQL','   int mysql_affected_rows ([int link_identifier])');
INSERT INTO "php_manual" VALUES (1023,'mysql_change_user','  Change logged in user of the active connection','   int mysql_change_user (string user, string password [, string database');
INSERT INTO "php_manual" VALUES (1024,'mysql_close',' Close MySQL connection','   int mysql_close ([int link_identifier])');
INSERT INTO "php_manual" VALUES (1025,'mysql_connect',' Open a connection to a MySQL Server','   int mysql_connect ([string hostname [:port] [:/path/to/socket] [,');
INSERT INTO "php_manual" VALUES (1026,'mysql_create_db',' Create a MySQL database','   int mysql_create_db (string database name [, int link_identifier])');
INSERT INTO "php_manual" VALUES (1027,'mysql_data_seek',' Move internal result pointer','   int mysql_data_seek (int result_identifier, int row_number)');
INSERT INTO "php_manual" VALUES (1028,'mysql_db_name',' Get result data','   int mysql_db_name (int result, int row [, mixed field])');
INSERT INTO "php_manual" VALUES (1029,'mysql_db_query',' Send a MySQL query','   int mysql_db_query (string database, string query [, int');
INSERT INTO "php_manual" VALUES (1030,'mysql_drop_db',' Drop (delete) a MySQL database','   int mysql_drop_db (string database_name [, int link_identifier])');
INSERT INTO "php_manual" VALUES (1031,'mysql_errno',' Returns the numerical value of the error message from','   int mysql_errno ([int link_identifier])');
INSERT INTO "php_manual" VALUES (1032,'mysql_error',' Returns the text of the error message from previous','   string mysql_error ([int link_identifier])');
INSERT INTO "php_manual" VALUES (1033,'mysql_fetch_array','  Fetch a result row as an associative array, a','   array mysql_fetch_array (int result [, int result_type])');
INSERT INTO "php_manual" VALUES (1034,'mysql_fetch_assoc','  Fetch a result row as an associative array','   array mysql_fetch_assoc (int result)');
INSERT INTO "php_manual" VALUES (1035,'mysql_fetch_field','  Get column information from a result and return','   object mysql_fetch_field (int result [, int field_offset])');
INSERT INTO "php_manual" VALUES (1036,'mysql_fetch_lengths','  Get the length of each output in a result','   array mysql_fetch_lengths (int result)');
INSERT INTO "php_manual" VALUES (1037,'mysql_fetch_object',' Fetch a result row as an object','   object mysql_fetch_object (int result [, int result_type])');
INSERT INTO "php_manual" VALUES (1038,'mysql_fetch_row',' Get a result row as an enumerated array','   array mysql_fetch_row (int result)');
INSERT INTO "php_manual" VALUES (1039,'mysql_field_flags','  Get the flags associated with the specified','   string mysql_field_flags (int result, int field_offset)');
INSERT INTO "php_manual" VALUES (1040,'mysql_field_name','  Get the name of the specified field in a result','   string mysql_field_name (int result, int field_index)');
INSERT INTO "php_manual" VALUES (1041,'mysql_field_len','  Returns the length of the specified field','   int mysql_field_len (int result, int field_offset)');
INSERT INTO "php_manual" VALUES (1042,'mysql_field_seek','  Set result pointer to a specified field offset','   int mysql_field_seek (int result, int field_offset)');
INSERT INTO "php_manual" VALUES (1043,'mysql_field_table','  Get name of the table the specified field is in','   string mysql_field_table (int result, int field_offset)');
INSERT INTO "php_manual" VALUES (1044,'mysql_field_type','  Get the type of the specified field in a result','   string mysql_field_type (int result, int field_offset)');
INSERT INTO "php_manual" VALUES (1045,'mysql_free_result',' Free result memory','   int mysql_free_result (int result)');
INSERT INTO "php_manual" VALUES (1046,'mysql_insert_id','  Get the id generated from the previous INSERT','   int mysql_insert_id ([int link_identifier])');
INSERT INTO "php_manual" VALUES (1047,'mysql_list_dbs','  List databases available on a MySQL server','   int mysql_list_dbs ([int link_identifier])');
INSERT INTO "php_manual" VALUES (1048,'mysql_list_fields',' List MySQL result fields','   int mysql_list_fields (string database_name, string table_name [, int');
INSERT INTO "php_manual" VALUES (1049,'mysql_list_tables',' List tables in a MySQL database','   int mysql_list_tables (string database [, int link_identifier])');
INSERT INTO "php_manual" VALUES (1050,'mysql_num_fields',' Get number of fields in result','   int mysql_num_fields (int result)');
INSERT INTO "php_manual" VALUES (1051,'mysql_num_rows',' Get number of rows in result','   int mysql_num_rows (int result)');
INSERT INTO "php_manual" VALUES (1052,'mysql_pconnect','  Open a persistent connection to a MySQL Server','   int mysql_pconnect ([string hostname [:port] [:/path/to/socket] [,');
INSERT INTO "php_manual" VALUES (1053,'mysql_query',' Send a MySQL query','   int mysql_query (string query [, int link_identifier])');
INSERT INTO "php_manual" VALUES (1054,'mysql_result',' Get result data','   mixed mysql_result (int result, int row [, mixed field])');
INSERT INTO "php_manual" VALUES (1055,'mysql_select_db',' Select a MySQL database','   int mysql_select_db (string database_name [, int link_identifier])');
INSERT INTO "php_manual" VALUES (1056,'mysql_tablename',' Get table name of field','   string mysql_tablename (int result, int i)');
INSERT INTO "php_manual" VALUES (1057,'checkdnsrr','  Check DNS records corresponding to a given Internet','   int checkdnsrr (string host [, string type])');
INSERT INTO "php_manual" VALUES (1058,'closelog',' Close connection to system logger','   int closelog(void);');
INSERT INTO "php_manual" VALUES (1059,'debugger_off',' Disable internal PHP debugger','   int debugger_off(void);');
INSERT INTO "php_manual" VALUES (1060,'debugger_on',' Enable internal PHP debugger','   int debugger_on (string address)');
INSERT INTO "php_manual" VALUES (1061,'define_syslog_variables',' Initializes all syslog related constants','   void define_syslog_varaibles (void)');
INSERT INTO "php_manual" VALUES (1062,'fsockopen','  Open Internet or Unix domain socket connection','   int fsockopen (string [udp://]hostname, int port [, int errno [,');
INSERT INTO "php_manual" VALUES (1063,'gethostbyaddr','  Get the Internet host name corresponding to a given','   string gethostbyaddr (string ip_address)');
INSERT INTO "php_manual" VALUES (1064,'gethostbyname','  Get the IP address corresponding to a given Internet','   string gethostbyname (string hostname)');
INSERT INTO "php_manual" VALUES (1065,'gethostbynamel','  Get a list of IP addresses corresponding to a given','   array gethostbynamel (string hostname)');
INSERT INTO "php_manual" VALUES (1066,'getmxrr','  Get MX records corresponding to a given Internet host name','   int getmxrr (string hostname, array mxhosts [, array weight])');
INSERT INTO "php_manual" VALUES (1067,'getprotobyname','  Get protocol number associated with protocol name','   int getprotobyname (string name)');
INSERT INTO "php_manual" VALUES (1068,'getprotobynumber','  Get protocol name associated with protocol number','   string getprotobynumber (int number)');
INSERT INTO "php_manual" VALUES (1069,'getservbyname','  Get port number associated with an Internet service','   int getservbyname (string service, string protocol)');
INSERT INTO "php_manual" VALUES (1070,'getservbyport','  Get Internet service which corresponds to port and','   string getservbyport (int port, string protocol)');
INSERT INTO "php_manual" VALUES (1071,'ip2long','  Converts a string containing an (IPv4) Internet Protocol','   int ip2long (string ip_address)');
INSERT INTO "php_manual" VALUES (1072,'long2ip','  Converts an (IPv4) Internet network address into a string','   string long2ip (int proper_address)');
INSERT INTO "php_manual" VALUES (1073,'openlog',' Open connection to system logger','   int openlog (string ident, int option, int facility)');
INSERT INTO "php_manual" VALUES (1074,'pfsockopen','  Open persistent Internet or Unix domain socket','   int pfsockopen (string hostname, int port [, int errno [, string');
INSERT INTO "php_manual" VALUES (1075,'socket_get_status','  Returns information about existing socket','   array socket_get_status (resource socket_get_status)');
INSERT INTO "php_manual" VALUES (1076,'socket_set_blocking',' Set blocking/non-blocking mode on a socket','   int socket_set_blocking (int socket descriptor, int mode)');
INSERT INTO "php_manual" VALUES (1077,'socket_set_timeout',' Set timeout period on a socket','   bool socket_set_timeout (int socket descriptor, int seconds, int');
INSERT INTO "php_manual" VALUES (1078,'syslog',' Generate a system log message','   int syslog (int priority, string message)');
INSERT INTO "php_manual" VALUES (1079,'odbc_autocommit',' Toggle autocommit behaviour','   int odbc_autocommit (int connection_id [, int OnOff])');
INSERT INTO "php_manual" VALUES (1080,'odbc_binmode',' Handling of binary column data','   int odbc_binmode (int result_id, int mode)');
INSERT INTO "php_manual" VALUES (1081,'odbc_close',' Close an ODBC connection','   void odbc_close (int connection_id)');
INSERT INTO "php_manual" VALUES (1082,'odbc_close_all',' Close all ODBC connections','   void odbc_close_all(void);');
INSERT INTO "php_manual" VALUES (1083,'odbc_commit',' Commit an ODBC transaction','   int odbc_commit (int connection_id)');
INSERT INTO "php_manual" VALUES (1084,'odbc_connect',' Connect to a datasource','   int odbc_connect (string dsn, string user, string password [, int');
INSERT INTO "php_manual" VALUES (1085,'odbc_cursor',' Get cursorname','   string odbc_cursor (int result_id)');
INSERT INTO "php_manual" VALUES (1086,'odbc_do',' Synonym for odbc_exec()','   int odbc_do (int conn_id, string query)');
INSERT INTO "php_manual" VALUES (1087,'odbc_error',' Get the last error code','   int odbc_error ([int connection_id])');
INSERT INTO "php_manual" VALUES (1088,'odbc_errormsg',' Get the last error message','   int odbc_errormsg ([int connection_id])');
INSERT INTO "php_manual" VALUES (1089,'odbc_exec',' Prepare and execute a SQL statement','   int odbc_exec (int connection_id, string query_string)');
INSERT INTO "php_manual" VALUES (1090,'odbc_execute',' Execute a prepared statement','   int odbc_execute (int result_id [, array parameters_array])');
INSERT INTO "php_manual" VALUES (1091,'odbc_fetch_into',' Fetch one result row into array','   int odbc_fetch_into (int result_id [, int rownumber, array');
INSERT INTO "php_manual" VALUES (1092,'odbc_fetch_row',' Fetch a row','   int odbc_fetch_row (int result_id [, int row_number])');
INSERT INTO "php_manual" VALUES (1093,'odbc_field_name',' Get the columnname','   string odbc_field_name (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1094,'odbc_field_num',' Return column number','   int odbc_field_num (int result_id, string field_name)');
INSERT INTO "php_manual" VALUES (1095,'odbc_field_type',' Datatype of a field','   string odbc_field_type (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1096,'odbc_field_len',' Get the length (precision) of a field','   int odbc_field_len (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1097,'odbc_field_precision',' Synonym for odbc_field_len()','   string odbc_field_precision (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1098,'odbc_field_scale',' Get the scale of a field','   string odbc_field_scale (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1099,'odbc_free_result',' Free resources associated with a result','   int odbc_free_result (int result_id)');
INSERT INTO "php_manual" VALUES (1100,'odbc_longreadlen',' Handling of LONG columns','   int odbc_longreadlen (int result_id, int length)');
INSERT INTO "php_manual" VALUES (1101,'odbc_num_fields',' Number of columns in a result','   int odbc_num_fields (int result_id)');
INSERT INTO "php_manual" VALUES (1102,'odbc_pconnect',' Open a persistent database connection','   int odbc_pconnect (string dsn, string user, string password [, int');
INSERT INTO "php_manual" VALUES (1103,'odbc_prepare',' Prepares a statement for execution','   int odbc_prepare (int connection_id, string query_string)');
INSERT INTO "php_manual" VALUES (1104,'odbc_num_rows',' Number of rows in a result','   int odbc_num_rows (int result_id)');
INSERT INTO "php_manual" VALUES (1105,'odbc_result',' Get result data','   string odbc_result (int result_id, mixed field)');
INSERT INTO "php_manual" VALUES (1106,'odbc_result_all',' Print result as HTML table','   int odbc_result_all (int result_id [, string format])');
INSERT INTO "php_manual" VALUES (1107,'odbc_rollback',' Rollback a transaction','   int odbc_rollback (int connection_id)');
INSERT INTO "php_manual" VALUES (1108,'odbc_setoption','  Adjust ODBC settings. Returns false if an error','   int odbc_setoption (int id, int function, int option, int param)');
INSERT INTO "php_manual" VALUES (1109,'odbc_tables','  Get the list of table names stored in a specific data','   int odbc_tables (int connection_id [, string qualifier [, string owner');
INSERT INTO "php_manual" VALUES (1110,'odbc_tableprivileges','  Lists tables and the privileges associated','   int odbc_tableprivileges (int connection_id [, string qualifier [,');
INSERT INTO "php_manual" VALUES (1111,'odbc_columns','  Lists the column names in specified tables. Returns a','   int odbc_columns (int connection_id [, string qualifier [, string');
INSERT INTO "php_manual" VALUES (1112,'odbc_columnprivileges','  Returns a result identifier that can be used','   int odbc_columnprivileges (int connection_id [, string qualifier [,');
INSERT INTO "php_manual" VALUES (1113,'odbc_gettypeinfo','  Returns a result identifier containing','   int odbc_gettypeinfo (int connection_id [, int data_type])');
INSERT INTO "php_manual" VALUES (1114,'odbc_primarykeys','  Returns a result identifier that can be used to','   int odbc_primarykeys (int connection_id, string qualifier, string');
INSERT INTO "php_manual" VALUES (1115,'odbc_foreignkeys','  Returns a list of foreign keys in the specified','   int odbc_foreignkeys (int connection_id, string pk_qualifier, string');
INSERT INTO "php_manual" VALUES (1116,'odbc_procedures','  Get the list of procedures stored in a specific','   int odbc_procedures (int connection_id [, string qualifier [, string');
INSERT INTO "php_manual" VALUES (1117,'odbc_procedurecolumns','  Retrieve information about parameters to','   int odbc_procedurecolumns (int connection_id [, string qualifier [,');
INSERT INTO "php_manual" VALUES (1118,'odbc_specialcolumns','  Returns either the optimal set of columns that','   int odbc_specialcolumns (int connection_id, int type, string');
INSERT INTO "php_manual" VALUES (1119,'odbc_statistics',' Retrieve statistics about a table','   int odbc_statistics (int connection_id, string qualifier, string');
INSERT INTO "php_manual" VALUES (1120,'OCIDefineByName','  Use a PHP variable for the define-step during a','   int OCIDefineByName (int stmt, string Column-Name, mixed variable [,');
INSERT INTO "php_manual" VALUES (1121,'OCIBindByName','  Bind a PHP variable to an Oracle Placeholder','   int OCIBindByName (int stmt, string ph_name, mixed &variable, int');
INSERT INTO "php_manual" VALUES (1122,'OCILogon',' Establishes a connection to Oracle','   int OCILogon (string username, string password [, string db])');
INSERT INTO "php_manual" VALUES (1123,'OCIPLogon',' Connect to an Oracle database and log on using a','   int OCIPLogon (string username, string password [, string db])');
INSERT INTO "php_manual" VALUES (1124,'OCINLogon',' Connect to an Oracle database and log on using a new','   int OCINLogon (string username, string password [, string db])');
INSERT INTO "php_manual" VALUES (1125,'OCILogOff',' Disconnects from Oracle','   int OCILogOff (int connection)');
INSERT INTO "php_manual" VALUES (1126,'OCIExecute',' Execute a statement','   int OCIExecute (int statement [, int mode])');
INSERT INTO "php_manual" VALUES (1127,'OCICommit',' Commits outstanding transactions','   int OCICommit (int connection)');
INSERT INTO "php_manual" VALUES (1128,'OCIRollback',' Rolls back outstanding transactions','   int OCIRollback (int connection)');
INSERT INTO "php_manual" VALUES (1129,'OCINewDescriptor','  Initialize a new empty descriptor LOB/FILE (LOB','   string OCINewDescriptor (int connection [, int type])');
INSERT INTO "php_manual" VALUES (1130,'OCIRowCount',' Gets the number of affected rows','   int OCIRowCount (int statement)');
INSERT INTO "php_manual" VALUES (1131,'OCINumCols','  Return the number of result columns in a statement','   int OCINumCols (int stmt)');
INSERT INTO "php_manual" VALUES (1132,'OCIResult',' Returns column value for fetched row','   mixed OCIResult (int statement, mixed column)');
INSERT INTO "php_manual" VALUES (1133,'OCIFetch',' Fetches the next row into result-buffer','   int OCIFetch (int statement)');
INSERT INTO "php_manual" VALUES (1134,'OCIFetchInto',' Fetches the next row into result-array','   int OCIFetchInto (int stmt, array &result [, int mode])');
INSERT INTO "php_manual" VALUES (1135,'OCIFetchStatement',' Fetch all rows of result data into an array.','   int OCIFetchStatement (int stmt, array &variable)');
INSERT INTO "php_manual" VALUES (1136,'OCIColumnIsNULL',' test whether a result column is NULL','   int OCIColumnIsNULL (int stmt, mixed column)');
INSERT INTO "php_manual" VALUES (1137,'OCIColumnName',' Returns the name of a column.','   string OCIColumnName (int stmt, int col)');
INSERT INTO "php_manual" VALUES (1138,'OCIColumnSize',' return result column size','   int OCIColumnSize (int stmt, mixed column)');
INSERT INTO "php_manual" VALUES (1139,'OCIColumnType',' Returns the data type of a column.','   mixed OCIColumnType (int stmt, int col)');
INSERT INTO "php_manual" VALUES (1140,'OCIServerVersion',' Return a string containing server version','   string OCIServerVersion (int conn)');
INSERT INTO "php_manual" VALUES (1141,'OCIStatementType',' Return the type of an OCI statement.','   string OCIStatementType (int stmt)');
INSERT INTO "php_manual" VALUES (1142,'OCINewCursor','  Return a new cursor (Statement-Handle) - use to bind','   int OCINewCursor (int conn)');
INSERT INTO "php_manual" VALUES (1143,'OCIFreeStatement','  Free all resources associated with a statement.','   int OCIFreeStatement (int stmt)');
INSERT INTO "php_manual" VALUES (1144,'OCIFreeCursor','  Free all resources associated with a cursor.','   int OCIFreeCursor (int stmt)');
INSERT INTO "php_manual" VALUES (1145,'OCIFreeDesc',' Deletes a large object descriptor.','   int OCIFreeDesc (object lob)');
INSERT INTO "php_manual" VALUES (1146,'OCIParse',' Parse a query and return a statement','   int OCIParse (int conn, strint query)');
INSERT INTO "php_manual" VALUES (1147,'OCIError',' Return the last error of stmt|conn|global. If no error','   array OCIError ([int stmt|conn|global])');
INSERT INTO "php_manual" VALUES (1148,'OCIInternalDebug','  Enables or disables internal debug output. By','   void OCIInternalDebug (int onoff)');
INSERT INTO "php_manual" VALUES (1149,'openssl_free_key',' Free key resource','   void openssl_free_key (int key_identifier)');
INSERT INTO "php_manual" VALUES (1150,'openssl_get_privatekey',' Prepare a PEM formatted private key for use','   int openssl_get_privatekey (string key [, string passphrase])');
INSERT INTO "php_manual" VALUES (1151,'openssl_get_publickey',' Extract public key from certificate and','   int openssl_get_publickey (string certificate)');
INSERT INTO "php_manual" VALUES (1152,'openssl_open',' Open sealed data','   bool openssl_open (string sealed_data, string open_data, string');
INSERT INTO "php_manual" VALUES (1153,'openssl_seal',' Seal (encrypt) data','   int openssl_seal (string data, string sealed_data, array env_keys,');
INSERT INTO "php_manual" VALUES (1154,'openssl_sign',' Generate signature','   bool openssl_sign (string data, string signature, int priv_key_id)');
INSERT INTO "php_manual" VALUES (1155,'openssl_verify',' Verify signature','   int openssl_verify (string data, string signature, int pub_key_id)');
INSERT INTO "php_manual" VALUES (1156,'Ora_Bind',' bind a PHP variable to an Oracle parameter','   int ora_bind (int cursor, string PHP variable name, string SQL');
INSERT INTO "php_manual" VALUES (1157,'Ora_Close',' close an Oracle cursor','   int ora_close (int cursor)');
INSERT INTO "php_manual" VALUES (1158,'Ora_ColumnName',' get name of Oracle result column','   string Ora_ColumnName (int cursor, int column)');
INSERT INTO "php_manual" VALUES (1159,'Ora_ColumnSize',' get size of Oracle result column','   int Ora_ColumnSize (int cursor, int column)');
INSERT INTO "php_manual" VALUES (1160,'Ora_ColumnType',' get type of Oracle result column','   string Ora_ColumnType (int cursor, int column)');
INSERT INTO "php_manual" VALUES (1161,'Ora_Commit',' commit an Oracle transaction','   int ora_commit (int conn)');
INSERT INTO "php_manual" VALUES (1162,'Ora_CommitOff',' disable automatic commit','   int ora_commitoff (int conn)');
INSERT INTO "php_manual" VALUES (1163,'Ora_CommitOn',' enable automatic commit','   int ora_commiton (int conn)');
INSERT INTO "php_manual" VALUES (1164,'Ora_Do',' Parse, Exec, Fetch','   int ora_do (int conn, string query)');
INSERT INTO "php_manual" VALUES (1165,'Ora_Error',' get Oracle error message','   string Ora_Error (int cursor_or_connection)');
INSERT INTO "php_manual" VALUES (1166,'Ora_ErrorCode',' get Oracle error code','   int Ora_ErrorCode (int cursor_or_connection)');
INSERT INTO "php_manual" VALUES (1167,'Ora_Exec',' execute parsed statement on an Oracle cursor','   int ora_exec (int cursor)');
INSERT INTO "php_manual" VALUES (1168,'Ora_Fetch',' fetch a row of data from a cursor','   int ora_fetch (int cursor)');
INSERT INTO "php_manual" VALUES (1169,'Ora_Fetch_Into',' Fetch a row into the specified result array','   int ora_fetch_into (int cursor, array result [, int flags])');
INSERT INTO "php_manual" VALUES (1170,'Ora_GetColumn',' get data from a fetched column','   mixed ora_getcolumn (int cursor, mixed column)');
INSERT INTO "php_manual" VALUES (1171,'Ora_Logoff',' close an Oracle connection','   int ora_logoff (int connection)');
INSERT INTO "php_manual" VALUES (1172,'Ora_Logon',' open an Oracle connection','   int ora_logon (string user, string password)');
INSERT INTO "php_manual" VALUES (1173,'Ora_pLogon','  Open a persistent Oracle connection','   int ora_plogon (string user, string password)');
INSERT INTO "php_manual" VALUES (1174,'Ora_Numcols',' Returns the number of columns','   int ora_numcols (int cursor_ind)');
INSERT INTO "php_manual" VALUES (1175,'Ora_Numrows',' Returns the number of rows','   int ora_numrows (int cursor_ind)');
INSERT INTO "php_manual" VALUES (1176,'Ora_Open',' open an Oracle cursor','   int ora_open (int connection)');
INSERT INTO "php_manual" VALUES (1177,'Ora_Parse',' parse an SQL statement','   int ora_parse (int cursor_ind, string sql_statement, int defer)');
INSERT INTO "php_manual" VALUES (1178,'Ora_Rollback',' roll back transaction','   int ora_rollback (int connection)');
INSERT INTO "php_manual" VALUES (1179,'ovrimos_connect',' Connect to the specified database','   int ovrimos_connect (string host, string db, string user, string');
INSERT INTO "php_manual" VALUES (1180,'ovrimos_close',' Closes the connection to ovrimos','   void ovrimos_close (int connection)');
INSERT INTO "php_manual" VALUES (1181,'ovrimos_close_all',' Closes all the connections to ovrimos','   void ovrimos_close_all (void)');
INSERT INTO "php_manual" VALUES (1182,'ovrimos_longreadlen','  Specifies how many bytes are to be retrieved','   int ovrimos_longreadlen (int result_id, int length)');
INSERT INTO "php_manual" VALUES (1183,'ovrimos_prepare',' Prepares an SQL statement','   int ovrimos_prepare (int connection_id, string query)');
INSERT INTO "php_manual" VALUES (1184,'ovrimos_execute',' Executes a prepared SQL statement','   int ovrimos_execute (int result_id [, array parameters_array])');
INSERT INTO "php_manual" VALUES (1185,'ovrimos_cursor',' Returns the name of the cursor','   int ovrimos_cursor (int result_id)');
INSERT INTO "php_manual" VALUES (1186,'ovrimos_exec',' Executes an SQL statement','   int ovrimos_exec (int connection_id, string query)');
INSERT INTO "php_manual" VALUES (1187,'ovrimos_fetch_into',' Fetches a row from the result set','   int ovrimos_fetch_into (int result_id, array result_array [, string');
INSERT INTO "php_manual" VALUES (1188,'ovrimos_fetch_row',' Fetches a row from the result set','   int ovrimos_fetch_row (int result_id [, int how [, int row_number]])');
INSERT INTO "php_manual" VALUES (1189,'ovrimos_result',' Retrieves the output column','   int ovrimos_result (int result_id, mixed field)');
INSERT INTO "php_manual" VALUES (1190,'ovrimos_result_all','  Prints the whole result set as an HTML table','   int ovrimos_result_all (int result_id [, string format])');
INSERT INTO "php_manual" VALUES (1191,'ovrimos_num_rows','  Returns the number of rows affected by update','   int ovrimos_num_rows (int result_id)');
INSERT INTO "php_manual" VALUES (1192,'ovrimos_num_fields',' Returns the number of columns','   int ovrimos_num_fields (int result_id)');
INSERT INTO "php_manual" VALUES (1193,'ovrimos_field_name',' Returns the output column name','   int ovrimos_field_name (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1194,'ovrimos_field_type','  Returns the (numeric) type of the output column','   int ovrimos_field_type (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1195,'ovrimos_field_len',' Returns the length of the output column','   int ovrimos_field_len (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1196,'ovrimos_field_num','  Returns the (1-based) index of the output column','   int ovrimos_field_num (int result_id, string field_name)');
INSERT INTO "php_manual" VALUES (1197,'ovrimos_free_result',' Frees the specified result_id','   int ovrimos_free_result (int result_id)');
INSERT INTO "php_manual" VALUES (1198,'ovrimos_commit',' Commits the transaction','   int ovrimos_commit (int connection_id)');
INSERT INTO "php_manual" VALUES (1199,'ovrimos_rollback',' Rolls back the transaction','   int ovrimos_rollback (int connection_id)');
INSERT INTO "php_manual" VALUES (1200,'flush',' Flush the output buffer','   void flush(void);');
INSERT INTO "php_manual" VALUES (1201,'ob_start',' Turn on output buffering','   void ob_start ([string output_callback])');
INSERT INTO "php_manual" VALUES (1202,'ob_get_contents','  Return the contents of the output buffer','   string ob_get_contents(void);');
INSERT INTO "php_manual" VALUES (1203,'ob_get_length','  Return the length of the output buffer','   string ob_get_length(void);');
INSERT INTO "php_manual" VALUES (1204,'ob_gzhandler','  ob_start callback function to gzip output buffer','   string ob_gzhandler (string buffer)');
INSERT INTO "php_manual" VALUES (1205,'ob_end_flush','  Flush (send) the output buffer and turn off output','   void ob_end_flush(void);');
INSERT INTO "php_manual" VALUES (1206,'ob_end_clean','  Clean (erase) the output buffer and turn off output','   void ob_end_clean(void);');
INSERT INTO "php_manual" VALUES (1207,'ob_implicit_flush','  Turn implicit flush on/off','   void ob_implicit_flush ([int flag])');
INSERT INTO "php_manual" VALUES (1208,'PDF_add_annotation',' Deprecitad: Adds annotation','   The PDF_add_outline() is replaced by PDF_add_note()');
INSERT INTO "php_manual" VALUES (1209,'PDF_add_bookmark',' Adds bookmark for current page','   int PDF_add_bookmark (int pdf object, string text [, int parent [, int');
INSERT INTO "php_manual" VALUES (1210,'PDF_add_launchlink',' Add a launch annotation for current page','   int PDF_add_launchlink (int pdf object, FLOAT8llx, double lly, double');
INSERT INTO "php_manual" VALUES (1211,'PDF_add_locallink',' Add a link annotation for current page','   int PDF_add_locallink (int pdf object, FLOAT8llx, double lly, double');
INSERT INTO "php_manual" VALUES (1212,'PDF_add_note',' Add a note annotation for current page','   int PDF_add_note (int pdf object, FLOAT8llx, double lly, double urx,');
INSERT INTO "php_manual" VALUES (1213,'pdf_add_outline',' Depriciated: Adds bookmark for current page','   Depreciated.');
INSERT INTO "php_manual" VALUES (1214,'PDF_add_pdflink',' Adds file link annotation for current page','   int PDF_add_pdflink (int pdf object, FLOAT8llx, double lly, double');
INSERT INTO "php_manual" VALUES (1215,'PDF_add_thumbnail',' Adds thumbnail for current page','   int PDF_add_thumbnail (int pdf object, int image)');
INSERT INTO "php_manual" VALUES (1216,'PDF_add_weblink',' Adds weblink for current page','   int PDF_add_weblink (int pdf object, FLOAT8llx, double lly, double');
INSERT INTO "php_manual" VALUES (1217,'PDF_arc',' Draws an arc','   void PDF_arc (int pdf object, FLOAT8x, double y, double r, double');
INSERT INTO "php_manual" VALUES (1218,'PDF_arcn',' Draws an arc','   void PDF_arc (int pdf object, FLOAT8x, double y, double r, double');
INSERT INTO "php_manual" VALUES (1219,'PDF_attach_file',' Adds a file attachement for current page','   int PDF_attach_file (int pdf object, FLOAT8llx, double lly, double');
INSERT INTO "php_manual" VALUES (1220,'PDF_begin_page',' Starts new page','   void PDF_begin_page (int pdf object, FLOAT8width, double height)');
INSERT INTO "php_manual" VALUES (1221,'PDF_begin_pattern',' Starts new pattern','   void PDF_begin_pattern (int pdf object, FLOAT8width, double height,');
INSERT INTO "php_manual" VALUES (1222,'PDF_begin_template',' Starts new template','   void PDF_begin_template (int pdf object, FLOAT8width, double height)');
INSERT INTO "php_manual" VALUES (1223,'PDF_circle',' Draws a circle','   void PDF_circle (int pdf object, FLOAT8x, double y, double r)');
INSERT INTO "php_manual" VALUES (1224,'PDF_clip',' Clips to current path','   void PDF_clip (int pdf object)');
INSERT INTO "php_manual" VALUES (1225,'PDF_close',' Closes a pdf object','   void PDF_close (int pdf object)');
INSERT INTO "php_manual" VALUES (1226,'PDF_closepath',' Closes path','   void PDF_closepath (int pdf object)');
INSERT INTO "php_manual" VALUES (1227,'PDF_closepath_fill_stroke',' Closes, fills and strokes current path','   void PDF_closepath_fill_stroke (int pdf object)');
INSERT INTO "php_manual" VALUES (1228,'PDF_closepath_stroke',' Closes path and draws line along path','   void PDF_closepath_stroke (int pdf object)');
INSERT INTO "php_manual" VALUES (1229,'PDF_close_image',' Closes an image','   void PDF_close_image (int image)');
INSERT INTO "php_manual" VALUES (1230,'PDF_close_pdi','  Close the input PDF document','   void PDF_close_pdi (int pdf object, int dochandle)');
INSERT INTO "php_manual" VALUES (1231,'PDF_close_pdi_page','  Close the page handle','   void PDF_close_pdi_page (int pdf object, int dochandle, int');
INSERT INTO "php_manual" VALUES (1232,'PDF_concat',' Concatenate a matrix to the CTM','   void PDF_concat (int pdf object, FLOAT8a, double b, double c, double');
INSERT INTO "php_manual" VALUES (1233,'PDF_continue_text',' Outputs text in next line','   void PDF_continue_text (int pdf object, string text)');
INSERT INTO "php_manual" VALUES (1234,'PDF_curveto',' Draws a curve','   void PDF_curveto (int pdf object, FLOAT8x1, double y1, double x2,');
INSERT INTO "php_manual" VALUES (1235,'PDF_delete',' Deletes a PDF object','   void PDF_delete (int pdf object)');
INSERT INTO "php_manual" VALUES (1236,'PDF_end_page',' Ends a page','   void PDF_end_page (int pdf object)');
INSERT INTO "php_manual" VALUES (1237,'PDF_endpath',' Depreciated: Ends current path','   Deprecated, use one of the stroke, fill, or clip functions instead.');
INSERT INTO "php_manual" VALUES (1238,'PDF_end_pattern',' Finish pattern','   void PDF_end_pattern (int pdf object)');
INSERT INTO "php_manual" VALUES (1239,'PDF_end_template',' Finish template','   void PDF_end_template (int pdf object)');
INSERT INTO "php_manual" VALUES (1240,'PDF_fill',' Fills current path','   void PDF_fill_stroke (int pdf object)');
INSERT INTO "php_manual" VALUES (1241,'PDF_fill_stroke',' Fills and strokes current path','   void PDF_fill_stroke (int pdf object)');
INSERT INTO "php_manual" VALUES (1242,'PDF_findfont',' Prepare font for later use with PDF_setfont().','   void PDF_findfont (int pdf object, string fontname, string encoding^,');
INSERT INTO "php_manual" VALUES (1243,'PDF_get_buffer',' Fetch the buffer containig the generated PDF data.','   string PDF_get_buffer (int pdf object)');
INSERT INTO "php_manual" VALUES (1244,'PDF_get_font',' Depreciated font handling','   Depreciated.');
INSERT INTO "php_manual" VALUES (1245,'PDF_get_fontname',' Depreciated font handling','   Depreciated.');
INSERT INTO "php_manual" VALUES (1246,'PDF_get_fontsize',' Depreciated font handling','   Depreciated.');
INSERT INTO "php_manual" VALUES (1247,'PDF_get_image_height',' Returns height of an image','   string PDF_get_image_height (int pdf object, int image)');
INSERT INTO "php_manual" VALUES (1248,'PDF_get_image_width',' Returns width of an image','   string PDF_get_image_width (int pdf object, int image)');
INSERT INTO "php_manual" VALUES (1249,'PDF_get_parameter',' Gets certain parameters','   string PDF_get_parameter (int pdf object, string key [, FLOAT8);
INSERT INTO "php_manual" VALUES (1250,'PDF_get_pdi_parameter',' Get some PDI string parameters','   string PDF_get_pdi_parameter (int pdf object, string key, int doc, int');
INSERT INTO "php_manual" VALUES (1251,'PDF_get_pdi_value',' Gets some PDI numerical parameters','   string PDF_get_pdi_value (int pdf object, string key, int doc, int');
INSERT INTO "php_manual" VALUES (1252,'PDF_get_value',' Gets certain numerical value','   FLOAT8PDF_get_value (int pdf object, string key [, double modifier])');
INSERT INTO "php_manual" VALUES (1253,'PDF_initgraphics',' Resets graphic state','   void PDF_initgraphics (int pdf object)');
INSERT INTO "php_manual" VALUES (1254,'PDF_lineto',' Draws a line','   void PDF_lineto (int pdf object, FLOAT8x, double y)');
INSERT INTO "php_manual" VALUES (1255,'PDF_makespotcolor',' Makes a spotcolor','   void PDF_makespotcolor (int pdf object, string spotname)');
INSERT INTO "php_manual" VALUES (1256,'PDF_moveto',' Sets current point','   void PDF_moveto (int pdf object, FLOAT8x, double y)');
INSERT INTO "php_manual" VALUES (1257,'PDF_new',' Creates a new pdf object','   int PDF_new ()');
INSERT INTO "php_manual" VALUES (1258,'pdf_open',' Depriciated: Opens a new pdf object','   The PDF_open() is depreciated, use PDF_new() plus PDF_open_file()');
INSERT INTO "php_manual" VALUES (1259,'PDF_open_CCITT',' Opens a new image file with raw CCITT data','   int PDF_open (int pdf object, string filename, int width, int height,');
INSERT INTO "php_manual" VALUES (1260,'PDF_open_file',' Opens a new pdf object','   int PDF_open_file (int pdf object [, string filename])');
INSERT INTO "php_manual" VALUES (1261,'PDF_open_gif',' Depreciated: Opens a GIF image','   Depreciated.');
INSERT INTO "php_manual" VALUES (1262,'PDF_open_image',' Versatile function for images','   int PDF_open_image (int PDF-document, string imagetype, string source,');
INSERT INTO "php_manual" VALUES (1263,'PDF_open_image_file',' Reads an image from a file','   int PDF_open_image_file (int PDF-document, string imagetype, string');
INSERT INTO "php_manual" VALUES (1264,'PDF_open_jpeg',' Depreciated: Opens a JPEG image','   Depreciated.');
INSERT INTO "php_manual" VALUES (1265,'PDF_open_pdi','  Opens a PDF file','   void PDF_open_pdi (int pdf object, string filename, string');
INSERT INTO "php_manual" VALUES (1266,'PDF_open_pdi_page','  Prepare a page','   void PDF_open_pd_pagei (int pdf object, int dochandle, int pagenumber,');
INSERT INTO "php_manual" VALUES (1267,'PDF_open_png','  Depreciated: Opens a PNG image','   Depreciated.');
INSERT INTO "php_manual" VALUES (1268,'PDF_open_tiff',' Depreciated: Opens a TIFF image','   int PDF_open_tiff (int PDF-document, string filename)');
INSERT INTO "php_manual" VALUES (1269,'PDF_place_image',' Places an image on the page','   void PDF_place_image (int pdf object, int image, FLOAT8x, double y,');
INSERT INTO "php_manual" VALUES (1270,'PDF_rect',' Draws a rectangle','   void PDF_rect (int pdf object, FLOAT8x, double y, double width,');
INSERT INTO "php_manual" VALUES (1271,'PDF_restore',' Restores formerly saved environment','   void PDF_restore (int pdf object)');
INSERT INTO "php_manual" VALUES (1272,'PDF_rotate',' Sets rotation','   void PDF_rotate (int pdf object, FLOAT8phi)');
INSERT INTO "php_manual" VALUES (1273,'PDF_save',' Saves the current environment','   void PDF_save (int pdf object)');
INSERT INTO "php_manual" VALUES (1274,'PDF_scale',' Sets scaling','   void PDF_scale (int pdf object, FLOAT8x-scale, double y-scale)');
INSERT INTO "php_manual" VALUES (1275,'PDF_setcolor',' Sets fill and stroke color to CMYK values','   void PDF_secolor (int pdf object, string type, string colorspace,');
INSERT INTO "php_manual" VALUES (1276,'PDF_setdash',' Sets dash pattern','   void PDF_setdash (int pdf object, FLOAT8w, double b)');
INSERT INTO "php_manual" VALUES (1277,'PDF_setflat',' Sets flatness','   void PDF_setflat (int pdf object, FLOAT8flatness)');
INSERT INTO "php_manual" VALUES (1278,'PDF_setfont',' Set the current font','   void PDF_setfont (int pdf object, int font, FLOAT8size)');
INSERT INTO "php_manual" VALUES (1279,'PDF_setgray',' Sets drawing and filling color to gray value','   void PDF_setgray (int pdf object, FLOAT8gray)');
INSERT INTO "php_manual" VALUES (1280,'PDF_setgray_fill',' Sets filling color to gray value','   void PDF_setgray_fill (int pdf object, FLOAT8gray)');
INSERT INTO "php_manual" VALUES (1281,'PDF_setgray_stroke',' Sets drawing color to gray value','   void PDF_setgray_stroke (int pdf object, FLOAT8gray)');
INSERT INTO "php_manual" VALUES (1282,'PDF_setlinecap',' Sets linecap parameter','   void PDF_setlinecap (int pdf object, int linecap)');
INSERT INTO "php_manual" VALUES (1283,'PDF_setlinejoin',' Sets linejoin parameter','   void PDF_setlinejoin (int pdf object, long linejoin)');
INSERT INTO "php_manual" VALUES (1284,'PDF_setlinewidth',' Sets line width','   void PDF_setlinewidth (int pdf object, FLOAT8width)');
INSERT INTO "php_manual" VALUES (1285,'PDF_setmatrix',' Sets current transformation matrix','   void PDF_setmatrix (int pdf object, FLOAT8a, double b, double c,');
INSERT INTO "php_manual" VALUES (1286,'PDF_setmiterlimit',' Sets miter limit','   void PDF_setmiterlimit (int pdf object, FLOAT8miter)');
INSERT INTO "php_manual" VALUES (1287,'PDF_setpolydash',' Sets complicated dash pattern','   void PDF_setpolydash (int pdf object, FLOAT8*dasharray)');
INSERT INTO "php_manual" VALUES (1288,'PDF_setrgbcolor',' Sets drawing and filling color to rgb color value','   void PDF_setrgbcolor (int pdf object, FLOAT8red value, double green');
INSERT INTO "php_manual" VALUES (1289,'PDF_setrgbcolor_fill',' Sets filling color to rgb color value','   void PDF_setrgbcolor_fill (int pdf object, FLOAT8red value, double');
INSERT INTO "php_manual" VALUES (1290,'PDF_setrgbcolor_stroke',' Sets drawing color to rgb color value','   void PDF_setrgbcolor_stroke (int pdf object, FLOAT8red value, double');
INSERT INTO "php_manual" VALUES (1291,'PDF_set_border_color',' Sets color of border around links and','   void PDF_set_border_color (int pdf object, FLOAT8red, double green,');
INSERT INTO "php_manual" VALUES (1292,'PDF_set_border_dash',' Sets dash style of border around links and','   void PDF_set_border_dash (int pdf object, FLOAT8black, double white)');
INSERT INTO "php_manual" VALUES (1293,'PDF_set_border_style',' Sets style of border around links and','   void PDF_set_border_style (int pdf object, string style, FLOAT8width)');
INSERT INTO "php_manual" VALUES (1294,'PDF_set_char_spacing',' Depreciated: Sets character spacing','   Depreciated.');
INSERT INTO "php_manual" VALUES (1295,'pdf_set_duration',' Depriciated: Sets duration between pages','   Depreciated.');
INSERT INTO "php_manual" VALUES (1296,'PDF_set_font',' Depreciated: Selects a font face and size','   Depreciated. You should use PDF_findfont() plus PDF_setfont() instead.');
INSERT INTO "php_manual" VALUES (1297,'PDF_set_horiz_scaling',' Sets horizontal scaling of text','   void PDF_set_horiz_scaling (int pdf object, FLOAT8scale)');
INSERT INTO "php_manual" VALUES (1298,'PDF_set_info',' Fills a field of the document information','   void PDF_set_info (int pdf object, string key, string value)');
INSERT INTO "php_manual" VALUES (1299,'PDF_set_leading',' Depreciated: Sets distance between text lines','   Depreciated.');
INSERT INTO "php_manual" VALUES (1300,'PDF_set_parameter',' Sets certain parameters','   void PDF_set_parameter (int pdf object, string key, string value)');
INSERT INTO "php_manual" VALUES (1301,'PDF_set_text_pos',' Sets text position','   void PDF_set_text_pos (int pdf object, FLOAT8x, double y)');
INSERT INTO "php_manual" VALUES (1302,'PDF_set_text_rendering',' Depreciated: Determines how text is rendered','   Depreciated.');
INSERT INTO "php_manual" VALUES (1303,'pdf_set_text_rise',' Depriciated: Sets the text rise','   Depreciated.');
INSERT INTO "php_manual" VALUES (1304,'pdf_set_text_matrix',' Depriciated: Sets the text matrix','   See PDF_set_paramter().');
INSERT INTO "php_manual" VALUES (1305,'PDF_set_value',' Sets certain numerical value','   void PDF_set_value (int pdf object, string key, FLOAT8value)');
INSERT INTO "php_manual" VALUES (1306,'pdf_set_word_spacing',' Depriciated: Sets spacing between words','   Depreciated.');
INSERT INTO "php_manual" VALUES (1307,'PDF_show',' Output text at current position','   void PDF_show (int pdf object, string text)');
INSERT INTO "php_manual" VALUES (1308,'PDF_show_boxed',' Output text in a box','   int PDF_show_boxed (int pdf object, string text, FLOAT8left, double');
INSERT INTO "php_manual" VALUES (1309,'PDF_show_xy',' Output text at given position','   void PDF_show_xy (int pdf object, string text, FLOAT8x, double y)');
INSERT INTO "php_manual" VALUES (1310,'PDF_skew',' Skews the coordinate system','   void PDF_skew (int pdf object, FLOAT8alpha, double beta)');
INSERT INTO "php_manual" VALUES (1311,'PDF_stringwidth',' Returns width of text using current font','   FLOAT8PDF_stringwidth (int pdf object, string text [, string text [,');
INSERT INTO "php_manual" VALUES (1312,'PDF_stroke',' Draws line along path','   void PDF_stroke (int pdf object)');
INSERT INTO "php_manual" VALUES (1313,'PDF_translate',' Sets origin of coordinate system','   void PDF_translate (int pdf object, FLOAT8tx, double ty)');
INSERT INTO "php_manual" VALUES (1314,'PDF_open_memory_image',' Opens an image created with PHP\'s image','   int PDF_open_memory_image (int pdf object, int image)');
INSERT INTO "php_manual" VALUES (1315,'pfpro_init',' Initialises the Payflow Pro library','   void pfpro_init(void);');
INSERT INTO "php_manual" VALUES (1316,'pfpro_cleanup',' Shuts down the Payflow Pro library','   void pfpro_cleanup(void);');
INSERT INTO "php_manual" VALUES (1317,'pfpro_process',' Process a transaction with Payflow Pro','   array pfpro_process (array parameters [, string address [, int port [,');
INSERT INTO "php_manual" VALUES (1318,'pfpro_process_raw',' Process a raw transaction with Payflow Pro','   string pfpro_process_raw (string parameters [, string address [, int');
INSERT INTO "php_manual" VALUES (1319,'pfpro_version',' Returns the version of the Payflow Pro software','   string pfpro_version(void);');
INSERT INTO "php_manual" VALUES (1320,'assert',' Checks if assertion is false','   int assert (string|bool assertion)');
INSERT INTO "php_manual" VALUES (1321,'assert_options',' Set/get the various assert flags','   mixed assert_options (int what [, mixed value])');
INSERT INTO "php_manual" VALUES (1322,'extension_loaded',' find out whether an extension is loaded','   bool extension_loaded (string name)');
INSERT INTO "php_manual" VALUES (1323,'dl',' load a PHP extension at runtime','   int dl (string library)');
INSERT INTO "php_manual" VALUES (1324,'getenv',' Get the value of an environment variable','   string getenv (string varname)');
INSERT INTO "php_manual" VALUES (1325,'get_cfg_var','  Get the value of a PHP configuration option.','   string get_cfg_var (string varname)');
INSERT INTO "php_manual" VALUES (1326,'get_current_user','  Get the name of the owner of the current PHP','   string get_current_user (void)');
INSERT INTO "php_manual" VALUES (1327,'get_magic_quotes_gpc','  Get the current active configuration setting','   long get_magic_quotes_gpc (void)');
INSERT INTO "php_manual" VALUES (1328,'get_magic_quotes_runtime','  Get the current active configuration','   long get_magic_quotes_runtime (void)');
INSERT INTO "php_manual" VALUES (1329,'getlastmod',' Get time of last page modification.','   int getlastmod (void)');
INSERT INTO "php_manual" VALUES (1330,'getmyinode',' Get the inode of the current script.','   int getmyinode (void)');
INSERT INTO "php_manual" VALUES (1331,'getmypid',' Get PHP\'s process ID.','   int getmypid (void)');
INSERT INTO "php_manual" VALUES (1332,'getmyuid',' Get PHP script owner\'s UID.','   int getmyuid (void)');
INSERT INTO "php_manual" VALUES (1333,'getrusage',' Get the current resource usages.','   array getrusage ([int who])');
INSERT INTO "php_manual" VALUES (1334,'ini_alter',' Change the value of a configuration option','   string ini_alter (string varname, string newvalue)');
INSERT INTO "php_manual" VALUES (1335,'ini_get',' Get the value of a configuration option','   string ini_get (string varname)');
INSERT INTO "php_manual" VALUES (1336,'ini_restore',' Restore the value of a configuration option','   string ini_restore (string varname)');
INSERT INTO "php_manual" VALUES (1337,'ini_set',' Set the value of a configuration option','   string ini_set (string varname, string newvalue)');
INSERT INTO "php_manual" VALUES (1338,'phpcredits',' Prints out the credits for PHP.','   void phpcredits (int flag)');
INSERT INTO "php_manual" VALUES (1339,'phpinfo',' Output lots of PHP information.','   int phpinfo ([int what])');
INSERT INTO "php_manual" VALUES (1340,'phpversion',' Get the current PHP version.','   string phpversion (void)');
INSERT INTO "php_manual" VALUES (1341,'php_logo_guid',' Get the logo guid','   string php_logo_guid (void)');
INSERT INTO "php_manual" VALUES (1342,'php_sapi_name','  Returns the type of interface between web server and','   string php_sapi_name(void);');
INSERT INTO "php_manual" VALUES (1343,'php_uname','  Returns information about the operating system PHP was','   string php_uname(void);');
INSERT INTO "php_manual" VALUES (1344,'putenv',' Set the value of an environment variable.','   void putenv (string setting)');
INSERT INTO "php_manual" VALUES (1345,'set_magic_quotes_runtime','  Set the current active configuration','   long set_magic_quotes_runtime (int new_setting)');
INSERT INTO "php_manual" VALUES (1346,'set_time_limit',' limit the maximum execution time','   void set_time_limit (int seconds)');
INSERT INTO "php_manual" VALUES (1347,'zend_logo_guid',' Get the zend guid','   string zend_logo_guid (void)');
INSERT INTO "php_manual" VALUES (1348,'get_loaded_extensions','  Returns an array with the names of all','   array get_loaded_extensions (void)');
INSERT INTO "php_manual" VALUES (1349,'get_extension_funcs','  Returns an array with the names of the','   array get_extension_funcs (string module_name)');
INSERT INTO "php_manual" VALUES (1350,'get_required_files','  Returns an array with the names of the files','   array get_required_files (void)');
INSERT INTO "php_manual" VALUES (1351,'get_included_files','  Returns an array with the names of the files','   array get_included_files (void)');
INSERT INTO "php_manual" VALUES (1352,'zend_version',' Get the version of the current Zend engine.','   string zend_version (void)');
INSERT INTO "php_manual" VALUES (1353,'posix_kill',' Send a signal to a process','   bool posix_kill (int pid, int sig)');
INSERT INTO "php_manual" VALUES (1354,'posix_getpid',' Return the current process identifier','   int posix_getpid (void )');
INSERT INTO "php_manual" VALUES (1355,'posix_getppid',' Return the parent process identifier','   int posix_getppid (void )');
INSERT INTO "php_manual" VALUES (1356,'posix_getuid','  Return the FLOAT8user ID of the current process','   int posix_getuid (void )');
INSERT INTO "php_manual" VALUES (1357,'posix_geteuid','  Return the effective user ID of the current process','   int posix_geteuid (void )');
INSERT INTO "php_manual" VALUES (1358,'posix_getgid','  Return the FLOAT8group ID of the current process','   int posix_getgid (void )');
INSERT INTO "php_manual" VALUES (1359,'posix_getegid','  Return the effective group ID of the current process','   int posix_getegid (void )');
INSERT INTO "php_manual" VALUES (1360,'posix_setuid','  Set the effective UID of the current process','   bool posix_setuid (int uid)');
INSERT INTO "php_manual" VALUES (1361,'posix_setgid','  Set the effective GID of the current process','   bool posix_setgid (int gid)');
INSERT INTO "php_manual" VALUES (1362,'posix_getgroups','  Return the group set of the current process','   array posix_getgroups (void )');
INSERT INTO "php_manual" VALUES (1363,'posix_getlogin',' Return login name','   string posix_getlogin (void )');
INSERT INTO "php_manual" VALUES (1364,'posix_getpgrp','  Return the current process group identifier','   int posix_getpgrp (void )');
INSERT INTO "php_manual" VALUES (1365,'posix_setsid',' Make the current process a session leader','   int posix_setsid (void )');
INSERT INTO "php_manual" VALUES (1366,'posix_setpgid',' set process group id for job control','   int posix_setpgid (int pid, int pgid)');
INSERT INTO "php_manual" VALUES (1367,'posix_getpgid',' Get process group id for job control','   int posix_getpgid (int pid)');
INSERT INTO "php_manual" VALUES (1368,'posix_getsid',' Get the current sid of the process','   int posix_getsid (int pid)');
INSERT INTO "php_manual" VALUES (1369,'posix_uname',' Get system name','   array posix_uname (void )');
INSERT INTO "php_manual" VALUES (1370,'posix_times',' Get process times','   array posix_times (void )');
INSERT INTO "php_manual" VALUES (1371,'posix_ctermid',' Get path name of controlling terminal','   string posix_ctermid (void )');
INSERT INTO "php_manual" VALUES (1372,'posix_ttyname',' Determine terminal device name','   string posix_ttyname (int fd)');
INSERT INTO "php_manual" VALUES (1373,'posix_isatty','  Determine if a file descriptor is an interactive','   bool posix_isatty (int fd)');
INSERT INTO "php_manual" VALUES (1374,'posix_getcwd',' Pathname of current directory','   string posix_getcwd (void )');
INSERT INTO "php_manual" VALUES (1375,'posix_mkfifo','  Create a fifo special file (a named pipe)','   bool posix_mkfifo (string pathname, int mode)');
INSERT INTO "php_manual" VALUES (1376,'posix_getgrnam',' Return info about a group by name','   array posix_getgrnam (string name)');
INSERT INTO "php_manual" VALUES (1377,'posix_getgrgid',' Return info about a group by group id','   array posix_getgrgid (int gid)');
INSERT INTO "php_manual" VALUES (1378,'posix_getpwnam',' Return info about a user by username','   array posix_getpwnam (string username)');
INSERT INTO "php_manual" VALUES (1379,'posix_getpwuid',' Return info about a user by user id','   array posix_getpwuid (int uid)');
INSERT INTO "php_manual" VALUES (1380,'posix_getrlimit',' Return info about system ressource limits','   array posix_getrlimit (void )');
INSERT INTO "php_manual" VALUES (1381,'pg_close',' Close a PostgreSQL connection','   bool pg_close (int connection)');
INSERT INTO "php_manual" VALUES (1382,'pg_cmdtuples',' Returns number of affected tuples','   int pg_cmdtuples (int result_id)');
INSERT INTO "php_manual" VALUES (1383,'pg_connect',' Open a PostgreSQL connection','   int pg_connect (string conn_string)');
INSERT INTO "php_manual" VALUES (1384,'pg_dbname',' Get the database name','   string pg_dbname (int connection)');
INSERT INTO "php_manual" VALUES (1385,'pg_end_copy',' Sync with PostgreSQL backend','   bool pg_end_copy ([resource connection])');
INSERT INTO "php_manual" VALUES (1386,'pg_errormessage',' Get the error message string','   string pg_errormessage (int connection)');
INSERT INTO "php_manual" VALUES (1387,'pg_exec',' Execute a query','   int pg_exec (int connection, string query)');
INSERT INTO "php_manual" VALUES (1388,'pg_fetch_array',' Fetch a row as an array','   array pg_fetch_array (int result, int row [, int result_type])');
INSERT INTO "php_manual" VALUES (1389,'pg_fetch_object',' Fetch a row as an object','   object pg_fetch_object (int result, int row [, int result_type])');
INSERT INTO "php_manual" VALUES (1390,'pg_fetch_row',' Get a row as an enumerated array','   array pg_fetch_row (int result, int row)');
INSERT INTO "php_manual" VALUES (1391,'pg_fieldisnull',' Test if a field is NULL','   int pg_fieldisnull (int result_id, int row, mixed field)');
INSERT INTO "php_manual" VALUES (1392,'pg_fieldname',' Returns the name of a field','   string pg_fieldname (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1393,'pg_fieldnum',' Returns the field number of the named field','   int pg_fieldnum (int result_id, string field_name)');
INSERT INTO "php_manual" VALUES (1394,'pg_fieldprtlen',' Returns the printed length','   int pg_fieldprtlen (int result_id, int row_number, string field_name)');
INSERT INTO "php_manual" VALUES (1395,'pg_fieldsize','  Returns the internal storage size of the named field','   int pg_fieldsize (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1396,'pg_fieldtype','  Returns the type name for the corresponding field','   string pg_fieldtype (int result_id, int field_number)');
INSERT INTO "php_manual" VALUES (1397,'pg_freeresult',' Free result memory','   int pg_freeresult (int result_id)');
INSERT INTO "php_manual" VALUES (1398,'pg_getlastoid',' Returns the last object identifier','   int pg_getlastoid (int result_id)');
INSERT INTO "php_manual" VALUES (1399,'pg_host','  Returns the host name associated with the connection','   string pg_host (int connection_id)');
INSERT INTO "php_manual" VALUES (1400,'pg_loclose',' Close a large object','   void pg_loclose (int fd)');
INSERT INTO "php_manual" VALUES (1401,'pg_locreate',' Create a large object','   int pg_locreate (int conn)');
INSERT INTO "php_manual" VALUES (1402,'pg_loexport',' Export a large object to file','   bool pg_loexport (int oid, int file [, int connection_id])');
INSERT INTO "php_manual" VALUES (1403,'pg_loimport',' Import a large object from file','   int pg_loimport (int file [, int connection_id])');
INSERT INTO "php_manual" VALUES (1404,'pg_loopen',' Open a large object','   int pg_loopen (int conn, int objoid, string mode)');
INSERT INTO "php_manual" VALUES (1405,'pg_loread',' Read a large object','   string pg_loread (int fd, int len)');
INSERT INTO "php_manual" VALUES (1406,'pg_loreadall','  Read a entire large object and send straight to','   void pg_loreadall (int fd)');
INSERT INTO "php_manual" VALUES (1407,'pg_lounlink',' Delete a large object','   void pg_lounlink (int conn, int lobjid)');
INSERT INTO "php_manual" VALUES (1408,'pg_lowrite',' Write a large object','   int pg_lowrite (int fd, string buf)');
INSERT INTO "php_manual" VALUES (1409,'pg_numfields',' Returns the number of fields','   int pg_numfields (int result_id)');
INSERT INTO "php_manual" VALUES (1410,'pg_numrows',' Returns the number of rows','   int pg_numrows (int result_id)');
INSERT INTO "php_manual" VALUES (1411,'pg_options',' Get the options associated with the connection','   string pg_options (int connection_id)');
INSERT INTO "php_manual" VALUES (1412,'pg_pconnect',' Open a persistant PostgreSQL connection','   int pg_pconnect (string conn_string)');
INSERT INTO "php_manual" VALUES (1413,'pg_port','  Return the port number associated with the connection','   int pg_port (int connection_id)');
INSERT INTO "php_manual" VALUES (1414,'pg_put_line',' Send a NULL-terminated string to PostgreSQL backend','   bool pg_put_line ([resource connection_id, string data])');
INSERT INTO "php_manual" VALUES (1415,'pg_result',' Returns values from a result identifier','   mixed pg_result (int result_id, int row_number, mixed fieldname)');
INSERT INTO "php_manual" VALUES (1416,'pg_set_client_encoding','  Set the client encoding','   int pg_set_client_encoding ([int connection, string encoding])');
INSERT INTO "php_manual" VALUES (1417,'pg_client_encoding','  Get the client encoding','   string pg_client_encoding ([int connection])');
INSERT INTO "php_manual" VALUES (1418,'pg_trace',' Enable tracing a PostgreSQL connection','   bool pg_trace (string filename [, string mode [, int connection]])');
INSERT INTO "php_manual" VALUES (1419,'pg_tty','  Return the tty name associated with the connection','   string pg_tty (int connection_id)');
INSERT INTO "php_manual" VALUES (1420,'pg_untrace',' Disable tracing of a PostgreSQL connection','   bool pg_untrace ([int connection])');
INSERT INTO "php_manual" VALUES (1421,'escapeshellarg',' escape a string to be used as a shell argument','   string escapeshellarg (string arg)');
INSERT INTO "php_manual" VALUES (1422,'escapeshellcmd',' escape shell metacharacters','   string escapeshellcmd (string command)');
INSERT INTO "php_manual" VALUES (1423,'exec',' Execute an external program','   string exec (string command [, string array [, int return_var]])');
INSERT INTO "php_manual" VALUES (1424,'passthru','  Execute an external program and display raw output','   void passthru (string command [, int return_var])');
INSERT INTO "php_manual" VALUES (1425,'system',' Execute an external program and display output','   string system (string command [, int return_var])');
INSERT INTO "php_manual" VALUES (1426,'pspell_add_to_personal',' Add the word to a personal wordlist.','   int pspell_add_to_personal (int dictionary_link, string word)');
INSERT INTO "php_manual" VALUES (1427,'pspell_add_to_session',' Add the word to the wordlist in the current','   int pspell_add_to_session (int dictionary_link, string word)');
INSERT INTO "php_manual" VALUES (1428,'pspell_check',' Check a word','   boolean pspell_check (int dictionary_link, string word)');
INSERT INTO "php_manual" VALUES (1429,'pspell_clear_session',' Clear the current session.','   int pspell_clear_session (int dictionary_link)');
INSERT INTO "php_manual" VALUES (1430,'pspell_config_create',' Create a config used to open a dictionary.','   int pspell_config_create (string language [, string spelling [, string');
INSERT INTO "php_manual" VALUES (1431,'pspell_config_ignore',' Ignore words less than N characters long.','   int pspell_config_ignore (int dictionary_link, int n)');
INSERT INTO "php_manual" VALUES (1432,'pspell_config_mode',' Change the mode number of suggestions returned.','   int pspell_config_mode (int dictionary_link, int mode)');
INSERT INTO "php_manual" VALUES (1433,'pspell_config_personal',' Set a file that contains personal wordlist.','   int pspell_config_personal (int dictionary_link, string file)');
INSERT INTO "php_manual" VALUES (1434,'pspell_config_repl',' Set a file that contains replacement pairs.','   int pspell_config_repl (int dictionary_link, string file)');
INSERT INTO "php_manual" VALUES (1435,'pspell_config_runtogether',' Consider run-together words as valid','   int pspell_config_runtogether (int dictionary_link, boolean flag)');
INSERT INTO "php_manual" VALUES (1436,'pspell_config_save_repl',' Determine whether to save a replacement','   int pspell_config_save_repl (int dictionary_link, boolean flag)');
INSERT INTO "php_manual" VALUES (1437,'pspell_new',' Load a new dictionary','   int pspell_new (string language [, string spelling [, string jargon [,');
INSERT INTO "php_manual" VALUES (1438,'pspell_new_config',' Load a new dictionary with settings based on a','   int pspell_new_config (int config)');
INSERT INTO "php_manual" VALUES (1439,'pspell_new_personal',' Load a new dictionary with personal wordlist','   int pspell_new_personal (string personal, string language [, string');
INSERT INTO "php_manual" VALUES (1440,'pspell_save_wordlist',' Save the personal wordlist to a file.','   int pspell_save_wordlist (int dictionary_link)');
INSERT INTO "php_manual" VALUES (1441,'pspell_store_replacement',' Store a replacement pair for a word','   int pspell_store_replacement (int dictionary_link, string misspelled,');
INSERT INTO "php_manual" VALUES (1442,'pspell_suggest',' Suggest spellings of a word','   array pspell_suggest (int dictionary_link, string word)');
INSERT INTO "php_manual" VALUES (1443,'readline',' Reads a line','   string readline ([string prompt])');
INSERT INTO "php_manual" VALUES (1444,'readline_add_history',' Adds a line to the history','   void readline_add_history (string line)');
INSERT INTO "php_manual" VALUES (1445,'readline_clear_history',' Clears the history','   boolean readline_clear_history (void )');
INSERT INTO "php_manual" VALUES (1446,'readline_completion_function',' Registers a completion function','   boolean readline_completion_function (string line)');
INSERT INTO "php_manual" VALUES (1447,'readline_info',' Gets/sets various internal readline variables','   mixed readline_info ([string varname [, string newvalue]])');
INSERT INTO "php_manual" VALUES (1448,'readline_list_history',' Lists the history','   array readline_list_history (void )');
INSERT INTO "php_manual" VALUES (1449,'readline_read_history',' Reads the history','   boolean readline_read_history (string filename)');
INSERT INTO "php_manual" VALUES (1450,'readline_write_history',' Writes the history','   boolean readline_write_history (string filename)');
INSERT INTO "php_manual" VALUES (1451,'recode_string',' Recode a string according to a recode request','   string recode_string (string request, string string)');
INSERT INTO "php_manual" VALUES (1452,'recode',' Recode a string according to a recode request','   string recode (string request, string string)');
INSERT INTO "php_manual" VALUES (1453,'recode_file','  Recode from file to file according to recode request','   boolean recode_file (string request, resource input, resource output)');
INSERT INTO "php_manual" VALUES (1454,'preg_match',' Perform a regular expression match','   int preg_match (string pattern, string subject [, array matches])');
INSERT INTO "php_manual" VALUES (1455,'preg_match_all',' Perform a global regular expression match','   int preg_match_all (string pattern, string subject, array matches [,');
INSERT INTO "php_manual" VALUES (1456,'preg_replace',' Perform a regular expression search and replace','   mixed preg_replace (mixed pattern, mixed replacement, mixed subject [,');
INSERT INTO "php_manual" VALUES (1457,'preg_replace_callback',' Perform a regular expression search and','   mixed preg_replace_callback (mixed pattern, mixed callback, mixed');
INSERT INTO "php_manual" VALUES (1458,'preg_split',' Split string by a regular expression','   array preg_split (string pattern, string subject [, int limit [, int');
INSERT INTO "php_manual" VALUES (1459,'preg_quote',' Quote regular expression characters','   string preg_quote (string str [, string delimiter])');
INSERT INTO "php_manual" VALUES (1460,'preg_grep','  Return array entries that match the pattern','   array preg_grep (string pattern, array input)');
INSERT INTO "php_manual" VALUES (1461,'Pattern Modifiers',' Describes possible modifiers in regex patterns','   The current possible PCRE modifiers are listed below. The names in');
INSERT INTO "php_manual" VALUES (1462,'Pattern Syntax',' Describes PCRE regex syntax','        The PCRE library is a set of functions that implement regular');
INSERT INTO "php_manual" VALUES (1463,'ereg',' Regular expression match','   int ereg (string pattern, string string [, array regs])');
INSERT INTO "php_manual" VALUES (1464,'ereg_replace',' Replace regular expression','   string ereg_replace (string pattern, string replacement, string');
INSERT INTO "php_manual" VALUES (1465,'eregi',' case insensitive regular expression match','   int eregi (string pattern, string string [, array regs])');
INSERT INTO "php_manual" VALUES (1466,'eregi_replace',' replace regular expression case insensitive','   string eregi_replace (string pattern, string replacement, string');
INSERT INTO "php_manual" VALUES (1467,'split',' split string into array by regular expression','   array split (string pattern, string string [, int limit])');
INSERT INTO "php_manual" VALUES (1468,'spliti','  Split string into array by regular expression case','   array spliti (string pattern, string string [, int limit])');
INSERT INTO "php_manual" VALUES (1469,'sql_regcase','  Make regular expression for case insensitive match','   string sql_regcase (string string)');
INSERT INTO "php_manual" VALUES (1470,'OrbitObject',' Access CORBA objects','   new OrbitObject (string ior)');
INSERT INTO "php_manual" VALUES (1471,'OrbitEnum',' Use CORBA enums','   new OrbitEnum (string id)');
INSERT INTO "php_manual" VALUES (1472,'OrbitStruct',' Use CORBA structs','   new OrbitStruct (string id)');
INSERT INTO "php_manual" VALUES (1473,'satellite_caught_exception','  See if an exception was caught from the','   bool satellite_caught_exception ()');
INSERT INTO "php_manual" VALUES (1474,'satellite_exception_id',' Get the repository id for the latest','   string satellite_exception_id ()');
INSERT INTO "php_manual" VALUES (1475,'satellite_exception_value','  Get the exception struct for the latest','   OrbitStruct satellite_exception_value ()');
INSERT INTO "php_manual" VALUES (1476,'sem_get',' Get a semaphore id','   int sem_get (int key [, int max_acquire [, int perm]])');
INSERT INTO "php_manual" VALUES (1477,'sem_acquire',' Acquire a semaphore','   int sem_acquire (int sem_identifier)');
INSERT INTO "php_manual" VALUES (1478,'sem_release',' Release a semaphore','   int sem_release (int sem_identifier)');
INSERT INTO "php_manual" VALUES (1479,'shm_attach',' Creates or open a shared memory segment','   int shm_attach (int key [, int memsize [, int perm]])');
INSERT INTO "php_manual" VALUES (1480,'shm_detach',' Disconnects from shared memory segment','   int shm_detach (int shm_identifier)');
INSERT INTO "php_manual" VALUES (1481,'shm_remove',' Removes shared memory from Unix systems','   int shm_remove (int shm_identifier)');
INSERT INTO "php_manual" VALUES (1482,'shm_put_var',' Inserts or updates a variable in shared memory','   int shm_put_var (int shm_identifier, int variable_key, mixed variable)');
INSERT INTO "php_manual" VALUES (1483,'shm_get_var',' Returns a variable from shared memory','   mixed shm_get_var (int id, int variable_key)');
INSERT INTO "php_manual" VALUES (1484,'shm_remove_var',' Removes a variable from shared memory','   int shm_remove_var (int id, int variable_key)');
INSERT INTO "php_manual" VALUES (1485,'sesam_connect',' Open SESAM database connection','   boolean sesam_connect (string catalog, string schema, string user)');
INSERT INTO "php_manual" VALUES (1486,'sesam_disconnect',' Detach from SESAM connection','   boolean sesam_disconnect(void);');
INSERT INTO "php_manual" VALUES (1487,'sesam_settransaction',' Set SESAM transaction parameters','   boolean sesam_settransaction (int isolation_level, int read_only)');
INSERT INTO "php_manual" VALUES (1488,'sesam_commit','  Commit pending updates to the SESAM database','   boolean sesam_commit(void);');
INSERT INTO "php_manual" VALUES (1489,'sesam_rollback','  Discard any pending updates to the SESAM database','   boolean sesam_rollback(void);');
INSERT INTO "php_manual" VALUES (1490,'sesam_execimm',' Execute an \"immediate\" SQL-statement','   string sesam_execimm (string query)');
INSERT INTO "php_manual" VALUES (1491,'sesam_query',' Perform a SESAM SQL query and prepare the result','   string sesam_query (string query [, boolean scrollable])');
INSERT INTO "php_manual" VALUES (1492,'sesam_num_fields','  Return the number of fields/columns in a result','   int sesam_num_fields (string result_id)');
INSERT INTO "php_manual" VALUES (1493,'sesam_field_name','  Return one column name of the result set','   int sesam_field_name (string result_id, int index)');
INSERT INTO "php_manual" VALUES (1494,'sesam_diagnostic','  Return status information for last SESAM call','   array sesam_diagnostic(void);');
INSERT INTO "php_manual" VALUES (1495,'sesam_fetch_result',' Return all or part of a query result','   mixed sesam_fetch_result (string result_id [, int max_rows])');
INSERT INTO "php_manual" VALUES (1496,'sesam_affected_rows','  Get number of rows affected by an immediate','   int sesam_affected_rows (string result_id)');
INSERT INTO "php_manual" VALUES (1497,'sesam_errormsg',' Returns error message of last SESAM call','   string sesam_errormsg(void);');
INSERT INTO "php_manual" VALUES (1498,'sesam_field_array','  Return meta information about individual columns','   array sesam_field_array (string result_id)');
INSERT INTO "php_manual" VALUES (1499,'sesam_fetch_row',' Fetch one row as an array','   array sesam_fetch_row (string result_id [, int whence [, int offset]])');
INSERT INTO "php_manual" VALUES (1500,'sesam_fetch_array',' Fetch one row as an associative array','   array sesam_fetch_array (string result_id [, int whence [, int');
INSERT INTO "php_manual" VALUES (1501,'sesam_seek_row','  Set scrollable cursor mode for subsequent fetches','   boolean sesam_seek_row (string result_id, int whence [, int offset])');
INSERT INTO "php_manual" VALUES (1502,'sesam_free_result',' Releases resources for the query','   int sesam_free_result (string result_id)');
INSERT INTO "php_manual" VALUES (1503,'session_start',' Initialize session data','   bool session_start(void);');
INSERT INTO "php_manual" VALUES (1504,'session_destroy',' Destroys all data registered to a session','   bool session_destroy(void);');
INSERT INTO "php_manual" VALUES (1505,'session_name',' Get and/or set the current session name','   string session_name ([string name])');
INSERT INTO "php_manual" VALUES (1506,'session_module_name',' Get and/or set the current session module','   string session_module_name ([string module])');
INSERT INTO "php_manual" VALUES (1507,'session_save_path',' Get and/or set the current session save path','   string session_save_path ([string path])');
INSERT INTO "php_manual" VALUES (1508,'session_id',' Get and/or set the current session id','   string session_id ([string id])');
INSERT INTO "php_manual" VALUES (1509,'session_register','  Register one or more variables with the current','   bool session_register (mixed name [, mixed ...])');
INSERT INTO "php_manual" VALUES (1510,'session_unregister','  Unregister a variable from the current session','   bool session_unregister (string name)');
INSERT INTO "php_manual" VALUES (1511,'session_unset','  Free all session variables','   void session_unset(void);');
INSERT INTO "php_manual" VALUES (1512,'session_is_registered','  Find out if a variable is registered in a','   bool session_is_registered (string name)');
INSERT INTO "php_manual" VALUES (1513,'session_get_cookie_params','  Get the session cookie parameters','   array session_get_cookie_params (void);');
INSERT INTO "php_manual" VALUES (1514,'session_set_cookie_params','  Set the session cookie parameters','   void session_set_cookie_params (int lifetime [, string path [, string');
INSERT INTO "php_manual" VALUES (1515,'session_decode',' Decodes session data from a string','   bool session_decode (string data)');
INSERT INTO "php_manual" VALUES (1516,'session_encode','  Encodes the current session data as a string','   string session_encode(void);');
INSERT INTO "php_manual" VALUES (1517,'session_set_save_handler','  Sets user-level session storage functions','   void session_set_save_handler (string open, string close, string read,');
INSERT INTO "php_manual" VALUES (1518,'session_cache_limiter',' Get and/or set the current cache limiter','   string session_cache_limiter ([string cache_limiter])');
INSERT INTO "php_manual" VALUES (1519,'shmop_open',' Create or open shared memory block','   int shmop_open (int key, string flags, int mode, int size)');
INSERT INTO "php_manual" VALUES (1520,'shmop_read',' Read data from shared memory block','   string shmop_read (int shmid, int start, int count)');
INSERT INTO "php_manual" VALUES (1521,'shmop_write',' Write data into shared memory block','   int shmop_write (int shmid, string data, int offset)');
INSERT INTO "php_manual" VALUES (1522,'shmop_size',' Get size of shared memory block','   int shmop_size (int shmid)');
INSERT INTO "php_manual" VALUES (1523,'shmop_delete',' Delete shared memory block','   int shmop_delete (int shmid)');
INSERT INTO "php_manual" VALUES (1524,'shmop_close',' Close shared memory block','   int shmop_close (int shmid)');
INSERT INTO "php_manual" VALUES (1525,'swf_openfile',' Open a new Shockwave Flash file','   void swf_openfile (string filename, float width, float height, float');
INSERT INTO "php_manual" VALUES (1526,'swf_closefile',' Close the current Shockwave Flash file','   void swf_closefile ([int return_file])');
INSERT INTO "php_manual" VALUES (1527,'swf_labelframe',' Label the current frame','   void swf_labelframe (string name)');
INSERT INTO "php_manual" VALUES (1528,'swf_showframe',' Display the current frame','   void swf_showframe (void);');
INSERT INTO "php_manual" VALUES (1529,'swf_setframe',' Switch to a specified frame','   void swf_setframe (int framenumber)');
INSERT INTO "php_manual" VALUES (1530,'swf_getframe',' Get the frame number of the current frame','   int swf_getframe (void);');
INSERT INTO "php_manual" VALUES (1531,'swf_mulcolor','  Sets the global multiply color to the rgba value','   void swf_mulcolor (float r, float g, float b, float a)');
INSERT INTO "php_manual" VALUES (1532,'swf_addcolor','  Set the global add color to the rgba value specified','   void swf_addcolor (float r, float g, float b, float a)');
INSERT INTO "php_manual" VALUES (1533,'swf_placeobject',' Place an object onto the screen','   void swf_placeobject (int objid, int depth)');
INSERT INTO "php_manual" VALUES (1534,'swf_modifyobject',' Modify an object','   void swf_modifyobject (int depth, int how)');
INSERT INTO "php_manual" VALUES (1535,'swf_removeobject',' Remove an object','   void swf_removeobject (int depth)');
INSERT INTO "php_manual" VALUES (1536,'swf_nextid',' Returns the next free object id','   int swf_nextid (void);');
INSERT INTO "php_manual" VALUES (1537,'swf_startdoaction','  Start a description of an action list for the','   void swf_startdoaction (void);');
INSERT INTO "php_manual" VALUES (1538,'swf_actiongotoframe',' Play a frame and then stop','   void swf_actiongotoframe (int framenumber)');
INSERT INTO "php_manual" VALUES (1539,'swf_actiongeturl',' Get a URL from a Shockwave Flash movie','   void swf_actiongeturl (string url, string target)');
INSERT INTO "php_manual" VALUES (1540,'swf_actionnextframe',' Go foward one frame','   void swf_actionnextframe (void);');
INSERT INTO "php_manual" VALUES (1541,'swf_actionprevframe',' Go backwards one frame','   void swf_actionprevframe (void);');
INSERT INTO "php_manual" VALUES (1542,'swf_actionplay','  Start playing the flash movie from the current','   void swf_actionplay (void);');
INSERT INTO "php_manual" VALUES (1543,'swf_actionstop','  Stop playing the flash movie at the current frame','   void swf_actionstop (void);');
INSERT INTO "php_manual" VALUES (1544,'swf_actiontogglequality','  Toggle between low and high quality','   void swf_actiontogglequality (void);');
INSERT INTO "php_manual" VALUES (1545,'swf_actionwaitforframe','  Skip actions if a frame has not been loaded','   void swf_actionwaitforframe (int framenumber, int skipcount)');
INSERT INTO "php_manual" VALUES (1546,'swf_actionsettarget',' Set the context for actions','   void swf_actionsettarget (string target)');
INSERT INTO "php_manual" VALUES (1547,'swf_actiongotolabel','  Display a frame with the specified label','   void swf_actiongotolabel (string label)');
INSERT INTO "php_manual" VALUES (1548,'swf_enddoaction',' End the current action','   void swf_enddoaction (void);');
INSERT INTO "php_manual" VALUES (1549,'swf_defineline',' Define a line','   void swf_defineline (int objid, float x1, float y1, float x2, float');
INSERT INTO "php_manual" VALUES (1550,'swf_definerect',' Define a rectangle','   void swf_definerect (int objid, float x1, float y1, float x2, float');
INSERT INTO "php_manual" VALUES (1551,'swf_definepoly','  Define a polygon','   void swf_definepoly (int objid, array coords, int npoints, float');
INSERT INTO "php_manual" VALUES (1552,'swf_startshape',' Start a complex shape','   void swf_startshape (int objid)');
INSERT INTO "php_manual" VALUES (1553,'swf_shapelinesolid',' Set the current line style','   void swf_shapelinesolid (float r, float g, float b, float a, float');
INSERT INTO "php_manual" VALUES (1554,'swf_shapefilloff',' Turns off filling','   void swf_shapefilloff (void);');
INSERT INTO "php_manual" VALUES (1555,'swf_shapefillsolid','  Set the current fill style to the specified','   void swf_shapefillsolid (float r, float g, float b, float a)');
INSERT INTO "php_manual" VALUES (1556,'swf_shapefillbitmapclip','  Set current fill mode to clipped bitmap','   void swf_shapefillbitmapclip (int bitmapid)');
INSERT INTO "php_manual" VALUES (1557,'swf_shapefillbitmaptile','  Set current fill mode to tiled bitmap','   void swf_shapefillbitmaptile (int bitmapid)');
INSERT INTO "php_manual" VALUES (1558,'swf_shapemoveto',' Move the current position','   void swf_shapemoveto (float x, float y)');
INSERT INTO "php_manual" VALUES (1559,'swf_shapelineto',' Draw a line','   void swf_shapelineto (float x, float y)');
INSERT INTO "php_manual" VALUES (1560,'swf_shapecurveto','  Draw a quadratic bezier curve between two points','   void swf_shapecurveto (float x1, float y1, float x2, float y2)');
INSERT INTO "php_manual" VALUES (1561,'swf_shapecurveto3',' Draw a cubic bezier curve','   void swf_shapecurveto3 (float x1, float y1, float x2, float y2, float');
INSERT INTO "php_manual" VALUES (1562,'swf_shapearc',' Draw a circular arc','   void swf_shapearc (float x, float y, float r, float ang1, float ang2)');
INSERT INTO "php_manual" VALUES (1563,'swf_endshape','  Completes the definition of the current shape','   void swf_endshape (void);');
INSERT INTO "php_manual" VALUES (1564,'swf_definefont','  Defines a font','   void swf_definefont (int fontid, string fontname)');
INSERT INTO "php_manual" VALUES (1565,'swf_setfont',' Change the current font','   void swf_setfont (int fontid)');
INSERT INTO "php_manual" VALUES (1566,'swf_fontsize',' Change the font size','   void swf_fontsize (float size)');
INSERT INTO "php_manual" VALUES (1567,'swf_fontslant',' Set the font slant','   void swf_fontslant (float slant)');
INSERT INTO "php_manual" VALUES (1568,'swf_fonttracking',' Set the current font tracking','   void swf_fonttracking (float tracking)');
INSERT INTO "php_manual" VALUES (1569,'swf_getfontinfo','  The height in pixels of a capital A and a','   array swf_getfontinfo (void);');
INSERT INTO "php_manual" VALUES (1570,'swf_definetext',' Define a text string','   void swf_definetext (int objid, string str, int docenter)');
INSERT INTO "php_manual" VALUES (1571,'swf_textwidth',' Get the width of a string','   float swf_textwidth (string str)');
INSERT INTO "php_manual" VALUES (1572,'swf_definebitmap',' Define a bitmap','   void swf_definebitmap (int objid, string image_name)');
INSERT INTO "php_manual" VALUES (1573,'swf_getbitmapinfo',' Get information about a bitmap','   array swf_getbitmapinfo (int bitmapid)');
INSERT INTO "php_manual" VALUES (1574,'swf_startsymbol',' Define a symbol','   void swf_startsymbol (int objid)');
INSERT INTO "php_manual" VALUES (1575,'swf_endsymbol',' End the definition of a symbol','   void swf_endsymbol (void);');
INSERT INTO "php_manual" VALUES (1576,'swf_startbutton',' Start the definition of a button','   void swf_startbutton (int objid, int type)');
INSERT INTO "php_manual" VALUES (1577,'swf_addbuttonrecord','  Controls location, appearance and active area','   void swf_addbuttonrecord (int states, int shapeid, int depth)');
INSERT INTO "php_manual" VALUES (1578,'swf_oncondition','  Describe a transition used to trigger an action','   void swf_oncondition (int transition)');
INSERT INTO "php_manual" VALUES (1579,'swf_endbutton','  End the definition of the current button','   void swf_endbutton (void);');
INSERT INTO "php_manual" VALUES (1580,'swf_viewport',' Select an area for future drawing','   void swf_viewport (FLOAT8xmin, double xmax, double ymin, double ymax)');
INSERT INTO "php_manual" VALUES (1581,'swf_ortho','  Defines an orthographic mapping of user coordinates onto','   void swf_ortho (FLOAT8xmin, double xmax, double ymin, double ymax,');
INSERT INTO "php_manual" VALUES (1582,'swf_ortho2','  Defines 2D orthographic mapping of user coordinates','   void swf_ortho2 (FLOAT8xmin, double xmax, double ymin, double ymax)');
INSERT INTO "php_manual" VALUES (1583,'swf_perspective','  Define a perspective projection transformation','   void swf_perspective (FLOAT8fovy, double aspect, double near, double');
INSERT INTO "php_manual" VALUES (1584,'swf_polarview','  Define the viewer\'s position with polar coordinates','   void swf_polarview (FLOAT8dist, double azimuth, double incidence,');
INSERT INTO "php_manual" VALUES (1585,'swf_lookat',' Define a viewing transformation','   void swf_lookat (FLOAT8view_x, double view_y, double view_z, double');
INSERT INTO "php_manual" VALUES (1586,'swf_pushmatrix','  Push the current transformation matrix back unto','   void swf_pushmatrix (void);');
INSERT INTO "php_manual" VALUES (1587,'swf_popmatrix','  Restore a previous transformation matrix','   void swf_popmatrix (void);');
INSERT INTO "php_manual" VALUES (1588,'swf_scale',' Scale the current transformation','   void swf_scale (FLOAT8x, double y, double z)');
INSERT INTO "php_manual" VALUES (1589,'swf_translate',' Translate the current transformations','   void swf_translate (FLOAT8x, double y, double z)');
INSERT INTO "php_manual" VALUES (1590,'swf_rotate',' Rotate the current transformation','   void swf_rotate (FLOAT8angle, string axis)');
INSERT INTO "php_manual" VALUES (1591,'swf_posround','  Enables or Disables the rounding of the translation','   void swf_posround (int round)');
INSERT INTO "php_manual" VALUES (1592,'snmpget',' Fetch an SNMP object','   string snmpget (string hostname, string community, string object_id [,');
INSERT INTO "php_manual" VALUES (1593,'snmpset',' Set an SNMP object','   bool snmpset (string hostname, string community, string object_id,');
INSERT INTO "php_manual" VALUES (1594,'snmpwalk',' Fetch all the SNMP objects from an agent','   array snmpwalk (string hostname, string community, string object_id [,');
INSERT INTO "php_manual" VALUES (1595,'snmpwalkoid',' Query for a tree of information about a network entity','   array snmpwalkoid (string hostname, string community, string object_id');
INSERT INTO "php_manual" VALUES (1596,'snmp_get_quick_print',' Fetch the current value of the UCD library\'s','   boolean snmp_get_quick_print (void )');
INSERT INTO "php_manual" VALUES (1597,'snmp_set_quick_print',' Set the value of quick_print within the UCD','   void snmp_set_quick_print (boolean quick_print)');
INSERT INTO "php_manual" VALUES (1598,'accept_connect',' Accepts a connection on a socket','   int accept_connect (int socket)');
INSERT INTO "php_manual" VALUES (1599,'bind',' Binds a name to a socket','   int bind (int socket, string address [, int port])');
INSERT INTO "php_manual" VALUES (1600,'close',' Closes a file descriptor','   bool close (int socket)');
INSERT INTO "php_manual" VALUES (1601,'connect',' Initiates a connection on a socket','   int connect (int socket, string address [, int port])');
INSERT INTO "php_manual" VALUES (1602,'listen',' Listens for a connection on a socket','   int listen (int socket, int backlog)');
INSERT INTO "php_manual" VALUES (1603,'read',' Read from a socket','   int read (int socket_des, string &buffer, int length)');
INSERT INTO "php_manual" VALUES (1604,'socket',' Create a socket (endpoint for communication)','   int socket (int domain, int type, int protocol)');
INSERT INTO "php_manual" VALUES (1605,'strerror',' Return a string describing a socket error','   string strerror (int errno)');
INSERT INTO "php_manual" VALUES (1606,'write',' Write to a socket','   int write (int socket_des, string &buffer, int length)');
INSERT INTO "php_manual" VALUES (1607,'AddCSlashes',' Quote string with slashes in a C style','   string addcslashes (string str, string charlist)');
INSERT INTO "php_manual" VALUES (1608,'AddSlashes',' Quote string with slashes','   string addslashes (string str)');
INSERT INTO "php_manual" VALUES (1609,'bin2hex','  Convert binary data into hexadecimal representation','   string bin2hex (string str)');
INSERT INTO "php_manual" VALUES (1610,'Chop',' Remove trailing whitespace','   string chop (string str)');
INSERT INTO "php_manual" VALUES (1611,'Chr',' Return a specific character','   string chr (int ascii)');
INSERT INTO "php_manual" VALUES (1612,'chunk_split',' Split a string into smaller chunks','   string chunk_split (string string [, int chunklen [, string end]])');
INSERT INTO "php_manual" VALUES (1613,'convert_cyr_string','  Convert from one Cyrillic character set to','   string convert_cyr_string (string str, string from, string to)');
INSERT INTO "php_manual" VALUES (1614,'count_chars','  Return information abouts characters used in a string','   mixed count_chars (string string [, mode])');
INSERT INTO "php_manual" VALUES (1615,'crc32',' Calculates the crc32 polynomial of a string','   int crc32 (string str)');
INSERT INTO "php_manual" VALUES (1616,'crypt',' DES-encrypt a string','   string crypt (string str [, string salt])');
INSERT INTO "php_manual" VALUES (1617,'echo',' Output one or more strings','   echo (string arg1, string [argn]...)');
INSERT INTO "php_manual" VALUES (1618,'explode',' Split a string by string','   array explode (string separator, string string [, int limit])');
INSERT INTO "php_manual" VALUES (1619,'get_html_translation_table','  Returns the translation table used by','   string get_html_translation_table (int table [, int quote_style])');
INSERT INTO "php_manual" VALUES (1620,'get_meta_tags','  Extracts all meta tag content attributes from a file','   array get_meta_tags (string filename [, int use_include_path])');
INSERT INTO "php_manual" VALUES (1621,'hebrev','  Convert logical Hebrew text to visual text','   string hebrev (string hebrew_text [, int max_chars_per_line])');
INSERT INTO "php_manual" VALUES (1622,'hebrevc','  Convert logical Hebrew text to visual text with newline','   string hebrevc (string hebrew_text [, int max_chars_per_line])');
INSERT INTO "php_manual" VALUES (1623,'htmlentities','  Convert all applicable characters to HTML entities','   string htmlentities (string string [, int quote_style])');
INSERT INTO "php_manual" VALUES (1624,'htmlspecialchars','  Convert special characters to HTML entities','   string htmlspecialchars (string string [, int quote_style])');
INSERT INTO "php_manual" VALUES (1625,'implode',' Join array elements with a string','   string implode (string glue, array pieces)');
INSERT INTO "php_manual" VALUES (1626,'join',' Join array elements with a string','   string join (string glue, array pieces)');
INSERT INTO "php_manual" VALUES (1627,'levenshtein','  Calculate Levenshtein distance between two strings','   int levenshtein (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1628,'localeconv',' Get numeric formatting information','   array localeconv(void);');
INSERT INTO "php_manual" VALUES (1629,'ltrim','  Strip whitespace from the beginning of a string','   string ltrim (string str)');
INSERT INTO "php_manual" VALUES (1630,'md5',' Calculate the md5 hash of a string','   string md5 (string str)');
INSERT INTO "php_manual" VALUES (1631,'Metaphone',' Calculate the metaphone key of a string','   string metaphone (string str)');
INSERT INTO "php_manual" VALUES (1632,'nl2br',' Inserts HTML line breaks before all newlines in a string','   string nl2br (string string)');
INSERT INTO "php_manual" VALUES (1633,'Ord',' Return ASCII value of character','   int ord (string string)');
INSERT INTO "php_manual" VALUES (1634,'parse_str',' Parses the string into variables','   void parse_str (string str [, array arr])');
INSERT INTO "php_manual" VALUES (1635,'print',' Output a string','   print (string arg)');
INSERT INTO "php_manual" VALUES (1636,'printf',' Output a formatted string','   int printf (string format [, mixed args...])');
INSERT INTO "php_manual" VALUES (1637,'quoted_printable_decode','  Convert a quoted-printable string to an 8','   string quoted_printable_decode (string str)');
INSERT INTO "php_manual" VALUES (1638,'quotemeta',' Quote meta characters','   string quotemeta (string str)');
INSERT INTO "php_manual" VALUES (1639,'rtrim',' Remove trailing whitespace.','   string rtrim (string str)');
INSERT INTO "php_manual" VALUES (1640,'sscanf',' Parses input from a string according to a format','   mixed sscanf (string str, string format [, string var1...])');
INSERT INTO "php_manual" VALUES (1641,'setlocale',' Set locale information','   string setlocale (mixed category, string locale)');
INSERT INTO "php_manual" VALUES (1642,'similar_text','  Calculate the similarity between two strings','   int similar_text (string first, string second [, FLOAT8percent])');
INSERT INTO "php_manual" VALUES (1643,'soundex',' Calculate the soundex key of a string','   string soundex (string str)');
INSERT INTO "php_manual" VALUES (1644,'sprintf',' Return a formatted string','   string sprintf (string format [, mixed args...])');
INSERT INTO "php_manual" VALUES (1645,'strncasecmp','  Binary safe case-insensitive string comparison of the','   int strncasecmp (string str1, string str2, int len)');
INSERT INTO "php_manual" VALUES (1646,'strcasecmp','  Binary safe case-insensitive string comparison','   int strcasecmp (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1647,'strchr','  Find the first occurrence of a character','   string strchr (string haystack, string needle)');
INSERT INTO "php_manual" VALUES (1648,'strcmp',' Binary safe string comparison','   int strcmp (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1649,'strcoll',' Locale based string comparison','   int strcoll (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1650,'strcspn','  Find length of initial segment not matching mask','   int strcspn (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1651,'strip_tags',' Strip HTML and PHP tags from a string','   string strip_tags (string str [, string allowable_tags])');
INSERT INTO "php_manual" VALUES (1652,'stripcslashes','  Un-quote string quoted with addcslashes()','   string stripcslashes (string str)');
INSERT INTO "php_manual" VALUES (1653,'stripslashes','  Un-quote string quoted with addslashes()','   string stripslashes (string str)');
INSERT INTO "php_manual" VALUES (1654,'stristr','  Case-insensitive strstr()','   string stristr (string haystack, string needle)');
INSERT INTO "php_manual" VALUES (1655,'strlen',' Get string length','   int strlen (string str)');
INSERT INTO "php_manual" VALUES (1656,'strnatcmp','  String comparisons using a \"natural order\" algorithm','   int strnatcmp (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1657,'strnatcasecmp','  Case insensitive string comparisons using a \"natural','   int strnatcasecmp (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1658,'strncmp','  Binary safe string comparison of the first n characters','   int strncmp (string str1, string str2, int len)');
INSERT INTO "php_manual" VALUES (1659,'str_pad',' Pad a string to a certain length with another string','   string str_pad (string input, int pad_length [, string pad_string [,');
INSERT INTO "php_manual" VALUES (1660,'strpos','  Find position of first occurrence of a string','   int strpos (string haystack, string needle [, int offset])');
INSERT INTO "php_manual" VALUES (1661,'strrchr','  Find the last occurrence of a character in a string','   string strrchr (string haystack, string needle)');
INSERT INTO "php_manual" VALUES (1662,'str_repeat',' Repeat a string','   string str_repeat (string input, int multiplier)');
INSERT INTO "php_manual" VALUES (1663,'strrev',' Reverse a string','   string strrev (string string)');
INSERT INTO "php_manual" VALUES (1664,'strrpos','  Find position of last occurrence of a char in a string','   int strrpos (string haystack, char needle)');
INSERT INTO "php_manual" VALUES (1665,'strspn','  Find length of initial segment matching mask','   int strspn (string str1, string str2)');
INSERT INTO "php_manual" VALUES (1666,'strstr',' Find first occurrence of a string','   string strstr (string haystack, string needle)');
INSERT INTO "php_manual" VALUES (1667,'strtok',' Tokenize string','   string strtok (string arg1, string arg2)');
INSERT INTO "php_manual" VALUES (1668,'strtolower',' Make a string lowercase','   string strtolower (string str)');
INSERT INTO "php_manual" VALUES (1669,'strtoupper',' Make a string uppercase','   string strtoupper (string string)');
INSERT INTO "php_manual" VALUES (1670,'str_replace','  Replace all occurrences of the search string with the','   mixed str_replace (mixed search, mixed replace, mixed subject)');
INSERT INTO "php_manual" VALUES (1671,'strtr',' Translate certain characters','   string strtr (string str, string from, string to)');
INSERT INTO "php_manual" VALUES (1672,'substr',' Return part of a string','   string substr (string string, int start [, int length])');
INSERT INTO "php_manual" VALUES (1673,'substr_count',' Count the number of substring occurrences','   int substr_count (string haystrack, string needle)');
INSERT INTO "php_manual" VALUES (1674,'substr_replace',' Replace text within a portion of a string','   string substr_replace (string string, string replacement, int start [,');
INSERT INTO "php_manual" VALUES (1675,'trim','  Strip whitespace from the beginning and end of a string','   string trim (string str)');
INSERT INTO "php_manual" VALUES (1676,'ucfirst',' Make a string\'s first character uppercase','   string ucfirst (string str)');
INSERT INTO "php_manual" VALUES (1677,'ucwords','  Uppercase the first character of each word in a string','   string ucwords (string str)');
INSERT INTO "php_manual" VALUES (1678,'wordwrap','  Wraps a string to a given number of characters using a','   string wordwrap (string str [, int width [, string break [, int');
INSERT INTO "php_manual" VALUES (1679,'sybase_affected_rows',' get number of affected rows in last query','   int sybase_affected_rows ([int link_identifier])');
INSERT INTO "php_manual" VALUES (1680,'sybase_close',' close Sybase connection','   bool sybase_close (int link_identifier)');
INSERT INTO "php_manual" VALUES (1681,'sybase_connect',' open Sybase server connection','   int sybase_connect (string servername, string username, string');
INSERT INTO "php_manual" VALUES (1682,'sybase_data_seek',' move internal row pointer','   bool sybase_data_seek (int result_identifier, int row_number)');
INSERT INTO "php_manual" VALUES (1683,'sybase_fetch_array',' fetch row as array','   array sybase_fetch_array (int result)');
INSERT INTO "php_manual" VALUES (1684,'sybase_fetch_field',' get field information','   object sybase_fetch_field (int result [, int field_offset])');
INSERT INTO "php_manual" VALUES (1685,'sybase_fetch_object',' fetch row as object','   int sybase_fetch_object (int result)');
INSERT INTO "php_manual" VALUES (1686,'sybase_fetch_row',' get row as enumerated array','   array sybase_fetch_row (int result)');
INSERT INTO "php_manual" VALUES (1687,'sybase_field_seek',' set field offset','   int sybase_field_seek (int result, int field_offset)');
INSERT INTO "php_manual" VALUES (1688,'sybase_free_result',' free result memory','   bool sybase_free_result (int result)');
INSERT INTO "php_manual" VALUES (1689,'sybase_get_last_message',' Returns the last message from the server','   string sybase_get_last_message (void )');
INSERT INTO "php_manual" VALUES (1690,'sybase_min_client_severity',' Sets minimum client severity','   void sybase_min_client_severity (int severity)');
INSERT INTO "php_manual" VALUES (1691,'sybase_min_error_severity',' Sets minimum error severity','   void sybase_min_error_severity (int severity)');
INSERT INTO "php_manual" VALUES (1692,'sybase_min_message_severity',' Sets minimum message severity','   void sybase_min_message_severity (int severity)');
INSERT INTO "php_manual" VALUES (1693,'sybase_min_server_severity',' Sets minimum server severity','   void sybase_min_server_severity (int severity)');
INSERT INTO "php_manual" VALUES (1694,'sybase_num_fields',' get number of fields in result','   int sybase_num_fields (int result)');
INSERT INTO "php_manual" VALUES (1695,'sybase_num_rows',' get number of rows in result','   int sybase_num_rows (int result)');
INSERT INTO "php_manual" VALUES (1696,'sybase_pconnect',' open persistent Sybase connection','   int sybase_pconnect (string servername, string username, string');
INSERT INTO "php_manual" VALUES (1697,'sybase_query',' send Sybase query','   int sybase_query (string query, int link_identifier)');
INSERT INTO "php_manual" VALUES (1698,'sybase_result',' get result data','   string sybase_result (int result, int row, mixed field)');
INSERT INTO "php_manual" VALUES (1699,'sybase_select_db',' select Sybase database','   bool sybase_select_db (string database_name, int link_identifier)');
INSERT INTO "php_manual" VALUES (1700,'base64_decode',' Decodes data encoded with MIME base64','   string base64_decode (string encoded_data)');
INSERT INTO "php_manual" VALUES (1701,'base64_encode',' Encodes data with MIME base64','   string base64_encode (string data)');
INSERT INTO "php_manual" VALUES (1702,'parse_url',' Parse a URL and return its components','   array parse_url (string url)');
INSERT INTO "php_manual" VALUES (1703,'rawurldecode',' Decode URL-encoded strings','   string rawurldecode (string str)');
INSERT INTO "php_manual" VALUES (1704,'rawurlencode',' URL-encode according to RFC1738','   string rawurlencode (string str)');
INSERT INTO "php_manual" VALUES (1705,'urldecode',' Decodes URL-encoded string','   string urldecode (string str)');
INSERT INTO "php_manual" VALUES (1706,'urlencode',' URL-encodes string','   string urlencode (string str)');
INSERT INTO "php_manual" VALUES (1707,'doubleval',' Get FLOAT8value of a variable','   double doubleval (mixed var)');
INSERT INTO "php_manual" VALUES (1708,'empty',' Determine whether a variable is set','   int empty (mixed var)');
INSERT INTO "php_manual" VALUES (1709,'gettype',' Get the type of a variable','   string gettype (mixed var)');
INSERT INTO "php_manual" VALUES (1710,'get_defined_vars','  Returns an array of all defined variables','   array get_defined_vars (void )');
INSERT INTO "php_manual" VALUES (1711,'get_resource_type','  Returns the resource type','   string get_resource_type (resource $handle)');
INSERT INTO "php_manual" VALUES (1712,'intval',' Get integer value of a variable','   int intval (mixed var [, int base])');
INSERT INTO "php_manual" VALUES (1713,'is_array',' Finds whether a variable is an array','   bool is_array (mixed var)');
INSERT INTO "php_manual" VALUES (1714,'is_bool','  Finds out whether a variable is a boolean','   bool is_bool (mixed var)');
INSERT INTO "php_manual" VALUES (1715,'is_double',' Finds whether a variable is a FLOAT8,'   bool is_double (mixed var)');
INSERT INTO "php_manual" VALUES (1716,'is_float',' Finds whether a variable is a float','   bool is_float (mixed var)');
INSERT INTO "php_manual" VALUES (1717,'is_int',' Find whether a variable is an integer','   bool is_int (mixed var)');
INSERT INTO "php_manual" VALUES (1718,'is_integer',' Find whether a variable is an integer','   bool is_integer (mixed var)');
INSERT INTO "php_manual" VALUES (1719,'is_long',' Finds whether a variable is an integer','   bool is_long (mixed var)');
INSERT INTO "php_manual" VALUES (1720,'is_null','  Finds whether a variable is null','   bool is_null (mixed var)');
INSERT INTO "php_manual" VALUES (1721,'is_numeric','  Finds whether a variable is a number or a numeric','   bool is_numeric (mixed var)');
INSERT INTO "php_manual" VALUES (1722,'is_object',' Finds whether a variable is an object','   bool is_object (mixed var)');
INSERT INTO "php_manual" VALUES (1723,'is_real',' Finds whether a variable is a FLOAT8,'   bool is_real (mixed var)');
INSERT INTO "php_manual" VALUES (1724,'is_resource','  Finds whether a variable is a resource','   bool is_resource (mixed var)');
INSERT INTO "php_manual" VALUES (1725,'is_scalar','  Finds whether a variable is a scalar','   bool is_scalar (mixed var)');
INSERT INTO "php_manual" VALUES (1726,'is_string',' Finds whether a variable is a string','   bool is_string (mixed var)');
INSERT INTO "php_manual" VALUES (1727,'isset',' Determine whether a variable is set','   int isset (mixed var)');
INSERT INTO "php_manual" VALUES (1728,'print_r','  Prints human-readable information about a variable','   void print_r (mixed expression)');
INSERT INTO "php_manual" VALUES (1729,'serialize','  Generates a storable representation of a value','   string serialize (mixed value)');
INSERT INTO "php_manual" VALUES (1730,'settype',' Set the type of a variable','   int settype (string var, string type)');
INSERT INTO "php_manual" VALUES (1731,'strval',' Get string value of a variable','   string strval (mixed var)');
INSERT INTO "php_manual" VALUES (1732,'unserialize','  Creates a PHP value from a stored representation','   mixed unserialize (string str)');
INSERT INTO "php_manual" VALUES (1733,'unset',' Unset a given variable','   void unset (mixed var [, mixed var [, ...]])');
INSERT INTO "php_manual" VALUES (1734,'var_dump',' Dumps information about a variable','   void var_dump (mixed expression)');
INSERT INTO "php_manual" VALUES (1735,'wddx_serialize_value',' Serialize a single value into a WDDX packet','   string wddx_serialize_value (mixed var [, string comment])');
INSERT INTO "php_manual" VALUES (1736,'wddx_serialize_vars',' Serialize variables into a WDDX packet','   string wddx_serialize_vars (mixed var_name [, mixed ...])');
INSERT INTO "php_manual" VALUES (1737,'wddx_packet_start','  Starts a new WDDX packet with structure inside','   int wddx_packet_start ([string comment])');
INSERT INTO "php_manual" VALUES (1738,'wddx_packet_end',' Ends a WDDX packet with the specified ID','   string wddx_packet_end (int packet_id)');
INSERT INTO "php_manual" VALUES (1739,'wddx_add_vars','  Add variables to a WDDX packet with the specified ID','   wddx_add_vars (int packet_id, mixed name_var [, mixed ...])');
INSERT INTO "php_manual" VALUES (1740,'wddx_deserialize',' Deserializes a WDDX packet','   mixed wddx_deserialize (string packet)');
INSERT INTO "php_manual" VALUES (1741,'xml_parser_create',' create an XML parser','   int xml_parser_create ([string encoding])');
INSERT INTO "php_manual" VALUES (1742,'xml_set_object',' Use XML Parser within an object','   void xml_set_object (int parser, object &object)');
INSERT INTO "php_manual" VALUES (1743,'xml_set_element_handler',' set up start and end element handlers','   int xml_set_element_handler (int parser, string startElementHandler,');
INSERT INTO "php_manual" VALUES (1744,'xml_set_character_data_handler',' set up character data handler','   int xml_set_character_data_handler (int parser, string handler)');
INSERT INTO "php_manual" VALUES (1745,'xml_set_processing_instruction_handler','  Set up processing','   int xml_set_processing_instruction_handler (int parser, string');
INSERT INTO "php_manual" VALUES (1746,'xml_set_DEFAULT_handler',' set up default handler','   int xml_set_default_handler (int parser, string handler)');
INSERT INTO "php_manual" VALUES (1747,'xml_set_unparsed_entity_decl_handler','  Set up unparsed entity','   int xml_set_unparsed_entity_decl_handler (int parser, string handler)');
INSERT INTO "php_manual" VALUES (1748,'xml_set_notation_decl_handler',' set up notation declaration handler','   int xml_set_notation_decl_handler (int parser, string handler)');
INSERT INTO "php_manual" VALUES (1749,'xml_set_external_entity_ref_handler',' set up external entity','   int xml_set_external_entity_ref_handler (int parser, string handler)');
INSERT INTO "php_manual" VALUES (1750,'xml_parse',' start parsing an XML document','   int xml_parse (int parser, string data [, int isFinal])');
INSERT INTO "php_manual" VALUES (1751,'xml_get_error_code',' get XML parser error code','   int xml_get_error_code (int parser)');
INSERT INTO "php_manual" VALUES (1752,'xml_error_string',' get XML parser error string','   string xml_error_string (int code)');
INSERT INTO "php_manual" VALUES (1753,'xml_get_current_line_number',' get current line number for an XML','   int xml_get_current_line_number (int parser)');
INSERT INTO "php_manual" VALUES (1754,'xml_get_current_column_number','  Get current column number for an XML','   int xml_get_current_column_number (int parser)');
INSERT INTO "php_manual" VALUES (1755,'xml_get_current_byte_index',' get current byte index for an XML parser','   int xml_get_current_byte_index (int parser)');
INSERT INTO "php_manual" VALUES (1756,'xml_parse_into_struct',' Parse XML data into an array structure','   int xml_parse_into_struct (int parser, string data, array &values,');
INSERT INTO "php_manual" VALUES (1757,'xml_parser_free',' Free an XML parser','   string xml_parser_free (int parser)');
INSERT INTO "php_manual" VALUES (1758,'xml_parser_set_option',' set options in an XML parser','   int xml_parser_set_option (int parser, int option, mixed value)');
INSERT INTO "php_manual" VALUES (1759,'xml_parser_get_option',' get options from an XML parser','   mixed xml_parser_get_option (int parser, int option)');
INSERT INTO "php_manual" VALUES (1760,'utf8_decode','  Converts a string with ISO-8859-1 characters encoded','   string utf8_decode (string data)');
INSERT INTO "php_manual" VALUES (1761,'utf8_encode',' encodes an ISO-8859-1 string to UTF-8','   string utf8_encode (string data)');
INSERT INTO "php_manual" VALUES (1762,'xslt_closelog',' Clear the logfile for a given instance of Sablotron','   bool xslt_closelog (resource xh)');
INSERT INTO "php_manual" VALUES (1763,'xslt_create',' Create a new XSL processor.','   resource xslt_create(void);');
INSERT INTO "php_manual" VALUES (1764,'xslt_errno',' Return the current error number','   int xslt_errno (int xh)');
INSERT INTO "php_manual" VALUES (1765,'xslt_error',' Return the current error string','   mixed xslt_error (int xh)');
INSERT INTO "php_manual" VALUES (1766,'xslt_fetch_result',' Fetch a (named) result buffer','   string xslt_fetch_result (int xh string result_name)');
INSERT INTO "php_manual" VALUES (1767,'xslt_free',' Free XSLT processor','   void xslt_free (resource xh)');
INSERT INTO "php_manual" VALUES (1768,'xslt_openlog',' Set a logfile for XSLT processor messages','   bool xslt_openlog (resource xh string logfile int loglevel)');
INSERT INTO "php_manual" VALUES (1769,'xslt_output_begintransform',' Begin an XSLT transformation on the','   void xslt_output_begintransform (string xslt_filename)');
INSERT INTO "php_manual" VALUES (1770,'xslt_output_endtransform',' End an output transformation started with','   void xslt_output_endtransform (void);');
INSERT INTO "php_manual" VALUES (1771,'xslt_process',' Transform XML data through a string containing XSL','   bool xslt_process (string xsl_data string xml_data string result)');
INSERT INTO "php_manual" VALUES (1772,'xslt_run',' Apply a XSLT stylesheet to a file.','   bool xslt_run (resource xh string xslt_file string xml_data_file');
INSERT INTO "php_manual" VALUES (1773,'xslt_set_sax_handler',' Set SAX handlers for a XSLT processor','   bool xslt_set_sax_handler (resource xh array handlers)');
INSERT INTO "php_manual" VALUES (1774,'xslt_transform',' Perform an XSLT transformation','   bool xslt_transform (string xsl string xml string result string params');
INSERT INTO "php_manual" VALUES (1775,'yaz_addinfo',' Returns additional error information','   int yaz_addinfo (int id)');
INSERT INTO "php_manual" VALUES (1776,'yaz_close',' Closes a YAZ connection','   int yaz_close (int id)');
INSERT INTO "php_manual" VALUES (1777,'yaz_connect','  Prepares for a connection and Z-association to a','   int yaz_connect (string zurl [, string authentication])');
INSERT INTO "php_manual" VALUES (1778,'yaz_errno',' Returns error number','   int yaz_errno (int id)');
INSERT INTO "php_manual" VALUES (1779,'yaz_error',' Returns error description','   string yaz_error (int id)');
INSERT INTO "php_manual" VALUES (1780,'yaz_hits',' Returns number of hits for last search','   int yaz_hits (int id)');
INSERT INTO "php_manual" VALUES (1781,'yaz_element','  Specifies Element-Set Name for retrieval','   int yaz_element (int id, string elementset)');
INSERT INTO "php_manual" VALUES (1782,'yaz_database','  Specifies the databases within a session','   int yaz_database (int id, string databases)');
INSERT INTO "php_manual" VALUES (1783,'yaz_range','  Specifies the maximum number of records to retrieve','   int yaz_range (int id, int start, int number)');
INSERT INTO "php_manual" VALUES (1784,'yaz_record',' Returns a record','   int yaz_record (int id, int pos, string type)');
INSERT INTO "php_manual" VALUES (1785,'yaz_search',' Prepares for a search','   int yaz_search (int id, string type, string query)');
INSERT INTO "php_manual" VALUES (1786,'yaz_present','  Prepares for retrieval (Z39.50 present).','   int yaz_present(void);');
INSERT INTO "php_manual" VALUES (1787,'yaz_syntax','  Specifies the preferred record syntax for retrieval.','   int yaz_syntax (int id, string syntax)');
INSERT INTO "php_manual" VALUES (1788,'yaz_scan',' Prepares for a scan','   int yaz_scan (int id, string type, string startterm [, array flags])');
INSERT INTO "php_manual" VALUES (1789,'yaz_scan_result',' Returns Scan Response result','   array yaz_scan_result (int id [, array & result])');
INSERT INTO "php_manual" VALUES (1790,'yaz_ccl_conf',' Configure CCL parser','   int yaz_ccl_conf (int id, array config)');
INSERT INTO "php_manual" VALUES (1791,'yaz_ccl_parse',' Invoke CCL Parser','   int yaz_ccl_parse (int id, string query, array &result)');
INSERT INTO "php_manual" VALUES (1792,'yaz_itemorder','  Prepares for Z39.50 Item Order with an ILL-Request','   int yaz_itemorder (array args)');
INSERT INTO "php_manual" VALUES (1793,'yaz_wait',' Wait for Z39.50 requests to complete','   int yaz_wait(void);');
INSERT INTO "php_manual" VALUES (1794,'yp_get_DEFAULT_domain',' Fetches the machine\'s default NIS domain','   int yp_get_default_domain (void )');
INSERT INTO "php_manual" VALUES (1795,'yp_order',' Returns the order number for a map','   int yp_order (string domain, string map)');
INSERT INTO "php_manual" VALUES (1796,'yp_master','  Returns the machine name of the master NIS server for a','   string yp_master (string domain, string map)');
INSERT INTO "php_manual" VALUES (1797,'yp_match',' Returns the matched line','   string yp_match (string domain, string map, string key)');
INSERT INTO "php_manual" VALUES (1798,'yp_first','  Returns the first key-value pair from the named map','   array yp_first (string domain, string map)');
INSERT INTO "php_manual" VALUES (1799,'yp_next',' Returns the next key-value pair in the named map.','   array yp_next (string domain, string map, string key)');
INSERT INTO "php_manual" VALUES (1800,'gzclose',' Close an open gz-file pointer','   int gzclose (int zp)');
INSERT INTO "php_manual" VALUES (1801,'gzeof',' Test for end-of-file on a gz-file pointer','   int gzeof (int zp)');
INSERT INTO "php_manual" VALUES (1802,'gzfile',' Read entire gz-file into an array','   array gzfile (string filename [, int use_include_path])');
INSERT INTO "php_manual" VALUES (1803,'gzgetc',' Get character from gz-file pointer','   string gzgetc (int zp)');
INSERT INTO "php_manual" VALUES (1804,'gzgets',' Get line from file pointer','   string gzgets (int zp, int length)');
INSERT INTO "php_manual" VALUES (1805,'gzgetss','  Get line from gz-file pointer and strip HTML tags','   string gzgetss (int zp, int length [, string allowable_tags])');
INSERT INTO "php_manual" VALUES (1806,'gzopen',' Open gz-file','   int gzopen (string filename, string mode [, int use_include_path])');
INSERT INTO "php_manual" VALUES (1807,'gzpassthru','  Output all remaining data on a gz-file pointer','   int gzpassthru (int zp)');
INSERT INTO "php_manual" VALUES (1808,'gzputs',' Write to a gz-file pointer','   int gzputs (int zp, string str [, int length])');
INSERT INTO "php_manual" VALUES (1809,'gzread',' Binary-safe gz-file read','   string gzread (int zp, int length)');
INSERT INTO "php_manual" VALUES (1810,'gzrewind',' Rewind the position of a gz-file pointer','   int gzrewind (int zp)');
INSERT INTO "php_manual" VALUES (1811,'gzseek',' Seek on a gz-file pointer','   int gzseek (int zp, int offset)');
INSERT INTO "php_manual" VALUES (1812,'gztell',' Tell gz-file pointer read/write position','   int gztell (int zp)');
INSERT INTO "php_manual" VALUES (1813,'gzwrite',' Binary-safe gz-file write','   int gzwrite (int zp, string string [, int length])');
INSERT INTO "php_manual" VALUES (1814,'readgzfile',' Output a gz-file','   int readgzfile (string filename [, int use_include_path])');
INSERT INTO "php_manual" VALUES (1815,'gzcompress',' Compress a string','   string gzcompress (string data [, int level])');
INSERT INTO "php_manual" VALUES (1816,'gzuncompress',' Uncompress a deflated string','   string gzuncompress (string data [, int length])');
INSERT INTO "php_manual" VALUES (1817,'gzdeflate',' Deflate a string','   string gzdeflate (string data [, int level])');
INSERT INTO "php_manual" VALUES (1818,'gzinflate',' Inflate a deflated string','   string gzinflate (string data [, int length])');
INSERT INTO "php_manual" VALUES (1819,'gzencode',' Create a gzip compressed string','   string gzencode (string data [, int level])');
INSERT INTO "php_manual" VALUES (1820,'class classname extends PEAR { ... }',' PEAR base class','   The PEAR base class provides standard functionality that is used by');
INSERT INTO "php_manual" VALUES (1821,'Methods',' PEAR error mechanism base class','   PEAR_Error constructor. Parameters:');

--
-- Table structure for table 'server_error'
--



--
-- Sequences for table SERVER_ERROR
--

CREATE SEQUENCE server_error_server_error_id;

CREATE TABLE "server_error" (
  "server_error_id" INT4 DEFAULT nextval('server_error_server_error_id'),
  "time" INT4 NOT NULL DEFAULT '0',
  "error" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("server_error_id")

);

--
-- Dumping data for table 'server_error'
--

INSERT INTO "server_error" VALUES (1,987288277,'ERROR :Closing Link: php_bot by Flanders.Be.Eu.Undernet.org (Ping timeout)\r\n');
INSERT INTO "server_error" VALUES (2,987288281,'ERROR :Closing Link: php_bot by Amsterdam.NL.EU.undernet.org (Too many connections from your host)\r\n');
INSERT INTO "server_error" VALUES (3,987288290,'ERROR :Closing Link: php_bot by Diemen.NL.EU.Undernet.org (Too many connections from your host)\r\n');
INSERT INTO "server_error" VALUES (4,987288296,'ERROR :Closing Link: php_bot by Diemen.NL.EU.Undernet.org (Too many connections from your host)\r\n');
INSERT INTO "server_error" VALUES (5,987288305,'ERROR :Closing Link: php_bot by Haarlem.NL.EU.UnderNet.Org (Too many connections from your host)\r\n');
INSERT INTO "server_error" VALUES (6,987288497,'ERROR :Closing Link: php_bot by Oslo.no.eu.undernet.org (Ping timeout)\r\n');
INSERT INTO "server_error" VALUES (7,987288499,'ERROR :Closing Link: php_bot2 by Diemen.NL.EU.Undernet.org (Too many connections from your host)\r\n');
INSERT INTO "server_error" VALUES (8,987288504,'ERROR :Closing Link: php_bot by Haarlem.NL.EU.UnderNet.Org (Too many connections from your host)\r\n');
INSERT INTO "server_error" VALUES (9,987288518,'ERROR :Closing Link: php_bot by Haarlem.NL.EU.UnderNet.Org (Too many connections from your host)\r\n');
INSERT INTO "server_error" VALUES (10,987288587,'ERROR :Closing Link: php_bot by graz2.at.Eu.UnderNet.org (Too many connections from your host)\r\n');

--
-- Table structure for table 'server_groups'
--



--
-- Sequences for table SERVER_GROUPS
--

CREATE SEQUENCE server_groups_server_groups_;

CREATE TABLE "server_groups" (
  "server_groups_id" INT4 DEFAULT nextval('server_groups_server_groups_'),
  "server_group" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("server_groups_id")

);

--
-- Dumping data for table 'server_groups'
--

INSERT INTO "server_groups" VALUES (1,'Random US DALnet server');
INSERT INTO "server_groups" VALUES (2,'Random EU DALnet server');
INSERT INTO "server_groups" VALUES (3,'Random US EFnet server');
INSERT INTO "server_groups" VALUES (4,'Random EU EFnet server');
INSERT INTO "server_groups" VALUES (5,'Random CA EFnet server');
INSERT INTO "server_groups" VALUES (6,'Random AU EFnet server');
INSERT INTO "server_groups" VALUES (7,'Random US IRCnet server');
INSERT INTO "server_groups" VALUES (8,'Random EU IRCnet server');
INSERT INTO "server_groups" VALUES (9,'Random AU IRCnet server');
INSERT INTO "server_groups" VALUES (10,'Random US Undernet server');
INSERT INTO "server_groups" VALUES (11,'Random EU Undernet server');
INSERT INTO "server_groups" VALUES (12,'Accessirc');
INSERT INTO "server_groups" VALUES (13,'Acestar');
INSERT INTO "server_groups" VALUES (14,'Action-IRC');
INSERT INTO "server_groups" VALUES (15,'Afternet');
INSERT INTO "server_groups" VALUES (16,'Alternativenet');
INSERT INTO "server_groups" VALUES (17,'Animenet');
INSERT INTO "server_groups" VALUES (18,'ArabChat');
INSERT INTO "server_groups" VALUES (19,'Asixnet');
INSERT INTO "server_groups" VALUES (20,'AstroLink');
INSERT INTO "server_groups" VALUES (21,'Asylumnet');
INSERT INTO "server_groups" VALUES (22,'Austnet');
INSERT INTO "server_groups" VALUES (23,'AwesomeChat');
INSERT INTO "server_groups" VALUES (24,'BeyondIRC');
INSERT INTO "server_groups" VALUES (25,'Blabbernet');
INSERT INTO "server_groups" VALUES (26,'Bohemians');
INSERT INTO "server_groups" VALUES (27,'Brasirc');
INSERT INTO "server_groups" VALUES (28,'Brasnet');
INSERT INTO "server_groups" VALUES (29,'Bunker7');
INSERT INTO "server_groups" VALUES (30,'Castlenet-irc');
INSERT INTO "server_groups" VALUES (31,'CCnet');
INSERT INTO "server_groups" VALUES (32,'ChatArea');
INSERT INTO "server_groups" VALUES (33,'Chatcafe');
INSERT INTO "server_groups" VALUES (34,'ChatCentral2');
INSERT INTO "server_groups" VALUES (35,'ChatCircuit');
INSERT INTO "server_groups" VALUES (36,'ChatCity');
INSERT INTO "server_groups" VALUES (37,'Chatlink');
INSERT INTO "server_groups" VALUES (38,'Chatnet');
INSERT INTO "server_groups" VALUES (39,'Chatpinoy');
INSERT INTO "server_groups" VALUES (40,'ChatPR');
INSERT INTO "server_groups" VALUES (41,'Chatroom');
INSERT INTO "server_groups" VALUES (42,'ChatX');
INSERT INTO "server_groups" VALUES (43,'Circanet');
INSERT INTO "server_groups" VALUES (44,'CNN');
INSERT INTO "server_groups" VALUES (45,'Coolchat');
INSERT INTO "server_groups" VALUES (46,'Criten');
INSERT INTO "server_groups" VALUES (47,'Cyberchat');
INSERT INTO "server_groups" VALUES (48,'Cyberchat-irc');
INSERT INTO "server_groups" VALUES (49,'CyGanet');
INSERT INTO "server_groups" VALUES (50,'DALnet');
INSERT INTO "server_groups" VALUES (51,'Darkernet');
INSERT INTO "server_groups" VALUES (52,'Darkfire');
INSERT INTO "server_groups" VALUES (53,'Darkfyre');
INSERT INTO "server_groups" VALUES (54,'Darkliar');
INSERT INTO "server_groups" VALUES (55,'DarkMyst');
INSERT INTO "server_groups" VALUES (56,'Darktree');
INSERT INTO "server_groups" VALUES (57,'Deepspace');
INSERT INTO "server_groups" VALUES (58,'Dezynched');
INSERT INTO "server_groups" VALUES (59,'Different');
INSERT INTO "server_groups" VALUES (60,'Digarix');
INSERT INTO "server_groups" VALUES (61,'Digitalirc');
INSERT INTO "server_groups" VALUES (62,'Dobbernet');
INSERT INTO "server_groups" VALUES (63,'Dreamnet');
INSERT INTO "server_groups" VALUES (64,'Duh-net');
INSERT INTO "server_groups" VALUES (65,'Dynastynet');
INSERT INTO "server_groups" VALUES (66,'EFnet');
INSERT INTO "server_groups" VALUES (67,'EgyptianIRC');
INSERT INTO "server_groups" VALUES (68,'EliteOrbit');
INSERT INTO "server_groups" VALUES (69,'EntertheGame');
INSERT INTO "server_groups" VALUES (70,'Esprit');
INSERT INTO "server_groups" VALUES (71,'euIRC');
INSERT INTO "server_groups" VALUES (72,'Exedor');
INSERT INTO "server_groups" VALUES (73,'ExodusIRC');
INSERT INTO "server_groups" VALUES (74,'Fancynet');
INSERT INTO "server_groups" VALUES (75,'FDFnet');
INSERT INTO "server_groups" VALUES (76,'FEFnet');
INSERT INTO "server_groups" VALUES (77,'FireChat');
INSERT INTO "server_groups" VALUES (78,'Forestnet');
INSERT INTO "server_groups" VALUES (79,'FreedomChat');
INSERT INTO "server_groups" VALUES (80,'Fuelienet');
INSERT INTO "server_groups" VALUES (81,'FunNet');
INSERT INTO "server_groups" VALUES (82,'Galaxynet');
INSERT INTO "server_groups" VALUES (83,'Gamesnet');
INSERT INTO "server_groups" VALUES (84,'Gammaforce');
INSERT INTO "server_groups" VALUES (85,'Ghostnet');
INSERT INTO "server_groups" VALUES (86,'GizNet');
INSERT INTO "server_groups" VALUES (87,'Global-irc');
INSERT INTO "server_groups" VALUES (88,'Globalchat');
INSERT INTO "server_groups" VALUES (89,'Go2Chat');
INSERT INTO "server_groups" VALUES (90,'Grnet');
INSERT INTO "server_groups" VALUES (91,'Hellenicnet');
INSERT INTO "server_groups" VALUES (92,'Hugsnet');
INSERT INTO "server_groups" VALUES (93,'Hybnet');
INSERT INTO "server_groups" VALUES (94,'iChatZone');
INSERT INTO "server_groups" VALUES (95,'ICQnet');
INSERT INTO "server_groups" VALUES (96,'Infatech');
INSERT INTO "server_groups" VALUES (97,'Infinity');
INSERT INTO "server_groups" VALUES (98,'Insiderz');
INSERT INTO "server_groups" VALUES (99,'IRC-Hispano');
INSERT INTO "server_groups" VALUES (100,'IRChat');
INSERT INTO "server_groups" VALUES (101,'IRChat-br');
INSERT INTO "server_groups" VALUES (102,'IRCLink');
INSERT INTO "server_groups" VALUES (103,'IRCnet');
INSERT INTO "server_groups" VALUES (104,'IRCStorm');
INSERT INTO "server_groups" VALUES (105,'Israelnet');
INSERT INTO "server_groups" VALUES (106,'K0wNet');
INSERT INTO "server_groups" VALUES (107,'Kewl.org');
INSERT INTO "server_groups" VALUES (108,'Kidsworld');
INSERT INTO "server_groups" VALUES (109,'KissLand');
INSERT INTO "server_groups" VALUES (110,'Knightnet');
INSERT INTO "server_groups" VALUES (111,'KreyNet');
INSERT INTO "server_groups" VALUES (112,'Krushnet');
INSERT INTO "server_groups" VALUES (113,'Lagnet');
INSERT INTO "server_groups" VALUES (114,'Librenet');
INSERT INTO "server_groups" VALUES (115,'Lunatics');
INSERT INTO "server_groups" VALUES (116,'MagicStar');
INSERT INTO "server_groups" VALUES (117,'MavraNet');
INSERT INTO "server_groups" VALUES (118,'Mellorien');
INSERT INTO "server_groups" VALUES (119,'Messique');
INSERT INTO "server_groups" VALUES (120,'Microsoft Network');
INSERT INTO "server_groups" VALUES (121,'Millenia');
INSERT INTO "server_groups" VALUES (122,'mIRCnet');
INSERT INTO "server_groups" VALUES (123,'Mozilla');
INSERT INTO "server_groups" VALUES (124,'Muhabbet');
INSERT INTO "server_groups" VALUES (125,'Mysteria');
INSERT INTO "server_groups" VALUES (126,'Mystical');
INSERT INTO "server_groups" VALUES (127,'NDRSnet');
INSERT INTO "server_groups" VALUES (128,'Nebulanet');
INSERT INTO "server_groups" VALUES (129,'Net-France');
INSERT INTO "server_groups" VALUES (130,'Nevernet');
INSERT INTO "server_groups" VALUES (131,'Newnet');
INSERT INTO "server_groups" VALUES (132,'Nightstar');
INSERT INTO "server_groups" VALUES (133,'Novernet');
INSERT INTO "server_groups" VALUES (134,'OpenMind');
INSERT INTO "server_groups" VALUES (135,'Othernet');
INSERT INTO "server_groups" VALUES (136,'Otherside');
INSERT INTO "server_groups" VALUES (137,'Outsiderz');
INSERT INTO "server_groups" VALUES (138,'OzChat');
INSERT INTO "server_groups" VALUES (139,'OzOrg');
INSERT INTO "server_groups" VALUES (140,'OzTic');
INSERT INTO "server_groups" VALUES (141,'Phishynet');
INSERT INTO "server_groups" VALUES (142,'Pinoycentral');
INSERT INTO "server_groups" VALUES (143,'Planetarion');
INSERT INTO "server_groups" VALUES (144,'PowerChat');
INSERT INTO "server_groups" VALUES (145,'Pseudonet');
INSERT INTO "server_groups" VALUES (146,'PTlink');
INSERT INTO "server_groups" VALUES (147,'PTnet');
INSERT INTO "server_groups" VALUES (148,'QChat');
INSERT INTO "server_groups" VALUES (149,'QuakeNet');
INSERT INTO "server_groups" VALUES (150,'Raptanet');
INSERT INTO "server_groups" VALUES (151,'Raptornet');
INSERT INTO "server_groups" VALUES (152,'Red-Latina');
INSERT INTO "server_groups" VALUES (153,'RedeBrasil');
INSERT INTO "server_groups" VALUES (154,'RedeSul');
INSERT INTO "server_groups" VALUES (155,'RedLatona');
INSERT INTO "server_groups" VALUES (156,'RekorNet');
INSERT INTO "server_groups" VALUES (157,'Relicnet');
INSERT INTO "server_groups" VALUES (158,'Risanet');
INSERT INTO "server_groups" VALUES (159,'Rusnet');
INSERT INTO "server_groups" VALUES (160,'SamShark');
INSERT INTO "server_groups" VALUES (161,'Sandnet');
INSERT INTO "server_groups" VALUES (162,'Seveneagle');
INSERT INTO "server_groups" VALUES (163,'SexNet');
INSERT INTO "server_groups" VALUES (164,'SgNet');
INSERT INTO "server_groups" VALUES (165,'ShadowFire');
INSERT INTO "server_groups" VALUES (166,'ShadowWorld');
INSERT INTO "server_groups" VALUES (167,'SideNet');
INSERT INTO "server_groups" VALUES (168,'Skyyenet');
INSERT INTO "server_groups" VALUES (169,'Slashnet');
INSERT INTO "server_groups" VALUES (170,'Solarchat');
INSERT INTO "server_groups" VALUES (171,'Sorcerynet');
INSERT INTO "server_groups" VALUES (172,'Spamnet');
INSERT INTO "server_groups" VALUES (173,'StarChat');
INSERT INTO "server_groups" VALUES (174,'StarLink-irc');
INSERT INTO "server_groups" VALUES (175,'StarLink Org');
INSERT INTO "server_groups" VALUES (176,'Stormdancing');
INSERT INTO "server_groups" VALUES (177,'Styliso');
INSERT INTO "server_groups" VALUES (178,'Sub-city');
INSERT INTO "server_groups" VALUES (179,'Superchat');
INSERT INTO "server_groups" VALUES (180,'Superonline');
INSERT INTO "server_groups" VALUES (181,'Sysopnet');
INSERT INTO "server_groups" VALUES (182,'Techdreams');
INSERT INTO "server_groups" VALUES (183,'Telstra');
INSERT INTO "server_groups" VALUES (184,'Terra-ES');
INSERT INTO "server_groups" VALUES (185,'Thunderirc');
INSERT INTO "server_groups" VALUES (186,'TR-net');
INSERT INTO "server_groups" VALUES (187,'TRcom');
INSERT INTO "server_groups" VALUES (188,'Treklink');
INSERT INTO "server_groups" VALUES (189,'Undernet');
INSERT INTO "server_groups" VALUES (190,'UnderZ');
INSERT INTO "server_groups" VALUES (191,'Undienet');
INSERT INTO "server_groups" VALUES (192,'Unfnet');
INSERT INTO "server_groups" VALUES (193,'UnionLatina');
INSERT INTO "server_groups" VALUES (194,'UnitedChat Net');
INSERT INTO "server_groups" VALUES (195,'UnitedChat Org');
INSERT INTO "server_groups" VALUES (196,'Univers');
INSERT INTO "server_groups" VALUES (197,'VenomXnet');
INSERT INTO "server_groups" VALUES (198,'Vidgamechat');
INSERT INTO "server_groups" VALUES (199,'Vitamina');
INSERT INTO "server_groups" VALUES (200,'VortexIRC');
INSERT INTO "server_groups" VALUES (201,'Wanas');
INSERT INTO "server_groups" VALUES (202,'Warpednet');
INSERT INTO "server_groups" VALUES (203,'Webnet');
INSERT INTO "server_groups" VALUES (204,'WonKnet');
INSERT INTO "server_groups" VALUES (205,'Woot');
INSERT INTO "server_groups" VALUES (206,'WorldIRC');
INSERT INTO "server_groups" VALUES (207,'Xevion');
INSERT INTO "server_groups" VALUES (208,'Xnet');
INSERT INTO "server_groups" VALUES (209,'XWorld');
INSERT INTO "server_groups" VALUES (210,'ZAnet Net');
INSERT INTO "server_groups" VALUES (211,'ZAnet Org');
INSERT INTO "server_groups" VALUES (212,'Zerolimit');
INSERT INTO "server_groups" VALUES (213,'ZiRC');
INSERT INTO "server_groups" VALUES (214,'ZUHnet');
INSERT INTO "server_groups" VALUES (215,'Zurna');
INSERT INTO "server_groups" VALUES (216,'');

--
-- Table structure for table 'servers'
--



--
-- Sequences for table SERVERS
--

CREATE SEQUENCE servers_servers_id_seq;

CREATE TABLE "servers" (
  "servers_id" INT4 DEFAULT nextval('servers_servers_id_seq'),
  "server_group_id" INT4 NOT NULL DEFAULT '0',
  "server_name" varchar(255) NOT NULL DEFAULT '',
  "port" INT4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("servers_id")

);

--
-- Dumping data for table 'servers'
--

INSERT INTO "servers" VALUES (1,1,'irc.dal.net',6660);
INSERT INTO "servers" VALUES (2,1,'irc.dal.net',6661);
INSERT INTO "servers" VALUES (3,1,'irc.dal.net',6662);
INSERT INTO "servers" VALUES (4,1,'irc.dal.net',6663);
INSERT INTO "servers" VALUES (5,1,'irc.dal.net',6664);
INSERT INTO "servers" VALUES (6,1,'irc.dal.net',6665);
INSERT INTO "servers" VALUES (7,1,'irc.dal.net',6666);
INSERT INTO "servers" VALUES (8,1,'irc.dal.net',6667);
INSERT INTO "servers" VALUES (9,2,'irc.eu.dal.net',6667);
INSERT INTO "servers" VALUES (10,3,'us.rr.efnet.net',6667);
INSERT INTO "servers" VALUES (11,4,'eu.rr.efnet.net',6667);
INSERT INTO "servers" VALUES (12,5,'ca.rr.efnet.net',6667);
INSERT INTO "servers" VALUES (13,6,'au.rr.efnet.net',6667);
INSERT INTO "servers" VALUES (14,7,'us.ircnet.org',6665);
INSERT INTO "servers" VALUES (15,7,'us.ircnet.org',6666);
INSERT INTO "servers" VALUES (16,7,'us.ircnet.org',6667);
INSERT INTO "servers" VALUES (17,7,'us.ircnet.org',6668);
INSERT INTO "servers" VALUES (18,8,'eu.ircnet.org',6665);
INSERT INTO "servers" VALUES (19,8,'eu.ircnet.org',6666);
INSERT INTO "servers" VALUES (20,8,'eu.ircnet.org',6667);
INSERT INTO "servers" VALUES (21,8,'eu.ircnet.org',6668);
INSERT INTO "servers" VALUES (22,9,'au.ircnet.org',6667);
INSERT INTO "servers" VALUES (23,10,'us.undernet.org',6667);
INSERT INTO "servers" VALUES (24,11,'eu.undernet.org',6667);
INSERT INTO "servers" VALUES (25,12,'irc.accessirc.net',6667);
INSERT INTO "servers" VALUES (26,13,'irc.acestar.org',6667);
INSERT INTO "servers" VALUES (27,14,'irc.action-irc.net',6660);
INSERT INTO "servers" VALUES (28,14,'irc.action-irc.net',6661);
INSERT INTO "servers" VALUES (29,14,'irc.action-irc.net',6662);
INSERT INTO "servers" VALUES (30,14,'irc.action-irc.net',6663);
INSERT INTO "servers" VALUES (31,14,'irc.action-irc.net',6664);
INSERT INTO "servers" VALUES (32,14,'irc.action-irc.net',6665);
INSERT INTO "servers" VALUES (33,14,'irc.action-irc.net',6666);
INSERT INTO "servers" VALUES (34,14,'irc.action-irc.net',6667);
INSERT INTO "servers" VALUES (35,14,'irc.action-irc.net',6668);
INSERT INTO "servers" VALUES (36,14,'irc.action-irc.net',6669);
INSERT INTO "servers" VALUES (37,15,'irc.afternet.org',6667);
INSERT INTO "servers" VALUES (38,16,'irc.altnet.org',6667);
INSERT INTO "servers" VALUES (39,17,'irc.animenet.org',6660);
INSERT INTO "servers" VALUES (40,17,'irc.animenet.org',6661);
INSERT INTO "servers" VALUES (41,17,'irc.animenet.org',6662);
INSERT INTO "servers" VALUES (42,17,'irc.animenet.org',6663);
INSERT INTO "servers" VALUES (43,17,'irc.animenet.org',6664);
INSERT INTO "servers" VALUES (44,17,'irc.animenet.org',6665);
INSERT INTO "servers" VALUES (45,17,'irc.animenet.org',6666);
INSERT INTO "servers" VALUES (46,17,'irc.animenet.org',6667);
INSERT INTO "servers" VALUES (47,17,'irc.animenet.org',6668);
INSERT INTO "servers" VALUES (48,17,'irc.animenet.org',6669);
INSERT INTO "servers" VALUES (49,18,'irc.arabchat.org',6660);
INSERT INTO "servers" VALUES (50,18,'irc.arabchat.org',6661);
INSERT INTO "servers" VALUES (51,18,'irc.arabchat.org',6662);
INSERT INTO "servers" VALUES (52,18,'irc.arabchat.org',6663);
INSERT INTO "servers" VALUES (53,18,'irc.arabchat.org',6664);
INSERT INTO "servers" VALUES (54,18,'irc.arabchat.org',6665);
INSERT INTO "servers" VALUES (55,18,'irc.arabchat.org',6666);
INSERT INTO "servers" VALUES (56,18,'irc.arabchat.org',6667);
INSERT INTO "servers" VALUES (57,19,'irc.asixnet.org',6667);
INSERT INTO "servers" VALUES (58,20,'irc.astrolink.org',6660);
INSERT INTO "servers" VALUES (59,20,'irc.astrolink.org',6661);
INSERT INTO "servers" VALUES (60,20,'irc.astrolink.org',6662);
INSERT INTO "servers" VALUES (61,20,'irc.astrolink.org',6663);
INSERT INTO "servers" VALUES (62,20,'irc.astrolink.org',6664);
INSERT INTO "servers" VALUES (63,20,'irc.astrolink.org',6665);
INSERT INTO "servers" VALUES (64,20,'irc.astrolink.org',6666);
INSERT INTO "servers" VALUES (65,20,'irc.astrolink.org',6667);
INSERT INTO "servers" VALUES (66,21,'irc.asylum-net.org',6661);
INSERT INTO "servers" VALUES (67,21,'irc.asylum-net.org',6662);
INSERT INTO "servers" VALUES (68,21,'irc.asylum-net.org',6663);
INSERT INTO "servers" VALUES (69,21,'irc.asylum-net.org',6664);
INSERT INTO "servers" VALUES (70,21,'irc.asylum-net.org',6665);
INSERT INTO "servers" VALUES (71,21,'irc.asylum-net.org',6666);
INSERT INTO "servers" VALUES (72,21,'irc.asylum-net.org',6667);
INSERT INTO "servers" VALUES (73,21,'irc.asylum-net.org',6668);
INSERT INTO "servers" VALUES (74,21,'irc.asylum-net.org',6669);
INSERT INTO "servers" VALUES (75,22,'au.austnet.org',6667);
INSERT INTO "servers" VALUES (76,22,'nz.austnet.org',6667);
INSERT INTO "servers" VALUES (77,22,'sg.austnet.org',6667);
INSERT INTO "servers" VALUES (78,22,'us.austnet.org',6667);
INSERT INTO "servers" VALUES (79,23,'irc.awesomechat.net',6661);
INSERT INTO "servers" VALUES (80,23,'irc.awesomechat.net',6662);
INSERT INTO "servers" VALUES (81,23,'irc.awesomechat.net',6663);
INSERT INTO "servers" VALUES (82,23,'irc.awesomechat.net',6664);
INSERT INTO "servers" VALUES (83,23,'irc.awesomechat.net',6665);
INSERT INTO "servers" VALUES (84,23,'irc.awesomechat.net',6666);
INSERT INTO "servers" VALUES (85,23,'irc.awesomechat.net',6667);
INSERT INTO "servers" VALUES (86,23,'irc.awesomechat.net',6668);
INSERT INTO "servers" VALUES (87,23,'irc.awesomechat.net',6669);
INSERT INTO "servers" VALUES (88,24,'irc.beyondirc.net',6660);
INSERT INTO "servers" VALUES (89,24,'irc.beyondirc.net',6661);
INSERT INTO "servers" VALUES (90,24,'irc.beyondirc.net',6662);
INSERT INTO "servers" VALUES (91,24,'irc.beyondirc.net',6663);
INSERT INTO "servers" VALUES (92,24,'irc.beyondirc.net',6664);
INSERT INTO "servers" VALUES (93,24,'irc.beyondirc.net',6665);
INSERT INTO "servers" VALUES (94,24,'irc.beyondirc.net',6666);
INSERT INTO "servers" VALUES (95,24,'irc.beyondirc.net',6667);
INSERT INTO "servers" VALUES (96,24,'irc.beyondirc.net',6668);
INSERT INTO "servers" VALUES (97,24,'irc.beyondirc.net',6669);
INSERT INTO "servers" VALUES (98,25,'irc.blabber.net',6667);
INSERT INTO "servers" VALUES (99,25,'irc.blabber.net',7000);
INSERT INTO "servers" VALUES (100,26,'irc.bohemians.org',6667);
INSERT INTO "servers" VALUES (101,26,'irc.bohemians.org',7000);
INSERT INTO "servers" VALUES (102,27,'irc.brasirc.net',6666);
INSERT INTO "servers" VALUES (103,27,'irc.brasirc.net',6667);
INSERT INTO "servers" VALUES (104,27,'irc.libnet.com.br',6666);
INSERT INTO "servers" VALUES (105,27,'irc.libnet.com.br',6667);
INSERT INTO "servers" VALUES (106,27,'irc.libnet.com.br',6668);
INSERT INTO "servers" VALUES (107,27,'irc.intergate.com.br',6667);
INSERT INTO "servers" VALUES (108,28,'eu.brasnet.org',6665);
INSERT INTO "servers" VALUES (109,28,'eu.brasnet.org',6666);
INSERT INTO "servers" VALUES (110,28,'eu.brasnet.org',6667);
INSERT INTO "servers" VALUES (111,28,'eu.brasnet.org',6668);
INSERT INTO "servers" VALUES (112,28,'eu.brasnet.org',6669);
INSERT INTO "servers" VALUES (113,28,'irc.brasnet.org',6665);
INSERT INTO "servers" VALUES (114,28,'irc.brasnet.org',6666);
INSERT INTO "servers" VALUES (115,28,'irc.brasnet.org',6667);
INSERT INTO "servers" VALUES (116,28,'irc.brasnet.org',6668);
INSERT INTO "servers" VALUES (117,28,'irc.brasnet.org',6669);
INSERT INTO "servers" VALUES (118,28,'us.brasnet.org',6665);
INSERT INTO "servers" VALUES (119,28,'us.brasnet.org',6666);
INSERT INTO "servers" VALUES (120,28,'us.brasnet.org',6667);
INSERT INTO "servers" VALUES (121,28,'us.brasnet.org',6668);
INSERT INTO "servers" VALUES (122,28,'us.brasnet.org',6669);
INSERT INTO "servers" VALUES (123,29,'irc.bunker7.net',6667);
INSERT INTO "servers" VALUES (124,30,'irc.castlenet-irc.org',6667);
INSERT INTO "servers" VALUES (125,30,'stormcenter.ca.castlenet-irc.org',6667);
INSERT INTO "servers" VALUES (126,30,'cowboy.ok.castlenet-irc.org',6667);
INSERT INTO "servers" VALUES (127,31,'irc.cchat.net',6667);
INSERT INTO "servers" VALUES (128,31,'irc.cchat.net',7000);
INSERT INTO "servers" VALUES (129,31,'irc2.cchat.net',6667);
INSERT INTO "servers" VALUES (130,31,'irc2.cchat.net',7000);
INSERT INTO "servers" VALUES (131,32,'irc.chatarea.net',6667);
INSERT INTO "servers" VALUES (132,33,'irc.chatcafe.net',6667);
INSERT INTO "servers" VALUES (133,34,'irc.cc2.org',6665);
INSERT INTO "servers" VALUES (134,34,'irc.cc2.org',6666);
INSERT INTO "servers" VALUES (135,34,'irc.cc2.org',6667);
INSERT INTO "servers" VALUES (136,34,'irc.cc2.org',6668);
INSERT INTO "servers" VALUES (137,34,'irc.cc2.org',6669);
INSERT INTO "servers" VALUES (138,35,'irc.chatcircuit.com',6667);
INSERT INTO "servers" VALUES (139,36,'irc.chatcity.org',6667);
INSERT INTO "servers" VALUES (140,36,'irc.chatcity.org',6668);
INSERT INTO "servers" VALUES (141,36,'irc.chatcity.org',6669);
INSERT INTO "servers" VALUES (142,37,'irc.chatlink.org',6667);
INSERT INTO "servers" VALUES (143,37,'cool.ca.us.chatlink.org',6667);
INSERT INTO "servers" VALUES (144,37,'dream.oh.us.chatlink.org',6667);
INSERT INTO "servers" VALUES (145,38,'au.chatnet.org',6667);
INSERT INTO "servers" VALUES (146,38,'eu.chatnet.org',6667);
INSERT INTO "servers" VALUES (147,38,'us.chatnet.org',6667);
INSERT INTO "servers" VALUES (148,39,'irc.chatpinoy.com',6667);
INSERT INTO "servers" VALUES (149,40,'irc.chatpr.org',6667);
INSERT INTO "servers" VALUES (150,41,'irc.chatroom.org',6667);
INSERT INTO "servers" VALUES (151,42,'irc.chatx.net',6667);
INSERT INTO "servers" VALUES (152,43,'irc.circanet.org',6660);
INSERT INTO "servers" VALUES (153,43,'irc.circanet.org',6661);
INSERT INTO "servers" VALUES (154,43,'irc.circanet.org',6662);
INSERT INTO "servers" VALUES (155,43,'irc.circanet.org',6663);
INSERT INTO "servers" VALUES (156,43,'irc.circanet.org',6664);
INSERT INTO "servers" VALUES (157,43,'irc.circanet.org',6665);
INSERT INTO "servers" VALUES (158,43,'irc.circanet.org',6666);
INSERT INTO "servers" VALUES (159,43,'irc.circanet.org',6667);
INSERT INTO "servers" VALUES (160,43,'irc.circanet.org',6668);
INSERT INTO "servers" VALUES (161,43,'irc.circanet.org',6669);
INSERT INTO "servers" VALUES (162,44,'chat.cnn.com',6667);
INSERT INTO "servers" VALUES (163,44,'chat.cnn.com',6668);
INSERT INTO "servers" VALUES (164,44,'chat.cnn.com',6669);
INSERT INTO "servers" VALUES (165,45,'irc.coolchat.net',6667);
INSERT INTO "servers" VALUES (166,46,'irc.criten.net',6667);
INSERT INTO "servers" VALUES (167,47,'irc.cyberchat.org',6667);
INSERT INTO "servers" VALUES (168,47,'irc.cyberchat.org',6668);
INSERT INTO "servers" VALUES (169,48,'irc.cyberchat-irc.net',6667);
INSERT INTO "servers" VALUES (170,49,'irc.cyga.net',6667);
INSERT INTO "servers" VALUES (171,50,'coins.dal.net',6663);
INSERT INTO "servers" VALUES (172,50,'coins.dal.net',6664);
INSERT INTO "servers" VALUES (173,50,'coins.dal.net',6665);
INSERT INTO "servers" VALUES (174,50,'coins.dal.net',6666);
INSERT INTO "servers" VALUES (175,50,'coins.dal.net',6667);
INSERT INTO "servers" VALUES (176,50,'coins.dal.net',6668);
INSERT INTO "servers" VALUES (177,50,'ozbytes.dal.net',6667);
INSERT INTO "servers" VALUES (178,50,'ozbytes.dal.net',7000);
INSERT INTO "servers" VALUES (179,50,'vancouver.dal.net',6660);
INSERT INTO "servers" VALUES (180,50,'vancouver.dal.net',6661);
INSERT INTO "servers" VALUES (181,50,'vancouver.dal.net',6662);
INSERT INTO "servers" VALUES (182,50,'vancouver.dal.net',6663);
INSERT INTO "servers" VALUES (183,50,'vancouver.dal.net',6664);
INSERT INTO "servers" VALUES (184,50,'vancouver.dal.net',6665);
INSERT INTO "servers" VALUES (185,50,'vancouver.dal.net',6666);
INSERT INTO "servers" VALUES (186,50,'vancouver.dal.net',6667);
INSERT INTO "servers" VALUES (187,50,'vancouver.dal.net',6668);
INSERT INTO "servers" VALUES (188,50,'vancouver.dal.net',6669);
INSERT INTO "servers" VALUES (189,50,'traced.de.eu.dal.net',6664);
INSERT INTO "servers" VALUES (190,50,'traced.de.eu.dal.net',6665);
INSERT INTO "servers" VALUES (191,50,'traced.de.eu.dal.net',6666);
INSERT INTO "servers" VALUES (192,50,'traced.de.eu.dal.net',6667);
INSERT INTO "servers" VALUES (193,50,'traced.de.eu.dal.net',6668);
INSERT INTO "servers" VALUES (194,50,'traced.de.eu.dal.net',6669);
INSERT INTO "servers" VALUES (195,50,'powertech.no.eu.dal.net',6666);
INSERT INTO "servers" VALUES (196,50,'powertech.no.eu.dal.net',6667);
INSERT INTO "servers" VALUES (197,50,'viking.dal.net',6666);
INSERT INTO "servers" VALUES (198,50,'viking.dal.net',6667);
INSERT INTO "servers" VALUES (199,50,'viking.dal.net',6668);
INSERT INTO "servers" VALUES (200,50,'viking.dal.net',6669);
INSERT INTO "servers" VALUES (201,50,'ced.dal.net',6667);
INSERT INTO "servers" VALUES (202,50,'ced.dal.net',7000);
INSERT INTO "servers" VALUES (203,50,'paranoia.dal.net',6661);
INSERT INTO "servers" VALUES (204,50,'paranoia.dal.net',6662);
INSERT INTO "servers" VALUES (205,50,'paranoia.dal.net',6663);
INSERT INTO "servers" VALUES (206,50,'paranoia.dal.net',6664);
INSERT INTO "servers" VALUES (207,50,'paranoia.dal.net',6665);
INSERT INTO "servers" VALUES (208,50,'paranoia.dal.net',6666);
INSERT INTO "servers" VALUES (209,50,'paranoia.dal.net',6667);
INSERT INTO "servers" VALUES (210,50,'paranoia.dal.net',6668);
INSERT INTO "servers" VALUES (211,50,'paranoia.dal.net',6669);
INSERT INTO "servers" VALUES (212,50,'defiant.dal.net',6666);
INSERT INTO "servers" VALUES (213,50,'defiant.dal.net',6667);
INSERT INTO "servers" VALUES (214,50,'defiant.dal.net',6668);
INSERT INTO "servers" VALUES (215,50,'defiant.dal.net',6669);
INSERT INTO "servers" VALUES (216,50,'defiant.dal.net',7000);
INSERT INTO "servers" VALUES (217,50,'defiant.dal.net',7001);
INSERT INTO "servers" VALUES (218,50,'defiant.dal.net',7002);
INSERT INTO "servers" VALUES (219,50,'sodre.dal.net',6661);
INSERT INTO "servers" VALUES (220,50,'sodre.dal.net',6662);
INSERT INTO "servers" VALUES (221,50,'sodre.dal.net',6663);
INSERT INTO "servers" VALUES (222,50,'sodre.dal.net',6664);
INSERT INTO "servers" VALUES (223,50,'sodre.dal.net',6665);
INSERT INTO "servers" VALUES (224,50,'sodre.dal.net',6666);
INSERT INTO "servers" VALUES (225,50,'sodre.dal.net',6667);
INSERT INTO "servers" VALUES (226,50,'sodre.dal.net',6668);
INSERT INTO "servers" VALUES (227,50,'sodre.dal.net',6669);
INSERT INTO "servers" VALUES (228,50,'hebron.dal.net',6661);
INSERT INTO "servers" VALUES (229,50,'hebron.dal.net',6662);
INSERT INTO "servers" VALUES (230,50,'hebron.dal.net',6663);
INSERT INTO "servers" VALUES (231,50,'hebron.dal.net',6664);
INSERT INTO "servers" VALUES (232,50,'hebron.dal.net',6665);
INSERT INTO "servers" VALUES (233,50,'hebron.dal.net',6666);
INSERT INTO "servers" VALUES (234,50,'hebron.dal.net',6667);
INSERT INTO "servers" VALUES (235,50,'hebron.dal.net',6668);
INSERT INTO "servers" VALUES (236,50,'hebron.dal.net',6669);
INSERT INTO "servers" VALUES (237,50,'qis.md.us.dal.net',6660);
INSERT INTO "servers" VALUES (238,50,'qis.md.us.dal.net',6661);
INSERT INTO "servers" VALUES (239,50,'qis.md.us.dal.net',6662);
INSERT INTO "servers" VALUES (240,50,'qis.md.us.dal.net',6663);
INSERT INTO "servers" VALUES (241,50,'qis.md.us.dal.net',6664);
INSERT INTO "servers" VALUES (242,50,'qis.md.us.dal.net',6665);
INSERT INTO "servers" VALUES (243,50,'qis.md.us.dal.net',6666);
INSERT INTO "servers" VALUES (244,50,'qis.md.us.dal.net',6667);
INSERT INTO "servers" VALUES (245,50,'qis.md.us.dal.net',6668);
INSERT INTO "servers" VALUES (246,50,'qis.md.us.dal.net',6669);
INSERT INTO "servers" VALUES (247,50,'liberty.dal.net',6662);
INSERT INTO "servers" VALUES (248,50,'liberty.dal.net',6663);
INSERT INTO "servers" VALUES (249,50,'liberty.dal.net',6664);
INSERT INTO "servers" VALUES (250,50,'liberty.dal.net',6665);
INSERT INTO "servers" VALUES (251,50,'liberty.dal.net',6666);
INSERT INTO "servers" VALUES (252,50,'liberty.dal.net',6667);
INSERT INTO "servers" VALUES (253,50,'liberty.dal.net',6668);
INSERT INTO "servers" VALUES (254,50,'liberty.dal.net',6669);
INSERT INTO "servers" VALUES (255,50,'glass.dal.net',6660);
INSERT INTO "servers" VALUES (256,50,'glass.dal.net',6661);
INSERT INTO "servers" VALUES (257,50,'glass.dal.net',6662);
INSERT INTO "servers" VALUES (258,50,'glass.dal.net',6663);
INSERT INTO "servers" VALUES (259,50,'glass.dal.net',6664);
INSERT INTO "servers" VALUES (260,50,'glass.dal.net',6665);
INSERT INTO "servers" VALUES (261,50,'glass.dal.net',6666);
INSERT INTO "servers" VALUES (262,50,'glass.dal.net',6667);
INSERT INTO "servers" VALUES (263,50,'webzone.dal.net',6664);
INSERT INTO "servers" VALUES (264,50,'webzone.dal.net',6665);
INSERT INTO "servers" VALUES (265,50,'webzone.dal.net',6666);
INSERT INTO "servers" VALUES (266,50,'webzone.dal.net',6667);
INSERT INTO "servers" VALUES (267,50,'webzone.dal.net',6668);
INSERT INTO "servers" VALUES (268,50,'webzone.dal.net',6669);
INSERT INTO "servers" VALUES (269,51,'irc.darker.net',6667);
INSERT INTO "servers" VALUES (270,52,'irc.darkfire.net',6667);
INSERT INTO "servers" VALUES (271,52,'irc.darkfire.net',7000);
INSERT INTO "servers" VALUES (272,52,'irc.darkfire.net',8000);
INSERT INTO "servers" VALUES (273,53,'irc.darkfyre.net',6667);
INSERT INTO "servers" VALUES (274,54,'irc.darklair.org',6667);
INSERT INTO "servers" VALUES (275,55,'irc.darkmyst.org',6667);
INSERT INTO "servers" VALUES (276,56,'irc.darktree.net',6667);
INSERT INTO "servers" VALUES (277,57,'irc.deepspace.org',6667);
INSERT INTO "servers" VALUES (278,58,'irc.dezynched.net',6665);
INSERT INTO "servers" VALUES (279,58,'irc.dezynched.net',6666);
INSERT INTO "servers" VALUES (280,58,'irc.dezynched.net',6667);
INSERT INTO "servers" VALUES (281,58,'irc.dezynched.net',6668);
INSERT INTO "servers" VALUES (282,58,'irc.dezynched.net',6669);
INSERT INTO "servers" VALUES (283,59,'irc.different.net',6667);
INSERT INTO "servers" VALUES (284,60,'irc.digarix.net',6667);
INSERT INTO "servers" VALUES (285,61,'irc.digitalirc.net',6667);
INSERT INTO "servers" VALUES (286,62,'irc.dobber.net',6667);
INSERT INTO "servers" VALUES (287,63,'eu.dreamnet.org',6664);
INSERT INTO "servers" VALUES (288,63,'eu.dreamnet.org',6665);
INSERT INTO "servers" VALUES (289,63,'eu.dreamnet.org',6666);
INSERT INTO "servers" VALUES (290,63,'irc.dreamnet.org',6664);
INSERT INTO "servers" VALUES (291,63,'irc.dreamnet.org',6665);
INSERT INTO "servers" VALUES (292,63,'irc.dreamnet.org',6666);
INSERT INTO "servers" VALUES (293,63,'us.dreamnet.org',6664);
INSERT INTO "servers" VALUES (294,63,'us.dreamnet.org',6665);
INSERT INTO "servers" VALUES (295,63,'us.dreamnet.org',6666);
INSERT INTO "servers" VALUES (296,64,'rexx.duh-net.org',6667);
INSERT INTO "servers" VALUES (297,64,'murlin.duh-net.org',6667);
INSERT INTO "servers" VALUES (298,64,'wildstar.duh-net.org',6667);
INSERT INTO "servers" VALUES (299,65,'irc.dynastynet.net',6667);
INSERT INTO "servers" VALUES (300,66,'efnet.telstra.net.au',6665);
INSERT INTO "servers" VALUES (301,66,'efnet.telstra.net.au',6666);
INSERT INTO "servers" VALUES (302,66,'efnet.telstra.net.au',6667);
INSERT INTO "servers" VALUES (303,66,'efnet.telstra.net.au',6668);
INSERT INTO "servers" VALUES (304,66,'efnet.telstra.net.au',6669);
INSERT INTO "servers" VALUES (305,66,'irc.powersurfr.com',6667);
INSERT INTO "servers" VALUES (306,66,'irc.fasti.net',6667);
INSERT INTO "servers" VALUES (307,66,'irc.etsmtl.ca',6667);
INSERT INTO "servers" VALUES (308,66,'efnet.cs.hut.fi',6667);
INSERT INTO "servers" VALUES (309,66,'irc.isdnet.fr',6667);
INSERT INTO "servers" VALUES (310,66,'irc.isdnet.fr',6668);
INSERT INTO "servers" VALUES (311,66,'irc.isdnet.fr',6669);
INSERT INTO "servers" VALUES (312,66,'irc.homelien.no',6666);
INSERT INTO "servers" VALUES (313,66,'irc.homelien.no',7000);
INSERT INTO "servers" VALUES (314,66,'irc.homelien.no',7001);
INSERT INTO "servers" VALUES (315,66,'irc.rt.ru',6661);
INSERT INTO "servers" VALUES (316,66,'irc.rt.ru',6662);
INSERT INTO "servers" VALUES (317,66,'irc.rt.ru',6663);
INSERT INTO "servers" VALUES (318,66,'irc.rt.ru',6664);
INSERT INTO "servers" VALUES (319,66,'irc.rt.ru',6665);
INSERT INTO "servers" VALUES (320,66,'irc.rt.ru',6666);
INSERT INTO "servers" VALUES (321,66,'irc.rt.ru',6667);
INSERT INTO "servers" VALUES (322,66,'irc.rt.ru',6668);
INSERT INTO "servers" VALUES (323,66,'irc.rt.ru',6669);
INSERT INTO "servers" VALUES (324,66,'irc.du.se',6666);
INSERT INTO "servers" VALUES (325,66,'irc.du.se',6667);
INSERT INTO "servers" VALUES (326,66,'irc.du.se',6668);
INSERT INTO "servers" VALUES (327,66,'irc.du.se',6669);
INSERT INTO "servers" VALUES (328,66,'efnet.demon.co.uk',6665);
INSERT INTO "servers" VALUES (329,66,'efnet.demon.co.uk',6666);
INSERT INTO "servers" VALUES (330,66,'efnet.demon.co.uk',6667);
INSERT INTO "servers" VALUES (331,66,'efnet.demon.co.uk',6668);
INSERT INTO "servers" VALUES (332,66,'efnet.demon.co.uk',6669);
INSERT INTO "servers" VALUES (333,66,'irc.inter.net.il',6667);
INSERT INTO "servers" VALUES (334,66,'irc2.home.com',6667);
INSERT INTO "servers" VALUES (335,66,'irc.prison.net',6666);
INSERT INTO "servers" VALUES (336,66,'irc.prison.net',6667);
INSERT INTO "servers" VALUES (337,66,'irc.stanford.edu',6667);
INSERT INTO "servers" VALUES (338,66,'irc.colorado.edu',6665);
INSERT INTO "servers" VALUES (339,66,'irc.colorado.edu',6666);
INSERT INTO "servers" VALUES (340,66,'irc.emory.edu',6667);
INSERT INTO "servers" VALUES (341,66,'irc.mindspring.com',6660);
INSERT INTO "servers" VALUES (342,66,'irc.mindspring.com',6661);
INSERT INTO "servers" VALUES (343,66,'irc.mindspring.com',6662);
INSERT INTO "servers" VALUES (344,66,'irc.mindspring.com',6663);
INSERT INTO "servers" VALUES (345,66,'irc.mindspring.com',6664);
INSERT INTO "servers" VALUES (346,66,'irc.mindspring.com',6665);
INSERT INTO "servers" VALUES (347,66,'irc.mindspring.com',6666);
INSERT INTO "servers" VALUES (348,66,'irc.mindspring.com',6667);
INSERT INTO "servers" VALUES (349,66,'irc.mindspring.com',6668);
INSERT INTO "servers" VALUES (350,66,'irc.mindspring.com',6669);
INSERT INTO "servers" VALUES (351,66,'irc.mcs.net',6666);
INSERT INTO "servers" VALUES (352,66,'irc.mcs.net',6667);
INSERT INTO "servers" VALUES (353,66,'irc.mcs.net',6668);
INSERT INTO "servers" VALUES (354,66,'irc.umich.edu',6667);
INSERT INTO "servers" VALUES (355,66,'irc.umn.edu',6665);
INSERT INTO "servers" VALUES (356,66,'irc.umn.edu',6666);
INSERT INTO "servers" VALUES (357,66,'irc.umn.edu',6667);
INSERT INTO "servers" VALUES (358,66,'irc.umn.edu',6668);
INSERT INTO "servers" VALUES (359,66,'irc.umn.edu',6669);
INSERT INTO "servers" VALUES (360,66,'irc.frontiernet.net',6663);
INSERT INTO "servers" VALUES (361,66,'irc.frontiernet.net',6664);
INSERT INTO "servers" VALUES (362,66,'irc.frontiernet.net',6665);
INSERT INTO "servers" VALUES (363,66,'irc.frontiernet.net',6666);
INSERT INTO "servers" VALUES (364,66,'irc.frontiernet.net',6667);
INSERT INTO "servers" VALUES (365,66,'irc.frontiernet.net',6668);
INSERT INTO "servers" VALUES (366,66,'irc.frontiernet.net',6669);
INSERT INTO "servers" VALUES (367,66,'irc.cs.cmu.edu',6666);
INSERT INTO "servers" VALUES (368,66,'irc.cs.cmu.edu',6667);
INSERT INTO "servers" VALUES (369,66,'irc.cs.cmu.edu',6668);
INSERT INTO "servers" VALUES (370,66,'irc.lagged.org',6667);
INSERT INTO "servers" VALUES (371,66,'irc.mpl.net',6667);
INSERT INTO "servers" VALUES (372,67,'irc.egyptianirc.net',6667);
INSERT INTO "servers" VALUES (373,67,'irc.egyptianirc.net',6668);
INSERT INTO "servers" VALUES (374,67,'irc.egyptianirc.net',6669);
INSERT INTO "servers" VALUES (375,68,'irc.eliteorbit.net',6667);
INSERT INTO "servers" VALUES (376,69,'irc.enterthegame.com',6667);
INSERT INTO "servers" VALUES (377,69,'irc.enterthegame.com',6668);
INSERT INTO "servers" VALUES (378,69,'irc.enterthegame.com',6669);
INSERT INTO "servers" VALUES (379,70,'irc.esprit.net',6667);
INSERT INTO "servers" VALUES (380,71,'irc.euirc.net',6665);
INSERT INTO "servers" VALUES (381,71,'irc.euirc.net',6666);
INSERT INTO "servers" VALUES (382,71,'irc.euirc.net',6667);
INSERT INTO "servers" VALUES (383,71,'irc.euirc.net',6668);
INSERT INTO "servers" VALUES (384,71,'irc.euirc.net',6669);
INSERT INTO "servers" VALUES (385,72,'irc.exedor.net',6660);
INSERT INTO "servers" VALUES (386,72,'irc.exedor.net',6661);
INSERT INTO "servers" VALUES (387,72,'irc.exedor.net',6662);
INSERT INTO "servers" VALUES (388,72,'irc.exedor.net',6663);
INSERT INTO "servers" VALUES (389,72,'irc.exedor.net',6664);
INSERT INTO "servers" VALUES (390,72,'irc.exedor.net',6665);
INSERT INTO "servers" VALUES (391,72,'irc.exedor.net',6666);
INSERT INTO "servers" VALUES (392,72,'irc.exedor.net',6667);
INSERT INTO "servers" VALUES (393,73,'irc.exodusirc.net',6660);
INSERT INTO "servers" VALUES (394,73,'irc.exodusirc.net',6661);
INSERT INTO "servers" VALUES (395,73,'irc.exodusirc.net',6662);
INSERT INTO "servers" VALUES (396,73,'irc.exodusirc.net',6663);
INSERT INTO "servers" VALUES (397,73,'irc.exodusirc.net',6664);
INSERT INTO "servers" VALUES (398,73,'irc.exodusirc.net',6665);
INSERT INTO "servers" VALUES (399,73,'irc.exodusirc.net',6666);
INSERT INTO "servers" VALUES (400,73,'irc.exodusirc.net',6667);
INSERT INTO "servers" VALUES (401,73,'irc.exodusirc.net',6668);
INSERT INTO "servers" VALUES (402,73,'irc.exodusirc.net',6669);
INSERT INTO "servers" VALUES (403,74,'irc.fancynet.com',6660);
INSERT INTO "servers" VALUES (404,74,'irc.fancynet.com',6661);
INSERT INTO "servers" VALUES (405,74,'irc.fancynet.com',6662);
INSERT INTO "servers" VALUES (406,74,'irc.fancynet.com',6663);
INSERT INTO "servers" VALUES (407,74,'irc.fancynet.com',6664);
INSERT INTO "servers" VALUES (408,74,'irc.fancynet.com',6665);
INSERT INTO "servers" VALUES (409,74,'irc.fancynet.com',6666);
INSERT INTO "servers" VALUES (410,74,'irc.fancynet.com',6667);
INSERT INTO "servers" VALUES (411,74,'irc.fancynet.com',6668);
INSERT INTO "servers" VALUES (412,74,'irc.fancynet.com',6669);
INSERT INTO "servers" VALUES (413,75,'where.fdf.net',6667);
INSERT INTO "servers" VALUES (414,75,'irc.transbay.net',6666);
INSERT INTO "servers" VALUES (415,75,'irc.transbay.net',6667);
INSERT INTO "servers" VALUES (416,75,'irc.transbay.net',6668);
INSERT INTO "servers" VALUES (417,75,'data.fdf.net',6667);
INSERT INTO "servers" VALUES (418,75,'irc.iceworld.org',6666);
INSERT INTO "servers" VALUES (419,75,'irc.iceworld.org',6667);
INSERT INTO "servers" VALUES (420,75,'irc.iceworld.org',6668);
INSERT INTO "servers" VALUES (421,76,'irc.fef.net',6667);
INSERT INTO "servers" VALUES (422,76,'vendetta.fef.net',6666);
INSERT INTO "servers" VALUES (423,76,'vendetta.fef.net',8888);
INSERT INTO "servers" VALUES (424,76,'vendetta.fef.net',9999);
INSERT INTO "servers" VALUES (425,76,'liii.fef.net',8888);
INSERT INTO "servers" VALUES (426,76,'liii.fef.net',9999);
INSERT INTO "servers" VALUES (427,77,'irc.firechat.org',6667);
INSERT INTO "servers" VALUES (428,78,'irc.forestnet.org',6667);
INSERT INTO "servers" VALUES (429,78,'irc.forestnet.org',7000);
INSERT INTO "servers" VALUES (430,79,'chat.freedomchat.net',6667);
INSERT INTO "servers" VALUES (431,80,'irc.fuelie.net',6667);
INSERT INTO "servers" VALUES (432,80,'irc.fuelie.net',7000);
INSERT INTO "servers" VALUES (433,81,'irc.funnet.org',6667);
INSERT INTO "servers" VALUES (434,82,'irc.galaxynet.org',6662);
INSERT INTO "servers" VALUES (435,82,'irc.galaxynet.org',6663);
INSERT INTO "servers" VALUES (436,82,'irc.galaxynet.org',6664);
INSERT INTO "servers" VALUES (437,82,'irc.galaxynet.org',6665);
INSERT INTO "servers" VALUES (438,82,'irc.galaxynet.org',6666);
INSERT INTO "servers" VALUES (439,82,'irc.galaxynet.org',6667);
INSERT INTO "servers" VALUES (440,82,'irc.galaxynet.org',6668);
INSERT INTO "servers" VALUES (441,82,'auckland.nz.galaxynet.org',6661);
INSERT INTO "servers" VALUES (442,82,'auckland.nz.galaxynet.org',6662);
INSERT INTO "servers" VALUES (443,82,'auckland.nz.galaxynet.org',6663);
INSERT INTO "servers" VALUES (444,82,'auckland.nz.galaxynet.org',6664);
INSERT INTO "servers" VALUES (445,82,'auckland.nz.galaxynet.org',6665);
INSERT INTO "servers" VALUES (446,82,'auckland.nz.galaxynet.org',6666);
INSERT INTO "servers" VALUES (447,82,'auckland.nz.galaxynet.org',6667);
INSERT INTO "servers" VALUES (448,82,'auckland.nz.galaxynet.org',6668);
INSERT INTO "servers" VALUES (449,82,'auckland.nz.galaxynet.org',6669);
INSERT INTO "servers" VALUES (450,82,'online.be.galaxynet.org',6661);
INSERT INTO "servers" VALUES (451,82,'online.be.galaxynet.org',6662);
INSERT INTO "servers" VALUES (452,82,'online.be.galaxynet.org',6663);
INSERT INTO "servers" VALUES (453,82,'online.be.galaxynet.org',6664);
INSERT INTO "servers" VALUES (454,82,'online.be.galaxynet.org',6665);
INSERT INTO "servers" VALUES (455,82,'online.be.galaxynet.org',6666);
INSERT INTO "servers" VALUES (456,82,'online.be.galaxynet.org',6667);
INSERT INTO "servers" VALUES (457,82,'online.be.galaxynet.org',6668);
INSERT INTO "servers" VALUES (458,82,'online.be.galaxynet.org',6669);
INSERT INTO "servers" VALUES (459,82,'vltmedia.se.galaxynet.org',6661);
INSERT INTO "servers" VALUES (460,82,'vltmedia.se.galaxynet.org',6662);
INSERT INTO "servers" VALUES (461,82,'vltmedia.se.galaxynet.org',6663);
INSERT INTO "servers" VALUES (462,82,'vltmedia.se.galaxynet.org',6664);
INSERT INTO "servers" VALUES (463,82,'vltmedia.se.galaxynet.org',6665);
INSERT INTO "servers" VALUES (464,82,'vltmedia.se.galaxynet.org',6666);
INSERT INTO "servers" VALUES (465,82,'vltmedia.se.galaxynet.org',6667);
INSERT INTO "servers" VALUES (466,82,'vltmedia.se.galaxynet.org',6668);
INSERT INTO "servers" VALUES (467,82,'vltmedia.se.galaxynet.org',6669);
INSERT INTO "servers" VALUES (468,82,'gymnet.us.galaxynet.org',6661);
INSERT INTO "servers" VALUES (469,82,'gymnet.us.galaxynet.org',6662);
INSERT INTO "servers" VALUES (470,82,'gymnet.us.galaxynet.org',6663);
INSERT INTO "servers" VALUES (471,82,'gymnet.us.galaxynet.org',6664);
INSERT INTO "servers" VALUES (472,82,'gymnet.us.galaxynet.org',6665);
INSERT INTO "servers" VALUES (473,82,'gymnet.us.galaxynet.org',6666);
INSERT INTO "servers" VALUES (474,82,'gymnet.us.galaxynet.org',6667);
INSERT INTO "servers" VALUES (475,82,'gymnet.us.galaxynet.org',6668);
INSERT INTO "servers" VALUES (476,82,'gymnet.us.galaxynet.org',6669);
INSERT INTO "servers" VALUES (477,82,'freei.us.galaxynet.org',6661);
INSERT INTO "servers" VALUES (478,82,'freei.us.galaxynet.org',6662);
INSERT INTO "servers" VALUES (479,82,'freei.us.galaxynet.org',6663);
INSERT INTO "servers" VALUES (480,82,'freei.us.galaxynet.org',6664);
INSERT INTO "servers" VALUES (481,82,'freei.us.galaxynet.org',6665);
INSERT INTO "servers" VALUES (482,82,'freei.us.galaxynet.org',6666);
INSERT INTO "servers" VALUES (483,82,'freei.us.galaxynet.org',6667);
INSERT INTO "servers" VALUES (484,82,'freei.us.galaxynet.org',6668);
INSERT INTO "servers" VALUES (485,82,'freei.us.galaxynet.org',6669);
INSERT INTO "servers" VALUES (486,83,'east.gamesnet.net',6667);
INSERT INTO "servers" VALUES (487,83,'west.gamesnet.net',6667);
INSERT INTO "servers" VALUES (488,84,'irc.gammaforce.org',6660);
INSERT INTO "servers" VALUES (489,84,'irc.gammaforce.org',6661);
INSERT INTO "servers" VALUES (490,84,'irc.gammaforce.org',6662);
INSERT INTO "servers" VALUES (491,84,'irc.gammaforce.org',6663);
INSERT INTO "servers" VALUES (492,84,'irc.gammaforce.org',6664);
INSERT INTO "servers" VALUES (493,84,'irc.gammaforce.org',6665);
INSERT INTO "servers" VALUES (494,84,'irc.gammaforce.org',6666);
INSERT INTO "servers" VALUES (495,84,'irc.gammaforce.org',6667);
INSERT INTO "servers" VALUES (496,84,'irc.gammaforce.org',6668);
INSERT INTO "servers" VALUES (497,84,'irc.gammaforce.org',6669);
INSERT INTO "servers" VALUES (498,85,'irc.ghostnet.org',6660);
INSERT INTO "servers" VALUES (499,85,'irc.ghostnet.org',6661);
INSERT INTO "servers" VALUES (500,85,'irc.ghostnet.org',6662);
INSERT INTO "servers" VALUES (501,85,'irc.ghostnet.org',6663);
INSERT INTO "servers" VALUES (502,85,'irc.ghostnet.org',6664);
INSERT INTO "servers" VALUES (503,85,'irc.ghostnet.org',6665);
INSERT INTO "servers" VALUES (504,85,'irc.ghostnet.org',6666);
INSERT INTO "servers" VALUES (505,85,'irc.ghostnet.org',6667);
INSERT INTO "servers" VALUES (506,85,'irc.ghostnet.org',6668);
INSERT INTO "servers" VALUES (507,85,'irc.ghostnet.org',6669);
INSERT INTO "servers" VALUES (508,86,'irc.giznet.com',6666);
INSERT INTO "servers" VALUES (509,86,'irc.giznet.com',6667);
INSERT INTO "servers" VALUES (510,86,'irc.giznet.com',6668);
INSERT INTO "servers" VALUES (511,86,'irc.giznet.com',6669);
INSERT INTO "servers" VALUES (512,87,'irc.global-irc.net',6667);
INSERT INTO "servers" VALUES (513,88,'irc.globalchat.org',6667);
INSERT INTO "servers" VALUES (514,89,'irc.go2chat.net',6667);
INSERT INTO "servers" VALUES (515,89,'irc.go2chat.net',6668);
INSERT INTO "servers" VALUES (516,89,'irc.go2chat.net',6669);
INSERT INTO "servers" VALUES (517,90,'gr.irc.gr',6667);
INSERT INTO "servers" VALUES (518,90,'gr.irc.gr',7000);
INSERT INTO "servers" VALUES (519,90,'srv.irc.gr',6667);
INSERT INTO "servers" VALUES (520,90,'srv.irc.gr',7000);
INSERT INTO "servers" VALUES (521,90,'us.irc.gr',6667);
INSERT INTO "servers" VALUES (522,90,'us.irc.gr',7000);
INSERT INTO "servers" VALUES (523,91,'irc.mirc.gr',6667);
INSERT INTO "servers" VALUES (524,91,'irc.mirc.gr',7000);
INSERT INTO "servers" VALUES (525,92,'irc.hugs.net',6667);
INSERT INTO "servers" VALUES (526,92,'irc.hugs.net',7000);
INSERT INTO "servers" VALUES (527,93,'irc.hybnet.net',6667);
INSERT INTO "servers" VALUES (528,94,'irc.ichatzone.com',6667);
INSERT INTO "servers" VALUES (529,95,'irc.icq.com',6667);
INSERT INTO "servers" VALUES (530,96,'irc.infatech.net',6660);
INSERT INTO "servers" VALUES (531,96,'irc.infatech.net',6661);
INSERT INTO "servers" VALUES (532,96,'irc.infatech.net',6662);
INSERT INTO "servers" VALUES (533,96,'irc.infatech.net',6663);
INSERT INTO "servers" VALUES (534,96,'irc.infatech.net',6664);
INSERT INTO "servers" VALUES (535,96,'irc.infatech.net',6665);
INSERT INTO "servers" VALUES (536,96,'irc.infatech.net',6666);
INSERT INTO "servers" VALUES (537,96,'irc.infatech.net',6667);
INSERT INTO "servers" VALUES (538,96,'irc.infatech.net',6668);
INSERT INTO "servers" VALUES (539,96,'irc.infatech.net',6669);
INSERT INTO "servers" VALUES (540,97,'irc.infinity-irc.org',6667);
INSERT INTO "servers" VALUES (541,98,'irc.insiderz.net',6667);
INSERT INTO "servers" VALUES (542,99,'irc.irc-hispano.org',6667);
INSERT INTO "servers" VALUES (543,100,'irc.irchat.net',6660);
INSERT INTO "servers" VALUES (544,100,'irc.irchat.net',6661);
INSERT INTO "servers" VALUES (545,100,'irc.irchat.net',6662);
INSERT INTO "servers" VALUES (546,100,'irc.irchat.net',6663);
INSERT INTO "servers" VALUES (547,100,'irc.irchat.net',6664);
INSERT INTO "servers" VALUES (548,100,'irc.irchat.net',6665);
INSERT INTO "servers" VALUES (549,100,'irc.irchat.net',6666);
INSERT INTO "servers" VALUES (550,100,'irc.irchat.net',6667);
INSERT INTO "servers" VALUES (551,100,'irc.irchat.net',6668);
INSERT INTO "servers" VALUES (552,100,'irc.irchat.net',6669);
INSERT INTO "servers" VALUES (553,101,'irc.irchat.com.br',6667);
INSERT INTO "servers" VALUES (554,102,'alesund.no.eu.irclink.net',6667);
INSERT INTO "servers" VALUES (555,102,'alesund.no.eu.irclink.net',6668);
INSERT INTO "servers" VALUES (556,102,'alesund.no.eu.irclink.net',6669);
INSERT INTO "servers" VALUES (557,102,'frogn.no.eu.irclink.net',6667);
INSERT INTO "servers" VALUES (558,102,'frogn.no.eu.irclink.net',6668);
INSERT INTO "servers" VALUES (559,102,'frogn.no.eu.irclink.net',6669);
INSERT INTO "servers" VALUES (560,102,'rockhill.sc.us.irclink.net',6667);
INSERT INTO "servers" VALUES (561,102,'rockhill.sc.us.irclink.net',6668);
INSERT INTO "servers" VALUES (562,102,'rockhill.sc.us.irclink.net',6669);
INSERT INTO "servers" VALUES (563,103,'irc.ircd.it',6665);
INSERT INTO "servers" VALUES (564,103,'irc.ircd.it',6666);
INSERT INTO "servers" VALUES (565,103,'irc.ircd.it',6667);
INSERT INTO "servers" VALUES (566,103,'irc.ircd.it',6668);
INSERT INTO "servers" VALUES (567,103,'irc.ircd.it',6669);
INSERT INTO "servers" VALUES (568,103,'irc.tokyo.wide.ad.jp',6667);
INSERT INTO "servers" VALUES (569,103,'flute.telstra.net.au',6665);
INSERT INTO "servers" VALUES (570,103,'flute.telstra.net.au',6666);
INSERT INTO "servers" VALUES (571,103,'flute.telstra.net.au',6667);
INSERT INTO "servers" VALUES (572,103,'flute.telstra.net.au',6668);
INSERT INTO "servers" VALUES (573,103,'flute.telstra.net.au',6669);
INSERT INTO "servers" VALUES (574,103,'yoyo.cc.monash.edu.au',6667);
INSERT INTO "servers" VALUES (575,103,'yoyo.cc.monash.edu.au',6668);
INSERT INTO "servers" VALUES (576,103,'yoyo.cc.monash.edu.au',6669);
INSERT INTO "servers" VALUES (577,103,'irc.usyd.edu.au',6667);
INSERT INTO "servers" VALUES (578,103,'linz.irc.at',6666);
INSERT INTO "servers" VALUES (579,103,'linz.irc.at',6667);
INSERT INTO "servers" VALUES (580,103,'linz.irc.at',6668);
INSERT INTO "servers" VALUES (581,103,'vienna.irc.at',6666);
INSERT INTO "servers" VALUES (582,103,'vienna.irc.at',6667);
INSERT INTO "servers" VALUES (583,103,'vienna.irc.at',6668);
INSERT INTO "servers" VALUES (584,103,'vienna.irc.at',6669);
INSERT INTO "servers" VALUES (585,103,'irc.belnet.be',6667);
INSERT INTO "servers" VALUES (586,103,'ircnet.wanadoo.be',6661);
INSERT INTO "servers" VALUES (587,103,'ircnet.wanadoo.be',6662);
INSERT INTO "servers" VALUES (588,103,'ircnet.wanadoo.be',6663);
INSERT INTO "servers" VALUES (589,103,'ircnet.wanadoo.be',6664);
INSERT INTO "servers" VALUES (590,103,'ircnet.wanadoo.be',6665);
INSERT INTO "servers" VALUES (591,103,'ircnet.wanadoo.be',6666);
INSERT INTO "servers" VALUES (592,103,'ircnet.wanadoo.be',6667);
INSERT INTO "servers" VALUES (593,103,'ircnet.wanadoo.be',6668);
INSERT INTO "servers" VALUES (594,103,'ircnet.wanadoo.be',6669);
INSERT INTO "servers" VALUES (595,103,'irc.felk.cvut.cz',6667);
INSERT INTO "servers" VALUES (596,103,'irc.fu-berlin.de',6665);
INSERT INTO "servers" VALUES (597,103,'irc.fu-berlin.de',6666);
INSERT INTO "servers" VALUES (598,103,'irc.fu-berlin.de',6667);
INSERT INTO "servers" VALUES (599,103,'irc.fu-berlin.de',6668);
INSERT INTO "servers" VALUES (600,103,'irc.fu-berlin.de',6669);
INSERT INTO "servers" VALUES (601,103,'irc.freenet.de',6665);
INSERT INTO "servers" VALUES (602,103,'irc.freenet.de',6666);
INSERT INTO "servers" VALUES (603,103,'irc.freenet.de',6667);
INSERT INTO "servers" VALUES (604,103,'irc.freenet.de',6668);
INSERT INTO "servers" VALUES (605,103,'irc.freenet.de',6669);
INSERT INTO "servers" VALUES (606,103,'irc.belwue.de',6665);
INSERT INTO "servers" VALUES (607,103,'irc.belwue.de',6666);
INSERT INTO "servers" VALUES (608,103,'irc.belwue.de',6667);
INSERT INTO "servers" VALUES (609,103,'irc.belwue.de',6668);
INSERT INTO "servers" VALUES (610,103,'irc.belwue.de',6669);
INSERT INTO "servers" VALUES (611,103,'irc.ircnet.dk',6667);
INSERT INTO "servers" VALUES (612,103,'irc.estpak.ee',6666);
INSERT INTO "servers" VALUES (613,103,'irc.estpak.ee',6667);
INSERT INTO "servers" VALUES (614,103,'irc.estpak.ee',6668);
INSERT INTO "servers" VALUES (615,103,'irc.funet.fi',6660);
INSERT INTO "servers" VALUES (616,103,'irc.funet.fi',6661);
INSERT INTO "servers" VALUES (617,103,'irc.funet.fi',6662);
INSERT INTO "servers" VALUES (618,103,'irc.funet.fi',6663);
INSERT INTO "servers" VALUES (619,103,'irc.funet.fi',6664);
INSERT INTO "servers" VALUES (620,103,'irc.funet.fi',6665);
INSERT INTO "servers" VALUES (621,103,'irc.funet.fi',6666);
INSERT INTO "servers" VALUES (622,103,'irc.funet.fi',6667);
INSERT INTO "servers" VALUES (623,103,'irc.funet.fi',6668);
INSERT INTO "servers" VALUES (624,103,'irc.funet.fi',6669);
INSERT INTO "servers" VALUES (625,103,'irc.cs.hut.fi',6667);
INSERT INTO "servers" VALUES (626,103,'irc.eurecom.fr',6667);
INSERT INTO "servers" VALUES (627,103,'ircnet.grolier.net',6667);
INSERT INTO "servers" VALUES (628,103,'sil.polytechnique.fr',6667);
INSERT INTO "servers" VALUES (629,103,'irc.ee.auth.gr',6666);
INSERT INTO "servers" VALUES (630,103,'irc.ee.auth.gr',6667);
INSERT INTO "servers" VALUES (631,103,'irc.ee.auth.gr',6668);
INSERT INTO "servers" VALUES (632,103,'irc.ee.auth.gr',6669);
INSERT INTO "servers" VALUES (633,103,'irc.elte.hu',6667);
INSERT INTO "servers" VALUES (634,103,'ircnet.netvision.net.il',6661);
INSERT INTO "servers" VALUES (635,103,'ircnet.netvision.net.il',6662);
INSERT INTO "servers" VALUES (636,103,'ircnet.netvision.net.il',6663);
INSERT INTO "servers" VALUES (637,103,'ircnet.netvision.net.il',6664);
INSERT INTO "servers" VALUES (638,103,'ircnet.netvision.net.il',6665);
INSERT INTO "servers" VALUES (639,103,'ircnet.netvision.net.il',6666);
INSERT INTO "servers" VALUES (640,103,'ircnet.netvision.net.il',6667);
INSERT INTO "servers" VALUES (641,103,'ircnet.netvision.net.il',6668);
INSERT INTO "servers" VALUES (642,103,'irc.isnet.is',6661);
INSERT INTO "servers" VALUES (643,103,'irc.isnet.is',6662);
INSERT INTO "servers" VALUES (644,103,'irc.isnet.is',6663);
INSERT INTO "servers" VALUES (645,103,'irc.isnet.is',6664);
INSERT INTO "servers" VALUES (646,103,'irc.isnet.is',6665);
INSERT INTO "servers" VALUES (647,103,'irc.isnet.is',6666);
INSERT INTO "servers" VALUES (648,103,'irc.isnet.is',6667);
INSERT INTO "servers" VALUES (649,103,'irc.isnet.is',6668);
INSERT INTO "servers" VALUES (650,103,'irc.isnet.is',6669);
INSERT INTO "servers" VALUES (651,103,'irc.lvnet.lv',6667);
INSERT INTO "servers" VALUES (652,103,'irc.lvnet.lv',6668);
INSERT INTO "servers" VALUES (653,103,'irc.lvnet.lv',6669);
INSERT INTO "servers" VALUES (654,103,'irc.nl.uu.net',6660);
INSERT INTO "servers" VALUES (655,103,'irc.nl.uu.net',6661);
INSERT INTO "servers" VALUES (656,103,'irc.nl.uu.net',6662);
INSERT INTO "servers" VALUES (657,103,'irc.nl.uu.net',6663);
INSERT INTO "servers" VALUES (658,103,'irc.nl.uu.net',6664);
INSERT INTO "servers" VALUES (659,103,'irc.nl.uu.net',6665);
INSERT INTO "servers" VALUES (660,103,'irc.nl.uu.net',6666);
INSERT INTO "servers" VALUES (661,103,'irc.nl.uu.net',6667);
INSERT INTO "servers" VALUES (662,103,'irc.nl.uu.net',6668);
INSERT INTO "servers" VALUES (663,103,'irc.nl.uu.net',6669);
INSERT INTO "servers" VALUES (664,103,'irc.xs4all.nl',6660);
INSERT INTO "servers" VALUES (665,103,'irc.xs4all.nl',6661);
INSERT INTO "servers" VALUES (666,103,'irc.xs4all.nl',6662);
INSERT INTO "servers" VALUES (667,103,'irc.xs4all.nl',6663);
INSERT INTO "servers" VALUES (668,103,'irc.xs4all.nl',6664);
INSERT INTO "servers" VALUES (669,103,'irc.xs4all.nl',6665);
INSERT INTO "servers" VALUES (670,103,'irc.xs4all.nl',6666);
INSERT INTO "servers" VALUES (671,103,'irc.xs4all.nl',6667);
INSERT INTO "servers" VALUES (672,103,'irc.xs4all.nl',6668);
INSERT INTO "servers" VALUES (673,103,'irc.xs4all.nl',6669);
INSERT INTO "servers" VALUES (674,103,'irc.snt.utwente.nl',6660);
INSERT INTO "servers" VALUES (675,103,'irc.snt.utwente.nl',6661);
INSERT INTO "servers" VALUES (676,103,'irc.snt.utwente.nl',6662);
INSERT INTO "servers" VALUES (677,103,'irc.snt.utwente.nl',6663);
INSERT INTO "servers" VALUES (678,103,'irc.snt.utwente.nl',6664);
INSERT INTO "servers" VALUES (679,103,'irc.snt.utwente.nl',6665);
INSERT INTO "servers" VALUES (680,103,'irc.snt.utwente.nl',6666);
INSERT INTO "servers" VALUES (681,103,'irc.snt.utwente.nl',6667);
INSERT INTO "servers" VALUES (682,103,'irc.snt.utwente.nl',6668);
INSERT INTO "servers" VALUES (683,103,'irc.snt.utwente.nl',6669);
INSERT INTO "servers" VALUES (684,103,'irc.sci.kun.nl',6660);
INSERT INTO "servers" VALUES (685,103,'irc.sci.kun.nl',6661);
INSERT INTO "servers" VALUES (686,103,'irc.sci.kun.nl',6662);
INSERT INTO "servers" VALUES (687,103,'irc.sci.kun.nl',6663);
INSERT INTO "servers" VALUES (688,103,'irc.sci.kun.nl',6664);
INSERT INTO "servers" VALUES (689,103,'irc.sci.kun.nl',6665);
INSERT INTO "servers" VALUES (690,103,'irc.sci.kun.nl',6666);
INSERT INTO "servers" VALUES (691,103,'irc.sci.kun.nl',6667);
INSERT INTO "servers" VALUES (692,103,'irc.sci.kun.nl',6668);
INSERT INTO "servers" VALUES (693,103,'irc.sci.kun.nl',6669);
INSERT INTO "servers" VALUES (694,103,'irc.ifi.uio.no',6667);
INSERT INTO "servers" VALUES (695,103,'irc.pvv.unit.no',6667);
INSERT INTO "servers" VALUES (696,103,'warszawa.irc.pl',6666);
INSERT INTO "servers" VALUES (697,103,'warszawa.irc.pl',6667);
INSERT INTO "servers" VALUES (698,103,'warszawa.irc.pl',6668);
INSERT INTO "servers" VALUES (699,103,'irc.msu.ru',6667);
INSERT INTO "servers" VALUES (700,103,'irc.ludd.luth.se',6661);
INSERT INTO "servers" VALUES (701,103,'irc.ludd.luth.se',6662);
INSERT INTO "servers" VALUES (702,103,'irc.ludd.luth.se',6663);
INSERT INTO "servers" VALUES (703,103,'irc.ludd.luth.se',6664);
INSERT INTO "servers" VALUES (704,103,'irc.ludd.luth.se',6665);
INSERT INTO "servers" VALUES (705,103,'irc.ludd.luth.se',6666);
INSERT INTO "servers" VALUES (706,103,'irc.ludd.luth.se',6667);
INSERT INTO "servers" VALUES (707,103,'irc.ludd.luth.se',6668);
INSERT INTO "servers" VALUES (708,103,'irc.ludd.luth.se',6669);
INSERT INTO "servers" VALUES (709,103,'chat.bt.net',6660);
INSERT INTO "servers" VALUES (710,103,'chat.bt.net',6661);
INSERT INTO "servers" VALUES (711,103,'chat.bt.net',6662);
INSERT INTO "servers" VALUES (712,103,'chat.bt.net',6663);
INSERT INTO "servers" VALUES (713,103,'chat.bt.net',6664);
INSERT INTO "servers" VALUES (714,103,'chat.bt.net',6665);
INSERT INTO "servers" VALUES (715,103,'chat.bt.net',6666);
INSERT INTO "servers" VALUES (716,103,'chat.bt.net',6667);
INSERT INTO "servers" VALUES (717,103,'chat.bt.net',6668);
INSERT INTO "servers" VALUES (718,103,'chat.bt.net',6669);
INSERT INTO "servers" VALUES (719,103,'ircnet.demon.co.uk',6665);
INSERT INTO "servers" VALUES (720,103,'ircnet.demon.co.uk',6666);
INSERT INTO "servers" VALUES (721,103,'ircnet.demon.co.uk',6667);
INSERT INTO "servers" VALUES (722,103,'ircnet.demon.co.uk',6668);
INSERT INTO "servers" VALUES (723,103,'ircnet.demon.co.uk',6669);
INSERT INTO "servers" VALUES (724,103,'irc.netcom.net.uk',6660);
INSERT INTO "servers" VALUES (725,103,'irc.netcom.net.uk',6661);
INSERT INTO "servers" VALUES (726,103,'irc.netcom.net.uk',6662);
INSERT INTO "servers" VALUES (727,103,'irc.netcom.net.uk',6663);
INSERT INTO "servers" VALUES (728,103,'irc.u-net.com',6660);
INSERT INTO "servers" VALUES (729,103,'irc.u-net.com',6661);
INSERT INTO "servers" VALUES (730,103,'irc.u-net.com',6662);
INSERT INTO "servers" VALUES (731,103,'irc.u-net.com',6663);
INSERT INTO "servers" VALUES (732,103,'irc.u-net.com',6664);
INSERT INTO "servers" VALUES (733,103,'irc.u-net.com',6665);
INSERT INTO "servers" VALUES (734,103,'irc.u-net.com',6666);
INSERT INTO "servers" VALUES (735,103,'irc.u-net.com',6667);
INSERT INTO "servers" VALUES (736,103,'irc.u-net.com',6668);
INSERT INTO "servers" VALUES (737,103,'irc.u-net.com',6669);
INSERT INTO "servers" VALUES (738,103,'irc.u-net.com',7000);
INSERT INTO "servers" VALUES (739,103,'irc.u-net.com',7001);
INSERT INTO "servers" VALUES (740,103,'irc.u-net.com',7002);
INSERT INTO "servers" VALUES (741,103,'irc.stealth.net',6660);
INSERT INTO "servers" VALUES (742,103,'irc.stealth.net',6661);
INSERT INTO "servers" VALUES (743,103,'irc.stealth.net',6662);
INSERT INTO "servers" VALUES (744,103,'irc.stealth.net',6663);
INSERT INTO "servers" VALUES (745,103,'irc.stealth.net',6664);
INSERT INTO "servers" VALUES (746,103,'irc.stealth.net',6665);
INSERT INTO "servers" VALUES (747,103,'irc.stealth.net',6666);
INSERT INTO "servers" VALUES (748,103,'irc.stealth.net',6667);
INSERT INTO "servers" VALUES (749,103,'irc.stealth.net',6668);
INSERT INTO "servers" VALUES (750,103,'irc.stealth.net',6669);
INSERT INTO "servers" VALUES (751,104,'irc.ircstorm.net',6667);
INSERT INTO "servers" VALUES (752,105,'irc.israel.net',6667);
INSERT INTO "servers" VALUES (753,106,'irc.k0w.net',6660);
INSERT INTO "servers" VALUES (754,106,'irc.k0w.net',6661);
INSERT INTO "servers" VALUES (755,106,'irc.k0w.net',6662);
INSERT INTO "servers" VALUES (756,106,'irc.k0w.net',6663);
INSERT INTO "servers" VALUES (757,106,'irc.k0w.net',6664);
INSERT INTO "servers" VALUES (758,106,'irc.k0w.net',6665);
INSERT INTO "servers" VALUES (759,106,'irc.k0w.net',6666);
INSERT INTO "servers" VALUES (760,106,'irc.k0w.net',6667);
INSERT INTO "servers" VALUES (761,106,'irc.k0w.net',6668);
INSERT INTO "servers" VALUES (762,106,'irc.k0w.net',6669);
INSERT INTO "servers" VALUES (763,107,'irc.kewl.org',6667);
INSERT INTO "servers" VALUES (764,107,'nanterre.fr.eu.kewl.org',6667);
INSERT INTO "servers" VALUES (765,107,'london.uk.eu.kewl.org',6667);
INSERT INTO "servers" VALUES (766,108,'paris.fr.eu.kidsworld.org',6660);
INSERT INTO "servers" VALUES (767,108,'paris.fr.eu.kidsworld.org',6661);
INSERT INTO "servers" VALUES (768,108,'paris.fr.eu.kidsworld.org',6662);
INSERT INTO "servers" VALUES (769,108,'paris.fr.eu.kidsworld.org',6663);
INSERT INTO "servers" VALUES (770,108,'paris.fr.eu.kidsworld.org',6664);
INSERT INTO "servers" VALUES (771,108,'paris.fr.eu.kidsworld.org',6665);
INSERT INTO "servers" VALUES (772,108,'paris.fr.eu.kidsworld.org',6666);
INSERT INTO "servers" VALUES (773,108,'paris.fr.eu.kidsworld.org',6667);
INSERT INTO "servers" VALUES (774,108,'paris.fr.eu.kidsworld.org',6668);
INSERT INTO "servers" VALUES (775,108,'paris.fr.eu.kidsworld.org',6669);
INSERT INTO "servers" VALUES (776,108,'denver.co.us.kidsworld.org',6666);
INSERT INTO "servers" VALUES (777,108,'denver.co.us.kidsworld.org',6667);
INSERT INTO "servers" VALUES (778,108,'denver.co.us.kidsworld.org',6668);
INSERT INTO "servers" VALUES (779,108,'denver.co.us.kidsworld.org',6669);
INSERT INTO "servers" VALUES (780,108,'baltimore.md.us.kidsworld.org',6666);
INSERT INTO "servers" VALUES (781,108,'baltimore.md.us.kidsworld.org',6667);
INSERT INTO "servers" VALUES (782,108,'baltimore.md.us.kidsworld.org',6668);
INSERT INTO "servers" VALUES (783,108,'baltimore.md.us.kidsworld.org',6669);
INSERT INTO "servers" VALUES (784,109,'irc.kissland.com',6667);
INSERT INTO "servers" VALUES (785,110,'orc.dbn.za.knightnet.net',6667);
INSERT INTO "servers" VALUES (786,110,'orc.dbn.za.knightnet.net',5555);
INSERT INTO "servers" VALUES (787,110,'goldengate.ca.us.knightnet.net',6667);
INSERT INTO "servers" VALUES (788,110,'goldengate.ca.us.knightnet.net',5555);
INSERT INTO "servers" VALUES (789,111,'irc.krey.net',6667);
INSERT INTO "servers" VALUES (790,112,'irc.krushnet.org',6667);
INSERT INTO "servers" VALUES (791,113,'reaper.lagnet.org.za',6667);
INSERT INTO "servers" VALUES (792,113,'splash.lagnet.org.za',6667);
INSERT INTO "servers" VALUES (793,113,'mystery.lagnet.org.za',6667);
INSERT INTO "servers" VALUES (794,113,'possum.lagnet.org.za',6667);
INSERT INTO "servers" VALUES (795,114,'irc.librenet.net',6667);
INSERT INTO "servers" VALUES (796,115,'irc.lunatics.net',6667);
INSERT INTO "servers" VALUES (797,115,'irc.lunatics.net',6668);
INSERT INTO "servers" VALUES (798,115,'irc.lunatics.net',6669);
INSERT INTO "servers" VALUES (799,116,'irc.magicstar.net',6667);
INSERT INTO "servers" VALUES (800,117,'irc.mavra.net',6660);
INSERT INTO "servers" VALUES (801,117,'irc.mavra.net',6661);
INSERT INTO "servers" VALUES (802,117,'irc.mavra.net',6662);
INSERT INTO "servers" VALUES (803,117,'irc.mavra.net',6663);
INSERT INTO "servers" VALUES (804,117,'irc.mavra.net',6664);
INSERT INTO "servers" VALUES (805,117,'irc.mavra.net',6665);
INSERT INTO "servers" VALUES (806,117,'irc.mavra.net',6666);
INSERT INTO "servers" VALUES (807,117,'irc.mavra.net',6667);
INSERT INTO "servers" VALUES (808,117,'irc.mavra.net',6668);
INSERT INTO "servers" VALUES (809,117,'irc.mavra.net',6669);
INSERT INTO "servers" VALUES (810,118,'irc.mellorien.net',6667);
INSERT INTO "servers" VALUES (811,119,'irc.messique.org',6661);
INSERT INTO "servers" VALUES (812,119,'irc.messique.org',6662);
INSERT INTO "servers" VALUES (813,119,'irc.messique.org',6663);
INSERT INTO "servers" VALUES (814,119,'irc.messique.org',6664);
INSERT INTO "servers" VALUES (815,119,'irc.messique.org',6665);
INSERT INTO "servers" VALUES (816,119,'irc.messique.org',6666);
INSERT INTO "servers" VALUES (817,119,'irc.messique.org',6667);
INSERT INTO "servers" VALUES (818,119,'irc.messique.org',6668);
INSERT INTO "servers" VALUES (819,119,'irc.messique.org',6669);
INSERT INTO "servers" VALUES (820,120,'chat.msn.com',6667);
INSERT INTO "servers" VALUES (821,121,'irc.millenia.org',6664);
INSERT INTO "servers" VALUES (822,121,'irc.millenia.org',6665);
INSERT INTO "servers" VALUES (823,121,'irc.millenia.org',6666);
INSERT INTO "servers" VALUES (824,121,'irc.millenia.org',6667);
INSERT INTO "servers" VALUES (825,121,'irc.millenia.org',6668);
INSERT INTO "servers" VALUES (826,121,'irc.millenia.org',6669);
INSERT INTO "servers" VALUES (827,122,'irc.mirc.net',6667);
INSERT INTO "servers" VALUES (828,123,'irc.mozilla.org',6667);
INSERT INTO "servers" VALUES (829,123,'irc.mozilla.org',7000);
INSERT INTO "servers" VALUES (830,124,'irc.muhabbet.net',6667);
INSERT INTO "servers" VALUES (831,124,'irc.muhabbet.net',8888);
INSERT INTO "servers" VALUES (832,124,'irc.muhabbet.net',9000);
INSERT INTO "servers" VALUES (833,125,'irc.mysteria.net',6667);
INSERT INTO "servers" VALUES (834,125,'irc.mysteria.net',7000);
INSERT INTO "servers" VALUES (835,126,'irc.mystical.net',6667);
INSERT INTO "servers" VALUES (836,126,'irc.mystical.net',7000);
INSERT INTO "servers" VALUES (837,127,'irc.ndrs.com',6661);
INSERT INTO "servers" VALUES (838,127,'irc.ndrs.com',6662);
INSERT INTO "servers" VALUES (839,127,'irc.ndrs.com',6663);
INSERT INTO "servers" VALUES (840,127,'irc.ndrs.com',6664);
INSERT INTO "servers" VALUES (841,127,'irc.ndrs.com',6665);
INSERT INTO "servers" VALUES (842,127,'irc.ndrs.com',6666);
INSERT INTO "servers" VALUES (843,127,'irc.ndrs.com',6667);
INSERT INTO "servers" VALUES (844,127,'irc.ndrs.com',6668);
INSERT INTO "servers" VALUES (845,128,'irc.nebulanet.org',6660);
INSERT INTO "servers" VALUES (846,128,'irc.nebulanet.org',6661);
INSERT INTO "servers" VALUES (847,128,'irc.nebulanet.org',6662);
INSERT INTO "servers" VALUES (848,128,'irc.nebulanet.org',6663);
INSERT INTO "servers" VALUES (849,128,'irc.nebulanet.org',6664);
INSERT INTO "servers" VALUES (850,128,'irc.nebulanet.org',6665);
INSERT INTO "servers" VALUES (851,128,'irc.nebulanet.org',6666);
INSERT INTO "servers" VALUES (852,128,'irc.nebulanet.org',6667);
INSERT INTO "servers" VALUES (853,128,'irc.nebulanet.org',6668);
INSERT INTO "servers" VALUES (854,128,'irc.nebulanet.org',6669);
INSERT INTO "servers" VALUES (855,129,'irc.net-france.com',6667);
INSERT INTO "servers" VALUES (856,130,'irc.nevernet.net',6667);
INSERT INTO "servers" VALUES (857,131,'irc.newnet.net',6665);
INSERT INTO "servers" VALUES (858,131,'irc.newnet.net',6666);
INSERT INTO "servers" VALUES (859,131,'irc.newnet.net',6667);
INSERT INTO "servers" VALUES (860,131,'irc.oasis-net.net',6666);
INSERT INTO "servers" VALUES (861,131,'irc.oasis-net.net',7000);
INSERT INTO "servers" VALUES (862,131,'irc.uplink.net.nz',6660);
INSERT INTO "servers" VALUES (863,131,'irc.uplink.net.nz',6661);
INSERT INTO "servers" VALUES (864,131,'irc.uplink.net.nz',6662);
INSERT INTO "servers" VALUES (865,131,'irc.uplink.net.nz',6663);
INSERT INTO "servers" VALUES (866,131,'irc.uplink.net.nz',6664);
INSERT INTO "servers" VALUES (867,131,'irc.uplink.net.nz',6665);
INSERT INTO "servers" VALUES (868,131,'irc.uplink.net.nz',6666);
INSERT INTO "servers" VALUES (869,131,'irc.uplink.net.nz',6667);
INSERT INTO "servers" VALUES (870,131,'irc.uplink.net.nz',6668);
INSERT INTO "servers" VALUES (871,131,'irc.uplink.net.nz',6669);
INSERT INTO "servers" VALUES (872,131,'irc.fragglerock.org',6666);
INSERT INTO "servers" VALUES (873,131,'irc.fragglerock.org',7000);
INSERT INTO "servers" VALUES (874,131,'irc.eskimo.com',6660);
INSERT INTO "servers" VALUES (875,131,'irc.eskimo.com',6661);
INSERT INTO "servers" VALUES (876,131,'irc.eskimo.com',6662);
INSERT INTO "servers" VALUES (877,131,'irc.eskimo.com',6663);
INSERT INTO "servers" VALUES (878,131,'irc.eskimo.com',6664);
INSERT INTO "servers" VALUES (879,131,'irc.eskimo.com',6665);
INSERT INTO "servers" VALUES (880,131,'irc.eskimo.com',6666);
INSERT INTO "servers" VALUES (881,131,'irc.eskimo.com',6667);
INSERT INTO "servers" VALUES (882,131,'irc.eskimo.com',6668);
INSERT INTO "servers" VALUES (883,131,'irc.eskimo.com',6669);
INSERT INTO "servers" VALUES (884,132,'irc.nightstar.net',6665);
INSERT INTO "servers" VALUES (885,132,'irc.nightstar.net',6666);
INSERT INTO "servers" VALUES (886,132,'irc.nightstar.net',6667);
INSERT INTO "servers" VALUES (887,132,'irc.nightstar.net',6668);
INSERT INTO "servers" VALUES (888,132,'irc.nightstar.net',6669);
INSERT INTO "servers" VALUES (889,133,'irc.novernet.com',6665);
INSERT INTO "servers" VALUES (890,133,'irc.novernet.com',6666);
INSERT INTO "servers" VALUES (891,133,'irc.novernet.com',6667);
INSERT INTO "servers" VALUES (892,133,'irc.novernet.com',6668);
INSERT INTO "servers" VALUES (893,133,'irc.novernet.com',6669);
INSERT INTO "servers" VALUES (894,133,'irc.c-plusnet.com',6665);
INSERT INTO "servers" VALUES (895,133,'irc.c-plusnet.com',6666);
INSERT INTO "servers" VALUES (896,133,'irc.c-plusnet.com',6667);
INSERT INTO "servers" VALUES (897,133,'irc.c-plusnet.com',6668);
INSERT INTO "servers" VALUES (898,133,'irc.c-plusnet.com',6669);
INSERT INTO "servers" VALUES (899,133,'chat.novernet.com',6667);
INSERT INTO "servers" VALUES (900,134,'irc.openmind.net',6667);
INSERT INTO "servers" VALUES (901,135,'irc.othernet.org',6667);
INSERT INTO "servers" VALUES (902,135,'miami.fl.us.othernet.org',6667);
INSERT INTO "servers" VALUES (903,135,'stlouis.mo.us.othernet.org',6667);
INSERT INTO "servers" VALUES (904,136,'irc.otherside.com',6667);
INSERT INTO "servers" VALUES (905,137,'irc.outsiderz.com',6667);
INSERT INTO "servers" VALUES (906,138,'irc.ozchat.org',6667);
INSERT INTO "servers" VALUES (907,139,'chariot.adelaide.oz.org',6666);
INSERT INTO "servers" VALUES (908,139,'chariot.adelaide.oz.org',6667);
INSERT INTO "servers" VALUES (909,139,'chariot.adelaide.oz.org',6668);
INSERT INTO "servers" VALUES (910,139,'iinet.perth.oz.org',6667);
INSERT INTO "servers" VALUES (911,139,'aussie.sydney.oz.org',6668);
INSERT INTO "servers" VALUES (912,139,'aussie.sydney.oz.org',6669);
INSERT INTO "servers" VALUES (913,140,'irc.oztic.net',6667);
INSERT INTO "servers" VALUES (914,140,'irc.oztic.net',6668);
INSERT INTO "servers" VALUES (915,140,'irc.oztic.net',6669);
INSERT INTO "servers" VALUES (916,141,'irc.phishy.net',6667);
INSERT INTO "servers" VALUES (917,141,'irc.phishy.net',7000);
INSERT INTO "servers" VALUES (918,142,'chat.abs-cbn.com',6667);
INSERT INTO "servers" VALUES (919,143,'irc.planetarion.com',6667);
INSERT INTO "servers" VALUES (920,144,'irc.powerchat.org',6660);
INSERT INTO "servers" VALUES (921,144,'irc.powerchat.org',6661);
INSERT INTO "servers" VALUES (922,144,'irc.powerchat.org',6662);
INSERT INTO "servers" VALUES (923,144,'irc.powerchat.org',6663);
INSERT INTO "servers" VALUES (924,144,'irc.powerchat.org',6664);
INSERT INTO "servers" VALUES (925,144,'irc.powerchat.org',6665);
INSERT INTO "servers" VALUES (926,144,'irc.powerchat.org',6666);
INSERT INTO "servers" VALUES (927,144,'irc.powerchat.org',6667);
INSERT INTO "servers" VALUES (928,144,'irc.powerchat.org',6668);
INSERT INTO "servers" VALUES (929,144,'irc.powerchat.org',6669);
INSERT INTO "servers" VALUES (930,144,'irc.powerchat.org',6670);
INSERT INTO "servers" VALUES (931,144,'irc.powerchat.org',6671);
INSERT INTO "servers" VALUES (932,144,'irc.powerchat.org',6672);
INSERT INTO "servers" VALUES (933,144,'irc.powerchat.org',6673);
INSERT INTO "servers" VALUES (934,144,'irc.powerchat.org',6674);
INSERT INTO "servers" VALUES (935,144,'irc.powerchat.org',6675);
INSERT INTO "servers" VALUES (936,144,'irc.powerchat.org',6676);
INSERT INTO "servers" VALUES (937,144,'irc.powerchat.org',6677);
INSERT INTO "servers" VALUES (938,144,'irc.powerchat.org',6678);
INSERT INTO "servers" VALUES (939,144,'irc.powerchat.org',6679);
INSERT INTO "servers" VALUES (940,144,'irc.powerchat.org',6680);
INSERT INTO "servers" VALUES (941,144,'irc.powerchat.org',6681);
INSERT INTO "servers" VALUES (942,144,'irc.powerchat.org',6682);
INSERT INTO "servers" VALUES (943,144,'irc.powerchat.org',6683);
INSERT INTO "servers" VALUES (944,144,'irc.powerchat.org',6684);
INSERT INTO "servers" VALUES (945,144,'irc.powerchat.org',6685);
INSERT INTO "servers" VALUES (946,144,'irc.powerchat.org',6686);
INSERT INTO "servers" VALUES (947,144,'irc.powerchat.org',6687);
INSERT INTO "servers" VALUES (948,144,'irc.powerchat.org',6688);
INSERT INTO "servers" VALUES (949,144,'irc.powerchat.org',6689);
INSERT INTO "servers" VALUES (950,144,'irc.powerchat.org',6690);
INSERT INTO "servers" VALUES (951,144,'irc.powerchat.org',6691);
INSERT INTO "servers" VALUES (952,144,'irc.powerchat.org',6692);
INSERT INTO "servers" VALUES (953,144,'irc.powerchat.org',6693);
INSERT INTO "servers" VALUES (954,144,'irc.powerchat.org',6694);
INSERT INTO "servers" VALUES (955,144,'irc.powerchat.org',6695);
INSERT INTO "servers" VALUES (956,144,'irc.powerchat.org',6696);
INSERT INTO "servers" VALUES (957,144,'irc.powerchat.org',6697);
INSERT INTO "servers" VALUES (958,144,'irc.powerchat.org',6698);
INSERT INTO "servers" VALUES (959,144,'irc.powerchat.org',6699);
INSERT INTO "servers" VALUES (960,144,'irc.powerchat.org',6700);
INSERT INTO "servers" VALUES (961,144,'irc.powerchat.org',6701);
INSERT INTO "servers" VALUES (962,144,'irc.powerchat.org',6702);
INSERT INTO "servers" VALUES (963,144,'irc.powerchat.org',6703);
INSERT INTO "servers" VALUES (964,144,'irc.powerchat.org',6704);
INSERT INTO "servers" VALUES (965,144,'irc.powerchat.org',6705);
INSERT INTO "servers" VALUES (966,144,'irc.powerchat.org',6706);
INSERT INTO "servers" VALUES (967,144,'irc.powerchat.org',6707);
INSERT INTO "servers" VALUES (968,144,'irc.powerchat.org',6708);
INSERT INTO "servers" VALUES (969,144,'irc.powerchat.org',6709);
INSERT INTO "servers" VALUES (970,144,'irc.powerchat.org',6710);
INSERT INTO "servers" VALUES (971,144,'irc.powerchat.org',6711);
INSERT INTO "servers" VALUES (972,144,'irc.powerchat.org',6712);
INSERT INTO "servers" VALUES (973,144,'irc.powerchat.org',6713);
INSERT INTO "servers" VALUES (974,144,'irc.powerchat.org',6714);
INSERT INTO "servers" VALUES (975,144,'irc.powerchat.org',6715);
INSERT INTO "servers" VALUES (976,144,'irc.powerchat.org',6716);
INSERT INTO "servers" VALUES (977,144,'irc.powerchat.org',6717);
INSERT INTO "servers" VALUES (978,144,'irc.powerchat.org',6718);
INSERT INTO "servers" VALUES (979,144,'irc.powerchat.org',6719);
INSERT INTO "servers" VALUES (980,144,'irc.powerchat.org',6720);
INSERT INTO "servers" VALUES (981,144,'irc.powerchat.org',6721);
INSERT INTO "servers" VALUES (982,144,'irc.powerchat.org',6722);
INSERT INTO "servers" VALUES (983,144,'irc.powerchat.org',6723);
INSERT INTO "servers" VALUES (984,144,'irc.powerchat.org',6724);
INSERT INTO "servers" VALUES (985,144,'irc.powerchat.org',6725);
INSERT INTO "servers" VALUES (986,144,'irc.powerchat.org',6726);
INSERT INTO "servers" VALUES (987,144,'irc.powerchat.org',6727);
INSERT INTO "servers" VALUES (988,144,'irc.powerchat.org',6728);
INSERT INTO "servers" VALUES (989,144,'irc.powerchat.org',6729);
INSERT INTO "servers" VALUES (990,144,'irc.powerchat.org',6730);
INSERT INTO "servers" VALUES (991,144,'irc.powerchat.org',6731);
INSERT INTO "servers" VALUES (992,144,'irc.powerchat.org',6732);
INSERT INTO "servers" VALUES (993,144,'irc.powerchat.org',6733);
INSERT INTO "servers" VALUES (994,144,'irc.powerchat.org',6734);
INSERT INTO "servers" VALUES (995,144,'irc.powerchat.org',6735);
INSERT INTO "servers" VALUES (996,144,'irc.powerchat.org',6736);
INSERT INTO "servers" VALUES (997,144,'irc.powerchat.org',6737);
INSERT INTO "servers" VALUES (998,144,'irc.powerchat.org',6738);
INSERT INTO "servers" VALUES (999,144,'irc.powerchat.org',6739);
INSERT INTO "servers" VALUES (1000,144,'irc.powerchat.org',6740);
INSERT INTO "servers" VALUES (1001,144,'irc.powerchat.org',6741);
INSERT INTO "servers" VALUES (1002,144,'irc.powerchat.org',6742);
INSERT INTO "servers" VALUES (1003,144,'irc.powerchat.org',6743);
INSERT INTO "servers" VALUES (1004,144,'irc.powerchat.org',6744);
INSERT INTO "servers" VALUES (1005,144,'irc.powerchat.org',6745);
INSERT INTO "servers" VALUES (1006,144,'irc.powerchat.org',6746);
INSERT INTO "servers" VALUES (1007,144,'irc.powerchat.org',6747);
INSERT INTO "servers" VALUES (1008,144,'irc.powerchat.org',6748);
INSERT INTO "servers" VALUES (1009,144,'irc.powerchat.org',6749);
INSERT INTO "servers" VALUES (1010,144,'irc.powerchat.org',6750);
INSERT INTO "servers" VALUES (1011,144,'irc.powerchat.org',6751);
INSERT INTO "servers" VALUES (1012,144,'irc.powerchat.org',6752);
INSERT INTO "servers" VALUES (1013,144,'irc.powerchat.org',6753);
INSERT INTO "servers" VALUES (1014,144,'irc.powerchat.org',6754);
INSERT INTO "servers" VALUES (1015,144,'irc.powerchat.org',6755);
INSERT INTO "servers" VALUES (1016,144,'irc.powerchat.org',6756);
INSERT INTO "servers" VALUES (1017,144,'irc.powerchat.org',6757);
INSERT INTO "servers" VALUES (1018,144,'irc.powerchat.org',6758);
INSERT INTO "servers" VALUES (1019,144,'irc.powerchat.org',6759);
INSERT INTO "servers" VALUES (1020,144,'irc.powerchat.org',6760);
INSERT INTO "servers" VALUES (1021,144,'irc.powerchat.org',6761);
INSERT INTO "servers" VALUES (1022,144,'irc.powerchat.org',6762);
INSERT INTO "servers" VALUES (1023,144,'irc.powerchat.org',6763);
INSERT INTO "servers" VALUES (1024,144,'irc.powerchat.org',6764);
INSERT INTO "servers" VALUES (1025,144,'irc.powerchat.org',6765);
INSERT INTO "servers" VALUES (1026,144,'irc.powerchat.org',6766);
INSERT INTO "servers" VALUES (1027,144,'irc.powerchat.org',6767);
INSERT INTO "servers" VALUES (1028,144,'irc.powerchat.org',6768);
INSERT INTO "servers" VALUES (1029,144,'irc.powerchat.org',6769);
INSERT INTO "servers" VALUES (1030,144,'irc.powerchat.org',6770);
INSERT INTO "servers" VALUES (1031,144,'irc.powerchat.org',6771);
INSERT INTO "servers" VALUES (1032,144,'irc.powerchat.org',6772);
INSERT INTO "servers" VALUES (1033,144,'irc.powerchat.org',6773);
INSERT INTO "servers" VALUES (1034,144,'irc.powerchat.org',6774);
INSERT INTO "servers" VALUES (1035,144,'irc.powerchat.org',6775);
INSERT INTO "servers" VALUES (1036,144,'irc.powerchat.org',6776);
INSERT INTO "servers" VALUES (1037,144,'irc.powerchat.org',6777);
INSERT INTO "servers" VALUES (1038,144,'irc.powerchat.org',6778);
INSERT INTO "servers" VALUES (1039,144,'irc.powerchat.org',6779);
INSERT INTO "servers" VALUES (1040,144,'irc.powerchat.org',6780);
INSERT INTO "servers" VALUES (1041,144,'irc.powerchat.org',6781);
INSERT INTO "servers" VALUES (1042,144,'irc.powerchat.org',6782);
INSERT INTO "servers" VALUES (1043,144,'irc.powerchat.org',6783);
INSERT INTO "servers" VALUES (1044,144,'irc.powerchat.org',6784);
INSERT INTO "servers" VALUES (1045,144,'irc.powerchat.org',6785);
INSERT INTO "servers" VALUES (1046,144,'irc.powerchat.org',6786);
INSERT INTO "servers" VALUES (1047,144,'irc.powerchat.org',6787);
INSERT INTO "servers" VALUES (1048,144,'irc.powerchat.org',6788);
INSERT INTO "servers" VALUES (1049,144,'irc.powerchat.org',6789);
INSERT INTO "servers" VALUES (1050,144,'irc.powerchat.org',6790);
INSERT INTO "servers" VALUES (1051,144,'irc.powerchat.org',6791);
INSERT INTO "servers" VALUES (1052,144,'irc.powerchat.org',6792);
INSERT INTO "servers" VALUES (1053,144,'irc.powerchat.org',6793);
INSERT INTO "servers" VALUES (1054,144,'irc.powerchat.org',6794);
INSERT INTO "servers" VALUES (1055,144,'irc.powerchat.org',6795);
INSERT INTO "servers" VALUES (1056,144,'irc.powerchat.org',6796);
INSERT INTO "servers" VALUES (1057,144,'irc.powerchat.org',6797);
INSERT INTO "servers" VALUES (1058,144,'irc.powerchat.org',6798);
INSERT INTO "servers" VALUES (1059,144,'irc.powerchat.org',6799);
INSERT INTO "servers" VALUES (1060,144,'irc.powerchat.org',6800);
INSERT INTO "servers" VALUES (1061,144,'irc.powerchat.org',6801);
INSERT INTO "servers" VALUES (1062,144,'irc.powerchat.org',6802);
INSERT INTO "servers" VALUES (1063,144,'irc.powerchat.org',6803);
INSERT INTO "servers" VALUES (1064,144,'irc.powerchat.org',6804);
INSERT INTO "servers" VALUES (1065,144,'irc.powerchat.org',6805);
INSERT INTO "servers" VALUES (1066,144,'irc.powerchat.org',6806);
INSERT INTO "servers" VALUES (1067,144,'irc.powerchat.org',6807);
INSERT INTO "servers" VALUES (1068,144,'irc.powerchat.org',6808);
INSERT INTO "servers" VALUES (1069,144,'irc.powerchat.org',6809);
INSERT INTO "servers" VALUES (1070,144,'irc.powerchat.org',6810);
INSERT INTO "servers" VALUES (1071,144,'irc.powerchat.org',6811);
INSERT INTO "servers" VALUES (1072,144,'irc.powerchat.org',6812);
INSERT INTO "servers" VALUES (1073,144,'irc.powerchat.org',6813);
INSERT INTO "servers" VALUES (1074,144,'irc.powerchat.org',6814);
INSERT INTO "servers" VALUES (1075,144,'irc.powerchat.org',6815);
INSERT INTO "servers" VALUES (1076,144,'irc.powerchat.org',6816);
INSERT INTO "servers" VALUES (1077,144,'irc.powerchat.org',6817);
INSERT INTO "servers" VALUES (1078,144,'irc.powerchat.org',6818);
INSERT INTO "servers" VALUES (1079,144,'irc.powerchat.org',6819);
INSERT INTO "servers" VALUES (1080,144,'irc.powerchat.org',6820);
INSERT INTO "servers" VALUES (1081,144,'irc.powerchat.org',6821);
INSERT INTO "servers" VALUES (1082,144,'irc.powerchat.org',6822);
INSERT INTO "servers" VALUES (1083,144,'irc.powerchat.org',6823);
INSERT INTO "servers" VALUES (1084,144,'irc.powerchat.org',6824);
INSERT INTO "servers" VALUES (1085,144,'irc.powerchat.org',6825);
INSERT INTO "servers" VALUES (1086,144,'irc.powerchat.org',6826);
INSERT INTO "servers" VALUES (1087,144,'irc.powerchat.org',6827);
INSERT INTO "servers" VALUES (1088,144,'irc.powerchat.org',6828);
INSERT INTO "servers" VALUES (1089,144,'irc.powerchat.org',6829);
INSERT INTO "servers" VALUES (1090,144,'irc.powerchat.org',6830);
INSERT INTO "servers" VALUES (1091,144,'irc.powerchat.org',6831);
INSERT INTO "servers" VALUES (1092,144,'irc.powerchat.org',6832);
INSERT INTO "servers" VALUES (1093,144,'irc.powerchat.org',6833);
INSERT INTO "servers" VALUES (1094,144,'irc.powerchat.org',6834);
INSERT INTO "servers" VALUES (1095,144,'irc.powerchat.org',6835);
INSERT INTO "servers" VALUES (1096,144,'irc.powerchat.org',6836);
INSERT INTO "servers" VALUES (1097,144,'irc.powerchat.org',6837);
INSERT INTO "servers" VALUES (1098,144,'irc.powerchat.org',6838);
INSERT INTO "servers" VALUES (1099,144,'irc.powerchat.org',6839);
INSERT INTO "servers" VALUES (1100,144,'irc.powerchat.org',6840);
INSERT INTO "servers" VALUES (1101,144,'irc.powerchat.org',6841);
INSERT INTO "servers" VALUES (1102,144,'irc.powerchat.org',6842);
INSERT INTO "servers" VALUES (1103,144,'irc.powerchat.org',6843);
INSERT INTO "servers" VALUES (1104,144,'irc.powerchat.org',6844);
INSERT INTO "servers" VALUES (1105,144,'irc.powerchat.org',6845);
INSERT INTO "servers" VALUES (1106,144,'irc.powerchat.org',6846);
INSERT INTO "servers" VALUES (1107,144,'irc.powerchat.org',6847);
INSERT INTO "servers" VALUES (1108,144,'irc.powerchat.org',6848);
INSERT INTO "servers" VALUES (1109,144,'irc.powerchat.org',6849);
INSERT INTO "servers" VALUES (1110,144,'irc.powerchat.org',6850);
INSERT INTO "servers" VALUES (1111,144,'irc.powerchat.org',6851);
INSERT INTO "servers" VALUES (1112,144,'irc.powerchat.org',6852);
INSERT INTO "servers" VALUES (1113,144,'irc.powerchat.org',6853);
INSERT INTO "servers" VALUES (1114,144,'irc.powerchat.org',6854);
INSERT INTO "servers" VALUES (1115,144,'irc.powerchat.org',6855);
INSERT INTO "servers" VALUES (1116,144,'irc.powerchat.org',6856);
INSERT INTO "servers" VALUES (1117,144,'irc.powerchat.org',6857);
INSERT INTO "servers" VALUES (1118,144,'irc.powerchat.org',6858);
INSERT INTO "servers" VALUES (1119,144,'irc.powerchat.org',6859);
INSERT INTO "servers" VALUES (1120,144,'irc.powerchat.org',6860);
INSERT INTO "servers" VALUES (1121,144,'irc.powerchat.org',6861);
INSERT INTO "servers" VALUES (1122,144,'irc.powerchat.org',6862);
INSERT INTO "servers" VALUES (1123,144,'irc.powerchat.org',6863);
INSERT INTO "servers" VALUES (1124,144,'irc.powerchat.org',6864);
INSERT INTO "servers" VALUES (1125,144,'irc.powerchat.org',6865);
INSERT INTO "servers" VALUES (1126,144,'irc.powerchat.org',6866);
INSERT INTO "servers" VALUES (1127,144,'irc.powerchat.org',6867);
INSERT INTO "servers" VALUES (1128,144,'irc.powerchat.org',6868);
INSERT INTO "servers" VALUES (1129,144,'irc.powerchat.org',6869);
INSERT INTO "servers" VALUES (1130,144,'irc.powerchat.org',6870);
INSERT INTO "servers" VALUES (1131,144,'irc.powerchat.org',6871);
INSERT INTO "servers" VALUES (1132,144,'irc.powerchat.org',6872);
INSERT INTO "servers" VALUES (1133,144,'irc.powerchat.org',6873);
INSERT INTO "servers" VALUES (1134,144,'irc.powerchat.org',6874);
INSERT INTO "servers" VALUES (1135,144,'irc.powerchat.org',6875);
INSERT INTO "servers" VALUES (1136,144,'irc.powerchat.org',6876);
INSERT INTO "servers" VALUES (1137,144,'irc.powerchat.org',6877);
INSERT INTO "servers" VALUES (1138,144,'irc.powerchat.org',6878);
INSERT INTO "servers" VALUES (1139,144,'irc.powerchat.org',6879);
INSERT INTO "servers" VALUES (1140,144,'irc.powerchat.org',6880);
INSERT INTO "servers" VALUES (1141,144,'irc.powerchat.org',6881);
INSERT INTO "servers" VALUES (1142,144,'irc.powerchat.org',6882);
INSERT INTO "servers" VALUES (1143,144,'irc.powerchat.org',6883);
INSERT INTO "servers" VALUES (1144,144,'irc.powerchat.org',6884);
INSERT INTO "servers" VALUES (1145,144,'irc.powerchat.org',6885);
INSERT INTO "servers" VALUES (1146,144,'irc.powerchat.org',6886);
INSERT INTO "servers" VALUES (1147,144,'irc.powerchat.org',6887);
INSERT INTO "servers" VALUES (1148,144,'irc.powerchat.org',6888);
INSERT INTO "servers" VALUES (1149,144,'irc.powerchat.org',6889);
INSERT INTO "servers" VALUES (1150,144,'irc.powerchat.org',6890);
INSERT INTO "servers" VALUES (1151,144,'irc.powerchat.org',6891);
INSERT INTO "servers" VALUES (1152,144,'irc.powerchat.org',6892);
INSERT INTO "servers" VALUES (1153,144,'irc.powerchat.org',6893);
INSERT INTO "servers" VALUES (1154,144,'irc.powerchat.org',6894);
INSERT INTO "servers" VALUES (1155,144,'irc.powerchat.org',6895);
INSERT INTO "servers" VALUES (1156,144,'irc.powerchat.org',6896);
INSERT INTO "servers" VALUES (1157,144,'irc.powerchat.org',6897);
INSERT INTO "servers" VALUES (1158,144,'irc.powerchat.org',6898);
INSERT INTO "servers" VALUES (1159,144,'irc.powerchat.org',6899);
INSERT INTO "servers" VALUES (1160,144,'irc.powerchat.org',6900);
INSERT INTO "servers" VALUES (1161,144,'irc.powerchat.org',6901);
INSERT INTO "servers" VALUES (1162,144,'irc.powerchat.org',6902);
INSERT INTO "servers" VALUES (1163,144,'irc.powerchat.org',6903);
INSERT INTO "servers" VALUES (1164,144,'irc.powerchat.org',6904);
INSERT INTO "servers" VALUES (1165,144,'irc.powerchat.org',6905);
INSERT INTO "servers" VALUES (1166,144,'irc.powerchat.org',6906);
INSERT INTO "servers" VALUES (1167,144,'irc.powerchat.org',6907);
INSERT INTO "servers" VALUES (1168,144,'irc.powerchat.org',6908);
INSERT INTO "servers" VALUES (1169,144,'irc.powerchat.org',6909);
INSERT INTO "servers" VALUES (1170,144,'irc.powerchat.org',6910);
INSERT INTO "servers" VALUES (1171,144,'irc.powerchat.org',6911);
INSERT INTO "servers" VALUES (1172,144,'irc.powerchat.org',6912);
INSERT INTO "servers" VALUES (1173,144,'irc.powerchat.org',6913);
INSERT INTO "servers" VALUES (1174,144,'irc.powerchat.org',6914);
INSERT INTO "servers" VALUES (1175,144,'irc.powerchat.org',6915);
INSERT INTO "servers" VALUES (1176,144,'irc.powerchat.org',6916);
INSERT INTO "servers" VALUES (1177,144,'irc.powerchat.org',6917);
INSERT INTO "servers" VALUES (1178,144,'irc.powerchat.org',6918);
INSERT INTO "servers" VALUES (1179,144,'irc.powerchat.org',6919);
INSERT INTO "servers" VALUES (1180,144,'irc.powerchat.org',6920);
INSERT INTO "servers" VALUES (1181,144,'irc.powerchat.org',6921);
INSERT INTO "servers" VALUES (1182,144,'irc.powerchat.org',6922);
INSERT INTO "servers" VALUES (1183,144,'irc.powerchat.org',6923);
INSERT INTO "servers" VALUES (1184,144,'irc.powerchat.org',6924);
INSERT INTO "servers" VALUES (1185,144,'irc.powerchat.org',6925);
INSERT INTO "servers" VALUES (1186,144,'irc.powerchat.org',6926);
INSERT INTO "servers" VALUES (1187,144,'irc.powerchat.org',6927);
INSERT INTO "servers" VALUES (1188,144,'irc.powerchat.org',6928);
INSERT INTO "servers" VALUES (1189,144,'irc.powerchat.org',6929);
INSERT INTO "servers" VALUES (1190,144,'irc.powerchat.org',6930);
INSERT INTO "servers" VALUES (1191,144,'irc.powerchat.org',6931);
INSERT INTO "servers" VALUES (1192,144,'irc.powerchat.org',6932);
INSERT INTO "servers" VALUES (1193,144,'irc.powerchat.org',6933);
INSERT INTO "servers" VALUES (1194,144,'irc.powerchat.org',6934);
INSERT INTO "servers" VALUES (1195,144,'irc.powerchat.org',6935);
INSERT INTO "servers" VALUES (1196,144,'irc.powerchat.org',6936);
INSERT INTO "servers" VALUES (1197,144,'irc.powerchat.org',6937);
INSERT INTO "servers" VALUES (1198,144,'irc.powerchat.org',6938);
INSERT INTO "servers" VALUES (1199,144,'irc.powerchat.org',6939);
INSERT INTO "servers" VALUES (1200,144,'irc.powerchat.org',6940);
INSERT INTO "servers" VALUES (1201,144,'irc.powerchat.org',6941);
INSERT INTO "servers" VALUES (1202,144,'irc.powerchat.org',6942);
INSERT INTO "servers" VALUES (1203,144,'irc.powerchat.org',6943);
INSERT INTO "servers" VALUES (1204,144,'irc.powerchat.org',6944);
INSERT INTO "servers" VALUES (1205,144,'irc.powerchat.org',6945);
INSERT INTO "servers" VALUES (1206,144,'irc.powerchat.org',6946);
INSERT INTO "servers" VALUES (1207,144,'irc.powerchat.org',6947);
INSERT INTO "servers" VALUES (1208,144,'irc.powerchat.org',6948);
INSERT INTO "servers" VALUES (1209,144,'irc.powerchat.org',6949);
INSERT INTO "servers" VALUES (1210,144,'irc.powerchat.org',6950);
INSERT INTO "servers" VALUES (1211,144,'irc.powerchat.org',6951);
INSERT INTO "servers" VALUES (1212,144,'irc.powerchat.org',6952);
INSERT INTO "servers" VALUES (1213,144,'irc.powerchat.org',6953);
INSERT INTO "servers" VALUES (1214,144,'irc.powerchat.org',6954);
INSERT INTO "servers" VALUES (1215,144,'irc.powerchat.org',6955);
INSERT INTO "servers" VALUES (1216,144,'irc.powerchat.org',6956);
INSERT INTO "servers" VALUES (1217,144,'irc.powerchat.org',6957);
INSERT INTO "servers" VALUES (1218,144,'irc.powerchat.org',6958);
INSERT INTO "servers" VALUES (1219,144,'irc.powerchat.org',6959);
INSERT INTO "servers" VALUES (1220,144,'irc.powerchat.org',6960);
INSERT INTO "servers" VALUES (1221,144,'irc.powerchat.org',6961);
INSERT INTO "servers" VALUES (1222,144,'irc.powerchat.org',6962);
INSERT INTO "servers" VALUES (1223,144,'irc.powerchat.org',6963);
INSERT INTO "servers" VALUES (1224,144,'irc.powerchat.org',6964);
INSERT INTO "servers" VALUES (1225,144,'irc.powerchat.org',6965);
INSERT INTO "servers" VALUES (1226,144,'irc.powerchat.org',6966);
INSERT INTO "servers" VALUES (1227,144,'irc.powerchat.org',6967);
INSERT INTO "servers" VALUES (1228,144,'irc.powerchat.org',6968);
INSERT INTO "servers" VALUES (1229,144,'irc.powerchat.org',6969);
INSERT INTO "servers" VALUES (1230,144,'irc.powerchat.org',6970);
INSERT INTO "servers" VALUES (1231,144,'irc.powerchat.org',6971);
INSERT INTO "servers" VALUES (1232,144,'irc.powerchat.org',6972);
INSERT INTO "servers" VALUES (1233,144,'irc.powerchat.org',6973);
INSERT INTO "servers" VALUES (1234,144,'irc.powerchat.org',6974);
INSERT INTO "servers" VALUES (1235,144,'irc.powerchat.org',6975);
INSERT INTO "servers" VALUES (1236,144,'irc.powerchat.org',6976);
INSERT INTO "servers" VALUES (1237,144,'irc.powerchat.org',6977);
INSERT INTO "servers" VALUES (1238,144,'irc.powerchat.org',6978);
INSERT INTO "servers" VALUES (1239,144,'irc.powerchat.org',6979);
INSERT INTO "servers" VALUES (1240,144,'irc.powerchat.org',6980);
INSERT INTO "servers" VALUES (1241,144,'irc.powerchat.org',6981);
INSERT INTO "servers" VALUES (1242,144,'irc.powerchat.org',6982);
INSERT INTO "servers" VALUES (1243,144,'irc.powerchat.org',6983);
INSERT INTO "servers" VALUES (1244,144,'irc.powerchat.org',6984);
INSERT INTO "servers" VALUES (1245,144,'irc.powerchat.org',6985);
INSERT INTO "servers" VALUES (1246,144,'irc.powerchat.org',6986);
INSERT INTO "servers" VALUES (1247,144,'irc.powerchat.org',6987);
INSERT INTO "servers" VALUES (1248,144,'irc.powerchat.org',6988);
INSERT INTO "servers" VALUES (1249,144,'irc.powerchat.org',6989);
INSERT INTO "servers" VALUES (1250,144,'irc.powerchat.org',6990);
INSERT INTO "servers" VALUES (1251,144,'irc.powerchat.org',6991);
INSERT INTO "servers" VALUES (1252,144,'irc.powerchat.org',6992);
INSERT INTO "servers" VALUES (1253,144,'irc.powerchat.org',6993);
INSERT INTO "servers" VALUES (1254,144,'irc.powerchat.org',6994);
INSERT INTO "servers" VALUES (1255,144,'irc.powerchat.org',6995);
INSERT INTO "servers" VALUES (1256,144,'irc.powerchat.org',6996);
INSERT INTO "servers" VALUES (1257,144,'irc.powerchat.org',6997);
INSERT INTO "servers" VALUES (1258,144,'irc.powerchat.org',6998);
INSERT INTO "servers" VALUES (1259,144,'irc.powerchat.org',6999);
INSERT INTO "servers" VALUES (1260,144,'irc.powerchat.org',7000);
INSERT INTO "servers" VALUES (1261,145,'irc.pseudonet.org',6667);
INSERT INTO "servers" VALUES (1262,146,'irc.ptlink.net',6667);
INSERT INTO "servers" VALUES (1263,147,'ualg.ptnet.org',6667);
INSERT INTO "servers" VALUES (1264,147,'telepac2.ptnet.org',6667);
INSERT INTO "servers" VALUES (1265,148,'irc.qchat.net',6667);
INSERT INTO "servers" VALUES (1266,149,'irc.quakenet.eu.org',6667);
INSERT INTO "servers" VALUES (1267,149,'irc.quakenet.eu.org',6668);
INSERT INTO "servers" VALUES (1268,149,'irc.quakenet.eu.org',6669);
INSERT INTO "servers" VALUES (1269,150,'irc.rapta.net',6667);
INSERT INTO "servers" VALUES (1270,151,'irc.raptornet.org',6667);
INSERT INTO "servers" VALUES (1271,152,'irc.red-latina.org',6667);
INSERT INTO "servers" VALUES (1272,152,'irc.dalsom.net',6666);
INSERT INTO "servers" VALUES (1273,152,'irc.dalsom.net',6667);
INSERT INTO "servers" VALUES (1274,153,'irc.persocom.com.br',6668);
INSERT INTO "servers" VALUES (1275,153,'irc.persocom.com.br',6669);
INSERT INTO "servers" VALUES (1276,153,'irc.persocom.com.br',7000);
INSERT INTO "servers" VALUES (1277,153,'irc.persocom.com.br',7001);
INSERT INTO "servers" VALUES (1278,153,'irc.persocom.com.br',7002);
INSERT INTO "servers" VALUES (1279,153,'irc.netstage.com.br',6668);
INSERT INTO "servers" VALUES (1280,153,'irc.netstage.com.br',6669);
INSERT INTO "servers" VALUES (1281,153,'irc.netstage.com.br',7000);
INSERT INTO "servers" VALUES (1282,153,'irc.netstage.com.br',7001);
INSERT INTO "servers" VALUES (1283,153,'irc.netstage.com.br',7002);
INSERT INTO "servers" VALUES (1284,153,'irc.elogica.com.br',6668);
INSERT INTO "servers" VALUES (1285,153,'irc.elogica.com.br',6669);
INSERT INTO "servers" VALUES (1286,153,'irc.elogica.com.br',7000);
INSERT INTO "servers" VALUES (1287,153,'irc.elogica.com.br',7001);
INSERT INTO "servers" VALUES (1288,153,'irc.elogica.com.br',7002);
INSERT INTO "servers" VALUES (1289,154,'irc.wnet.com.br',6667);
INSERT INTO "servers" VALUES (1290,154,'irc.braznet.com.br',6667);
INSERT INTO "servers" VALUES (1291,154,'irc.braznet.com.br',9001);
INSERT INTO "servers" VALUES (1292,155,'irc.redlatona.net',6667);
INSERT INTO "servers" VALUES (1293,155,'irc.redlatona.net',6668);
INSERT INTO "servers" VALUES (1294,156,'irc.rekor.net',6661);
INSERT INTO "servers" VALUES (1295,156,'irc.rekor.net',6662);
INSERT INTO "servers" VALUES (1296,156,'irc.rekor.net',6663);
INSERT INTO "servers" VALUES (1297,156,'irc.rekor.net',6664);
INSERT INTO "servers" VALUES (1298,156,'irc.rekor.net',6665);
INSERT INTO "servers" VALUES (1299,156,'irc.rekor.net',6666);
INSERT INTO "servers" VALUES (1300,156,'irc.rekor.net',6667);
INSERT INTO "servers" VALUES (1301,156,'irc.rekor.net',6668);
INSERT INTO "servers" VALUES (1302,156,'irc.rekor.net',6669);
INSERT INTO "servers" VALUES (1303,157,'irc.relic.net',6667);
INSERT INTO "servers" VALUES (1304,157,'cyclone.us.relic.net',6661);
INSERT INTO "servers" VALUES (1305,157,'cyclone.us.relic.net',6662);
INSERT INTO "servers" VALUES (1306,157,'cyclone.us.relic.net',6663);
INSERT INTO "servers" VALUES (1307,157,'cyclone.us.relic.net',6664);
INSERT INTO "servers" VALUES (1308,157,'cyclone.us.relic.net',6665);
INSERT INTO "servers" VALUES (1309,158,'irc.risanet.com',6667);
INSERT INTO "servers" VALUES (1310,158,'irc.risanet.com',6668);
INSERT INTO "servers" VALUES (1311,158,'irc.risanet.com',6669);
INSERT INTO "servers" VALUES (1312,159,'irc.tsk.ru',6667);
INSERT INTO "servers" VALUES (1313,159,'irc.tsk.ru',6668);
INSERT INTO "servers" VALUES (1314,159,'irc.tsk.ru',6669);
INSERT INTO "servers" VALUES (1315,159,'irc.tsk.ru',7770);
INSERT INTO "servers" VALUES (1316,159,'irc.tsk.ru',7771);
INSERT INTO "servers" VALUES (1317,159,'irc.tsk.ru',7772);
INSERT INTO "servers" VALUES (1318,159,'irc.tsk.ru',7773);
INSERT INTO "servers" VALUES (1319,159,'irc.tsk.ru',7774);
INSERT INTO "servers" VALUES (1320,159,'irc.tsk.ru',7775);
INSERT INTO "servers" VALUES (1321,159,'irc.vladivostok.ru',6667);
INSERT INTO "servers" VALUES (1322,159,'irc.vladivostok.ru',6668);
INSERT INTO "servers" VALUES (1323,159,'irc.vladivostok.ru',6669);
INSERT INTO "servers" VALUES (1324,159,'irc.vladivostok.ru',7770);
INSERT INTO "servers" VALUES (1325,159,'irc.vladivostok.ru',7771);
INSERT INTO "servers" VALUES (1326,159,'irc.vladivostok.ru',7772);
INSERT INTO "servers" VALUES (1327,159,'irc.vladivostok.ru',7773);
INSERT INTO "servers" VALUES (1328,159,'irc.vladivostok.ru',7774);
INSERT INTO "servers" VALUES (1329,159,'irc.vladivostok.ru',7775);
INSERT INTO "servers" VALUES (1330,159,'irc.kar.net',6667);
INSERT INTO "servers" VALUES (1331,159,'irc.kar.net',6668);
INSERT INTO "servers" VALUES (1332,159,'irc.kar.net',6669);
INSERT INTO "servers" VALUES (1333,159,'irc.kar.net',7770);
INSERT INTO "servers" VALUES (1334,159,'irc.kar.net',7771);
INSERT INTO "servers" VALUES (1335,159,'irc.kar.net',7772);
INSERT INTO "servers" VALUES (1336,159,'irc.kar.net',7773);
INSERT INTO "servers" VALUES (1337,159,'irc.kar.net',7774);
INSERT INTO "servers" VALUES (1338,159,'irc.kar.net',7775);
INSERT INTO "servers" VALUES (1339,160,'irc.samshark.com',6667);
INSERT INTO "servers" VALUES (1340,161,'irc.sandnet.net',6660);
INSERT INTO "servers" VALUES (1341,161,'irc.sandnet.net',6661);
INSERT INTO "servers" VALUES (1342,161,'irc.sandnet.net',6662);
INSERT INTO "servers" VALUES (1343,161,'irc.sandnet.net',6663);
INSERT INTO "servers" VALUES (1344,161,'irc.sandnet.net',6664);
INSERT INTO "servers" VALUES (1345,161,'irc.sandnet.net',6665);
INSERT INTO "servers" VALUES (1346,161,'irc.sandnet.net',6666);
INSERT INTO "servers" VALUES (1347,161,'irc.sandnet.net',6667);
INSERT INTO "servers" VALUES (1348,161,'irc.sandnet.net',6668);
INSERT INTO "servers" VALUES (1349,161,'irc.sandnet.net',6669);
INSERT INTO "servers" VALUES (1350,161,'mystic.tides.sandnet.net',6660);
INSERT INTO "servers" VALUES (1351,161,'mystic.tides.sandnet.net',6661);
INSERT INTO "servers" VALUES (1352,161,'mystic.tides.sandnet.net',6662);
INSERT INTO "servers" VALUES (1353,161,'mystic.tides.sandnet.net',6663);
INSERT INTO "servers" VALUES (1354,161,'mystic.tides.sandnet.net',6664);
INSERT INTO "servers" VALUES (1355,161,'mystic.tides.sandnet.net',6665);
INSERT INTO "servers" VALUES (1356,161,'mystic.tides.sandnet.net',6666);
INSERT INTO "servers" VALUES (1357,161,'mystic.tides.sandnet.net',6667);
INSERT INTO "servers" VALUES (1358,161,'mystic.tides.sandnet.net',6668);
INSERT INTO "servers" VALUES (1359,161,'mystic.tides.sandnet.net',6669);
INSERT INTO "servers" VALUES (1360,161,'dunebuggy.nj.sandnet.net',6660);
INSERT INTO "servers" VALUES (1361,161,'dunebuggy.nj.sandnet.net',6661);
INSERT INTO "servers" VALUES (1362,161,'dunebuggy.nj.sandnet.net',6662);
INSERT INTO "servers" VALUES (1363,161,'dunebuggy.nj.sandnet.net',6663);
INSERT INTO "servers" VALUES (1364,161,'dunebuggy.nj.sandnet.net',6664);
INSERT INTO "servers" VALUES (1365,161,'dunebuggy.nj.sandnet.net',6665);
INSERT INTO "servers" VALUES (1366,161,'dunebuggy.nj.sandnet.net',6666);
INSERT INTO "servers" VALUES (1367,161,'dunebuggy.nj.sandnet.net',6667);
INSERT INTO "servers" VALUES (1368,161,'dunebuggy.nj.sandnet.net',6668);
INSERT INTO "servers" VALUES (1369,161,'dunebuggy.nj.sandnet.net',6669);
INSERT INTO "servers" VALUES (1370,162,'irc.seveneagle.net',6667);
INSERT INTO "servers" VALUES (1371,163,'irc.sexnet.org',6667);
INSERT INTO "servers" VALUES (1372,164,'irc.sgnet.org',6660);
INSERT INTO "servers" VALUES (1373,164,'irc.sgnet.org',6661);
INSERT INTO "servers" VALUES (1374,164,'irc.sgnet.org',6662);
INSERT INTO "servers" VALUES (1375,164,'irc.sgnet.org',6663);
INSERT INTO "servers" VALUES (1376,164,'irc.sgnet.org',6664);
INSERT INTO "servers" VALUES (1377,164,'irc.sgnet.org',6665);
INSERT INTO "servers" VALUES (1378,164,'irc.sgnet.org',6666);
INSERT INTO "servers" VALUES (1379,164,'irc.sgnet.org',6667);
INSERT INTO "servers" VALUES (1380,164,'irc.sgnet.org',6668);
INSERT INTO "servers" VALUES (1381,164,'irc.sgnet.org',6669);
INSERT INTO "servers" VALUES (1382,165,'irc.shadowfire.org',6667);
INSERT INTO "servers" VALUES (1383,166,'irc.shadowworld.net',6667);
INSERT INTO "servers" VALUES (1384,167,'irc.sidenet.org',6660);
INSERT INTO "servers" VALUES (1385,167,'irc.sidenet.org',6661);
INSERT INTO "servers" VALUES (1386,167,'irc.sidenet.org',6662);
INSERT INTO "servers" VALUES (1387,167,'irc.sidenet.org',6663);
INSERT INTO "servers" VALUES (1388,167,'irc.sidenet.org',6664);
INSERT INTO "servers" VALUES (1389,167,'irc.sidenet.org',6665);
INSERT INTO "servers" VALUES (1390,167,'irc.sidenet.org',6666);
INSERT INTO "servers" VALUES (1391,167,'irc.sidenet.org',6667);
INSERT INTO "servers" VALUES (1392,167,'irc.sidenet.org',6668);
INSERT INTO "servers" VALUES (1393,167,'irc.sidenet.org',6669);
INSERT INTO "servers" VALUES (1394,167,'irc.sidenet.org',6670);
INSERT INTO "servers" VALUES (1395,167,'irc.sidenet.org',6671);
INSERT INTO "servers" VALUES (1396,167,'irc.sidenet.org',6672);
INSERT INTO "servers" VALUES (1397,167,'irc.sidenet.org',6673);
INSERT INTO "servers" VALUES (1398,167,'irc.sidenet.org',6674);
INSERT INTO "servers" VALUES (1399,167,'irc.sidenet.org',6675);
INSERT INTO "servers" VALUES (1400,167,'irc.sidenet.org',6676);
INSERT INTO "servers" VALUES (1401,167,'irc.sidenet.org',6677);
INSERT INTO "servers" VALUES (1402,167,'irc.sidenet.org',6678);
INSERT INTO "servers" VALUES (1403,167,'irc.sidenet.org',6679);
INSERT INTO "servers" VALUES (1404,167,'irc.sidenet.org',6680);
INSERT INTO "servers" VALUES (1405,167,'irc.sidenet.org',6681);
INSERT INTO "servers" VALUES (1406,167,'irc.sidenet.org',6682);
INSERT INTO "servers" VALUES (1407,167,'irc.sidenet.org',6683);
INSERT INTO "servers" VALUES (1408,167,'irc.sidenet.org',6684);
INSERT INTO "servers" VALUES (1409,167,'irc.sidenet.org',6685);
INSERT INTO "servers" VALUES (1410,167,'irc.sidenet.org',6686);
INSERT INTO "servers" VALUES (1411,167,'irc.sidenet.org',6687);
INSERT INTO "servers" VALUES (1412,167,'irc.sidenet.org',6688);
INSERT INTO "servers" VALUES (1413,167,'irc.sidenet.org',6689);
INSERT INTO "servers" VALUES (1414,167,'irc.sidenet.org',6690);
INSERT INTO "servers" VALUES (1415,167,'irc.sidenet.org',6691);
INSERT INTO "servers" VALUES (1416,167,'irc.sidenet.org',6692);
INSERT INTO "servers" VALUES (1417,167,'irc.sidenet.org',6693);
INSERT INTO "servers" VALUES (1418,167,'irc.sidenet.org',6694);
INSERT INTO "servers" VALUES (1419,167,'irc.sidenet.org',6695);
INSERT INTO "servers" VALUES (1420,167,'irc.sidenet.org',6696);
INSERT INTO "servers" VALUES (1421,167,'irc.sidenet.org',6697);
INSERT INTO "servers" VALUES (1422,167,'irc.sidenet.org',6698);
INSERT INTO "servers" VALUES (1423,167,'irc.sidenet.org',6699);
INSERT INTO "servers" VALUES (1424,167,'irc.sidenet.org',6700);
INSERT INTO "servers" VALUES (1425,167,'irc.sidenet.org',6701);
INSERT INTO "servers" VALUES (1426,167,'irc.sidenet.org',6702);
INSERT INTO "servers" VALUES (1427,167,'irc.sidenet.org',6703);
INSERT INTO "servers" VALUES (1428,167,'irc.sidenet.org',6704);
INSERT INTO "servers" VALUES (1429,167,'irc.sidenet.org',6705);
INSERT INTO "servers" VALUES (1430,167,'irc.sidenet.org',6706);
INSERT INTO "servers" VALUES (1431,167,'irc.sidenet.org',6707);
INSERT INTO "servers" VALUES (1432,167,'irc.sidenet.org',6708);
INSERT INTO "servers" VALUES (1433,167,'irc.sidenet.org',6709);
INSERT INTO "servers" VALUES (1434,167,'irc.sidenet.org',6710);
INSERT INTO "servers" VALUES (1435,167,'irc.sidenet.org',6711);
INSERT INTO "servers" VALUES (1436,167,'irc.sidenet.org',6712);
INSERT INTO "servers" VALUES (1437,167,'irc.sidenet.org',6713);
INSERT INTO "servers" VALUES (1438,167,'irc.sidenet.org',6714);
INSERT INTO "servers" VALUES (1439,167,'irc.sidenet.org',6715);
INSERT INTO "servers" VALUES (1440,167,'irc.sidenet.org',6716);
INSERT INTO "servers" VALUES (1441,167,'irc.sidenet.org',6717);
INSERT INTO "servers" VALUES (1442,167,'irc.sidenet.org',6718);
INSERT INTO "servers" VALUES (1443,167,'irc.sidenet.org',6719);
INSERT INTO "servers" VALUES (1444,167,'irc.sidenet.org',6720);
INSERT INTO "servers" VALUES (1445,167,'irc.sidenet.org',6721);
INSERT INTO "servers" VALUES (1446,167,'irc.sidenet.org',6722);
INSERT INTO "servers" VALUES (1447,167,'irc.sidenet.org',6723);
INSERT INTO "servers" VALUES (1448,167,'irc.sidenet.org',6724);
INSERT INTO "servers" VALUES (1449,167,'irc.sidenet.org',6725);
INSERT INTO "servers" VALUES (1450,167,'irc.sidenet.org',6726);
INSERT INTO "servers" VALUES (1451,167,'irc.sidenet.org',6727);
INSERT INTO "servers" VALUES (1452,167,'irc.sidenet.org',6728);
INSERT INTO "servers" VALUES (1453,167,'irc.sidenet.org',6729);
INSERT INTO "servers" VALUES (1454,167,'irc.sidenet.org',6730);
INSERT INTO "servers" VALUES (1455,167,'irc.sidenet.org',6731);
INSERT INTO "servers" VALUES (1456,167,'irc.sidenet.org',6732);
INSERT INTO "servers" VALUES (1457,167,'irc.sidenet.org',6733);
INSERT INTO "servers" VALUES (1458,167,'irc.sidenet.org',6734);
INSERT INTO "servers" VALUES (1459,167,'irc.sidenet.org',6735);
INSERT INTO "servers" VALUES (1460,167,'irc.sidenet.org',6736);
INSERT INTO "servers" VALUES (1461,167,'irc.sidenet.org',6737);
INSERT INTO "servers" VALUES (1462,167,'irc.sidenet.org',6738);
INSERT INTO "servers" VALUES (1463,167,'irc.sidenet.org',6739);
INSERT INTO "servers" VALUES (1464,167,'irc.sidenet.org',6740);
INSERT INTO "servers" VALUES (1465,167,'irc.sidenet.org',6741);
INSERT INTO "servers" VALUES (1466,167,'irc.sidenet.org',6742);
INSERT INTO "servers" VALUES (1467,167,'irc.sidenet.org',6743);
INSERT INTO "servers" VALUES (1468,167,'irc.sidenet.org',6744);
INSERT INTO "servers" VALUES (1469,167,'irc.sidenet.org',6745);
INSERT INTO "servers" VALUES (1470,167,'irc.sidenet.org',6746);
INSERT INTO "servers" VALUES (1471,167,'irc.sidenet.org',6747);
INSERT INTO "servers" VALUES (1472,167,'irc.sidenet.org',6748);
INSERT INTO "servers" VALUES (1473,167,'irc.sidenet.org',6749);
INSERT INTO "servers" VALUES (1474,167,'irc.sidenet.org',6750);
INSERT INTO "servers" VALUES (1475,167,'irc.sidenet.org',6751);
INSERT INTO "servers" VALUES (1476,167,'irc.sidenet.org',6752);
INSERT INTO "servers" VALUES (1477,167,'irc.sidenet.org',6753);
INSERT INTO "servers" VALUES (1478,167,'irc.sidenet.org',6754);
INSERT INTO "servers" VALUES (1479,167,'irc.sidenet.org',6755);
INSERT INTO "servers" VALUES (1480,167,'irc.sidenet.org',6756);
INSERT INTO "servers" VALUES (1481,167,'irc.sidenet.org',6757);
INSERT INTO "servers" VALUES (1482,167,'irc.sidenet.org',6758);
INSERT INTO "servers" VALUES (1483,167,'irc.sidenet.org',6759);
INSERT INTO "servers" VALUES (1484,167,'irc.sidenet.org',6760);
INSERT INTO "servers" VALUES (1485,167,'irc.sidenet.org',6761);
INSERT INTO "servers" VALUES (1486,167,'irc.sidenet.org',6762);
INSERT INTO "servers" VALUES (1487,167,'irc.sidenet.org',6763);
INSERT INTO "servers" VALUES (1488,167,'irc.sidenet.org',6764);
INSERT INTO "servers" VALUES (1489,167,'irc.sidenet.org',6765);
INSERT INTO "servers" VALUES (1490,167,'irc.sidenet.org',6766);
INSERT INTO "servers" VALUES (1491,167,'irc.sidenet.org',6767);
INSERT INTO "servers" VALUES (1492,167,'irc.sidenet.org',6768);
INSERT INTO "servers" VALUES (1493,167,'irc.sidenet.org',6769);
INSERT INTO "servers" VALUES (1494,167,'irc.sidenet.org',6770);
INSERT INTO "servers" VALUES (1495,167,'irc.sidenet.org',6771);
INSERT INTO "servers" VALUES (1496,167,'irc.sidenet.org',6772);
INSERT INTO "servers" VALUES (1497,167,'irc.sidenet.org',6773);
INSERT INTO "servers" VALUES (1498,167,'irc.sidenet.org',6774);
INSERT INTO "servers" VALUES (1499,167,'irc.sidenet.org',6775);
INSERT INTO "servers" VALUES (1500,167,'irc.sidenet.org',6776);
INSERT INTO "servers" VALUES (1501,167,'irc.sidenet.org',6777);
INSERT INTO "servers" VALUES (1502,167,'irc.sidenet.org',6778);
INSERT INTO "servers" VALUES (1503,167,'irc.sidenet.org',6779);
INSERT INTO "servers" VALUES (1504,167,'irc.sidenet.org',6780);
INSERT INTO "servers" VALUES (1505,167,'irc.sidenet.org',6781);
INSERT INTO "servers" VALUES (1506,167,'irc.sidenet.org',6782);
INSERT INTO "servers" VALUES (1507,167,'irc.sidenet.org',6783);
INSERT INTO "servers" VALUES (1508,167,'irc.sidenet.org',6784);
INSERT INTO "servers" VALUES (1509,167,'irc.sidenet.org',6785);
INSERT INTO "servers" VALUES (1510,167,'irc.sidenet.org',6786);
INSERT INTO "servers" VALUES (1511,167,'irc.sidenet.org',6787);
INSERT INTO "servers" VALUES (1512,167,'irc.sidenet.org',6788);
INSERT INTO "servers" VALUES (1513,167,'irc.sidenet.org',6789);
INSERT INTO "servers" VALUES (1514,167,'irc.sidenet.org',6790);
INSERT INTO "servers" VALUES (1515,167,'irc.sidenet.org',6791);
INSERT INTO "servers" VALUES (1516,167,'irc.sidenet.org',6792);
INSERT INTO "servers" VALUES (1517,167,'irc.sidenet.org',6793);
INSERT INTO "servers" VALUES (1518,167,'irc.sidenet.org',6794);
INSERT INTO "servers" VALUES (1519,167,'irc.sidenet.org',6795);
INSERT INTO "servers" VALUES (1520,167,'irc.sidenet.org',6796);
INSERT INTO "servers" VALUES (1521,167,'irc.sidenet.org',6797);
INSERT INTO "servers" VALUES (1522,167,'irc.sidenet.org',6798);
INSERT INTO "servers" VALUES (1523,167,'irc.sidenet.org',6799);
INSERT INTO "servers" VALUES (1524,167,'irc.sidenet.org',6800);
INSERT INTO "servers" VALUES (1525,167,'irc.sidenet.org',6801);
INSERT INTO "servers" VALUES (1526,167,'irc.sidenet.org',6802);
INSERT INTO "servers" VALUES (1527,167,'irc.sidenet.org',6803);
INSERT INTO "servers" VALUES (1528,167,'irc.sidenet.org',6804);
INSERT INTO "servers" VALUES (1529,167,'irc.sidenet.org',6805);
INSERT INTO "servers" VALUES (1530,167,'irc.sidenet.org',6806);
INSERT INTO "servers" VALUES (1531,167,'irc.sidenet.org',6807);
INSERT INTO "servers" VALUES (1532,167,'irc.sidenet.org',6808);
INSERT INTO "servers" VALUES (1533,167,'irc.sidenet.org',6809);
INSERT INTO "servers" VALUES (1534,167,'irc.sidenet.org',6810);
INSERT INTO "servers" VALUES (1535,167,'irc.sidenet.org',6811);
INSERT INTO "servers" VALUES (1536,167,'irc.sidenet.org',6812);
INSERT INTO "servers" VALUES (1537,167,'irc.sidenet.org',6813);
INSERT INTO "servers" VALUES (1538,167,'irc.sidenet.org',6814);
INSERT INTO "servers" VALUES (1539,167,'irc.sidenet.org',6815);
INSERT INTO "servers" VALUES (1540,167,'irc.sidenet.org',6816);
INSERT INTO "servers" VALUES (1541,167,'irc.sidenet.org',6817);
INSERT INTO "servers" VALUES (1542,167,'irc.sidenet.org',6818);
INSERT INTO "servers" VALUES (1543,167,'irc.sidenet.org',6819);
INSERT INTO "servers" VALUES (1544,167,'irc.sidenet.org',6820);
INSERT INTO "servers" VALUES (1545,167,'irc.sidenet.org',6821);
INSERT INTO "servers" VALUES (1546,167,'irc.sidenet.org',6822);
INSERT INTO "servers" VALUES (1547,167,'irc.sidenet.org',6823);
INSERT INTO "servers" VALUES (1548,167,'irc.sidenet.org',6824);
INSERT INTO "servers" VALUES (1549,167,'irc.sidenet.org',6825);
INSERT INTO "servers" VALUES (1550,167,'irc.sidenet.org',6826);
INSERT INTO "servers" VALUES (1551,167,'irc.sidenet.org',6827);
INSERT INTO "servers" VALUES (1552,167,'irc.sidenet.org',6828);
INSERT INTO "servers" VALUES (1553,167,'irc.sidenet.org',6829);
INSERT INTO "servers" VALUES (1554,167,'irc.sidenet.org',6830);
INSERT INTO "servers" VALUES (1555,167,'irc.sidenet.org',6831);
INSERT INTO "servers" VALUES (1556,167,'irc.sidenet.org',6832);
INSERT INTO "servers" VALUES (1557,167,'irc.sidenet.org',6833);
INSERT INTO "servers" VALUES (1558,167,'irc.sidenet.org',6834);
INSERT INTO "servers" VALUES (1559,167,'irc.sidenet.org',6835);
INSERT INTO "servers" VALUES (1560,167,'irc.sidenet.org',6836);
INSERT INTO "servers" VALUES (1561,167,'irc.sidenet.org',6837);
INSERT INTO "servers" VALUES (1562,167,'irc.sidenet.org',6838);
INSERT INTO "servers" VALUES (1563,167,'irc.sidenet.org',6839);
INSERT INTO "servers" VALUES (1564,167,'irc.sidenet.org',6840);
INSERT INTO "servers" VALUES (1565,167,'irc.sidenet.org',6841);
INSERT INTO "servers" VALUES (1566,167,'irc.sidenet.org',6842);
INSERT INTO "servers" VALUES (1567,167,'irc.sidenet.org',6843);
INSERT INTO "servers" VALUES (1568,167,'irc.sidenet.org',6844);
INSERT INTO "servers" VALUES (1569,167,'irc.sidenet.org',6845);
INSERT INTO "servers" VALUES (1570,167,'irc.sidenet.org',6846);
INSERT INTO "servers" VALUES (1571,167,'irc.sidenet.org',6847);
INSERT INTO "servers" VALUES (1572,167,'irc.sidenet.org',6848);
INSERT INTO "servers" VALUES (1573,167,'irc.sidenet.org',6849);
INSERT INTO "servers" VALUES (1574,167,'irc.sidenet.org',6850);
INSERT INTO "servers" VALUES (1575,167,'irc.sidenet.org',6851);
INSERT INTO "servers" VALUES (1576,167,'irc.sidenet.org',6852);
INSERT INTO "servers" VALUES (1577,167,'irc.sidenet.org',6853);
INSERT INTO "servers" VALUES (1578,167,'irc.sidenet.org',6854);
INSERT INTO "servers" VALUES (1579,167,'irc.sidenet.org',6855);
INSERT INTO "servers" VALUES (1580,167,'irc.sidenet.org',6856);
INSERT INTO "servers" VALUES (1581,167,'irc.sidenet.org',6857);
INSERT INTO "servers" VALUES (1582,167,'irc.sidenet.org',6858);
INSERT INTO "servers" VALUES (1583,167,'irc.sidenet.org',6859);
INSERT INTO "servers" VALUES (1584,167,'irc.sidenet.org',6860);
INSERT INTO "servers" VALUES (1585,167,'irc.sidenet.org',6861);
INSERT INTO "servers" VALUES (1586,167,'irc.sidenet.org',6862);
INSERT INTO "servers" VALUES (1587,167,'irc.sidenet.org',6863);
INSERT INTO "servers" VALUES (1588,167,'irc.sidenet.org',6864);
INSERT INTO "servers" VALUES (1589,167,'irc.sidenet.org',6865);
INSERT INTO "servers" VALUES (1590,167,'irc.sidenet.org',6866);
INSERT INTO "servers" VALUES (1591,167,'irc.sidenet.org',6867);
INSERT INTO "servers" VALUES (1592,167,'irc.sidenet.org',6868);
INSERT INTO "servers" VALUES (1593,167,'irc.sidenet.org',6869);
INSERT INTO "servers" VALUES (1594,167,'irc.sidenet.org',6870);
INSERT INTO "servers" VALUES (1595,167,'irc.sidenet.org',6871);
INSERT INTO "servers" VALUES (1596,167,'irc.sidenet.org',6872);
INSERT INTO "servers" VALUES (1597,167,'irc.sidenet.org',6873);
INSERT INTO "servers" VALUES (1598,167,'irc.sidenet.org',6874);
INSERT INTO "servers" VALUES (1599,167,'irc.sidenet.org',6875);
INSERT INTO "servers" VALUES (1600,167,'irc.sidenet.org',6876);
INSERT INTO "servers" VALUES (1601,167,'irc.sidenet.org',6877);
INSERT INTO "servers" VALUES (1602,167,'irc.sidenet.org',6878);
INSERT INTO "servers" VALUES (1603,167,'irc.sidenet.org',6879);
INSERT INTO "servers" VALUES (1604,167,'irc.sidenet.org',6880);
INSERT INTO "servers" VALUES (1605,167,'irc.sidenet.org',6881);
INSERT INTO "servers" VALUES (1606,167,'irc.sidenet.org',6882);
INSERT INTO "servers" VALUES (1607,167,'irc.sidenet.org',6883);
INSERT INTO "servers" VALUES (1608,167,'irc.sidenet.org',6884);
INSERT INTO "servers" VALUES (1609,167,'irc.sidenet.org',6885);
INSERT INTO "servers" VALUES (1610,167,'irc.sidenet.org',6886);
INSERT INTO "servers" VALUES (1611,167,'irc.sidenet.org',6887);
INSERT INTO "servers" VALUES (1612,167,'irc.sidenet.org',6888);
INSERT INTO "servers" VALUES (1613,167,'irc.sidenet.org',6889);
INSERT INTO "servers" VALUES (1614,167,'irc.sidenet.org',6890);
INSERT INTO "servers" VALUES (1615,167,'irc.sidenet.org',6891);
INSERT INTO "servers" VALUES (1616,167,'irc.sidenet.org',6892);
INSERT INTO "servers" VALUES (1617,167,'irc.sidenet.org',6893);
INSERT INTO "servers" VALUES (1618,167,'irc.sidenet.org',6894);
INSERT INTO "servers" VALUES (1619,167,'irc.sidenet.org',6895);
INSERT INTO "servers" VALUES (1620,167,'irc.sidenet.org',6896);
INSERT INTO "servers" VALUES (1621,167,'irc.sidenet.org',6897);
INSERT INTO "servers" VALUES (1622,167,'irc.sidenet.org',6898);
INSERT INTO "servers" VALUES (1623,167,'irc.sidenet.org',6899);
INSERT INTO "servers" VALUES (1624,167,'irc.sidenet.org',6900);
INSERT INTO "servers" VALUES (1625,167,'irc.sidenet.org',6901);
INSERT INTO "servers" VALUES (1626,167,'irc.sidenet.org',6902);
INSERT INTO "servers" VALUES (1627,167,'irc.sidenet.org',6903);
INSERT INTO "servers" VALUES (1628,167,'irc.sidenet.org',6904);
INSERT INTO "servers" VALUES (1629,167,'irc.sidenet.org',6905);
INSERT INTO "servers" VALUES (1630,167,'irc.sidenet.org',6906);
INSERT INTO "servers" VALUES (1631,167,'irc.sidenet.org',6907);
INSERT INTO "servers" VALUES (1632,167,'irc.sidenet.org',6908);
INSERT INTO "servers" VALUES (1633,167,'irc.sidenet.org',6909);
INSERT INTO "servers" VALUES (1634,167,'irc.sidenet.org',6910);
INSERT INTO "servers" VALUES (1635,167,'irc.sidenet.org',6911);
INSERT INTO "servers" VALUES (1636,167,'irc.sidenet.org',6912);
INSERT INTO "servers" VALUES (1637,167,'irc.sidenet.org',6913);
INSERT INTO "servers" VALUES (1638,167,'irc.sidenet.org',6914);
INSERT INTO "servers" VALUES (1639,167,'irc.sidenet.org',6915);
INSERT INTO "servers" VALUES (1640,167,'irc.sidenet.org',6916);
INSERT INTO "servers" VALUES (1641,167,'irc.sidenet.org',6917);
INSERT INTO "servers" VALUES (1642,167,'irc.sidenet.org',6918);
INSERT INTO "servers" VALUES (1643,167,'irc.sidenet.org',6919);
INSERT INTO "servers" VALUES (1644,167,'irc.sidenet.org',6920);
INSERT INTO "servers" VALUES (1645,167,'irc.sidenet.org',6921);
INSERT INTO "servers" VALUES (1646,167,'irc.sidenet.org',6922);
INSERT INTO "servers" VALUES (1647,167,'irc.sidenet.org',6923);
INSERT INTO "servers" VALUES (1648,167,'irc.sidenet.org',6924);
INSERT INTO "servers" VALUES (1649,167,'irc.sidenet.org',6925);
INSERT INTO "servers" VALUES (1650,167,'irc.sidenet.org',6926);
INSERT INTO "servers" VALUES (1651,167,'irc.sidenet.org',6927);
INSERT INTO "servers" VALUES (1652,167,'irc.sidenet.org',6928);
INSERT INTO "servers" VALUES (1653,167,'irc.sidenet.org',6929);
INSERT INTO "servers" VALUES (1654,167,'irc.sidenet.org',6930);
INSERT INTO "servers" VALUES (1655,167,'irc.sidenet.org',6931);
INSERT INTO "servers" VALUES (1656,167,'irc.sidenet.org',6932);
INSERT INTO "servers" VALUES (1657,167,'irc.sidenet.org',6933);
INSERT INTO "servers" VALUES (1658,167,'irc.sidenet.org',6934);
INSERT INTO "servers" VALUES (1659,167,'irc.sidenet.org',6935);
INSERT INTO "servers" VALUES (1660,167,'irc.sidenet.org',6936);
INSERT INTO "servers" VALUES (1661,167,'irc.sidenet.org',6937);
INSERT INTO "servers" VALUES (1662,167,'irc.sidenet.org',6938);
INSERT INTO "servers" VALUES (1663,167,'irc.sidenet.org',6939);
INSERT INTO "servers" VALUES (1664,167,'irc.sidenet.org',6940);
INSERT INTO "servers" VALUES (1665,167,'irc.sidenet.org',6941);
INSERT INTO "servers" VALUES (1666,167,'irc.sidenet.org',6942);
INSERT INTO "servers" VALUES (1667,167,'irc.sidenet.org',6943);
INSERT INTO "servers" VALUES (1668,167,'irc.sidenet.org',6944);
INSERT INTO "servers" VALUES (1669,167,'irc.sidenet.org',6945);
INSERT INTO "servers" VALUES (1670,167,'irc.sidenet.org',6946);
INSERT INTO "servers" VALUES (1671,167,'irc.sidenet.org',6947);
INSERT INTO "servers" VALUES (1672,167,'irc.sidenet.org',6948);
INSERT INTO "servers" VALUES (1673,167,'irc.sidenet.org',6949);
INSERT INTO "servers" VALUES (1674,167,'irc.sidenet.org',6950);
INSERT INTO "servers" VALUES (1675,167,'irc.sidenet.org',6951);
INSERT INTO "servers" VALUES (1676,167,'irc.sidenet.org',6952);
INSERT INTO "servers" VALUES (1677,167,'irc.sidenet.org',6953);
INSERT INTO "servers" VALUES (1678,167,'irc.sidenet.org',6954);
INSERT INTO "servers" VALUES (1679,167,'irc.sidenet.org',6955);
INSERT INTO "servers" VALUES (1680,167,'irc.sidenet.org',6956);
INSERT INTO "servers" VALUES (1681,167,'irc.sidenet.org',6957);
INSERT INTO "servers" VALUES (1682,167,'irc.sidenet.org',6958);
INSERT INTO "servers" VALUES (1683,167,'irc.sidenet.org',6959);
INSERT INTO "servers" VALUES (1684,167,'irc.sidenet.org',6960);
INSERT INTO "servers" VALUES (1685,167,'irc.sidenet.org',6961);
INSERT INTO "servers" VALUES (1686,167,'irc.sidenet.org',6962);
INSERT INTO "servers" VALUES (1687,167,'irc.sidenet.org',6963);
INSERT INTO "servers" VALUES (1688,167,'irc.sidenet.org',6964);
INSERT INTO "servers" VALUES (1689,167,'irc.sidenet.org',6965);
INSERT INTO "servers" VALUES (1690,167,'irc.sidenet.org',6966);
INSERT INTO "servers" VALUES (1691,167,'irc.sidenet.org',6967);
INSERT INTO "servers" VALUES (1692,167,'irc.sidenet.org',6968);
INSERT INTO "servers" VALUES (1693,167,'irc.sidenet.org',6969);
INSERT INTO "servers" VALUES (1694,167,'irc.sidenet.org',6970);
INSERT INTO "servers" VALUES (1695,167,'irc.sidenet.org',6971);
INSERT INTO "servers" VALUES (1696,167,'irc.sidenet.org',6972);
INSERT INTO "servers" VALUES (1697,167,'irc.sidenet.org',6973);
INSERT INTO "servers" VALUES (1698,167,'irc.sidenet.org',6974);
INSERT INTO "servers" VALUES (1699,167,'irc.sidenet.org',6975);
INSERT INTO "servers" VALUES (1700,167,'irc.sidenet.org',6976);
INSERT INTO "servers" VALUES (1701,167,'irc.sidenet.org',6977);
INSERT INTO "servers" VALUES (1702,167,'irc.sidenet.org',6978);
INSERT INTO "servers" VALUES (1703,167,'irc.sidenet.org',6979);
INSERT INTO "servers" VALUES (1704,167,'irc.sidenet.org',6980);
INSERT INTO "servers" VALUES (1705,167,'irc.sidenet.org',6981);
INSERT INTO "servers" VALUES (1706,167,'irc.sidenet.org',6982);
INSERT INTO "servers" VALUES (1707,167,'irc.sidenet.org',6983);
INSERT INTO "servers" VALUES (1708,167,'irc.sidenet.org',6984);
INSERT INTO "servers" VALUES (1709,167,'irc.sidenet.org',6985);
INSERT INTO "servers" VALUES (1710,167,'irc.sidenet.org',6986);
INSERT INTO "servers" VALUES (1711,167,'irc.sidenet.org',6987);
INSERT INTO "servers" VALUES (1712,167,'irc.sidenet.org',6988);
INSERT INTO "servers" VALUES (1713,167,'irc.sidenet.org',6989);
INSERT INTO "servers" VALUES (1714,167,'irc.sidenet.org',6990);
INSERT INTO "servers" VALUES (1715,167,'irc.sidenet.org',6991);
INSERT INTO "servers" VALUES (1716,167,'irc.sidenet.org',6992);
INSERT INTO "servers" VALUES (1717,167,'irc.sidenet.org',6993);
INSERT INTO "servers" VALUES (1718,167,'irc.sidenet.org',6994);
INSERT INTO "servers" VALUES (1719,167,'irc.sidenet.org',6995);
INSERT INTO "servers" VALUES (1720,167,'irc.sidenet.org',6996);
INSERT INTO "servers" VALUES (1721,167,'irc.sidenet.org',6997);
INSERT INTO "servers" VALUES (1722,167,'irc.sidenet.org',6998);
INSERT INTO "servers" VALUES (1723,167,'irc.sidenet.org',6999);
INSERT INTO "servers" VALUES (1724,167,'irc.sidenet.org',7000);
INSERT INTO "servers" VALUES (1725,168,'arlington.va.us.skyyenet.org',6667);
INSERT INTO "servers" VALUES (1726,169,'irc.slashnet.org',6667);
INSERT INTO "servers" VALUES (1727,170,'irc.solarchat.net',6667);
INSERT INTO "servers" VALUES (1728,170,'irc.solarchat.net',7000);
INSERT INTO "servers" VALUES (1729,171,'irc.sorcery.net',6667);
INSERT INTO "servers" VALUES (1730,171,'irc.sorcery.net',7000);
INSERT INTO "servers" VALUES (1731,171,'irc.sorcery.net',9000);
INSERT INTO "servers" VALUES (1732,171,'nexus.sorcery.net',6667);
INSERT INTO "servers" VALUES (1733,171,'nexus.sorcery.net',7000);
INSERT INTO "servers" VALUES (1734,171,'nexus.sorcery.net',9000);
INSERT INTO "servers" VALUES (1735,171,'kechara.sorcery.net',6667);
INSERT INTO "servers" VALUES (1736,171,'kechara.sorcery.net',7000);
INSERT INTO "servers" VALUES (1737,171,'kechara.sorcery.net',9000);
INSERT INTO "servers" VALUES (1738,172,'irc.spamnet.org',6667);
INSERT INTO "servers" VALUES (1739,172,'irc.spamnet.org',6668);
INSERT INTO "servers" VALUES (1740,172,'irc.spamnet.org',6669);
INSERT INTO "servers" VALUES (1741,173,'irc.starchat.net',6667);
INSERT INTO "servers" VALUES (1742,173,'irc.starchat.net',6668);
INSERT INTO "servers" VALUES (1743,173,'irc.starchat.net',6669);
INSERT INTO "servers" VALUES (1744,173,'boomer.qld.au.starchat.net',6667);
INSERT INTO "servers" VALUES (1745,173,'boomer.qld.au.starchat.net',6668);
INSERT INTO "servers" VALUES (1746,173,'boomer.qld.au.starchat.net',6669);
INSERT INTO "servers" VALUES (1747,173,'reality.no.eu.starchat.net',6667);
INSERT INTO "servers" VALUES (1748,173,'reality.no.eu.starchat.net',6668);
INSERT INTO "servers" VALUES (1749,173,'reality.no.eu.starchat.net',6669);
INSERT INTO "servers" VALUES (1750,173,'sand.ca.us.starchat.net',6667);
INSERT INTO "servers" VALUES (1751,173,'sand.ca.us.starchat.net',6668);
INSERT INTO "servers" VALUES (1752,173,'sand.ca.us.starchat.net',6669);
INSERT INTO "servers" VALUES (1753,174,'irc.starlink-irc.org',6667);
INSERT INTO "servers" VALUES (1754,174,'rochester.mi.us.starlink-irc.org',6667);
INSERT INTO "servers" VALUES (1755,174,'houston.tx.us.starlink-irc.org',6667);
INSERT INTO "servers" VALUES (1756,175,'denver.co.us.starlink.org',6660);
INSERT INTO "servers" VALUES (1757,175,'denver.co.us.starlink.org',6661);
INSERT INTO "servers" VALUES (1758,175,'denver.co.us.starlink.org',6662);
INSERT INTO "servers" VALUES (1759,175,'denver.co.us.starlink.org',6663);
INSERT INTO "servers" VALUES (1760,175,'denver.co.us.starlink.org',6664);
INSERT INTO "servers" VALUES (1761,175,'denver.co.us.starlink.org',6665);
INSERT INTO "servers" VALUES (1762,175,'denver.co.us.starlink.org',6666);
INSERT INTO "servers" VALUES (1763,175,'denver.co.us.starlink.org',6667);
INSERT INTO "servers" VALUES (1764,175,'denver.co.us.starlink.org',6668);
INSERT INTO "servers" VALUES (1765,175,'denver.co.us.starlink.org',6669);
INSERT INTO "servers" VALUES (1766,175,'durham-r.nc.us.starlink.org',6660);
INSERT INTO "servers" VALUES (1767,175,'durham-r.nc.us.starlink.org',6661);
INSERT INTO "servers" VALUES (1768,175,'durham-r.nc.us.starlink.org',6662);
INSERT INTO "servers" VALUES (1769,175,'durham-r.nc.us.starlink.org',6663);
INSERT INTO "servers" VALUES (1770,175,'durham-r.nc.us.starlink.org',6664);
INSERT INTO "servers" VALUES (1771,175,'durham-r.nc.us.starlink.org',6665);
INSERT INTO "servers" VALUES (1772,175,'durham-r.nc.us.starlink.org',6666);
INSERT INTO "servers" VALUES (1773,175,'durham-r.nc.us.starlink.org',6667);
INSERT INTO "servers" VALUES (1774,175,'durham-r.nc.us.starlink.org',6668);
INSERT INTO "servers" VALUES (1775,175,'durham-r.nc.us.starlink.org',6669);
INSERT INTO "servers" VALUES (1776,175,'wichitafalls.tx.us.starlink.org',6666);
INSERT INTO "servers" VALUES (1777,175,'wichitafalls.tx.us.starlink.org',6667);
INSERT INTO "servers" VALUES (1778,175,'wichitafalls.tx.us.starlink.org',6668);
INSERT INTO "servers" VALUES (1779,176,'irc.stormdancing.net',6664);
INSERT INTO "servers" VALUES (1780,176,'irc.stormdancing.net',6665);
INSERT INTO "servers" VALUES (1781,176,'irc.stormdancing.net',6666);
INSERT INTO "servers" VALUES (1782,176,'irc.stormdancing.net',6667);
INSERT INTO "servers" VALUES (1783,176,'irc.stormdancing.net',6668);
INSERT INTO "servers" VALUES (1784,176,'irc.stormdancing.net',6669);
INSERT INTO "servers" VALUES (1785,177,'irc.styliso.net',6667);
INSERT INTO "servers" VALUES (1786,178,'irc.sub-city.net',6667);
INSERT INTO "servers" VALUES (1787,178,'irc.sub-city.net',6668);
INSERT INTO "servers" VALUES (1788,178,'irc.sub-city.net',6669);
INSERT INTO "servers" VALUES (1789,179,'irc.superchat.org',6660);
INSERT INTO "servers" VALUES (1790,179,'irc.superchat.org',6661);
INSERT INTO "servers" VALUES (1791,179,'irc.superchat.org',6662);
INSERT INTO "servers" VALUES (1792,179,'irc.superchat.org',6663);
INSERT INTO "servers" VALUES (1793,179,'irc.superchat.org',6664);
INSERT INTO "servers" VALUES (1794,179,'irc.superchat.org',6665);
INSERT INTO "servers" VALUES (1795,179,'irc.superchat.org',6666);
INSERT INTO "servers" VALUES (1796,179,'irc.superchat.org',6667);
INSERT INTO "servers" VALUES (1797,179,'irc.superchat.org',6668);
INSERT INTO "servers" VALUES (1798,180,'irc.superonline.com',6661);
INSERT INTO "servers" VALUES (1799,180,'irc.superonline.com',6662);
INSERT INTO "servers" VALUES (1800,180,'irc.superonline.com',6663);
INSERT INTO "servers" VALUES (1801,180,'irc.superonline.com',6664);
INSERT INTO "servers" VALUES (1802,180,'irc.superonline.com',6665);
INSERT INTO "servers" VALUES (1803,180,'irc.superonline.com',6666);
INSERT INTO "servers" VALUES (1804,180,'irc.superonline.com',6667);
INSERT INTO "servers" VALUES (1805,180,'irc.superonline.com',6668);
INSERT INTO "servers" VALUES (1806,180,'irc.superonline.com',6669);
INSERT INTO "servers" VALUES (1807,180,'irc.superonline.com',6670);
INSERT INTO "servers" VALUES (1808,181,'irc.sysopnet.org',6666);
INSERT INTO "servers" VALUES (1809,181,'irc.sysopnet.org',6667);
INSERT INTO "servers" VALUES (1810,181,'irc.sysopnet.org',6668);
INSERT INTO "servers" VALUES (1811,182,'irc.techdreams.net',6667);
INSERT INTO "servers" VALUES (1812,183,'irc.telstra.com',6667);
INSERT INTO "servers" VALUES (1813,183,'irc.telstra.com',6668);
INSERT INTO "servers" VALUES (1814,183,'irc.telstra.com',6669);
INSERT INTO "servers" VALUES (1815,184,'irc.terra.es',6667);
INSERT INTO "servers" VALUES (1816,185,'irc.thunderirc.net',6667);
INSERT INTO "servers" VALUES (1817,186,'irc.dominet.com.tr',6667);
INSERT INTO "servers" VALUES (1818,186,'irc.teklan.com.tr',6667);
INSERT INTO "servers" VALUES (1819,187,'irc.trcom.net',6666);
INSERT INTO "servers" VALUES (1820,187,'irc.trcom.net',6667);
INSERT INTO "servers" VALUES (1821,187,'irc.trcom.net',6668);
INSERT INTO "servers" VALUES (1822,187,'irc.trcom.net',6669);
INSERT INTO "servers" VALUES (1823,188,'irc.treklink.net',6667);
INSERT INTO "servers" VALUES (1824,189,'vancouver.bc.ca.undernet.org',6660);
INSERT INTO "servers" VALUES (1825,189,'vancouver.bc.ca.undernet.org',6661);
INSERT INTO "servers" VALUES (1826,189,'vancouver.bc.ca.undernet.org',6662);
INSERT INTO "servers" VALUES (1827,189,'vancouver.bc.ca.undernet.org',6663);
INSERT INTO "servers" VALUES (1828,189,'vancouver.bc.ca.undernet.org',6664);
INSERT INTO "servers" VALUES (1829,189,'vancouver.bc.ca.undernet.org',6665);
INSERT INTO "servers" VALUES (1830,189,'vancouver.bc.ca.undernet.org',6666);
INSERT INTO "servers" VALUES (1831,189,'vancouver.bc.ca.undernet.org',6667);
INSERT INTO "servers" VALUES (1832,189,'vancouver.bc.ca.undernet.org',6668);
INSERT INTO "servers" VALUES (1833,189,'vancouver.bc.ca.undernet.org',6669);
INSERT INTO "servers" VALUES (1834,189,'vancouver.bc.ca.undernet.org',6670);
INSERT INTO "servers" VALUES (1835,189,'vancouver.bc.ca.undernet.org',6671);
INSERT INTO "servers" VALUES (1836,189,'vancouver.bc.ca.undernet.org',6672);
INSERT INTO "servers" VALUES (1837,189,'vancouver.bc.ca.undernet.org',6673);
INSERT INTO "servers" VALUES (1838,189,'vancouver.bc.ca.undernet.org',6674);
INSERT INTO "servers" VALUES (1839,189,'vancouver.bc.ca.undernet.org',6675);
INSERT INTO "servers" VALUES (1840,189,'vancouver.bc.ca.undernet.org',6676);
INSERT INTO "servers" VALUES (1841,189,'vancouver.bc.ca.undernet.org',6677);
INSERT INTO "servers" VALUES (1842,189,'vancouver.bc.ca.undernet.org',6678);
INSERT INTO "servers" VALUES (1843,189,'vancouver.bc.ca.undernet.org',6679);
INSERT INTO "servers" VALUES (1844,189,'vancouver.bc.ca.undernet.org',6680);
INSERT INTO "servers" VALUES (1845,189,'vancouver.bc.ca.undernet.org',6681);
INSERT INTO "servers" VALUES (1846,189,'vancouver.bc.ca.undernet.org',6682);
INSERT INTO "servers" VALUES (1847,189,'vancouver.bc.ca.undernet.org',6683);
INSERT INTO "servers" VALUES (1848,189,'vancouver.bc.ca.undernet.org',6684);
INSERT INTO "servers" VALUES (1849,189,'vancouver.bc.ca.undernet.org',6685);
INSERT INTO "servers" VALUES (1850,189,'vancouver.bc.ca.undernet.org',6686);
INSERT INTO "servers" VALUES (1851,189,'vancouver.bc.ca.undernet.org',6687);
INSERT INTO "servers" VALUES (1852,189,'vancouver.bc.ca.undernet.org',6688);
INSERT INTO "servers" VALUES (1853,189,'vancouver.bc.ca.undernet.org',6689);
INSERT INTO "servers" VALUES (1854,189,'vancouver.bc.ca.undernet.org',6690);
INSERT INTO "servers" VALUES (1855,189,'toronto.on.ca.undernet.org',6661);
INSERT INTO "servers" VALUES (1856,189,'toronto.on.ca.undernet.org',6662);
INSERT INTO "servers" VALUES (1857,189,'toronto.on.ca.undernet.org',6663);
INSERT INTO "servers" VALUES (1858,189,'toronto.on.ca.undernet.org',6664);
INSERT INTO "servers" VALUES (1859,189,'toronto.on.ca.undernet.org',6665);
INSERT INTO "servers" VALUES (1860,189,'toronto.on.ca.undernet.org',6666);
INSERT INTO "servers" VALUES (1861,189,'toronto.on.ca.undernet.org',6667);
INSERT INTO "servers" VALUES (1862,189,'toronto.on.ca.undernet.org',6668);
INSERT INTO "servers" VALUES (1863,189,'toronto.on.ca.undernet.org',6669);
INSERT INTO "servers" VALUES (1864,189,'montreal.qu.ca.undernet.org',6660);
INSERT INTO "servers" VALUES (1865,189,'montreal.qu.ca.undernet.org',6661);
INSERT INTO "servers" VALUES (1866,189,'montreal.qu.ca.undernet.org',6662);
INSERT INTO "servers" VALUES (1867,189,'montreal.qu.ca.undernet.org',6663);
INSERT INTO "servers" VALUES (1868,189,'montreal.qu.ca.undernet.org',6664);
INSERT INTO "servers" VALUES (1869,189,'montreal.qu.ca.undernet.org',6665);
INSERT INTO "servers" VALUES (1870,189,'montreal.qu.ca.undernet.org',6666);
INSERT INTO "servers" VALUES (1871,189,'montreal.qu.ca.undernet.org',6667);
INSERT INTO "servers" VALUES (1872,189,'montreal.qu.ca.undernet.org',6668);
INSERT INTO "servers" VALUES (1873,189,'montreal.qu.ca.undernet.org',6669);
INSERT INTO "servers" VALUES (1874,189,'graz.at.eu.undernet.org',6661);
INSERT INTO "servers" VALUES (1875,189,'graz.at.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1876,189,'graz.at.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1877,189,'graz.at.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1878,189,'graz.at.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1879,189,'graz.at.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1880,189,'graz.at.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1881,189,'graz.at.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1882,189,'graz.at.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1883,189,'flanders.be.eu.undernet.org',6660);
INSERT INTO "servers" VALUES (1884,189,'flanders.be.eu.undernet.org',6661);
INSERT INTO "servers" VALUES (1885,189,'flanders.be.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1886,189,'flanders.be.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1887,189,'flanders.be.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1888,189,'flanders.be.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1889,189,'flanders.be.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1890,189,'flanders.be.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1891,189,'flanders.be.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1892,189,'flanders.be.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1893,189,'brussels.be.eu.undernet.org',6660);
INSERT INTO "servers" VALUES (1894,189,'brussels.be.eu.undernet.org',6661);
INSERT INTO "servers" VALUES (1895,189,'brussels.be.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1896,189,'brussels.be.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1897,189,'brussels.be.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1898,189,'brussels.be.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1899,189,'brussels.be.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1900,189,'brussels.be.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1901,189,'brussels.be.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1902,189,'brussels.be.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1903,189,'caen.fr.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1904,189,'caen.fr.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1905,189,'caen.fr.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1906,189,'caen.fr.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1907,189,'paris.fr.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1908,189,'paris.fr.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1909,189,'paris.fr.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1910,189,'paris.fr.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1911,189,'paris.fr.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1912,189,'paris.fr.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1913,189,'paris.fr.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1914,189,'diemen.nl.eu.undernet.org',6660);
INSERT INTO "servers" VALUES (1915,189,'diemen.nl.eu.undernet.org',6661);
INSERT INTO "servers" VALUES (1916,189,'diemen.nl.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1917,189,'diemen.nl.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1918,189,'diemen.nl.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1919,189,'diemen.nl.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1920,189,'diemen.nl.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1921,189,'diemen.nl.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1922,189,'diemen.nl.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1923,189,'diemen.nl.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1924,189,'haarlem.nl.eu.undernet.org',6660);
INSERT INTO "servers" VALUES (1925,189,'haarlem.nl.eu.undernet.org',6661);
INSERT INTO "servers" VALUES (1926,189,'haarlem.nl.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1927,189,'haarlem.nl.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1928,189,'haarlem.nl.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1929,189,'haarlem.nl.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1930,189,'haarlem.nl.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1931,189,'haarlem.nl.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1932,189,'haarlem.nl.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1933,189,'haarlem.nl.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1934,189,'oslo.no.eu.undernet.org',6660);
INSERT INTO "servers" VALUES (1935,189,'oslo.no.eu.undernet.org',6661);
INSERT INTO "servers" VALUES (1936,189,'oslo.no.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1937,189,'oslo.no.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1938,189,'oslo.no.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1939,189,'oslo.no.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1940,189,'oslo.no.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1941,189,'oslo.no.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1942,189,'oslo.no.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1943,189,'oslo.no.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1944,189,'gothenburg.se.eu.undernet.org',6660);
INSERT INTO "servers" VALUES (1945,189,'gothenburg.se.eu.undernet.org',6661);
INSERT INTO "servers" VALUES (1946,189,'gothenburg.se.eu.undernet.org',6662);
INSERT INTO "servers" VALUES (1947,189,'gothenburg.se.eu.undernet.org',6663);
INSERT INTO "servers" VALUES (1948,189,'gothenburg.se.eu.undernet.org',6664);
INSERT INTO "servers" VALUES (1949,189,'gothenburg.se.eu.undernet.org',6665);
INSERT INTO "servers" VALUES (1950,189,'gothenburg.se.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1951,189,'gothenburg.se.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1952,189,'gothenburg.se.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1953,189,'gothenburg.se.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1954,189,'london.uk.eu.undernet.org',6666);
INSERT INTO "servers" VALUES (1955,189,'london.uk.eu.undernet.org',6667);
INSERT INTO "servers" VALUES (1956,189,'london.uk.eu.undernet.org',6668);
INSERT INTO "servers" VALUES (1957,189,'london.uk.eu.undernet.org',6669);
INSERT INTO "servers" VALUES (1958,189,'auckland.nz.undernet.org',6667);
INSERT INTO "servers" VALUES (1959,189,'auckland.nz.undernet.org',6668);
INSERT INTO "servers" VALUES (1960,189,'phoenix.az.us.undernet.org',6660);
INSERT INTO "servers" VALUES (1961,189,'phoenix.az.us.undernet.org',6661);
INSERT INTO "servers" VALUES (1962,189,'phoenix.az.us.undernet.org',6662);
INSERT INTO "servers" VALUES (1963,189,'phoenix.az.us.undernet.org',6663);
INSERT INTO "servers" VALUES (1964,189,'phoenix.az.us.undernet.org',6664);
INSERT INTO "servers" VALUES (1965,189,'phoenix.az.us.undernet.org',6665);
INSERT INTO "servers" VALUES (1966,189,'phoenix.az.us.undernet.org',6666);
INSERT INTO "servers" VALUES (1967,189,'phoenix.az.us.undernet.org',6667);
INSERT INTO "servers" VALUES (1968,189,'phoenix.az.us.undernet.org',6668);
INSERT INTO "servers" VALUES (1969,189,'phoenix.az.us.undernet.org',6669);
INSERT INTO "servers" VALUES (1970,189,'los-angeles.ca.us.undernet.org',6660);
INSERT INTO "servers" VALUES (1971,189,'los-angeles.ca.us.undernet.org',6661);
INSERT INTO "servers" VALUES (1972,189,'los-angeles.ca.us.undernet.org',6662);
INSERT INTO "servers" VALUES (1973,189,'los-angeles.ca.us.undernet.org',6663);
INSERT INTO "servers" VALUES (1974,189,'los-angeles.ca.us.undernet.org',6664);
INSERT INTO "servers" VALUES (1975,189,'los-angeles.ca.us.undernet.org',6665);
INSERT INTO "servers" VALUES (1976,189,'los-angeles.ca.us.undernet.org',6666);
INSERT INTO "servers" VALUES (1977,189,'los-angeles.ca.us.undernet.org',6667);
INSERT INTO "servers" VALUES (1978,189,'los-angeles.ca.us.undernet.org',6668);
INSERT INTO "servers" VALUES (1979,189,'los-angeles.ca.us.undernet.org',6669);
INSERT INTO "servers" VALUES (1980,189,'sandiego.ca.us.undernet.org',6660);
INSERT INTO "servers" VALUES (1981,189,'sandiego.ca.us.undernet.org',6661);
INSERT INTO "servers" VALUES (1982,189,'sandiego.ca.us.undernet.org',6662);
INSERT INTO "servers" VALUES (1983,189,'sandiego.ca.us.undernet.org',6663);
INSERT INTO "servers" VALUES (1984,189,'sandiego.ca.us.undernet.org',6664);
INSERT INTO "servers" VALUES (1985,189,'sandiego.ca.us.undernet.org',6665);
INSERT INTO "servers" VALUES (1986,189,'sandiego.ca.us.undernet.org',6666);
INSERT INTO "servers" VALUES (1987,189,'sandiego.ca.us.undernet.org',6667);
INSERT INTO "servers" VALUES (1988,189,'sandiego.ca.us.undernet.org',6668);
INSERT INTO "servers" VALUES (1989,189,'sandiego.ca.us.undernet.org',6669);
INSERT INTO "servers" VALUES (1990,189,'sandiego.ca.us.undernet.org',6670);
INSERT INTO "servers" VALUES (1991,189,'washington.dc.us.undernet.org',6660);
INSERT INTO "servers" VALUES (1992,189,'washington.dc.us.undernet.org',6661);
INSERT INTO "servers" VALUES (1993,189,'washington.dc.us.undernet.org',6662);
INSERT INTO "servers" VALUES (1994,189,'washington.dc.us.undernet.org',6663);
INSERT INTO "servers" VALUES (1995,189,'washington.dc.us.undernet.org',6664);
INSERT INTO "servers" VALUES (1996,189,'washington.dc.us.undernet.org',6665);
INSERT INTO "servers" VALUES (1997,189,'washington.dc.us.undernet.org',6666);
INSERT INTO "servers" VALUES (1998,189,'washington.dc.us.undernet.org',6667);
INSERT INTO "servers" VALUES (1999,189,'washington.dc.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2000,189,'washington.dc.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2001,189,'atlanta.ga.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2002,189,'atlanta.ga.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2003,189,'atlanta.ga.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2004,189,'atlanta.ga.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2005,189,'atlanta.ga.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2006,189,'atlanta.ga.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2007,189,'atlanta.ga.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2008,189,'atlanta.ga.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2009,189,'atlanta.ga.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2010,189,'atlanta.ga.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2011,189,'manhattan.ks.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2012,189,'manhattan.ks.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2013,189,'manhattan.ks.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2014,189,'manhattan.ks.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2015,189,'manhattan.ks.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2016,189,'manhattan.ks.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2017,189,'manhattan.ks.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2018,189,'manhattan.ks.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2019,189,'manhattan.ks.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2020,189,'manhattan.ks.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2021,189,'baltimore.md.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2022,189,'baltimore.md.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2023,189,'baltimore.md.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2024,189,'baltimore.md.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2025,189,'baltimore.md.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2026,189,'baltimore.md.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2027,189,'baltimore.md.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2028,189,'baltimore.md.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2029,189,'baltimore.md.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2030,189,'baltimore.md.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2031,189,'ann-arbor.mi.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2032,189,'ann-arbor.mi.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2033,189,'ann-arbor.mi.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2034,189,'ann-arbor.mi.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2035,189,'ann-arbor.mi.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2036,189,'ann-arbor.mi.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2037,189,'ann-arbor.mi.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2038,189,'ann-arbor.mi.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2039,189,'ann-arbor.mi.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2040,189,'ann-arbor.mi.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2041,189,'newbrunswick.nj.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2042,189,'newbrunswick.nj.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2043,189,'newbrunswick.nj.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2044,189,'newbrunswick.nj.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2045,189,'newbrunswick.nj.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2046,189,'newbrunswick.nj.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2047,189,'newbrunswick.nj.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2048,189,'newbrunswick.nj.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2049,189,'newbrunswick.nj.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2050,189,'newbrunswick.nj.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2051,189,'lasvegas.nv.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2052,189,'lasvegas.nv.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2053,189,'lasvegas.nv.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2054,189,'lasvegas.nv.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2055,189,'lasvegas.nv.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2056,189,'lasvegas.nv.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2057,189,'lasvegas.nv.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2058,189,'lasvegas.nv.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2059,189,'lasvegas.nv.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2060,189,'lasvegas.nv.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2061,189,'newyork.ny.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2062,189,'newyork.ny.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2063,189,'newyork.ny.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2064,189,'newyork.ny.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2065,189,'newyork.ny.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2066,189,'newyork.ny.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2067,189,'newyork.ny.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2068,189,'newyork.ny.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2069,189,'newyork.ny.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2070,189,'newyork.ny.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2071,189,'dallas.tx.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2072,189,'dallas.tx.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2073,189,'dallas.tx.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2074,189,'dallas.tx.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2075,189,'dallas.tx.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2076,189,'dallas.tx.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2077,189,'dallas.tx.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2078,189,'dallas.tx.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2079,189,'dallas.tx.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2080,189,'saltlake.ut.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2081,189,'saltlake.ut.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2082,189,'saltlake.ut.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2083,189,'saltlake.ut.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2084,189,'saltlake.ut.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2085,189,'saltlake.ut.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2086,189,'saltlake.ut.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2087,189,'saltlake.ut.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2088,189,'saltlake.ut.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2089,189,'saltlake.ut.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2090,189,'arlington.va.us.undernet.org',6660);
INSERT INTO "servers" VALUES (2091,189,'arlington.va.us.undernet.org',6661);
INSERT INTO "servers" VALUES (2092,189,'arlington.va.us.undernet.org',6662);
INSERT INTO "servers" VALUES (2093,189,'arlington.va.us.undernet.org',6663);
INSERT INTO "servers" VALUES (2094,189,'arlington.va.us.undernet.org',6664);
INSERT INTO "servers" VALUES (2095,189,'arlington.va.us.undernet.org',6665);
INSERT INTO "servers" VALUES (2096,189,'arlington.va.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2097,189,'arlington.va.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2098,189,'arlington.va.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2099,189,'arlington.va.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2100,189,'mclean.va.us.undernet.org',6666);
INSERT INTO "servers" VALUES (2101,189,'mclean.va.us.undernet.org',6667);
INSERT INTO "servers" VALUES (2102,189,'mclean.va.us.undernet.org',6668);
INSERT INTO "servers" VALUES (2103,189,'mclean.va.us.undernet.org',6669);
INSERT INTO "servers" VALUES (2104,190,'irc.underz.org',6667);
INSERT INTO "servers" VALUES (2105,190,'irc.underz.org',6668);
INSERT INTO "servers" VALUES (2106,191,'irc.undienet.org',6661);
INSERT INTO "servers" VALUES (2107,191,'irc.undienet.org',6662);
INSERT INTO "servers" VALUES (2108,191,'irc.undienet.org',6663);
INSERT INTO "servers" VALUES (2109,191,'irc.undienet.org',6664);
INSERT INTO "servers" VALUES (2110,191,'irc.undienet.org',6665);
INSERT INTO "servers" VALUES (2111,192,'irc.unfnet.net',6667);
INSERT INTO "servers" VALUES (2112,192,'irc.unfnet.net',6668);
INSERT INTO "servers" VALUES (2113,192,'irc.unfnet.net',6669);
INSERT INTO "servers" VALUES (2114,193,'irc.unionlatina.org',6667);
INSERT INTO "servers" VALUES (2115,194,'irc.unitedchat.net',6667);
INSERT INTO "servers" VALUES (2116,195,'irc.unitedchat.org',6667);
INSERT INTO "servers" VALUES (2117,196,'irc.univers.org',6665);
INSERT INTO "servers" VALUES (2118,196,'irc.univers.org',6666);
INSERT INTO "servers" VALUES (2119,196,'irc.univers.org',6667);
INSERT INTO "servers" VALUES (2120,196,'irc.univers.org',6668);
INSERT INTO "servers" VALUES (2121,196,'irc.univers.org',6669);
INSERT INTO "servers" VALUES (2122,197,'irc.venomx.com',6661);
INSERT INTO "servers" VALUES (2123,197,'irc.venomx.com',6662);
INSERT INTO "servers" VALUES (2124,197,'irc.venomx.com',6663);
INSERT INTO "servers" VALUES (2125,197,'irc.venomx.com',6664);
INSERT INTO "servers" VALUES (2126,197,'irc.venomx.com',6665);
INSERT INTO "servers" VALUES (2127,197,'irc.venomx.com',6666);
INSERT INTO "servers" VALUES (2128,197,'irc.venomx.com',6667);
INSERT INTO "servers" VALUES (2129,197,'irc.venomx.com',6668);
INSERT INTO "servers" VALUES (2130,197,'irc.venomx.com',6669);
INSERT INTO "servers" VALUES (2131,198,'irc.vidgamechat.com',6667);
INSERT INTO "servers" VALUES (2132,199,'irc-rr.vitamina.ca',6667);
INSERT INTO "servers" VALUES (2133,200,'irc.vortexirc.net',6667);
INSERT INTO "servers" VALUES (2134,201,'irc.wanas.net',6660);
INSERT INTO "servers" VALUES (2135,201,'irc.wanas.net',6661);
INSERT INTO "servers" VALUES (2136,201,'irc.wanas.net',6662);
INSERT INTO "servers" VALUES (2137,201,'irc.wanas.net',6663);
INSERT INTO "servers" VALUES (2138,201,'irc.wanas.net',6664);
INSERT INTO "servers" VALUES (2139,201,'irc.wanas.net',6665);
INSERT INTO "servers" VALUES (2140,201,'irc.wanas.net',6666);
INSERT INTO "servers" VALUES (2141,201,'irc.wanas.net',6667);
INSERT INTO "servers" VALUES (2142,201,'irc.wanas.net',6668);
INSERT INTO "servers" VALUES (2143,201,'irc.wanas.net',6669);
INSERT INTO "servers" VALUES (2144,202,'irc.warped.net',6667);
INSERT INTO "servers" VALUES (2145,203,'irc.webchat.org',6667);
INSERT INTO "servers" VALUES (2146,203,'irc.webchat.org',6668);
INSERT INTO "servers" VALUES (2147,203,'irc.webchat.org',6669);
INSERT INTO "servers" VALUES (2148,203,'wiregrass.al.us.webchat.org',6667);
INSERT INTO "servers" VALUES (2149,203,'wiregrass.al.us.webchat.org',6668);
INSERT INTO "servers" VALUES (2150,203,'wiregrass.al.us.webchat.org',6669);
INSERT INTO "servers" VALUES (2151,203,'webmaster.ca.us.webchat.org',6661);
INSERT INTO "servers" VALUES (2152,203,'webmaster.ca.us.webchat.org',6662);
INSERT INTO "servers" VALUES (2153,203,'webmaster.ca.us.webchat.org',6663);
INSERT INTO "servers" VALUES (2154,203,'webmaster.ca.us.webchat.org',6664);
INSERT INTO "servers" VALUES (2155,203,'webmaster.ca.us.webchat.org',6665);
INSERT INTO "servers" VALUES (2156,203,'webmaster.ca.us.webchat.org',6666);
INSERT INTO "servers" VALUES (2157,203,'webmaster.ca.us.webchat.org',6667);
INSERT INTO "servers" VALUES (2158,203,'webmaster.ca.us.webchat.org',6668);
INSERT INTO "servers" VALUES (2159,203,'webmaster.ca.us.webchat.org',6669);
INSERT INTO "servers" VALUES (2160,203,'greennet.ma.us.webchat.org',6667);
INSERT INTO "servers" VALUES (2161,203,'greennet.ma.us.webchat.org',6668);
INSERT INTO "servers" VALUES (2162,203,'greennet.ma.us.webchat.org',6669);
INSERT INTO "servers" VALUES (2163,204,'irc.wonk.net',6667);
INSERT INTO "servers" VALUES (2164,204,'irc.wonk.net',6668);
INSERT INTO "servers" VALUES (2165,204,'irc.wonk.net',6669);
INSERT INTO "servers" VALUES (2166,205,'irc.woot.net',6667);
INSERT INTO "servers" VALUES (2167,206,'irc.worldirc.org',6667);
INSERT INTO "servers" VALUES (2168,207,'irc.xevion.net',6667);
INSERT INTO "servers" VALUES (2169,207,'irc.xevion.net',7000);
INSERT INTO "servers" VALUES (2170,208,'au.xnet.org',6667);
INSERT INTO "servers" VALUES (2171,208,'eu.xnet.org',6667);
INSERT INTO "servers" VALUES (2172,208,'us.xnet.org',6667);
INSERT INTO "servers" VALUES (2173,209,'irc.xworld.org',6667);
INSERT INTO "servers" VALUES (2174,210,'lia.zanet.net',6667);
INSERT INTO "servers" VALUES (2175,210,'timewiz.zanet.net',6667);
INSERT INTO "servers" VALUES (2176,211,'gaspode.zanet.org.za',6667);
INSERT INTO "servers" VALUES (2177,211,'is.zanet.org.za',6667);
INSERT INTO "servers" VALUES (2178,211,'ethereal.zanet.org.za',6660);
INSERT INTO "servers" VALUES (2179,211,'ethereal.zanet.org.za',6666);
INSERT INTO "servers" VALUES (2180,212,'irc.zerolimit.net',6667);
INSERT INTO "servers" VALUES (2181,213,'irc.zirc.org',6660);
INSERT INTO "servers" VALUES (2182,213,'irc.zirc.org',6661);
INSERT INTO "servers" VALUES (2183,213,'irc.zirc.org',6662);
INSERT INTO "servers" VALUES (2184,213,'irc.zirc.org',6663);
INSERT INTO "servers" VALUES (2185,213,'irc.zirc.org',6664);
INSERT INTO "servers" VALUES (2186,213,'irc.zirc.org',6665);
INSERT INTO "servers" VALUES (2187,213,'irc.zirc.org',6666);
INSERT INTO "servers" VALUES (2188,213,'irc.zirc.org',6667);
INSERT INTO "servers" VALUES (2189,213,'irc.zirc.org',6668);
INSERT INTO "servers" VALUES (2190,213,'irc.zirc.org',6669);
INSERT INTO "servers" VALUES (2191,214,'irc.zuh.net',6667);
INSERT INTO "servers" VALUES (2192,215,'irc.zurna.net',6667);

--
-- Table structure for table 'user'
--

CREATE TABLE "user" (
  "user" varchar(20) NOT NULL DEFAULT '',
  "pass" varchar(50) DEFAULT NULL,
  v INT4 NOT NULL DEFAULT '0',
  o INT4 NOT NULL DEFAULT '0',
  m INT4 NOT NULL DEFAULT '0',
  n INT4 NOT NULL DEFAULT '0',
  f INT4 NOT NULL DEFAULT '0',
  p INT4 NOT NULL DEFAULT '0',
  b INT4 NOT NULL DEFAULT '0',
  h INT4 NOT NULL DEFAULT '0',
  j INT4 NOT NULL DEFAULT '0',
  t INT4 NOT NULL DEFAULT '0',
  x INT4 NOT NULL DEFAULT '0',
  "created" varchar(15) NOT NULL DEFAULT '',
  "last_on" varchar(15) DEFAULT NULL,
  "last_chan" varchar(200) DEFAULT NULL,
  "password" varchar(100) DEFAULT NULL,
  "mysql_password" varchar(50) DEFAULT NULL
);

--
-- Dumping data for table 'user'
--

--
-- Table structure for table 'user_bot'
--



--
-- Sequences for table USER_BOT
--

CREATE SEQUENCE user_bot_b_id_seq;

CREATE TABLE "user_bot" (
  "b_id" INT4 DEFAULT nextval('user_bot_b_id_seq'),
  "user" varchar(20) NOT NULL DEFAULT '',
  "botaddr" varchar(100) NOT NULL DEFAULT '',
  "telnet" varchar(10) NOT NULL DEFAULT '',
  "port2" varchar(10) NOT NULL DEFAULT '',
  h INT4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("b_id")

);

--
-- Dumping data for table 'user_bot'
--

INSERT INTO "user_bot" VALUES (1,'neiano','','','','Y');
INSERT INTO "user_bot" VALUES (2,'mysql','212.242.74.5','9969','9969','Y');

--
-- Table structure for table 'user_chan'
--



--
-- Sequences for table USER_CHAN
--

CREATE SEQUENCE user_chan_uc_id_seq;

CREATE TABLE "user_chan" (
  "uc_id" INT4 DEFAULT nextval('user_chan_uc_id_seq'),
  "chan" varchar(100) NOT NULL DEFAULT '',
  v INT4 NOT NULL DEFAULT '0',
  o INT4 NOT NULL DEFAULT '0',
  f INT4 NOT NULL DEFAULT '0',
  p INT4 NOT NULL DEFAULT '0',
  "user" varchar(20) NOT NULL DEFAULT '',
  m INT4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("uc_id")

);

--
-- Dumping data for table 'user_chan'
--

--
-- Table structure for table 'user_host'
--



--
-- Sequences for table USER_HOST
--

CREATE SEQUENCE user_host_host_id_seq;

CREATE TABLE "user_host" (
  "host_id" INT4 DEFAULT nextval('user_host_host_id_seq'),
  "user" varchar(20) NOT NULL DEFAULT '',
  "mask" varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY ("host_id")

);

--
-- Dumping data for table 'user_host'
--

--
-- Table structure for table 'web_login'
--



--
-- Sequences for table WEB_LOGIN
--

CREATE SEQUENCE web_login_web_login_id_seq;

CREATE TABLE "web_login" (
  "web_login_id" INT4 DEFAULT nextval('web_login_web_login_id_seq'),
  "user" varchar(50) NOT NULL DEFAULT '',
  "login_time" INT4 NOT NULL DEFAULT '0',
  PRIMARY KEY ("web_login_id")

);

--
-- Dumping data for table 'web_login'
--



--
-- Sequences for table PART_MSG
--

SELECT SETVAL('part_msg_part_msg_id_seq',(select case when max("part_msg_id")>0 then max("part_msg_id")+1 else 1 end from "part_msg"));

--
-- Sequences for table USER_HOST
--

SELECT SETVAL('user_host_host_id_seq',(select case when max("host_id")>0 then max("host_id")+1 else 1 end from "user_host"));

--
-- Sequences for table SERVER_ERROR
--

SELECT SETVAL('server_error_server_error_id',(select case when max("server_error_id")>0 then max("server_error_id")+1 else 1 end from "server_error"));

--
-- Sequences for table CHAN_USERS
--

SELECT SETVAL('chan_users_cu_id_seq',(select case when max("cu_id")>0 then max("cu_id")+1 else 1 end from "chan_users"));

--
-- Sequences for table CHAN_BANS
--

SELECT SETVAL('chan_bans_cb_id_seq',(select case when max("cb_id")>0 then max("cb_id")+1 else 1 end from "chan_bans"));

--
-- Sequences for table BANS
--

SELECT SETVAL('bans_ban_id_seq',(select case when max("ban_id")>0 then max("ban_id")+1 else 1 end from "bans"));

--
-- Sequences for table CHANNELS
--

SELECT SETVAL('channels_channels_id_seq',(select case when max("channels_id")>0 then max("channels_id")+1 else 1 end from "channels"));

--
-- Sequences for table WEB_LOGIN
--

SELECT SETVAL('web_login_web_login_id_seq',(select case when max("web_login_id")>0 then max("web_login_id")+1 else 1 end from "web_login"));

--
-- Sequences for table SERVER_GROUPS
--

SELECT SETVAL('server_groups_server_groups_',(select case when max("server_groups_id")>0 then max("server_groups_id")+1 else 1 end from "server_groups"));

--
-- Sequences for table MANUAL
--

SELECT SETVAL('',(select case when max("INSERT")>0 then max("INSERT")+1 else 1 end from "manual"));

--
-- Sequences for table USER_CHAN
--

SELECT SETVAL('user_chan_uc_id_seq',(select case when max("uc_id")>0 then max("uc_id")+1 else 1 end from "user_chan"));

--
-- Sequences for table DCC_CONNECTIONS
--

SELECT SETVAL('dcc_connections_id_seq',(select case when max("id")>0 then max("id")+1 else 1 end from "dcc_connections"));

--
-- Sequences for table SERVERS
--

SELECT SETVAL('servers_servers_id_seq',(select case when max("servers_id")>0 then max("servers_id")+1 else 1 end from "servers"));

--
-- Sequences for table USER_BOT
--

SELECT SETVAL('user_bot_b_id_seq',(select case when max("b_id")>0 then max("b_id")+1 else 1 end from "user_bot"));

--
-- Sequences for table MODULES
--

SELECT SETVAL('modules_modules_id_seq',(select case when max("modules_id")>0 then max("modules_id")+1 else 1 end from "modules"));

--
-- Sequences for table PERL_MANUAL
--

SELECT SETVAL('perl_manual_id_seq',(select case when max("ID")>0 then max("ID")+1 else 1 end from "perl_manual"));

--
-- Sequences for table MODE_DATA
--

SELECT SETVAL('mode_data_mode_data_id_seq',(select case when max("mode_data_id")>0 then max("mode_data_id")+1 else 1 end from "mode_data"));

--
-- Sequences for table PHP_MANUAL
--

SELECT SETVAL('php_manual_m_id_seq',(select case when max("m_id")>0 then max("m_id")+1 else 1 end from "php_manual"));

--
-- Sequences for table MODULE_BINDS
--

SELECT SETVAL('module_binds_module_binds_id',(select case when max("module_binds_id")>0 then max("module_binds_id")+1 else 1 end from "module_binds"));

--
-- Sequences for table JOIN_MSG
--

SELECT SETVAL('join_msg_join_msg_id_seq',(select case when max("join_msg_id")>0 then max("join_msg_id")+1 else 1 end from "join_msg"));

COMMIT;
