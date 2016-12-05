<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<%

set rsResume = Server.CreateObject("ADODB.RecordSet")
rsResume.Open "SELECT * FROM resumes WHERE ID = '" & request("ID") & "'",Connect,3,3

%>

<html>
<head>
<title>Applicant Resume</title>

<link rel="stylesheet" href="http://www.personnel.com/css/default.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="5" bgcolor="#F3F3F3">
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="8">
              <tr> 
                <td width="28%" valign="top" class="titleLittle"><b>CONTACT INFO:</b></td>
                <td width="72%" colspan="2"><%=rsResume("fName")%>&nbsp;<%=rsResume("lName")%><br>
                  <%=rsResume("strAddress")%> &nbsp; &nbsp; Apt. # <%=rsResume("apt")%><br>
                  <%=rsResume("city")%>, <%=rsResume("state")%> &nbsp;<%=rsResume("zipCode")%><br>
                  <%=rsResume("phone")%><br>
                  <%=rsResume("email")%> <br>
                </td>
              </tr>
              <tr> 
                <td valign="top" width="28%" class="titleLittle"><b>OBJECTIVE:</b> 
                </td>
                <td width="72%" colspan="2"><%=rsResume("objective")%></td>
              </tr>
              <tr> 
                <td width="28%" class="titleLittle" valign="top"><b>WORK STATUS:</b></td>
                <td width="36%" valign="top"> 
                  <% if rsResume("eligible") = "yes" then %>
                  Eligible to work in the US 
                  <% else %>
                  Not eligible to work in the US 
                  <% end if %>
                  <br>
                  <% Select Case rsResume("availability")
			     Case "both" %>
                  Seeking full or part time work. 
                  <%
				 Case "fullTime" %>
                  Seeking full time work 
                  <%
				 Case "partTime" %>
                  Seeking part time work 
                  <%
				End Select %>
                  <br>
                  <br>
                </td>
                <td width="36%" valign="top"> 
                  <% Select Case rsResume("dateAvailable")
			     Case "asap" %>
                  Available for work immediately 
                  <%
				 Case "onemonth" %>
                  Available for work under one month 
                  <%
				 Case "twomonths" %>
                  Available for work one to two months 
                  <%
				 Case "threemonths" %>
                  Available for work three or more months 
                  <%
			    End Select %>
                  <br>
                  <% Select Case rsResume("relocate")
			     Case "yes" %>
                  Willing to relocate 
                  <%
				 Case "no" %>
                  Not willing to relocate <%=rsResume("salary")%> 
                  <%
 			   End Select %>
                </td>
              </tr>
              <tr> 
                <td width="28%" class="titleLittle" valign="top">&nbsp;</td>
                <td width="36%" valign="top">Requested Salary Range:<br>
                  <br>
                </td>
                <td width="36%" valign="top"> <%=rsResume("salary")%> <br>
                </td>
              </tr>
              <tr> 
                <td width="28%" class="titleLittle" valign="top"><b>EXPERIENCE:</b></td>
                <td colspan="2"><b><%=rsResume("companyJobTitle1")%></b> &nbsp;<%=rsResume("companyName1")%> 
                  &nbsp;<%=rsResume("companyLocation1")%> &nbsp;(<%=rsResume("companyStartDate1")%> 
                  - <%=rsResume("companyEndDate1")%>)<br>
                  <%=rsResume("companyJobDuties1")%><br>
                  <b><%=rsResume("companyJobTitle2")%></b> &nbsp;<%=rsResume("companyName2")%> 
                  &nbsp;<%=rsResume("companyLocation2")%> &nbsp;(<%=rsResume("companyStartDate2")%> 
                  - <%=rsResume("companyEndDate2")%>)<br>
                  <%=rsResume("companyJobDuties2")%><br>
                  <b><%=rsResume("companyJobTitle3")%></b> &nbsp;<%=rsResume("companyName3")%> 
                  &nbsp;<%=rsResume("companyLocation3")%> &nbsp;(<%=rsResume("companyStartDate3")%> 
                  - <%=rsResume("companyEndDate3")%>)<br>
                  <%=rsResume("companyJobDuties3")%> </td>
              </tr>
              <tr> 
                <td width="28%" class="titleLittle" valign="top"><b>SCHOOL:</b></td>
                <td colspan="2"><b><%=rsResume("collegeName1")%></b> &nbsp; <%=rsResume("collegeDateCompleted1")%><br>
                  <%=rsResume("collegeCity1")%>, <%=rsResume("collegeState1")%>, 
                  <%=rsResume("collegeCountry1")%><br>
                  <%=rsResume("collegeDescription1")%><br>
                  <b><%=rsResume("collegeName2")%></b> &nbsp; <%=rsResume("collegeDateCompleted2")%><br>
                  <%=rsResume("collegeCity2")%>, <%=rsResume("collegeState2")%>, 
                  <%=rsResume("collegeCountry2")%><br>
                  <%=rsResume("collegeDescription2")%><br>
                  <b><%=rsResume("hschoolName")%></b> &nbsp; <%=rsResume("hschoolCity")%>, 
                  <%=rsResume("hschoolState")%><br>
                  <% if rsResume("hschoolGraduate") = "yes" then%>
                  High School Diploma 
                  <% end if %>
                  <br>
                  <b><%=rsResume("jrhighName")%></b> &nbsp; <%=rsResume("jrhighCity")%>, 
                  <%=rsResume("hschoolState")%><br>
                  <b><%=rsResume("elementaryName")%></b> &nbsp; <%=rsResume("elementaryCity")%>, 
                  <%=rsResume("hschoolState")%> </td>
              </tr>
              <tr> 
                <td width="28%" class="titleLittle" valign="top"><b>SKILLS:</b></td>
                <td colspan="2"><%=rsResume("skills")%></td>
              </tr>
              <tr> 
                <td class="titleLittle" valign="top"><b>REFERENCES:</b></td>
                <td><b><%=rsResume("referenceName1")%></b><br>
                  <%=rsResume("referenceCompany1")%><br>
                  <b><%=rsResume("referenceName2")%></b><br>
                  <%=rsResume("referenceCompany2")%><br>
                  <b><%=rsResume("referenceName3")%></b><br>
                  <%=rsResume("referenceCompany3")%><br>
                </td>
                <td><%=rsResume("referencePhoneNumber1")%><br>
                  <%=rsResume("referenceJobTitle1")%><br>
                  <%=rsResume("referencePhoneNumber2")%><br>
                  <%=rsResume("referenceJobTitle2")%><br>
                  <%=rsResume("referencePhoneNumber3")%><br>
                  <%=rsResume("referenceJobTitle3")%> </td>
              </tr>
              <tr> 
                <td class="titleLittle" valign="top">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
