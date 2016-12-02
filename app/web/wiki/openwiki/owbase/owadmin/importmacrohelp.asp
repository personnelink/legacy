<%@ Language=VBScript EnableSessionState=False %>
<% RESPONSE.BUFFER=TRUE %>
<!-- #include virtual="/ow/owpreamble.asp" //-->
<!-- #include virtual="/ow/owconfig_default.asp" //-->
<!-- #include virtual="/ow/owado.asp" //-->

<%
'        // DECLARES AND INITS //
Dim oConn,tConn,oRs,tRs,oSQL,tSQL,FSO,csvFile,macrohelp_Folder,macrohelp_Filename,macrohelp_Path,ct
Dim aName,aBuiltin,aNumParams,aDescription,aParam1,aParam2,aParam3,aComments
Dim Success
Set FSO = Server.CreateObject("Scripting.FileSystemObject")
Set oConn = Server.CreateObject("ADODB.Connection")
Set oRS = Server.CreateObject("ADODB.Recordset")
oConn.Open OPENWIKI_DB
Set tConn = Server.CreateObject("ADODB.Connection")
Set tRS = Server.CreateObject("ADODB.Recordset")
macrohelp_Folder=Server.MapPath(".") & "\"
macrohelp_Filename="macrohelp.csv"
macrohelp_Path=macrohelp_Folder & macrohelp_Filename
ct=0
'Response.Write(macrohelp_Path)
'Response.End
'        // Open the textfile driver
tConn.Open "Provider=Microsoft.Jet.OLEDB.4.0;" &_
	"Data Source=" & macrohelp_Folder & ";" & _
	"Extended Properties=""text;HDR=Yes;FMT=CSVDelimited""" 

'tConn.Open "Driver={Microsoft Text Driver (*.txt; *.csv)};" & _
'    "Dbq=" & macrohelp_Folder & ";" & _
'    "Extensions=asc,csv,tab,txt;" &_
'    "Format=CSVDelimited;" &_
'    "ColNameHeader = true;"

Function SQLTokenise(vText)
'	// Mash textfields for SQL consumption
	if IsNull(vText) then vText="DEFAULT" '	// This will trigger the DEFAULT value
	SQLTokenise=vText
	if vText="" then Exit Function
'	// VText contains text	
	vText=Replace(vText,"'","''")
	vText=Replace(vText,"^","/^")
'	vText=Server.URLEncode(vText)
	vText=Replace(vText,"""","&quot;")
	'vText=Replace(vText,"/","//")
	SQLTokenise=Trim(vText)
End Function
%>
<html>
<head>
 <title>Import Macrohelp from csv file Page</title>
 <link rel="stylesheet" type="text/css" href="../ow/css/ow.css" />
</head>
<body>
<p>
<%
'        // Initial report
Response.Write("<h2>Macrohelp Import from CSV File</h2><hr />")
If (Request.Form("submitted")="yes") AND (Request.Form("password")=gAdminPassword) then
    Response.Write("Importing from " & macrohelp_Path & "...<br />Please wait. working..")
    Response.Flush

    Success=False
    'On Error Resume Next
    If FSO.FileExists(macrohelp_Path) then
            '        // Open a recordset of the macrohelp
            tSQL="SELECT * FROM " & macrohelp_Filename'  & " ORDER BY macro_name ASC;"
			tRS.Open tSQL, tConn, adOpenForwardOnly
            If OPENWIKI_DB_SYNTAX = DB_SQLSERVER then
				oConn.BeginTrans()
				oConn.Execute("DELETE openwiki_macrohelp;")
			else
				oConn.Execute("DELETE * FROM openwiki_macrohelp;")
			end if	
            '        // Loop through, and write to macrohelp_Filename
            Do While Not tRS.EOF
                    aName=SQLTokenise(tRs.Fields("macro_name"))
                    aBuiltin=CInt(tRs.Fields("macro_builtin"))
                    aNumParams=CInt(tRs.Fields("macro_numparams"))
                    aDescription=SQLTokenise(tRs.Fields("macro_description"))
                    aParam1=SQLTokenise(tRs.Fields("macro_param1"))
                    aParam2=SQLTokenise(tRs.Fields("macro_param2"))
                    aParam3=SQLTokenise(tRs.Fields("macro_param3"))
                    aComments=SQLTokenise(tRs.Fields("macro_comment"))
'					// DEBUGGING START //
'                    Response.Write(oSQL & "<p>")
'                    Response.Flush
'					// DEBUGGING END //
                    oSQL="INSERT INTO openwiki_macrohelp VALUES(" &_
                    "'" & aName & "'," &_
                    aBuiltin & "," &_
                    aNumParams & "," &_
                    "'" & aDescription & "'," &_
                    "'" & aParam1 & "'," &_
                    "'" & aParam2 & "'," &_
                    "'" & aParam3 & "'," &_
                    "'" & aComments & "'" &_
                    ");"
                    ' // Use table default values for Null fields
                    If OPENWIKI_DB_SYNTAX = DB_SQLSERVER then
						oSQL=Replace(oSQL,"'DEFAULT'","DEFAULT")
					End If	
                    ' DEBUGGING Response.Write(oSQL & VBCR)
                    oConn.Execute oSQL
                    Response.Write(".")
                    Response.Flush
                    ct=ct+1
                    tRs.MoveNext
            Loop
            tRS.Close
            If oConn.Errors.Count=0 then
				If OPENWIKI_DB_SYNTAX = DB_SQLSERVER then oConn.CommitTrans()
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
Click the button to import the Macrohelp data from csv file to database
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