<!-- #include file='usagedetail.class.asp' -->
<%
class cCustomerUsage

	private m_UsageDetail
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page


	Sub Class_Initialize()
		set m_UsageDetail = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_UsageDetail = Nothing
	End Sub

	public property get UsageDetail()
		set UsageDetail = m_UsageDetail
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
	public function LoadCustomerUsage()
		dim strSQL, MyId
		MyId = clng(p_CompanyId)
		break "query review, please check back"
		strSQL = "" &_
			"SELECT Detail.*, Summary.* " &_
			"FROM (" &_
				"SELECT HistoryDetail.Billrate, HistoryDetail.Quantity, HistoryDetail.Invoice, HistoryDetail.Workcode AS CostCenter, " &_
					"WorkCodes.Description AS CCDescription, Applicants.ApplicantID AS DApplicantId, HistoryDetail.InvoiceDate, Orders.JobNumber, " &_
					"Orders.JobDescription " &_
				"FROM Orders " &_
					"RIGHT JOIN ((HistoryDetail LEFT JOIN Applicants ON HistoryDetail.[AppId] = Applicants.[ApplicantID]) " &_
					"LEFT JOIN WorkCodes ON HistoryDetail.Workcode = WorkCodes.WorkCode) ON Orders.Reference = HistoryDetail.Reference " &_
				"WHERE (((HistoryDetail.InvoiceDate) Between #1/1/2011# And #2/1/2011#)  " &_
					"AND ((HistoryDetail.Customer)=""CITYBU""))  " &_
				"ORDER BY Orders.JobNumber, Applicants.LastnameFirst, HistoryDetail.Invoice " &_
				")  " &_
			"AS Detail  " &_
			"LEFT JOIN ( " &_
				"SELECT Sum(HistoryDetail.Quantity) AS SumOfQuantity, Sum(HistoryDetail.Billrate*HistoryDetail.Quantity) AS TotalBilled,  " &_
					"Applicants.LastnameFirst, Applicants.ApplicantID " &_
				"FROM Orders  " &_
					"RIGHT JOIN (HistoryDetail  " &_
					"LEFT JOIN Applicants ON HistoryDetail.[AppId] = Applicants.[ApplicantID]) ON Orders.Reference = HistoryDetail.Reference  " &_
				"WHERE (((HistoryDetail.InvoiceDate) Between #1/1/2011# And #2/1/2011#))  " &_
				"GROUP BY Applicants.LastnameFirst, Applicants.ApplicantID, HistoryDetail.Customer  " &_
				"HAVING (((HistoryDetail.Customer)=""CITYBU"")) " &_
				"ORDER BY Applicants.LastnameFirst" &_
				") " &_
			"AS Summary " &_
			"ON Detail.DApplicantId = Summary.ApplicantID " &_
			"ORDER BY Detail.JobNumber;"
		LoadCustomerUsage = LoadData (strSQL)
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
		dim p_Billrate : p_Billrate = 0
		dim p_Quantity : p_Quantity = 0
		dim thisUsageDetail
		
		p_RS.PageSize = m_ItemsPerPage
		m_PageCount = p_RS.PageCount
				
		if m_Page < 1 Or m_Page > m_PageCount then
			m_Page = 1
		end if

		if not p_RS.eof then p_RS.AbsolutePage = m_Page
		
 		do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
			set thisUsageDetail = New cUsageDetail
			with thisUsageDetail
				p_Billrate = CDbl(p_RS.fields("Billrate").Value)
				p_Quantity = CDbl(p_RS.fields("Quantity").Value)
				.Id             = p_Key : p_Key = p_Key + 1
				.DepartmentId   = p_RS.fields("JobNumber").Value
				.JobDescription = p_RS.fields("JobDescription").Value
				.ApplicantId    = p_RS.fields("ApplicantID").Value
				.Billrate       = TwoDecimals(p_Billrate)
				.Quantity       = TwoDecimals(p_Quantity)
				.Billed         = TwoDecimals((p_Billrate * p_Quantity) + .005)
				.SumOfQuantity  = p_RS.fields("SumOfQuantity").Value
				.TotalBilled    = p_RS.fields("TotalBilled").Value
				.Invoice        = p_RS.fields("Invoice").Value
				.CostCenter     = p_RS.fields("CostCenter").Value
				.CCDescription  = p_RS.fields("CCDescription").Value
				.LastnameFirst  = p_RS.fields("LastnameFirst").Value
				.InvoiceDate    = cstr(p_RS.fields("InvoiceDate").Value)
			end with
			m_UsageDetail.Add thisUsageDetail.Id, thisUsageDetail
			p_RS.movenext
        loop
	End Function

'#############  Private Functions                           ##############


	Private Function LoadData(p_strSQL)
		dim rs
        set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getTempsDSN(whichCompany)))
 		FillFromRS(rs)
		LoadData = rs.recordcount
		rs. close
		set rs = nothing
	End Function

end class
%>
