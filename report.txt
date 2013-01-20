1. テーブルの定義

テーブル t1 は、列 c2 と c4 にインデックスを設定。
テーブル t2 は、列 ( c2, c3 ) と ( c4, c5 ) にインデックスを設定。

CREATE TABLE t1 (
  pk INT 
, c1 INT
, c2 INT
, c3 INT
, c4 CHAR(10)
, c5 CHAR(10)
, c6 VARCHAR(2000)
, PRIMARY KEY ( pk )
, INDEX ( c2 )
, INDEX ( c4 )
);

DESC t1;
+-------+---------------+------+-----+---------+-------+
| Field | Type          | Null | Key | Default | Extra |
+-------+---------------+------+-----+---------+-------+
| pk    | int(11)       | NO   | PRI | 0       |       |
| c1    | int(11)       | YES  |     | NULL    |       |
| c2    | int(11)       | YES  | MUL | NULL    |       |
| c3    | int(11)       | YES  |     | NULL    |       |
| c4    | char(10)      | YES  | MUL | NULL    |       |
| c5    | char(10)      | YES  |     | NULL    |       |
| c6    | varchar(2000) | YES  |     | NULL    |       |
+-------+---------------+------+-----+---------+-------+

SHOW INDEX FROM t1;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| t1    | 0          | PRIMARY  | 1            | pk          | A         | 1000029     | NULL     | NULL   |      | BTREE      |         |               |
| t1    | 1          | c2       | 1            | c2          | A         | 511         | NULL     | NULL   | YES  | BTREE      |         |               |
| t1    | 1          | c4       | 1            | c4          | A         | 2049        | NULL     | NULL   | YES  | BTREE      |         |               |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+


CREATE TABLE t2 (
  pk INT 
, c1 INT
, c2 INT
, c3 INT
, c4 CHAR(10)
, c5 CHAR(10)
, c6 VARCHAR(2000)
, PRIMARY KEY ( pk )
, INDEX ( c2, c3 )
, INDEX ( c4, c5 )
);

DESC t2;
+-------+---------------+------+-----+---------+-------+
| Field | Type          | Null | Key | Default | Extra |
+-------+---------------+------+-----+---------+-------+
| pk    | int(11)       | NO   | PRI | 0       |       |
| c1    | int(11)       | YES  |     | NULL    |       |
| c2    | int(11)       | YES  | MUL | NULL    |       |
| c3    | int(11)       | YES  |     | NULL    |       |
| c4    | char(10)      | YES  | MUL | NULL    |       |
| c5    | char(10)      | YES  |     | NULL    |       |
| c6    | varchar(2000) | YES  |     | NULL    |       |
+-------+---------------+------+-----+---------+-------+

SHOW INDEX FROM t2;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| t2    | 0          | PRIMARY  | 1            | pk          | A         | 1000029     | NULL     | NULL   |      | BTREE      |         |               |
| t2    | 1          | c2       | 1            | c2          | A         | 895         | NULL     | NULL   | YES  | BTREE      |         |               |
| t2    | 1          | c2       | 2            | c3          | A         | 895         | NULL     | NULL   | YES  | BTREE      |         |               |
| t2    | 1          | c4       | 1            | c4          | A         | 127         | NULL     | NULL   | YES  | BTREE      |         |               |
| t2    | 1          | c4       | 2            | c5          | A         | 127         | NULL     | NULL   | YES  | BTREE      |         |               |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+


2. データ

テーブル t1 と t2 に100万行の同じデータを投入。

SELECT pk, c1, c2, c3, c4, c5, CONCAT(SUBSTR(c6, 1, 12), '... (',
 FORMAT(CHAR_LENGTH(c6), 0), ')') "c6 (length)" FROM t1 WHERE pk < 15 ORDER BY pk;
