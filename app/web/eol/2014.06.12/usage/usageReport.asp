<%
session("add_css") = "./usageReport.css"
session("required_user_level") = 256 'userLevelSupervisor
session("window_page_title") = "Customer Usage Report - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="usageReport.js"></script>
<!-- #include file='usageReport.doStuff.asp' -->

<!-- begin presentation stuff -->
<form id="report_form" name="report_form" action="<%=aspPageName%>" method="get">
<%=decorateTop("track_activities", "notToShort marLR10", "Usage Report")%>
<div id="mainReportBody">
	<p>
		<a style="float:right;" class="squarebutton" href="#" onclick="act_refresh('<%=thisCustomer%>');" style="margin:.25em 1em .25em"><span>Refresh View</span></a>
	</p>

  	<table id="enter_dates" class="<%=show_date_form%>">
		<tr><td>
	     	<label style="float:left; clear:left" for="fromDate">From </label>
			<input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>" onKeyPress="return submitenter(this,event)">
		</td></tr><tr><td>
			<label for="toDate" style="float:left; clear:left">To </label>
			<input  style="float:left; clear:left" name="toDate" id="toDate" type="text" value="<%=toDate%>" onKeyPress="return submitenter(this,event)">
		</td></tr>
	</table>

<%=PageNavigation%>

<%
dim strPreviousName     : strPreviousName      = ""
dim dblTotalBilled      : dblTotalBilled       = 0
dim dblTotalHours       : dblTotalHours        = 0
dim dblGrandTotalBilled : dblGrandTotalBillled = 0
dim dblGrandTotalHours  : dblGrandTotalHours   = 0

dim i : i = 0
for each UsageDetail in CustomerUsage.UsageDetail.Items 
	
	if UsageDetail.LastnameFirst <> strPreviousName then
		strPreviousName = UsageDetail.LastnameFirst
		if i > 0 then %>
		 <tr class="summary">
			<th class="lastnamefirst"></td>
			<th class="department"></th>
			<th></th>
			<th class="hours"><%="$ " & TwoDecimals(dblTotalHours)%></th>
			<th></th>
			<th class="billed"><%="$ " & TwoDecimals(dblTotalBilled)%></th>
		</tr>
	</table> <%
		end if
		dblGrandTotalBilled = dblGrandTotalBilled + dblTotalBilled
		dblGrandTotalHours = dblGrandTotalHours + dblTotalHours
		dblTotalBilled = UsageDetail.Billed
		dblTotalHours =  UsageDetail.Quantity %>
	<table class="UsageTable">
		<tr class="summary">
			<th class="lastnamefirst"><%=UsageDetail.LastnameFirst%></td>
			<th colspan="5" class="department"></th>
		</tr>
		<tr class="heading">
			<th class="costcenter"><%=UsageDetail.DepartmentId & " : " & UsageDetail.JobDescription%></th>
			<th class="invoice">Invoice #</th>
			<th class="date">Date</th>
			<th class="hours">Hours</th>
			<th class="billrate">Bill Rate</th>
			<th class="billed">Billed</th>
		</tr>
		<%
	else
		dblTotalBilled = dblTotalBilled + cdbl(UsageDetail.Billed)
		dblTotalHours = dblTotalHours + cdbl(UsageDetail.Quantity)
	end if %>
		<tr class="details">
			<td class="costcenter"><%="&nbsp;&nbsp;&nbsp;" & UsageDetail.CostCenter & " : " & UsageDetail.CCDescription%></td>
			<td class="invoice"><%=UsageDetail.Invoice%></td>
			<td class="invoicedate"><%=UsageDetail.InvoiceDate%></td>
			<td class="quantity"><%=UsageDetail.Quantity%></td>
			<td class="billrate"><%="$ " & UsageDetail.Billrate%></td>
			<td class="billed"><%="$ " & UsageDetail.Billed%></td>
		</tr> <%

	i = i + 1
next %>
	 <tr class="summary">
			<th class="lastnamefirst"></td>
			<th class="department"></th>
			<th></th>
			<th class="hours"><%=TwoDecimals(dblTotalHours)%></th>
			<th></th>
			<th class="billed"><%="$ " & TwoDecimals(dblTotalBilled)%></th>
		</tr>
	 <tr class="summary">
			<th colspan="6">&nbsp;</th>
		</tr>
	 <tr class="summary">
			<th class="lastnamefirst"></td>
			<th class="department">Grand Total</th>
			<th></th>
			<th class="hours"><%=TwoDecimals(dblGrandTotalHours + dblTotalHours)%></th>
			<th></th>
			<th class="billed"><%="$ " & TwoDecimals(dblGrandTotalBilled + dblTotalBilled)%></th>
		</tr>

	</table>
</div>
<%=DecorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
