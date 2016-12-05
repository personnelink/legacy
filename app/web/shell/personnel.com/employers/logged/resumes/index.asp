<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->

<%
set rsResumes = Server.CreateObject("ADODB.RecordSet")
rsResumes.CursorLocation = 3
rsResumes.Open "SELECT app_id, job_id, res_id, mbr_id, emp_id, app_is_deleted, app_date_created FROM tbl_applications WHERE emp_id = " & session("empID") & " AND app_is_deleted = 0 ORDER BY app_date_created DESC",Connect,3,3
%>

<html>
<head>
<title>Manage Your Job Applications - www.personnel.com</title>
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_hms.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#E7E7E7"> 
                <td> 
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
                      <td><img src="/images/headers/applicantManager.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td> 
                        <table width="90%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td colspan="2">You have received <strong><%=rsResumes.RecordCount%></strong> 
                              job application(s).</td>
                          </tr>
                          <tr bgcolor="#DDDDDD"> 
                            <td bgcolor="#FFFFFF" colspan="2">&nbsp;</td>
                          </tr>
<%
set rsViewResume = Server.CreateObject("ADODB.RecordSet")
rsViewResume.CursorLocation = 3
set rsJobList = Server.CreateObject("ADODB.RecordSet")
rsJobList.CursorLocation = 3
' loop through all applications and pull job and resume data
do until rsResumes.eof
rsJobList.Open "SELECT * FROM tbl_jobs WHERE job_id = " & rsResumes("job_id"),Connect,3,3
rsViewResume.Open "SELECT * FROM tbl_resumes WHERE res_id = " & rsResumes("res_id"),Connect,3,3 
%>
                          <tr bgcolor="E7E7E7"> 
                            <td width="65%"> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td>Application For: <strong><%=rsJobList("job_title")%></strong>
                                  </td>
                                  <td align="right"><a href="/employers/logged/resumes/doDelete.asp?id=<%=rsResumes("app_id")%>">Delete</a></td>
                                </tr>
                              </table>
                            </td>
                            <td width="25%" align="right">Job # <%=rsJobList("job_number")%> 
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> 
                            <td colspan="2"> 
<p>
<strong>Date Received:</strong> <%=FormatDateTime(rsResumes("app_date_created"),1)%>
<br>

<% if rsViewResume("res_filename") = "empty" then %>
<strong>From:</strong>
 <a href="viewResume.asp?id=<%=rsViewResume("res_id")%>&jid=<%=rsJobList("job_id")%>&d=<%=rsResumes("app_date_created")%>"><%=rsViewResume("res_first_name")%>&nbsp;<%=rsViewResume("res_last_name")%></a>
<br>
<strong>Resume Title:</strong> <a href="viewResume.asp?id=<%=rsViewResume("res_id")%>&jid=<%=rsJobList("job_id")%>&d=<%=rsResumes("app_date_created")%>"><%=rsViewResume("res_title")%></a>
<br>
<strong>Objective:</strong> <%=rsViewResume("res_objective")%>
  <% Else %>
<strong>From:</strong>  
<a href="viewResume2.asp?id=<%=rsViewResume("res_id")%>&jid=<%=rsJobList("job_id")%>&d=<%=rsResumes("app_date_created")%>"><%=rsViewResume("res_first_name")%>&nbsp;<%=rsViewResume("res_last_name")%></a>
<br>   
<strong>Resume Title:</strong> <a href="viewResume2.asp?id=<%=rsViewResume("res_id")%>&jid=<%=rsJobList("job_id")%>&d=<%=rsResumes("app_date_created")%>"><%=rsViewResume("res_title")%></a>
<br>
<%
if TRIM(rsViewResume("res_description")) <> "" then 
response.write("Description:")
response.write(rsViewResume("res_description"))
end if
%>
<% End if %>
</p>
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF"> 
                            <td colspan="2">&nbsp;</td>
                          </tr>
<%
	rsJobList.Close
    rsViewResume.Close
	rsResumes.MoveNext
  loop
%>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
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
<%
rsResumes.Close
Set rsResumes = Nothing
Set rsJobList = Nothing
Set rsViewResume = Nothing
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
