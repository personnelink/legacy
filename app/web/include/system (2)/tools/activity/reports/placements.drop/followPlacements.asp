<%
dim is_service
if request.querystring("isservice") = "true" then is_service = true

'suppress style sheet; it's being loaded by userHome.asp
if not is_service then session("add_css") = "./followPlacements.asp.css"

session("required_user_level") = 4096 'userLevelPPlusStaff

if is_service then
	'suppress header and scripting; they are being loaded by calling host
	session("no_header") = true
else
	session("additionalScripting") = "<script type=""text/javascript"" src=""followPlacements.js""></script>"
end if
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #include file='followPlacements.classes.asp' -->
<script type="text/javascript" src="followPlacements.js"></script>
<!-- #include file='followPlacements.doStuff.asp' -->

<% if not is_service then %>

<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Placement Follow Up Status")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="get">

  <p style="padding-bottom:1em;>
	<%=objCompanySelector(whichCompany, false, "javascript:document.whoseHereForm.submit();")%>
 	<span id="activeonly">
		<label for="onlyactive">
			<input type="checkbox" id="onlyactive" name="onlyactive" value="1"<%if onlyactive then response.write " checked=""yes"""%> onchange="javascript:document.whoseHereForm.submit();"/>Only Show Active</label>
	</span>
</p>
<input name="page_title" id="page_title" type="hidden" value="Arrival Calls" />
 </form>

<%=PageNavigation%>

<% else %>

<input type="hidden" id="whichCompany" name="whichCompany" value="<%=whichCompany%>" />

<% end if %>

<%
dim i : i = 0
for each Appointment in Placements.Appointments.Items 
i = i + 1
%>

<table class="placements">
	<tr class="heading">
		<th class="date">Date & Time</th>
		<th class="applicant">Applicant</th>
		<th class="reason">Reason</th>
		<th class="foruser">Entered</th>
	</tr>
	 <tr class="details">
		<td><%=Appointment.ApptDate%></td>
		<td><%=Appointment.LnkMaintain%></td>
		<td><span class="idle" id="aloader<%=Appointment.id%>"><%=Appointment.ApptType%></span></td>
		<td><%=Appointment.EnteredBy%></td>
	</tr>
	<tr class="details">
		<th></th>
		<td><%=Appointment.ApplicantPhone%></td>
		<td></td>
		<td></td>
	</tr>
	<tr class="heading">
		<th class="customer">Customer</th>
		<th class="joborder">Job Order</th>
		<th class="status">Status</th>
		<th class="for">For</th>
	</tr>
	<tr class="details">
		<td><%=Appointment.CustomerCode & " : " & Appointment.CustomerName%></td>
		<td><%=Appointment.ReferenceId & " : " & Appointment.JobDescription%></td>
		<td><span class="idle" id="dloader<%=Appointment.id%>"><%=Appointment.Disposition%></span></td>
		<td><%=Appointment.AssignedTo%></td>
	</tr>
	<tr class="details">
		<td><%=Appointment.CustomerContact & Appointment.CustomerPhone%></td>
		<td class="jobsupervisor"><%=Appointment.JobSupervisor & " : " & Appointment.WorkSitePhone%></td>
		<td></span></td>
		<td></td>
	</tr>
	<tr class="footer">
		<td colspan="4"><span class="memo">Memo</span>: <span id="cm<%=Appointment.id%>" class="description"><%=Appointment.Comment%></span></td>
	</tr>
</table>
<%
next

if i = 0 then response.write "<i>No appointments or placement follow-ups</i>"
 %>
</table>

<% if not is_service then %>
<%=PageNavigation%>

</div>
<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->

<% end if %>