#!/bin/bash
testid=622
dbquery=`mysql -B -s -e "select output_epr from simsql.param_inp2 where sim_ID=$testid" -u test_user --password=test_password`
echo $dbquery
echo $testid
echo "Hello world $testid"