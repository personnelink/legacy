<%
' // Revision 1  2006/04/07 18:17:59  Vagabond
' // Build 200600407
' // new macros MyCheckForAllowedView and MyCheckForAllowedEdit
' // for customizable Authorisation

Sub MyCheckForAllowedView()
	' add here any custom authorisation logic for editing of pages
	' to disallow the viewing of an page set editOK = FALSE

	dim bViewAllowed
	bViewAllowed = TRUE
	
	If ( bViewAllowed = FALSE ) AND NOT ( gPage = OPENWIKI_ERRORPAGENAME ) then
	  gPage = OPENWIKI_VIEWERRORPAGE
	  gErrorPageText = "You are not allowed to view this page !"
	End if

End Sub


Sub MyCheckForAllowedEdit()
	' add here any custom authorisation logic for editing of pages
	' to disallow the editing of an page set editOK = FALSE

	dim bEditAllowed
	bEditAllowed = TRUE
	
	If ( bEditAllowed = FALSE ) then
	  Response.Redirect( gScriptName & "?a=view&p=" & OPENWIKI_EDITERRORPAGE & "&redirect=" &  Server.URLEncode(FreeToNormal(gPage)))
	End if
End Sub

%>