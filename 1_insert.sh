#!/bin/sh

# 0 --> 15,624 のプライマリキーを生成する。
generate_primary_key() {

  VAL_PK="0"

  while [ ${VAL_PK} -le 15624 ]
  do
    echo "${VAL_PK}"
    VAL_PK=$((++VAL_PK))
  done
}

# 1,000文字の文字列を生成する。
VAL_TEXT="0123456789012345678901234567890123456789"
VAL_TEXT="${VAL_TEXT}${VAL_TEXT}${VAL_TEXT}${VAL_TEXT}${VAL_TEXT}"
VAL_TEXT="${VAL_TEXT}${VAL_TEXT}${VAL_TEXT}${VAL_TEXT}${VAL_TEXT}"

# 15,625行のINSERT文を生成する。
BASE_SQL=`generate_primary_key \
  | sed -E -e "s/(.*(.))$/\1,\ \1,\ \2,\ \2,\ '\2',\ '\2'/" \
  | sed -E -e "s/\ 0,/\ NULL,/g" \
  | sed -E -e "s/'0'/'0123456789'/g" \
  | sed -E -e "s/'1'/'1234567890'/g" \
  | sed -E -e "s/'2'/'2345678901'/g" \
  | sed -E -e "s/'3'/'3456789012'/g" \
  | sed -E -e "s/'4'/'4567890123'/g" \
  | sed -E -e "s/'5'/'5678901234'/g" \
  | sed -E -e "s/'6'/'6789012345'/g" \
  | sed -E -e "s/'7'/'7890123456'/g" \
  | sed -E -e "s/'8'/'8901234567'/g" \
  | sed -E -e "s/'9'/'9012345678'/g" \
  | sed -E -e "s/(.*)/INSERT INTO tt (pk, c1, c2, c3, c4, c5, c6) values (\1, '${VAL_TEXT}');/"`

# 生成した INSERT文を実行し、64倍にする。
insert_all() {

  TABLE=$1
  SQL=`echo "${BASE_SQL}" | sed s/tt/${TABLE}/`
  
  echo "-- ${TABLE} --"
  echo "TRUNCATE ${TABLE};" | mysql -uroot test

  # 開始時刻
  TS_START="`date '+%s'`"

  # 実行
  mysql -uroot test<<EOF
SET autocommit = 1;
${SQL}
INSERT INTO ${TABLE} (pk, c1, c2, c3, c4, c5, c6)
  SELECT pk + 15625, c1 + 15625, c2, c3, c4, c5, c6 FROM ${TABLE};
INSERT INTO ${TABLE} (pk, c1, c2, c3, c4, c5, c6)
  SELECT pk + 15625 * 2, c1 + 15625 * 2, c2, c3, c4, c5, c6 FROM ${TABLE};
INSERT INTO ${TABLE} (pk, c1, c2, c3, c4, c5, c6)
  SELECT pk + 15625 * 4, c1 + 15625 * 4, c2, c3, c4, c5, c6 FROM ${TABLE};
INSERT INTO ${TABLE} (pk, c1, c2, c3, c4, c5, c6)
  SELECT pk + 15625 * 8, c1 + 15625 * 8, c2, c3, c4, c5, c6 FROM ${TABLE};
INSERT INTO ${TABLE} (pk, c1, c2, c3, c4, c5, c6)
  SELECT pk + 15625 * 16, c1 + 15625 * 16, c2, c3, c4, c5, c6 FROM ${TABLE};
INSERT INTO ${TABLE} (pk, c1, c2, c3, c4, c5, c6)
  SELECT pk + 15625 * 32, c1 + 15625 * 32, c2, c3, c4, c5, c6 FROM ${TABLE};
EOF

  # 所要時間
  ELAPSED="$(( `date '+%s'` - ${TS_START} ))"
  echo "${ELAPSED} sec."
  echo "$(( ${ELAPSED} * 1000000 / 1000000 )) microsec./行"
}

LOG_FILE="`pwd`/log/1_insert.log"

insert_all t1 | tee ${LOG_FILE}
insert_all t2 | tee -a ${LOG_FILE}
