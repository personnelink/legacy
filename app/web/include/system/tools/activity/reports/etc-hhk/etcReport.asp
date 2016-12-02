<%
session("add_css") = "./etcReport.css"
session("mobile_css") = "./etcReport.mobile.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Expected Timcards - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<link rel="stylesheet" type="text/css" href="/include/js/jquery.msgbox.css" />
<script type="text/javascript" src="/include/js/jquery.msgbox.min.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="etcReport.js"></script>
<style type="text/css"> @import url("/include/functions/calendar/calendar-blue.css"); </style>


<!-- #include file='etcReport.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="report_form" name="report_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", "Expected Timecards")%>
<div id="whoseHereList">
	<p>
		<%=objCompanySelector(whichCompany, false, "javascript:document.report_form.submit();")%>
		<a style="float:right;" class="squarebutton" href="#" onclick="act_refresh('<%=thisCustomer%>');" style="margin:.25em 1em .25em"><span>Refresh View</span></a>
	</p>

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

	<% 'get page nav records into re-cyclable variable
		dim rsNavigationLnks : rsNavigationLnks = navRecordsByPage(rsWhoseHere) %>

	<%=rsNavigationLnks%>

	<% showActivityStream rsWhoseHere %>

	<%=rsNavigationLnks%>

</div>

<div id="helpkey">
	<p><span style="display:block;float:left"><span class="ClosePlacement"></span> = Active Placement, Time card Expected</span>
	<span style="display:block;float:right"><span class="ExpectingPlacement"></span> = Closed Placement</span></p>
	<span style="display:block;float:right;margin:0 6em 0 0;"><span class="OpenPlacement"></span> = Expecting Final Time card</span></p>
</div>

<%=decorateBottom()%>

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
'cleanup'
rsWhoseHere.close
Set rsWhoseHere = nothing

noSocial = true

%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
