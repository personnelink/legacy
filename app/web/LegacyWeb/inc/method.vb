<%
if session("directApply") = "1" then
response.redirect("/index2.asp?DA=1")
end if

if request("officeSelector") <> "" then
session("targetOffice") = request("officeSelector")
else
session("targetOffice") = "twin@personnel.com"
end if


' this is for requests from maidsource.net
if request("siteid") = "475" then
dim job_wanted
job_wanted = "Janitorial - Happy Housekeepers"
end if


' Get states/provinces
dim sqlLocation
dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)

dim sqlLocation2
dim rsLocation2
sqlLocation2 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation2 = Connect.Execute(sqlLocation2)

dim sqlLocation3
dim rsLocation3
sqlLocation3 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation3 = Connect.Execute(sqlLocation2)

dim sqlLocation4
dim rsLocation4
sqlLocation4 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation4 = Connect.Execute(sqlLocation2)
%>