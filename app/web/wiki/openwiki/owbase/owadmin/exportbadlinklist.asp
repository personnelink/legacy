<%@ Language=VBScript EnableSessionState=False %>
<% RESPONSE.BUFFER=TRUE %>

<!-- #include virtual="/ow/owpreamble.asp" //-->
<!-- #include virtual="/ow/owconfig_default.asp" //-->
<!-- #include virtual="/ow/owado.asp" //-->

<%
'	$Log: exportbadlinklist.asp,v $
'	Revision 1.2  2006/03/08 02:07:20  gbamber
'	#includes changed to virtual
'	
'	Revision 1.1  2005/12/10 08:29:55  gbamber
'	Moved to owadmin folder
'	
'	Revision 1.5  2004/10/22 10:10:13  gbamber
'	BUGFIX: Import under MSAcess
'	
'	Revision 1.4  2004/07/18 10:58:34  gbamber
'	Log Added
'	

'	// DECLARES AND INITS //
Dim oConn,tConn,oRs,tRs,oSQL,tSQL,FSO,csvFile,aName,aURL,badlinklist_Folder,badlinklist_Filename,badlinklist_Path,ct
Set FSO = Server.CreateObject("Scripting.FileSystemObject")
Set oConn = Server.CreateObject("ADODB.Connection")
Set oRS = Server.CreateObject("ADODB.Recordset")
oConn.Open OPENWIKI_DB
Set tConn = Server.CreateObject("ADODB.Connection")
Set tRS = Server.CreateObject("ADODB.Recordset")
badlinklist_Folder=Server.MapPath("../plugins") & "\"
badlinklist_Filename="badlinklist.csv"
badlinklist_Path=badlinklist_Folder & badlinklist_Filename
ct=0

'	// Open the textfile driver
tConn.Open "Driver={Microsoft Text Driver (*.txt; *.csv)};" & _
    "Dbq=" & badlinklist_Folder & ";" & _
    "Extensions=asc,csv,tab,txt"

'	// Set up the CSV file
Set csvFile=FSO.CreateTextFile(badlinklist_Path,TRUE)
csvFile.WriteLine("""bll_name"",""bll_comment""")
csvFile.Close
Set csvFile=Nothing
%>
<html>
<head>
	<title>Export badlinklist to csv Page</title>
	<link rel="stylesheet" type="text/css" href="../css/ow.css" />
</head>
<body>
<p>
<%    
'	// Initial report
Response.Write("<h2>badlinklist Export to CSV File</h2><hr />")
If (Request.Form("submitted")="yes") AND (Request.Form("password")=gAdminPassword) then
		Response.Write("Creating " & badlinklist_Path & "...<br />Please wait. working..")
		Response.Flush
		
		'	// Open a recordset of the badlinklists    
		oSQL="SELECT * FROM openwiki_badlinklist ORDER BY bll_name ASC;"
		oRS.Open oSQL, oConn, adOpenForwardOnly
		
		'	// Loop through, and write to badlinklist_Filename
		Do While Not oRS.EOF
			aName=oRs.Fields("bll_name")
            aName=Replace(aName, "''", "'")

			aComment=oRs.Fields("bll_comment")
            aComment=Replace(aComment, "''", "'")
			tSQL="INSERT INTO " & badlinklist_Filename & " VALUES('" &_
			aName & "','" & aComment & "');"
			tConn.Execute(tSQL)
			Response.Write(".")
			Response.Flush
			ct=ct+1
			oRs.MoveNext
		Loop
		oRS.Close
	
	
		'	// Final report
		Response.Write("<br />Done! " & ct & " entries successfully written.")
		Response.Write("<br />CSV file: <a href='../plugins/" & badlinklist_Filename & "'>" & badlinklist_Filename & "</a>")
		Response.Write("<hr /><small>Export Facility by <a href='mailto:openwiking@gmail.com'>OpenWikiNG team</a> &copy;2004 GPL license</small>")
Else
%>
<p>
Click the button to export the badlinklist links from database to csv file
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