#Searches the parameter table to find parameter setups that don't have a corresponding epr file
dbquery=`mysql -e "select sim_ID from simsql.param_inp2"  -u test_user --password=test_password`
#echo $dbquery
dbquery=($(mysql -utest_user -ptest_password -e "select sim_ID from simsql.param_inp2"))
echo ${#dbquery[@]}

for ((i=1; i<=${#dbquery[@]}; i++ ))
	do 
	simlines=($(mysql -utest_user -ptest_password -e "select * from simsql.sim$i"))
	#echo ${#simlines[@]}
	if [ ${#simlines[@]} == 0 ]
	then
		deleterow=`mysql -e "delete from simsql.param_inp2 where sim_ID=$i"  -u test_user --password=test_password`
		droptable=`mysql -e "drop table simsql.sim$i"  -u test_user --password=test_password`
		echo $i
	fi
done