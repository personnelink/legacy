<%
'
' add your custom made actions, must start with the string Action, e.g.
'
'  Sub ActionDoSomething()
'      gActionReturn = True
'  End Sub
'
' see more examples in owaction.asp
'
' ****************************************************************************
'	// HOW TO USE ACTIONS IN openWiking
'	// by Gordon Bamber
'	
' An action is the result of a form being submitted.  Such a form looks like:
' <form name=""MyWizzyForm"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">
' <input type=""hidden"" name=""a"" value=""myreplace""/>
' Old Text: <input type=""text"" name=""oldtxt"" />
' New Text: <input type=""text"" name=""newtxt"" />
' <input id=""doit"" type=""submit"" value=""Replace Text""/>
' </form>
'
' The important element is the hidden one called 'a'
' The value of the element 'a' (myreplace) will determine the action handler s name
'	The handler name always starts with 'Action'
'
' The subitting form can be in a Macro, or in an XSL file (Like the Edit form)
'
'
'	// Heres the corresponding (example) handler.
'	// This handler grabs the page, replaces stuff, then displays it in 'view mode'
'
' Sub ActionMyReplace()
' Dim OldText,NewText,vPage
'	OldText=Request("oldtxt") ' // Grab from the form element
'	NewText=Request("newtxt") ' // Grab from the form element
'   Set vPage = gNamespace.GetPage(gPage, gRevision, True, False)
'	// Note that gPage,gRevision is already given to you free
'	vPage.Text = Replace(vPage.Text,OldText,NewText)
'	gAction = "view"  ' // This is for the XSL handler
'   Call gTransformer.Transform(vPage.ToXML(1))
'	Set vPage = Nothing
' 	gActionReturn = True
' End Sub
'
' ****************************************************************************

%>