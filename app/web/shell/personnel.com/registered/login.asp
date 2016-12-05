<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkMbrCookie.asp' -->
<%
'	*************************  File Description  *************************
'		FileName:		login.asp
'		Description:	Member login page
'						Sends email address and password to setSession.asp
'		Created:		Tuesday, February 17, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

if session("mbrAuth") = "true" then response.redirect("/registered/logged/index.asp") end if
%>

<html>
<head>
<title>Member Login - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<SCRIPT LANGUAGE="javascript">
function checkLogin() {
document.loginInfo.submit_btn.disabled = true;
var isGood = true;

if (IsBlank(document.loginInfo.emailAddress.value))
  {
isGood=false
mesg2 = "Please enter your email address"
alert(mesg2);
document.loginInfo.emailAddress.value = "";
document.loginInfo.emailAddress.focus();
document.loginInfo.submit_btn.disabled = false;
return false;
  }

if (IsBlank(document.loginInfo.password.value))
  {
isGood=false
alert("Please enter your password");
document.loginInfo.password.value = "";
document.loginInfo.password.focus();
document.loginInfo.submit_btn.disabled = false;
return false;
  }


    
  if (isGood==true) {
    document.loginInfo.submit()
  }  
}
</SCRIPT>
</head>

<body onLoad="javascript:document.loginInfo.emailAddress.focus();">
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
          <td bgcolor="#5187CA" width="175"><img src="/images/flare_srn_w.gif" width="175" height="76"></td>
        </tr>
        <tr bgcolor="#000000"> 
          <td> 
            <!-- #INCLUDE VIRTUAL='/includes/menu.asp' -->
          </td>
          <td width="175">&nbsp;</td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr> 
                <td> 
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="/images/headers/jobSeekerLogin.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="8"></td>
                            <td class="sideMenu" valign="bottom">&nbsp;</td>
                          </tr>
                          <tr>
                            <td width="30" class="sideMenu">&nbsp;</td>
                            <td class="sideMenu" valign="bottom">
                              <form name="loginInfo" method="post" action="setSession.asp">
                                <table width="90%" border="0" cellspacing="0" cellpadding="5" bgcolor="#ffffff">
                                  <tr> 
                                    <td colspan="3" class="redHead">
                                      <p class="smallDesc">
                                        <%if request("error") = 1 then %><img src="/images/ico_alert.gif" alt="" width="25" height="19" border="0" align="absmiddle">  
                                        <strong><font color="#b22222">Invalid login 
                                        information, please try again.</font></strong> 
                                        <%elseif request("error") = 2 then %>
                                        <strong><font color="#b22222">Your account has 
                                        been suspended.</font></strong> 
                                        <%elseif request("error") = 3 then %>
                                        <strong><font color="#b22222">You were automatically logged out due to inactivity, please log in again.</font></strong> 
                                        <% else %>
                                        <strong>Please enter your e-mail address and password.</strong> 
                                        <% end if %>
                                        <br>
                                        <br>
                                      </p>
                                      </td>
                                  </tr>
                                  <tr> 
                                    <td width="30"><img src="/images/pixel.gif" width="25" height="2"></td>
                                    <td width="18%"><strong>E-mail Address:</strong></td>
                                    <td width="82%"> 
                                      <input type="text" name="emailAddress" maxlength="50" size="26" maxlength="100">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="30"><img src="/images/pixel.gif" width="25" height="2"></td>
                                    <td width="18%"><strong>Password:</strong></td>
                                    <td width="82%"> 
                                      <input type="password" name="password" size="16" maxlength="50">
                                      &nbsp;&nbsp;
                                      <input type="button" name="submit_btn" value="Go" onClick="checkLogin();">
                                    </td>
                                  </tr>
								  <tr>
									<td width="30"><img src="/images/pixel.gif" width="25" height="2"></td>								  
								  	<td colspan="2"><input type="checkbox" name="setCookie" value="yes"><font size="1"> Remember me on this computer next time</font></td>
								  </tr>
                                  <tr> 
                                    <td width="30"><img src="/images/pixel.gif" width="25" height="2"></td>
                                    <td width="18%" align="right">&nbsp; </td>
                                    <td width="82%" class="sideMenu"><strong><a href="forgot.asp"><font size="2">Forgot your Password?</font></a></strong><br>
                                      <a href="mailto:webmaster@personnel.com?Subject=Member%20Account%20--%20Problems%20Signing%20In&body=Please%20describe%20your%20problem%20here."><font size="1">Still Having Trouble? </font></a></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3"><br>
                                    </td>
                                  </tr>
                                  <tr bgcolor="#ffffff"> 
                                    <td colspan="3" height="33"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="70%" valign="middle">
<font size="3"><strong>Not a member yet?</strong></font> <a href="newuser/index.asp"><font size="3">Register now for free!</font></a>
<br>
Register to access your personalized Career Development Center.<br> Start 
reaching for your dreams and career goals with the online resume builder, career 
resources, and other useful tools.										  
										  
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
                </td>
              </tr>
            </table>
          </td>
          <td width="175" valign="top"> 
            <!-- #INCLUDE VIRTUAL='/includes/pub_menu.asp' -->
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
Connect.Close
Set Connect = Nothing
%>
