<%
public function getUserDetail()
	'on error resume next

	dim cmd
	set cmd = server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "" &_
				"SELECT tbl_users.userID, tbl_users.applicationID, CONCAT(tbl_users.firstName, "" "", tbl_users.lastName) AS ApplicantName, tbl_users.EmpCode,  " &_
				"tbl_applications.in" & tempsCode & " AS ApplicantId, tbl_applications.ssn " &_
				"FROM pplusvms.tbl_users  " &_
				"INNER JOIN pplusvms.tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
				"WHERE  tbl_applications.in" & tempsCode & "='" & applicantid & "'"

	end with
	
	
	if applicantid <> "NaN" and applicantid > 0 then 
	
	dim rs
		set rs =cmd.execute()
		
		if not rs.eof then
		
		dim photolnk, compcode
		compcode = getTempsCompCode(siteid)
		
		'print "\\personnelplus.net.\web\vms\include\system\tools\timeclock\photoid\" & compcode & "\" & applicantid & "\photo.jpg"
		
		dim fs
		set fs=Server.CreateObject("Scripting.FileSystemObject")
		if fs.FileExists("\\personnelplus.net.\web\vms\include\system\tools\timeclock\photoid\" & compcode & "\" & applicantid & "\photo.jpg") then
		  photolnk = "photoid/" & compcode & "/" & applicantid & "/photo.jpg"
		else
		  photolnk = "photoid/profile-pic-generic.jpg"
		end if
		set fs=nothing
	%>
			<img style="float:right;margin-left:0.2em;box-shadow: 10px 10px 5px #888888;" src="<%=photolnk%>">
			<div style="float:left;">
			<div style="font-size:105%; width:10em;text-align:right;padding-right:0.2em;">
			<%=rs("ApplicantName")%><span style="display:block;font-size:60%;color:white;">
			<%="***-**-" & right(rs("ssn"), 4)%><br>
			<i>Personnel Plus</i></span></div></div>
	<%
		end if
		
		rs.close
		set rs = nothing
	end if
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