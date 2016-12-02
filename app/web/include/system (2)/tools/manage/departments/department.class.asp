<%
Class cDepartment

	private m_ID
	private m_Name
	private m_Number
	private m_CompanyId

	'read the current ID value
	public property get ID()
		ID = clng(m_ID)
	end property
	
	'set a new ID value
	public property let ID(p_ID)
		m_ID = p_ID
	end property

	'read the current department name [Description]
	public property get Name()
		Name = m_Name
	end property
	'set the current department name
	public property let Name(p_Name)
		m_Name = p_Name
	end property

	'read the current department number
	public property get Number()
		Number = m_Number
	end property
	'set the current department number
	public property let Number(p_Number)
		m_Number = p_Number
	end property

	'read the current companyid
	public property get CompanyId()
		CompanyId = m_CompanyId
	end property
	'set the current companyid
	public property let CompanyId(p_CompanyId)
		m_CompanyId = p_CompanyId
	end property

end class
%>
