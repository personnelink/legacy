<!-- #include file='customerusage.class.asp' -->

<%
dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim foruser : foruser = trim(request.querystring("for"))

dim CustomerUsage
set CustomerUsage = new cCustomerUsage
CustomerUsage.ItemsPerPage = 100
CustomerUsage.Page = CInt(Request.QueryString("Page"))

CustomerUsage.LoadCustomerUsage

dim PageNavigation
PageNavigation = CustomerUsage.GetPageSelection()

%>
