<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<% 
if session("mbrAuth") = "true" then
response.redirect("/registered/logged/index.asp")
end if
%>
<html>
<head>
<title>Create New Member Account - www.personnel.com</title>

<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
<script language="javascript" src="/includes/scripts/formVal.js"></script>
<SCRIPT LANGUAGE="javascript">
function confirmInfo()	  {

document.accountInfo.submit_btn.disabled = true;
var isGood = true;

if (IsBlank(document.accountInfo.emailAddress.value))
  {
isGood=false
alert("Please provide an e-mail address.");
document.accountInfo.emailAddress.value = "";
document.accountInfo.emailAddress.focus();
document.accountInfo.submit_btn.disabled = false;
return false;
  }
  
if (document.accountInfo.password.value.length < 3)
  {
isGood=false
mesg2 = "You have entered " + document.accountInfo.password.value.length + " character(s) for the password.\n"
mesg2 = mesg2 + "Please use at least 3 characters for your password.\n"
alert(mesg2);
document.accountInfo.password.value = "";
document.accountInfo.confirmPassword.value = "";
document.accountInfo.password.focus();
document.accountInfo.submit_btn.disabled = false;
return false;
  } 

if (document.accountInfo.password.value != document.accountInfo.confirmPassword.value || document.accountInfo.password.value == "")
  {
isGood=false
alert("Please make sure you have entered a password and that your passwords match");
document.accountInfo.password.value = "";
document.accountInfo.confirmPassword.value = "";
document.accountInfo.password.focus();
document.accountInfo.submit_btn.disabled = false;
return false;
  }
  
if ((IsBlank(document.accountInfo.password.value)) || (IsBlank(document.accountInfo.confirmPassword.value)))
  {
isGood=false
alert("Your password cannot be blank");
document.accountInfo.password.value = "";
document.accountInfo.confirmPassword.value = "";
document.accountInfo.password.focus();
document.accountInfo.submit_btn.disabled = false;
return false;
  }  
    
  if (isGood==true) {
    document.accountInfo.submit()
  }  
}
</SCRIPT>

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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                    <table width="80%" border="0" cellspacing="0" cellpadding="4">
                    <tr> 
                      <td colspan="2" align="left"><img src="/images/hdr_new_mbr_reg.gif" width="328" height="48"></td>
                    </tr>
                    <tr> 
                       <td width="30" class="sideMenu"><img src="/images/pixel.gif" width="30" height="1"></td>
                       <td>You have just taken the first step to a brighter future! <br> By signing up as a member you can create resumes, apply for jobs and more.
                         
 						</td>
                    </tr>
					<tr><td width="30"><img src="/images/pixel.gif" width="30" height="1"></td>
						<td bgcolor="#e7e7e7"><strong>To register, enter your e-mail address and a password to use below:</strong></td>
					</tr>				 
                  </table>				
                  <form name="accountInfo" method="post" action="doFirstPage.asp" onSubmit="noReturn('accountInfo'); return false">
                    <table width="90%" border="0" cellspacing="0" cellpadding="5">
                      <tr> 
                        <td colspan="2"> 
                          <% if request("error") = 1 then %>
						  <img src="/images/ico_alert.gif" alt="" width="25" height="19" border="0" align="absmiddle"> <font color="#CC0000"><%=request.querystring("emailAddress")%> is in use.</font>
<br>
<img src="/images/pixel.gif" width="25" height="1">if you are a returning member, <a href="/registered/login.asp">log in here</a>.
<br>
<img src="/images/pixel.gif" width="25" height="1">if you have forgotten or lost your password, <a href="/registered/forgot.asp">click here</a>.
                          <% End if %>
                          <% if request("error") = 2 then %>
						  <img src="/images/ico_alert.gif" alt="" width="25" height="19" border="0" align="absmiddle"> <font color="#CC0000">There was an error processing your request, please try again:</font>
                          <% End if %>						  
                          <% if request("error") = 3 then %>
						  <img src="/images/ico_alert.gif" alt="" width="25" height="19" border="0" align="absmiddle"> <font color="#CC0000">Please verify that <strong><%=request.querystring("emailAddress")%></strong> is a valid e-mail address and try again:</font>
                          <% End if %>						  

                        </td>

                      </tr>
                      <tr> 
                        <td width="27%" align="right">E-mail Address:</td>
                        <td width="73%"> 
                          <input type="text" name="emailAddress" size="26" maxlength="100" onBlur="IsEmail(this);">
                        </td>
                      </tr>
                      <tr> 
                        <td width="27%" align="right">Password:</td>
                        <td width="73%"> 
                          <input type="password" name="password" size="18" maxlength="20">
                        </td>
                      </tr>
                      <tr> 
                        <td width="27%" align="right">Confirm Password:</td>
                        <td width="73%"> 
                          <input type="password" name="confirmPassword" size="18" maxlength="20">
                        </td>
                      </tr>
                      <tr> 
                        <td width="27%">&nbsp;</td>
                        <td width="73%"> 
                          <input type="button" name="submit_btn" value="Next..." onClick="confirmInfo();">
                        </td>
                      </tr>
                    </table>
                  </form>
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
<%
Connect.Close
Set Connect = Nothing
%>
</body>
</html>
