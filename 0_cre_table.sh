#!/bin/sh

mysql -uroot test --table<<EOF

DROP TABLE IF EXISTS t1;

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

DROP TABLE IF EXISTS t2;

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
EOF
