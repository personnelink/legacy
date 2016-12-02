<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<SCRIPT language="JavaScript">
<!--
function confirmDelete(sheetID)
{
 var where_to= confirm("Do you really want to delete this message?");
 if (where_to== true)
 {
   window.location="/tools/timemanagement/manageTimesheets.asp?DeleteMessageID="+indexID;
 }
}

//-->
</SCRIPT>

<% 
'---- App Directory and Native Image Constants
const FormPostTo = "/tools/messaging/messageCenter.asp"

const linkImgNew = "<img style='border:none; cursor:pointer;' src='/include/style/images/ico_msgNew.gif' alt=' '></a>"
const linkImgRead = "<img style='border:none; cursor:pointer;' src='/include/style/images/ico_msgRead.gif' alt=' '></a>"
const linkImgReply = "<img style='border:none; cursor:pointer;' src='/include/style/images/ico_msgReply.gif' alt=' '></a>"
const linkImgForward = "<img style='border:none; cursor:pointer;' src='/include/style/images/ico_msgForward.gif' alt=' '></a>" 
const linkImgDelete = "<img style='border:none; cursor:pointer;' src='/include/style/images/ico_msgDelete.gif' alt=' '></a>"

Select Case Trim(Request.QueryString("Action"))
	Case msgNew
		NewMessage
	Case msgForward
	Case msgDelete
	Case msgRead
		ViewMessage
	Case msgReply
	Case msgViewFolder
		ViewFolder
	Case Else
End Select


Sub ViewFolder 
	dim i, messageID, from, subject, body, read, msgRead, Folder, FolderID

	FolderID = Request.QueryString("Folder")
	Select Case FolderID
	Case Inbox
		Folder = "Message Inbox Folder"
	Case Drafts
		Folder = "Saved Drafts Folder"
	Case Sent
		Folder = "Sent Items Folder"
	Case Deleted
		Folder = "Deleted Items Folder"
	End Select	
	
	Database.Open MySql
	Set dbQuery = Database.Execute("Select * From tbl_messages Where userID=" & user_id & " And folder=" & FolderID)	%>
	
	<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;">
		<div class="normalTitle" style="margin-bottom:0;"><%=Folder%></div>
		<table style="margin:10;border:none" width="615">
			<tr>
				<td width="3%"></td><td style="vertical-align:top" width="3%"></td>
				<td width="3%"></td><td style="vertical-align:top" width="3%"></td>
				<td width="21%"><p><strong>From</strong></p></td>
				<td width="44%"><p><strong>Subject</strong></p></td>
				<td width="23%"><p><strong>Date</strong></p></td>
			</tr>	<%
 			do while not dbQuery.eof
				ID = dbQuery("messageID")
				from = GetName(dbQuery("fromID"))
				subject = dbQuery("msgSubject")
				sentDate = dbQuery("CreationDate")
				read = dbQuery("msgRead")
				
				if read = "True" then
					msgRead = linkImgRead
				elseif read = "false" then
					msgRead = linkImgNew
				end if	%>
				
				<tr>
					<td style="vertical-align:top"><%=LinkMessaging & lnkMessageID & ID & "&amp;Folder=" & FolderID & lnkRead & msgRead%></td>
					<td style="vertical-align:top"><%=LinkMessaging & lnkMessageID & ID & "&amp;Folder=" & FolderID & lnkReply & linkImgReply %></td>
					<td style="vertical-align:top"><%=LinkMessaging & lnkMessageID & ID & "&amp;Folder=" & FolderID & lnkForward & linkImgForward %></td>
					<td style="vertical-align:top"><%=LinkMessaging & lnkMessageID & messageID & "&amp;Folder=" & FolderID & lnkDelete & linkImgDelete %></td>
					<td style="vertical-align:top"><%=from%></td>
					<td style="vertical-align:top"><%=subject%></td>
					<td style="vertical-align:top"><%=sentDate%></td>
				</tr>	<%
				dbQuery.Movenext
			loop %>
		</table>
	</div> 
	<%
	Set dbQuery = Nothing
	Database.Close
End Sub

