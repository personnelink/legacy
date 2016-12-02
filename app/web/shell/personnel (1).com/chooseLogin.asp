<%
if session("mbrAuth") = "true" then
response.redirect("/registered/logged/index.asp")
end if
if session("empAuth") = "true" then
response.redirect("employers/logged/index.asp")
end if

%>
<html>
<head>
<title>www.personnel.com - Main Login</title>
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
                <td width="100%"><img src="/images/pixel.gif" width="1" height="72"></td>
              </tr>
              <tr> 
                <td height="4" width="100%" bgcolor="#FFFFFF"><img src="/images/pixel.gif" width="1" height="1"></td>
              </tr>
            </table>
          </td>
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_srn_w.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <%
		    response.write("<table width=100% border=0 cellspacing=0 cellpadding=3><tr><td>" & VBCRLF)
            response.write("<FONT COLOR=WHITE>")
            response.write("&nbsp;&nbsp;<a href='/search/index.asp' class=headmenu>Search Jobs</a>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/chooseLogin.asp' class=headmenu>Login Now!</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/registered/newuser/index.asp' class=headmenu>Post a Resume</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/employers/newuser/index.asp' class=headmenu>Post a Job</A>&nbsp;&nbsp;")
            response.write(" &#149; &nbsp;&nbsp;<A HREF='/help/index.asp' class=headmenu>First Time Users</A>&nbsp;&nbsp;")
            response.write("</font></td></tr></table>" & VBCRLF)
			%>
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top" bgcolor="E7E7E7"> 
            <!--#include virtual="/includes/pub_greybar.asp" -->
          </td>
          <td rowspan="2" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/chooseLogin.gif" width="328" height="48"></td>
                      <td class="sideMenu" valign="bottom" align="right">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="50" height="1"></td>
                            <td class="sideMenu" valign="bottom">&nbsp; </td>
                          </tr>
                        </table>
                      </td>
                      <td class="sideMenu" valign="bottom" align="right">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="35" height="1"></td>
                      <td class="sideMenu" valign="bottom"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="10">
                          <tr> 
                            <td valign="top"> 
                              <table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                  <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/registered/login.asp" class="buttons">Member 
                                    Login</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                  <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                </tr>
                              </table>
                            </td>
                            <td width="100%" valign="top"> 
<p>Job Seekers, log-in to your account and access your personalized <strong>Career Development Center</strong>.
<br>
Start reaching for your dreams and career goals: Build an online resume, search and apply for jobs, visit our available career resources, and more!
<br>
<br>
if you do not have an account you may <a href="/registered/newuser/index.asp">register as a new member</a>!
<br>
</p>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" colspan="2"> 
                              <hr noshade color="#AAAAAA" size="1">
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top"> 
                              <table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td align="left" width="10"><img src="/images/buttonL.gif" width="10" height="21"></td>
                                  <td bgcolor="#5187CA" align="center" nowrap class="buttons">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/employers/login.asp" class="buttons">Employer 
                                    Login</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                                  <td align="right" width="10"><img src="/images/buttonR.gif" width="10" height="21"></td>
                                </tr>
                              </table>
                            </td>
                            <td width="100%" valign="top">
Log in to your Employer account to access the employer <strong>Hiring Management System</strong>. 
Utilizing the powerful online tools you can fill a position quickly and 
easily with one of the many qualified Job Seekers.
<br>
<br>
if you do not have an account you may <a href="/employers/newuser/index.asp">register as an employer</a>! </td>
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
