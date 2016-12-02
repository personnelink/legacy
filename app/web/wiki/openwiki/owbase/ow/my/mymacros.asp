<!-- #include virtual="/wiki/owbase/ow/owmacros.asp" -->
<%
' Examples of custom build macros.
' Included the main macros file to be able to reuse some of the standard functions
' When you create a new macro add the letter P to the name of
' the sub for each parameter you define. A macro can take at
' most 2 parameters.
'
' A macro should return the value that is supposed to be
' substituted in the text by setting the global variable
' gMacroReturn.

' For each macro you add below, you must add it's name to the
' return value of this function. Seperate the names by the
' pipe (|) character.
'
' If you want to redefine all available macros set the
' variable gMacros (see also owpatterns.asp).

' ****************************************************************************
'	// MAKING YOUR OWN OpenWikiNG MACRO //
'	// by Gordon Bamber //
'	
' Rules:
' 1) Any macro can take a MAXIMUM of 2 parameters
'   a) These can be string, integer - any type - but are usually string
'   b) A macro does not have to have 2 parameters.  It can have 1 or none at all.
'   c) To make parameters optional, you have to write more than one version
'		of the Macro. (see example Macro 'ShowMe')
' 2) A macro can be a Function or a Sub - either is OK.
' 3) ALL macros must set the string variable 'gMacroreturn'
'	 - even if it is only to a space character.
'	 gMacroreturn will de displayed on the page as the 'result' of your Macro.
' 4) All Subs or Functions must follow a fixed naming pattern:
'	 Macro<MacroName>[P][P] where:
'		<Macroname> will be the macro name that the user types
' Examples:
'	Sub MacroDoMyThing
'		- The user types in: <DoMyThing>
'	Sub MacroDoMyThingP(myParam)
'		- The user types in: <DoMyThing(something)>
'	Sub MacroDoMyThingPP(myParam1,myParam2)
'		- The user types in: <DoMyThing(something,something)>
' 5) Error-trapping and UserHelp should be built into your code.
'	- See the example Macros below to see how.
'	You should also update ow/macrohelp.csv and re-Import it into the DB
' 5a)	The Function SyntaxErrorMessage(MacroName,ErrorMessage) should be
'		used as a fallback when MacroHelp has been disabled.
' 6) The Macro name must be added to the variable string 'MyMacroPatterns'
'	 in the function 'MyMacroPatterns' below this text.
'	Each Macro name is separated by a pipe (|) character
' Example:
'	If you have written 3 macros: DoMyThing, MyMacro, ShowSomething, then
'	MyMacroPatterns = "DoMyThing|MyMacro|ShowSomething"
'
' Study the 2 example macros written in this file, to get a feel for it:
' ****************************************************************************

Function MyMacroPatterns
    If cEmbeddedMode = 0 Then '	// Only use these macros inside openWikiNG
        MyMacroPatterns = "FirstnameLastname|DeprecatedPages|Execute|CreateNewIDPage"
    End If
End Function
'
' ----------------------------------------------------------------------------
'	// Example Macro1.  This is a working sample
'	// and you can use it on any page
'	// Code by Gordon Bamber
'	// Type: Simple return string.  No other functions used.
'	// SYNTAX 1: <FirstnameLastname(string1)>
'	// SYNTAX 2: <FirstnameLastname(string1,string2)>
Sub MacroFirstnameLastnamePP(pParam1,pParam2) '	// 2-parameter version
	If pParam1="" then MacroFirstnameLastname '	// Trap for blank parameter1
	If pParam2="" then MacroFirstnameLastnameP pParam1 '	// Trap for blank parameter2 -Just use parameter 1
	gMacroReturn="My name is " & pParam1 & " " & pParam2
End Sub

Sub MacroFirstnameLastnameP(pParam1)'	// 1-parameter version
	If pParam1="" then MacroFirstnameLastname '	// Trap for blank parameter1
	gMacroReturn="My name is " & pParam1 
End Sub

Sub MacroFirstnameLastname'	// No-parameter version (this is an error trap)
	If plugins.Item("Macro Help") = 1 Then
		Call MacroMacroHelpP("FirstnameLastname")'	// This sets gMacroReturn for us.
	else	
		gMacroReturn = SyntaxErrorMessage("FirstnameLastname","This macro requires at least a name in brackets")
	End If	
End Sub
'
' ----------------------------------------------------------------------------
'	// Example Macro2.  This is a working sample
'	// and you can use it on any page
'	// Code by Gordon Bamber
'	// Type: Returns a calculated number
'	// SYNTAX 1: <DeprecatedPages>
'	// 			- Returns pages deprecated more than OPENWIKI_DAYSTOKEEP days ago.
'	// SYNTAX 2: <DeprecatedPages(NumDays)>
'	// 			- Returns pages deprecated more than NumDays days ago.
'	// SYNTAX 3: <DeprecatedPages(-NumDays)>
'	// 			- Returns pages deprecated in the last NumDays days.
Sub MacroDeprecatedPagesP(pDaysOld)
Dim oConn,oRs,szSQL,vText,iTotalDeprecatedPages,ConditionIsTrue
	iTotalDeprecatedPages = 0 '	// Initialise
