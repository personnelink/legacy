<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
<% 
if session("employerAuth") = "true" then
response.redirect("/lweb/employers/registered/index.asp?who=1")
end if
%>
<%
' Get states/provinces
Dim sqlLocation
Dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
set rsLocation = Connect.Execute(sqlLocation)
' Get countries
Dim sqlCountry
Dim rsCountry
sqlCountry = "SELECT locCode, locName, display FROM tbl_locations WHERE display = 'N' ORDER BY locName"
set rsCountry = Connect.Execute(sqlCountry)
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<TITLE>Creating Your New Employer Account - Step 2: Your Profile</TITLE>
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
	var Phone=document.employerProfile.companyPhone
	
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

function checkPreferences()  {

var isGood = true
document.employerProfile.submit_btn.disabled = true;	

  if (document.employerProfile.companyName.value == '')
    {  alert("Please enter a company name.\nIf this is an individual business, you may enter the full name of the registered business owner"); 
	document.employerProfile.companyName.focus();
document.employerProfile.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}	
  if (document.employerProfile.companyAgentFirstName.value == '')
    {  alert("Please enter your First Name."); 
	document.employerProfile.companyAgentFirstName.focus();
document.employerProfile.submit_btn.disabled = false;		
		isGood = false;
		return false
  		}		
  if (document.employerProfile.companyAgentLastName.value == '')
    {  alert("Please enter your Last Name."); 
	document.employerProfile.companyAgentLastName.focus();
document.employerProfile.submit_btn.disabled = false;		
		isGood = false; 
		return false
  		}	
				
				  	
  if (document.employerProfile.addressOne.value == '')
    {  alert("Please provide your street or mailing address."); 
	document.employerProfile.addressOne.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	   		
  if (document.employerProfile.city.value == '')
    {  alert("Please provide a city name."); 
	document.employerProfile.city.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 			
	
  if (document.employerProfile.state.value == '')
    {  alert("Please indicate which state or province you live in."); 
	document.employerProfile.state.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
  		}	 
 
  if (document.employerProfile.zipCode.value == '')
    {  alert("Please enter a zip or postal code."); 
	document.employerProfile.zipCode.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
		
		
  if (document.employerProfile.emailAddress.value == '')
    {  alert("An email address for Personnel Plus to contact you is required."); 
	document.employerProfile.emailAddress.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}	
  if (document.employerProfile.jobEmailAddress.value == '')
    {  alert("An email address for applicants to contact you is required."); 
	document.employerProfile.jobEmailAddress.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false;  
		return false
		}			
				
  if (document.employerProfile.emailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.employerProfile.emailAddress.value.indexOf("@",0)
    var foundDot = document.employerProfile.emailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The E-mail Address provided is incomplete.")
	document.employerProfile.emailAddress.value = "";
    document.employerProfile.emailAddress.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }	
  if (document.employerProfile.jobEmailAddress.value != '')
    {
    var okSoFar=true
    var foundAt = document.employerProfile.jobEmailAddress.value.indexOf("@",0)
    var foundDot = document.employerProfile.jobEmailAddress.value.indexOf(".",0)
     if (foundAt+foundDot < 2 && okSoFar) {
    alert ("The Job E-mail Address provided is incomplete.")
	document.employerProfile.jobEmailAddress.value = "";
    document.employerProfile.jobEmailAddress.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false;
		return false
     }	
    }			
		
		 	
  if (document.employerProfile.companyPhone.value == '')
    {  alert("Please enter your company phone number."); 
	document.employerProfile.companyPhone.focus();
document.employerProfile.submit_btn.disabled = false;		
			isGood = false; 
		return false
  		}	
									
  if (isGood != false)
    {  document.employerProfile.submit();  }
}
</SCRIPT>

</HEAD>
<BODY>
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->

<FORM NAME="employerProfile" METHOD="post" ACTION="newEmpAcct4.asp?who=1">

<TABLE WIDTH="75%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
				<TR>
				<TD BGCOLOR="#003366" ALIGN="left" HEIGHT="35"><IMG SRC="/lweb/img/tab_top_left.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0"><IMG SRC="/lweb/img/tab_emp_profile.gif" ALT="Personal Profile" WIDTH="166" HEIGHT="31" BORDER="0" ALIGN="absmiddle"></TD>
<TD BGCOLOR="#003366" HEIGHT="35" ALIGN="right" NOWRAP><FONT COLOR="#FFFFFF">Creating Your New Employer Account - STEP 2 of 3</FONT><IMG SRC="/lweb/img/tab_top_right.gif" ALT="" WIDTH="17" HEIGHT="35" BORDER="0" ALIGN="absmiddle"></TD>
				</TR>
					  <tr>
					    <td align="center" colspan="2">
					<TABLE WIDTH="100%" BORDER="0" CELLSPACING="10" CELLPADDING="0" style="border: 1px solid #D1DCEB;">
				  			<tr>
								<td colspan="2" align="center">Your <%=session("temp_companyType")%> Account Information:</td>
							</tr>
	                      <tr> 
	                        <td align="right" width="50%"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Company Name:</td>
	                        <td> 
	                          <input type="text" name="companyName" size="35" maxlength="100">
	                        </td>
						  </tr>
						  <tr>
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Your First Name:</td>
	                        <td> 
	                          <input type="text" name="companyAgentFirstName" size="25" maxlength="30">
	                        </td>
	                      </tr>
						  <tr>
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Your Last name:</td>
	                        <td> 
							  <input type="text" name="companyAgentLastName" size="25" maxlength="40">
	                        </td>
	                      </tr>					  
						  <tr>
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Your Job Title/Position:</td>
	                        <td><input type="text" name="companyAgentTitle" size="30" maxlength="100">
	                        </td>
	                      </tr>					  
	                      <tr> 
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Company Address:</td>
	                        <td>
							<input type="text" name="addressOne" size="35" maxlength="125"><br>
							
	                        </td>
						  </tr>
	                      <tr> 
	                        <td align="right">Address (Cont.):</td>
	                        <td>
							<input type="text" name="addressTwo" size="35" maxlength="100"><br>
							
	                        </td>
						  </tr>					  
						  <tr>
	                        <td valign="top" align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> City:</td>
	                        </td>
	                        <td valign="top">
	                          <input type="text" name="city" size="16" maxlength="36">
	                        </td>						
	                      </tr>
	                      <tr> 
	                        <td valign="top" align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> State/Province:</td>
	                        <td> 
							<select name="state">
	<option value="" SELECTED>-- SELECT ONE --</option>
	<%	
		Do While NOT rsLocation.EOF
		response.Write "<OPTION VALUE='" & rsLocation("locCode") & _
						   "'>" & rsLocation("locCode") & " - " & rsLocation("locName")	
			rsLocation.MoveNext
					
		Loop		
	%>
	</select>
	                        </td>
	                      </tr>
	                      <tr> 
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Zip/Postal Code:</td>
	                        <td> 
	                          <input type="text" name="zipCode" size="10" maxlength="8"> - <input type="text" name="zipCodePlus4" size="4" maxlength="4">
	                        </td>
						  </tr>
	                      <tr> 
	                        <td valign="top" align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9>  Country:</td>
	                        <td> 
	<SELECT NAME="country" TABINDEX="10">
		<% Do While NOT rsCountry.EOF %>
		<OPTION	VALUE="<%= rsCountry("LOCCODE")%>"
		<% If rsCountry("locCode") = "US" then %>SELECTED<% End If %>> <%=rsCountry("locName") %></OPTION>
		<% rsCountry.MoveNext %>
		<% Loop %>	
	</SELECT>
	                        </td>
	                      </tr>					  					  
						  <tr>
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> E-mail address:<br>
	                          <font size="1"><EM>(Used by Personnel Plus 
	                          to contact you) </EM></font></td>
	                        <td> 
	                          <input type="text" name="emailAddress" size="30" maxlength="80">
	                        </td>
	                      </tr>					  
						  <tr>
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Job E-mail address:<br>
	                          <font size="1"><EM>(Used by Job Searchers to contact you) </EM></font></td>
	                        <td> 
	                          <input type="text" name="jobEmailAddress" size="30" maxlength="80">
	                        </td>
	                      </tr>					  
						  <tr>
	                        <td align="right"><IMG SRC="/lweb/img/asterisk.gif" WIDTH=7 HEIGHT=9> Contact/Message Phone #:</td>
	                        <td> 
	                          <input type="text" name="companyPhone" size="15" maxlength="15" onBlur="return ValidateForm()">
	                        </td>
	                      </tr>
						  <tr>
	                        <td align="right">Company Fax #:</td>
	                        <td> 
	                          <input type="text" name="faxNumber" size="15" maxlength="15">
	                        </td>
	                      </tr>  					  
	                      <tr> 
							<td colspan="2" align="center"><INPUT TYPE="button" style="background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF" NAME="submit_btn" VALUE="Continue &gt;&gt;&gt;" TABINDEX=4 onClick="checkPreferences()"></td>
	                      </tr>
	                    </table>
				</td>
			</tr>
			</table>
</form>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</BODY>
</HTML>

