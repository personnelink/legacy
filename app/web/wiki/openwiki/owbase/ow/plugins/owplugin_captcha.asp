<%
' // $Log: owplugin_captcha.asp,v $
' // Revision 1.7  2005/12/10 08:38:38  gbamber
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
' // Revision 1.6  2004/07/04 02:35:23  oddible
' // Central override for plugin activation in owplugins.asp
' //
' // Revision 1.5  2004/07/04 02:13:00  oddible
' // Minor Cosmetic Comment
' //
' // Revision 1.4  2004/07/04 00:53:57  gbamber
' // Log added
' /
' **** ACTIVATION CODE ***
 plugins.Add "CAPTCHA",0
' ************************

Sub CheckForCAPTCHA
	If plugins.Item("CAPTCHA") = 1 Then
		A_CheckForCAPTCHA
	End If
End Sub

'        // ACTIVE CODE
Sub A_CheckForCAPTCHA
'        // Same as in capcha asp page
DIM C_CAPCHA_PAGE, C_WIKI_PAGE, C_COOKIE_PATH, C_COOKIE_LIFE_DAYS, C_CAPCHA_ERROR_PAGE
C_CAPCHA_PAGE = OPENWIKI_CAPTCHA_SERVERPAGE
C_WIKI_PAGE = gServerRoot & gScriptName
C_COOKIE_PATH = "/"
C_COOKIE_LIFE_DAYS = 7
C_CAPCHA_ERROR_PAGE = OPENWIKI_CAPTCHA_ERRORPAGE

'        // Has the user been to the CAPCHA form at all?
        If (Request.Cookies("CAPCHA") <> "OK") then
			If (Request.Form("capcha") <> "yes")then
                 Response.Redirect(C_CAPCHA_PAGE &_
				 "?" & Request.ServerVariables("QUERY_STRING") &_
				 "&WikiReferrer=" & Server.URLEncode(gServerRoot & gScriptName))
			end if
        End If

'        // Process the Capcha form post
        if Request.Form("submitted") = "yes" then
                Dim theCode,i,y,newText
                theCode=Request.Form("Hidden1")
                for  i= 1 to Len(theCode)
                        y =   CInt( mid(theCode, i,1) +1)
                        newText=newText &  Cstr(y )
                next
                if  Request.Form("CodeNumberTextBox") = newText then
                        Response.Cookies("CAPCHA").Path= C_COOKIE_PATH
                        Response.Cookies("CAPCHA")="OK"
                        Response.Cookies("CAPCHADONE").Path= C_COOKIE_PATH
                        Response.Cookies("CAPCHADONE").Expires=NOW() + CInt(C_COOKIE_LIFE_DAYS)
                        Response.Cookies("CAPCHADONE")="OK"

                Else
                        Response.Cookies("CAPCHA").Path= C_COOKIE_PATH
                        Response.Cookies("CAPCHA")="NOTOK"
                        Response.Redirect(OPENWIKI_SCRIPTNAME & "?p=" & C_CAPCHA_ERROR_PAGE)
                end if
        end if

'        // CAPCHA FORM SUCCESS?
        If (Request.Cookies("CAPCHADONE") <> "OK") then
                 Response.Redirect(C_CAPCHA_PAGE &_
				 "?" & Request.ServerVariables("QUERY_STRING") &_
				 "&WikiReferrer=" & Server.URLEncode(gServerRoot & gScriptName))
        else
'                // Uncomment this line if you want the cookies to self-renew
'                // every time a validated user edits another page within the expiry time of their cookie
                Response.Cookies("CAPCHA").Path= C_COOKIE_PATH
				Response.Cookies("CAPCHA").Expires=NOW() + CInt(C_COOKIE_LIFE_DAYS)
                Response.Cookies("CAPCHADONE").Expires=NOW() + CInt(C_COOKIE_LIFE_DAYS)
        End If
End Sub
%>