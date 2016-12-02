<!-- #include file="functions.asp" -->
<%
Response.ContentType = "text/vnd.wap.wml"
Response.Buffer = True

sDate = Request.QueryString("D")
%>
<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
	<head>
		<meta forua="true" http-equiv="pragma"
						   content="no-cache"/>
		<meta forua="true" http-equiv="Cache-Control"
						   content="no-cache, must-revalidate"/>
	</head>
	<card id="start">
		<p align="center"><b><%= sDate %></b></p>
<%
If isDate(sDate) then
	iDay   = Day(cDate(sDate))
	iMonth = Month(cDate(sDate))
	iYear  = Year(cDate(sDate))
	Call OpenDB()
	sSQL = "SELECT * FROM Calendar WHERE Day = " & iDay & " AND Month = " & iMonth & " AND Year = " & iYear
	Call OpenRORS(sSQL)
	If objRS.EOF then
		Response.Write "<p>No events are scheduled for " & sDate & ".</p>"
	else
		Dim iCounter
		iCounter = 1
		While not objRS.EOF
			Response.Write "<p><a href='event.asp?ID=" & objRS("ID") & "'>" & objRS("Subject") & "</a></p>"
			objRS.MoveNext
			iCounter = iCounter + 1
		wend
	end if

	Call CloseRS()
	Call CloseDB()
Else
	Response.Write "<p>The criteria you entered is not a valid date.</p>"
End if
%>
		<do type="options" label="Home">
			<go href="Default.asp#start" />
		</do>
	</card>
</wml>