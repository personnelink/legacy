<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%

if Request.QueryString("mode") = "simulation" then
	response.write "<style type=" & Chr(34) & "text/css" & Chr(34) & ">"
	Response.write "table tr th { padding:.8em 0 .3em; }"
	response.write "table { width:90%; margin-bottom:1.4em; }"
	response.write ".alignL {text-align:left; }"
	Response.write "</style>"
end if

dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

Select Case Replace(Trim(Request.QueryString("companyid")), "'", "")
Case "PER"
	thisConnection = dsnLessTemps(PER)
Case "BUR"
	thisConnection = dsnLessTemps(BUR)
Case "BOI"
	thisConnection = dsnLessTemps(BOI)
Case Else
	Response.End()
End Select
JobNumber = Replace(Trim(Request.QueryString("orderid")), "'", "")

Set getJobData_cmd = Server.CreateObject ("ADODB.Command")
With getJobData_cmd
	.ActiveConnection = thisConnection
	.CommandText = "SELECT Orders.Customer, Orders.JobStatus, Orders.StartDate, Orders.StopDate, Orders.OrderDate, " &_
		"Orders.JobNumber, Orders.OTPay, Orders.JobDescription, Orders.WorkSite1, Orders.WorkSite2, Orders.WorkSite3, Orders.JobSupervisor, " &_
		"Orders.TimeFromHere, Orders.StartTime, Orders.StopTime, Orders.OrderTakenBy, Orders.Memo, Orders.RecordedBy, Orders.Dispatcher, " &_
		"Orders.NextDispatchDate, Orders.Reference, Orders.JobChangedBy, Orders.JobChangedDate, Orders.SuspendService, Orders.EmailAddress, " &_
		"Orders.RegTimePay, Orders.ReportTo, Orders.DirectionsParking, Orders.ContactId, Customers.CustomerName, Customers.Contact, Customers.Phone, " &_
		"Customers.Address, Customers.Cityline " &_
		"FROM Customers INNER JOIN Orders ON Customers.Customer = Orders.Customer " &_
		"WHERE JobNumber=" & JobNumber & ";"
	.Prepared = true
End With
Set getJobData = getJobData_cmd.Execute	
if Not getJobData.eof then 
%>
<table>
  <tr>
    <th class="alignL">Order ID</th>
    <th>Reference ID</th>
    <th>Order Status</th>
    <th>Service Status</th>
    <th>Order Date</th>
    <th>Travel Time</th>
  </tr>
  <tr>
    <td><%=getJobData("JobNumber")%></td>
    <td><%=getJobData("Reference")%></td>
    <td><%=getJobData("JobStatus")%></td>
    <td><%=getJobData("SuspendService")%></td>
    <td><%=getJobData("OrderDate")%></td>
    <td><%=getJobData("TimeFromHere")%></td>
  </tr>
  <tr>
    <th class="alignL">Taken By</th>
    <th>Recorded By</th>
    <th>Dispatcher</th>
    <th>Next Dispatch Date</th>
    <th>Start Date</th>
    <th>Start Time</th>
  </tr>
  <tr>
    <td><%=getJobData("OrderTakenBy")%></td>
    <td><%=getJobData("RecordedBy")%></td>
    <td><%=getJobData("Dispatcher")%></td>
    <td><%=getJobData("NextDispatchDate")%></td>
    <td><%=getJobData("StartDate")%></td>
    <td><%=getJobData("StartTime")%></td>
  </tr>
  <tr>
    <th class="alignL">Company Contact</th>
    <th>Contact Phone</th>
    <th>Changed By</th>
    <th>Date Changed</th>
    <th>Stop Date</th>
    <th>Stop Time</th>
  </tr>
  <tr>
    <td><%=getJobData("Contact")%></td>
    <td><%=FormatPhone(getJobData("Phone"))%></td>
    <td><%=getJobData("JobChangedBy")%></td>
    <td><%=getJobData("JobChangedDate")%></td>
    <td><%=getJobData("StopDate")%></td>
    <td><%=getJobData("StopTime")%></td>
  </tr>
  <tr>
    <th colspan="2" class="alignL">Company Infoformation</th>
    <th>Report To</th>
    <th colspan="3">Work Location</th>
  </tr>
  <tr>
    <td><%=getJobData("Customer")%></td>
    <td><%=getJobData("CustomerName")%></td>
    <td><%=getJobData("JobSupervisor")%></td>
    <td colspan="3"><%=getJobData("WorkSite1") & ", " & getJobData("WorkSite2") & ", " & getJobData("WorkSite3")%></td>
  </tr>
  <tr>
    <td colspan="2"><%=getJobData("Address") & ", " & getJobData("Cityline")%></td>
    <td colspan="4"><%=getJobData("EmailAddress")%></td>
  </tr>
  <tr>
    <th class="alignL">Regular Pay</th>
    <th>Overtime Pay</th>
    <th colspan="4">Notes</th>
  </tr>
  <tr>
    <td><%=getJobData("RegTimePay")%></td>
    <td><%=getJobData("OTPay")%></td>
    <td colspan="4"><%=getJobData("Memo")%></td>
  </tr>
  <tr>
    <th colspan="2" class="alignL">Job Description</th>
    <th colspan="4">Directions/Parking</th>
  </tr>
  <tr>
    <td colspan="2"><%=getJobData("JobDescription")%></td>
    <td colspan="4"><%=getJobData("DirectionsParking")%></td>
  </tr>
</table>
<img src="/include/system/tools/timecards/images/placementDetail.png" />
<%	
end if
Set getJobData = Nothing
Set getJobData_cmd = Nothing
%>
