<?php 
$link = mysql_connect('localhost','test_user','test_password'); 
if (!$link) { die('Could not connect to MySQL: ' . mysql_error()); } 

$simtable = "sim";
$simtable_num = 4;
$sql = "select * from simsql." . $simtable . $simtable_num;
$result = mysql_query($sql);
if (!$result) { echo "stuff done broke"; }

//Get stuff from SQL to arrays
$i = 0;
while ( $row = mysql_fetch_array($result)) {
	$Field[$i] = $row['Field'];
	$Data[$i] = $row['Data'];
	//Calculate derivative
	if ( $i > 1 ) {	$Epr[$i] = ($Data[$i] - $Data[$i-1]) / ($Field[$i] - $Field[$i-1]); }
	else { $Epr[$i] = 0; }
	$i++;
}
$num_rows = $i;
$field_max = max($Field);
$data_max = max($Data);
$epr_max = max($Epr);

//Initialising strings to go into JavaScript
$fieldstr = "";
$datastr = "";
$absstr = "";
$i = 0;
//Strings to put data into cells for graph
for($i=0;$i<$num_rows;$i++) {
	$fieldstr = $fieldstr . "data.setCell(" . $i . ",0," . $Field[$i] . "); \n";
	$datastr = $datastr . "data.setCell(" . $i . ",1," . ($Epr[$i]/$epr_max) . "); \n";
	//$absstr = $absstr . "data.setCell(" . $i . ",2," . ($Data[$i]/$data_max) . "); \n";
}
?> 

<html>
  <head>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
	    google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		
		function drawChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('number','x');
		data.addColumn('number','y');
		data.addRows(<?php echo $num_rows; ?>);
		<?php echo $fieldstr; echo $datastr; ?>
		
		var options = {
          title: 'EPR spectrum',
          hAxis: {title: 'Field', minValue: 0, maxValue: 2},
          vAxis: {title: 'Intensity', minValue: -1, maxValue: 1},
          legend: 'none'
        };		
		
		//Draw data to screen
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
		
		var el = document.getElementByID('params');
		el.innerHTML = 'ggg';
		}
	</script>
</head>
<body>
    <div id="chart_div" style="width: 900px; height: 500px;"></div>
	<div id="params">...</div>
  </body>
</html>