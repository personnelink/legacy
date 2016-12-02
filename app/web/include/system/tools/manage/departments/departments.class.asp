<%

Class cDepartments

private m_Departments
private m_Total
private m_CompanyId
private m_ItemsPerPage
private m_Page

Sub Class_Initialize()
    set m_Departments = Server.CreateObject ("Scripting.Dictionary")
End Sub
Sub Class_Terminate()
    set m_Departments = Nothing
End Sub

'read the current deparment
public property get Departments()
	set Departments = m_Departments
end property

public property get Total()
		Total = m_Total
end property

public property get ItemsPerPage()
	ItemsPerPage = m_ItemsPerPage
end property

public property let ItemsPerPage(p_ItemsPerPage)
	m_ItemsPerPage = p_ItemsPerPage
end property

public property get 

public property let Page(p_Page)
	m_Page = p_Page
end property


'#############  Public Functions, accessible to web pages ##############
	'load departments based on current company id
	public function LoadFromCompanyId(p_CompanyId)
		dim strSQL, MyId
		MyId = clng(p_CompanyId)
		strSQL = "" &_
			"SELECT departmentID as id, name " &_
			"FROM tbl_departments " &_
			"WHERE companyID=" & MyId
		
		LoadFromCompanyId = LoadData (strSQL)
	end function

    'Takes a recordset
    'Fills the object's properties using the recordset
    Private Function FillFromRS(p_RS)
		p_RS.PageSize = m_ItemsPerPage
		m_PageCount = p_RS.PageCount
				
		if m_Page < 1 Or m_Page > m_PageCount then
			m_Page = 1
		end if

		if not p_RS.eof then p_RS.AbsolutePage = m_Page
		
		set thisDepartment = New cDepartment
		with thisDepartment
			.id		= p_RS.fields("id").Value
			.Name	= p_RS.fields("name").Value
		end with
		m_Departments.Add thisDepartment.id, thisDepartment
		
	End Function
	
    'Takes a recordset
    'Fills the object's properties using the recordset
    private function FillFromRS(p_RS)
		dim thisAppointment
        do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
            set thisAppointment = New cAppointment
			thisAppointment.id                = p_RS.fields("Id").Value
            thisAppointment.Comment           = p_RS.fields("Comment").Value
            thisAppointment.ApplicantPhone    = p_RS.fields("TelePhone").Value
   			m_Appointments.Add thisAppointment.id, thisAppointment
			
            p_RS.movenext
        loop
    End Function

'#############  Private Functions                           ##############


	Private Function LoadData(p_strSQL)
		dim rs
		set rs = LoadRSfromDB(p_strSQL, MySql)
		FillFromRS(rs)
		LoadData = rs.recordcount
		rs. close
		set rs = nothing
	End Function


%>
