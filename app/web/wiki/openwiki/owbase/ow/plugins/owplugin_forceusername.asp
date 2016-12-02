<%
' // $Log: owplugin_forceusername.asp,v $
' // Revision 1.8  2005/12/10 08:38:38  gbamber
' // BUILD 20051210
' // New: <RedirectPage>
' // New <CreateSubPage>
' // BugFix: CreatePage macro code
' // BugFix: Userprefs back link
' // BugFix: CAPTCHA now works
' // BugFic: cUseFreeLinks=0 option works correctly
' // BugFix: Page rename partly repaired
' // BugFix: forceusername uses persistent cookie
' // //Gordon//
' //
' // Revision 1.7  2004/10/13 12:20:07  gbamber
' // Forced updates to make sure CVS reflects current work
' //
' // Revision 1.6  2004/10/10 22:49:11  gbamber
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
' // Revision 1.5  2004/07/04 02:35:23  oddible
' // Central override for plugin activation in owplugins.asp
' //
' // Revision 1.4  2004/07/04 00:53:57  gbamber
' // Log added
' //
' **** ACTIVATION CODE ***
plugins.Add "Check for User Name",0
'plugins.Add "Check for User Name",1
' ************************

Sub CheckForUserName
	If plugins.Item("Check for User Name") = 1 Then
		A_CheckForUserName
	End If
End Sub

'        // ACTIVE CODE
Sub A_CheckForUserName
        If GetRemoteAlias() = "" then
				If (gPage <> OPENWIKI_UPNAME) then Response.Cookies(gCookieHash & "?referringpage") = gPage
                Response.Redirect(OPENWIKI_SCRIPTNAME & "?p=" & OPENWIKI_UPNAME)
        End If
End Sub
%>