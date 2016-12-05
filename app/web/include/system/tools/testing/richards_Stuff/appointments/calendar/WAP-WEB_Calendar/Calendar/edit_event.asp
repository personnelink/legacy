<!--#include file="BeginPage.asp"-->
<!--#include file="adovbs.inc"-->
<!--#include file="DBConnect.asp"-->

<%
If Request.Form("btnCalendar") = "Cancel" Then
	Response.Redirect("calendar.asp")
End If

Dim EventToEdit
EventToEdit = request.QueryString("ID")

Dim objRecordset
Dim Updated

Dim sSQL
sSQL = "SELECT * FROM calendar WHERE (((calendar.ID)=" & cInt(EventToEdit) & "))"

Set objRecordset = Server.CreateObject("ADODB.Recordset")
objRecordset.Open sSQL, DB_CONNECTIONSTRING, adOpenStatic, adLockPessimistic, adCmdText

If objRecordset.EOF Then
	Response.Write "Error: No Event Passed."
	Response.End
End If

'Check for Update Button
If Request.Form("btnEdit") = "Update Event" Then

	'Update Record
	objRecordset.Fields("Subject") = Request.Form("txtSubject")
	objRecordset.Fields("Message") = Request.Form("Message")
	objRecordset.Fields("Day") = Request.Form("txtDay")
	objRecordset.Fields("Month") = Request.Form("txtMonth")
	objRecordset.Fields("Year") = Request.Form("txtYear")
	objRecordset.Fields("AddedBy") = Request.Form("txtAddedBy")
	objRecordset.Fields("DateAdded") = Now()
	objRecordset.Update
	
	If Request.Form("CkConfirm") <> "yes" then
		Response.redirect ("Calendar.asp?date=" & objRecordset.Fields("Month") & "/" & objRecordset.Fields("Day") & "/" & objRecordset.Fields("Year"))
	End if

	Updated = "True"
End If

'Check for Delete button
If Request.Form("btnDelete") = "Delete Event" Then
	'Set strDate variable to know which date to go on Calendar.asp
	Dim strDate
	strDate = objRecordset.Fields("Month") & "/" & objRecordset.Fields("Day") & "/" & objRecordset.Fields("Year")
	objRecordset.Delete adAffectCurrent
	Response.Redirect("calendar.asp?date=" & strDate)
End If

%>

<h2>Calendar</h2>
<h3>Edit Event on <%= sDate %></h3>

<form method="post" action="edit_event.asp?ID=<%= EventToEdit %>">
<table border="0" cellpadding="5" cellspacing="1" class="CalTable">
 <tr>
  <td class="CalNoDay">
  
  <%
  If Updated = "True" Then
	Response.Write("<p><b><font color='red'>" & objRecordset.Fields("Subject") & "</font> has been updated</b><p>")
  End If
  %>
<p>Change date to: <input type="text" name="txtMonth" size="3" value="<%= objRecordset.Fields("Month")%>">/
<input type="text" name="txtDay" size="3" value="<%= objRecordset.Fields("Day")%>">/
<input type="text" name="txtYear" size="5" value="<%= objRecordset.Fields("Year")%>">

<p>
Display Subject:<br><input type="text" name="txtSubject" size="35" value="<%= objRecordset.Fields("Subject")%>">

<p>
Details:<br>
<textarea name="Message" cols="35" rows="8"><%= objRecordset.Fields("Message")%></textarea>

<!-- Commenting out Added By field
<P>
Added By: <input type="text" name="txtAddedBy" size="35" value="<%= objRecordset.Fields("AddedBy")%>">
-->
<p>
<font size=-1><INPUT type="checkbox" id=CkConfirm name=CkConfirm value=yes> Show update Confirmation</font>

</td></tr></table>
<p>

<input type="submit" name="btnEdit" value="Update Event">
<input type="submit" name="btnDelete" value="Delete Event">
<input type="submit" name="btnCalendar" value="Cancel">

</form>

<%
objRecordset.Close
Set objRecordset = Nothing
%>

<!--#include file="EndPage.asp"-->

