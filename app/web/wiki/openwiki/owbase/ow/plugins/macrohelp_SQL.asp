<%@ Language=VBScript EnableSessionState=False %>
<!-- #include file="../owpreamble.asp" //-->
<!-- #include file="../owconfig_default.asp" //-->
<!-- #include file="../owado.asp" //-->
<%
' // $Log: macrohelp_SQL.asp,v $
' // Revision 1.1  2004/08/04 22:30:13  gbamber
' // MacroHelp files
' //
' gAdminPassword is set in owconfig_default.asp
Dim Success,szSQL
Dim oConn
Set oConn = Server.CreateObject("ADODB.Connection")
oConn.Open OPENWIKI_DB
Success=False '        // Default to fail

If Request.Form("submitted")="yes" then
        If (Request.Form("pw")=gAdminPassword) OR (gAdminPassword="") then
                oConn.BeginTrans()
                szSQL="if exists (select * from dbo.sysobjects where id = object_id(N'openwiki_macrohelp') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
                "drop table openwiki_macrohelp;"
                 oConn.Execute(szSQL)
                 szSQL="CREATE TABLE openwiki_macrohelp (" &_
                 "macro_name [varchar] (255) NOT NULL PRIMARY KEY," &_
                 "macro_builtin [int] NULL DEFAULT 1," &_
                 "macro_numparams [int] NULL DEFAULT 0," &_
                 "macro_description [varchar] (255) NULL DEFAULT 'No description available'," &_
                 "macro_param1 [varchar] (255) NULL DEFAULT 'None'," &_
                 "macro_param2 [varchar] (255) NULL DEFAULT 'None'," &_
                 "macro_param3 [varchar] (255) NULL DEFAULT 'None'," &_
                 "macro_comment [varchar] (255) NULL DEFAULT 'None'" &_
                 ") ON [PRIMARY]"
                 oConn.Execute(szSQL)
                 If oConn.Errors.Count = 0 then
                    oConn.CommitTrans()
                    Success=True
                 else
                     oConn.RollbackTrans()
                    Success=False
                 End If
'                // Test for success disabled because of no default data
'                Set oRS = Server.CreateObject("ADODB.Recordset")
'                oRS.Open "SELECT * FROM openwiki_macrohelp;", oConn, adOpenForwardOnly
'        Success=NOT oRS.EOF
'        oRs.Close
'        Set oRs=Nothing
        If Success=False then Response.Write("<h2>Update was unsuccessful.</h2>")
        Else '        // Bad Password
                Response.Write("Incorrect or missing Administration password.  Unable to proceed")
        End If
End If
Set oConn = Nothing
%>
<html>
<head><title>Initialise <%=OPENWIKI_TITLE%> SQL Database Table</title></head>
<body>
<%If Success = False then%>
<h2>Update <%=OPENWIKI_TITLE%> Database Schema for Macro Help (SQL Server/MSDE)</h2>
<hr />
<form method="POST" name="postform">
        <input type="hidden" name="submitted" value="yes" />
        Administrator password: <input type="text" size="16" name="pw" value="" /> (or leave blank)
        <br />
        <input type="submit" name="doit" value="Initialise Database" />
</form>
<hr />
<%Else%>
<h2>Update Successful!</h2>
Congratulations! You have successfully updated the <%=OPENWIKI_TITLE%> database.
<%End If%>
</body>
</html>