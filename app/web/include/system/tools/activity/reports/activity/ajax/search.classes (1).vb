<%

class cSearchTemps
	'Private, class member variable
	private m_SearchResults
	private m_Site
	private m_FromDate
	private m_ToDate
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_SearchResults = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_SearchResults = Nothing
	End Sub

	'Read the current placements
	Public Property Get SearchResults()
		Set SearchResults = m_SearchResults
	End Property

	public property get Site()
		Site = m_Site
	end property
	public property let Site(p_Site)
		if len(p_Site) = 0 then
			p_Site = request.form("whichCompany")
			if len(p_Site) = 0 then
				p_Site = request.querystring("site")
				if len(p_Site) = 0 then
					p_Site = company_dsn_site
					if len(p_Site) = 0 then
						p_Site = session("location")
					end if
				end if
			end if
		end if
		m_Site = p_Site
	end property

	public property get FromDate()
		FromDate = m_FromDate
	end property
	public property let FromDate(p_FromDate)
		m_FromDate = p_FromDate
	end property

	public property get ToDate()
		ToDate = m_ToDate
	end property
	public property let ToDate(p_ToDate)
		m_ToDate = p_ToDate
	end property

	public property get Description()
		Description = m_Description
	end property
	public property let Description(p_Description)
		m_Description = p_Description
	end property

	public property get Code()
		Code = m_Code
	end property
	public property let Code(p_Code)
		m_Code = p_Code
	end property

	public property get SSNorEIN()
		SSNorEIN = m_SSNorEIN
	end property
	public property let SSNorEIN(p_SSNorEIN)
		m_SSNorEIN = p_SSNorEIN
	end property

	Public Property get NumberOfPages()
		NumberOfPages = m_NumberOfPages
	end property'set page size

	Public Property let NumberOfPages(p_NumberOfPages)
		m_NumberOfPages = p_NumberOfPages
	end property

	'Items Per Page
	Public Property get ItemsPerPage()
		ItemsPerPage = m_ItemsPerPage
	end property

	Public Property let ItemsPerPage(p_ItemsPerPage)
		m_ItemsPerPage = p_ItemsPerPage
	end property

	'Read the current Customers
	Public Property get PageCount()
		PageCount = m_PageCount
	End Property

	Public Property let PageCount(p_PageCount)
		m_PageCount = p_PageCount
	End Property

	'Page Number

	public property get Page()
		Page = m_Page
	end property

	public property let Page(p_Page)
		p_Page = Trim(Replace(p_Page, ",", ""))
		if len(p_Page) = 0 then
			p_Page = request.form("WhichPage")
			if len(p_Page) = 0 then
				p_Page = 1 'default
			end if
		end if
		
		select case vartype(p_Page)
		case 8 'string, convert
			if isnumeric(p_Page) then
				m_Page = cint(p_Page) 'verified number, set page
			else
				m_Page = 1 'initialize variable anyway
			end if
		case 2, 3, 4, 5
			m_Page = cint(p_Page)
		case else
			m_Page = 1
		end select

	end property

	'#############  Public Functions ##############
		
		public function SearchByCustomer(strSearch)
			dim strSql
			strSql = "" &_
				"SELECT TOP 10 Customers.Customer AS ID, Customers.SalesTaxExemptNo as Code, Customers.CustomerName as Description " &_
				"FROM Customers " &_
				"WHERE Customers.Customer Like '%" & strSearch & "%' OR Customers.SalesTaxExemptNo Like '%" & strSearch & "%' OR Customers.CustomerName Like '%" & strSearch & "%' " &_
				"ORDER By CustomerName"
			
			SearchByCustomer = LoadData (strSQL)
			
		end function

		
		public function SearchByJobOrder(strSearch)
			dim strSql
			strSql = "" &_
				"SELECT TOP 10 Orders.Reference AS ID, Orders.JobNumber as Code, Orders.JobDescription as Description " &_
				"FROM Orders " &_
				"WHERE Orders.Reference Like '%" & strSearch & "%' OR Orders.JobNumber Like '%" & strSearch & "%' OR Orders.JobDescription Like '%" & strSearch & "%' " &_
				"Order By Reference Desc; "
			
			SearchByJobOrder = LoadData (strSQL)
			
		end function

		public function SearchByEmployee(strSearch)
			dim strSql
			strSql = "" &_
				"SELECT TOP 10 Applicants.ApplicantID AS ID, Applicants.SSNumber as Code, Applicants.LastnameFirst as Description " &_
				"FROM Applicants " &_
				"WHERE Applicants.ApplicantID Like '%" & strSearch & "%' OR Applicants.SSNumber Like '%" & strSearch & "%' OR Applicants.LastnameFirst Like '%" & strSearch & "%' " &_
				"Order By ApplicantID Desc; "
			
			SearchByEmployee = LoadData (strSQL)
			
		end function
		
		
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount

			dim thisSearch, id
			do while not ( p_RS.eof )

				set thisSearch = New cSearch
				with thisSearch
					.Id             = p_RS.fields("ID").Value
					.Code           = p_RS.fields("Code").Value
					.Description    = p_RS.fields("Description").Value
				end with
				m_SearchResults.Add thisSearch.Id, thisSearch
				p_RS.movenext
			loop
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getTempsDSN(me.Site)))
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class

class cSearch

	private m_Id
	private m_Code
	private m_Description
	
	public property get Id()
		Id = m_Id
	end property
	public property let Id(p_Id)
		m_Id = p_Id
	end property

	public property get Code()
		Code = m_Code
	end property
	public property let Code(p_Code)
		m_Code = p_Code
	end property

	public property get Description()
		Description = m_Description
	end property
	public property let Description(p_Description)
		m_Description = p_Description
	end property

end class



%>
