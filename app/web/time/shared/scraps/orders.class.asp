<%
class cOrder

'Private, class member variable
private m_Reference        
private m_Customer
private m_CustomerName
private m_ReportTo
private m_JobDescription
private m_WorkSite1
private m_WorkSite2
private m_EmailAddress
private m_WorkSite3
private m_JobSupervisor
private m_Memo
private m_Bill1
private m_Bill2
private m_Bill3
private m_Bill4
private m_RecordedBy
private m_JobChangedBy
private m_JobChangedDate
private m_Dispatcher
private m_NextDispatchDate	

'Order Reference Number
public property get Reference()
	Reference = m_Reference
end property
public property let Reference(p_Reference)
	m_Reference = p_Reference
end property

public property get Customer()
	 = m_Customer
end property
public property let Customer(p_Customer)
	m_Customer = p_Customer
end property

public property get CustomerName()
	CustomerName = m_CustomerName
end property
public property let CustomerName(p_CustomerName)
	m_CustomerName = p_CustomerName
end property

public property get ReportTo()
	ReportTo = m_ReportTo
end property
public property let ReportTo(p_ReportTo)
	m_ReportTo = p_ReportTo
end property

'Order Job Description
public property get JobDescription()
	JobDescription = m_JobDescription
end property
public property let JobDescription(p_JobDescription)
	m_JobDescription = p_JobDescription
end property

'Order Work Site
public property get WorkSite1()
	WorkSite1 = m_WorkSite1
end property
public property let WorkSite1(p_WorkSite1)
	m_WorkSite1 = p_WorkSite1
end property

public property get WorkSite2()
	WorkSite2 = m_WorkSite2
end property
public property let WorkSite2(p_WorkSite2)
	m_WorkSite2 = p_WorkSite2
end property

public property get WorkSite3()
	WorkSite3 = m_WorkSite3
end property
public property let (p_WorkSite3)
	m_WorkSite3 = p_WorkSite3
end property

public property get EmailAddress()
	EmailAddress = m_EmailAddress
end property
public property let EmailAddress(p_EmailAddress)
	m_EmailAddress = p_EmailAddress
end property

public property get JobSupervisor()
	JobSupervisor = m_JobSupervisor
end property
public property let JobSupervisor(p_JobSupervisor)
	m_JobSupervisor = p_JobSupervisor
end property

public property get Memo()
	Memo = m_Memo
end property
public property let (p_Memo)
	m_Memo = p_Memo
end property

public property get Bill1()
	Bill1 = m_Bill1
end property
public property let Bill1(p_Bill1)
	m_Bill1 = p_Bill1
end property

public property get Bill2()
	Bill2 = m_Bill2
end property
public property let (p_Bill2)
	m_Bill2 = p_Bill2
end property

public property get Bill3()
	Bill3 = m_Bill3
end property
public property let Bill3(p_Bill3)
	m_Bill3 = p_Bill3
end property

public property get Bill4()
	Bill4 = m_Bill4
end property
public property let Bill4(p_Bill4)
	m_Bill4 = p_Bill4
end property

public property get RecordedBy()
	RecordedBy = m_RecordedBy
end property
public property let RecordedBy(p_RecordedBy)
	m_RecordedBy = p_RecordedBy
end property

public property get JobChangedBy()
	JobChangedBy = m_JobChangedBy
end property
public property let JobChangedBy(p_JobChangedBy)
	m_JobChangedBy = p_JobChangedBy
end property

public property get JobChangedDate()
	JobChangedDate = m_JobChangedDate
end property
public property let (p_JobChangedDate)
	m_JobChangedDate = p_JobChangedDate
end property

public property get Dispatcher()
	Dispatcher = m_Dispatcher
end property
public property let Dispatcher(p_Dispatcher)
	m_Dispatcher = p_Dispatcher
end property

public property get NextDispatchDate()
	NextDispatchDate = m_NextDispatchDate
end property
public property let NextDispatchDate(p_NextDispatchDate)
	m_NextDispatchDate = p_NextDispatchDate
end property

end class

class Orders

'Private, class member variable
private m_Orders
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

'Read the current Orders
Public Property Get Orders()
    Set Orders = m_Orders
End Property

'Read the current Orders
Public Property Get PageCount()
    PageCount = m_PageCount
End Property

'set page size
Public Property Let ItemsPerPage(p_ItemsPerPage)
	m_ItemsPerPage = p_ItemsPerPage
end property

public property let Page(p_Page)
	m_Page = p_Page
end property


