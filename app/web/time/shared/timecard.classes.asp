<%

' class cCustomers
' class cCustomer
' class cOrders
' class cOrder 
' class cPlacements
' class cPlacement
' class cTimeSummary
' class cTimeDetail

class cCustomers
	'Private, class member variable
	private m_Customers
	private m_Site
	private m_Status
	private m_Customer
	private m_FromDate
	private m_ToDate
	private m_ReportWhen
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page
	private m_Department
    
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
				p_Site = request.querystring("whichCompany")
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

	public property get Status()
		if isnull(m_Status) then
			m_Status = 0	
		end if
		Status = m_Status
	end property
	public property let Status(p_Status)
		if len(p_Status) = 0 then
			p_Status = request.form("whichCompany")
			if len(p_Status) = 0 then
				p_Status = request.querystring("whichCompany")
				if len(p_Status) = 0 then
					p_Status = company_dsn_site
					if len(p_Status) = 0 then
						p_Status = session("location")
					end if
				end if
			end if
		end if
		m_Status = p_Status
	end property

	public property get Customer()
		Customer = m_Customer
	end property
	public property let Customer(p_Customer)
		if len(p_Customer) = 0 then
			if userLevelRequired(userLevelPPlusStaff) then
				p_Customer = "@ALL" 'default
			else
				p_Customer = g_company_custcode.CustomerCode
			end if
		end if
		m_Customer = Replace(p_Customer, "'", "''")
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
		
		public function GetCustomers()
			dim strSelectCriteria
			if me.Customer = "@ALL" AND userLevelRequired(userLevelPPlusStaff) then
				strSelectCriteria = "WHERE (Customers.CustomerType <> 'P' AND Customers.CustomerType <> 'I' AND Customers.CustomerType <> 'X' AND ETimeCardStyle <> 86)"
			elseif len(me.Customer) > 0 then
				strSelectCriteria = "WHERE (Customers.Customer='" & me.Customer & "') AND (Customers.CustomerType <> 'P' AND Customers.CustomerType <> 'I' AND Customers.CustomerType <> 'X')"
			end if

			
			strSelectCriteria = strSelectCriteria &_
				" AND (((Orders.Reference) Is Not Null) AND ((Orders.JobStatus)<>2 And (Orders.JobStatus)<>4))"

			
			
