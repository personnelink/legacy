<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/loggedRedirect.asp' -->
<%
' Get states/provinces
dim sqlLocation
dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)
' Get countries
dim sqlCountry
dim rsCountry
sqlCountry = "SELECT locCode, locName, display FROM tbl_locations WHERE display = 'N' ORDER BY locName"
set rsCountry = Connect.Execute(sqlCountry)
%>	
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<TITLE>Creating Your New Account - Step 2: Personal Profile</TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<script language = "Javascript">
/**
 * DHTML phone number validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

// Declaring required variables
var digits = "0123456789";
// non-digit characters which are allowed in phone numbers
var phoneNumberDelimiters = "()- ";
// characters which are allowed in international phone numbers
// (a leading + is OK)
var validWorldPhoneChars = phoneNumberDelimiters + "+";
// Minimum no of digits in an international phone no.
var minDigitsInIPhoneNumber = 10;

function isInteger(s)
{   var i;
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag)
{   var i;
    var returnString = "";
    // Search through string's characters one by one.
    // if character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function checkInternationalPhone(strPhone){
s=stripCharsInBag(strPhone,validWorldPhoneChars);
return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
}

function ValidateForm(){
	var Phone=document.profileInfo.contactPhone
	
	if ((Phone.value==null)||(Phone.value=="")){
		alert("Please enter the best phone number to contact you at.")

		return false
	}
	if (checkInternationalPhone(Phone.value)==false){
		alert("Please enter a valid 10 digit phone number. Be sure to include your area code.")
		Phone.value=""

		return false
	}
	return true
 }
</script>
<SCRIPT LANGUAGE="javascript">
function checkProfile()  {

var isGood = true
document.profileInfo.submit_btn.disabled = true;	

  if (document.profileInfo.firstName.value == '')
    {  alert("Please enter your First Name."); 
	document.profileInfo.firstName.focus();
document.profileInfo.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}		
  if (document.profileInfo.lastName.value == '')
    {  alert("Please enter your Last Name."); 
	document.profileInfo.lastName.focus();
document.profileInfo.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
		
  if (document.profileInfo.emailAddress.value == '')
    {  alert("Email Address is required."); 
	document.profileInfo.emailAddress.focus();
document.profileInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}	
				
  if (document.profileInfo.emailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.profileInfo.emailAddress.value.indexOf("@",0)
    var foundDot = document.profileInfo.emailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The E-mail Address provided is incomplete.")
	document.profileInfo.emailAddress.value = "";
    document.profileInfo.emailAddress.focus();
document.profileInfo.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }				
				  	
  if (document.profileInfo.addressOne.value == '')
    {  alert("Please provide your street or mailing address."); 
	document.profileInfo.addressOne.focus();
document.profileInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	
		
  if (document.profileInfo.contactPhone.value == '')
    {  alert("Please enter a phone number where you can be reached."); 
	document.profileInfo.contactPhone.focus();
document.profileInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}			
		   		
  if (document.profileInfo.city.value == '')
    {  alert("Please provide a city name."); 
	document.profileInfo.city.focus();
document.profileInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.profileInfo.state.value == '')
    {  alert("Please indicate which state or province you live in."); 
	document.profileInfo.state.focus();
document.profileInfo.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 
 
  if (document.profileInfo.zipCode.value == '')
    {  alert("Please enter a zip or postal code."); 
	document.profileInfo.zipCode.focus();
document.profileInfo.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	 	
							
  if (isGood != false)
    {  document.profileInfo.submit();  }
}
</SCRIPT>


</HEAD>

<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<FORM NAME="profileInfo" METHOD="post" ACTION="newAcct4.asp?who=2">	

<TABLE WIDTH=100% BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR="#FFFFFF">				
	<TR>
		<TD COLSPAN="2" ALIGN="center">
			<TABLE WIDTH="75%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
				<TR>
				<TD BGCOLOR="#003366" ALIGN="left" HEIGHT="35"><IMG SRC="/img/tab_top_left.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0"><IMG SRC="/img/tab_profile.gif" ALT="Personal Profile" WIDTH="166" HEIGHT="31" BORDER="0" ALIGN="absmiddle"></TD>
<TD BGCOLOR="#003366" HEIGHT="35" ALIGN="right" NOWRAP><FONT COLOR="#FFFFFF">Creating Your New Account - STEP <STRONG>2</STRONG> of 3</FONT><IMG SRC="/img/tab_top_right.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0" ALIGN="absmiddle"></TD>
				</TR>
				<TR>
				<TD COLSPAN="2">
						<TABLE WIDTH="100%" BORDER="0" CELLSPACING="10" CELLPADDING="0" style="border: 1px solid #D1DCEB;">
						<TR>
						<TD COLSPAN="2"><img src="/img/req_info.gif" alt="" width="87" height="16" border="0"></TD>
						</TR>
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> First Name:<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="firstName" TYPE="text" MAXLENGTH="30" SIZE="35" TABINDEX=1>
							</TD>
							<TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Last Name: <BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="lastName" TYPE="text" MAXLENGTH="40" SIZE="35" TABINDEX=2>
							</TD>
						</TR>						
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Email Address:<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="emailAddress" TYPE="text" MAXLENGTH="30" SIZE="35" TABINDEX=3>
							</TD>
<TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Contact Phone: <font size="1">(with area code)</font><BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="contactPhone" TYPE="text" MAXLENGTH="15" SIZE="35" TABINDEX=4 onBlur="return ValidateForm()">
							</TD>
						</TR>					
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Street Address:<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="addressOne" TYPE="text" MAXLENGTH="125" SIZE="35" TABINDEX=5>
							</TD>
							<TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="23" HEIGHT="1" BORDER="0">
							 Street Address <font size="1">(cont...)</font><BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="addressTwo" TYPE="text" MAXLENGTH="100" SIZE="35" TABINDEX=6>
							</TD>
						</TR>	
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> City:<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="city" TYPE="text" MAXLENGTH="30" SIZE="35" TABINDEX=7>
							</TD>
							<TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> State / Province: <BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
						
	<SELECT NAME="state" TABINDEX="8">
		<% do while not rsLocation.eof %>
		<OPTION	VALUE="<%= rsLocation("LOCCODE")%>"
		<% if rsLocation("locCode") = "ID" then %>SELECTED<% End if %>> <%=rsLocation("locName") %></OPTION>
		<% rsLocation.MoveNext %>
		<% loop %>	
	</SELECT>

							</TD>
						</TR>
						<TR><TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Zip/Postal Code:<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<INPUT NAME="zipCode" TYPE="zipCode" MAXLENGTH="10" SIZE="35" TABINDEX=9>
							</TD> 
							<TD VALIGN="top" WIDTH="50%"><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
							<IMG SRC="/img/asterisk.gif" WIDTH=7 HEIGHT=9> Country:<BR><IMG SRC="/img/spacer.gif" WIDTH="16" HEIGHT="1" BORDER="0">
	<SELECT NAME="country" TABINDEX="10">
		<% do while not rsCountry.eof %>
		<OPTION	VALUE="<%= rsCountry("LOCCODE")%>"
		<% if rsCountry("locCode") = "US" then %>SELECTED<% End if %>> <%=rsCountry("locName") %></OPTION>
		<% rsCountry.MoveNext %>
		<% loop %>	
	</SELECT>
							</TD>
						</TR>																
						<TR>
						<TD colspan="2" align="center"><br><INPUT TYPE="button" NAME="submit_btn" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" VALUE="Continue &gt;&gt;&gt;" TABINDEX=12 onClick="checkProfile()"></TD>				
						</TR>							
						</TABLE>
					</TD>
					</TR>			
			</TABLE>
		</TD>
		</TR>		
</TABLE>
</form>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->


