<%
'flag to toggle using querystring or form post data
dim use_qs
if request.querystring("use_qs") = "1" then
	use_qs = true
else
	use_qs = false
end if

dim applicantid
applicantid = getParameter("applicantid")

dim jobref
jobref = getParameter("jobref")

dim dept
dept = getParameter("dept")

dim siteid
siteid = getParameter("site")

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

dim foruser
foruser = trim(request.querystring("foruser"))
if len(foruser) = 0 then
	foruser = request.form("foruser")
	if len(foruser) = 0 then
		foruser = tUser_id
	end if
end if

dim callingApp
	' callingApp = request.ServerVariables("PATH_INFO")
	callingApp = getParameter("app")
	
dim Reminders
set Reminders = new cReminders
Reminders.ItemsPerPage = 200
Reminders.Page = CInt(Request.QueryString("Page"))

if callingApp = "joborder" then

	Reminders.GetJobOrderActivities
		
else

	Reminders.GetAllAppointments

end if

dim PageNavigation
PageNavigation = Reminders.GetPageSelection()


function getParameter(p_name)
	if use_qs then
		getParameter = request.querystring(p_name)
	else
		getParameter = request.form(p_name)
	end if
end function



%>
