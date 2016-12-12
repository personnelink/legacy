<%
public function doGetCostCenters()
	
	on error resume next
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		if isnumeric(siteid) then
			.ActiveConnection = dsnLessTemps(cint(siteid))
		else
			.ActiveConnection = dsnLessTemps(getTempsDSN(siteid))
		end if

		.CommandText = "" &_
				"SELECT Applicants.ApplicantID, Placements.PlacementID, Orders.Customer, Orders.Reference, Placements.CurrentReviewScore, " &_
				"Placements.AverageReviewScore, Placements.EmployeeNumber, Placements.WorkCode, WorkCodes.Description, " &_
				"Orders.JobNumber, Orders.JobDescription " &_
				"FROM WorkCodes RIGHT JOIN " &_
				"(Orders RIGHT JOIN (Applicants LEFT JOIN Placements ON Applicants.ApplicantID = Placements.ApplicantId) " &_
				"ON Orders.Reference = Placements.Reference) ON WorkCodes.WorkCode = Placements.WorkCode " &_
				"WHERE (Applicants.ApplicantID=" & applicantid & " AND Orders.Customer='" & customerid &"') AND PlacementStatus = 0;"
		.Prepared = true
	end with
	
	'print cmd.CommandText
	dim rs
	set rs =cmd.execute()
	if err.Number = 0 then 

%>
<table style="width:25em;">
		<tr><td colspan="2"><span style="color:white; font-weight:bold;border-bottom:1px solid #8da0d9;">Optional: Alternate Departments or Cost Centers</span></td></tr></table>
<%	
	dim costCenterPid
	if not rs.eof then
		dim firstPlacementId
			firstPlacementId = rs("PlacementID")
		do until rs.eof
			costCenterPid = rs("PlacementID")
			%>
			<div class="cost_center_button">
					<span class="cost_center" onclick="cost_centers.get_actions('<%=costCenterPid%>', '<%=applicantid%>', '<%=siteid%>', '<%=customerid%>')" style="vertical-align:middle;padding:1.2em 0;color:white;display:block;height:2.4em;font-weight:normal;font-family:arial;">
					<%=rs("Reference")%>:<%=rs("PlacementID")%>&nbsp;&nbsp;<%=rs("JobDescription")%>&nbsp;/&nbsp;<%=rs("Description")%>
					</span>
			</div><%
			
			rs.movenext
		loop
		
		
		response.write "<!-- first placement id=[" & firstPlacementId & "] -->"
	end if
	
	else %>
	
		<div style="border:1px solid #65539f;background-color:#65539f;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em">
			<table style="width:25em;">
			<tr><td colspan="2"></td></tr>
			<tr>
				<td colspan="2"><span style="color:white; font-weight:bold;">Error #<%=err.Number%>: Card swipe processing error <br><br></span></td>
			</tr>
			<tr><td colspan="2"></td></tr>
			<tr><td colspan="2"></td></tr>
			</table>
		</div><%

	end if


	rs. close
	set rs = nothing
	set cmd = nothing
		

end function

public function removeTimeSummary()
	dim placementid
	placementid = getParameter("id")
	
	dim siteid
	siteid = getTempsDSN(g_strSite)
	
	dim summaryid
	summaryid = getParameter("summary")
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"DELETE FROM time_summary " &_
			"WHERE (placementid=" & placementid & ") AND (site=" & siteid & ") AND (id=" & summaryid & ")"
			
		.Execute()
	end with

	with cmd
		.CommandText = "" &_
			"DELETE FROM time_detail " &_
			"WHERE (summaryid=" & summaryid & ")"
		.Execute()
	end with

	set cmd = nothing
	response.write placementid & ":" & g_strSite
end function



%>