<%

dim is_service 

is_service = true
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true

%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #include file='checkAppointments.classes.asp' -->

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

dim foruser
foruser = trim(request.querystring("foruser"))
if len(foruser) = 0 then
	foruser = request.form("foruser")
	if len(foruser) = 0 then
		foruser = tUser_id
	end if
end if

dim Placements
set Placements = new cPlacements
Placements.ItemsPerPage = 20
Placements.Page = CInt(Request.QueryString("Page"))

Placements.GetAllAppointments

dim strAppointments

dim strComment, strNumber, strDiscuss


dim i : i = 0
for each Appointment in Placements.Appointments.Items 
	i = i + 1
	
	if len(Appointment.CustomerContact) > 0 and len(Appointment.CustomerName) > 0 then
		strComment = "Appointment with " & Appointment.CustomerContact & " @ " &  Appointment.CustomerName
	elseif len(Appointment.CustomerContact) > 0 then
		'CustomerName is empty
		strComment = "Appointment with " & Appointment.CustomerContact
	else
		strComment = "Appointment"
	end if
	
	if len(Appointment.CustomerPhone) > 0 then
		strNumber = ", contact # " & Appointment.CustomerPhone
	else
		strNumber = ""
	end if
	
	if len(Appointment.Comment) > 0 then
		strDiscuss = ", to discuss " & Appointment.Comment
	else
		strDiscuss = ""
	end if

	strAppointments = strAppointments & "" &_
		server.HTMLEncode(strComment &	" at " & Appointment.ApptDate & strNumber & strDiscuss) & "]|["
next

%>

<%

if len(strAppointments) > 2 then
	response.write left(strAppointments, len(strAppointments) - 3)
end if
	
%>

<!-- #INCLUDE VIRTUAL='/include/core/dispose_service_session.asp' -->


%>
