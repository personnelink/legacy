<%Option Explicit%>

<%

session("add_css") = "./timeArchive.css"
session("required_user_level") = 256 'userLevelSupervisor
session("window_page_title") = "Time Archive - Personnel Plus"

dim formAction
formAction = request.form("formAction")
if formAction = "submit" then session("no_header") = true

dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 14) 
end if

toDate = Request.QueryString("toDate") 
if isDate(toDate) = false then 
	toDate = request.form("toDate") 
	if isDate(toDate) = false then toDate = CStr(Date() + 1)
end if

%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE FILE='timeArchive.do.vb' -->
<!-- #INCLUDE FILE='timeArchive.html' -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
