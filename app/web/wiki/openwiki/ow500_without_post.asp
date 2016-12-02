<%@Language="VBSCRIPT"%>
<%
  Option Explicit
'  On Error Resume Next
  Response.Clear
  Dim objError
  Set objError = Server.GetLastError()
%>
<html>
<head>
<title>OpenwikiNG Error page</title>
<style>
BODY  { FONT-FAMILY: Arial; FONT-SIZE: 10pt;
        BACKGROUND: #ffffff; COLOR: #000000;
        MARGIN: 15px; }
H2    { FONT-SIZE: 16pt; COLOR: #ff0000; }
TABLE { BACKGROUND: #000000; PADDING: 5px; }
TH    { BACKGROUND: #0000ff; COLOR: #ffffff; }
TR    { BACKGROUND: #cccccc; COLOR: #000000; }
</style>
</head>
<body>
<hr>
<h2 align="center">OpenwikiNG Automatic Error Report</h2>

<p align="center">An error occurred which was not your fault.<br/>
Please copy the information below, and paste into a text file for support personnel to see.<br/><br/>
<i><a href="http://www.openwiking.com/forum/forum.asp?FORUM_ID=9">The openwikiNG team</a></i>
</p>

<hr>
<form name="owng_error_report">
<textarea cols="160" rows="80" READONLY>
<%
Dim OWNG_ServerVar, OWNG_ServerVar_Value, OWNG_FormVar, OWNG_FormVar_Value

Response.Write ( Server.HTMLEncode( "=== OWNG Error Dump ===" & VBCR & VBCR ) )

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


 %>
</textarea>
</form>
</body>
</html>
