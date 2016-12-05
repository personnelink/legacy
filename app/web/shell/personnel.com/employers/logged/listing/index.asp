<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<%
'	*************************  File Description  *************************
'		FileName:		index.asp
'		Description:	Job Listings Manager for Employers - Main Page
'		Created:		Monday, February 16, 2004
'		LastMod:		Monday, February 16, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

dim rsCount, sqlCount, rsList, sqlList, numJobs


sqlCount = "SELECT count(emp_id) as number FROM tbl_jobs WHERE emp_id= " & session("empID") & " AND job_is_deleted = 0"
sqlList = "SELECT job_id, emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description FROM tbl_jobs WHERE emp_id= " & session("empID") & " AND job_is_deleted = 0 ORDER BY job_date_created DESC"

Set rsCount = Connect.Execute(sqlCount)
numJobs = rsCount("number")
Set rsCount = Nothing

if numJobs > 0 then
  Set rsList = Server.CreateObject("ADODB.RecordSet")
  rsList.CursorLocation = 3
  rsList.Open(sqlList),Connect
end if
%>

<html>
<head>
<title>Job Listings Manager - www.personnel.com</title>
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
        <tr bgcolor="EFEFEF"> 
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
              <tr bgcolor="E7E7E7"> 
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
                      <td><img src="/images/headers/jobListingsManager.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu">&nbsp;</td>
                            <td class="sideMenu" valign="bottom">
                              <table border="0" cellspacing="13" cellpadding="0">
                                <tr align="center"> 
                                  <td> 
                                    <table border="0" cellspacing="0" cellpadding="0">
                                      <tr> 
                                        <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                        <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a href="newJob.asp" class="buttons">Post 
                                          A Job Listing</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                                        </td>
                                        <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td> 
                                    <table border="0" cellspacing="0" cellpadding="0">
                                      <tr> 
                                        <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                        <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/search/index.asp"><font color="#FFFFFF">Search 
                                          Jobs</font></a> &nbsp;&nbsp;&nbsp;&nbsp; 
                                        </td>
                                        <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                        </tr>
								  
                                    </table>
                                  </td>
								  <td><strong>You currently have 
                              <%=numJobs%> job(s) online.</strong></td>
                                </tr>								
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="10"><img src="/images/pixel.gif" width="10" height="8"></td>
                      <td>
                        <table width="95%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
                          <% if numJobs > 0 then %>
						  <tr>
						    <td width="100%">
							  <table border="0" cellspacing="0" cellpadding="3" width="100%" style="border: 1px solid #000000;">
							  <tr>
							     <td width="75%" class="empJobMgrHead"><strong>&nbsp;Job Title</strong></td>
							     <td width="10%" class="empJobMgrHead" align="left"><strong>Posted</strong></td>								 
							     <td width="10%" class="empJobMgrHead" align="center"><strong>ID #</strong></td>
							     <td width="5%" class="empJobMgrHead"><strong>Hits</strong></td>								  
							  </tr>
							  </table>							  
							</td>
						  </tr>						  
                          <% do until rsList.eof %>
                          <tr>
						    <td width="100%">
							  <table border="0" cellspacing="0" cellpadding="3" width="100%" style="border: 1px solid #000000;">
							  <tr>
							     <td class="empJobMgrList" bgcolor="#e7e7e7" width="75%"><strong><%=rsList("job_title")%></strong></td>
							     <td class="empJobMgrList" bgcolor="#e7e7e7" width="10%" align="left"><%=FormatDateTime(rsList("job_date_created"),2)%></td>								 
							     <td class="empJobMgrList" bgcolor="#e7e7e7" width="10%" align="center"><%=rsList("job_number")%></td>
							     <td class="empJobMgrList" bgcolor="#e7e7e7" width="5%" align="right"><%=rsList("job_view_count")%>&nbsp;</td>								  
							  </tr>
                          	  <tr>
						    	 <td bgcolor="#fefefe" colspan="4" class="empJobMgrList" width="100%" align="left"><a href="viewJob.asp?id=<%=rsList("job_id")%>">View 
                              Job</a> | <a href="editJob.asp?id=<%=rsList("job_id")%>">Edit 
                              Job</a> | <a href="deleteJob.asp?id=<%=rsList("job_id")%>">Delete 
                              Job</a>
								 </td>
                          	  </tr>							  
							  </table>							  
							</td>						
                          </tr>


<%
rsList.MoveNext
loop
rsList.Close
Set rsList = Nothing
End if 
%>
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
<%

Connect.Close
Set Connect = Nothing
%>
</body>
</html>
