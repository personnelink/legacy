<%@ Language=VBScript EnableSessionState=False %>
<% RESPONSE.BUFFER=TRUE %>

<!-- #include file="../owpreamble.asp" //-->
<!-- #include file="../owconfig_default.asp" //-->
<!-- #include file="../owado.asp" //-->

<%
'	$Log: importbadlinklist.asp,v $
'	Revision 1.6  2005/12/02 10:10:39  gbamber
'	Fixed bug in code
'	
'	Revision 1.5  2004/10/22 10:10:13  gbamber
'	BUGFIX: Import under MSAcess
'	
'	Revision 1.4  2004/07/18 10:58:34  gbamber
'	Log Added
'	
'        // DECLARES AND INITS //
Dim oConn,tConn,oRs,tRs,oSQL,tSQL,FSO,csvFile,aName,aURL,badlinklist_Folder,badlinklist_Filename,badlinklist_Path,ct
Dim Success,sz
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
'        // Open the textfile driver
tConn.Open "Driver={Microsoft Text Driver (*.txt; *.csv)};" & _
    "Dbq=" & badlinklist_Folder & ";" & _
    "Extensions=asc,csv,tab,txt;" &_
    "Format=CSVDelimited;" &_
    "ColNameHeader = true;"

%>
<html>
<head>
 <title>Import Bad Link List from csv Page</title>
 <link rel="stylesheet" type="text/css" href="../ow/css/ow.css" />
</head>
<body>
<p>
<%
'        // Initial report
Response.Write("<h2>Bad Link List Import from CSV File</h2><hr />")
If (Request.Form("submitted")="yes") AND (Request.Form("password")=gAdminPassword) then
    Response.Write("Importing from " & badlinklist_Path & "...<br />Please wait. working..")
    Response.Flush

    Success=False
    'On Error Resume Next
    If FSO.FileExists(badlinklist_Path) then
            '        // Open a recordset of the badlinklists
            tSQL="SELECT DISTINCT * FROM " & badlinklist_Filename & ";"
            tRS.Open tSQL, tConn, adOpenForwardOnly
            oConn.BeginTrans()
            If OPENWIKI_DB_SYNTAX = DB_SQLSERVER then
				oConn.Execute("DELETE openwiki_badlinklist;")
			else
	            oConn.Execute("DELETE * FROM openwiki_badlinklist;")
			end if
            '        // Loop through, and write to badlinklist_Filename
            Do While Not tRS.EOF
                    aName=Trim(tRs.Fields("bll_name"))
                    aName=Replace(aName, "'", "''")
                    aComment=Trim(tRs.Fields("bll_comment"))
                    if LEN(aComment) > 0 then
						aComment=Replace(aComment, "'", "''")
					else
						aComment="chongqed.org"
					end if
'//DEBUGGING LINE//					RESPONSE.WRITE("bll_name=" & aName & "<BR>")
                    oSQL="INSERT INTO openwiki_badlinklist (bll_name,bll_comment)VALUES('" &_
                    aName & "','" & aComment & "');"
                    oConn.Execute(oSQL)
                    Response.Write(".")
                    Response.Flush
                    ct=ct+1
                    tRs.MoveNext
            Loop
            tRS.Close
            If oConn.Errors.Count=0 then
                    oConn.CommitTrans()
                    Success=True
            Else
                    oConn.RollbackTrans()
            End If
    End If
    If Success=True then
            '        // Final report
            Response.Write("<br />Success! " & ct & " entries successfully read.")
            Response.Write("<hr /><small>Import Facility by <a href='mailto:openwiking@gmail.com'>OpenWikiNG team</a> &copy;2004 GPL license</small>")
    Else
            Response.Write("<br />Sorry - there was an error!  Quitting.")
            Response.Write("<hr /><small>Import Facility by <a href='mailto:openwiking@gmail.com'>OpenWikiNG team</a> &copy;2004 GPL license</small>")
    End If
Else
%>
<p>
Click the button to import the badlinklist links from csv file to database
</p>
<form name="theform" method="POST">
 <input type="hidden" name="submitted" value="yes">
 Admin password (required): <input type="password" name="password">
 <br /><input type="submit" name="doit" value="Import">
</form>
<%
End If
%>
</p>
</body>
</html>
<%
'        // TIDY UP
set tConn = Nothing
set oConn = Nothing
set FSO = Nothing
set tRs = Nothing
set oRs = Nothing
%>