Sub ViewMessage
	dim messageID, subject, body, Folder

	messageID = Request.QueryString("messageID")
	FolderID = Request.QueryString("Folder")
	Select Case FolderID
	Case Inbox
		Folder = "Viewing Message In Inbox Folder"
	Case Drafts
		Folder = "Viewing Message In Saved Drafts Folder"
	Case Sent
		Folder = "Viewing Message In Sent Items Folder"
	Case Deleted
		Folder = "Viewing Message In Deleted Items Folder"
	End Select	
	
	Database.Open MySql
	Set dbQuery = Database.Execute("Select * From tbl_messages Where messageID=" & messageID) 
	%>
	
	<div class="threeQuarterWidth leftOfPage bordered" style="padding-bottom:10;">
		<div class="normalTitle" style="margin-bottom:0;"><%=Folder%></div>
		<table style="margin:15px;border:none" width="605">
			<tr>
				<td style="vertical-align:top" width="10%"><strong>From:</strong><br><br></td>
				<td style="vertical-align:top" width="90%"><%=GetName(dbQuery("fromID"))%><br></td>
			</tr>
			<%
				Subject = dbQuery("msgSubject")
				Body = dbQuery("msgBody")
			%>	
				
			<tr>
				<td style="vertical-align:top"><strong>Subject:</strong><br><br></td>
				<td style="vertical-align:top"><%=Subject%></td>
			</tr>
			<tr>
				<td style="vertical-align:top"><strong>Message:</strong><br><br></td>
				<td style="vertical-align:top"><%=Body%></td>
			</tr>
		</table>
	</div>
	<%
	Set dbQuery = Database.Execute("UPDATE tbl_messages SET msgRead=True WHERE messageID=" & messageID)
	Set dbQuery = Nothing
	Database.Close
End Sub

Sub NewMessage
	if request.form("submit") = "Send" then
		Database.Open MySql
		sqlCommand = "Insert Into tbl_messages (userID, fromID, msgSubject, msgBody, msgRead, folder, CreationDate) Values ('" & _
					request.form("contacts") & "'," & _
					"'" & user_id & "'," & _
					"'" & request.form("subject") & "'," & _
					"'" & request.form("messagebody") & "'," & _
					"No, '" & Inbox & "', '" & Now() & "')" 
		'response.write(sqlCommand)
		'Response.End
		
		Database.Execute(sqlCommand)
		Response.Redirect(FormPostTo & "?Folder=" &  Inbox & "&amp;Action=" & msgViewFolder)
	end if
	
	dim ID, DisplayName, i, UserID, CompanyUsers(), PPlusTemps()
	
	DisplayName = 0
	UserID = 1
	Email = 2
	Database.Open MySql
	
	i = CountRecords("userID", "tbl_users", "companyID=" & companyId)
	Redim CompanyUsers(i, 1)
	
	i = CountRecords("employeeID", "tbl_assignments", "companyID=" & companyId)
	Redim PPlusTemps(i, 1)
	
	'Populate Address List
	Set dbQuery = Database.Execute("Select userID From tbl_users Where companyID=" & companyId) 
	i = 0
	do while not dbQuery.eof
		ID = dbQuery("userID")
		CompanyUsers(i, DisplayName) = GetName(ID)
		CompanyUsers(i, userID) = ID
		i = i + 1
		dbQuery.Movenext
	loop
	
	Set dbQuery = Database.Execute("Select employeeID From tbl_assignments Where companyID=" & companyId) 
	i = 0
	do while not dbQuery.eof
		ID = dbQuery("employeeID")
		PPlusTemps(i, DisplayName) = GetName(ID)
		PPlusTemps(i, userID) = ID
		i = i + 1
		dbQuery.Movenext
	loop
	
	%>
	
	<div class="sideMargin border">
		<div class="normalTitle bottommargin">New Message</div>
		<div class="divided">
			<form name="sendmail" id="sendmail" method="post" action="<%=FormPostTo & "?Action=" & msgNew%>">
			<select name="contacts" multiple>
				<option value="<%=SendMailAll%>">-All Internal / Contracted-</option>
				<option value="<%=SendMailAllCompany%>">-All Internal Users-</option>
				
				<%
				For i = 0 to ubound(CompanyUsers) - 1
					response.write("<option value='" & CompanyUsers(i, userID) & "'>" & CompanyUsers(i, DisplayName) & "</option>")
				Next
				%>
				<option value="<%=SendMailAllTemps%>">-All Contracted Users-</option>
				<%
				For i = 0 to ubound(PPlusTemps) - 1
					response.write("<option value='" & PPlusTemps(i, userID) & "'>" & PPlusTemps(i, DisplayName) & "</option>")
				Next
				%>
			</select>
		</div>	
		<div class="divided">
			<p><label for="subject">Subject</label>
			<input name="subject" type="text"></p>
			<p><label for="messagebody">Message</label>
			<textarea cols="25" rows="15" name="messagebody"></textarea></p>
		</div>
	</div>
	<div class="sideMargin">
	<p class="shiftright"><input class="normalbtn" name="submit" type="submit" value="Cancel">
	<input class="normalbtn" style="margin-right:30;" name="submit" type="submit" value="Send"></p>
	</div>
	</form>
	<%
	Set dbQuery = Nothing
	Database.Close
End Sub
%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
