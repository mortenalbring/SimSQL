testid=622
dbquery=`mysql -B -s -e "select output_epr from simsql.param_inp2 where sim_ID=$testid" -u test_user --password=test_password`
echo $dbquery
mysql -B -s -e "create table simsql.sim$testid ( Field FLOAT, Data FLOAT )" -u test_user --password=test_password 
filename=$dbquery
c=1
while read line
do
let c++
if [ $c -eq 23 ] 
then
echo $line
fi
done < "$filename"

