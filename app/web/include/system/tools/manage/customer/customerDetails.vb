<%
Class CCurrentCustomer

private m_customerNumber
private m_status
private m_entryDate
private m_availableDate
private m_lastAssigned
private m_assignedTo
public property get customerNumber()
	customerNumber = m_customerNumber
end property
public property let customerNumber(p_customerNumber)
	m_customerNumber = p_customerNumber
end property

public property get status()
	status = m_status
end property
public property let status(p_status)
	m_status = p_status
end property

public property get entryDate()
	entryDate = m_entryDate
end property
public property let entryDate(p_entryDate)
	m_entryDate = p_entryDate
end property

public property get availableDate()
	availableDate = m_availableDate
end property
public property let availableDate(p_availableDate)
	m_availableDate = p_availableDate
end property

public property get lastAssigned()
	lastAssigned = m_lastAssigned
end property
public property let lastAssigned(p_lastAssigned)
	m_lastAssigned = p_lastAssigned
end property

public property get assignedTo()
	assignedTo = m_assignedTo
end property
public property let assignedTo(p_assignedTo)
	m_assignedTo = p_assignedTo
end property



		'#############  Public Functions ##############

		public function LoadSomething()

				'LoadSomething = LoadData (strSQL)
		end function
			'#############  Private Functions ##############
		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			'p_RS.PageSize = m_ItemsPerPage
			p_RS.PageSize = 1
			dim m_PageCount
			m_PageCount = p_RS.PageCount

			dim m_Page
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page

			dim thisOrderTab, id
			if not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page ) then
				with me

					'.customerNumber       = p_RS.fields("customerNumber").value 'customerNumber
					'.status       = p_RS.fields("status").value 'status
					'.entryDate       = p_RS.fields("entryDate").value 'entryDate
					'.availableDate       = p_RS.fields("availableDate").value 'availableDate
					'.lastAssigned       = p_RS.fields("lastAssigned").value 'lastAssigned
					'.assignedTo       = p_RS.fields("assignedTo").value 'assignedTo

				end with
			end if
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			if isnumeric(me.Site) then
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))
			else
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getCompanyNumber(me.Site)))
			end if
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function



		end class
%>