<%
session("add_css") = "./heardHow.asp.css"
session("required_user_level") = 2048 'userLevelSupervisor
session("window_page_title") = "Heard About Us How - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<% if isDev then Server.ScriptTimeout = 3 %>

<script type="text/javascript" src="heardHow.js"></script>
<!-- #include file='heardHow.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="report_form" name="report_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", "Applicants Heard About Us How")%>
<div id="mainReportBody">

  	<table id="enter_dates" class="<%=show_date_form%>">
		<tr><td id="fromdate">
	     	<label style="float:left; clear:left" for="fromDate">From Date</label>
			<input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=ApplicantSources.FromDate%>" onKeyPress="return submitenter(this,event)">
		</td><td id="todate">
			<label for="toDate" style="float:left; clear:left">To Date</label>
			<input  style="float:left; clear:left" name="toDate" id="toDate" type="text" value="<%=ApplicantSources.ToDate%>" onKeyPress="return submitenter(this,event)">
		</td>
		<td id="refreshview">
	     	<a class="squarebutton" href="#" onclick="act_refresh();"><span>Refresh View</span></a>
		</td>
		</tr>
	</table>
	<input type="hidden" value="<%=ApplicantSources.Page%>" name="Page" id="Page" />

<%=persist_simulation%>	

<%=PageNavigation%>

<%
dim LastReference      : LastReference    = 0
dim LastDepartment     : LastDepartment   = 0
dim LastSourcesId      : LastSourcesId    = 0
dim firstloop          : firstloop        = true


for each Source in ApplicantSources.Sources.Items
	noloop = false
		if firstloop then
%>		<table class="account_activity departmenttotal">
				<tr>
					<th class="">Heard How</th>
					<th class="">How Many</th>
					<th class="">Month Last Active</th>
					<th class="">Year Last Active</th>
				</tr>
<%
		firstloop = false
		end if
%>	

	
<%
		LastSourceId = Source.Id




	if row_number MOD 2	= 0 then
		row_shade = " even"
	else
		row_shade = " odd"
	end if
	
%>
	<tr class="<%=row_shade%>">
		<td id="source" class=""><span style="font-weight:normal" onclick="source.edit('<%=Source.Id%>');" id="from<%=Source.Id%>"><%=Source.HeardAboutUs%></span>
		<input style="display:none;" class="editsource" name="newsource<%=Source.Id%>" id="new<%=Source.Id%>" onBlur="source.update('<%=Source.Id%>');" onKeyUp="source.check(event, '<%=Source.Id%>');"></td>
		<td class=""><%=Source.HowOften%></td>
		<td class=""><%=Source.MonthLastActive%></td>
		<td class=""><%=Source.YearLastActive%></td>
	</tr>

<%
	row_number = row_number + 1
	LastSourceId = Source.Id

next

%>
</table>
</div>
	
<%
Set ApplciantSources = nothing

%>

</form>
<%=DecorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
