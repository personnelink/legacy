<%
if session("directApply") = "1" then
response.redirect("/lweb/index2.asp?DA=1")
End If

if request("officeSelector") <> "" then
session("targetOffice") = request("officeSelector")
else
session("targetOffice") = "twin@personnel.com"
end if


' this is for requests from maidsource.net
If request("siteid") = "475" then
Dim job_wanted
job_wanted = "Janitorial - Happy Housekeepers"
End If


' Get states/provinces
Dim sqlLocation
Dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)

Dim sqlLocation2
Dim rsLocation2
sqlLocation2 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation2 = Connect.Execute(sqlLocation2)

Dim sqlLocation3
Dim rsLocation3
sqlLocation3 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation3 = Connect.Execute(sqlLocation2)

Dim sqlLocation4
Dim rsLocation4
sqlLocation4 = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation4 = Connect.Execute(sqlLocation2)
%>