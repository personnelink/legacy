<%
'Account Activity object class
class cAccountActivity

	private m_Summary
	private m_CustomerCode
	private m_CompanyId 'Temps DSN ID
	private m_Department
	private m_FromDate
	private m_ToDate
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Summary = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Summary = Nothing
	End Sub

	public property get Summary()
		set Summary = m_Summary
	end property

	public property get CustomerCode()
		CustomerCode = m_CustomerCode
	end property
	public property let CustomerCode(p_CustomerCode)
		m_CustomerCode = p_CustomerCode
	end property
	
	public property get CompanyId()
		CompanyId = m_CompanyId
	end property
	public property let CompanyId(p_CompanyId)
		m_CompanyId = p_CompanyId
	end property
	
	public property get Department()
		Department = m_Department
	end property
	public property let Department(p_Department)
		m_Department = p_Department
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
	
	public property get ItemsPerPage()
		ItemsPerPage = m_ItemsPerPage
	end property
	public property let ItemsPerPage(p_ItemsPerPage)
		m_ItemsPerPage = p_ItemsPerPage
	end property

	public property get Page()
		Page = m_Page
	end property
	public property let Page(p_Page)
		m_Page = p_Page
	end property


	'#############  Public Functions, accessible to web pages ##############
	'load departments based on current company id
	public function LoadAccountActivity()

		' if len(simcust & "") > 0 and userLevelRequired(userLevelPPlusStaff) then
			' whichCompanyID = "((ARSummary.Customer)='" & simcust & "') AND "
			' this_customer = simcust
			' simcust = "cust=" & simcust
		' elseif (len(company_custcode & "") > 0 and userLevelRequired(userLevelPPlusStaff)) or (len(company_custcode & "") > 0 and userLevelRequired(userLevelManager)) then
			' whichCompanyID = "((ARSummary.Customer)='" & company_custcode & "') AND "
			' this_customer = company_custcode
			' simcust = "cust=" & company_custcode
		' else
			' break company_custcode
			' print "SELECT ARActivity.Oldest, ARActivity.Balance, ARActivity.Customer FROM ARActivity WHERE ARActivity.Customer=""ZIONSB"";"
		' end if
	
		dim MyId : MyId = clng(p_CompanyId)
		dim strDateClause
		if isDate(m_FromDate) then 'check if FromDate is valid
			if not isDate(m_ToDate) then
				''From' date valid, check if 'To' date is also, otherwise set To date to today
				m_ToDate = Date()
			end if
		elseif isDate(m_ToDate) then
			'From date is invalid.
			'Check 'To' date and if valid inputs are reversed; set 'From' date to today
			m_FromDate = Date()
		
		else
			'Neither date is valid or set. Default variables to last 30 days.
			m_ToDate = Date()
			m_FromDate = DateAdd("d", -90, m_ToDate)
		end if
		strDateClause = "(ARSummary.InvoiceDate BETWEEN #" & m_FromDate & "# AND #" & m_ToDate & "#)"

		dim strDepartmentClause
		if len(m_Department) = 0 then
			'no department restrictions
			strDepartmentClause = ""
		elseif instr(m_Department, ",") > 0 then
			'User is associated with multiple departments. Split them up and build appropriate ad-hoc SQL statement.
			strDepartmentClause = "(Orders.JobNumber=" & replace(replace(m_Department, " ", ""), ",", " OR Orders.JobNumber=") & ")"
		else
			'User is associated with a single department
			strDepartmentClause = "(Orders.JobNumber=" & m_Department & ")"
		end if
		
		dim strCompanyClause
		if len(m_CustomerCode) > 0 then
			strCompanyClause = "(ARSummary.Customer='" & m_CustomerCode & "')"
		else
			'Abort processing because no customer code is set... Should never happen, but potential security issue.
			break "Customer Code not set"
		end if
		
		'Assemble final ad-hoc expression
		dim strWhereClause
		if len(strDepartmentClause) > 0 then
			strWhereClause = "" &_
				"WHERE " & strDateClause & " AND " & strDepartmentClause  & " AND " & strCompanyClause
		else
			strWhereClause = "" &_
				"WHERE " & strDateClause & " AND " & strCompanyClause
		end if
		
		'Assemble final query
		dim strSQL
 		strSQL = "" &_
			"SELECT ARSummary.Invoice, ARSummary.InvoiceDate, ARCustomers.Contact, ARDetail.Amount, " &_
					"ARDetail.PostingDate, ARSummary.Total, ARDetail.Document, ARDetail.Description, " &_
					"Orders.JobNumber, Orders.JobDescription " &_
					"FROM (((ARSummary LEFT JOIN ARCustomers ON ARSummary.Customer = ARCustomers.Customer) " &_
					"LEFT JOIN ARDetail ON ARSummary.SummaryId = ARDetail.SummaryId) " &_
					"LEFT JOIN ArTerms ON ARCustomers.TermsCode = ArTerms.TermsCode) " &_
					"RIGHT JOIN Orders ON ARSummary.Reference = Orders.Reference " &_
					strWhereClause & " AND ARSummary.InHistory=FALSE " &_
					"ORDER BY Orders.JobNumber, Orders.JobDescription, ARSummary.Customer, ARSummary.Invoice"
					
					'print strSQL
					
					LoadAccountActivity = LoadData (strSQL)
					
		
	end function

	public function GetPageSelection()
		const StartSlide = 32 ' when to start sliding
		const StopSlide = 112 'when to stop sliding and show the smallests amount
		const SlideRange = 8 'the most pages to show minus this = smallest number to show aka the slide
		const TopPages = 25 'the most records to show
		
		dim maxPages, slidePages

		if m_Page <= StartSlide then
			maxPages = TopPages
		elseif m_Page > StartSlide and m_Page < StopSlide then
			maxPages = TopPages - (SlideRange - Cint(SlideRange * ((StopSlide - m_Page)/(StopSlide - StartSlide))))
		else
			maxPages = TopPages - SlideRange
		end if
		slidePages = cint((maxPages/2)+0.5)

		dim startPage, stopPage
		if m_PageCount > maxPages then
			startPage = nPage - slidePages
			stopPage = nPage + slidePages
			
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
		queryPageNumber = Request.QueryString("Page")
		if queryPageNumber then
			rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
		end if
		
		dim p_strPageSelection
		p_strPageSelection = "<div id=""topPageRecords"" class=""navPageRecords"">" &_
			"<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & whichCompany & """>First</A>"
			For i = startPage to stopPage
				p_strPageSelection = p_strPageSelection &_
					"<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & """>&nbsp;"
				if i = nPage then
					p_strPageSelection = p_strPageSelection &_
						"<span style=""color:red"">" & i & "</span>"
				Else
					p_strPageSelection = p_strPageSelection & i
				end if
				p_strPageSelection = p_strPageSelection &"&nbsp;</A>"
			Next
		p_strPageSelection = p_strPageSelection &_
			"<A HREF=""" & aspPageName & "?Page=" & m_PageCount & "&whichCompany=" & whichCompany & """>Last</A>" &_
			"</div>"

		GetPageSelection = p_strPageSelection
	end function	
	
    'Takes a recordset
    'Fills the object's properties using the recordset
    Private Function FillFromRS(p_RS)
		dim p_Key      : p_Key = 0
		
		p_RS.PageSize = m_ItemsPerPage
		m_PageCount = p_RS.PageCount
				
		if m_Page < 1 Or m_Page > m_PageCount then
			m_Page = 1
		end if
		
		if not p_RS.eof then p_RS.AbsolutePage = m_Page
		
		dim thisAccountSummary
		dim p_Invoice
 		do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
			set thisAccountSummary = New cAccountSummary
			with thisAccountSummary
				.Id              = p_Key : p_Key = p_Key + 1
				 p_Invoice       = p_RS.fields("Invoice").Value
				.Invoice         = p_Invoice
				.InvoiceDate     = cstr(p_RS.fields("InvoiceDate").Value)
				.Contact         = p_RS.fields("Contact").Value
				.Amount          = p_RS.fields("Amount").Value
				.PostingDate     = p_RS.fields("PostingDate").Value
				.Total           = p_RS.fields("Total").Value
				.Document        = p_RS.fields("Document").Value
				.Description     = p_RS.fields("Description").Value
				.JobDescription  = p_RS.fields("JobDescription").Value
				.JobNumber       = p_RS.fields("JobNumber").Value
				.HTMLInvoiceLink = "" &_
									"<a href=""/include/system/services/sendPDF.asp?" &_
									"site=" & m_CompanyId & "&" &_
									"customer=" & m_CustomerCode & "&" &_
									"id=" & p_Invoice & "&" &_
									"cat=inv"" class=""invlink"">" & p_Invoice & "</a>"
			end with
			m_Summary.Add thisAccountSummary.Id, thisAccountSummary
			p_RS.movenext
        loop
	End Function

'#############  Private Functions                           ##############


	Private Function LoadData(p_strSQL)
		dim rs
		'print dsnLessTempsAR(m_CompanyId)
        set rs = GetRSfromDB(p_strSQL, dsnLessTempsAR(m_CompanyId))
 		FillFromRS(rs)
		LoadData = rs.recordcount
		rs. close
		set rs = nothing
	End Function

end class


'object class for each summary line item with-in the 'Account Activity' object
class cAccountSummary

	private m_Id
	private m_Invoice
	private m_InvoiceDate
	private m_Contact
	private m_Amount
	private m_PostingDate
	private m_Total
	private m_Document
	private m_Description
	private m_JobDescription
	private m_JobNumber
	private m_HTMLInvoiceLink
	
	'read the current deparment
	public property get Id()
		Id = m_Id
	end property
	public property let Id(p_Id)
		m_Id = p_Id
	end property

	public property get Invoice()
		Invoice = m_Invoice
	end property
	public property let Invoice(p_Invoice)
		m_Invoice = p_Invoice
	end property

	public property get InvoiceDate()
		InvoiceDate = m_InvoiceDate
	end property
	public property let InvoiceDate(p_InvoiceDate)
		m_InvoiceDate = p_InvoiceDate
	end property

	public property get Contact()
		Contact = m_Contact
	end property
	public property let Contact(p_Contact)
		m_Contact = p_Contact
	end property

	public property get Amount()
		Amount = m_Amount
	end property
	public property let Amount(p_Amount)
		m_Amount = p_Amount
	end property

	public property get PostingDate()
		PostingDate = m_PostingDate
	end property
	public property let PostingDate(p_PostingDate)
		m_PostingDate = p_PostingDate
	end property

	public property get Total()
		Total = m_Total
	end property
	public property let Total(p_Total)
		m_Total = p_Total
	end property

	public property get Document()
		Document = m_Document
	end property
	public property let Document(p_Document)
		m_Document = p_Document
	end property

	public property get Description()
		Description = m_Description
	end property
	public property let Description(p_Description)
		m_Description = p_Description
	end property
	
	public property get JobDescription()
		JobDescription = m_JobDescription
	end property
	public property let JobDescription(p_JobDescription)
		m_JobDescription = p_JobDescription
	end property
	
	public property get JobNumber()
		JobNumber = m_JobNumber
	end property
	public property let JobNumber(p_JobNumber)
		m_JobNumber = p_JobNumber
	end property
	
	public property get HTMLInvoiceLink()
		HTMLInvoiceLink = m_HTMLInvoiceLink
	end property
	public property let HTMLInvoiceLink(p_HTMLInvoiceLink)
		m_HTMLInvoiceLink = p_HTMLInvoiceLink
	end property
	
end class

%>
