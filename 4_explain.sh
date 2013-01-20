#!/bin/sh

LOG_FILE="`pwd`/log/4_explain.log"

mysql -uroot test --verbose --table<<EOF | tee ${LOG_FILE}
EXPLAIN SELECT c1 FROM t1 WHERE pk = 555;
EXPLAIN SELECT pk FROM t1 WHERE pk = 555;
EXPLAIN SELECT c1 FROM t1 WHERE c1 = 555;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c2 = 5;
EXPLAIN SELECT COUNT(*) FROM t2 WHERE c2 = 5;
EXPLAIN SELECT COUNT(c2) FROM t1 WHERE c2 = 5;
EXPLAIN SELECT COUNT(c3) FROM t1 WHERE c2 = 5;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c3 = 5;
EXPLAIN SELECT COUNT(*) FROM t2 WHERE c3 = 5;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c4 = '5678901234';
EXPLAIN SELECT COUNT(*) FROM t2 WHERE c4 = '5678901234';
EXPLAIN SELECT COUNT(c4) FROM t1 WHERE c4 = '5678901234';
EXPLAIN SELECT COUNT(c5) FROM t1 WHERE c4 = '5678901234';
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c5 = '5678901234';
EXPLAIN SELECT COUNT(*) FROM t2 WHERE c5 = '5678901234';
EXPLAIN SELECT COUNT(*) FROM t1 WHERE 333 < pk and pk < 777;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE 333 < c1 and c1 < 777;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE 3 < c2 and c2 < 7;
EXPLAIN SELECT COUNT(*) FROM t2 WHERE 3 < c2 and c2 < 7;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE 3 < c3 and c3 < 7;
EXPLAIN SELECT COUNT(*) FROM t2 WHERE 3 < c3 and c3 < 7;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE pk IN (333, 555, 777);
EXPLAIN SELECT COUNT(*) FROM t1 WHERE pk = 333 OR pk = 555 OR pk = 777;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c4 like '567%';
EXPLAIN SELECT COUNT(*) FROM t2 WHERE c4 like '567%';
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c5 like '567%';
EXPLAIN SELECT COUNT(*) FROM t2 WHERE c5 like '567%';
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c4 like '%890%';
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c5 like '%890%';
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c4 like '%123';
EXPLAIN SELECT COUNT(*) FROM t1 WHERE c5 like '%123';
EXPLAIN SELECT COUNT(*) FROM t1;
EXPLAIN SELECT COUNT(pk) FROM t1;
EXPLAIN SELECT COUNT(c1) FROM t1;
EXPLAIN SELECT COUNT(c2) FROM t1;
EXPLAIN SELECT COUNT(c2) FROM t2;
EXPLAIN SELECT COUNT(c3) FROM t1;
EXPLAIN SELECT COUNT(c3) FROM t2;
EXPLAIN SELECT COUNT(c4) FROM t1;
EXPLAIN SELECT COUNT(c4) FROM t2;
EXPLAIN SELECT COUNT(c5) FROM t1;
EXPLAIN SELECT COUNT(c5) FROM t2;
EXPLAIN SELECT COUNT(c6) FROM t1;
EXPLAIN SELECT pk FROM t1 ORDER BY pk LIMIT 10 OFFSET 999990;
EXPLAIN SELECT pk FROM t1 ORDER BY c1 LIMIT 10 OFFSET 999990;
EXPLAIN SELECT pk FROM t1 ORDER BY c2 LIMIT 10 OFFSET 999990;
EXPLAIN SELECT pk FROM t1 ORDER BY c3 LIMIT 10 OFFSET 999990;
EXPLAIN SELECT pk FROM t1 ORDER BY pk DESC LIMIT 10 OFFSET 999990;
EXPLAIN SELECT pk FROM t1 ORDER BY c2 DESC LIMIT 10 OFFSET 999990;
EXPLAIN SELECT c2, COUNT(*) FROM t1 GROUP BY c2;
EXPLAIN SELECT c3, COUNT(*) FROM t1 GROUP BY c3;
EXPLAIN SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.pk WHERE t1.pk = 5 ORDER BY t1.pk;
EXPLAIN SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.c1 WHERE t1.pk = 5 ORDER BY t1.pk;
EXPLAIN SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.pk WHERE t1.pk < 10 ORDER BY t1.pk;
EXPLAIN SELECT t1.pk FROM t1 JOIN t2 ON t1.c2 = t2.c1 WHERE t1.pk < 10 ORDER BY t1.pk;
EXPLAIN SELECT COUNT(*) FROM t1 WHERE t1.pk IN (SELECT pk FROM t2 WHERE 33 < pk and pk < 77);
EXPLAIN SELECT COUNT(*) FROM t1 WHERE t1.pk IN (SELECT c1 FROM t2 WHERE 33 < pk and pk < 77);
EXPLAIN SELECT COUNT(*) FROM t1 WHERE t1.c1 IN (SELECT pk FROM t2 WHERE 33 < pk and pk < 77);
EXPLAIN SELECT COUNT(*) FROM t1 WHERE t1.c1 IN (SELECT c1 FROM t2 WHERE 33 < pk and pk < 33);
EOF