<%
session("add_css") = "./etcReport.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Expected Timcards - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="etcReport.js"></script>
<!-- #include file='etcReport.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="report_form" name="report_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", "Expected Timecards")%>
<div id="whoseHereList">
	<p>
		<label for="whichCompany">Select Location</label>
		<select name="whichCompany" id="whichCompany" class="styled" onchange="javascript:document.report_form.submit();">
		 <option value="">--- Select Area ---</option>
		 <option value="BUR" <% if whichCompany = "BUR" then Response.write "selected" %>>Burley</option>
		 <option value="PER" <% if whichCompany = "PER" then Response.write "selected" %>>Twin Falls and Jerome</option>
		 <option value="BOI" <% if whichCompany = "BOI" then Response.write "selected" %>>Boise and Nampa</option>
		 <option value="IDA" <% if whichCompany = "IDA" then Response.write "selected" %>>Idaho Department of Ag</option>
		</SELECT>
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
