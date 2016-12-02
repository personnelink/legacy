<!DOCTYPE HTML>
<html>
<head>
<title>Time Clock: Clocked In</title>
<link href="timeclock.css" rel="stylesheet" type="text/css" />
<!-- Redirect site and countdown -->
	<META http-equiv="refresh" content="5;URL=index.php"> 
</head>
<body>
<div id="header"> </div>
<div id="container">
<?php
if (empty($_POST['BadgeID']))
	echo "<p>Card failed to read. Try again.</p>";
	else 
	{
	$DBConnect = @mysql_connect("localhost", "root", "");
	if ($DBConnect === FALSE) 
		echo "<p>Unable to connect to the database server.</p>" . "<p>Error code " . mysql_errno() . ": " . mysql_error() . "</p>";
		else 
		{
			$DBName = "time_clock";
				if (!@mysql_select_db($DBName, $DBConnect)) {
					$SQLstring = "CREATE DATABASE $DBName";
					$QueryResult = @mysql_query($SQLstring, $DBConnect);
					if ($QueryResult === FALSE)
						echo "<p>Unable to execute the query.</p>" . "<p>Error code " . mysql_errno($DBConnect) . ": " . mysql_error($DBConnect) . "</p>";
					else 
						echo "<p>You are the first employee to clock in.</p>";
				}
				mysql_select_db($DBName, $DBConnect);
				
				$TableName = "TimeClock";
				$SQLstring = "SHOW TABLES LIKE '$TableName'";
				$QueryResult = @mysql_query($SQLstring, $DBConnect);

				if (mysql_num_rows($QueryResult) == 0) {
					$SQLstring = "CREATE TABLE $TableName (BadgeID VARCHAR(40), siteCode VarChar(10), jobCode VARCHAR(10), Time VARCHAR(40), Date VARCHAR(40),InorOut VARCHAR(10))";
															
					$QueryResult = @mysql_query($SQLstring, $DBConnect);
					if ($QueryResult === FALSE){
						echo "<p> Unable to create the table.</p>" . "<p>Error code " . mysql_errno($DBConnect) . ": " . mysql_error($DBConnect) . "</p>";
						} else{
							echo "<p>Table created</p>";}
				}	
			$BadgeID = stripslashes($_POST['BadgeID']);
			$SiteCode = $_POST['siteCode'];
			$JobCode = $_POST['jobCode'];			
			$d=strtotime("-8 hour");
			$e=strtotime("-1 day");
			$Time = date("h:i:s a", $d);
			$Date = date("Y-m-d", $e);
			$InOrOut = $_POST['InorOut'];
					
			$SQLstring = "INSERT INTO $TableName VALUES('$BadgeID','$SiteCode','$JobCode','$Time','$Date','$InOrOut')";
			$QueryResult = @mysql_query($SQLstring, $DBConnect);
			if ($QueryResult === FALSE)
				{
					echo "<p>Unable to execute the query.</p>" . "<p>Error code " . mysql_errno($DBConnect) . ": " . mysql_error($DBConnect) . "</p>";
				}
				elseif ($InOrOut == 'clock_in')
				{				
					echo "<h1>You have successfully clocked-in. Have a good day!</h1>";
				}
				else 
				{
					echo "<h1>You have successfully clocked-out. Have a good day!</h1>";
				}
		}
	}
	
?>

</div>
<footer>
	<div>
		<div style="text-align:center;">

		<p>&copy;
			<script type="text/javascript">
			<!--
				tday=new Date();
				yr0=tday.getFullYear();
			// end hiding -->
			</script>
			<script type="text/javascript">
			<!-- Hide from old browsers
				document.write(yr0);
			// end hiding -->
			</script>
			Personnel Plus, Inc. All Rights Reserved. </p>
		</div>
	</div>
</footer>
</body>