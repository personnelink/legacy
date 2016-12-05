<%
accessdb=server.mappath("\jobdata\ppi.mdb")
set Connect = server.createobject("ADODB.Connection")
Connect.open "PROVIDER=MICROSOFT.JET.OLEDB.4.0;DATA SOURCE=" & accessdb & ""


' Get states/provinces
dim sqlLocation
dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)



%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body bgcolor="#b0c4de">

<select name="state">
	<option value="" SELECTED>-- SELECT ONE --</option>
	<%	
		do while not rsLocation.eof
		response.Write "<OPTION VALUE='" & rsLocation("locCode") & _
						   "'>" & rsLocation("locCode") & " - " & rsLocation("locName")	
			rsLocation.MoveNext
					
		loop		
	%>
	</select>

</body>
</html>

