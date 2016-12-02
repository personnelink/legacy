<%@LANGUAGE="VBSCRIPT"%>
<% FormPostTo = "#?Action=" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%
if request.form("updatePlacements") = "Update Placements" then
	Database.Open MySql
	RequisitionID = request.form("RequisitonNumber")
	Database.Execute("Delete From tbl_placements Where requisitionID=" & RequisitionID)
	Placed = 0
	For i = 1 to request.form("Placements")
		if len(request.form("PlacedApplicants" & Trim(CStr(i)))) > 0 then
			Placed = Placed + 1
			Database.Execute("INSERT INTO tbl_placements (applicantID, requisitionID) VALUES ('" & request.form("PlacedApplicants" & Trim(CStr(i))) & "', '" & RequisitionID & "')")
			Database.Execute("INSERT INTO tbl_assignments (companyID, employeeID) VALUES ('" & request.form("companyID") & "', '" & request.form("PlacedApplicants" & Trim(CStr(i))) & "')")
		end if
	Next
	Database.Execute("Update tbl_jobRequisitions Set placed=" & Placed & " Where requisitionID=" & RequisitionID)
	Database.Close
end if

dim Companies
dim Companies_numRows

Set Companies = Server.CreateObject("ADODB.Recordset")
With Companies
	.ActiveConnection = MySql
	.Source = "SELECT * FROM tbl_companies ORDER BY companyName ASC"
	.CursorType = 0
	.CursorLocation = 2
	.LockType = 1
	.Open()
End With

Companies_numRows = 0
dim Applicants__MMColParam
Applicants__MMColParam = "1"
if (Request.QueryString("userLevelEngaged") <> "") then 
  Applicants__MMColParam = Request.QueryString("userLevelEngaged")
End if %>
<%
dim Applicants
dim Applicants_numRows

Set Applicants = Server.CreateObject("ADODB.Recordset")
With Applicants
	.ActiveConnection = MySql
	.Source = "SELECT * FROM tbl_users WHERE userLevel <= " + Replace(Applicants__MMColParam, "'", "''") + " ORDER BY lastName ASC"
	.CursorType = 0
	.CursorLocation = 2
	.LockType = 1
	.Open()
End With

Applicants_numRows = 0
%>

<style type="text/css">@import url(/include/functions/calendar/calendar-blue2.css);</style>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<SCRIPT language="JavaScript">
<!--
function confirmDelete(reqID)
{
 var where_to= confirm("Do you really want to delete this Job Applicant?");
 if (where_to== true)
 {
   window.location="<%=FormPostTo & remove & "&amp;ReqID="%>" + reqID;
 }
}
//-->
</SCRIPT>
<%=decorateTop("", "notToShort marLR10", "Job Requisitions")%>
<div id="whoseHereList">
<%
	Database.Open MySql
	if Request.QueryString("Action") = View then
		ReqID = Request.QueryString("RequisitionID")
		Set Requisition = Server.CreateObject("ADODB.Recordset")
		With Requisition
			.ActiveConnection = MySql
			.Source = "SELECT * FROM tbl_jobRequisitions WHERE requisitionID=" & ReqID
			.CursorType = 0
			.CursorLocation = 2
			.LockType = 1
			.Open()
		End With
		
		Requisition_numRows = 0 %>
			<div class="normalTitle" style="margin-bottom:5px;"><%=GetCompanyName(Requisition.Fields.Item("companyID").Value) & " - " & Requisition.Fields.Item("jobtitle").Value %></div>
			<form name="ReqDetail" method="post" action="<%=FormPostTo & add%>"> 
			<div class="" style="padding:10">
				<table class="border" width="600" cellpadding="0" cellspacing="0">
					<tr>
						<td><strong>Category</strong></td><td><%=Requisition.Fields.Item("category").Value %></td>
						<td><strong>Dresscode</strong></td><td><%=Requisition.Fields.Item("dresscode").Value %></td>
						<td><strong>Start Date</strong></td><td><%=Requisition.Fields.Item("startdate").Value %></td>
						<td><strong>End Date</strong></td><td><%=Requisition.Fields.Item("enddate").Value %></td>
					</tr>
					<tr>
						<td><strong>Wage</strong></td><td>$<%=TwoDecimals(Requisition.Fields.Item("wage").Value) %></td>
						<td><strong>Wage Type</strong></td><td><%=Requisition.Fields.Item("wagetype").Value %></td>
						<td><strong>Schedule</strong></td><td><%=Requisition.Fields.Item("schedule").Value %></td>
						<td><strong>Interview</strong></td><td><%=Requisition.Fields.Item("interview").Value %></td>
					</tr>
				</table>
			</div>
			<div class="" style="padding:10">
				<%=Requisition.Fields.Item("comments").Value %>
			</div>
			<div>
				<div class="normalTitle" style="margin-bottom:5px;">Placements</div>
				<div class="" style="padding:10">
				
				<table width="600" cellpadding="2" cellspacing="0">
					<%
					Set Placements = Server.CreateObject("ADODB.Recordset")
					Placements.ActiveConnection = MySql
					Placements.Source = "SELECT * FROM tbl_placements WHERE requisitionID=" & ReqID
					Placements.CursorType = 0
					Placements.CursorLocation = 2
					Placements.LockType = 1
					Placements.Open()
					while (Not Placements.eof) %>
						<tr style="margin-bottom:2px"><td> <%
						PositionsFilled = PositionsFilled + 1 %>
						<label for="PlacedApplicants">Applicant To Assign</label>
						<select name="PlacedApplicants<%=PositionsFilled%>" class="createUser">
						<option value="">No Applicant Placed</option> <%
						while (Not Applicants.eof) %>
							<option value="<%=Applicants.Fields.Item("userID").Value%>" <%
							if Placements.Fields.Item("applicantID").Value = Applicants.Fields.Item("userID").Value then %>
								 selected="selected" <%
							End IF %> ><%=GetName(Applicants.Fields.Item("userID").Value)%> - <%=Applicants.Fields.Item("userPhone").Value%>, <%=Applicants.Fields.Item("userSPhone").Value%>, <%=Applicants.Fields.Item("userEmail").Value%></option> <%
							Applicants.Movenext	
						Wend
						Applicants.Movefirst %>
						</select> <%
						Placements.Movenext %>
						</td></tr> <%								
					Wend
					if PositionsFilled < Requisition.Fields.Item("workers").Value then
						For i = 1 to Requisition.Fields.Item("workers").Value - PositionsFilled %>
							<tr style="margin-bottom:2px"><td>
							<label for="PlacedApplicants">Applicant To Assign</label>
							<select name="PlacedApplicants<%=PositionsFilled + i%>" class="createUser">
							<option value="">No Applicant Placed</option> <%
							while (Not Applicants.eof) %>
								<option value="<%=Applicants.Fields.Item("userID").Value%>"><%=GetName(Applicants.Fields.Item("userID").Value)%> - <%=Applicants.Fields.Item("userPhone").Value%>, <%=Applicants.Fields.Item("userSPhone").Value%>, <%=Applicants.Fields.Item("userEmail").Value%></option> <%
								Applicants.Movenext	
							Wend
							Applicants.Movefirst %>
							</select></td></tr> <%
						Next
					End if %>
				</table>
			</div>
			<div class="" style="padding:15px;text-align:right;width:575px">
				
				<input name="companyID" type="hidden" value="<%=Requisition.Fields.Item("companyID").Value%>">
				<input name="Placements" type="hidden" value="<%=Requisition.Fields.Item("workers").Value%>">
				<input name="RequisitonNumber" type="hidden" value="<%=ReqID%>">
				
				<input class="normalbtn" name="updatePlacements" type="submit" value="Update Placements">
			</div>
			</div>
			</form>
		</div> <%
			
	end if
