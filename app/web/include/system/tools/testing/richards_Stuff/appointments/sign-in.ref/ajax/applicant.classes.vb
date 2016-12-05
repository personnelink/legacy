<%

class cOrders
	'Private, class member variable
	private m_Orders
	private m_Site
	private m_Customer
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
		
			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.JobStatus, Orders.JobNumber AS CustomerDept, Orders.Reference, " &_
				"Orders.JobDescription, Orders.WorkSite1 & "", "" & Orders.WorkSite2 AS WorkSite, Orders.WorkSite3 AS " &_
				"WorkSitePhone, Orders.OrderDate, Orders.StartDate, Orders.StopDate, Orders.EmailAddress, Orders.EmailFormat " &_
				"FROM Orders " &_
				"WHERE (Orders.Customer=""" & me.Customer & """) AND (Orders.JobStatus<2 OR Orders.JobStatus = 3);"
				
			GetOpenOrders = LoadData (strSQL)
		end function
		
		public function GetClosedOrders()

			dim strSql
			strSql = "" &_
				"SELECT Orders.Customer, Orders.JobStatus, Orders.JobNumber AS CustomerDept, Orders.Reference, " &_
				"Orders.JobDescription, Orders.WorkSite1 & "", "" & Orders.WorkSite2 AS WorkSite, Orders.WorkSite3 AS " &_
				"WorkSitePhone, Orders.OrderDate, Orders.StartDate, Orders.StopDate, Orders.EmailAddress, Orders.EmailFormat " &_
				"FROM Orders " &_
				"WHERE (Orders.Customer=""" & me.Customer & """) AND (Orders.JobStatus=2 OR Orders.JobStatus = 4);"
	
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


class cApplicants
	'Private, class member variable
	private m_Applicants
	private m_Site
	private m_Applicant
	private m_FromDate
	private m_ToDate
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Applicants = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Applicants = Nothing
	End Sub

	'Read the current placements
	Public Property Get Applicants()
		Set Applicants = m_Applicants
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
		
		public function Search(strSearch)
			dim tempsCode
				tempsCode = getTempsCompCode(me.Site)
				
			dim strSql
			strSql = "" &_
				"SELECT tbl_users.userID, tbl_users.applicationID, tbl_users.userEmail, tbl_users.userPhone, tbl_users.userSPhone, " &_
				"CONCAT(tbl_users.firstName, "" "", tbl_users.lastName) AS ApplicantName, tbl_users.EmpCode,  " &_
				"tbl_applications.lastInserted, tbl_applications.modifiedDate, tbl_applications.creationDate, " &_
				"tbl_applications.in" & tempsCode & " AS ApplicantId, tbl_applications.ssn " &_
				"FROM pplusvms.tbl_users  " &_
				"INNER JOIN pplusvms.tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
				"WHERE (CONCAT(tbl_users.firstName, "" "", tbl_users.lastName) like '%" & strSearch & "%' OR " &_
				"EmpCode like '%" & strSearch & "%' OR " &_
				"userPhone like '%" & strSearch & "%' OR " &_
				"userSPhone like '%" & strSearch & "%' OR " &_
				"userEmail like '%" & strSearch & "%' OR " &_
				"ssn like '%" & strSearch & "%') AND tbl_applications.in" & tempsCode & " IS NOT NULL " &_
				"ORDER By modifiedDate desc, lastInserted desc, creationDate desc, ApplicantName asc LIMIT 0, 15;"
		
			Search = LoadData (strSQL)
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
			
			dim thisApplicant, id
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				id = id + 1
				set thisApplicant = New cApplicant
				with thisApplicant
					.Id             = id
					.Site           = Me.Site
					.EmployeeCode   = p_RS.fields("EmpCode").Value
					.SSN            = p_RS.fields("ssn").Value
					.ApplicantId    = p_RS.fields("ApplicantId").Value
					.ApplicantName  = p_RS.fields("ApplicantName").Value
					.Phone          = p_RS.fields("userPhone").Value
					.SecondPhone    = p_RS.fields("userSPhone").Value
					.EmailAddress   = p_RS.fields("userEmail").Value
				end with
				m_Applicants.Add thisApplicant.Id, thisApplicant
				p_RS.movenext
			loop
		End Function

		Private Function LoadData(p_strSQL)
			dim rs
			set rs = GetRSfromDB(p_strSQL, MySql)
			FillFromRS(rs)
			LoadData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class

class cApplicant
	private m_Id
	private m_Site
	private m_EmployeeCode
	private m_SSN 'm_JobNumber
	private m_ApplicantId
	private m_ApplicantName
	private m_Phone
	private m_SecondPhone
	private m_StartDate
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

	public property get EmployeeCode ()
		EmployeeCode = m_EmployeeCode
	end property
	public property let EmployeeCode(p_EmployeeCode)
		m_EmployeeCode = p_EmployeeCode
	end property

	public property get SecondPhone()
		SecondPhone = m_SecondPhone
	end property
	public property let SecondPhone(p_SecondPhone)
		m_SecondPhone = p_SecondPhone
	end property

	public property get SSN() 'JobNumber
		SSN = m_SSN
	end property

	public property let SSN(p_SSN)
		m_SSN = p_SSN
	end property

	public property get ApplicantId()
		ApplicantId = m_ApplicantId
	end property

	public property let ApplicantId(p_ApplicantId)
		m_ApplicantId = p_ApplicantId
	end property

	public property get ApplicantName()
		ApplicantName = m_ApplicantName
	end property

	public property let ApplicantName(p_ApplicantName)
		m_ApplicantName = p_ApplicantName
	end property

	public property get Phone()
		Phone = m_Phone
	end property
	public property let Phone(p_Phone)
		m_Phone = p_Phone
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



%>
