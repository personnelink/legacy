<!-- INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>Login Help - Personnel Plus, Inc.</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<script language = "Javascript">
function noReturn() {
   if (document.forms) {
      // Do Nothing...
   }
}
function echeck(str) {
		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Please enter a valid E-mail Address")
		   return false
		}
		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Please enter a valid E-mail Address")
		   return false
		}
		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Please enter a valid E-mail Address")
		    return false
		}
		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Please enter a valid E-mail Address")
		    return false
		 }
		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Please enter a valid E-mail Address")
		    return false
		 }
		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Please enter a valid E-mail Address")
		    return false
		 }
		 if (str.indexOf(" ")!=-1){
		    alert("Please enter a valid E-mail Address")
		    return false
		 }
 		 return true					
	}
function checkForm(){
	var emailID=document.forgotLogin.emailAddress
	
	if ((emailID.value==null)||(emailID.value=="")){
		alert("Please enter your E-mail Address")
		emailID.focus()
		return false
	}
	if (echeck(emailID.value)==false){
		emailID.value=""
		emailID.focus()
		return false
	}
    document.forgotLogin.submit();		
	return true
 }
</script>
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<TABLE WIDTH="90%" BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR="#FFFFFF">					
	<TR>
		<TD COLSPAN="2" ALIGN="center">
			<TABLE WIDTH="75%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
			<TR>
				<TD BGCOLOR="#003366" ALIGN="left" HEIGHT="35"><IMG SRC="/include/content/images/legacy/img/tab_top_left.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0"><IMG SRC="/include/content/images/legacy/img/tab_help_login.gif" ALT="Login Help" WIDTH="123" HEIGHT="31" BORDER="0" ALIGN="absmiddle"></TD>
<TD BGCOLOR="#003366" HEIGHT="35" ALIGN="right"><FONT COLOR="#FFFFFF">What is my login?</FONT><IMG SRC="/include/content/images/legacy/img/tab_top_right.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0" ALIGN="absmiddle"></TD>
				</TR>
				<TR>
				<TD COLSPAN="2"><FORM NAME="forgotLogin" ACTION="sendLogin.asp" METHOD="post" onSubmit="noReturn('forgotPassword'); return false">
					<TABLE WIDTH="100%" BORDER="0" CELLSPACING="8" CELLPADDING="0" style="border: 1px solid #D1DCEB;">	

					<TR>
					<TD COLSPAN="2" ALIGN="center">
                   To recover your information and regain access to your<br> Personnel Plus account, 
                    please enter your E-mail address.<P></P>
                    * <STRONG>Note that the E-mail address entered below must 
                    match the same address used when you first created your account.</STRONG> 
                  </TD>
                </TR>
<% if request.queryString("error") <> "" then %>					
<% if request.queryString("error") = 0 then %>						
					<TR>
					<TD ALIGN="center" colspan="2"><font color="#FF0000">Your Account Information Has Been Emailed To You</font></TD>
					</TR>
<% end if %>	
<% if request.queryString("error") = 1 then %>	
					<TR>
					<TD ALIGN="center" colspan="2"><font color="#FF0000">There was an unknown error processing your request.  Please try again.</font></TD>
					</TR>					

<% end if %>	
<% if request.queryString("error") = 2 then %>	
					<TR>
					<TD ALIGN="center" colspan="2"><font color="#FF0000"><strong><%=request.querystring("badAddress")%></strong> could not be found in our job seeker database.</font><br>
<a href="mailto:webmaster@personnelplus-inc.com?Subject=Account Login Help"><font size="1">Need Login Help?</font></a></TD>
					</TR>					

<% end if %>
<% end if %>
					<TR>
					<TD ALIGN="right">* E-mail Address:</TD>
					<TD><INPUT TYPE="text" NAME="emailAddress" SIZE="30" MAXLENGTH="75"></TD>
					</TR>
                	<TR> 
                  <TD COLSPAN="2" ALIGN="center"><INPUT TYPE="button" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" name="submitBtn" VALUE="Send To Me" onClick="checkForm()"></TD>
                	</TR>
				</TABLE></form>
			</TD> 
		</TABLE>
	</TD>
  </TR>	
</TABLE>

<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>

