<!DOCTYPE HTML>
<html>
<head>
	<link href="timeclock.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="includes/jQuery-1.10.2.min.js"></script>
	
	
<title>Personnel Plus Time Clock</title>
</head>

<body>
<?php
	include 'includes/javascript.js';
?>


<div id="primary">

	<div id="container" >
		<img src="banner.png">
	<div id="time">
	<br><br>
	<h2><p>Current Date and Time</p></h2>
	<p id="time"></p>
		<script>document.getElementById("time").innerHTML = Date();</script>
	</div>
	<br><br>
	<form method="POST" action="Clockin.php">
		<fieldset>
			<legend>Clock-In or Clock-Out</legend>
				<ul>
					<li>
					<label onclick="showdiv('clockin');">
						<input id="InorOut" type="radio" name="InorOut" value="clock_in"  tabindex="14">Clock-In</label>
					<label onclick="hidediv('clockin');">
						<input id="InorOut" type="radio" name="InorOut" value="clock_out"  tabindex="15">Clock-Out</label>
					</li>
				</ul>
		</fieldset>
		<fieldset hidden>
			<input type="radio" name="siteCode" value="siteCode" checked />
		</fieldset>
		<fieldset>			
			<div id="clockin" class="hide"style="display:none;">
				<h3>Choose Job Code</h3>
				<input type="radio" name="jobCode" value="none_selected" checked hidden />
				<p><h4>Job Code ID: &nbsp;</h4></p><!--change the value to match the job code for the client and then the Example# for the job name uncomment them to make them live-->
				<p><input type="radio" name="jobCode" value="Example 1"/> &nbsp;Example 1</br></p>
				<p><input type="radio" name="jobCode" value="Example 2"/> &nbsp;Example 2</br></p>
				<p><input type="radio" name="jobCode" value="Example 3"/> &nbsp;Example 3</br></p>
				<p><input type="radio" name="jobCode" value="Example 4"/> &nbsp;Example 4</br></p>
				<p><input type="radio" name="jobCode" value="Example 5"/> &nbsp;Example 5</br></p>
				<!--
				<p><input type="radio" name="jobCode" value="Example 6"/> &nbsp;Example 6</br></p>
				<p><input type="radio" name="jobCode" value="Example 7"/> &nbsp;Example 7</br></p>
				<p><input type="radio" name="jobCode" value="Example 8"/> &nbsp;Example 8</br></p>
				<p><input type="radio" name="jobCode" value="Example 9"/> &nbsp;Example 9</br></p>
				<p><input type="radio" name="jobCode" value="Example 10"/> &nbsp;Example 10</br></p>
				-->
			</div>		
				<p>Badge ID: &nbsp;<input type="text" name="BadgeID" /></p>

				<p><input type="submit" value="Submit" />
				<button type="reset"><b>Reset the form!</b></button>			
		</fieldset>
	</form>
		
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