'SELECT DISTINCT Customers.Customer AS CustomerCode, Customers.CustomerName, Customers.Address, Customers.Cityline, Customers.Contact, Customers.Phone, Customers.DateLastActive
'FROM Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) AND (Customers.Customer = Orders.Customer)
'WHERE (((Customers.CustomerType)<>'P' And (Customers.CustomerType)<>'I' And (Customers.CustomerType)<>'X') AND ((Orders.Reference) Is Not Null) AND ((Orders.JobStatus)<>2 And (Orders.JobStatus)<>4));


			
			dim strSql
			strSql = "" &_
				"SELECT DISTINCT Customers.Customer AS CustomerCode, Customers.CustomerName, " &_
				"Customers.Address, Customers.Cityline, Customers.Contact, Customers.Phone, " &_
				"Customers.DateLastActive " &_
				"FROM Customers " &_
				"INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
				"AND (Customers.Customer = Orders.Customer) " &_
				strSelectCriteria & ";"
			
			'print strSelectCriteria
			'print strSql
			
			GetCustomers = LoadData (strSQL)
			
		end function
		
		
		public function GetApplicantCustomers()
		
		'retrieve applicant id
		'
		dim cmd
		set cmd = server.CreateObject("ADODB.Command")
		
		with cmd
			.ActiveConnection = MySql
			.CommandText = "" &_
				"SELECT tbl_applications.in" & getTempsCompCode(company_dsn_site) & ", " &_
					"tbl_users.userName, tbl_users.userEmail, tbl_users.userAlternateEmail " &_
				"FROM tbl_users " &_
					"RIGHT JOIN tbl_applications ON tbl_users.applicationID=tbl_applications.applicationID " &_
				"WHERE tbl_users.userID='" & user_id & "';"
		end with
		dim rs
		set rs = cmd.Execute()
		
		dim applicantid
		applicantid = rs(0)
		
		set rs = nothing
		set cmd = nothing
		
		dim strSelectCriteria
			strSelectCriteria = "WHERE (Placements.ApplicantId='" & applicantid & "') AND (Customers.CustomerType <> 'P' AND Customers.CustomerType <> 'I' AND Customers.CustomerType <> 'X')"
			
			
			REM strSelectCriteria = strSelectCriteria &_
				REM " AND (((Orders.Reference) Is Not Null) AND ((Orders.JobStatus)<>2 And (Orders.JobStatus)<>4))"
						
			'SELECT DISTINCT Customers.Customer AS CustomerCode, Customers.CustomerName, Customers.Address, Customers.Cityline, Customers.Contact, Customers.Phone, Customers.DateLastActive
			'FROM Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) AND (Customers.Customer = Orders.Customer)
			'WHERE (((Customers.CustomerType)<>'P' And (Customers.CustomerType)<>'I' And (Customers.CustomerType)<>'X') AND ((Orders.Reference) Is Not Null) AND ((Orders.JobStatus)<>2 And (Orders.JobStatus)<>4));


						
			dim strSql
			strSql = "" &_
				"SELECT DISTINCT Customers.Customer AS CustomerCode, Customers.CustomerName, " &_
				"Customers.Address, Customers.Cityline, Customers.Contact, Customers.Phone, " &_
				"Customers.DateLastActive " &_
				"FROM Customers " &_
				"INNER JOIN Orders ON (Customers.Customer = Orders.Customer) " &_
				"LEFT JOIN Placements ON (Placements.Customer = Orders.Customer) " &_
				"AND (Customers.Customer = Orders.Customer) " &_
				strSelectCriteria & ";"
			
			'print strSelectCriteria
			'print strSql
			
			GetApplicantCustomers = LoadData (strSQL)
		end function
	
		public function PageSelection()
			const StartSlide = 32 ' when to start sliding
			const StopSlide = 112 'when to stop sliding and show the smallests amount
			const SlideRange = 8 'the most pages to show minus this = smallest number to show aka the slide
			const TopPages = 25 'the most records to show
			
			dim maxPages, slidePages
			
			dim tmpPage : tmpPage = request.QueryString("WhichPage")
			if isnumeric(tmpPage) then
				m_Page = cint(tmpPage)
			else
				m_Page = 0
			end if
			
			if m_Page <= StartSlide then
				maxPages = TopPages
			elseif m_Page > StartSlide and m_Page < StopSlide then
				maxPages = TopPages - (SlideRange - Cint(SlideRange * ((StopSlide - m_Page)/(StopSlide - StartSlide))))
			else
				maxPages = TopPages - SlideRange
			end if
			slidePages = cint((maxPages/2)+0.5)
			
			'check if we need to slide page navigation "window"
			if global_debug then
				output_debug("* navRecordsByPage(): nPageCount: " & m_PageCount & " *")
				output_debug("* navRecordsByPage(): nPage: " & m_Page & " *")
			end if
			
			dim startPage, stopPage
			if m_PageCount > maxPages then
				startPage = m_Page - slidePages
				stopPage = m_Page + slidePages
				
				'check if startPages is less than 1
				if startPage < 1 then
					startPage = 1
					stopPage = maxPages
				end if
				'check if stopPages is greater than total pages
				if stopPage > m_PageCount then
					stopPage = m_PageCount
					startPage = m_PageCount - slidePages
				end if
			else
				startPage = 1
				stopPage = m_PageCount
			end if

			rsQuery = request.serverVariables("QUERY_STRING")

			queryPageNumber = whichPage
			if queryPageNumber then
				rsQuery = Replace(rsQuery, "WhichPage=" & queryPageNumber & "&", "")
				rsQuery = Replace(rsQuery, "WhichPage=" & queryPageNumber, "")
				rsQuery = Replace(rsQuery, "WhichPage=", "")
			end if

			dim holdNavRecords : holdNavRecords = ""
			
			holdNavRecords = "<div id=""topPageRecords"" class=""navPageRecords"">" &_
					"<input name=""WhichPage"" id=""WhichPage"" type=""hidden"" value="""" />"

			if stopPage > startPage then
				holdNavRecords = holdNavRecords &_
				"<A HREF=""#"" onclick=""refreshPage('1');"">First</A>"

				For i = startPage to stopPage
				
					holdNavRecords = holdNavRecords &_
						"<A HREF=""#"" onclick=""refreshPage('" & i & "');"">&nbsp;"
					if i = m_Page then
						holdNavRecords = holdNavRecords &_
							"<span style=""color:red"">" & i & "</span>"
					Else
						if (i = stopPage and i < m_PageCount) or (i = startPage and i > 1) then
							holdNavRecords = holdNavRecords & "..."
						else
							holdNavRecords = holdNavRecords & i
						end if
					end if
						holdNavRecords = holdNavRecords &_
							"&nbsp;</A>"
				Next
				holdNavRecords = holdNavRecords &_
					"<A HREF=""#"" onclick=""refreshPage('" & m_PageCount & "');"">Last</A>"
			end if
			holdNavRecords = holdNavRecords & "</div>"
			
			if len(holdNavRecords) > 0 then PageSelection = holdNavRecords

		end function
		
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
			
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisCustomer
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				set thisCustomer = New cCustomer
				with thisCustomer
					.CustomerCode   = p_RS.fields("CustomerCode").Value
					.CustomerName   = p_RS.fields("CustomerName").Value
					.Address        = p_RS.fields("Address").Value
					.Cityline       = p_RS.fields("Cityline").Value
					.Contact        = p_RS.fields("Contact").Value
					.Phone          = p_RS.fields("Phone").Value
					.DateLastActive = p_RS.fields("DateLastActive").Value
				end with
				m_Customers.Add thisCustomer.CustomerCode, thisCustomer
				
				p_RS.movenext
			loop
		End Function

		Private Function LoadData(p_strSQL)
		
			dim rs
			
			if isnumeric(me.Site) then
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))
			else
				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getSiteNumber(me.Site)))
			end if
				
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class

class cCustomer
	private m_CustomerCode
	private m_Department
	private m_CustomerName
	private m_Address
	private m_Cityline
	private m_Contact
	private m_Phone
	private m_DateLastActive

	public sub Class_Initialize

	end sub

	public property get CustomerCode ()
		CustomerCode = m_CustomerCode
	end property

	public property let CustomerCode(p_CustomerCode)
		m_CustomerCode = p_CustomerCode
	end property

	public property get CustomerName()
		CustomerName = m_CustomerName
	end property

	public property let CustomerName(p_CustomerName)
		m_CustomerName = p_CustomerName
	end property

	public property get Address()
		Address = m_Address
	end property

	public property let Address(p_Address)
		m_Address = p_Address
	end property

	public property get Cityline()
		Cityline = m_Cityline
	end property
	public property let Cityline(p_Cityline)
		m_Cityline = p_Cityline
	end property

	public property get Contact()
		Contact = m_Contact
	end property
	public property let Contact(p_Contact)
		m_Contact = p_Contact
	end property

	public property get Phone()
		Phone = m_Phone
	end property

	public property let Phone(p_Phone)
		m_Phone = p_Phone
	end property

	public property get DateLastActive()
		DateLastActive = m_DateLastActive
	end property
	public property let DateLastActive(p_DateLastActive)
		m_DateLastActive = p_DateLastActive
	end property

end class 

class cOrders
	'Private, class member variable
	private m_Orders
	private m_Site
	private m_Customer
	private m_Department
	private m_FromDate
	private m_ToDate
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Orders = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Orders = Nothing
	End Sub

	'Read the current placements
	Public Property Get Orders()
		Set Orders = m_Orders
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
		Customer = m_Customer
	end property
	public property let Customer(p_Customer)
		m_Customer = Replace(p_Customer, "'", "''")
	end property
	
	public property get Department()
		Department = m_Department
	end property
	public property let Department(p_Department)
		m_Department = p_Department
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

	public property get Applicant()
		Applicant = m_Applicant
	end property
	public property let Applicant(p_Applicant)
		if len(p_Applicant) = 0 then
			p_Applicant = request.form("whichApplicant")
		end if
		m_Applicant = p_Applicant
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
		
		public function GetOpenOrders()
			
			dim strDepartmentClause
			if len(m_Department) = 0 then
				'no department restrictions
				strDepartmentClause = ""
			elseif instr(m_Department, ",") > 0 then
				'User is associated with multiple departments. Split them up and build appropriate ad-hoc SQL statement.
				strDepartmentClause = " AND (Orders.JobNumber=" & replace(replace(m_Department, " ", ""), ",", " OR Orders.JobNumber=") & ")"
			else
				'User is associated with a single department
				strDepartmentClause = "AND (Orders.JobNumber=" & m_Department & ")"
			end if
		
			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.JobStatus, Orders.JobNumber AS CustomerDept, Orders.Reference, " &_
				"Orders.JobDescription, Orders.WorkSite1+', '+Orders.WorkSite2 AS WorkSite, Orders.WorkSite3 AS " &_
				"WorkSitePhone, Orders.OrderDate, Orders.StartDate, Orders.StopDate, Orders.EmailAddress, Orders.EmailFormat " &_
				"FROM Orders " &_
				"WHERE (Orders.Customer='" & me.Customer & "') AND (Orders.JobStatus<2 OR Orders.JobStatus = 3)" & strDepartmentClause & ";"
				
			GetOpenOrders = LoadData (strSQL)
		end function
		
		public function GetClosedOrders()

			dim strDepartmentClause
			if len(m_Department) = 0 then
				'no department restrictions
				strDepartmentClause = ""
			elseif instr(m_Department, ",") > 0 then
				'User is associated with multiple departments. Split them up and build appropriate ad-hoc SQL statement.
				strDepartmentClause = " AND (Orders.JobNumber=" & replace(replace(m_Department, " ", ""), ",", " OR Orders.JobNumber=") & ")"
			else
				'User is associated with a single department
				strDepartmentClause = "AND (Orders.JobNumber=" & m_Department & ")"
			end if

			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.JobStatus, Orders.JobNumber AS CustomerDept, Orders.Reference, " &_
				"Orders.JobDescription, Orders.WorkSite1+', '+Orders.WorkSite2 AS WorkSite, Orders.WorkSite3 AS " &_
				"WorkSitePhone, Orders.OrderDate, Orders.StartDate, Orders.StopDate, Orders.EmailAddress, Orders.EmailFormat " &_
				"FROM Orders " &_
				"WHERE (Orders.Customer='" & me.Customer & "') AND (Orders.JobStatus=2 OR Orders.JobStatus = 4)" & strDepartmentClause & ";"
	
			GetClosedOrders = LoadData (strSQL)
		end function

		
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
			
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisOrder
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				set thisOrder = New cOrder
				with thisOrder
					.Site           = Me.Site
					.CustomerCode   = p_RS.fields("Customer").Value 'Customer
					.JobStatus      = p_RS.fields("JobStatus").Value
					.CustomerDept   = p_RS.fields("CustomerDept").Value
					.Reference      = p_RS.fields("Reference").Value
					.JobDescription = p_RS.fields("JobDescription").Value
					.WorkSite       = p_RS.fields("WorkSite").Value
					.WorkSitePhone  = p_RS.fields("WorkSitePhone").Value
					.OrderDate      = p_RS.fields("OrderDate").Value
					.StartDate      = p_RS.fields("StartDate").Value
					.StopDate       = p_RS.fields("StopDate").Value
					.EmailAddress   = p_RS.fields("EmailAddress").Value
					.EmailFormat    = p_RS.fields("EmailFormat").Value
				end with
				m_Orders.Add thisOrder.Reference, thisOrder
				p_RS.movenext
			loop
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

class cOrder
	private m_Site
	private m_CustomerCode
	private m_JobStatus
	private m_CustomerDept 'm_JobNumber
	private m_Reference
	private m_JobDescription
	private m_WorkSite
	private m_WorkSitePhone
	private m_OrderDate
	private m_StartDate
	private m_StopDate
	private m_EmailAddress
	private m_EmailFormat

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

	public property get JobStatus()
		JobStatus = m_JobStatus
	end property
	public property let JobStatus(p_JobStatus)
		m_JobStatus = p_JobStatus
	end property

	public property get CustomerDept() 'JobNumber
		CustomerDept = m_CustomerDept
	end property

	public property let CustomerDept(p_CustomerDept)
		m_CustomerDept = p_CustomerDept
	end property

	public property get Reference()
		Reference = m_Reference
	end property

	public property let Reference(p_Reference)
		m_Reference = p_Reference
	end property

	public property get JobDescription()
		JobDescription = m_JobDescription
	end property

	public property let JobDescription(p_JobDescription)
		m_JobDescription = p_JobDescription
	end property

	public property get WorkSite()
		WorkSite = m_WorkSite
	end property
	public property let WorkSite(p_WorkSite)
		m_WorkSite = p_WorkSite
	end property
	
	public property get WorkSitePhone()
		WorkSitePhone = m_WorkSitePhone
	end property
	public property let WorkSitePhone(p_WorkSitePhone)
		m_WorkSitePhone = p_WorkSitePhone
	end property
	
	public property get OrderDate()
		OrderDate = m_OrderDate
	end property

	public property let OrderDate(p_OrderDate)
		m_OrderDate = p_OrderDate
	end property

	public property get StartDate()
		StartDate = m_StartDate
	end property

	public property let StartDate(p_StartDate)
		m_StartDate = p_StartDate
	end property

	public property get StopDate()
		StopDate = m_StopDate
	end property
	public property let StopDate(p_StopDate)
		m_StopDate = p_StopDate
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

	public property get HasTimeOrExpense()
		if (m_TotalExpenses > 0) or (m_TotalTime > 0) then
			HasTimeOrExpense = true
		else
			HasTimeOrExpense = false
		end if
	end property
	
	public property get ExpenseSummary
		'need placement id and company site
		dim placementId
		dim company
		if m_TotalExpenses > 0 then
			ExpenseSummary = SummaryObj("Expense", "Expecting", me.PlacementId, company, m_TotalExpenses)
		else
			ExpenseSummary = SummaryObj("Expense", "Grey", me.PlacementId, company, 0)
		end if
	
	end property

	public property get TimeSummary
		'need placement id and company site
		dim placementId
		dim company
		if m_TotalTime > 0 then
			TimeSummary = SummaryObj("Time", "Expecting", me.PlacementId, company, m_TotalTime)
		else
			TimeSummary = SummaryObj("Time", "Grey", me.PlacementId, company, 0)
		end if
	
	end property
	
	private function SummaryObj(summarytype, style, placementid, companysite, total)
		' summarytype - 'Expense'
		'             - 'Time'
		'
		' style       - 'Expecting'
		'             - 'Grey'
		
		SummaryObj = "" &_
			"<span class=""" & summarytype & """>" &_
				"<span class=""" & style & """ id=""" & lcase(summarytype) & "summary" &_
					placementid & """ " &_
				"onclick=""" & lcase(summarytype) & "summary.open('" &_
					placementid & "', '" & companysite & "')"">" &_
			"</span><span class=""amount " & style & """> " &_
				TwoDecimals(total) &_
			"</span></span>"
	
	end function

end class 

class cPlacements
	'Private, class member variable
	private m_Placements
	private m_Site
	private m_Customer
	private m_Order
	private m_Applicant
	private m_FromDate
	private m_ToDate
	private m_ReportWhen
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Placements = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Placements = Nothing
	End Sub

	'Read the current placements
	Public Property Get Placements()
		Set Placements = m_Placements
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
		Customer = m_Customer
	end property
	public property let Customer(p_Customer)
		if len(p_Customer) = 0 then
			if userLevelRequired(userLevelPPlusStaff) then
				p_Customer = "@ALL" 'default
			else
				p_Customer = g_company_custcode.CustomerCode
			end if
		end if
		m_Customer = Replace(p_Customer, "'", "''")
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

	public property get Applicant()
		Applicant = m_Applicant
	end property
	public property let Applicant(p_Applicant)
		if len(p_Applicant) = 0 then
			p_Applicant = request.form("whichApplicant")
		end if
		m_Applicant = p_Applicant
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

		public function ChooseJobOrder
			if userLevelRequired(userLevelPPlusStaff) then
				dim strDisplayText, strResponseBuffer

				if len(me.Site & "") > 0 then
					thisConnection = dsnLessTemps(getTempsDSN(me.Site))
						
					sqlWhichOrder = "SELECT Orders.Reference, Orders.JobDescription " &_
							"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
							"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
							"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
							"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
							"WHERE (Placements.PlacementStatus=3 AND Placements.NeedFinalTime='TRUE') OR Placements.PlacementStatus=0 " &_
							"AND (Orders.Customer='" & thisCustomer & "') " &_
							"ORDER BY Orders.Customer, Applicants.LastnameFirst"
					
					Set rsWhichOrder = Server.CreateObject("ADODB.RecordSet")
					with rsWhichOrder
						.CursorLocation = 3 ' adUseClient
						.Open sqlWhichOrder, thisConnection
					end with

					dim CurrentOrder
						CurrentOrder = "@ALL"

					strResponseBuffer = "" &_
						"<div id=""topPageRecordsByOrder"" class=""altNavPageRecords navPageRecords""><strong>Job Orders: </strong>" &_
						"<input name=""WhichOrder"" id=""WhichOrder"" type=""hidden"" value=""" & thisOrder & """>" &_
						"<br><div id=""scrollCustomers"">" &_
						"<A HREF=""#"" onclick=""etc_refresh_order('" & CurrentOrder & "')"">&nbsp;"
						
						if thisOrder = CurrentOrder or thisOrder = "" then
							strResponseBuffer = strResponseBuffer & "<span style=""color:red"">" & CurrentOrder & "</span>"
						Else
							strResponseBuffer = strResponseBuffer & CurrentOrder
						end if
						strResponseBuffer = strResponseBuffer & "&nbsp;</A>"
						
					do while not rsWhichOrder.Eof
						CurrentOrder = rsWhichOrder("Reference")
						strDisplayText = Replace(rsWhichOrder("JobDescription"), "&", "&amp;")
						strDisplayText = Replace(strDisplayText, " ", "&nbsp;")
						
						strResponseBuffer = strResponseBuffer & "<A HREF=""#"" onclick=""etc_refresh_order('" & CurrentOrder & "')"">&nbsp;"

						if trim(thisOrder) = trim(CurrentOrder) then
							strResponseBuffer = strResponseBuffer & "<span style=""color:red"">" & strDisplayText & "</span>"
						Else
							strResponseBuffer = strResponseBuffer & strDisplayText
						end if
						strResponseBuffer = strResponseBuffer & "&nbsp;</A>"
						rsWhichOrder.MoveNext
				
						linkNumber = linkNumber + 1
						if linkNumber > 10 and Not rsWhichOrder.Eof then
							linkNumber = 0
							strResponseBuffer = strResponseBuffer & "<br>"
						end if
					loop
					strResponseBuffer = strResponseBuffer & "</div></div>"

					rsWhichOrder.Close
					Set rsWhichOrder = Nothing
					ChooseJobOrder = strResponseBuffer
				end if
			end if
		end function
		
		public function GetActivePlacements()
			dim strSelectCriteria
			if me.Customer = "@ALL" then
				strSelectCriteria = ""
			elseif len(me.Customer) > 0 then
				strSelectCriteria = "Customers.Customer='" & replace(me.Customer, "@ALL", "*") & "' AND "
			end if

            if len(m_Order) > 0 then
                if instr(strSelectCriteria, " AND ") > 0 then
                    strSelectCriteria = "(" & replace(strSelectCriteria, " AND ", " AND Orders.Reference=" & m_Order & ") AND ")
                else
                     strSelectCriteria = "Orders.Reference=" & m_Order & " AND "
                end if
            end if

			dim strSql
			strSql = "SELECT Orders.Customer, Orders.Reference, Placements.EmployeeNumber, Placements.StartDate, " &_
					"Placements.PStopDate, Customers.CustomerName, Applicants.LastnameFirst, Orders.JobNumber, Orders.JobDescription," &_
					"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.PlacementStatus, " &_
					"Placements.PlacementID, Placements.NeedFinalTime, WorkCodes.Description " &_
					"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
					"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
					"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
					"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
					"WHERE " & strSelectCriteria & "(Placements.PlacementStatus=3 AND Placements.NeedFinalTime='TRUE' OR Placements.PlacementStatus=0) " &_
					"ORDER BY Orders.Customer, Applicants.LastnameFirst"

			GetActivePlacements = LoadData (strSQL)
		end function
		
		public function LoadPlacements(strPlacements)
			dim strSelectCriteria
			if me.Customer = "@ALL" then
				strSelectCriteria = ""
			elseif len(me.Customer) > 0 then
				strSelectCriteria = "Customers.Customer='" & replace(me.Customer, "@ALL", "*") & "' AND "
			end if

            if len(m_Order) > 0 then
                if instr(strSelectCriteria, " AND ") > 0 then
                    strSelectCriteria = "(" & replace(strSelectCriteria, " AND ", " AND Orders.Reference=" & m_Order & ") AND ")
                else
                     strSelectCriteria = "Orders.Reference=" & m_Order & " AND "
                end if
            end if
			
			dim strSelectPlacements
			if instr(strPlacements, ",") > 0 then
				strSelectPlacements = "(Placements.PlacementID=" & replace(strPlacements, ",", " OR Placements.PlacementID=") & ")"
			else
				strSelectPlacements = "(Placements.PlacementID=" & strPlacements & ")"
			end if

			dim strSql
			strSql = "SELECT Orders.Customer, Orders.Reference, Placements.EmployeeNumber, Placements.StartDate, " &_
					"Placements.PStopDate, Customers.CustomerName, Applicants.LastnameFirst, Orders.JobNumber, Orders.JobDescription," &_
					"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.PlacementStatus, " &_
					"Placements.PlacementID, Placements.NeedFinalTime, WorkCodes.Description " &_
					"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
					"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
					"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
					"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
					"WHERE " & strSelectCriteria & strSelectPlacements &_
					"ORDER BY Orders.Customer, Applicants.LastnameFirst"

				LoadPlacements = LoadData (strSQL)
		end function
		
		public function LoadArchivePlacements(strPlacements)
			dim strSelectCriteria
			if me.Customer = "@ALL" then
				strSelectCriteria = ""
			elseif len(me.Customer) > 0 then
				strSelectCriteria = "Customers.Customer='" & replace(me.Customer, "@ALL", "*") & "' AND "
			end if

            if len(m_Order) > 0 then
                if instr(strSelectCriteria, " AND ") > 0 then
                    strSelectCriteria = "(" & replace(strSelectCriteria, " AND ", " AND Orders.Reference=" & m_Order & ") AND ")
                else
                     strSelectCriteria = "Orders.Reference=" & m_Order & " AND "
                end if
            end if
			
			dim strSelectPlacements
			if instr(strPlacements, ",") > 0 then
				strSelectPlacements = "(Placements.PlacementID=" & replace(strPlacements, ",", " OR Placements.PlacementID=") & ")"
			else
				strSelectPlacements = "(Placements.PlacementID=" & strPlacements & ")"
			end if

			dim strSql
			strSql = "SELECT Orders.Customer, Orders.Reference, Placements.EmployeeNumber, Placements.StartDate, " &_
					"Placements.PStopDate, Customers.CustomerName, Applicants.LastnameFirst, Orders.JobNumber, Orders.JobDescription," &_
					"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.PlacementStatus, " &_
					"Placements.PlacementID, Placements.NeedFinalTime, WorkCodes.Description " &_
					"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
					"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
					"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
					"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
					"WHERE " & strSelectCriteria & strSelectPlacements &_
					"ORDER BY Orders.Customer, Applicants.LastnameFirst"

				LoadArchivePlacements = LoadData (strSQL)
		end function
		
		public function GetDeparments()
			dim strSelectCriteria
			if me.Customer = "@ALL" then
				strSelectCriteria = ""
			elseif len(me.Customer) > 0 then
				strSelectCriteria = "Customers.Customer='" & replace(me.Customer, "@ALL", "*") & "' AND "
			end if

			dim strSql
			strSql = "SELECT Orders.Customer, Orders.Reference, Placements.EmployeeNumber, Placements.StartDate, " &_
					"Placements.PStopDate, Customers.CustomerName, Applicants.LastnameFirst, Orders.JobNumber, Orders.JobDescription," &_
					"Placements.WorkCode, Placements.RegPayRate, Placements.RegBillRate, Placements.PlacementStatus, " &_
					"Placements.PlacementID, Placements.NeedFinalTime, WorkCodes.Description " &_
					"FROM (((Placements Placements LEFT OUTER JOIN Orders Orders ON Placements.Reference=Orders.Reference) " &_
					"LEFT OUTER JOIN WorkCodes WorkCodes ON Placements.WorkCode=WorkCodes.WorkCode) " &_
					"LEFT OUTER JOIN Applicants Applicants ON Placements.EmployeeNumber=Applicants.EmployeeNumber) " &_
					"LEFT OUTER JOIN Customers Customers ON Placements.Customer=Customers.Customer " &_
					"WHERE " & strSelectCriteria & "(Placements.PlacementStatus=3 AND Placements.NeedFinalTime='TRUE' OR Placements.PlacementStatus=0) " &_
					"ORDER BY Orders.Customer, Applicants.LastnameFirst"
				
			GetAllCustomers = LoadData (strSQL)
		end function
		
		

	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
			
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisPlacement
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				set thisPlacement = New cPlacement
				with thisPlacement
					.CustomerCode    = p_RS.fields("Customer").Value 'Customer
					.CustomerName    = p_RS.fields("CustomerName").Value 'CustomerName
					.JobDescription  = p_RS.fields("JobDescription").Value
					.Reference       = p_RS.fields("Reference").Value
					.EmployeeNumber  = p_RS.fields("EmployeeNumber").Value 
					.StartDate       = p_RS.fields("StartDate").Value 'Placement.StartDate
					.PStopDate       = p_RS.fields("PStopDate").Value 'Placements.PStopDate
					.PlacementId     = p_RS.fields("PlacementID")
					.LastnameFirst   = p_RS.fields("LastnameFirst").Value 'Applicants..LastnameFirst
					.JobNumber       = p_RS.fields("JobNumber").Value 'Orders.JobNumber
					.WorkCode        = p_RS.fields("WorkCode").Value 'WorkCode
					.RegPayRate      = TwoDecimals(p_RS.fields("RegPayRate").Value)
					.RegBillRate     = TwoDecimals(p_RS.fields("RegBillRate").Value)
					.Status          = p_RS.fields("PlacementStatus").Value
					.NeedFinalTime   = p_RS.fields("NeedFinalTime").Value
					.WCDescription   = p_RS.fields("Description").Value 'WorkCodes.Description 
				end with
				m_Placements.Add thisPlacement.PlacementId, thisPlacement
				
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

class cPlacement
	private m_CustomerCode
	private m_CustomerName
	private m_CustomerDept
	private m_DepartmentName
	private m_Reference
	private m_EmployeeNumber
	private m_StartDate
	private m_PStopDate
	private m_PlacementId
	private m_LastnameFirst
	private m_JobNumber
	private m_JobDescription
	private m_WorkCode
	private m_RegPayRate
	private m_RegBillRate
	private m_TotalExpenses
	private m_TotalTime
	private m_ExpenseSummary
	private m_TimeSummary
	Private m_Status
	private m_NeedFinalTime
	private m_WCDescription

	
	public sub Class_Initialize
		
	end sub


	public property get CustomerCode ()
		CustomerCode = m_CustomerCode
	end property

	public property let CustomerCode(p_CustomerCode)
		m_CustomerCode = p_CustomerCode
	end property

	public property get CustomerName()
		CustomerName = m_CustomerName
	end property

	public property let CustomerName(p_CustomerName)
		m_CustomerName = p_CustomerName
	end property

	public property get CustomerDept()
		CustomerDept = m_CustomerDept
	end property

	public property let CustomerDept(p_CustomerDept)
		m_CustomerDept = p_CustomerDept
	end property

	public property get Reference()
		Reference = m_Reference
	end property

	public property let Reference(p_Reference)
		m_Reference = p_Reference
	end property

	public property get EmployeeNumber()
		EmployeeNumber = m_EmployeeNumber
	end property

	public property let EmployeeNumber(p_EmployeeNumber)
		m_EmployeeNumber = p_EmployeeNumber
	end property

	public property get StartDate()
		StartDate = m_StartDate
	end property

	public property let StartDate(p_StartDate)
		m_StartDate = p_StartDate
	end property

	public property get PStopDate()
		PStopDate = m_PStopDate
	end property

	public property let PStopDate(p_PStopDate)
		m_PStopDate = p_PStopDate
	end property

	public property get PlacementId()
		PlacementId = m_PlacementId
	end property

	public property let PlacementId(p_PlacementId)
		m_PlacementId = p_PlacementId
		GetTotalHours(m_PlacementId)
	end property

	public property get LastnameFirst()
		LastnameFirst = m_LastnameFirst
	end property

	public property let LastnameFirst(p_LastnameFirst)
		m_LastnameFirst = p_LastnameFirst
	end property

	public property get JobNumber()
		JobNumber = m_JobNumber
	end property

	public property let JobNumber(p_JobNumber)
		m_JobNumber = p_JobNumber
	end property
	
	public property get JobDescription()
		JobDescription = m_JobDescription
	end property

	public property let JobDescription(p_JobDescription)
		m_JobDescription = p_JobDescription
	end property

	public property get CostCenter()
		CostCenter = m_JobNumber
	end property


	public property get WorkCode()
		WorkCode = m_WorkCode
	end property

	public property let WorkCode(p_WorkCode)
		m_WorkCode = p_WorkCode
	end property

	public property get RegPayRate()
		RegPayRate = m_RegPayRate
	end property

	public property let RegPayRate(p_RegPayRate)
		m_RegPayRate = p_RegPayRate
	end property

	public property get RegBillRate()
		RegBillRate = m_RegBillRate
	end property

	public property let RegBillRate(p_RegBillRate)
		m_RegBillRate = p_RegBillRate
	end property

	public property get HasTimeOrExpense()
		if (m_TotalExpenses > 0) or (m_TotalTime > 0) then
			HasTimeOrExpense = true
		else
			HasTimeOrExpense = false
		end if
	end property
	
	public property get ExpenseSummary
		'need placement id and company site
		dim placementId
		dim company
		if m_TotalExpenses > 0 then
			ExpenseSummary = SummaryObj("Expense", "Expecting", me.PlacementId, company, m_TotalExpenses)
		else
			ExpenseSummary = SummaryObj("Expense", "Grey", me.PlacementId, company, 0)
		end if
	
	end property

	public property get TimeSummary
		'need placement id and company site
		dim company
		
		if m_TotalTime > 0 then
			TimeSummary = SummaryObj("Time", "Expecting", me.PlacementId, company, m_TotalTime)
		else
			TimeSummary = SummaryObj("Time", "Grey", me.PlacementId, company, 0)
		end if
	
	end property
	
	private function SummaryObj(summarytype, style, placementid, companysite, total)
		' summarytype - 'Expense'
		'             - 'Time'
		'
		' style       - 'Expecting'
		'             - 'Grey'
		dim timeOrExpense

		if lcase(summarytype) = "expense" then
			timeOrExpense = "E"
		else
			timeOrExpense = "T"
		end if
		
		SummaryObj = "" &_
			"<span class=""" & summarytype & """>" &_
				"<span class=""" & style & """ id=""" & lcase(summarytype) & "summary" &_
					placementid & """ " &_
				"onclick=""" & lcase(summarytype) & "summary.open('" &_
					placementid & "', '" & companysite & "')"">" &_
			"</span><span id=""super" & timeOrExpense & "_" & placementid & """ class=""amount " & style & """> " &_
				TwoDecimals(total) &_
			"</span></span>"
	
	end function

	public property get Status()
		Status = m_Status
	end property

	public property let Status(p_Status)
		m_Status = p_Status
	end property

	public property get NeedFinalTime()
		NeedFinalTime = m_NeedFinalTime
	end property

	public property let NeedFinalTime(p_NeedFinalTime)
		m_NeedFinalTime = p_NeedFinalTime
	end property

	public property get WCDescription()
		WCDescription = m_WCDescription
	end property

	public property let WCDescription(p_WCDescription)
		m_WCDescription = p_WCDescription
	end property

	'#############  Public Functions ##############
		
		public function GetTotalHours(placementId)

			dim strSql
			strSql = "" &_
				"SELECT t.id, SUM(t.halftotal) as totalhours " &_
				"FROM (" &_
					"SELECT time_summary.id, timetotal AS halftotal " &_
					"FROM time_summary " &_
					"LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					"WHERE placementid=" & placementId & " " &_
				"UNION ALL " &_
					"SELECT time_summary.id, SUM(ABS(TIME_TO_SEC(TIMEDIFF(timeout, timein))))/60/60 AS halftotal " &_
					"FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					"WHERE placementid=" & placementId & " AND (timeout > timein) " &_
			"UNION ALL " &_
					"SELECT time_summary.id, SUM(ABS(TIME_TO_SEC(TIMEDIFF(ADDTIME(timeout, '24:00:00'), timein))))/60/60 AS halftotal " &_
					"FROM time_summary LEFT JOIN time_detail ON time_summary.id = time_detail.summaryid " &_
					"WHERE placementid=" & placementId & " AND (timein > timeout) ) t " &_
				"GROUP By t.id ORDER By t.id desc;"
				
			GetTotalHours = LoadData (strSQL)
			
		end function
	
	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillFromRS(p_RS)
			dim m_Page, m_PageCount, m_ItemsPerPage
			
			'p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
			
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim theseHours
			if not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page ) then
				set theseHours = New cTotalHours
				theseHours.id             = p_RS.fields("id").value
				
				'if more than one week, add together
				do until p_RS.eof
					theseHours.totalhours   = p_RS.fields("totalhours").Value 'Customer
					if vartype(theseHours.totalhours) > 1 then m_TotalTime = m_TotalTime + cdbl(theseHours.totalhours)
					p_RS.movenext
				loop
				theseHours.totalhours = m_TotalTime
			end if
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			REM if isnumeric(me.Site) then
				REM set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))
			REM else
				REM set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getCompanyNumber(me.Site)))
			REM end if
			set rs = GetRSfromDB(p_strSQL, MySql)
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function
	
