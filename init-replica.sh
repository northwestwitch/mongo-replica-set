#!/bin/bash

DB1_PORT=27011
DB2_PORT=27012
DB3_PORT=27013

LOCAL_HOST="127.0.0.1"

RS_MEMBER_1="{ \"_id\": 0, \"host\": \"${LOCAL_HOST}:${DB1_PORT}\", \"priority\": 2 }"
RS_MEMBER_2="{ \"_id\": 1, \"host\": \"${LOCAL_HOST}:${DB2_PORT}\", \"priority\": 0 }"
RS_MEMBER_3="{ \"_id\": 2, \"host\": \"${LOCAL_HOST}:${DB3_PORT}\", \"priority\": 0 }"

sleep 30
mongo --eval "rs.initiate({ \"_id\": \"rs0\", \"members\": [${RS_MEMBER_1}, ${RS_MEMBER_2}, ${RS_MEMBER_3}] });"
