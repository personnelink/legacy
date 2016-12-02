<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% if session("employerAuth") <> "true" then
response.redirect("/index.asp")
end if 
%>
<%
set rsUpdateProfile = Server.CreateObject("ADODB.RecordSet")
rsUpdateProfile.Open "SELECT * FROM tbl_employers WHERE empID = '" & session("empID") & "'",Connect,3,3

rsUpdateProfile("companyType") = request("companyType")
rsUpdateProfile("companyName") = ConvertString(TRIM(request("companyName")))
rsUpdateProfile("companyAgent") = ConvertString(TRIM(request("companyAgent")))
rsUpdateProfile("companyAgentTitle") = ConvertString(PCase(TRIM(request("companyAgentTitle"))))
rsUpdateProfile("addressOne") = ConvertString(TRIM(request("addressOne")))
rsUpdateProfile("addressTwo") = ConvertString(TRIM(request("addressTwo")))
rsUpdateProfile("city") = ConvertString(PCase(TRIM(request("city"))))
rsUpdateProfile("state") = request("state")
rsUpdateProfile("zipCode") = ConvertString(TRIM(request("zipCode")))
rsUpdateProfile("country") = request("country")
rsUpdateProfile("companyPhone") = ConvertString(TRIM(request("companyPhone")))
rsUpdateProfile("faxNumber") = ConvertString(TRIM(request("faxNumber")))
rsUpdateProfile("emailAddress") = ConvertString(TRIM(request("emailAddress")))
rsUpdateProfile("jobEmailAddress") = ConvertString(TRIM(request("jobEmailAddress")))
rsUpdateProfile.update		

response.redirect("/lweb/employers/registered/index.asp?who=1&?editProfileID=" & session("empID"))
%>


