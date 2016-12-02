<%@ Language=VBScript EnableSessionState=False %>
<% RESPONSE.BUFFER=TRUE %>

<!-- #include virtual="/ow/owpreamble.asp" //-->
<!-- #include virtual="/ow/owconfig_default.asp" //-->
<!-- #include virtual="/ow/owado.asp" //-->

<%
'	// DECLARES AND INITS //
Dim oConn,tConn,oRs,tRs,oSQL,tSQL,FSO,csvFile,aName,aURL,interwiki_Folder,interwiki_Filename,interwiki_Path,ct
Set FSO = Server.CreateObject("Scripting.FileSystemObject")
Set oConn = Server.CreateObject("ADODB.Connection")
Set oRS = Server.CreateObject("ADODB.Recordset")
oConn.Open OPENWIKI_DB
Set tConn = Server.CreateObject("ADODB.Connection")
Set tRS = Server.CreateObject("ADODB.Recordset")
interwiki_Folder=Server.MapPath("../owadmin") & "\"
interwiki_Filename="interwiki.csv"
interwiki_Path=interwiki_Folder & interwiki_Filename
ct=0

'	// Open the textfile driver
tConn.Open "Driver={Microsoft Text Driver (*.txt; *.csv)};" & _
    "Dbq=" & interwiki_Folder & ";" & _
    "Extensions=asc,csv,tab,txt"

'	// Set up the CSV file
Set csvFile=FSO.CreateTextFile(interwiki_Path,TRUE)
csvFile.WriteLine("""wik_name"",""wik_url""")
csvFile.Close
Set csvFile=Nothing
%>
<html>
<head>
	<title>Export InterWiki to csv Page</title>
	<link rel="stylesheet" type="text/css" href="../ow/css/ow.css" />
</head>
<body>
<p>
<%    
'	// Initial report
Response.Write("<h2>InterWiki Export to CSV File</h2><hr />")
If (Request.Form("submitted")="yes") AND (Request.Form("password")=gAdminPassword) then
		Response.Write("Creating " & interwiki_Path & "...<br />Please wait. working..")
		Response.Flush
		
		'	// Open a recordset of the InterWikis    
		oSQL="SELECT * FROM openwiki_interwikis ORDER BY wik_name ASC;"
		oRS.Open oSQL, oConn, adOpenForwardOnly
		
		'	// Loop through, and write to interwiki_Filename
		Do While Not oRS.EOF
			aName=oRs.Fields("wik_name")
			aURL=oRs.Fields("wik_url")
			tSQL="INSERT INTO " & interwiki_Filename & " VALUES('" &_
			aName & "','" & aURL & "');"
			tConn.Execute(tSQL)
			Response.Write(".")
			Response.Flush
			ct=ct+1
			oRs.MoveNext
		Loop
		oRS.Close
	
	
		'	// Final report
		Response.Write("<br />Done! " & ct & " entries successfully written.")
		Response.Write("<br />CSV file: <a href='../ow/" & interwiki_Filename & "'>" & interwiki_Filename & "</a>")
		Response.Write("<hr /><small>Export Facility by <a href='mailto:openwiking@gmail.com'>OpenWikiNG team</a> &copy;2004 GPL license</small>")
Else
%>
<p>
Click the button to export the InterWiki links from database to csv file
</p>
<form name="theform" method="POST">
 <input type="hidden" name="submitted" value="yes">
 Admin password (required): <input type="password" name="password">
 <br /><input type="submit" name="doit" value="Export">
</form>
<%
End If
%>
</p>
</body>
</html>
<%
'	// TIDY UP
set tConn = Nothing
set oConn = Nothing
set FSO = Nothing
set tRs = Nothing
set oRs = Nothing
%>