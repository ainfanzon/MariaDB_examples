#!/bin/bash

#
# Creates a table and starts inserting and reading values from it outside of a
# transaction with autocommit=1.
#

mysql -u maxuser -pletmein -h 172.20.0.5 -P 3306 -e "CREATE OR REPLACE TABLE test.t1 (id int);"

i=0
while [ $? -eq 0 ]
do
    echo "INSERT INTO test.t1 VALUES ($i);"
    echo -e "SELECT @@hostname, id, IF(COUNT(*)> 0, '\033[0;32mFound\033[0m','\033[0;31m       Not Found\033[0m' ) FROM test.t1 WHERE id = $i;"
    i=$((i+1))
done | mysql -N -u maxuser -pletmein -h 172.20.0.5 -P 3306
