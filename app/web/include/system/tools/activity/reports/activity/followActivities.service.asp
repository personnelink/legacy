<%
session("required_user_level") = 256 'userLevelSupervisor
session("window_page_title") = "Activities"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->

<!-- #include file='followActivities.doStuff.asp' -->

<!-- begin presentation stuff -->

<input id="page_title" name="page_title" type="hidden" class="hidden" value="Activities">
<%=decorateTop("track_activities", "notToShort marLR10", "Activity Tracks")%>
<input id="whichCompany" name="whichCompany" type="hidden" class="hidden" value="<%=whichCompany%>">

		 <span id="activeonly">
			<label for="onlyactive">
			<input type="checkbox" id="onlyactive" name="onlyactive" value="1"<%if onlyactive then response.write " checked=""yes"""%> onchange="javascript:document.activity_form.submit();"/>Only Show Active</label>
		</span>
	</p>

	<ul id="which_dates" class="what_activities">
		<li><strong>Include what dates:</strong></li>
		<li><label><input class="noBorder" type="radio" id="act_when_all" name="act_when" value="all" onclick="enter_date('false')"<%=act_all%>>All dates</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_past" name="act_when" value="past" onclick="enter_date('false')"<%=act_past%>>Past dates</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_future" name="act_when" value="future" onclick="enter_date('false')"<%=act_future%>>Future dates</label></li>
		<li><label><input class="noBorder" type="radio" id="act_when_custom" name="act_when" value="custom" onclick="enter_date('true')"<%=act_custom%>>Other:</label></li>
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

	<% 'get page nav records into re-cyclable variable
		dim rsNavigationLnks : rsNavigationLnks = navRecordsByPage(rsWhoseHere) %>

	<%=rsNavigationLnks%>

	<% showActivityStream rsWhoseHere %>

	<%=rsNavigationLnks%>



<%=decorateBottom()%>

<%
'cleanup'
rsWhoseHere.close
Set rsWhoseHere = nothing

noSocial = true

'build left side menu'
leftSideMenu = makeSideMenu ()

%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
