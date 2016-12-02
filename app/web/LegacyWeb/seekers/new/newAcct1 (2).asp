<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->

<% 
if request("officeSelector") <> "" then
session("targetOffice") = request("officeSelector")
else
session("targetOffice") = "twin@personnel.com"
end if 
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<TITLE>Creating Your New Account - Step 1: Choosing A Login</TITLE>
<SCRIPT LANGUAGE="javascript">

function checkLoginInfo()	  
{
document.loginInfo.submit_btn.disabled = true;
var isGood = true
if ((document.loginInfo.uN.value.length < 4) || (document.loginInfo.uN.value.length > 30))
  {
isGood=false
mesg2 = "You have entered " + document.loginInfo.uN.value.length + " character(s) for the user name.\n"
mesg2 = mesg2 + "The user name needs to be 4 or more characters in length.\n"
alert(mesg2);
document.loginInfo.uN.value = "";
document.loginInfo.uN.focus();
document.loginInfo.submit_btn.disabled = false;
return false;

  }
if ((document.loginInfo.uNer.value.length < 5) || (document.loginInfo.uNer.value.length > 30))
    {
isGood=false
mesg = "You have entered " + document.loginInfo.uNer.value.length + " character(s) for the password.\n"
mesg = mesg + "Your password needs to be 4 or more characters in length.\n"
alert(mesg);
document.loginInfo.uNer.value = "";
document.loginInfo.confirmuNer.value = "";
document.loginInfo.uNer.focus();
document.loginInfo.submit_btn.disabled = false;
return false;

    }  
if (document.loginInfo.uNer.value != document.loginInfo.confirmuNer.value) 
  {
    isGood=false
    alert("Please make sure that your passwords match.");
document.loginInfo.uNer.value = "";
document.loginInfo.confirmuNer.value = "";
document.loginInfo.uNer.focus();	
document.loginInfo.submit_btn.disabled = false;	
	return false

  }
  if (isGood==true) {
    document.loginInfo.submit()
  }  
}
</SCRIPT>
<SCRIPT LANGUAGE="javascript" TYPE="text/javascript">
<!--
var win=null;
function NewWindow(mypage,myname,w,h,scroll,pos){
if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}
if(pos=="center"){LeftPosition=(screen.width)?(screen.width-w)/2:100;TopPosition=(screen.height)?(screen.height-h)/2:100;}
else if((pos!="center" && pos!="random") || pos==null){LeftPosition=0;TopPosition=20}
settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';
win=window.open(mypage,myname,settings);}
// -->
</SCRIPT>
</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<FORM NAME="loginInfo" METHOD="post" ACTION="newAcct2.asp?who=2">

			<TABLE WIDTH="65%" BORDER="0" CELLSPACING="0" CELLPADDING="0" BGCOLOR="#FFFFFF">
				<TR>
				<TD BGCOLOR="#003366" ALIGN="left" HEIGHT="35"><IMG SRC="/img/tab_top_left.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0"><IMG SRC="/img/tab_choose.gif" ALT="Choose Login" WIDTH="166" HEIGHT="31" BORDER="0" ALIGN="absmiddle"></TD>
<TD BGCOLOR="#003366" HEIGHT="35" ALIGN="right" NOWRAP><FONT COLOR="#FFFFFF">Creating Your New Account - STEP <STRONG>1</STRONG> of 4</FONT><IMG SRC="/img/tab_top_right.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0" ALIGN="absmiddle"></TD>
				</TR>
				<TR>
				<TD COLSPAN="2">
					<TABLE WIDTH="100%" BORDER="0" CELLSPACING="10" CELLPADDING="0" style="border: 1px solid #D1DCEB;">
					<TR>
					<TD COLSPAN="2" ALIGN="center">				
<% if request("Error") = 1 then %>
<STRONG><FONT COLOR="#FF0000" STYLE CLASS="smallTxt">The User Name <FONT COLOR="#000000"><%=request("nameTaken") %></FONT> already exists. <BR>Please choose a different User Name; i.e. </FONT></STRONG> 
<%
RANDOMIZE
upperlimit = 43.0
lowerlimit = 1.0
response.write("<STRONG>" & request("nameTaken") & INT((upperlimit - lowerlimit)*RND() + lowerlimit) & "</STRONG>") %> 
<% else %>
<strong>Choose a user name and password for your account</strong>:
<% end if %>					
					</TD>
					</TR>
<% if session("auth") = "true" then %>
					<TR>
						<TD colspan="2" align="center">You are currently logged in. while you are welcome to create multiple accounts, you must <A HREF="/logout.asp">Log Out</A> from your current account before creating a new one.</TD>
					</TR>
					</TABLE>
				</TD>
				</TR>
			</TABLE></form>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
<% response.end %>
</BODY>
</HTML>					
<% end if %>						
					<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
					<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> User Name:<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
					<INPUT NAME="uN" TYPE="text" MAXLENGTH="30" SIZE="35" TABINDEX=1><BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
					<FONT STYLE CLASS="smallTxt">(4 character minimum)</FONT>
					</TD>
					<TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
					<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Password: <BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
					<INPUT NAME="uNer" TYPE="password" MAXLENGTH="30" SIZE="35" TABINDEX=2><BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
					<FONT STYLE CLASS="smallTxt">(5 character minimum)</FONT>
					</TD>
					</TR>
					<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="19" HEIGHT="1" BORDER="0"><INPUT TYPE="checkbox" NAME="rememberMe" VALUE="Yes" style="background:#FFFFFF; border:0; color:#FFFFFF"> Remember My Login<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
				<A HREF="/hlp/hlp_rememberMe.asp" onclick="NewWindow(this.href,'helpWin','300','300','yes','center');return false" onfocus="this.blur()"><FONT SIZE="1">What's This?</FONT></A>
					</TD>
					<TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
					<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Retype Password: <BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0"> <INPUT NAME="confirmuNer" TYPE="password" MAXLENGTH="12" SIZE="35" TABINDEX=3>
					</TD>
					</TR>
					<TR>
					<TD>&nbsp;</TD>
					<TD ALIGN="center"><INPUT TYPE="button" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" NAME="submit_btn" VALUE="Continue &gt;&gt;&gt;" TABINDEX=4 onClick="checkLoginInfo()"></TD>					
					</TR>					
					</TABLE>
				</TD>
				</TR>
			</TABLE></form>
					<form method="POST" action="/index2.asp?who=2&?#applicant">
						<input align="middle" type="submit" value="Already have an account?" STYLE="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF">
					</form>				
			
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>

