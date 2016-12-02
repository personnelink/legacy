<%
session("add_css") = "./followPlacements.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #include file='followPlacements.classes.asp' -->
<script type="text/javascript" src="followPlacements.js"></script>
<!-- #include file='followPlacements.doStuff.asp' -->
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->

<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Placement Follow Up Status")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="get">
  <p style="padding-bottom:1em;"><%=objCompanySelector(whichCompany, false, "javascript:document.whoseHereForm.submit();")%>
 	<span id="activeonly">
		<label for="onlyactive">
			<input type="checkbox" id="onlyactive" name="onlyactive" value="1"<%if onlyactive then response.write " checked=""yes"""%> onchange="javascript:document.whoseHereForm.submit();"/>Only Show Active</label>
	</span>
</p>

 </form>

<%=PageNavigation%>
	
<% for each Appointment in Placements.Appointments.Items %>

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
		<td><%=Appointment.ApptType%></td>
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
		<td><div class="refandjobdescript"><%=Appointment.Disposition%><span class="idle" id="loader<%=Appointment.id%>"></span></div></td>
		<td><%=Appointment.AssignedTo%></td>
	</tr>
	<tr class="details">
		<td><%=Appointment.CustomerContact & Appointment.CustomerPhone%></td>
		<td class="jobsupervisor"><%=Appointment.JobSupervisor & " : " & Appointment.WorkSitePhone%></td>
		<td></span></td>
		<td></td>
	</tr>
	<tr class="footer">
		<td colspan="4"><span class="memo">Memo</span>: <span class="description"><%=Appointment.Comment%></span></td>
	</tr>
</table>
<% next %>
</table>

<%=PageNavigation%>

</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
