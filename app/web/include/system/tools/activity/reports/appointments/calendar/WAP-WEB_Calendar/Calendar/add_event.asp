<!--#include file="BeginPage.asp"-->
<%
Dim sYear, sMonth, sDay
sYear  = Request.QueryString("Y")
sMonth = Request.QueryString("M")
sDay  = Request.QueryString("D")

Dim objRecordset
Dim Added
%>
<!--#include file="DBConnect.asp"-->
<!--#include file="adovbs.inc"-->
<%
Set objRecordset = Server.CreateObject("ADODB.Recordset")
objRecordset.Open "calendar", DB_CONNECTIONSTRING, adOpenDynamic, adLockOptimistic, adCmdTable

If Request.Form("btnAdd") = "Add Event" Then

	'Add new record
    objRecordset.AddNew
	objRecordset.Fields("Subject") = Request.Form("txtSubject")
	objRecordset.Fields("Message") = Request.Form("Message")
	objRecordset.Fields("Day") = sDay
	objRecordset.Fields("Month") = sMonth
	objRecordset.Fields("Year") = sYear
	if Request.Form("txtAddedBy") <> "" then
		objRecordset.Fields("AddedBy") = Request.Form("txtAddedBy")
	End if
	objRecordset.Fields("DateAdded") = Now()
	objRecordset.Update

	Added = "True"
End If

'Set strDate variable to know which date to go on Calendar.asp
Dim strDate
strDate = sMonth & "/" & sDay & "/" & sYear

objRecordset.Close
Set objRecordset = Nothing

If Added = "True" Then
	Response.Redirect("calendar.asp?date=" & strDate)
End If

%>
<SCRIPT ID="clientEventHandlersJS" LANGUAGE="javascript">
<!--

function btnReset_onclick() {
document.fCancel.submit()
}

//-->
</SCRIPT>
<h2>
	Calendar
</h2>
<h3>
	Add an Event on
	<%= sMonth %>
	/<%= sDay %>/<%= sYear %>
</h3>
<form method="post" action="add_event.asp?Y=<%= sYear %>&M=<%= sMonth %>&D=<%= sDay %>">
	<table border="0" cellpadding="5" cellspacing="1" class="CalTable">
		<tr>
			<td class="CalNoDay">
				Display Subject:
				<br>
				<input type="text" name="txtSubject" size="35">
				<p>
					Event Details:
					<br>
					<textarea name="Message" cols="35" rows="8"></textarea>
				<!--  Commenting out Addded By field

  <td>Added By: <input type="text" name="txtAddedBy" size="35" value="<%= Session("FirstName") & " " & Session("LastName")%>"></td>

 
-->
			</td>
		</tr>
	</table>
	<p>
		<input type="submit" name="btnAdd" value="Add Event"><input type="button" name="btnReset" value="Cancel" LANGUAGE="javascript" onclick="return btnReset_onclick()">
</form>
<form action="calendar.asp?date=<%= sMonth %>/<%= sDay %>/<%= sYear %>" method="post" name="fCancel" id="fCancel">
</form>
<!--#include file="EndPage.asp"-->