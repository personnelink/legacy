<%
session("add_css") = "./followActivities.css"
session("required_user_level") = 256 'userLevelSupervisor
session("window_page_title") = "Activities - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="followActivities.js"></script>
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

	<p>
		<%=objCompanySelector(whichCompany, false, "act_refresh();")%>
		<a class="squarebutton" href="#" onclick="act_refresh('<%=thisCustomer%>');" style="float:right;margin:.25em 1em .25em"><span>Refresh View</span></a>
		 <span id="activeonly">
			<label for="onlyactive">
			<input type="checkbox" id="onlyactive" name="onlyactive" value="1"<%if onlyactive then response.write " checked=""yes"""%> onchange="act_refresh();"/>Only Show Active</label>
		</span>
	</p>

	<ul id="which_dates" class="what_activities">
		<li><strong>Include what dates:</strong></li>
		<li><label><input class="noBorder" type="radio" id="act_when_all" name="act_when" value="all" onclick="enter_date('false')"<%=act_all%>>All dates</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_past" name="act_when" value="past" onclick="enter_date('false')"<%=act_past%>>Past dates</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_future" name="act_when" value="future" onclick="enter_date('false')"<%=act_future%>>Future dates</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_custom" name="act_when" value="custom" onclick="enter_date('true')"<%=act_custom%>>Other:</label></li>
	</ul>



  <%=navChooseCustomer(whichCompany)%>

  <%=navChooseJobOrder(whichOrder)%>

  	<table id="enter_dates" class="<%=show_date_form%>">
		<tr><td>
	     	<label style="float:left; clear:left" for="fromDate">From </label>
			<input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>" onKeyPress="return submitenter(this,event)">
		</td></tr><tr><td>
			<label for="toDate" style="float:left; clear:left">To </label>
			<input  style="float:left; clear:left" name="toDate" id="toDate" type="text" value="<%=toDate%>" onKeyPress="return submitenter(this,event)">
		</td></tr>
	</table>
	
	<div style="width:100%; clear:both">
		<div style="float:left;">
			<label for="enteredby">Entered By</label><input style="float:left;" name="enteredby" id="enteredby" type="text" value="<%=showEnteredBy%>"></div>
		<div style="float:left;">
			<label for="assignedto">Assigned To</label><input style="float:left;" name="assignedto"" id="assignedto" type="text" value="<%=showAssignedTo%>"></div>
	</div>
			
	<% 'get page nav records into re-cyclable variable

				
		if len(include_what) > 0 then

			dim rsNavigationLnks : rsNavigationLnks = navRecordsByPage(rsWhoseHere) %>

			<%=rsNavigationLnks%>
			
			<%=htmlDivMenu%>
			
			<% showActivityStream rsWhoseHere 
	
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
