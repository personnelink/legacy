<%
' // DEV
dim DBName,DBUser,DBPass,objRS,Connect

' // DEV
'DBName="maindata" 
'DBUser="root" 
'DBPass="" 
' \\ DEV

' // iPowerWeb
DBName="personn0_maindata" 
DBUser="personn0_gus" 
DBPass="12345678" 
'DBName="personn0_maindata" 
'DBUser="online" 
'DBPass=".SystemUse" 
' \\ iPowerWeb
Set Connect=Server.CreateObject("ADODB.Connection") 
'Connect.ConnectionString="DRIVER={MySQL ODBC 3.51 Driver};Server=x.personnelplus.net;port=6612;Option=16386;Database=personn0_maindata;User ID=online;Password=.SystemUse" 
Connect.ConnectionString="DRIVER={MySQL ODBC 3.51 Driver};Server=personn0.ipowermysql.com;Database="&DBName&";UID="&DBUser&";pwd="&DBPass&";OPTION=16386" 
Connect.Open 
' // ConvertString Function
Public Function ConvertString(strIn) 
	' convert "'" in strings to "''"
	dim intPos, strOut
	strOut = ""
	intPos = InStr(strIn, "'")
	Do Until intPos = 0
		strOut = strOut + Mid(strIn, 1, intPos) + "'"
		strIn = Mid(strIn, intPos + 1)
		intPos = InStr(strIn, "'")
	loop
	strOut = strOut & strIn
	ConvertString = strOut
End Function
%>