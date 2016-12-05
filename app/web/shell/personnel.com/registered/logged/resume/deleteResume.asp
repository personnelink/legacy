<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL = '/includes/checkMbrAuth.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->

<%
dim rsViewRes, resCount
Set rsViewRes = Server.CreateObject("ADODB.RecordSet")
rsViewRes.CursorLocation = 3
rsViewRes.Open "SELECT * FROM tbl_resumes WHERE res_id = " & request("id") & " AND mbr_id = "& session("mbrID"),Connect

' Make sure we have a valid resume ID
resCount = rsViewRes.RecordCount
if resCount = 0 then
  response.redirect("noResume.asp?id=" & request("id"))
end if

%>
<html>
<head>
<title>Delete Resume - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="JavaScript">
<!--
function MM_goToURL() {
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
</script>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" bgcolor="#000000"> 
      <!-- #INCLUDE VIRTUAL='/includes/top_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td width="100%" valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="#EFEFEF"> 
          <td bgcolor="#5187CA"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td rowspan="2" width="216"><img src="/images/logo.gif" width="215" height="76"></td>
                <td width="100%"><img src="/images/pixel.gif" width="100%" height="72"></td>
              </tr>
              <tr> 
                <td height="4" width="100%" bgcolor="#FFFFFF"><img src="/images/pixel.gif" width="1" height="1"></td>
              </tr>
            </table>
          </td>
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_cdc.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175" bgcolor="#000000">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="1">
              <tr bgcolor="E7E7E7"> 
                <td bgcolor="E7E7E7"><a href="/index.asp" class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                    </a>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><a href="index.asp"><img src="/images/headers/resumeCenter.gif" width="328" height="48" border="0"></a></td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                            <td valign="bottom"><a href="newResume/index.asp">Build a new resume</a> &#149;<a href="../career/index.asp"> Resume Advice / Help</a> 
                            </td>
                          </tr>
                        </table>
                      </td>
                      <td valign="bottom" align="right">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td> <form action="doDeleteResume.asp" method="post">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td width="85" valign="top"><img src="/images/ico_res_warning.gif" width="74" height="66"></td>
                                  <td>
                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
									<tr>
										<td colspan="2" align="left"></td>
									</tr>
									<tr> 
                                  		<td width="20%" nowrap class="middleMenu"><strong>Title:</strong></td>
                                  		<td width="80%" class="resTitle"><strong><%=rsViewRes("res_title")%></strong></td>
                                	</tr>
                                	<tr> 
                                  		<td width="20%" class="middleMenu"><strong>Created On:</strong></td>
                                  		<td width="80%"><%=FormatDateTime(rsViewRes("res_date_created"),1)%></td>
                                	</tr>
                                	<tr> 
                                  		<td width="20%" class="middleMenu"><strong>Employer Views:</strong></td>
                                  		<td width="80%">
<% 
if CInt(rsViewRes("res_completion_flag")) <> 5 then 
response.write("<EM><STRONG><FONT color='#b22222'>Incomplete Resume!</FONT></STRONG></EM>")
 Else
response.write(rsViewRes("res_view_count"))
end if
%>										
										</td>
                                	</tr>                                      
                                      <tr> 
                                        <td width="20%" nowrap colspan="2"><font color="#2f4f4f"><strong>Permanently delete this resume?</strong></font>
                                            <input type="hidden" name="id" value="<%=request("id")%>">
                                            <input type="button" value="Cancel" onClick="MM_goToURL('parent','index.asp');return document.MM_returnValue" name="button">&nbsp;&nbsp;&nbsp; 
                                            <input type="submit" value="Delete" name="submit">
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
							  </form>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td> 
<table width="100%" border="0" cellspacing="0" cellpadding="5" bgcolor="#FFFFFF" style="border: 1px solid #EEEEEE;">
                          <tr> 
                            <td> 
							
<% if CInt(rsViewRes("res_completion_flag")) = 5 then %>							
                              <table width="100%" border="0" cellspacing="0" cellpadding="8">
                                <tr> 
                                  <td width="28%" valign="top"><strong>CONTACT 
                                    INFO:</strong></td>
                                  <td width="72%" colspan="2"><%=rsViewRes("res_first_name")%>&nbsp;<%=rsViewRes("res_last_name")%><br>
                                    <%=rsViewRes("res_address_one")%> &nbsp; &nbsp; 
                                    <br>
									<%=rsViewRes("res_address_two")%><br>
                                    <%=rsViewRes("res_city")%>, <%=rsViewRes("res_location")%> 
                                    &nbsp;<%=rsViewRes("res_zipcode")%><br>
                                    <%=rsViewRes("res_phone_number")%><br>
                                    <%=rsViewRes("res_email_address")%> <br>
                                  </td>
                                </tr>
                                <tr> 
                                  <td valign="top" width="28%"><strong>OBJECTIVE:</strong> 
                                  </td>
                                  <td width="72%" colspan="2"><%=rsViewRes("res_objective")%></td>
                                </tr>
                                <tr> 
                                  <td width="28%" valign="top"><strong>WORK 
                                    STATUS:</strong></td>
                                  <td width="36%" valign="top"> 
                                    <% if CInt(rsViewRes("res_is_eligible")) = 1 then %>
                                    <li type="square">Eligible to work in the US.</li> 
                                    <% else %>
                                    <li type="square">Not eligible to work in the US.</li> 
                                    <% end if %>
                                    <br>
                                    <% Select Case rsViewRes("res_availability")
			     Case "FP" %>
                                    <li type="square">Seeking full or part-time work.</li> 
                                    <%
				 Case "FT" %>
                                    <li type="square">Seeking full-time work.</li> 
                                    <%
				 Case "PT" %>
                                    <li type="square">Seeking part-time work.</li> 
                                    <%
				End Select %>
                                    <br>

                                    <% Select Case rsViewRes("res_date_available")
			     Case "asap" %>
                                    <li type="square">Available for work immediately.</li> 
                                    <%
				 Case "onemonth" %>
                                    <li type="square">Available for work in under one month.</li> 
                                    <%
				 Case "twomonths" %>
                                    <li type="square">Available for work in one to two months.</li> 
                                    <%
				 Case "threemonths" %>
                                    <li type="square">Available for work in three or more months.</li> 
                                    <%
			    End Select %>
                                    <br>
                                    <% Select Case CInt(rsViewRes("res_will_relocate"))
			     Case 1 %>
                                    <li type="square">Willing to relocate.</li> 
                                    <%
				 Case 0 %>
                                    <li type="square">Not willing to relocate.</li>
 			<%   End Select %>      </td>
								  <td></td>
                                </tr>
                                <tr>
                                  <td width="28%" valign="top">&nbsp;</td>
                                  <td width="36%" valign="top"><li type="square">Desired Salary: <%=rsViewRes("res_pref_salary")%></li>
                                  </td>
                                  <td width="36%" valign="top" align="left"></td>
                                </tr>
                                <tr> 
                                  <td width="28%" valign="top"><strong>EXPERIENCE:</strong></td>
                                  <td colspan="2">							  
<strong><%=rsViewRes("res_comp_job_title1")%></strong> - 
&nbsp;<%=rsViewRes("res_comp_name1")%> - 
&nbsp;<%=rsViewRes("res_comp_location1")%>
<br> 
[<%=rsViewRes("res_comp_start_date1")%> - <%=rsViewRes("res_comp_end_date1")%>]
<br>
Duties:
<%=rsViewRes("res_comp_job_duties1")%>
<br>
<br>
<strong><%=rsViewRes("res_comp_job_title2")%></strong> -
&nbsp;<%=rsViewRes("res_comp_name2")%> -
&nbsp;<%=rsViewRes("res_comp_location2")%>
<br> 
[<%=rsViewRes("res_comp_start_date2")%> - <%=rsViewRes("res_comp_end_date2")%>]
<br>
Duties: 
<%=rsViewRes("res_comp_job_duties2")%> 
<br>
<br>
<strong><%=rsViewRes("res_comp_job_title3")%></strong> -
&nbsp;<%=rsViewRes("res_comp_name3")%> - 
&nbsp;<%=rsViewRes("res_comp_location3")%>
<br> 
[<%=rsViewRes("res_comp_start_date3")%> - <%=rsViewRes("res_comp_end_date3")%>]
<br>
Duties: 
<%=rsViewRes("res_comp_job_duties3")%> </td>
                                </tr>
							
                                <tr> 
                                  <td width="28%" valign="top"><strong>SCHOOL:</strong></td>
                                  <td colspan="2">
								  <table cellspacing="0" cellpadding="0" border="0" width="80%">
<tr>
	<td><strong><%=rsViewRes("res_college_name1")%></strong></td>
	<td>Degree: <%=rsViewRes("res_college_degree1")%></td>
</tr>
<tr>
	<td><%=rsViewRes("res_college_city1")%>, <%=rsViewRes("res_college_location1")%></td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td><strong><%=rsViewRes("res_college_name2")%></strong></td>
	<td>Degree: <%=rsViewRes("res_college_degree2")%></td>
</tr>
<tr>
	<td><%=rsViewRes("res_college_city2")%>, <%=rsViewRes("res_college_location2")%></td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td><strong><%=rsViewRes("res_hs_name")%></strong></td>
	<td>
<% 
if CInt(rsViewRes("res_hs_diploma")) = 1 then 

%>
High School Diploma 
<% 
End if 
%></td>
</tr>
<tr>
	<td><%=rsViewRes("res_hs_city")%>, <%=rsViewRes("res_hs_location")%></td>
	<td>&nbsp;</td>
</tr>

								  </table>								  
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="28%" valign="top"><strong>SKILLS:</strong></td>
                                  <td colspan="2"><%=rsViewRes("res_skills")%></td>
                                </tr>
                                <tr> 
                                  <td valign="top"><strong>REFERENCES:</strong></td>
                                  <td><strong><%=rsViewRes("res_refer_name1")%></strong><br>
                                    <%=rsViewRes("res_refer_company1")%><br>
                                    <strong><%=rsViewRes("res_refer_name2")%></strong><br>
                                    <%=rsViewRes("res_refer_company2")%><br>
                                    <strong><%=rsViewRes("res_refer_name3")%></strong><br>
                                    <%=rsViewRes("res_refer_company3")%><br>
                                  </td>
                                  <td><%=rsViewRes("res_refer_phone1")%><br>
                                    <%=rsViewRes("res_refer_title1")%><br>
                                    <%=rsViewRes("res_refer_phone2")%><br>
                                    <%=rsViewRes("res_refer_title2")%><br>
                                    <%=rsViewRes("res_refer_phone3")%><br>
                                    <%=rsViewRes("res_refer_title3")%> </td>
                                </tr>
                              </table>
<%
Else
end if
%>							  
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
              <!-- #INCLUDE VIRTUAL='/includes/cdc_menu.asp' -->
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="100%" height="10" bgcolor="#5187CA"> 
      <!-- #INCLUDE VIRTUAL='/includes/bottom_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></td>
  </tr>
</table>
</body>
</html>
<%
rsViewRes.Close
Set rsViewRes = Nothing
Connect.Close
Set Connect = Nothing
%>

