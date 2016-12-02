<!-- #INCLUDE VIRTUAL='/lweb/inc/employerAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->

<%
set rsResume = Server.CreateObject("ADODB.Recordset")
rsResume.Open "SELECT * FROM tbl_resumes WHERE resID='" & request("id") & "'",Connect,3,3
%>

<html>
<head>
<title>View Your Resume</title>
<!-- #INCLUDE VIRTUAL='/lweb/inc/meta.inc' -->

</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="100%" bgcolor="#000000"> 
      <!-- #INCLUDE VIRTUAL='/lweb/inc/top_menu.asp' -->
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
            <!-- #INCLUDE VIRTUAL='/lweb/inc/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="E7E7E7"> 
                <td> 
                  <p class="navLinks"> 
                    <!-- #INCLUDE VIRTUAL='/lweb/inc/textNav.asp' -->
                  </p>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="file://///primary/img/headers/applicantManager.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="file://///primary/img/pixel.gif" width="30" height="1"></td>
                      <td width="100%"> 
                        <table width="100%" border="0" cellspacing="3" cellpadding="0">
                          <tr> 
                            <td width="50" valign="top"><img src="file://///primary/img/resumeIconLarge.gif" width="37" height="42" border="0"></td>
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
                            <td bgcolor="#FFFFFF" align="center" width="33%">
                              <%rsResume("hitCount") = rsResume("hitCount") + 1
rsResume.Update
%>
                            </td>
                          </tr>
                          <tr> 
                            <td bgcolor="#FFFFFF" colspan="4">
                              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                <tr> 
                                  <td nowrap>&nbsp;&nbsp;<a href="/public/resumes/<%=rsResume("fileName")%>"><img src="file://///primary/img/resumeIconSmall.gif" width="16" height="20" border="0">&nbsp;</a>&nbsp;</td>
                                  <td width="99%"><b>Click to view attached resume.</b></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="file://///primary/img/pixel.gif" width="30" height="8"></td>
                      <td bgcolor="E7E7E7"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="10">
                          <tr> 
                            <td valign="top" width="28%" class="titleLittle"><b>OBJECTIVE:</b></td>
                            <td width="72%" colspan="2"><%=rsResume("objective")%></td>
                          </tr>
						  <% if rsResume("skills") <> "" then %>
                          <tr> 
                            <td width="28%" class="titleLittle" valign="top"><b>SKILLS:</b></td>
                            <td colspan="2"><%=rsResume("skills")%></td>
                          </tr>
						  <% end if %>
						  <% if rsResume("description") <> "" then %>
                          <tr> 
                            <td class="titleLittle" valign="top"><b>DESCRIPTION:</b></td>
                            <td colspan="2"><%=rsResume("description")%></td>
                          </tr>
						  <% end if %>
						  <% if rsResume("salary") <> "" then %>
                          <tr> 
                            <td class="titleLittle" valign="top"><b>EXPECTED SALARY:</b></td>
                            <td colspan="2"><%=rsResume("salary")%> </td>
                          </tr>
						  <% end if %>
                          <tr bgcolor="#FFFFFF"> 
                            <td class="titleLittle" valign="top" colspan="3">&nbsp; 
                            </td>
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
            <!-- #INCLUDE VIRTUAL='/lweb/inc/hms_menu.asp' -->
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="100%" height="10" bgcolor="#5187CA"> 
      <!-- #INCLUDE VIRTUAL='/lweb/inc/bottom_menu.asp' -->
    </td>
  </tr>
  <tr> 
    <td height="10" class="legal"><!-- #INCLUDE VIRTUAL='/lweb/inc/copyright.inc' --></td>
  </tr>
</table>
</body>
</html>
