<%
' // $Log: owplugin_WYSIWYG.asp,v $
' // Revision 1.8  2005/04/16 17:19:34  casper_gasper
' // Shows wikiedit for Firefox.
' //
' // Revision 1.8  2005/03/22 00:19:00  cgasper
' // Firefox support added
' // 
' // Revision 1.7  2004/08/02 18:29:21  gbamber
' // IE Detection added
' //
' // Revision 1.6  2004/07/04 02:35:23  oddible
' // Central override for plugin activation in owplugins.asp
' //
' // Revision 1.5  2004/07/04 02:06:42  oddible
' // Added XSL for WYSIWYG and changed XSL architecture for Plugins (see CodeChanges on the forum for details).
' //
' // Revision 1.4  2004/07/04 00:53:57  gbamber
' // Log added
' //
plugins.Add "WYSIWYG Editor",0
'plugins.Add "WYSIWYG Editor",1
' **********************

Function plugin_getWYSIWYG
	Dim userAgentString
	If plugins.Item("WYSIWYG Editor") = 1 Then
		userAgentString = Request.ServerVariables("HTTP_USER_AGENT")
		if Instr(userAgentString,"MSIE") > 0 or _
		  Instr(userAgentString,"Firefox") > 0 then
			plugin_getWYSIWYG = 1
		End If	
	Else
		plugin_getWYSIWYG = 0
	End If  
End Function
%>