<!--#include file="BeginPage.asp"-->
<%
Dim objRecordset
Dim EventToShow
%>

<!--#include file="DBConnect.asp"-->
<!--#include file="adovbs.inc"-->

<%

Set objRecordset = Server.CreateObject("ADODB.Recordset")
objRecordset.Open "calendar", DB_CONNECTIONSTRING, adOpenStatic, adLockPessimistic, adCmdTable

EventToShow = CInt(Request.QueryString("ID"))

		If Not objRecordset.EOF Then

			objRecordset.MoveFirst
			Do Until objRecordset.Fields("ID") = EventToShow
				objRecordset.MoveNext
			Loop
		End If

'Session("EventToEdit") = EventToShow
%>

<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

function btnReset_onclick() {
document.fCancel.submit()
}

//-->
</SCRIPT>

<%
Dim sMonth, sDay, sYear
sMonth = objRecordset.Fields("Month")
sDay = objRecordset.Fields("Day")
sYear = objRecordset.Fields("Year")
%>
<h2>Calendar</h2>
<h3>Event on <%= sMonth %>/<%= sDay %>/<%= sYear %></h3>


<table border="0" cellpadding="5" cellspacing="1" class="CalTable" width="350">
 <tr>
  <td class="CalNoDay">

   <b><%= objRecordset.Fields("Subject") %></b><p>

<b>Details:</b><br><%= objRecordset.Fields("Message") %><p>


<b>Added
<% If trim(objRecordset.Fields("AddedBy")) = "" OR isNull(objRecordset.Fields("AddedBy")) then %>
	:</b><br><%= objRecordset.Fields("DateAdded")%>
<% else %>
	 By:</b><br><%= objRecordset.Fields("AddedBy") & " on " & objRecordset.Fields("DateAdded")%>
<% end if %>
</td></tr></table>

  <form method="post" action="edit_event.asp?ID=<%= EventToShow %>">
	<input type="submit" name="btnEditEvent" value="Edit/Delete Event"><input type="button" name="btnReset" value="Cancel" LANGUAGE=javascript onclick="return btnReset_onclick()">
  </form>

<form action="calendar.asp?date=<%= objRecordset.Fields("Month") & "/" & objRecordset.Fields("Day") & "/" & objRecordset.Fields("Year") %>" method=post name="fCancel" id="fCancel"></form>

<%
objRecordset.Close
Set objRecordset = Nothing
%>

<!--#include file="EndPage.asp"-->









