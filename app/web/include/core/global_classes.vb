<%


function getApplicantIdFromUserId(p_uid, p_conn)

	dim rs, cmd

    set rs = Server.CreateObject("adodb.Recordset")
    set cmd = Server.CreateObject("adodb.Command")
    
	cmd.ActiveConnection = MySql
	cmd.CommandText = "SELECT tbl_applications.in" & getTempsCompCode(p_conn) & " FROM tbl_applications RIGHT JOIN tbl_users on tbl_users.applicationid=tbl_applications.applicationid WHERE tbl_users.userID=" & p_uid
	
	set rs = cmd.Execute()
	if not rs.eof then getApplicantIdFromUserId = rs(0) 'use ordinal number instead of name
	
	set rs = nothing
	set cmd = nothing
	
end function


class cTempsAttribute
	private m_site
	private m_table
	private m_element
	private m_newvalue
	private m_whereclause
	
	sub Class_Initialize()
	end sub
	sub Class_Terminate()
	end sub
	
	public property get site()
		site = m_site
	end property
	public property let site(p_site)
		m_site = p_site
	end property
	
	public property get table()
		table = m_table
	end property
	public property let table(p_table)
		m_table = p_table
	end property	

	public property get element()
		element = m_element
	end property
	public property let element(p_element)
		m_element = p_element
	end property
	
	public property get newvalue()
		newvalue = m_newvalue
	end property
	public property let newvalue(p_newvalue)
		m_newvalue = p_newvalue
	end property
	
	public property get whereclause()
		whereclause = m_whereclause
	end property
	public property let whereclause(p_whereclause)
		m_whereclause = p_whereclause
	end property

	'#############  public functions ##############

	public function update()
		dim strSql 
		
		if isnumeric(me.newvalue) then
			strSql = "" &_
			"UPDATE " & me.table & " " &_
			"SET " & me.element & "=" & me.newvalue & " " &_
			"WHERE " & me.whereclause & ";"
		else
			strSql = "" &_
			"UPDATE " & me.table & " " &_
			"SET " & me.element & "=" & insert_string(me.newvalue) & " " &_
			"WHERE " & me.whereclause & ";"
		end if
		
		print strSql
		
		update = doSQL(strSQL, dsnLessTemps(me.site))
	end function
	
	'#############  Private Functions ##############

end class	

class cNewActivity

	REM with cmd
		REM .ActiveConnection = dsnLessTemps(i)
		REM .CommandText = "SELECT LastnameFirst FROM Applicants WHERE ApplicantId=" & inTemps(i)
	REM end with
	REM set rsName = cmd.Execute()
	
	REM if not rsName.eof then
		REM strApplicantInterviewed = rsName("LastnameFirst")
	
		REM strWhatWasDone = "Initial Interview for " & strApplicantInterviewed & " by " &_
		REM "VMS User " & user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
	
		REM cmd.CommandText = "" &_
			REM "INSERT INTO Appointments " &_
				REM "(AppDate, ApplicantId, Comment, AssignedTo, ApptTypeCode, DispTypeCode, ContactId, Entered, EnteredBy, LocationId)" &_
				REM "VALUES (" &_
					REM "#" & Date() & "#, " & _
					REM insert_number(inTemps(i)) & ", " &_
					REM insert_string(strWhatWasDone) & ", " &_
					REM insert_string("{Anyone}") & ", " &_
					REM insert_number(ApptType) & ", " &_
					REM insert_number(DispTypeCode) & ", 0, " &_
					REM "#" & Date() & "#, " & _
					REM insert_string(tUser_id) & ", 1" &_
				REM ")"
		REM cmd.Execute()

end class

%>