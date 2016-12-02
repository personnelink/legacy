<!-- #INCLUDE VIRTUAL = '/inc/employerAuth.asp' -->
<!-- #INCLUDE VIRTUAL = '/inc/dbconn.asp' -->

<%
set rsResume = Server.CreateObject("ADODB.Recordset")
rsResume.Open "SELECT * FROM tbl_resumes WHERE resID='" & request("id") & "'",Connect,3,3
%>

<html>
<head>
<title>View Your Resume</title>
<!-- #INCLUDE VIRTUAL = '/inc/meta.inc' -->

</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" bgcolor="#000000"> 
      <!-- #INCLUDE VIRTUAL='/inc/top_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td width="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="EFEFEF"> 
          <td bgcolor="#5187CA"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td rowspan="2" width="216"><img src="/img/logo.gif" width="215" height="76"></td>
                <td width="100%"><img src="/img/pixel.gif" width="100%" height="72"></td>
              </tr>
              <tr> 
                <td height="4" width="100%" bgcolor="#FFFFFF"><img src="/img/pixel.gif" width="1" height="1"></td>
              </tr>
            </table>
          </td>
          <td bgcolor="#5187CA" width="175"><img src="/img/flare_hms.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/inc/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="E7E7E7"> 
                <td> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/inc/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="../../../img/headers/applicantManager.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="../../../img/pixel.gif" width="30" height="1"></td>
                      <td width="100%"> 
                        <table width="100%" border="0" cellspacing="3" cellpadding="0">
                          <tr> 
                            <td width="50" valign="top"><img src="../../../img/resumeIconLarge.gif" width="37" height="42" border="0"></td>
                            <td colspan="3"> 
                              <table border="0" cellspacing="3" cellpadding="0" width="100%">
                                <tr> 
                                  <td width="20%" nowrap><b>Resume Title:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
                                  <td class="sideMenu" width="80%"><%=rsResume("Title")%></td>
                                </tr>
                                <tr> 
                                  <td width="20%" nowrap><b>Creation Date:</b></td>
                                  <td class="sideMenu" width="80%"><font size="1"><i><%=FormatDateTime(rsResume("dateCreated"),1)%></i></font></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td bgcolor="#FFFFFF" width="50">&nbsp;</td>
                            <td bgcolor="#FFFFFF" align="center" width="33%">&nbsp;</td>
                            <td bgcolor="#FFFFFF" align="center" width="33%">&nbsp;</td>
                            <td bgcolor="#FFFFFF" align="center" width="33%">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="../../../img/pixel.gif" width="30" height="8"></td>
                      <td bgcolor="E7E7E7"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="10">
                          <tr> 
                            <td width="28%" valign="top" class="titleLittle"><b>CONTACT 
                              INFO:</b></td>
                            <td width="72%" colspan="2"><%=rsResume("firstName")%>&nbsp;<%=rsResume("lastName")%><br>
                              <%=rsResume("strAddress")%> <%=rsResume("strAddress")%>&nbsp; &nbsp; Apt. # 
                              <%=rsResume("apt")%><br>
                              <%=rsResume("city")%>, <%=rsResume("state")%> &nbsp;<%=rsResume("zipCode")%><br>
                              <%=rsResume("phone")%><br>
                              <%=rsResume("email")%> <br>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" width="28%" class="titleLittle"><b>OBJECTIVE:</b></td>
                            <td width="72%" colspan="2"><%=rsResume("objective")%></td>
                          </tr>
                          <tr> 
                            <td width="28%" class="titleLittle" valign="top"><b>WORK 
                              STATUS:</b></td>
                            <td width="36%"> 
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
                            </td>
                            <td width="36%"> 
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
                              Not willing to relocate 
                              <%
 			   End Select %>
                            </td>
                          </tr>
                          <tr> 
                            <td width="28%" class="titleLittle" valign="top"><b>EXPERIENCE:</b></td>
                            <td colspan="2"><b><%=rsResume("companyJobTitle1")%></b> 
                              &nbsp;<%=rsResume("companyName1")%> &nbsp;<%=rsResume("companyLocation1")%> 
                              &nbsp;(<%=rsResume("companyStartDate1")%> - <%=rsResume("companyEndDate1")%>)<br>
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
                            <td colspan="2"><b><%=rsResume("collegeName1")%></b> 
                              &nbsp; <%=rsResume("collegeDateCompleted1")%><br>
                              <%=rsResume("collegeCity1")%>, <%=rsResume("collegeState1")%>, 
                              <%=rsResume("collegeCountry1")%><br>
                              <%=rsResume("collegeDescription1")%><br>
                              <b><%=rsResume("collegeName1")%></b> &nbsp; <%=rsResume("collegeDateCompleted1")%><br>
                              <%=rsResume("collegeCity1")%>, <%=rsResume("collegeState1")%>, 
                              <%=rsResume("collegeCountry1")%><br>
                              <%=rsResume("collegeDescription1")%><br>
                              <b><%=rsResume("hschoolastName")%></b> &nbsp; <%=rsResume("hschoolCity")%>, 
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
                            <td class="titleLittle" valign="top"> 
                              <%rsResume("hitCount") = rsResume("hitCount") + 1
rsResume.Update
%>
                            </td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p></td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/inc/hms_menu.asp' -->
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="100%" height="10" bgcolor="#5187CA"> 
      <!-- #INCLUDE VIRTUAL='/inc/bottom_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/inc/copyright.inc' --></td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