%>

	
<div class="sideMargin border" style="margin-left:0;margin-bottom:10;">
	<div class="normalTitle" style="margin-bottom:5px;">Job Requisitions</div>
	<form name="ReqSummary" method="post" action="<%=FormPostTo & add%>">
    
            <%
			
dim Requisitions
dim Requisitions_numRows


while (NOT Companies.eof) 
	Set Requisitions = Server.CreateObject("ADODB.Recordset")
	Requisitions.ActiveConnection = MySql
	Requisitions.Source = "SELECT * FROM tbl_jobRequisitions WHERE companyID=" & (Companies.Fields.Item("companyID").Value) & " ORDER BY creationDate DESC"
	Requisitions.CursorType = 0
	Requisitions.CursorLocation = 2
	Requisitions.LockType = 1
	Requisitions.Open()

	Requisitions_numRows = 0

	if Not Requisitions.eof then %>
	
		<div class="sideMargin" style="margin-left:0">
			<div class="normalTitle" style="margin-top:10;margin-bottom:5px;text-align:left"><%=GetCompanyName(Companies.Fields.Item("companyID").Value)%></div>
  			<table width="615" cellpadding="0" cellspacing="0">
       			<tr>
       				<td width="4%"></td>
       				<td width="4%"></td>
   				    <td width="15%"><b>Date</b></td>
       				<td width="9%"><b>ID</b></td>
       				<td width="55%"><b>Position Title</b></td>
       				<td width="16%"><b>Status</b></td>
       				<td width="2%"><center><b>!</b></center></td>
       			</tr> <%
				while (Not Requisitions.eof)	
					ReqLink = FormPostTo & view & "&amp;RequisitionID="
					if (Requisitions.Fields.Item("lastModified").Value) > (Requisitions.Fields.Item("creationDate").Value) then 
						updateAlert = "<img style='padding-right:4px;' src='/include/style/images/flashing_light.gif' height='10' width='10'>"
					Else
						updateAlert	= ""
					end if	
					smallDate = Requisitions.Fields.Item("lastmodified").Value	%>
		       		<tr>
          				<td><input style="border:none" type="checkbox" name="checkbox<%=reqID%>" value="checkbox" id="checkbox<%=reqID%>"></td>
	          			<td><img style="border:none; cursor:pointer" src="/include/style/images/ico_msgDelete.gif" onclick="confirmDelete(<%=reqID%>);"></td>
   		      			<td><a href="<%= ReqLink & (Requisitions.Fields.Item("requisitionID").Value) %>"><%=Mid(smallDate, 1, Instr(smallDate, " ")-1) %></a></td>
       		  			<td><a href="<%= ReqLink & (Requisitions.Fields.Item("requisitionID").Value) %>"><%=(Requisitions.Fields.Item("requisitionID").Value) %></a></td>
          				<td><a href="<%= ReqLink & (Requisitions.Fields.Item("requisitionID").Value) %>"><%=(Requisitions.Fields.Item("jobTitle").Value) %></a></td>
   	      				<td><a href="<%= ReqLink & (Requisitions.Fields.Item("requisitionID").Value) %>"><%=(Requisitions.Fields.Item("placed").Value) & " / " & Requisitions.Fields.Item("workers").Value%></a></td>
       					<td><%=updateAlert%></td>
		        	</tr>  <%
					Requisitions.Movenext()
				Wend
				Requisitions.Close()
				Set Requisitions = Nothing	%>
			</table>
		</div>
 <%
	end if
	Companies.Movenext()
Wend
Companies.Close()
Set Companies = Nothing %>
</form>
</div></div>

<%
Response.write DecorateBottom()

Applicants.Close()
Database.Close

Set Applicants = Nothing
TheEnd
%>