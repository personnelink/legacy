<!DOCTYPE HTML>
<html>
<head>

</head>
<body>
<?php
$DBConnect = @mysql_connect("localhost", "TempPERSQL", "onlyme");			
	if ($DBConnect === FALSE)
	echo "<p>Unable to connect to the database server.</p>" . "<p>Error code " . mysql_errno() . ": " . mysql_error() . "</p>";
	else {
		$DBName = "alignment_survey";
		if (!@mysql_select_db($DBName, $DBConnect))
			echo "<p>There are no entries in the applicant report!</p>";
			else {
				$TableName = "characters";
				$SQLstring = "SELECT Applicants.LastnameFirst, Applicants.City, Applicants.State, Applicants.Zip, Applicants.Telephone, Applicants.k, KeyDictionary.KeywordId, Applicants.ApplicantId FROM KeyDictionary INNER JOIN (Applicants INNER JOIN KeysApplicants ON Applicants.ApplicantID = KeysApplicants.ApplicantId)ON KeyDictionary.KeywordId = KeysApplicants.KeywordId WHERE (((KeyDictionary.KeywordId)=1627)) ORDER BY Applicants.LastnameFirst;";
				$QueryResult = @mysql_query($SQLstring, $DBConnect);
				if (mysql_num_rows($QueryResult) == 0){
					echo "<h1>There are no entries in the survey!</h1>";
				}else {
						echo "<h1><p>The following players have used our survey:</p></h1>";
						echo "<table width='100%' border='1'>";
						echo "<tr><th>Character Name</th><th>Race</th><th>Class</th><th>Gender</th><th>Alignment</th></tr>";
						while (($Row = mysql_fetch_assoc($QueryResult)) !== FALSE) {
							echo "<tr><td>{$Row['name']}</td>";
							echo "<td>{$Row['race']}</td>";
							echo "<td>{$Row['class']}</td>";
							echo "<td>{$Row['gender']}</td>";
							echo "<td>{$Row['alignment']}</td></tr>";
						}
					}
					mysql_free_result($QueryResult);
			}
				mysql_close($DBConnect);
	}
?>	
</body>
</html>