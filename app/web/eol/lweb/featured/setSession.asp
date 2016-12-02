<%
session.Contents.RemoveAll()
session.Abandon
session("co") = ""
session("featureURL") = ""
session("featureHome") = ""
%>
<!-- INCLUDE VIRTUAL='/lweb/inc/Conn.inc' -->
<%
dim tmpUserName,tmpPassWord,strSendBackTo	
' MUNGE LOGIN DATA & PAGE TARGETING
tmpCompany = TRIM(request("co"))

response.write(tmpCompany)

' Featured Company
Set rsFeaturedProfile = Server.CreateObject("ADODB.Recordset")
rsFeaturedProfile.Open "SELECT featureID,featureCompany,featureURL,featureHome,featureCo FROM tbl_featured WHERE featureCo ='" & tmpCompany & "'", Connect, 3, 3

response.write(rsFeaturedProfile("featureID"))
response.write(rsFeaturedProfile("featureCo"))
response.write(rsFeaturedProfile("featureCompany"))
response.write(rsFeaturedProfile("featureURL"))
response.write(rsFeaturedProfile("featureHome"))
response.write(tmpCompany)

	if rsFeaturedProfile("featureCo") <> tmpCompany then response.redirect("/lweb/index2.asp?#applicant") end if
	session("featureID") = rsFeaturedProfile("featureID")
	session("featureCompany") = rsFeaturedProfile("featureCompany")
	session("featureURL") = rsFeaturedProfile("featureURL")
	session("featureHome") = rsFeaturedProfile("featureHome")
	session("featureCo") = rsFeaturedProfile("featureCo")
	
	setURL = TRIM(session("featureURL"))
		
	response.redirect(setURL)

response.write(session("featureID"))
response.write(session("featureCompany"))
response.write(session("featureURL"))
response.write(session("featureHome"))
response.write(session("featureCo"))

rsFeaturedProfile.Close
%><!--a href="<%=session("featureURL")%>">click here</a-->