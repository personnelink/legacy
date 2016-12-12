<%
session("add_css") = "./timecards.003.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Timecards - Personnel Plus"
%>
<!-- #include virtual='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="timecards.js"></script>
<!-- #include virtual='/include/system/tools/timecards/group/timecard.classes.asp' -->
<!-- #include file='timecards.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="report_form" name="report_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", "Time")%>
<div id="whoseHereList">
	<p><%=objCompanySelector(Active.Site, false, "javascript:document.report_form.submit();")%>
		<a style="float:right;" class="squarebutton" href="#" onclick="act_refresh('<%=Active.Customer%>');" style="margin:.25em 1em .25em"><span>Refresh View</span></a>
	</p>

	<% 'get page nav records into re-cyclable variable
		dim PageNavigation : PageNavigation = Active.PageSelection %>

	<%=PageNavigation%>
	
<%
dim LastReference      : LastReference    = 0
dim LastDepartment     : LastDepartment   = 0
dim firstloop          : firstloop        = true
dim department_total   : department_total = 0



dim manage_customer_lnk
manage_customer_form = "/include/system/tools/manage/customer/?"

resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

dim previousCode          : previousCode          = ""
dim previousLastnameFirst : previousLastnameFirst = ""
dim objChangePlacement    : objChangePlacement    = ""			
dim strResponse           : strResponse           = ""
dim hasTimeOrExpense 

for each Placement in Active.Placements.Items
	' do while not ( rs.Eof Or rs.AbsolutePage <> nPage )
		' if rs.eof then
			' rs.Close
			' ' Clean up
			' ' Do the no results HTML here
			' response.write "No Items found."
			' ' Done
			' Response.End 
		' end if
		
		' chkSpace = instr(PStopDate, " ")
		' if chkSpace > 0 then
			' PStopDate = left(PStopDate, chkSpace - 1)
		' end if
		
		if previousCode <> Placement.CustomerCode then
			if previousCode <> "" then
				response.write group_footer
			end if
			
			response.write main_header(Placement.CustomerCode, Placement.CustomerName, Placement.JobDescription) 'classes: CustomerCode, CustomerName, CostCenter
		
			response.write group_header
			
			previousCode = Placement.CustomerCode
		end if

		if Placement.HasTimeOrExpense then
			hasTimeOrExpense = ""
		else
			hasTimeOrExpense = " GreyOut"
		end if
		
		if Placement.lastnamefirst = previousLastnameFirst then
			useThisLastnameFirst = "&nbsp;&nbsp;&nbsp;^&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;"
		else
			useThisLastnameFirst  = Placement.lastnamefirst
			previousLastnameFirst = useThisLastnameFirst
		end if
		%>

		<table class="etcdetails">
			<tr>
				<td class="lastnamefirst<%=hasTimeOrExpense%>"><div><%=objOpenClosePlacement(Placement.PlacementId, Placement.Status) & useThisLastnameFirst%></div></td>
				<td class="EmployeeNumber<%=hasTimeOrExpense%>"><%=Placement.EmployeeNumber%></td>
				<td class="JobNumber<%=hasTimeOrExpense%>"><%=Placement.Reference%></td>
				<td class="WCDescription<%=hasTimeOrExpense%>"><div><%=Placement.WCDescription%></div></td>
				<td class="StartDate<%=hasTimeOrExpense%>"><%=Placement.StartDate%></td>
				<td class="PStopDate<%=hasTimeOrExpense%>"><div><%=Placement.PStopDate%></div></td>
				<td class="WorkCode<%=hasTimeOrExpense%>"><%=Placement.WorkCode%></td>
				<% if show_paid then %>
				<td class="RegPayRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegPayRate%></td>
				<% end if %>
				<% if show_bill then %>
				<td class="RegBillRate alignR<%=hasTimeOrExpense%>">$<%=Placement.RegBillRate%></td>
				<% end if %>
				<td class="ExpenseSummary alignR<%=hasTimeOrExpense%>"><%=Placement.ExpenseSummary%></td>
				<td class="TimeSummary alignR<%=hasTimeOrExpense%>"><%=Placement.TimeSummary%></td>
				<td class="OkayApprove alignR">
					<input type="checkbox" class="TimeOkay" id="TimeOkay<%=Placement.PlacementId%>" onclick="timeokay.open('<%Placement.PlacementId%>', '<%Active.Site%>')" />
				</td>
			</tr>
		</table>
		<!-- '"<td class=""Reference"">"  & "</td>" &_ -->
		<%=time_summary_div(Placement.PlacementId)%>
	
<%
next

Response.write group_footer

%>
	
<%=PageNavigation%>

</div>

<div id="helpkey">
	<p><span style="display:block;float:left"><span class="ClosePlacement"></span> = Active Placement, Time card Expected</span>
	<span style="display:block;float:right"><span class="ExpectingPlacement"></span> = Closed Placement</span></p>
	<span style="display:block;float:right;margin:0 6em 0 0;"><span class="OpenPlacement"></span> = Expecting Final Time card</span></p>
</div>

<%=decorateBottom()%>
<input type="hidden" id="WarnedOverwriteDetail" name="WarnedOverwriteDetail" value="no" />
<input type="hidden" id="WarnedOverwriteSummary" name="WarnedOverwriteSummary" value="no" />

</form>

<!--
<div id="popup">
    <p>Are you sure you want to go to example.com?</p>
    <p>
        <a onclick="document.location='http://example.com/'; return false;">
            Yes
        </a>
        <a onclick="document.getElementById('popup').style.display = 'none'; return false;">
            No
        </a>
    </p>
</div>
-->

<%
noSocial = true
%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