end class 

class cTotalHours
	private m_id	
	private m_totalhours
	
	public property get id()
		id = m_id
	end property
	public property let id(p_id)
		m_id = p_id
	end property
	
	public property get totalhours()
		totalhours = m_totalhours
	end property
	public property let totalhours(p_totalhours)
		m_totalhours = p_Totalhours
	end property

end class

class cTimeSummary
	private m_id
	private m_creatorid
	private m_WeekEnding
	private m_DayName(6)
	private m_Day(7)
	private m_WorkDay
	private m_TotalHours
	private m_TotalExpense

	public property get  DayName(p_weekday)
		DayName = m_DayName(p_weekday)
	end property
	
	public property get  Day(p_workday)
		Day = m_Day(p_workday)
	end property
	public property let  Day(p_workday, p_hours)
				m_Day(p_workday) = p_hours
	end property

	public property get id()
		id = m_id
	end property
	public property let id(p_id)
		m_id = p_id
	end property
	
	public property get creatorid()
		creatorid = m_creatorid
	end property
	public property let creatorid(p_creatorid)
		' query returns userid '1' as either null or false. IF block sets back to 1. Sort of hackish but can only
		' reproduce issue with my userid, other users everything works fine. After a few too many wasted hours [days]
		' resolving to apply the hack and move one. =)
		'
		if isnull(p_creatorid) then
			m_creatorid = cint(1)
		elseif p_creatorid="False" then
			'break "inside timecard.classes.timesummary.creatorid: breaking for false"
			m_creatorid = cint(1) 'correct user 1 issue with mysql boolean conversion
			'print vartype(p_creatorid)
			else
			'print vartype(p_creatorid)
			m_creatorid = p_creatorid
		end if
	end property	
	
	public property get WeekEnding()
		WeekEnding = m_WeekEnding
	end property
	public property let WeekEnding(p_WeekEnding)
		m_WeekEnding = p_WeekEnding
		
		dim i, current_day
		for i = 0 to 6
			current_day = Weekday(m_WeekEnding) - i
			if not isnull(current_day) then
				if current_day < 1  then current_day = current_day + 7
				m_DayName(6 - i) = Left(WeekDayName(current_day), 3)
			end if
		next
	end property

	public property get WorkDay()
		WorkDay = m_WorkDay
	end property
	public property let WorkDay(p_WorkDay)
		m_WorkDay = p_WorkDay
	end property
	
	public property get TotalHours()
		dim x, t
		for x = lbound(m_Day) to ubound(m_Day)
			t = t + cdbl(m_Day(x))
		next
		TotalHours = t
	end property
	public property let TotalHours(p_TotalHours)
		m_TotalHours = p_TotalHours
	end property
	
	public property get TotalExpense()
		TotalExpense = m_TotalExpense
	end property
	public property let TotalExpense(p_TotalExpense)
		m_TotalExpense = p_TotalExpense
	end property
	
