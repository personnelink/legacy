<%
dim is_service
if request.querystring("isservice") = "true" then is_service = true

	dim appointment_id, qs_appid
	qs_appid = request.querystring("appointmentid")
	if isnumeric(qs_appid) then
		appointment_id = cdbl(qs_appid)
	else
		appointment_id = 0
	end if

if appointment_id > 0 then is_service = true

'suppress style sheet; it's being loaded by userHome.asp
if not is_service then session("add_css") = "./followAppointments.asp.css"

session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_cache") = true


if is_service then
	'suppress header and scripting; they are being loaded by calling host
	session("no_header") = true
else
	session("additionalScripting") = "" &_
		"<script type=""text/javascript"" src=""followAppointments.001.js""></script>" &_
		"<script type=""text/javascript"" src=""/include/functions/calendar/calendar.js""></script>" &_
		"<script type=""text/javascript"" src=""/include/functions/calendar/calendar-setup.js""></script>" &_
		"<script type=""text/javascript"" src=""/include/functions/calendar/lang/calendar-en.js""></script>" &_
		"<style type=""text/css""> @import url(""/include/functions/calendar/calendar-blue.css""); </style>"
end if
%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #include file='followAppointments.classes.asp' -->

<% if not is_service then %>

<script type="text/javascript" src="followAppointments.001.js"></script>

<% end if %>

<!-- #include file='followAppointments.doStuff.asp' -->

<% if not is_service then %>

<%=decorateTop("WhoseHereForm", "notToShort marLR10", "Appointments")%>
<div id="whoseHereList">

<form id="whoseHereForm" name="whoseHereForm" action="<%=aspPageName%>" method="get">

  <p style="padding-bottom:1em;">
	<%=objCompanySelector(whichCompany, false, "javascript:document.whoseHereForm.submit();")%>
 	<span id="activeonly">
		<label for="onlyactive">
			<input type="checkbox" id="onlyactive" name="onlyactive" value="1"<%if onlyactive then response.write " checked=""yes"""%> onchange="javascript:document.whoseHereForm.submit();"/>Only Show Active</label>
	</span>
</p>
<input name="page_title" id="page_title" type="hidden" value="Appointments - Personnel Plus" />
 </form>

<%=PageNavigation%>


<% elseif appointment_id = 0 then %>
	<input name="page_title" id="page_title" type="hidden" value="Appointments" />
	<input type="hidden" id="whichCompany" name="whichCompany" value="<%=whichCompany%>" />

<% end if


if appointment_id = 0 then


%>
	<div id="new_appointment_div">
		<div class="clear"></div>
		<a href="javascript:;" class=" borDkBlue advert pad5 txtWhite bgLtBlue w100" onclick="appointment.newone(this);">new</a>
	</div>
	<%
	
end if

response.write "<div id=""appointment_stream"">"

dim i : i = 0
for each Appointment in Reminders.Appointments.Items 
	i = i + 1

	%>

	<table class="placements">
		<tr class="heading">
			<th class="customer">Customer</th>
			<th class="joborder">Job Order</th>
			<th class="foruser">Entered</th>
			<th class="date">Date & Time</th>
		</tr>
		 <tr class="details">
			<td onclick="lookup.show('customer','<%=Appointment.id%>');">
				<span id="cspan_<%=Appointment.id%>"><%=Appointment.CustomerCode & " : " & Appointment.CustomerName%></span>
				<div id="customer_<%=Appointment.id%>" class="hide search_div"><div>
					<input id="inp_customer_<%=Appointment.id%>" data-type="customer" data-appointmentid="<%=Appointment.id%>" name="csrch_<Appointment.id%>" type="text" onblur="lookup.set_self_destruct('customer','<%=Appointment.id%>');" onkeyup="lookup.search(this,'<%=Appointment.id%>');"/>
					<div id="customerLookUp_<%=Appointment.id%>" class="lookup_results"></div>
				</div></div>
			</td>
			<td onclick="lookup.show('order','<%=Appointment.id%>');">
				<span id="ospan_<%=Appointment.id%>"><%=Appointment.CustomerCode & " : " & Appointment.CustomerName%></span>
				<div id="order_<%=Appointment.id%>" class="hide search_div"><div>
					<input id="inp_order_<%=Appointment.id%>" data-type="order" data-appointmentid="<%=Appointment.id%>" name="jobsrch_<Appointment.id%>" type="text" onblur="lookup.set_self_destruct('order','<%=Appointment.id%>');" onkeyup="lookup.search(this,'<%=Appointment.id%>');"/>
					<div id="orderLookUp_<%=Appointment.id%>" class="lookup_results"></div>
				</div></div>
			<td><%=Appointment.EnteredBy%></td>
			<td class=""><%=Appointment.ApptDate%></td>
		</tr>
		<tr class="details">
			<td><%=Appointment.CustomerContact & Appointment.CustomerPhone%></td>
			<td class="jobsupervisor"><%=Appointment.JobSupervisor & " : " & Appointment.WorkSitePhone%></td>

			<td></td>
			<td></td>
		</tr>
		<tr class="heading">
			<th class="reason">Reason</th>
			<th class="applicant">Applicant</th>
			<th class="for">For</th>
			<th class="status">Status</th>
		</tr>
		<tr class="details">
			<td><span class="idle" id="aloader<%=Appointment.id%>"><%=Appointment.ApptType%></span></td>
			<td onclick="lookup.show('applicant','<%=Appointment.id%>');">
				<span id="aspan_<%=Appointment.id%>"><%=Appointment.LnkMaintain%></span>
				<div id="applicant_<%=Appointment.id%>" class="hide search_div"><div>
					<input id="inp_applicant_<%=Appointment.id%>"  data-type="applicant" data-appointmentid="<%=Appointment.id%>" name="applicantsrch_<%Appointment.id%> type="text" onblur="lookup.set_self_destruct('applicant','<%=Appointment.id%>');" onkeyup="lookup.search(this,'<%=Appointment.id%>');"/>
					<div id="applicantLookUp_<%=Appointment.id%>" class="searchbox lookup_results"></div>
				</div></div>
			</td>
			<td><%=Appointment.AssignTo%></td>
			<td class=""><span class="idle" id="dloader<%=Appointment.id%>"><%=Appointment.Disposition%></span></td>
		</tr>
		<tr class="details">

			<td></td>
			<td><%=Appointment.ApplicantPhone%></td>
			<td></td>
			<td></td>
		</tr>
		<tr id="tr_cm<%=Appointment.id%>" class="footer" onclick="appointment.comment.focus_edit('cm<%=Appointment.id%>');">
			<td colspan="4" ><span class="memo">Memo</span>:<span id="cm<%=Appointment.id%>" class="description" onclick="appointment.comment.edit(this);"><%=Appointment.Comment%></span>
				<textarea class="hide" id="txt_cm<%=Appointment.id%>"></textarea></td>
		</tr>
	</table> <%

next

if i = 0 and callingApp <> "joborder" then
	response.write "<i>No appointments or placement follow-ups</i>"
elseif i = 0 and callingApp = "joborder" then
	response.write "<i>No account placement or other activities</i>"
end if

set Reminders = nothing

 %>
</div>
</table>

<% if not is_service then %>
<%=PageNavigation%>

</div>
<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->

<% else %>

<!-- #INCLUDE VIRTUAL='/include/core/dispose_service_session.asp' -->

<% end if %>