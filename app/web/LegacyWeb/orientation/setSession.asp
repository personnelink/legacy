<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<%
session.Contents.RemoveAll()
session.Abandon
session("orAuth") = ""


dim tmpOrpswd,strSendBackTo	

' MUNGE LOGIN DATA & PAGE TARGETING
if request("pgOrig") = "or" then
strSendBackTo = "/orientation/index.asp"

tmpOrpswd = TRIM(request("password"))

end if


' Orientation
Set rsOrientationProfile = Server.CreateObject("ADODB.Recordset")
rsOrientationProfile.Open "SELECT orientID,password,orientCompany,orientURL,orientsuspended FROM tbl_orientation WHERE password ='" & tmpOrpswd & "'", Connect, 3, 3
Set rsOrientationCount = Connect.Execute("SELECT count(*) AS theCount FROM tbl_orientation WHERE password = '" & tmpOrpswd & "'")

if rsOrientationCount("theCount") = 0 then response.redirect("/orientation/index.asp?error=2") end if
if rsOrientationProfile("password") <> tmpOrpswd then response.redirect("/orientation/index.asp?error=2") end if
if rsOrientationProfile("orientsuspended") = TRUE then response.redirect("/orientation/index.asp?error=2") end if
session("orientID") = rsOrientationProfile("orientID")
session("orientcompany") = rsOrientationProfile("orientCompany")
session("URL") = rsOrientationProfile("orientURL")
session("orauth") = "true"

response.redirect(session("URL"))
'response.redirect("/orientation/company/index.asp")

rsOrientationProfile.Close
rsCount.Close
%>