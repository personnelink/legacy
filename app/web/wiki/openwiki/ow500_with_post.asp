<%@Language="VBSCRIPT"%>
<%
' //////////////////////////////////////////////////////
' // Custom IIS error page for error 500;100
' // adapted from the microsoft example
' // by Gordon and Stephan
' //
' // Ref: http://support.microsoft.com/default.aspx?scid=kb;en-us;224070
' //
' // To use, Set the custom ASP error page:
' // a.  Open the Internet Services Manager in the MMC. 
' // b.  Expand your Default Web Site. 
' // c.  Right-click on the Scripts folder and select Properties. 
' // d.  Click the Custom Errors tab. 
' // e.  Scroll down and highlight the 500;100 HTTP error and click Edit Properties. 
' // f.  Ensure that Message Type is set to URL. 
' // g.  Change the URL to "/scripts/ow500.asp" (without the quotation marks). 
' // h.  Click OK until you return to the MMC. 
' //
' // Version 20060223
' //////////////////////////////////////////////////////

  Option Explicit
  On Error Resume Next
  Response.Clear
  Dim objError
  Set objError = Server.GetLastError()
%>
<html>
<head>
<title>OpenwikiNG Automatic Error Report</title>
<style>
BODY  { FONT-FAMILY: Arial; FONT-SIZE: 10pt;
        BACKGROUND: #ffffff; COLOR: #000000;
        MARGIN: 15px; }
H2    { FONT-SIZE: 16pt; COLOR: #ff0000; }
H4    { FONT-SIZE: 14pt; COLOR: #000066; }
H5    { FONT-SIZE: 12pt; COLOR: #006666; }
TABLE { BACKGROUND: #000000; PADDING: 5px; }
TH    { BACKGROUND: #0000ff; COLOR: #ffffff; }
TR    { BACKGROUND: #cccccc; COLOR: #000000; }
</style>
</head>
<body>
<hr>
<h2 align="center">OpenwikiNG Automatic Error Report</h2>

<h4 align="center">-- An error occurred which was not your fault --</h4>
<p align="center"><i>Please read the instructions below</i><br/><br/>
</p>

<hr>
<h5>
If you feel this error should be reported to the openwikiNG dev team as a bug,
 then clicking the button below will automatically post the data to the support forum. Before doing so, please
 take a moment to add some more information and/or contact details into the report area below.
</h5>
<i><a href="http://www.openwiking.com/forum/forum.asp?FORUM_ID=9">The openwikiNG team</a></i>
<div align="center">
<form name="PostTopic" method="post" action="http://www.bamber.org/forum/post_info.asp">
<input name="Submit" type="submit" value="Submit this report to the support forum">
<input name="ARCHIVE" type="hidden" value="">
<input name="Method_Type" type="hidden" value="Reply">
<input name="TOPIC_ID" type="hidden" value="2">
<input name="FORUM_ID" type="hidden" value="3"> 
<input name="CAT_ID" type="hidden" value="1">
<input name="Refer" type="hidden" value="/forum/topic.asp?TOPIC_ID=2">
<input name="UserName" type="hidden" value="openwiking">
<input name="Password" type="hidden" value="54572377cd1489e35679fdf3b89bd0b3b319c573289662e57b1cac42a81d15be">
<br/><br/>
<textarea name="Message" cols="79" rows="9">
<%
Dim OWNG_ServerVar, OWNG_ServerVar_Value, OWNG_FormVar, OWNG_FormVar_Value


Response.Write( Server.HTMLEncode( "Date: " & FormatDateISO8601(Now()) & VBCR & VBCR ) )
Response.Write( Server.HTMLEncode( "== Please add the information below before posting ==" & VBCR ) )
Response.Write( Server.HTMLEncode( "Your Name/Organisation: " & VBCR ) )
Response.Write( Server.HTMLEncode( "contact eMail address(es): " & VBCR ) )
Response.Write( Server.HTMLEncode( "Any extra information about this error: " & VBCR & VBCR & VBCR ) )

Response.Write ( Server.HTMLEncode( "===============================================================================" & VBCR & VBCR & VBCR ) )

Response.Write ( Server.HTMLEncode( "=== OWNG IIS Error Report ===" & VBCR ) )
If Len(CStr(objError.ASPCode)) > 0 Then
	Response.Write( Server.HTMLEncode( "IIS Error Code: " & objError.ASPCode & VBCR ) )
End If
If Len(CStr(objError.File)) > 0 Then
	Response.Write( Server.HTMLEncode( "File Name= " & objError.File & VBCR ) )
End If
If Len(CStr(objError.Line)) > 0 Then
	Response.Write( Server.HTMLEncode( "Error Line: " & objError.Line & VBCR ) )
End If
If Len(CStr(objError.Source)) > 0 Then
	Response.Write( Server.HTMLEncode( "Error Source: " & objError.Source & VBCR ) )
End If
If Len(CStr(objError.Description)) > 0 Then
	Response.Write( Server.HTMLEncode( "Error: " & objError.Description & VBCR ) )
End If
If Len(CStr(objError.ASPDescription)) > 0 Then
	Response.Write( Server.HTMLEncode( "Full Description: " & objError.ASPDescription & VBCR ) )
End If
If Len(CStr(objError.Number)) > 0 Then
	Response.Write( Server.HTMLEncode( "COM Error number: " & objError.Number & " (0x" & Hex(objError.Number) & ")" & VBCR ) )
End If

Response.Write (VBCR & "=== Form Variable Dump ===" & VBCR & VBCR)
	for each OWNG_FormVar in Request.Form
		OWNG_FormVar_Value = Request.Form( OWNG_FormVar )
		response.write( Server.HTMLEncode( OWNG_FormVar ) & "=" & Server.HTMLEncode( OWNG_FormVar_Value & VBCR ) )
	next

Response.Write (VBCR & "=== Querystring Variable Dump ===" & VBCR & VBCR)
	for each OWNG_FormVar in Request.QueryString
		OWNG_FormVar_Value = Request.QueryString( OWNG_FormVar )
		response.write( Server.HTMLEncode( OWNG_FormVar ) & "=" & Server.HTMLEncode( OWNG_FormVar_Value & VBCR ) )
	next

' // We need to be more specific here about which ServerVariables are really useful
Response.Write (VBCR & "=== Server Variable Dump ===" & VBCR & VBCR)
	For each OWNG_ServerVar in Request.ServerVariables
		OWNG_ServerVar_Value = Request.ServerVariables( OWNG_ServerVar )
		if ( Instr(OWNG_ServerVar,"AUTH_PASSWORD")=0 ) _
		 AND ( Instr(OWNG_ServerVar,"Cookie")=0 ) _
		 AND ( Instr(OWNG_ServerVar,"HTTP_COOKIE")=0 ) _
		 AND ( Instr(OWNG_ServerVar,"ALL_RAW")=0 ) _
		 AND ( Instr(OWNG_ServerVar,"ALL_HTTP")=0 ) _
		 then
			response.write( Server.HTMLEncode( OWNG_ServerVar ) & "=" & Server.HTMLEncode( OWNG_ServerVar_Value ) ) & VBCR
		end if
	next


 '	// Function borrowed from the OWNG codebase
 Function FormatDateISO8601(pTimestamp)
    Dim vTemp
    FormatDateISO8601 = Year(pTimestamp) & "-"
    vTemp = Month(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & "-"
    vTemp = Day(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & " "
    vTemp = Hour(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & ":"
    vTemp = Minute(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & ":"
    vTemp = Second(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp
End Function

 %>
</textarea>
</form>
<hr/>
</div>
</body>
</html>
