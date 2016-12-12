<%
public function doAddDetailComment()
	
	dim placementid : placementid = getParameter("pid")
	dim summaryid   : summaryid   = getParameter("summary")
	dim detailid    : detailid    = getParameter("detailid")
	dim comment     : comment     = getParameter("comment")

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
			"INSERT INTO `time_comments` (`summaryid`, `detailid`, `comment`, `commentor`, `created`) " & _
			"VALUES (" & insert_number(summaryid) & ", " & insert_number(detailid) & ", " & insert_string(comment) & ", " & insert_number(user_id) & ", now());"
	end with
	
	cmd.execute()

	set cmd = nothing

end function



%>
