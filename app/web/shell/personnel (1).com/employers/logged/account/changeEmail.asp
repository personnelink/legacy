<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		changeEmail.asp
'		Description:	A simple form where employers may input a new primary Email Address
'		Created:		Monday, March 8, 2004
'		Lastmod:
'		Developer(s):	James Werrbach
'	**********************************************************************

Set rsEmployer = Server.CreateObject("ADODB.Recordset")
rsEmployer.CursorLocation = 3
rsEmployer.Open "SELECT emp_id, emp_email_address FROM tbl_employers WHERE emp_id =" & session("empID"),Connect
%>

<html>
<head>
<title>Change Email Address - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<SCRIPT LANGUAGE="javascript">
<!--
function checkForm()	  {

document.frmChgEmpEmail.submit_btn.disabled = true;
var isGood = true;
  
if (document.frmChgEmpEmail.e1.value != document.frmChgEmpEmail.e2.value || document.frmChgEmpEmail.e1.value == "")
  {
isGood=false
alert("Be sure to provide your complete email address and that they match.");
document.frmChgEmpEmail.e1.value = "";
document.frmChgEmpEmail.e2.value = "";
document.frmChgEmpEmail.e1.focus();
document.frmChgEmpEmail.submit_btn.disabled = false;
return false;
  }
  
if ((IsBlank(document.frmChgEmpEmail.e1.value)) || (IsBlank(document.frmChgEmpEmail.e2.value)))
  {
isGood=false
alert("Your email address cannot be left blank.");
document.frmChgEmpEmail.e1.value = "";
document.frmChgEmpEmail.e2.value = "";
document.frmChgEmpEmail.e1.focus();
document.frmChgEmpEmail.submit_btn.disabled = false;
return false;
  }  
  
 
  if (isGood==true) {
    document.frmChgEmpEmail.submit()
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
                              <td valign="bottom" class="sideLink">Other Options: <a href="index.asp">Edit Account Information</a> | <a href="changePwd.asp">Change Account Password</a></td>
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
                        <form name="frmChgEmpEmail" method="post" action="doChangeEmail.asp">
                          <table width="90%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td colspan="2" bgcolor="#e7e7e7" align="center"><strong>Use the form below to change your primary E-Mail Address:</strong>
<% if request("confirm") = "1" then%>
<br>
<font color="#b22222"> <strong>E-Mail Address Changed!</strong></font>
<% End if %>							  

								
								</td>
                            </tr>
							<tr>
								<td colspan="2">
<% if request("confirm") = "1" then %>* Your new E-Mail Address is <strong><%=request("newEmail")%></strong>
<br>
Remember, this change will take effect at your next log-in!
<% End if %>

<% if request("error") = "1" then%>
<font color="#b22222"> Addresses did not match - please re-enter</font>
<% End if %>	
							
<% if request("error") = "2" then%>
<font color="#b22222"> Unable to change address - please try again</font>
<% End if %>

<% if request("error") = "3" then%>
<font color="#b22222"> Invalid address received - <%=Request("badVal")%> - please try again</font>
<% End if %>

</td>
							</tr>							
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td align="left" class="req_label">New E-Mail Address:</td>
                              <td align="left"> 
  <input type="text" name="e1" size="36" maxlength="100" onBlur="IsEmail(this);">
                              </td>
							 </tr>
							 <tr>
                              <td align="left" class="req_label">Confirm New E-Mail:</td>
                              <td align="left"> 
 <input type="text" name="e2" size="36" maxlength="100" onBlur="IsEmail(this);">
                              </td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center">                            
<input type="button" value="Save Changes" onClick="checkForm();" name="submit_btn">&nbsp;&nbsp;
<input type="button" name="button" value="Cancel" tabindex="-1" onClick="MM_goToURL('parent','../index.asp');return document.MM_returnValue">								
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
