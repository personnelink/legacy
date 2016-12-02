<%
session("add_css") = "./reports.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="followActivities.js"></script>
<!-- #include file='followActivities.doStuff.asp' -->


<!-- begin presentation stuff -->
<form id="activity_form" name="activity_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", "Activity Tracks")%>
<div id="whoseHereList">
	<p>
		<%=objCompanySelector(whichCompany, false, "javascript:document.activity_form.submit();")%>
		<a style="float:right;" class="squarebutton" href="#" onclick="act_refresh('<%=thisCustomer%>');" style="margin:.25em 1em .25em"><span>Refresh View</span></a>
	</p>

	<ul id="which_dates" class="what_activities">
		<li><strong>Include what dates:</strong></li>
		<li><label><input type="radio" id="act_when_all" name="act_when" value="all" onclick="enter_date('false')"<%=act_all%>>All dates</label></li>
		<li><label><input type="radio" id="act_when_past" name="act_when" value="past" onclick="enter_date('false')"<%=act_past%>>Past dates</label></li>
		<li><label><input type="radio" id="act_when_future" name="act_when" value="future" onclick="enter_date('false')"<%=act_future%>>Future dates</label></li>
		<li><label><input type="radio" id="act_when_custom" name="act_when" value="custom" onclick="enter_date('true')"<%=act_custom%>>Other:</label></li>
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

  <%=navRecordsByPage(rsWhoseHere)%>

  <% showActivityStream rsWhoseHere %>

  <%=navRecordsByPage(rsWhoseHere)%>

</div>

<%=decorateBottom()%>

<%
'cleanup'
rsWhoseHere.close
Set rsWhoseHere = nothing
%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
