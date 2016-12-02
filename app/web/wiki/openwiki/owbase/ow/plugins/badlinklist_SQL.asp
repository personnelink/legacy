<%@ Language=VBScript EnableSessionState=False %>
<!-- #include file="../owconfig_default.asp" //-->
<!-- #include file="../owado.asp" //-->
<%
' // $Log: badlinklist_SQL.asp,v $
' // Revision 1.2  2004/07/21 12:33:19  gbamber
' // Updated with variable OPENWIKI_TITLE
' //
' // Revision 1.1  2004/07/17 15:38:53  gbamber
' // BanLinkList plugin added.  Referers bugfixed
' //
' //
' gAdminPassword is set in owconfig_default.asp
Dim Success,szSQL
Success=False '	// Default to fail
Function ExecuteSQL(sz_DML)
'	// Nice code from owdeprecate
	On Error Resume Next
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open OPENWIKI_DB
    conn.Execute sz_DML
    Set conn = Nothing
End Function

If Request.Form("submitted")="yes" then
	If (Request.Form("pw")=gAdminPassword) OR (gAdminPassword="") then
		 ExecuteSQL("START TRAN;")
		szSQL="if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[openwiki_badlinklist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)" &_
"drop table [dbo].[openwiki_badlinklist];"
		 ExecuteSQL(szSQL)
		 szSQL="CREATE TABLE [dbo].[openwiki_badlinklist] (" &_
        "[bll_name] [varchar] (255) NOT NULL ," &_
        "[bll_comment] [varchar] (255) NULL DEFAULT 'Spam Link'" &_
") ON [PRIMARY]"
		 ExecuteSQL(szSQL) '	// Create the table//
		 szSQL="INSERT INTO openwiki_badlinklist (bll_name,bll_comment)VALUES('http://www.spam.com','Spam link');"
		 ExecuteSQL(szSQL)'	// Insert one entry//
         ExecuteSQL("IF @@ERROR > 0 ROLLBACK TRAN ELSE COMMIT TRAN;")
'		// Test for success
		Dim oConn
		Set oConn = Server.CreateObject("ADODB.Connection")
		oConn.Open OPENWIKI_DB
		Set oRS = Server.CreateObject("ADODB.Recordset")
		oRS.Open "SELECT * FROM openwiki_badlinklist;", oConn, adOpenForwardOnly
        Success=NOT oRS.EOF
        oRs.Close
        Set oRs=Nothing
        Set oConn=Nothing
        If Success=False then Response.Write("<h2>Update was unsuccessful.</h2>")
	Else '	// Bad Password
		Response.Write("Incorrect or missing Administration password.  Unable to proceed")
	End If	
End If
%>
<html>
<head><title>Initialise <%=OPENWIKI_TITLE%> SQL Database Table</title></head>
<body>
<%If Success = False then%>
<h2>Update <%=OPENWIKI_TITLE%> Database Schema for Bad Link List (SQL Server/MSDE)</h2>
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