'#############  Public Functions ##############

	public function GetOpenOrders(p_customer)
		dim strSQL
		strSQL = "" &_
			"SELECT Orders.Customer, Customers.CustomerName, Orders.Reference, Orders.ReportTo, Orders.JobDescription, " &_
			"Orders.WorkSite1, Orders.WorkSite2, Orders.EmailAddress, Orders.WorkSite3, Orders.JobSupervisor, Orders.Memo, Orders.Bill1, " &_
			"Orders.Bill2, Orders.Bill3, Orders.Bill4, Orders.RecordedBy, Orders.JobChangedBy, Orders.JobChangedDate, Orders.Dispatcher, " &_
			"Orders.NextDispatchDate, OtherOrders.Def1, OtherOrders.Def2 " &_
			"FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) AND (Customers.Customer = Orders.Customer)) " &_
			"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
			"WHERE (((Orders.JobStatus)=3) AND Customer='" & p_customer & "') " &_
			"ORDER BY Orders.JobChangedDate DESC;"
		GetOpenOrders = LoadOrderData (strSQL)
	end function
	
	public function GetUnfilledOrders(p_customer)
		dim strSQL
		strSQL = "" &_
			"SELECT Orders.Customer, Customers.CustomerName, Orders.Reference, Orders.ReportTo, Orders.JobDescription, " &_
			"Orders.WorkSite1, Orders.WorkSite2, Orders.EmailAddress, Orders.WorkSite3, Orders.JobSupervisor, Orders.Memo, Orders.Bill1, " &_
			"Orders.Bill2, Orders.Bill3, Orders.Bill4, Orders.RecordedBy, Orders.JobChangedBy, Orders.JobChangedDate, Orders.Dispatcher, " &_
			"Orders.NextDispatchDate, OtherOrders.Def1, OtherOrders.Def2 " &_
			"FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) AND (Customers.Customer = Orders.Customer)) " &_
			"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
			"WHERE (((Orders.JobStatus)<2) AND Customer='" & p_customer & "') " &_
			"ORDER BY Orders.JobChangedDate DESC;"
		GetUnfilledOrders = LoadOrderData (strSQL)
	end function
	
	public function GetClosedOrders(p_customer)
		dim strSQL
		strSQL = "" &_
			"SELECT Orders.Customer, Customers.CustomerName, Orders.Reference, Orders.ReportTo, Orders.JobDescription, " &_
			"Orders.WorkSite1, Orders.WorkSite2, Orders.EmailAddress, Orders.WorkSite3, Orders.JobSupervisor, Orders.Memo, Orders.Bill1, " &_
			"Orders.Bill2, Orders.Bill3, Orders.Bill4, Orders.RecordedBy, Orders.JobChangedBy, Orders.JobChangedDate, Orders.Dispatcher, " &_
			"Orders.NextDispatchDate, OtherOrders.Def1, OtherOrders.Def2 " &_
			"FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) AND (Customers.Customer = Orders.Customer)) " &_
			"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
			"WHERE (((Orders.JobStatus)<2) AND Customer='" & p_customer & "') " &_
			"ORDER BY Orders.JobChangedDate DESC;"
		GetClosedOrders = LoadOrderData (strSQL)
	end function
	
	public function GetClosedOrdersNeedingTime(p_customer)
		dim strSQL
		strSQL = "" &_
			"SELECT Orders.Customer, Customers.CustomerName, Orders.Reference, Orders.ReportTo, Orders.JobDescription, " &_
			"Orders.WorkSite1, Orders.WorkSite2, Orders.EmailAddress, Orders.WorkSite3, Orders.JobSupervisor, Orders.Memo, Orders.Bill1, " &_
			"Orders.Bill2, Orders.Bill3, Orders.Bill4, Orders.RecordedBy, Orders.JobChangedBy, Orders.JobChangedDate, Orders.Dispatcher, " &_
			"Orders.NextDispatchDate, OtherOrders.Def1, OtherOrders.Def2 " &_
			"FROM (Customers INNER JOIN Orders ON (Customers.Customer = Orders.Customer) AND (Customers.Customer = Orders.Customer)) " &_
			"LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
			"WHERE (((Orders.JobStatus)<2) AND Customer='" & p_customer & "') " &_
			"ORDER BY Orders.JobChangedDate DESC;"
		GetClosedOrdersNeedingTime = LoadOrderData (strSQL)
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

'#############  Private Functions ##############

    'Takes a recordset
    'Fills the object's properties using the recordset
    private function FillOrdersFromRS(p_RS)
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
				.Reference        = p_RS.fields("Reference").Value
				.Customer         = p_RS.fields("Customer").Value
				.CustomerName     = p_RS.fields("CustomerName").Value
				.ReportTo         = p_RS.fields("ReportTo").Value
				.JobDescription   = p_RS.fields("JobDescription").Value
				.WorkSite1        = p_RS.fields("WorkSite1").Value
				.WorkSite2        = p_RS.fields("WorkSite2").Value
				.EmailAddress     = p_RS.fields("EmailAddress").Value
				.WorkSite3        = p_RS.fields("WorkSite3").Value
				.JobSupervisor    = p_RS.fields("JobSupervisor").Value
				.Memo             = p_RS.fields("Memo").Value
				.Bill1            = p_RS.fields("Bill1").Value
				.Bill2            = p_RS.fields("Bill2").Value
				.Bill3            = p_RS.fields("Bill3").Value
				.Bill4            = p_RS.fields("Bill4").Value
				.RecordedBy       = p_RS.fields("RecordedBy").Value
				.JobChangedBy     = p_RS.fields("JobChangedBy").Value
				.JobChangedDate   = p_RS.fields("JobChangedDate").Value
				.Dispatcher       = p_RS.fields("Dispatcher").Value
				.NextDispatchDate = p_RS.fields("NextDispatchDate").Value
			end with
			m_Orders.Add thisOrder.Reference, thisOrder
			
            p_RS.movenext
        loop
    End Function

    Private Function LoadOrderData(p_strSQL)
        dim rs
        set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getTempsDSN(whichCompany)))
        FillOrdersFromRS(rs)
        LoadOrderData = rs.recordcount
        rs. close
        set rs = nothing
    End Function

end class
%>
