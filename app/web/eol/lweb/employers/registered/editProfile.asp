<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% if session("employerAuth") <> "true" then response.redirect("/index.asp") end if%>
<%
Dim sqlLocation
Dim rsLocation
Dim sqlCountry
Dim rsCountry
Dim rsfrmEditProfile

sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)
sqlCountry = "SELECT locCode, locName, display FROM tbl_locations WHERE display = 'N' ORDER BY locName"
set rsCountry = Connect.Execute(sqlCountry)

Set rsfrmEditProfile = Server.CreateObject("ADODB.Recordset")
rsfrmEditProfile.Open "SELECT * FROM tbl_employers WHERE empID ='" & session("empID") & "'", Connect, 3, 3
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<TITLE>Edit Employer Account : <%=session("companyName")%>&nbsp;-&nbsp;<%=session("companyAgent")%></TITLE>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<script language = "Javascript">
var digits = "0123456789";
var phoneNumberDelimiters = "()- ";
var validWorldPhoneChars = phoneNumberDelimiters + "+";
var minDigitsInIPhoneNumber = 10;

function isInteger(s)
{   var i;
    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    return true;
}

function stripCharsInBag(s, bag)
{   var i;
    var returnString = "";
    for (i = 0; i < s.length; i++)
    {   
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
	var Phone=document.frmEditProfile.companyPhone
	
	if ((Phone.value==null)||(Phone.value=="")){
		alert("Please enter the company phone number.")

		return false
	}
	if (checkInternationalPhone(Phone.value)==false){
		alert("Please enter a valid 10 digit phone number.")
		Phone.value=""

		return false
	}
	return true
 }

function checkPreferences()  {

var isGood = true
document.frmEditProfile.submit_btn.disabled = true;	

  if (!document.frmEditProfile.companyType[0].checked && !document.frmEditProfile.companyType[1].checked)
    {  
	    isGood=false
		alert("Please indicate your type of business."); 
document.frmEditProfile.companyType[0].focus()
document.frmEditProfile.submit_btn.disabled = false;	  	
	return false  } 	

  if (document.frmEditProfile.companyName.value == '')
    {  alert("Please enter a company name.\nIf this is an individual business, you may enter the full name of the registered business owner"); 
	document.frmEditProfile.companyName.focus();
document.frmEditProfile.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
  if (document.frmEditProfile.companyAgent.value == '')
    {  alert("Please enter your full name."); 
	document.frmEditProfile.companyAgent.focus();
document.frmEditProfile.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}		
		  	
  if (document.frmEditProfile.addressOne.value == '')
    {  alert("Please provide your street or mailing address."); 
	document.frmEditProfile.addressOne.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	   		
  if (document.frmEditProfile.city.value == '')
    {  alert("Please provide a city name."); 
	document.frmEditProfile.city.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.frmEditProfile.state.value == '')
    {  alert("Please indicate which state or province you live in."); 
	document.frmEditProfile.state.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 
 
  if (document.frmEditProfile.zipCode.value == '')
    {  alert("Please enter a zip or postal code."); 
	document.frmEditProfile.zipCode.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
		
  if (document.frmEditProfile.emailAddress.value == '')
    {  alert("An email address for Personnel Plus to contact you is required."); 
	document.frmEditProfile.emailAddress.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}	
  if (document.frmEditProfile.jobEmailAddress.value == '')
    {  alert("An email address for applicants to contact you is required."); 
	document.frmEditProfile.jobEmailAddress.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}			
				
  if (document.frmEditProfile.emailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.frmEditProfile.emailAddress.value.indexOf("@",0)
    var foundDot = document.frmEditProfile.emailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The E-mail Address provided is incomplete.")
	document.frmEditProfile.emailAddress.value = "";
    document.frmEditProfile.emailAddress.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }	
  if (document.frmEditProfile.jobEmailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.frmEditProfile.jobEmailAddress.value.indexOf("@",0)
    var foundDot = document.frmEditProfile.jobEmailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The Job E-mail Address provided is incomplete.")
	document.frmEditProfile.jobEmailAddress.value = "";
    document.frmEditProfile.jobEmailAddress.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }			
		
		 	
  if (document.frmEditProfile.companyPhone.value == '')
    {  alert("Please enter your company phone number."); 
	document.frmEditProfile.companyPhone.focus();
document.frmEditProfile.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
									
  if (isGood != false)
    {  document.frmEditProfile.submit();  }
}
</SCRIPT>
</HEAD>

<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<TABLE width="75%" BORDER="0" CELLPADDING="3" CELLSPACING="0" BGCOLOR="#ffffff">
	<TR>
		<TD align="center" valign="top" bgcolor="#9acd32"><strong>Edit Account - <%=session("companyName")%></strong></td>
	</tr>
	<tr>
		<td valign="top" align="center" STYLE="border: 1px solid #999999;">
		<form name="frmEditProfile" method="post" action="/lweb/employers/registered/editProfile2.asp?who=1">
			<table>
				<tr>
					<td>Type of Business:</td><td><input type="radio" style="background:#FFFFFF; border:0; color:#FFFFFF" name="companyType" value="Corporate" <% if rsfrmEditProfile("companyType") = "Corporate" then%>CHECKED<%end if%>>Corporation&nbsp;&nbsp;
<input type="radio" style="background:#FFFFFF; border:0; color:#FFFFFF"name="companyType" value="Individual" <% if rsfrmEditProfile("companyType") = "Individual" then%>CHECKED<%end if%>>Individual</td>
				</tr>
				<tr>
					<td>Company Name:</td><td><input type="text" name="companyName" value="<%=rsfrmEditProfile("companyName")%>" size="50" maxlength="100"></td>
				
				</tr>
				<tr>
					<td>Company Agent:</td><td><input type="text" name="companyAgent" value="<%=rsfrmEditProfile("companyAgent")%>" size="35" maxlength="75"></td>
				
				</tr>	
				<tr>
					<td>Company Agent Title:</td><td><input type="text" name="companyAgentTitle" value="<%=rsfrmEditProfile("companyAgentTitle")%>" size="35" maxlength="75"></td>
				
				</tr>		
				<tr>
					<td>Address:</td><td><input type="text" name="addressOne" value="<%=rsfrmEditProfile("addressOne")%>" size="40" maxlength="125"></td>
				
				</tr>	
				<tr>
					<td>Address <font size="1">(continued)</font>:</td><td><input type="text" name="addressTwo" value="<%=rsfrmEditProfile("addressTwo")%>" size="40" maxlength="100"></td>
				
				</tr>	
				<tr>
					<td>City:</td><td><input type="text" name="city" value="<%=rsfrmEditProfile("city")%>" size="25" maxlength="36"></td>
				
				</tr>	
				<tr>
					<td>State:</td><td>
						<SELECT NAME="state">
							<% Do While NOT rsLocation.EOF %>
							<OPTION	VALUE="<%= rsLocation("locCode")%>"		
							<% If rsLocation("locCode") = rsfrmEditProfile("state") then %>SELECTED<% End If %>> <%=rsLocation("locName") %></OPTION>		
							<% rsLocation.MoveNext %>
							<% Loop %>	
						</SELECT>				
					</td>
				
				</tr>	
				<tr>
					<td>Zipcode:</td><td><input type="text" name="zipCode" value="<%=rsfrmEditProfile("zipCode")%>" size="25" maxlength="13"></td>
				
				</tr>	
				<tr>
					<td>Country:</td><td>
	<SELECT NAME="country">
		<% Do While NOT rsCountry.EOF %>
		<OPTION	VALUE="<%= rsCountry("locCode")%>"
		<% If rsCountry("locCode") = "US" then %>SELECTED<% End If %>> <%=rsCountry("locName") %></OPTION>
		<% rsCountry.MoveNext %>
		<% Loop %>	
	</SELECT>						
					</td>
				
				</tr>					
				
			
				
				<tr>
					<td>Phone:</td><td><input type="text" name="companyPhone" value="<%=rsfrmEditProfile("companyPhone")%>" size="25" maxlength="20" onBlur="return ValidateForm()"></td>
				
				</tr>	
				<tr>
					<td>Fax:</td><td><input type="text" name="faxNumber" value="<%=rsfrmEditProfile("faxNumber")%>" size="25" maxlength="15"></td>
				
				</tr>	
				<tr>
					<td>Email Address:</td><td><input type="text" name="emailAddress" value="<%=rsfrmEditProfile("emailAddress")%>" size="35" maxlength="80"></td>
				
				</tr>	
				<tr>
					<td>Job Email Address:</td><td><input type="text" name="jobEmailAddress" value="<%=rsfrmEditProfile("jobEmailAddress")%>" size="35" maxlength="80"></td>
				
				</tr>	
				<tr>
					<td colspan="2"><img src="/lweb/img/spacer.gif" alt="" width="1" height="6" border="0"></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><INPUT TYPE="button" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF"; NAME="submit_btn" VALUE="Save Changes" onClick="checkPreferences()"></td>
				</tr>	
				<tr>
					<td colspan="2"><img src="/lweb/img/spacer.gif" alt="" width="1" height="6" border="0"></td>
				</tr>
				<tr>
					<td align="left" colspan="2">[<a href="/lweb/employers/registered/index.asp?who=1"><font style class="smallTxt">Cancel &amp; Return To Control Panel</font></a>]</td>
				</tr>																																														

			</table>
		</form>


		</td>
	</tr>
</TABLE>
              
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>
<% 
set rsLocation = Nothing
set rsCountry = Nothing
set rsfrmEditProfile = Nothing

%>