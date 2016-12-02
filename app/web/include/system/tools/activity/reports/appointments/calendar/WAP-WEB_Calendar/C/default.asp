<!-- #include file="functions.asp" -->
<% 
Response.ContentType = "text/vnd.wap.wml"
Response.Buffer = True

'=====================================
'FUNCTION: GetDaysInMonth
'		   Returns the Number of days
'          in a month	
'=====================================
Function GetDaysInMonth(iMonth, iYear)
	Select Case iMonth
		Case 1, 3, 5, 7, 8, 10, 12
			GetDaysInMonth = 31
		Case 4, 6, 9, 11
			GetDaysInMonth = 30
		Case 2
			If IsDate("February 29, " & iYear) Then
				GetDaysInMonth = 29
			Else
				GetDaysInMonth = 28
			End If
	End Select
End Function

'Open the Database Connection		
Call OpenDB()

'Set todays date Criteria
Dim iDay, iMonth, iYear
iDay   = Day(Date)
iMonth = Month(Date)
iYear  = Year(Date)
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
		<p align="center" mode="nowrap"><b>Calendar</b></p>
		<p align="center" mode="nowrap"><b><%= formatDateTime(date, 2) %></b></p>
		<p>
			<a href="#today">Today</a>
		</p>
		<p>
			<a href="#tom">Tommorow</a>
		</p>
		<p>
			<a href="EnterDate.asp">Other...</a>
		</p>
		<do type="options" label="Home">
			<go href="default.asp#start" />
		</do>
	</card>
	<card id="today">
		<p><b>Today</b></p>
		<%
		sSQL = "SELECT * FROM Calendar WHERE Day = " & iDay & " AND Month = " & iMonth & " AND Year = " & iYear
		Call OpenRORS(sSQL)
		If objRS.EOF then
			Response.Write "<p>No events are scheduled for today.</p>"
		else
			Dim iCounter
			iCounter = 1
			While not objRS.EOF
				Response.Write "<p><a href='event.asp?ID=" & objRS("ID") & "'>" & objRS("Subject") & "</a></p>"
				objRS.MoveNext
				iCounter = iCounter + 1
			wend
		end if
		objRS.close
		%>
		<do type="options" label="Home">
			<go href="#start" />
		</do>
	</card>
	<card id="tom">
		<p><b>Tomorrow</b></p>
		<%
		sSQL = "SELECT * FROM Calendar WHERE Day = " & (iDay+1) & " AND Month = " & iMonth & " AND Year = " & iYear
		Call OpenRORS(sSQL)
		If objRS.EOF then
			Response.Write "<p>No events are scheduled for tommorrow.</p>"
		else
			'Dim iCounter
			iCounter = 1
			While not objRS.EOF
				Response.Write "<p><a href='event.asp?ID=" & objRS("ID") & "'>" & objRS("Subject") & "</a></p>"
				objRS.MoveNext
				iCounter = iCounter + 1
			wend
		end if
		%>
		<do type="options" label="Home">
			<go href="#start" />
		</do>
	</card>
</wml>
