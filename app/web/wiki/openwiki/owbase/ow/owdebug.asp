<%
' $CVS Check-in Log: owdebug.asp,v $
' File Revision 1.3  2004/10/10 22:47:42  gbamber
' Massive update!
' Added: Summaries
' Added: Default pages built-in
' Added: Auto-update from openwiki classic
' Modified: Default plugin status
' Modified: Default Page Names
' Modified: Default MSAccess DB to openwikidist.mdb
' BugFix: Many MSAccess bugs fixed
' Modified: plastic skin to show Summary
'
' Revision 1.2  2004/10/07 14:27:30  gbamber
' Added
' cUseMultipleParents = 1|0 (default=1)
' and ServerDown = 1|0 (default=0)
'
' Revision 1.1  2004/10/03 15:32:15  gbamber
' Cleaned up MSAccess OPENWIKI_DB code
' Added owdebug.asp
' Cleaned up owconfig_default a bit
' New switch in owconfig_default to debug the MSAccess connection string
'
'
' ****************************************************************************
Dim tConn,tRs
' ****************************************************************************
' UTILITY FUNCTIONS
' ****************************************************************************
Function GetHTMLStart(pTitleParam)
	GetHTMLStart = "<html><head><title>" & OPENWIKI_TITLE & " " & pTitleParam & "</title>" &_
	"<meta http-equiv=""Content-Type"" content=""text/html; charset=ISO-8859-1;"" />" &_
	"<link rel=""stylesheet"" type=""text/css"" href=""ow/skins/default/ow.css""/>" &_
	"</head><body>" &_
	"<img align=""right"" alt=""" & OPENWIKI_TITLE & """ src=""ow/images/logo.gif"" />" &_
	"<p>&nbsp;</p><h1 align='center'>" & pTitleParam & "</h1><hr />"
End Function

Function GetHTMLEnd()
	GetHTMLEnd = "<hr /><address>&nbsp;- the <a href=""http://s8.invisionfree.com/OpenWikiNG/index.php?showforum=5"" title=""Post your bugs to this forum"">" & OPENWIKI_APPNAME & "</a> development team</address></body></html>"
End Function

' ****************************************************************************

Sub DoServerDownForMaintainance
Dim HTMLResult
	HTMLResult = GetHTMLStart("Down for maintainance") &_
	"<ul><li><b>This Wiki is currently offline, but it will return as soon as esssential maintainance is complete</b></li></ul>" &_
	"<hr>" &_
	"<ul><li><address>WikiAdmin (" & FormatDateTime(Now,1) & ")</address></li></ul>"
	GetHTMLEnd()
	Response.Write(HTMLResult)
	Response.End
	Session.Abandon
End Sub

' ****************************************************************************

Function OpenDatabaseSuccess
	OpenDatabaseSuccess = False '	// Assume an error
	On Error Resume Next
	Set tConn = Server.CreateObject("ADODB.Connection")
	tConn.Errors.Count = 0
	tConn.Open OPENWIKI_DB
	If (tConn.Errors.Count = 0) then OpenDatabaseSuccess = True '	// Success!
End Function

' ****************************************************************************

Function CloseDatabaseSuccess
	CloseDatabaseSuccess = False '	// Assume an error
	On Error Resume Next
	tConn.Errors.Count = 0
	tConn.Close()
	If (tConn.Errors.Count = 0) then CloseDatabaseSuccess = True '	// Success!
	Call TidyUp
End Function

' ****************************************************************************

Sub TidyUp
	Set tConn = Nothing
	Set tRs=Nothing
End Sub

Function MakeGoodMessageListItem(pText)
	MakeGoodMessageListItem = "<li><span style=""color:#008000"">" & pText & "</span></li>"
End Function

' ****************************************************************************

Function MakeBadMessageListItem(pText)
	MakeBadMessageListItem = "<li><span style=""color:#ff0000"">Test <b>FAILED! :</b> " & pText & "</span></li>"
End Function

Sub ResetCookieList
'	// Reset cookies so that missing database tables can get (re)added
	Response.Cookies(OPENWIKI_TITLE & "badlinklist").expires  = #01/01/1990#
	Response.Cookies(OPENWIKI_TITLE & "badlinklist") = ""
	Response.Cookies(OPENWIKI_TITLE & "referrers").expires  = #01/01/1990#
	Response.Cookies(OPENWIKI_TITLE & "referrers") = ""
	Response.Cookies(OPENWIKI_TITLE & "summary").expires  = #01/01/1990#
	Response.Cookies(OPENWIKI_TITLE & "summary") = ""
	Response.Cookies(OPENWIKI_TITLE & "category").expires  = #01/01/1990#
	Response.Cookies(OPENWIKI_TITLE & "category") = ""
	Response.Cookies(OPENWIKI_TITLE & "hits").expires  = #01/01/1990#
	Response.Cookies(OPENWIKI_TITLE & "hits") = ""
End Sub

Function InsertTestRSS(pURL)
Dim vQuery,vQuery1,vQuery2
	InsertTestRSS = false
	On Error Resume Next
	tConn.Errors.Count = 0
	vQuery1 = "INSERT INTO openwiki_rss (rss_url,rss_last,rss_next,rss_refreshrate,rss_cache"
	vQuery2 = "'" & pURL & "','" & Now() & "','" & Now() & "',240,''"
	vQuery = vQuery1 & ") VALUES (" & vQuery2 & ");"
	tconn.execute(vQuery)
	Set tRS = Server.CreateObject("ADODB.Recordset")
	vQuery1="SELECT rss_url FROM openwiki_rss WHERE rss_url='" & pURL & "';"
	tRS.Open vQuery1, tConn, 0 '	// adOpenForwardOnly 
	If (NOT tRS.EOF) then
		AccessDebugTest = AccessDebugTest & MakeGoodMessageListItem("New RSS entry " & tRS.Fields("rss_url") & " created and retrieved.")
		vQuery="DELETE FROM openwiki_rss WHERE rss_url='" & pURL & "';"
		tconn.execute(vQuery)
		If (tConn.Errors.Count <> 0) then
			InsertTestRSS = False
			AccessDebugTest = AccessDebugTest & MakeBadMessageListItem("New RSS entry " & tRS.Fields("rss_url") & " could not be deleted successfully.")
			AccessDebugTest = AccessDebugTest & MakeBadMessageListItem(vQuery)
			AccessDebugTest = AccessDebugTest & MakeBadMessageListItem(vQuery1)
		else
			AccessDebugTest = AccessDebugTest & MakeGoodMessageListItem("New RSS entry " & tRS.Fields("rss_url") & " deleted successfully.")
		End If	
		InsertTestRSS = true '	// Success!
	else
		AccessDebugTest = AccessDebugTest & MakeBadMessageListItem(vQuery)
		AccessDebugTest = AccessDebugTest & MakeBadMessageListItem(vQuery1)
	End If
	tRS.Close()
		
End Function

' ****************************************************************************
' * DEBUGGING TEST FUNCTIONS START HERE *
' ****************************************************************************

Sub DoDBDebugTest3 '	// AccessDebugTest = 3 //
	ResetCookieList
	AccessDebugTest = GetHTMLStart("Debug3 Testing whether the database can be written to")
	On Error Resume Next
	AccessDebugTest = AccessDebugTest & "<ul>"
	if OpenDatabaseSuccess then '	// Make sure the database can be opened, first!
		AccessDebugTest = AccessDebugTest & MakeGoodMessageListItem("Database Opened successfully.")
'	// Test starts here.  Make, then delete a new page	
		If InsertTestRSS("http://www.openwiki.com") then
			AccessDebugTest = AccessDebugTest & MakeGoodMessageListItem("New RSS entry made (and deleted) successfully.  Database is writeable.")
		Else
			AccessDebugTest = AccessDebugTest & MakeBadMessageListItem("New RSS entry creation/deletion unsuccessful.  Database may not be writable.")
		End If
	else
		AccessDebugTest = AccessDebugTest & MakeBadMessageListItem("Database could not be opened.  Refresh your browser (F5)")
		AccessDebugTest = AccessDebugTest & MakeBadMessageListItem("If refreshing your browser continues to show this message, you have a connection problem.")
	End If
	AccessDebugTest = AccessDebugTest & "</ul>" & GetHTMLEnd()
	Response.Write(AccessDebugTest)
	Response.End
	Session.Abandon
End Sub

' ****************************************************************************

Sub DoDBDebugTest2 '	// AccessDebugTest = 2 //
	ResetCookieList
	AccessDebugTest = GetHTMLStart("Debug2 Testing the database connection")
	On Error Resume Next
	AccessDebugTest = AccessDebugTest & "<ul>"
	if OpenDatabaseSuccess then
		AccessDebugTest = AccessDebugTest & MakeGoodMessageListItem("Database opened successfully.  Your connection string is good.")
		if CloseDatabaseSuccess then
			AccessDebugTest = AccessDebugTest & MakeGoodMessageListItem("Database closed successfully")
		else
			AccessDebugTest = AccessDebugTest & MakeBadMessageListItem("Database could not be closed.")
		End If
	else
		AccessDebugTest = AccessDebugTest & MakeBadMessageListItem("Database could not be opened.  Refresh your browser (F5)")
		AccessDebugTest = AccessDebugTest & MakeBadMessageListItem("If refreshing your browser continues to show this message, you have a connection problem.")
	End If
	AccessDebugTest = AccessDebugTest & "</ul>" & GetHTMLEnd()
	Response.Write(AccessDebugTest)
	Response.End
	Session.Abandon
End Sub

' ****************************************************************************

Sub DoAccessDebugTest1'	// AccessDebugTest = 1 //
	ResetCookieList
	AccessDebugTest = GetHTMLStart("Debug1 - Testing the MSAccess path") &_
	"<ul><li>Clicking this link to the Access MDB file should not produce an error: <a href=""" & C_WIKIROOT & C_VIRTUALACCESSPATH &_
	""">" & C_WIKIROOT & C_VIRTUALACCESSPATH &_
	"</a></li>" &_
	"<li>On your server, the windows path to the MDB is currently set to " &_
	Server.MapPath(C_WIKIROOT & C_VIRTUALACCESSPATH) & "</li></ul>" &_
	"<hr /><b>If this information is correct, then reset ""AccessDebugTest = 0"" in your owdefault_config.asp file</b>" &_
	GetHTMLEnd()
	Response.Write(AccessDebugTest)
	Response.End
	Session.Abandon
End Sub
%>
