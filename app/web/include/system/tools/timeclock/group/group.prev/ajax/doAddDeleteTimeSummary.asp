<%
public function addTimeSummary()
	dim placementid
	placementid = getParameter("id")
	
	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		
		if isnumeric(g_strSite) then
			.CommandText = "" &_
				"INSERT INTO time_summary " &_
				"(placementid, site) " &_
				"VALUES " &_
				"(" & placementid & ", " & g_strSite & ")"
		else
			.CommandText = "" &_
				"INSERT INTO time_summary " &_
				"(placementid, site) " &_
				"VALUES " &_
				"(" & placementid & ", " & getSiteNumber(g_strSite) & ")"
		end if
		
		'print cmd.CommandText
		.Execute()

		' .CommandText = "" &_
			' "SELECT weekending, workday, SUM(TIME_TO_SEC(TIMEDIFF(timeout, timein))) AS totalhours " &_
			' "FROM time_summary INNER JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
			' "WHERE placementid=" & placementid & " " &_
			' "GROUP By workday ORDER By weekending desc, workday asc;"
	end with
	set cmd = nothing
	response.write placementid & ":" & g_strSite
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