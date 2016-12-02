<%
' // $Log: pagetool.asp,v $
' // Revision 1.3  2004/09/24 21:12:46  sansei
' // Dump of Variables now inline (PageTool)
' //
' // Revision 1.2  2004/09/24 17:06:24  sansei
' // Added dump of OW Variables functionality
' //
' // Revision 1.1  2004/09/06 14:17:12  sansei
' // Contact ASP-FLASH established
' //
' PageTool by sEi'2004
'
' This file handles the communication between ow and the swf.
'
' ### EXPERIMENTAL CODE ###

option explicit
%>
<!-- #include file="../../owpreamble.asp"       //-->
<!-- #include file="../../owconfig_default.asp" //-->
<!-- #include file="pagetool_inc.asp" //-->
<%
' ### INIT ###
Dim result,mode,runasp
'--------
runasp = False 'true ' TRUE = response to browser FALSE = response to Flash
'--------
mode = ucase(Request("mode"))
if len(mode)=0 then
	mode = "ERROR"
end if

' ### MAIN ###
select case mode
	case "FETCHALLVARIABLES"
		'return as XML!
		result = FetchVariableValues()
	case "FETCHVARIABLE"
		select case ucase(Request("varname"))
			case "$VERSION"
				result = FetchVariableValue("OPENWIKI_VERSION") & " " & replace(FetchVariableValue("OPENWIKI_REVISION"),"$","") & FetchVariableValue("OPENWIKI_BUILD")
			case else
				result = FetchVariableValue(Request("varname"))
		end select 

	case else
		result = DumpThisError("ASP - CRITICAL ERROR","The mode [" & mode & "] unknown!")
end select
if (runasp) then
	result = server.HTMLEncode(result)
else
	'result = "msg=" & server.HTMLEncode(result)&"&DoNext="&request("DoNext")
	result = "msg=" & result&"&DoNext="&request("DoNext")
end if

Response.Write(result)

' ### FUNCTIONS AND SUBS ###
function DumpThisError(sTitle,sMsg)
	dim str
	str = "" & sTitle & " " & sMsg
	DumpThisError = str
end function
%>