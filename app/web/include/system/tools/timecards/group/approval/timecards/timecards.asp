<%
session("add_css") = "./timecards.005.css"
session("required_user_level") = 2048 'userLevelPPlusStaff
session("window_page_title") = "Timecards - Personnel Plus"
%>
<!-- #include virtual='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="timecards.js"></script>
<!-- #include virtual='/include/system/tools/timecards/group/timecard.classes.asp' -->
<!-- #include file='timecards.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="report_form" name="report_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", "Time")%>
<div id="whoseHereList"><%	if userLevelRequired(userLevelPPlusStaff) then %>
	<p><%=objCompanySelector(Customers.Site, false, "javascript:document.report_form.submit();")%>
		<a style="float:right;margin:.25em 1em .25em" class="squarebutton" href="#" onclick="act_refresh('<%=Customers.Customer%>');"><span>Refresh View</span></a>
	</p>
	<%	end if
		'get page nav records into re-cyclable variable
		dim PageNavigation : PageNavigation = Customers.PageSelection %>

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

for each Customer in Customers.Customers.Items
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
		
	REM if Customer.HasTimeOrExpense then
		REM hasTimeOrExpense = ""
	REM else
		REM hasTimeOrExpense = " GreyOut"
	REM end if
	hasTimeOrExpense = ""	
		
	dim qsActivityURL
	qsActivityURL = "" &_
		"?page_title=Activities&site=" &_
		Customers.Site & "&" &_
		"act_when=all&WhichOrder=&fromDate=3%2F20%2F2011&toDate=3%2F25%2F2011&" &_
		"WhichPage=&WhichPage=&activity_0=1&activity_6=1&activity_4=1&activity_7=1&" &_
		"activity_13=1&activity_14=1&activity_15=1&activity_16=1" &_
		"&customer=" & Customer.CustomerCode
	%>
		<div class="groupheader">
			<%=objShowMore(Customer.CustomerCode, Customer.CUstomerName)%>
			<span class="CustomerCode"><div><%=Customer.CustomerCode%></div></span>
			<span class="CustomerName"><div><%=Customer.CustomerName%></div></span>
			<span class="CustomerAddress"><div><%=Customer.Address & ", " & Customer.Cityline%></div></span>
			<span class="CustomerContact"><div><%=Customer.Contact%></div></span>
			<span class="CustomerPhone"><div><%=FormatPhone(Customer.Phone)%></div></span>
			<span class="DateLastActive"><div><%=Customer.DateLastActive%></div></span>
			<span class="CustomerActivities">
				<a href="/include/system/tools/activity/reports/activity/<%=qsActivityURL%>">[view activities]</a>
			</span>
		</div>

		<!-- '"<td class=""Reference"">"  & "</td>" &_ -->
		<%=orders_div(Customer.CustomerCode)%>
	
<%
next

Response.write group_footer

%>
	
<%=PageNavigation%>

</div>

<div id="helpkey">
	<p><span style="display:block;float:left"><span class="ClosePlacement"></span> = Active Placement, Time card Expected</span>
	<span style="display:block;float:right"><span class="ExpectingPlacement"></span> = Closed Placement</span>
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
