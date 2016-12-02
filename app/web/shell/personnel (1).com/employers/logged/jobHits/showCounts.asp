<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookies.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		showCounts.asp
'		Description:	Shows the number of so-called hit counts for each job_id that the Employer has created
'		Created:		Monday, February 16, 2004
'		LastMod:
'		Developer(s):	James Werrbach
'	**********************************************************************
dim rsViewCount, sqlViewCount
sqlViewCount = "SELECT job_id, job_title, job_view_count FROM listings WHERE emp_id= " & session("empID")
' set rsViewCount = Server.CreateObject("ADODB.RecordSet")
Set rsViewCount = Connect.Execute(sqlViewCount)

dim jobTitle 			:	job_title = rsViewCount("job_title")
dim numViewCount 		:	numViewCount = rsViewCount("job_view_count")

%>

<html>
<head>
<title>Job Hit Counts - www.personnel.com</title>
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
                      <td><img src="/images/headers/jobHitCounter.gif" width="328" height="48"></td>
                    </tr>
                  </table>
                  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30"><img src="/images/pixel.gif" width="30" height="8"></td>
                      <td> 
                        <table width="90%" border="0" cellspacing="0" cellpadding="5">
                          <tr> 
                            <td width="41%"><b>Job Title</b></td>
                            <td width="59%"><b>Hit Count</b></td>
                          </tr>
                          <% do until rsViewCount.eof %>
                          <tr> 
                            <td width="41%"><%=jobTitle%></td>
                            <td width="59%"><%=numViewCount%></td>
                          </tr>
                          <%
  rsViewCount.MoveNext
  loop
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
</body>
</html>
