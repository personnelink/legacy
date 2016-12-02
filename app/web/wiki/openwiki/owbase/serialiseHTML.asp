<%@ Language=VBScript EnableSessionState=True %>
<%
Option Explicit
RESPONSE.BUFFER=TRUE
%>

<!-- #include file="ow/owall.asp" //-->

<html>
<head>
<link rel="stylesheet" type="text/css" href="ow/skins/default/ow.css" />
</head>
<body>
<%
    Dim SCRIPT_NAME, SERVER_NAME, SERVER_PORT, SERVER_PORT_SECURE
    Dim vUserSkin
    SCRIPT_NAME        = Request.ServerVariables("SCRIPT_NAME")
    SERVER_NAME        = Request.ServerVariables("SERVER_NAME")
    SERVER_PORT        = Request.ServerVariables("SERVER_PORT")
    SERVER_PORT_SECURE = Request.ServerVariables("SERVER_PORT_SECURE")

    If SERVER_PORT_SECURE = 0 Then
        gServerRoot = "http://" & SERVER_NAME
    Else
        gServerRoot = "https://" & SERVER_NAME
    End If
    If SERVER_PORT <> 80 Then
        gServerRoot = gServerRoot & ":" & SERVER_PORT
    End If
    gServerRoot = gServerRoot & Left(SCRIPT_NAME, InStrRev(SCRIPT_NAME, "/"))

    If OPENWIKI_SCRIPTNAME <> "" Then
        gScriptName = OPENWIKI_SCRIPTNAME
    Else
        gTemp = InStrRev(SCRIPT_NAME, "/")
        If gTemp > 0 Then
            gScriptName = Mid(SCRIPT_NAME, gTemp + 1)
        Else
            gScriptName = SCRIPT_NAME
        End If
    End If

    Server.ScriptTimeout=300 '   // Seconds. 600 = 10 minutes
    RESPONSE.WRITE(Archive("HTML"))
%>

</body>
</html>