<%
public function doSyncPlacements()

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
				"SELECT id, placementid, site FROM pplusvms.time_summary_archive WHERE placementid IS NOT NULL and site=" & getTempsSiteId(g_strSite) & " order by id desc;"
	end with
	
	
	dim rs_summaries
	set rs_summaries =cmd.execute()
	
	dim this_placementid
	
	do while not rs_summaries.eof
		this_placementid = rs_summaries("placementid")

		cmd.ActiveConnection = dsnLessTemps(g_strSite)	
		cmd.CommandText = "" &_
			"SELECT Orders.Customer, Orders.JobNumber, Orders.Reference, Orders.JobDescription, Placements.EmployeeNumber, " &_
			"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.OvertimePayRate, Placements.OvertimeBillRate, WorkCodes.Description " &_
			"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
			"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
			"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
			"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
			"WHERE Placements.PlacementID=" & this_placementid

		dim rs
		set rs = cmd.Execute()

		if not rs.eof then

			cmd.ActiveConnection = MySql
			cmd.CommandText = "" &_
				"UPDATE time_summary_archive " &_
				"SET workcode=" & insert_string(rs("WorkCode")) & ", " &_
				"wc_description=" & insert_string(rs("Description")) & ", " &_
				"employeenumber=" & insert_string(rs("EmployeeNumber")) & ", " &_
				"department=" & insert_number(rs("JobNumber")) & ", " &_
				"costcenter=" & insert_number(rs("Reference")) & ", " &_
				"cc_description=" & insert_string(rs("JobDescription")) & ", " &_
				"regpay=" & insert_string(rs("RegPayRate")) & ", " &_
				"regbill=" & insert_string(rs("RegBillRate")) & ", " &_
				"otpay=" & insert_string(rs("OvertimePayRate")) & ", " &_
				"otbill=" & insert_string(rs("OvertimeBillRate")) & " " &_
				"WHERE placementid=" & this_placementid
					
			print "pid: " & this_placementid & ", " & cmd.CommandText
			response.flush()
			
			cmd.execute
		end if

		rs_summaries.movenext
	loop
		
	rs_summaries.close

	set rs = nothing
	set rs_summaries = nothing
	set cmd = nothing
		

end function

%>