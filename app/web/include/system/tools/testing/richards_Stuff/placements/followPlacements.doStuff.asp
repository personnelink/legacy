<%
dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim onlyactive
select case request.querystring("onlyactive")
	case 0
		onlyactive = false
	case 1
		onlyactive = true
	case else
		onlyactive = true
end select

dim foruser : foruser = trim(request.querystring("for"))

dim Placements
set Placements = new cPlacements
Placements.ItemsPerPage = 20
Placements.Page = CInt(Request.QueryString("Page"))

Placements.GetAllPlacements

dim PageNavigation
PageNavigation = Placements.GetPageSelection()

%>
