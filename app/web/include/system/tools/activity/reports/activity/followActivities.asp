<%
session("add_css") = "./followActivities.css"
session("required_user_level") = 256 'userLevelSupervisor
session("window_page_title") = "Activities - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="followActivities.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<style type="text/css"> @import url("/include/functions/calendar/calendar-blue.css"); </style>

<!-- #include file='followActivities.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="activity_form" name="activity_form" action="" method="get">

<% 'initialize floating menu

'build left side menu and load htmlDivMenu with content
' leftSideMenu = makeSideMenu ()
' if instr(leftSideMenu, "</form>") = 0 then leftSideMenu = leftSideMenu & "</form>"

%>
<input id="page_title" name="page_title" type="hidden" class="hidden" value="Activities">
<%=decorateTop("track_activities", "notToShort marLR10", "Activity Tracks")%>
<div id="whoseHereList">

 <div id="filtering_options">
				<div id="show_basic_filters" class="borDkBlue advert pad5 txtWhite bgLtBlue w80"><p><strong>Show Date, Customer, Job Order and Applicant filtering options to include in report</strong></p></div>
				<div id="basic_filters" class="hide">
					<div id="hide_basic_filters"  class=" borDkBlue advert pad5 txtWhite bgLtBlue w80"><p><strong>Hide Date, Customer, Job Order and Applicant filtering options to include in report</strong></p></div>
					<div id="" class="navPageRecords">

	<p>
		<%=objCompanySelector(whichCompany, false, "act_refresh();")%>
		<a class="squarebutton" href="#" onclick="act_refresh('<%=thisCustomer%>');" style="float:right;margin:.25em 1em .25em"><span>Refresh View</span></a>
		 <span id="activeonly">
			<label for="onlyactive">
			<input type="checkbox" id="onlyactive" name="onlyactive" value="1"<%if onlyactive then response.write " checked=""yes"""%> onchange="act_refresh();"/>Only Show Active</label>
		</span>
		
		<span id="reverse_order" style="display:inline;">
			<label for="reverseorder">
			<input type="checkbox" id="reverseorder" name="reverseorder" value="1"<%if reverse_order then response.write " checked=""yes"""%> onchange="javascript:document.activity_form.submit();"/>Order by newest first</label>
		</span>

	</p>

	<ul id="which_dates" class="what_activities what_dates">
		<li><strong>Include what dates:</strong></li>
		<li><label><input class="noBorder" type="radio" id="act_when_all" name="act_when" value="all" onclick="enter_date('false')"<%=act_all%>>All</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_past" name="act_when" value="past" onclick="enter_date('false')"<%=act_past%>>Past</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_future" name="act_when" value="future" onclick="enter_date('false')"<%=act_future%>>Future</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_custom" name="act_when" value="custom" onclick="enter_date('true')"<%=act_custom%>>Other:</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_past" name="act_when" value="past" onclick="enter_date('false')"<%=act_past%>>Today</label></li>
	</ul>
	
  	<table id="enter_dates" class="<%=show_date_form%>">
		<tr><td>
	     	<label style="float:left; clear:left" for="fromDate">From </label>
			<input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>" onKeyPress="return submitenter(this,event)">
		</td></tr><tr><td>
			<label for="toDate" style="float:left; clear:left">To </label>
			<input  style="float:left; clear:left" name="toDate" id="toDate" type="text" value="<%=toDate%>" onKeyPress="return submitenter(this,event)">
		</td></tr>
	</table>
	
	<div id="ajax_inputs" class="navPageRecords">
		
		<div class="search">
			<label for="WhichCustomer">Customer</label>
			<input name="WhichCustomer" id="WhichCustomer" type="text" onkeyup="lookup_id(this);" value="<%=thisCustomer%>"></div>
			
			<!-- onclick event to call to set customer above and refresh page: 
							response.write "<A HREF=""#"" onclick=""arc('" & CurrentCustomer & "')"">"
			-->

		<div class="search">
			<label for="WhichOrder">Job Orders</label>
			<input name="WhichOrder" id="WhichOrder" type="text" onkeyup="lookup_id(this);" value="<%=whichOrder%>"></div>
			
		<div class="search">
			<label for="employee_search">Employee</label>
			<input style="float:left;" name="Employee" id="Employee" type="text" onkeyup="lookup_id(this);" value="<%=employee_search%>"></div>
			
		<div class="search">
			<label for="enteredby">Entered By</label><input style="float:left;" name="enteredby" id="enteredby" type="text" onkeyup="lookup_id(this);" value="<%=showEnteredBy%>"></div>
			
		<div class="search">
			<label for="assignedto">Assigned To</label>
			<input style="float:left;" name="assignedto" id="assignedto" type="text" onkeyup="lookup_id(this);" value="<%=showAssignedTo%>"></div>

		<div class="search">
			<label for="search_box">Search</label>
			<input name="search_box" id="search_box" type="text" onkeyup="lookup_id(this);" value="<%=search%>"></div>


	</div><div id="lookup_response"></div>
	

			
	<% 'get page nav records into re-cyclable variable

				
		if len(include_what) > 0 then
		
			dim rsNavigationLnks : rsNavigationLnks = navRecordsByPage(rsWhoseHere) %>

			<%=htmlDivMenu%></div></div></div></div>



			<%=rsNavigationLnks%>
			<div id="main_news_stream" class="clear w100">	</div> 
				<% showActivityStream rsWhoseHere %>
		<%
	
		end if
		
	%>

	<%=rsNavigationLnks%>

</div>

<%=decorateBottom()%>
</form>
<%

if len(include_what) > 0 then

	'cleanup'
	rsWhoseHere.close
	Set rsWhoseHere = nothing

end if

noSocial = true

leftSideMenu = ""
%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