+----+------+------+------+------------+------------+-------------------------+
| pk | c1   | c2   | c3   | c4         | c5         | c6 (length)             |
+----+------+------+------+------------+------------+-------------------------+
| 0  | NULL | NULL | NULL | 0123456789 | 0123456789 | 012345678901... (1,000) |
| 1  | 1    | 1    | 1    | 1234567890 | 1234567890 | 012345678901... (1,000) |
| 2  | 2    | 2    | 2    | 2345678901 | 2345678901 | 012345678901... (1,000) |
| 3  | 3    | 3    | 3    | 3456789012 | 3456789012 | 012345678901... (1,000) |
| 4  | 4    | 4    | 4    | 4567890123 | 4567890123 | 012345678901... (1,000) |
| 5  | 5    | 5    | 5    | 5678901234 | 5678901234 | 012345678901... (1,000) |
| 6  | 6    | 6    | 6    | 6789012345 | 6789012345 | 012345678901... (1,000) |
| 7  | 7    | 7    | 7    | 7890123456 | 7890123456 | 012345678901... (1,000) |
| 8  | 8    | 8    | 8    | 8901234567 | 8901234567 | 012345678901... (1,000) |
| 9  | 9    | 9    | 9    | 9012345678 | 9012345678 | 012345678901... (1,000) |
| 10 | 10   | NULL | NULL | 0123456789 | 0123456789 | 012345678901... (1,000) |
| 11 | 11   | 1    | 1    | 1234567890 | 1234567890 | 012345678901... (1,000) |
| 12 | 12   | 2    | 2    | 2345678901 | 2345678901 | 012345678901... (1,000) |
| 13 | 13   | 3    | 3    | 3456789012 | 3456789012 | 012345678901... (1,000) |
| 14 | 14   | 4    | 4    | 4567890123 | 4567890123 | 012345678901... (1,000) |
+----+------+------+------+------------+------------+-------------------------+

SELECT COUNT(*) FROM t1;
+----------+
| COUNT(*) |
+----------+
| 1000000  |
+----------+

所要時間　

-- t1 --
579 sec.
0.579 msec./行
1727 行/sec.

-- t2 --
565 sec.
0.565 msec./行
1769 行/sec.


3. クエリの所要時間の実測値 ( sec. )

Type: http://dev.mysql.com/doc/refman/5.1/ja/explain.html

  C: const
  E: eq_ref
  G: range
  R: ref
  U: unique_subquery
  I: index
  A: ALL
  N: Null

 # TY     sec.         SQL
-- -- ----------   ---------------
 1 C    0.169032 : SELECT c1 FROM t1 WHERE pk = 555;
 2 C    0.000232 : SELECT pk FROM t1 WHERE pk = 555;
 3 A   40.726989 : SELECT c1 FROM t1 WHERE c1 = 555;
 4 R    2.822190 : SELECT COUNT(*) FROM t1 WHERE c2 = 5;
 5 R    1.175355 : SELECT COUNT(*) FROM t2 WHERE c2 = 5;
 6 R    0.099853 : SELECT COUNT(c2) FROM t1 WHERE c2 = 5;
 7 R   13.562057 : SELECT COUNT(c3) FROM t1 WHERE c2 = 5;
 8 A    8.379612 : SELECT COUNT(*) FROM t1 WHERE c3 = 5;
 9 I    4.793032 : SELECT COUNT(*) FROM t2 WHERE c3 = 5;
