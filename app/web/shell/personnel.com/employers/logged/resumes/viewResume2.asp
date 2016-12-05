<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->

<%
dim rsViewRes, resCount
dim rsJobData, sqlJobData

Set rsViewRes = Server.CreateObject("ADODB.RecordSet")
rsViewRes.CursorLocation = 3
rsViewRes.Open "SELECT * FROM tbl_resumes WHERE res_id = " & request("id"),Connect

' Make sure we have a valid resume ID
resCount = rsViewRes.RecordCount
if resCount = 0 then
  response.redirect("noResume.asp?id=" & request("id"))
end if

' Insert HTML line breaks
dim txtResDesc, txtResBody
txtResDesc = Replace(rsViewRes("res_description"),vbCrLf,"<BR>")
txtResBody = Replace(rsViewRes("res_body"),vbCrLf,"<BR>")

' Nab our job posting data
sqlJobData = "SELECT job_id,job_title,job_number,job_date_created FROM tbl_jobs WHERE job_id =" & request.querystring("jid")
Set rsJobData = Connect.Execute(sqlJobData)

%>

<html>
<head>
<title><%=rsViewRes("res_last_name")%>, <%=rsViewRes("res_first_name")%> - View Applicant Resume - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="JavaScript" type="text/javascript">
<!--
function openWin() {
	window.open("/employers/logged/common/printView2.asp?id=<%=request("id")%>&jid=<%=request.QueryString("jid")%>&d=<%=request("d")%>", "printView", "toolbar=1,location=0,directories=0,status=0,menubar=yes,scrollbars=yes,resizable=yes,width=700,height=600");
}
//-->
</script>
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
                <td bgcolor="E7E7E7"> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/includes/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><a href="index.asp"><img src="/images/headers/recentApplicants.gif" width="328" height="48" border="0"></a></td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                            <td valign="bottom"> &nbsp;</td>
                          </tr>
                        </table>
                      </td>
                      <td class="sideMenu" valign="bottom" align="right">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
                      <td width="100%"> 
                        <table width="100%" border="0" cellspacing="3" cellpadding="0">
                          <tr> 
                            <td width="50" valign="top"><img src="/images/resumeIconLarge.gif" width="37" height="42" border="0"></td>
                            <td colspan="3"> 
                              <table border="0" cellspacing="3" cellpadding="0" width="100%">	
                                <tr> 
                                  <td width="25%" class="middleMenu"><strong>Postion Applied for:</strong></td>
                                  <td width="75%"><%=rsJobData("job_title")%> &nbsp;(Job #<%=rsJobData("job_number")%>)</td>
                                </tr>							  
                                <tr> 
                                  <td width="25%" class="middleMenu"><strong>Applicant Name:</strong></td>
                                  <td width="75%" class="resTitle"><%=rsViewRes("res_first_name")%>&nbsp;<%=rsViewRes("res_last_name")%></td>
                                </tr>							  						  					
                                <tr> 
                                  <td width="25%" nowrap class="middleMenu" valign="top"><strong>Resume Title:</strong></td>
                                  <td width="75%" class="resTitle"><%=rsViewRes("res_title")%></td>
                                </tr>

                                <tr> 
                                  <td width="25%" class="middleMenu"><strong>Application Date:</strong></td>
                                  <td width="75%">
<%=request("d")%>
									</td>
                                </tr>
                                <tr> 
                                  <td width="25%" class="middleMenu"><strong>Contact Options:</strong></td>
                                  <td width="75%"><a href="mailto:<%=rsViewRes("res_email_address")%>"><img src="/images/mail.gif" alt="" width="18" height="18" border="0" align="absmiddle"></a> <a href="mailto:<%=rsViewRes("res_email_address")%>">Email Applicant</a></td>
                                </tr>							
                              </table>
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
                              <table width="100%" border="0" cellspacing="0" cellpadding="8">
<% IF TRIM(rsViewRes("res_description")) <> "" then %>							  
                                <tr> 
                                  <td width="28%" valign="top"><strong>DESCRIPTION / COVER LETTER:</strong></td>
                                  <td width="72%" colspan="2" valign="top">


<% response.write(txtResDesc) %>

                                  </td>
                                </tr>
<% End if %>								

                                <tr> 
                                  <td width="28%" valign="top"><strong>APPLICANT WORK 
                                    STATUS:</strong></td>
                                  <td width="72%" valign="top"> 
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
                                  <td width="72%" valign="top"><li type="square">Desired Salary:  
<% if TRIM(rsViewRes("res_pref_salary")) = "" then response.write("<EM>Not Provided</EM>") end if%>
<% if TRIM(rsViewRes("res_pref_salary")) <> "" then response.write(rsViewRes("res_pref_salary")) end if%>
</li>
                                  </td>
                                  <td></td>
                                </tr>
                                <tr> 
                                  <td width="28%" valign="top"><strong>APPLICANT RESUME:</strong></td>
                                  <td colspan="2"><a href="#" onClick="openWin();"><img src="/images/print.gif" alt="" width="18" height="18" border="0" align="texttop"></a> <a href="#" onClick="openWin();">Printer-Friendly Version</a>

<!--
<img src="/images/ico_dl.gif" alt="" width="17" height="17" border="0" align="texttop"> <a href="">Save As File</a>
-->
								 </td>
                                </tr>								
								<tr>
									<td colspan="3">
<% response.write(txtResBody) %>	
								
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
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
              <!-- #INCLUDE VIRTUAL='/includes/hms_menu.asp' -->
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
Set rsJobData = Nothing
Connect.Close
Set Connect = Nothing
%>