'	// Trap for bad parameter
	If NOT IsNumeric(pDaysOld) then pDaysOld=OPENWIKI_DAYSTOKEEP'	// Use default for non-numeric parameters
'	// Set up ADO objects
	Set oConn = Server.CreateObject("ADODB.Connection")
	Set oRs = Server.CreateObject("ADODB.Recordset")
'	// Get all current revisions of pages
	szSQL = "SELECT wrv_name, wrv_timestamp, wrv_text FROM openwiki_revisions WHERE wrv_current = 1"
	oConn.Open OPENWIKI_DB
	oRs.Open szSQL, oConn, adOpenForwardOnly
	Do While Not oRs.EOF
		If pDaysOld=ABS(pDaysOld) then '	// Positive parameter
'		// Was the page deprecated more than DaysToKeep days ago? (+ve integer)
			ConditionIsTrue=(CDate(oRs("wrv_timestamp")) < CDate((Now() - pDaysOld)) )
		Else
'		// Was the page deprecated in the last DaysToKeep days? (-ve integer)
			ConditionIsTrue=(CDate(oRs("wrv_timestamp")) >= CDate((Now() - ABS(pDaysOld))) )
		End If	
		If ConditionIsTrue Then
'			// Grab the Page Text		
			vText = oRs("wrv_text")
'			// Examine the first 11 characters on the page			
			If Len(vText) >= 11 Then
				If Left(vText, 11) = "#DEPRECATED" Then
					iTotalDeprecatedPages=iTotalDeprecatedPages + 1
				End If
			End If
		End If
	oRs.MoveNext
	Loop
'	// Tidy up local DB objects
	Set oRs = Nothing
	Set oConn = Nothing
'	// Make sure that the result is XML-compliant
	gMacroReturn=CDataEncode(iTotalDeprecatedPages)
End Sub

'	// No-parameter version
Sub MacroDeprecatedPages
'	// Use a Call - no more code to process here.
	Call MacroDeprecatedPagesP(OPENWIKI_DAYSTOKEEP)
End Sub	
' ----------------------------------------------------------------------------
'	// This is for Macro Writers. 
'	// SYNTAX: <Execute(VBScriptCommand,AdminPassword)>
Sub MacroExecutePP(pParam,thePassword)
if cDisableExecuteMacro=0 then
	If thePassword=gAdminPassword then
		Execute(pParam)
		gMacroReturn="Executed command: <b>" & pParam & "</b> successfully."
	ElseIf thePassword=gAdminPassword & "|returnvalue" then
		gMacroReturn="The value of " & pParam & " is: " & Eval(pParam)
	else
		gMacroReturn="<ow:error>The password is incorrect</ow:error>"	
	End If
else
	gMacroReturn="<ow:error>This macro has been disabled by the WikiAdministrator</ow:error>"	
end if	
End Sub
Sub MacroExecuteP(pParam)
		gMacroReturn=SynTaxErrorMessage("Execute","Sorry, this macro requires the Administrator Password as the 2nd parameter")
End Sub
Sub MacroExecute
		gMacroReturn=SynTaxErrorMessage("Execute","Sorry, this macro requires at least 2 parameters")
End Sub


' ----------------------------------------------------------------------------
' PageRoot is the base name for the pages
' Digits is the number of digits to create the unique ID with (pads with leading zeros)
' e.g. CreateNewID("IssueTracking/CaseId", 6) will get the next page as format IssueTracking/CaseIdnnnnnn
' you also need a template called IssueTracking/CaseIdTemplate which it uses to create the page
Sub MacroCreateNewIDPagePP(PageRoot, Digits)
Dim oConn, oRs, szSQL, sLastPage, NextPage, Zeros

Zeros = String(Digits, "0")

' // Set up ADO objects
Set oConn = Server.CreateObject("ADODB.Connection")
Set oRs = Server.CreateObject("ADODB.Recordset")

' // Get all current revisions of pages
szSQL = "SELECT MAX(wpg_name) AS last_page FROM openwiki_pages WHERE wpg_name LIKE '" & PageRoot & "%' AND wpg_name <> '" & PageRoot & "Template'"
oConn.Open OPENWIKI_DB
oRs.Open szSQL, oConn, adOpenForwardOnly

if Not oRs.EOF then
sLastPage = oRs("last_page")
Else
sLastPage = PageRoot
end if
if IsNull(sLastPage) then
sLastPage = PageRoot
end if

NextPage = CStr(CLng(right(sLastPage, Digits)) + 1)
sLastPage = PageRoot & right(Zeros & NextPage, Digits)

' // Tidy up local DB objects
Set oRs = Nothing
Set oConn = Nothing

MacroCreatePagePP PageRoot & "Template", sLastPage
End Sub

%>
