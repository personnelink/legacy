<%

class cCustomers
	'Private, class member variable
	private m_Customers
	private m_Site
	private m_Applicant
	private m_FromDate
	private m_ToDate
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Customers = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Customers = Nothing
	End Sub

	'Read the current placements
	Public Property Get Customers()
		Set Customers = m_Customers
	End Property

	public property get Site()
		Site = m_Site
	end property
	public property let Site(p_Site)
		if len(p_Site) = 0 then
			p_Site = request.form("whichCompany")
			if len(p_Site) = 0 then
				p_Site = company_dsn_site
				if len(p_Site) = 0 then
					p_Site = session("location")
				end if
			end if
		end if
		m_Site = p_Site
	end property

	public property get Customer()
		Customer = m_Applicant
	end property
	public property let Customer(p_Customer)
		m_Applicant = Replace(p_Customer, "'", "''")
	end property

	public property get Order()
		Order = m_Order
	end property
	public property let Order(p_Order)
		if len(p_Order) = 0 then
			p_Order = request.form("whichOrder")
		end if
		m_Order = p_Order
	end property

	public property get FromDate()
		FromDate = m_FromDate
	end property
	public property let FromDate(p_FromDate)
		if isDate(p_FromDate) = false then 
			p_FromDate = request.form("fromDate") 
			if isDate(p_FromDate) = false then
				p_FromDate = CStr(Date() - 4)
			end if
		end if
		m_FromDate = p_FromDate
	end property

	public property get ToDate()
		ToDate = m_ToDate
	end property
	public property let ToDate(p_ToDate)
		if isDate(p_ToDate) = false then 
			p_ToDate = request.form("toDate") 
			if isDate(p_ToDate) = false then
				toDate = CStr(Date() + 1)
			end if
		end if
		m_ToDate = p_ToDate
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
		
		public function Search(strSearch)
			dim tempsCode
				tempsCode = getTempsCompCode(me.Site)
				
			dim strSql
			strSql = "" &_
				"SELECT TOP 15 Customers.Customer, Customers.CustomerName, Customers.Phone, " &_
				"Customers.Fax, Customers.EmailAddress " &_
				"FROM Customers " &_
				"WHERE Customer like ""%" & strSearch & "%"" OR " &_
				"CustomerName like ""%" & strSearch & "%"" OR " &_
				"Phone like ""%" & strSearch & "%"" OR " &_
				"Fax like ""%" & strSearch & "%"" OR " &_
				"EmailAddress like ""%" & strSearch & "%"" "&_
				"ORDER BY Customers.Customer, Customers.CustomerName, " &_
				"Customers.DateLastActive DESC , Customers.CustSetupDate DESC; "

			Search = LoadData (strSQL)
		end function
		
		
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
	
			dim thisCustomer, id
			do while not ( p_RS.eof  )
				id = id + 1
				set thisCustomer = New cCustomer
				with thisCustomer
					.Id             = id
					.Site           = Me.Site
					.CustomerCode   = p_RS.fields("Customer").Value
					'.BusinessId            = p_RS.fields("ssn").Value
					.CustomerName    = p_RS.fields("CustomerName").Value
					.Phone          = p_RS.fields("Phone").Value
					.Fax    = p_RS.fields("Fax").Value
					.EmailAddress   = p_RS.fields("EmailAddress").Value
				end with
				m_Customers.Add thisCustomer.Id, thisCustomer
				p_RS.movenext
			loop
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			if isnumeric(me.Site) then 'check if site number or site code
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))
			else
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getTempsDSNbyCode(me.Site)))
			end if
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class

class cCustomer
	private m_Id
	private m_Site
	private m_CustomerCode
	private m_BusinessId 'SSN or EIN
	private m_CustomerName
	private m_Phone
	private m_Fax
	private m_EmailAddress


	public property get Id()
		Id = m_Id
	end property
	public property let Id(p_Id)
		m_Id = p_Id
	end property

	public property get Site ()
		Site = m_Site
	end property
	public property let Site(p_Site)
		m_Site = p_Site
	end property

	public property get CustomerCode ()
		CustomerCode = m_CustomerCode
	end property
	public property let CustomerCode(p_CustomerCode)
		m_CustomerCode = p_CustomerCode
	end property

	public property get Fax()
		Fax = m_Fax
	end property
	public property let Fax(p_Fax)
		m_Fax = p_Fax
	end property

	public property get BusinessId() 'JobNumber
		BusinessId = m_BusinessId
	end property

	public property let BusinessId(p_BusinessId)
		m_BusinessId = p_BusinessId
	end property

	public property get CustomerName()
		CustomerName = m_CustomerName
	end property

	public property let CustomerName(p_CustomerName)
		m_CustomerName = p_CustomerName
	end property

	public property get Phone()
		Phone = m_Phone
	end property
	public property let Phone(p_Phone)
		m_Phone = p_Phone
	end property
	
	public property get EmailAddress()
		EmailAddress = m_EmailAddress
	end property
	public property let EmailAddress(p_EmailAddress)
		m_EmailAddress = p_EmailAddress
	end property
	
	public property get EmailFormat()
		EmailFormat = m_EmailFormat
	end property
	public property let EmailFormat(p_EmailFormat)
		m_EmailFormat = p_EmailFormat
	end property

end class

%>
