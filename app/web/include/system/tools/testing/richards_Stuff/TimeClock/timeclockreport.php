<!DOCTYPE HTML>
<html>
<head>
<title>Employee Records</title>
<link href="timeclockReports.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="container">
<header>
	<img src="banner.png">
</header>

<?php
$DBConnect = @mysql_connect("localhost", "root", "");
if ($DBConnect === FALSE)
	echo "<p>Unable to connect to the database server.</p>" . "<p>Error code " . mysql_errno() . ": " . mysql_error() . "</p>";
	else {
		$DBName = "mastertimeclock";
		if (!@mysql_select_db($DBName, $DBConnect))
			echo "<p>There are no entries in the employee report!</p>";
			else {
				$TableName = "timeclock";
				$firstField = "siteCode";
				$secondField = "badgeid";
				$thirdField = "InorOut";
				$SQLstring = "SELECT * FROM $TableName ORDER BY $firstField,$secondField,$thirdField ASC;";
				$QueryResult = @mysql_query($SQLstring, $DBConnect);
				if (mysql_num_rows($QueryResult) == 0)
					echo "<p>There are no entries in the time clock.</p>";
					else {
						echo "<h1><p>The following employees have used the time clock:</p></h1>";
						echo "<table width='100%' border='1'>";
						echo "<tr><th>Badge ID</th><th>Site Code</th><th>Job Code</th><th>Date_time</th><th>In or Out</th></tr>";
						while (($Row = mysql_fetch_assoc($QueryResult)) !== FALSE) {
							echo "<tr><td style='width:10%'>{$Row['BadgeID']}</td>";
							echo "<td style='width:10%'>{$Row['siteCode']}</td>";
							echo "<td style='width:10%'>{$Row['jobCode']}</td>";
							echo "<td>{$Row['Date_Time']}</td>";
							echo "<td style='width:10%'>{$Row['InorOut']}</td></tr>";
						}
					}
					mysql_free_result($QueryResult);
			}
				mysql_close($DBConnect);
	}
?>


<div>
<?php
	include 'reportbuttons.php';
?>
</div>
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
</html>