<%
' // $Log: owplugin_pagehits.asp,v $
' // Revision 1.16  2004/10/13 12:20:07  gbamber
' // Forced updates to make sure CVS reflects current work
' //
' // Revision 1.15  2004/10/13 00:53:12  gbamber
' // Added checks for table existence
' //
' // Revision 1.14  2004/10/10 22:49:11  gbamber
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
' // Revision 1.13  2004/09/27 22:19:06  gbamber
' // BugFix: incompatibility with owclassic database fixed
' //
' // Revision 1.12  2004/09/10 21:45:34  gbamber
' // Bugfix for integer overflow problem in owplugin_pagehits.asp
' //
' // Revision 1.11  2004/09/05 14:38:07  gbamber
' // Changed to LongType
' //
' // Revision 1.10  2004/08/29 11:21:07  gbamber
' // WikiBadge code added
' //
' // Revision 1.9  2004/08/23 10:22:26  gbamber
' // Small bugfix
' //
' // Revision 1.8  2004/08/13 07:13:21  gbamber
' // Fixed minor MSAccess error
' //
' // Revision 1.6  2004/07/08 09:44:41  gbamber
' // Fixed syntax errors that stopped the plugins from working
' //
' // Revision 1.5  2004/07/04 02:35:23  oddible
' // Central override for plugin activation in owplugins.asp
' //
' // Revision 1.4  2004/07/04 00:53:57  gbamber
' // Log added
' //
' **** ACTIVATION CODE ***
plugins.Add "Page Hits",0
' plugins.Add "Page Hits",1
'*************************

Function GetPageQuery()
	GetPageQuery = "SELECT wpg_name, wpg_changes, wpg_lastminor, wpg_lastmajor, wrv_revision, wrv_status, wrv_timestamp, wrv_minoredit, wrv_by, wrv_byalias, wrv_comment"
	If cUseCategories then GetPageQuery = GetPageQuery & ", wpg_FCategories"
	If cUseSummary then GetPageQuery = GetPageQuery & ", wrv_summary"
	If plugins.Item("Page Hits") = 1 Then GetPageQuery = GetPageQuery & ", wpg_hits"
	GetPageQuery = GetPageQuery & " "
End Function

Sub DoDBHits(vPage,vRS)
        If plugins.Item("Page Hits") = 1 Then
                A_DoDBHits vPage,vRS
        End If
End Sub

Sub DoIncrementPageHits(vPage,oConn)
        If plugins.Item("Page Hits") = 1 Then
                A_DoIncrementPageHits vPage,oConn
        End If
End Sub

' **** ACTIVE CODE ***

Sub A_DoDBHits(vPage,vRS)
'        // From owdb.asp
    vPage.Hits = 0 + CLng("0" & vRS("wpg_Hits"))
End Sub

Sub A_DoIncrementPageHits(vPage,oConn)
'        // From owdb.asp
On Error Resume Next
        Dim vQuery
        If (Instr(vPage.Text,"#NOHITS")=0) then
                        vPage.Hits = vPage.Hits + 1 '        // Increment hits IN PAGE OBJECT on retrieval
                        vQuery = "UPDATE openwiki_pages SET wpg_Hits = " & CLng(vPage.Hits) &_
                        " WHERE wpg_name = '" & Replace(vPage.name, "'", "''") & "';"
                        oConn.execute(vQuery)
						if vConn.Errors.Count <> 0 then
							ResetCookies
							TestForPageHitsTable
							oConn.execute(vQuery)
							Exit Sub
						End If	

        Else
                        '        // Take out PI text in page
                        vPage.Text=Replace(vPage.Text,"#NOHITS","")
        End If
End Sub
%>