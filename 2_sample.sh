#!/bin/sh

LOG_FILE="`pwd`/log/2_sample.log"

mysql -uroot test --table<<EOF | tee ${LOG_FILE}

DESC t1;
SHOW INDEX FROM t1;

SELECT pk, c1, c2, c3, c4, c5, CONCAT(SUBSTR(c6, 1, 12), '... (',
 FORMAT(CHAR_LENGTH(c6), 0), ')') "c6 (length)" FROM t1 WHERE pk < 15 ORDER BY pk;
SELECT COUNT(*) FROM t1;

DESC t2;
SHOW INDEX FROM t2;

SELECT pk, c1, c2, c3, c4, c5, CONCAT(SUBSTR(c6, 1, 12), '... (',
 FORMAT(CHAR_LENGTH(c6), 0), ')') "c6 (length)" FROM t2 WHERE pk < 15 ORDER BY pk;
SELECT COUNT(*) FROM t2;
EOF