end class

class cTimeDetail
	private m_PlacementId
	private m_SummaryId
	private m_DetailId
	private m_TimeTypeId
	private m_TimeType
	private m_WeekEnding
	private m_Site
	private m_Workday
	private m_TimeIn
	private m_TimeOut
	private m_TotalTime
	private m_Hours
	private m_EnteredBy
	private m_Created
	private m_CreatorId
	private m_Modified

	public property get PlacementId()
		PlacementId = m_PlacementId
	end property
	public property let PlacementId(p_PlacementId)
		m_PlacementId = p_PlacementId
	end property

	public property get SummaryId()
		SummaryId = m_SummaryId
	end property
	public property let SummaryId(p_SummaryId)
		m_SummaryId = p_SummaryId
	end property
	
	public property get DetailId()
		DetailId = m_DetailId
	end property
	public property let DetailId(p_DetailId)
		m_DetailId = p_DetailId
	end property

	public property get TimeTypeId()
		TimeTypeId = m_TimeTypeId
	end property
	public property let TimeTypeId(p_TimeTypeId)
		m_TimeTypeId = p_TimeTypeId
	end property

	public property get TimeType()
		TimeType = m_TimeType
	end property
	public property let TimeType(p_TimeType)
		m_TimeType = p_TimeType
	end property

	public property get WeekEnding()
		WeekEnding = m_WeekEnding
	end property
	public property let WeekEnding(p_WeekEnding)
		m_WeekEnding = p_WeekEnding
	end property

	public property get Site()
		Site = m_Site
	end property
	public property let Site(p_Site)
		m_Site = p_Site
	end property

	public property get Workday()
		Workday = m_Workday
	end property
	public property let Workday(p_Workday)
		m_WorkDay = p_Workday
	end property

	public property get TimeIn()
		TimeIn = m_TimeIn
	end property
	public property let TimeIn(p_TimeIn)
		m_TimeIn = p_TimeIn
	end property

	public property get TimeOut()
		TimeOut = m_TimeOut
	end property
	public property let TimeOut(p_TimeOut)
		m_TimeOut = p_TimeOut
	end property

	public property get TotalTime()
		TotalTime = m_TotalTime
	end property
	public property let TotalTime(p_TotalTime)
		m_TotalTime = p_TotalTime
	end property

	public property get Hours()
		Hours = m_Hours
	end property
	public property let Hours(p_Hours)
		m_Hours = p_Hours
	end property

	public property get EnteredBy()
		EnteredBy = m_EnteredBy
	end property
	public property let EnteredBy(p_EnteredBy)
		m_EnteredBy = p_EnteredBy
	end property

	public property get Created()
	end property
	public property let Created(p_Created)
	end property
	
	public property get CreatorId()
		CreatorId = m_CreatorId
	end property
	public property let CreatorId(p_CreatorId)
		if p_CreatorId = "False" and user_id = 1 then
			m_CreatorId = 1
		else
			m_CreatorId = p_CreatorId
		end if
	end property
	
	public property get Modified()
		Modified = m_Modified
	end property
	public property let Modified(p_Modified)
		m_Modified = p_Modified
	end property

end class


%>
