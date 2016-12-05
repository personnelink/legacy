<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		changePwd.asp
'		Description:	A simple form where employers may input new password
'		Created:		Monday, February 16, 2004
'		Lastmod:
'		Developer(s):	James Werrbach
'	**********************************************************************

Set rsEmployer = Server.CreateObject("ADODB.Recordset")
rsEmployer.CursorLocation = 3
rsEmployer.Open "SELECT emp_id, emp_password FROM tbl_employers WHERE emp_id =" & session("empID"),Connect
%>

<html>
<head>
<title>Change Account Password - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<SCRIPT LANGUAGE="javascript">
<!--
function checkForm()	  {

document.frmChgEmpPwd.submit_btn.disabled = true;
var isGood = true;
 
if (document.frmChgEmpPwd.p1.value.length < 3)
  {
isGood=false
mesg2 = "You have entered " + document.frmChgEmpPwd.p1.value.length + " character(s) for the password.\n"
mesg2 = mesg2 + "Please use at least 3 characters for your password.\n"
alert(mesg2);
document.frmChgEmpPwd.p1.value = "";
document.frmChgEmpPwd.p2.value = "";
document.frmChgEmpPwd.p1.focus();
document.frmChgEmpPwd.submit_btn.disabled = false;
return false;
  }  

if (document.frmChgEmpPwd.p1.value != document.frmChgEmpPwd.p2.value || document.frmChgEmpPwd.p1.value == "")
  {
isGood=false
alert("Please make sure you have entered a password and that your passwords match.");
document.frmChgEmpPwd.p1.value = "";
document.frmChgEmpPwd.p2.value = "";
document.frmChgEmpPwd.p1.focus();
document.frmChgEmpPwd.submit_btn.disabled = false;
return false;
  }
  
if ((IsBlank(document.frmChgEmpPwd.p1.value)) || (IsBlank(document.frmChgEmpPwd.p2.value)))
  {
isGood=false
alert("Your password cannot be blank.");
document.frmChgEmpPwd.p1.value = "";
document.frmChgEmpPwd.p2.value = "";
document.frmChgEmpPwd.p1.focus();
document.frmChgEmpPwd.submit_btn.disabled = false;
return false;
  }  
  
 
  if (isGood==true) {
    document.frmChgEmpPwd.submit()
  }  
}
function MM_goToURL() {
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
</SCRIPT>
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
                      <td><img src="/images/headers/accountOptions.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td width="30">&nbsp;</td>
                              <td valign="bottom" class="sideLink">Other Options: <a href="index.asp">Edit Account Information</a> | <a href="changeEmail.asp">Change E-mail Address</a></td>
                            </tr>  
                        </table>
                      </td>
                    </tr>
                  </table>
				  <br>
                  <table width="95%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="15"><img src="/images/pixel.gif" width="15" height="8"></td>
                      <td> 
                        <form name="frmChgEmpPwd" method="post" action="doChangePwd.asp">
                          <table width="75%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td colspan="2" bgcolor="#e7e7e7" align="center"><strong>Change Employer Account Password:</strong>
<% if request("confirm") = "1" then %>
<font color="#b22222"> <strong>Password Changed</strong> </font>
<% End if %>							  

								
								</td>
                            </tr>
							<tr>
								<td colspan="2">
<% if request("confirm") = "1" then %>* Remember, this change will take effect at your next log-in! 
<% End if %>

<% if request("error") = "1" then %>
<font color="#b22222"> Passwords did not match - please re-enter</font>
<% End if %>	
							
<% if request("error") = "2" then %>
<font color="#b22222"> Unable to change password - please try again</font>
<% End if %>


</td>
							</tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td align="left" class="req_label">New Password:</td>
                              <td align="left"> 
  <input type="password" name="p1" size="16" maxlength="20">
                              </td>
							 </tr>
							 <tr>
                              <td align="left" class="req_label">Confirm New Password:</td>
                              <td align="left"> 
 <input type="password" name="p2" size="16"  maxlength="20">
                              </td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center"> 
                                
                                
<input type="button" value="Save Changes" onClick="checkForm();" name="submit_btn">
&nbsp;&nbsp;
<input type="button" value="Cancel" onClick="MM_goToURL('parent','../index.asp');return document.MM_returnValue" name="button" tabindex="-1">
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
rsEmployer.Close
Set rsEmployer = Nothing
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
