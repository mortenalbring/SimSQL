#Makes some temporary files
>dbquery.tmp
>fielddatapoint.tmp
#Loops over the number of parameter files
for i in `seq 1 694`;
do 
testid=$i
#Creates a table with the name sim-number- where -number- is the ID of the sim
mysql -B -s -e "create table simsql.sim$testid ( Field FLOAT, Data FLOAT )" -u test_user --password=test_password 
#Queries the database to get the epr spectrum that corresponds to that sim ID
dbquery=`mysql -B -s -e "select output_epr from simsql.param_inp2 where sim_ID=$testid" -u test_user --password=test_password`
filepath=${PWD}/$dbquery
#Writes the sim file and path to a temporary file ordered by sim ID
echo $filepath >> dbquery.tmp
done

testid=0;
#Reads through dbquery.tmp
while read line
do
	let testid++
	echo $testid
	#Reads through the simulation file
	while read d
	do
		echo $d
		>fielddatapoint.tmp
		#For every pair of (Field,Data) point, writes that pair to a temp file
		echo ${d:0:23} >> fielddatapoint.tmp
		echo ${d:23} >> fielddatapoint.tmp
		#Load that pair into database
		mysql -e "load data infile 'fielddatapoint.tmp' into table simsql.sim$testid FIELDS TERMINATED BY '\n' (Field,Data)" -u test_user --password=test_password
	done < $line
done < dbquery.tmp
