<%
' // $Log: owplugin_badlinklist.asp,v $
' // Revision 1.10  2005/02/09 03:02:05  dtremblay
' // Added Firebird syntax for bad links.
' //
' // Revision 1.9  2004/10/13 12:20:07  gbamber
' // Forced updates to make sure CVS reflects current work
' //
' // Revision 1.8  2004/10/13 00:53:12  gbamber
' // Added checks for table existence
' //
' // Revision 1.7  2004/10/10 22:49:11  gbamber
' // Massive update!
' // Added: Summaries
' // Added: Default pages built-in
' // Added: Auto-update from openwiki classic
' // Modified: Default plugin status
' // Modified: Default Page Names
' // Modified: Default MSAccess DB to openwikidist.mdb
' // BugFix: Many MSAccess bugs fixed
' // Modified: plastic skin to show Summary
' //
' // Revision 1.6  2004/09/06 14:56:20  gbamber
' // Fixed MSAccess bug
' //
' // Revision 1.5  2004/08/12 17:12:55  gbamber
' // Fixed MSAccess incompatibility bug
' //
' // Revision 1.4  2004/07/19 17:23:24  gbamber
' // Made 'page to redirect to' a constant
' //
' // Macro <BadLinkList> done
' //
' // Revision 1.3  2004/07/19 17:18:27  gbamber
' // Bad Link List plugin improved and bugfixed
' //
' // Revision 1.2  2004/07/18 10:57:23  gbamber
' // Made chongqed.org the default redirect
' //
' // Revision 1.1  2004/07/17 15:38:53  gbamber
' // BanLinkList plugin added.  Referers bugfixed
' //
' // Log added
' //
' *** INITIALISE ***
plugins.Add "Bad Link List",0
Dim oConn,oRs
Set oConn = Server.CreateObject("ADODB.Connection")
Set oRS = Server.CreateObject("ADODB.Recordset")

'Const WIKI_PAGE_TO_REDIRECT_TO = "BadLinkList"
Const WIKI_PAGE_TO_REDIRECT_TO = "http://chongqed.org/index.shtml"

Function ReplaceBadLink(vLink)
        If (plugins.Item("Bad Link List") = 1) Then
                ReplaceBadLink=A_ReplaceBadLink(vLink)
        else
                ReplaceBadLink=vLink
        End If
End Function

Function GetBadLinkList()
        If (plugins.Item("Bad Link List") = 1) Then
                GetBadLinkList=A_GetBadLinkList()
        else
                GetBadLinkList="Bad Link List plugin not activated"
        End If
End Function

' ******************************************************************************

Function A_GetBadLinkList()
'	// This function is for the Macro <BadLinkList>

'	// Initialise vars
        Dim sz,sz_URL,sz_comment,i,oConn,oRs,vQuery
        Set oConn = Server.CreateObject("ADODB.Connection")
        oConn.Open OPENWIKI_DB
        Set oRS = Server.CreateObject("ADODB.Recordset")

        On Error Resume Next

'	// Make up a simple HTML table from the database entries
        sz="<table border='1'>"
        sz=sz & "<tr><th>Spam Link</th><th>Comment text</th></tr>"
        vQuery = "SELECT * FROM openwiki_badlinklist ORDER BY bll_name ASC;"
		oRS.Open vQuery, oConn, adOpenForwardOnly
		Do While Not oRS.EOF
'	// Be sure not to show live links!  Replace . with (dot)
                sz_URL="<strong>" & Trim(oRs.Fields("bll_name")) & "</strong>"
                sz_URL=Replace(sz_URL,".","</strong>(dot)<strong>")
                sz_comment="" & Trim(oRs.Fields("bll_comment"))
'	// Start of row
                sz = sz & "<tr>"
                sz = sz & "<td>" & sz_URL & "</td>"
                sz = sz & "<td>" & sz_comment & "</td>"
                sz = sz & "</tr>"
'	// End of row
                oRS.MoveNext
        Loop
        oRS.Close
        sz = sz & "</table>"
        A_GetBadLinkList = sz

'	// Tidy up when leaving
        oConn.Close
        Set oConn = Nothing
        Set oRS = Nothing
End Function

' ******************************************************************************

'        // ACTIVE CODE
Function A_ReplaceBadLink(vLink)
    Dim szSQL,pText,vURL
    '	// Do a TSQL version of 'Instr' to see if a banned list item is in this link
    If OPENWIKI_DB_SYNTAX = DB_ACCESS Then
        szSQL="SELECT * FROM openwiki_badlinklist WHERE (InStr(1,'" & Replace(vLink,"'","''") & "',bll_name,1) > 0);"
    ElseIf OPENWIKI_DB_SYNTAX = DB_FIREBIRD then
        szSQL="SELECT * FROM openwiki_badlinklist WHERE '" & Replace(vLink,"'","''") & "' LIKE '%' || bll_name || '%';" 
    else
        szSQL="SELECT bll_comment FROM openwiki_badlinklist WHERE (CHARINDEX(bll_name, '" & Replace(vLink,"'","''") & "',1) > 0);"
    End If 
    oConn.Open OPENWIKI_DB
    oRs.Open szSQL,oConn,adOpenForwardOnly
		if oConn.Errors.Count <> 0 then
			ResetCookies
			TestForBadLinkListTable
			oRs.Open szSQL,oConn,adOpenForwardOnly
		End If	

      If NOT oRs.EOF then
      '	// Found a match!  The whole of vLink will be replaced by whatever is the corresponding bll_comment
            if ISNULL(oRs.Fields("bll_comment")) then
                 pText="Default Spam Link"
            else
                 pText=Trim(CStr(oRs.Fields("bll_comment")))
            end if
			vURL=WIKI_PAGE_TO_REDIRECT_TO'	// Page to redirect to
            If (Instr(WIKI_PAGE_TO_REDIRECT_TO,"http") = 0) then vURL="?" & vURL
            vLink="<ow:link name='" & pText & "' href='" & vURL & "' date='" & FormatDateISO8601(Now()) & "'>" & pText & "</ow:link>"
	  End If
'	// Tidy up DB connections
	oRs.Close
	oConn.Close

'	// Function returns either
'	// 1) Unchanged vLink
'	// or 2) vLink replaced by bll_comment
	A_ReplaceBadLink=vLink

End Function
%>