10 R    0.805067 : SELECT COUNT(*) FROM t1 WHERE c4 = '5678901234';
11 R    0.835371 : SELECT COUNT(*) FROM t2 WHERE c4 = '5678901234';
12 R    0.077289 : SELECT COUNT(c4) FROM t1 WHERE c4 = '5678901234';
13 R   11.974615 : SELECT COUNT(c5) FROM t1 WHERE c4 = '5678901234';
14 A    6.402512 : SELECT COUNT(*) FROM t1 WHERE c5 = '5678901234';
15 I    7.369542 : SELECT COUNT(*) FROM t2 WHERE c5 = '5678901234';
16 G    0.085342 : SELECT COUNT(*) FROM t1 WHERE 333 < pk and pk < 777;
17 A    5.792206 : SELECT COUNT(*) FROM t1 WHERE 333 < c1 and c1 < 777;
18 G    5.027469 : SELECT COUNT(*) FROM t1 WHERE 3 < c2 and c2 < 7;
19 G    5.936712 : SELECT COUNT(*) FROM t2 WHERE 3 < c2 and c2 < 7;
20 A    5.965372 : SELECT COUNT(*) FROM t1 WHERE 3 < c3 and c3 < 7;
21 I    3.105512 : SELECT COUNT(*) FROM t2 WHERE 3 < c3 and c3 < 7;
22 G    0.058277 : SELECT COUNT(*) FROM t1 WHERE pk IN (333, 555, 777);
23 G    0.000275 : SELECT COUNT(*) FROM t1 WHERE pk = 333 OR pk = 555 OR pk = 777;
24 G    0.166990 : SELECT COUNT(*) FROM t1 WHERE c4 like '567%';
25 G    0.148582 : SELECT COUNT(*) FROM t2 WHERE c4 like '567%';
26 A    5.714941 : SELECT COUNT(*) FROM t1 WHERE c5 like '567%';
27 I    6.240257 : SELECT COUNT(*) FROM t2 WHERE c5 like '567%';
28 I    6.548055 : SELECT COUNT(*) FROM t1 WHERE c4 like '%890%';
29 A    6.442854 : SELECT COUNT(*) FROM t1 WHERE c5 like '%890%';
30 I    5.768264 : SELECT COUNT(*) FROM t1 WHERE c4 like '%123';
31 A    6.303429 : SELECT COUNT(*) FROM t1 WHERE c5 like '%123';
32 I    2.495663 : SELECT COUNT(*) FROM t1;
33 I    0.390959 : SELECT COUNT(pk) FROM t1;
34 A    6.116947 : SELECT COUNT(c1) FROM t1;
35 I    0.431209 : SELECT COUNT(c2) FROM t1;
36 I    3.383081 : SELECT COUNT(c2) FROM t2;
37 A    6.613420 : SELECT COUNT(c3) FROM t1;
38 I    4.064485 : SELECT COUNT(c3) FROM t2;
39 I    3.688296 : SELECT COUNT(c4) FROM t1;
40 I    4.162721 : SELECT COUNT(c4) FROM t2;
41 A    6.203687 : SELECT COUNT(c5) FROM t1;
42 I    1.067514 : SELECT COUNT(c5) FROM t2;
43 A    6.054356 : SELECT COUNT(c6) FROM t1;
44 I    7.068580 : SELECT pk FROM t1 ORDER BY pk LIMIT 10 OFFSET 999990;
45 A    6.530155 : SELECT pk FROM t1 ORDER BY c1 LIMIT 10 OFFSET 999990;
46 I    0.427420 : SELECT pk FROM t1 ORDER BY c2 LIMIT 10 OFFSET 999990;
47 A    6.588856 : SELECT pk FROM t1 ORDER BY c3 LIMIT 10 OFFSET 999990;
48 I    7.701476 : SELECT pk FROM t1 ORDER BY pk DESC LIMIT 10 OFFSET 999990;
49 I    0.700669 : SELECT pk FROM t1 ORDER BY c2 DESC LIMIT 10 OFFSET 999990;
50 I    0.387229 : SELECT c2, COUNT(*) FROM t1 GROUP BY c2;
51 A    5.928128 : SELECT c3, COUNT(*) FROM t1 GROUP BY c3;
52 CC   0.127321 : SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.pk WHERE t1.pk = 5 ORDER BY t1.pk;
53 CA  28.139084 : SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.c1 WHERE t1.pk = 5 ORDER BY t1.pk;
54 GE   0.116812 : SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.pk WHERE t1.pk < 10 ORDER BY t1.pk;
55 GA  30.309197 : SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.c1 WHERE t1.pk < 10 ORDER BY t1.pk;
56 IU 109.030308 : SELECT COUNT(*) FROM t1 WHERE t1.pk IN (SELECT pk FROM t2 WHERE 33 < pk and pk < 77);
57 IG  51.319563 : SELECT COUNT(*) FROM t1 WHERE t1.pk IN (SELECT c1 FROM t2 WHERE 33 < pk and pk < 77);
58 AU  52.305410 : SELECT COUNT(*) FROM t1 WHERE t1.c1 IN (SELECT pk FROM t2 WHERE 33 < pk and pk < 77);
59 AN  21.340231 : SELECT COUNT(*) FROM t1 WHERE t1.c1 IN (SELECT c1 FROM t2 WHERE 33 < pk and pk < 33);
