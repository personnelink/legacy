<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
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

PlacementID = Replace(Trim(Request.QueryString("placementid")), "'", "")

Set getPlacementData_cmd = Server.CreateObject ("ADODB.Command")
With getPlacementData_cmd
	.ActiveConnection = thisConnection
	.CommandText = "SELECT Customers.CustomerName, Placements.Customer, Placements.PlacedBy, WorkCodes.Description, " &_
		"Placements.WorkCode, Placements.PlacementStatus, Placements.EmployeeNumber, Placements.PStopDate, Placements.StartDate, " &_
		"Placements.RegPayRate, Placements.OvertimePayRate, Customers.Address, Customers.Cityline FROM (WorkCodes INNER JOIN " &_
		"Placements ON WorkCodes.WorkCode = Placements.WorkCode) INNER JOIN Customers ON Placements.Customer = Customers.Customer " &_
		"WHERE (((Placements.PlacementID)=" & PlacementID & "));"
	.Prepared = true
End With
Set PlacementData = getPlacementData_cmd.Execute	
if Not PlacementData.eof then

Select Case PlacementData("PlacementStatus")
Case 0
	StatusForShow = "Active"
Case 3
	StatusForShow = "Closed"
Case Else
	StatusForShow = "unknown"
End Select
	
if Request.QueryString("mode") = "simulation" then
	response.write "<style type=" & Chr(34) & "text/css" & Chr(34) & ">"
	Response.write "table tr th { padding:.8em 0 .3em; }"
	response.write "table { width:60em; float:right; margin-bottom:1.4em; }"
	response.write ".alignL {text-align:left; }"
	Response.write "</style>"
end if

 %>
 
 
<table>
  <tr>
    <th class="alignL">Job ID</th>
    <th>Employee ID</th>
    <th>Status</th>
    <th>Placed By</th>
    <th>Date Started</th>
    <th>Stop Date</th>
  </tr>
  <tr>
    <td><%=PlacementID%></td>
    <td><%=PlacementData("EmployeeNumber")%></td>
    <td><%=StatusForShow%></td>
    <td><%=PlacementData("PlacedBy")%></td>
    <td><%=PlacementData("StartDate")%></td>
    <td><%=PlacementData("PStopDate")%></td>
  </tr>
  <tr>
    <th colspan="3" class="alignL">Company Information</th>
    <th colspan="3" class="alignL">Company Address</th>
  </tr>
  <tr>
    <td><%=PlacementData("Customer")%></td>
    <td colspan="2"><%=PlacementData("CustomerName")%></td>
    <td colspan="3"><%=PlacementData("Cityline") & ", " & PlacementData("Address")%></td>
  </tr>
  <tr>
    <th colspan="2" class="alignL">Workmen's Compensation Detail</th>
    <th colspan="4" class='alignL'>Wage Information</th>
  </tr>
  <tr>
    <td><%=PlacementData("WorkCode")%></td>
    <td><%=PlacementData("Description")%></td>
    <th style="padding:0">Regular</th>
    <td>$<%=TwoDecimals(PlacementData("RegPayRate"))%></td>
    <th style="padding:0">Overtime</th>
    <td>$<%=TwoDecimals(PlacementData("OvertimePayRate"))%></td>
  </tr>
</table>
<img src="/include/system/tools/timecards/images/placementDetail.png" />
<%
	
end if
Set PlacementData = Nothing
Set getPlacementData_cmd = Nothing

%>
