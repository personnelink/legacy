<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<%

'response.write(user_name)
'response.write(session("seekID"))
'response.write(session("lastJobID"))
'response.end
if session("auth") = "true" then

' vars used to handle direction of resume
if request("officeSelector") <> "" then
session("targetOffice") = request("officeSelector")
else session("targetOffice") = "twin@personnel.com"
end if

Set rsPersonalProfile = Server.CreateObject("ADODB.Recordset")
rsPersonalProfile.Open "SELECT seekID,firstName,lastName,addressOne,addressTwo,city,state,zipCode,country,contactPhone,userName,password,emailAddress,numResumes,suspended,dateCreated FROM tbl_seekers WHERE userName ='" & user_name & "'", Connect, 3, 3

Set rsPreferences = Server.CreateObject("ADODB.Recordset")
rsPreferences.Open "SELECT seekID,userName,schedule,shift,wageType,wageAmount,qRelocate,relocateAreaOne,relocateAreaTwo,relocateAreaThree,commuteDist,workLegalStatus,workLegalProof,dateCreated FROM tbl_seekers_preferences WHERE seekID ='" & session("seekID") & "'", Connect, 3, 3
 Else
	response.redirect("/index.asp")
end if

dim sqlLocation
dim rsLocation
sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
%>
<HTML>
<HEAD>
<!-- #INCLUDE VIRTUAL='/inc/head.asp' -->
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<title><%=user_lastname%>, <%=user_firstname%>  - Online Resume - Personnel Plus, Inc.</title>
<script language="javaScript">
function validateResume() {
  var okSoFar=true 
document.onlineResume.submit_btn.disabled = true;	  
 
     
  
  //-- workAge
  if (document.onlineResume.workAge.value == "") {
    okSoFar=false
    alert("Please indicate if you are 18 years of age or older.")
    document.onlineResume.workAge.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  } 
  //-- workValidLicense
  if (document.onlineResume.workValidLicense.value == "") {
    okSoFar=false
    alert("Please indicate whether or not you have a valid drivers license.")
    document.onlineResume.workValidLicense.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  } 
  //-- workConviction
  if (document.onlineResume.workConviction.value == "") {
    okSoFar=false
    alert("Please indicate if you've been convicted of a crime or have been released from jail as a result of a prior conviction.")
    document.onlineResume.workConviction.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false	
  }   
    //-- jobHistTitleOne
  if (document.onlineResume.jobHistTitleOne.value == "") {
    okSoFar=false
    alert("Please enter your most recent job title.")
    document.onlineResume.jobHistTitleOne.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  } 
  //-- jobHistCpnyOne
  if (document.onlineResume.jobHistCpnyOne.value == "") {
    okSoFar=false
    alert("Please enter the name of the last company you worked for.")
    document.onlineResume.jobHistCpnyOne.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  } 
  //-- jobHistPhoneOne
  if (document.onlineResume.jobHistPhoneOne.value == "") {
    okSoFar=false
    alert("Please enter the phone number of the last company you worked for.")
    document.onlineResume.jobHistPhoneOne.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  } 
  
  //--  jobHistSMonthOne, jobHistSYearOne
  if (document.onlineResume.jobHistSMonthOne.value == "" || document.onlineResume.jobHistSYearOne.value == "") {
    okSoFar=false
    alert("Please enter a complete starting date of your most recent job.")
    document.onlineResume.jobHistSMonthOne.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  } 
  //--  jobHistEMonthOne, jobHistEYearOne
  if (document.onlineResume.jobHistEMonthOne.value == "" || document.onlineResume.jobHistEYearOne.value == "") {
    okSoFar=false
    alert("Please enter a complete ending date of your most recent job.")
    document.onlineResume.jobHistEMonthOne.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  }   
  
 
  //-- eduLevel
  if (document.onlineResume.eduLevel.value == "") {
    okSoFar=false
    alert("Please select the highest level of education completed.")
    document.onlineResume.eduLevel.focus();
	document.onlineResume.submit_btn.disabled = false;
	return false
  }  
  
  //-- emailAddress.
  var foundAt = document.onlineResume.emailAddress.value.indexOf("@",0)
  var foundDot = document.onlineResume.emailAddress.value.indexOf(".",0)
  if (foundAt+foundDot < 2 && okSoFar) {
    okSoFar = false
    alert ("Your E-mail address was incomplete.")
	document.onlineResume.submit_btn.disabled = false;
    document.onlineResume.emailAddress.focus();
  }
  
   if (okSoFar != false) 
  
{var agree=confirm("Submit your resume now?");
		if (agree)
	document.onlineResume.submit();
else
    document.onlineResume.submit_btn.disabled = false;	
	return false ;
	}  
  
  
}
</script>
</script>
</HEAD>
<BODY>
<noscript>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</noscript>
<!-- #INCLUDE VIRTUAL='/inc/navi_top.asp' -->
<TABLE WIDTH=75% BORDER=0 CELLPADDING=0 CELLSPACING=4 bgcolor="#dcbace">  
  <tr>
  	<td width="100%" align="center" colspan="2" bgcolor="#dcbace"><a href="/seekers/registered/emailresume/upload.asp"><strong>Upload an Existing Resume</strong></a>
  	</td>
  </tr>
  <tr>
  	<td><center>or</center>
  	</td>
  </tr>
  <tr>
    <td width="100%" align="center" colspan="2" bgcolor="#dcbace"><strong>Create an Online Resume Below</strong>	
	</td>
  </tr>
  
  <tr>
    	<td align="center" style="border:1px solid #dcbace;">
<FORM NAME="onlineResume" METHOD="POST" ACTION="applyOnline2.asp">
<input type="hidden" name="seekID" value="<%=session("seekID")%>">
<input type="hidden" name="userName" value="<%=user_name%>">
<input type="hidden" name="firstName" value="<%=user_firstname%>">
<input type="hidden" name="lastName" value="<%=user_lastname%>">
<input type="hidden" name="addressOne" value="<%=session("addressOne")%>">
<input type="hidden" name="addressTwo" value="<%=session("addressTwo")%>">
<input type="hidden" name="city" value="<%=session("city")%>">
<input type="hidden" name="state" value="<%=session("state")%>">
<input type="hidden" name="zipCode" value="<%=user_zip%>">
<input type="hidden" name="contactPhone" value="<%=session("contactPhone")%>">
<input type="hidden" name="emailAddress" value="<%=session("emailAddress")%>">
<input type="hidden" name="suspended" value="No">
<input type="hidden" name="workAuth" value="<%=rsPreferences("workLegalStatus")%>">
<input type="hidden" name="workAuthProof" value="<%=rsPreferences("workLegalProof")%>">
<input type="hidden" name="workTypeDesired" value="<%=rsPreferences("schedule")%>">
<input type="hidden" name="title" value="<%=user_lastname%>,  <%=user_firstname%> - online resume">
		<table width="100%" border="0" cellspacing="2" cellpadding="4" bgcolor="#FFFFFF">	
		<TR>
			<TD align="left" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="2">
				<tr>
					<td bgcolor="#C7D2E0"><font size="+1"><%=user_firstname%>&nbsp;<%=user_lastname%></font></td>
				</tr>
				<tr>
					<td><%=session("addressOne")%></td>
				</tr>
<% if session("addressTwo") <> "" then%>
				<tr>
					<td><%=session("addressTwo")%></td>
				</tr>
<% end if %>				

				<tr>
					<td><%=session("city")%>, <%=session("state")%>&nbsp;<%=user_zip%></td>
				</tr>
				<tr>
					<td><%=session("contactPhone")%></td>
				</tr>	
				<tr>
					<td><%=session("emailAddress")%></td>
				</tr>
				<tr>
					<td><!-- <a href="applyOnline.asp"><font style class="smallTxt">edit this profile</font></a> --></td>
				</tr>				
			</table>			
			</TD>
			<td align="right">
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
				<td colspan="2" align="right"> Are you 18 years or older?
				<select size="1" name="workAge">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes</option>				
				<option value="No">No</option>
				</select>				
				</td>
				</tr>						

				<tr>
				<td colspan="2" align="right"> Do you have a valid Drivers License?
				<select size="1" name="workValidLicense">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes</option>				
				<option value="No">No</option>			
				</select>
				</td>
				</tr>	
				<tr>
				<td colspan="2" align="right">Type of Drivers License (optional):
				<select size="1" name="workLicenseType">
					<option value="">-- Select One --</option>
					<option value="CDL-A">CDL-A</option>
					<option value="CDL-B">CDL-B</option>	
					<option value="CDL-C">CDL-C</option>								
				</select>
				</td>
				</tr>
				<tr>
				<td colspan="2" align="right">Have you ever been convicted of a crime?<br>
				<select size="1" name="workConviction">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes - I have been convicted of a felony in the U.S.</option>				
				<option value="No">No - I have never been convicted of a felony in the U.S.</option>
				</select>				
				</td>
				</tr>														
			</table>
			</td>
		</TR>	
	<tr>
		<td colspan="2" align="center" bgcolor="#C7D2E0" height="20"><strong>Your areas of knowledge and experience:</strong></td>
	</tr>
	<tr> 
		<td colspan="2" align="center"><font size="1">To select more than one skill, press and hold the [CTRL] key while clicking with your mouse.</font></td>
	</tr>		
				
	<tr>
		<td colspan="2" align="center" width="100%">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center" STYLE CLASS="resumeTD">Software</td>
				<td align="center" STYLE CLASS="resumeTD">Clerical</td>
				<td align="center" STYLE CLASS="resumeTD">Industrial</td>
				<td align="center" STYLE CLASS="resumeTD">Management</td>					
			</tr>			
			<tr>
				<td align="center" valign="top">
				<select multiple size="6" name="skillsSoftware">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Abstat">Abstat</option>
					<option value="ACT!">ACT!</option>					
					<option value="Illustrator">Adobe Illustrator</option>
					<option value="Photoshop">Adobe Photoshop</option>										
					<option value="Acrobat Reader">Acrobat Reader</option>
					<option value="CYMA ">CYMA</option>
					<option value="Execustat">Execustat</option>								
					<option value="Lotus">Lotus</option>	
					<option value="Macintosh">Macintosh</option>
					<option value="MS Access">MS Access</option>						
					<option value="MS Excel">MS Excel</option>
					<option value="MS Exchange">MS Exchange</option>						
					<option value="MS Fax">MS Fax</option>
					<option value="MS Frontpage">MS Frontpage</option>						
					<option value="MS Money">MS Money</option>
					<option value="MS Outlook">MS Outlook</option>
					<option value="MS PowerPoint">MS PowerPoint </option>
					<option value="MS Publisher">MS Publisher</option>															
					<option value="MS Word">MS Word</option>											
					<option value="Peachtree">Peachtree</option>						
					<option value="Quattro Pro">Quattro Pro</option>					
					<option value="Quickbooks">Quickbooks</option>		
					<option value="Windows 98">Windows 98</option>	
					<option value="Windows 98">Windows ME</option>					
					<option value="Windows 2000">Windows 2000</option>	
					<option value="Windows XP">Windows XP</option>	
					<option value="WordPerfect">WordPerfect</option>																																																																																																																																																					
				</select>
				</td>
				<td align="center" valign="top">
				<select multiple size="6" name="skillsClerical">
					<option value="Chose None">- Select all that apply -</option>
					<option value="10-key">10-key</option>					
					<option value="Cashier">Cashier</option>	
					<option value="Cost Accounting">Cost Accounting</option>	
					<option value="Credit/Collection">Credit/Collection</option>					
					<option value="Customer Service">Customer Service</option>	
					<option value="Data Entry">Data Entry</option>	
					<option value="Dictation">Dictation</option>					
					<option value="Fax/Copier">Fax/Copier</option>	
					<option value="Filing">Filing</option>
					<option value="Legal office">Legal office</option>									
					<option value="Mailing">Mailing</option>	
					<option value="Medical office">Medical office</option>	
					<option value="Medical terminology">Medical terminology</option>						
					<option value="Mortgage">Mortgage</option>									
					<option value="Payroll">Payroll</option>	
					<option value="Phone">Phone</option>	
					<option value="Proofreading">Proofreading</option>	
					<option value="Receptionist">Receptionist</option>	
					<option value="Switchboard">Switchboard</option>
					<option value="Speed Writing">Speed Writing</option>						
					<option value="Teller">Teller</option>	
					<option value="Title/Escrow">Title/Escrow</option>																					
					<option value="Typist">Typist</option>
					<option value="Word Processing">Word Processing</option>						
				</select>				
				</td>
				<td align="center" valign="top">
				<select multiple size="6" name="skillsIndustrial">
					<option value="Chose None">- Select all that apply -</option>				
					<option value="Electrical">Electrical</option>
					<option value="Electronics">Electronics</option>
					<option value="Fish Processing">Fish Processing</option>					
					<option value="Forklift Operator">Forklift Operator</option>					
					<option value="Hydraulics">Hydraulics</option>				
					<option value="Heavy Labor">Heavy Labor</option>
					<option value="Lab">Lab</option>					
					<option value="Light Labor">Light Labor</option>	
					<option value="Maintenance">Maintenance</option>									
					<option value="Machine Operator">Machine Operator</option>
					<option value="Packaging">Packaging</option>
					<option value="Palletizing">Palletizing</option>					
					<option value="Quality Assurance">Quality Assurance</option>
					<option value="Sanitation">Sanitation</option>					
					<option value="Shipping/Receiving">Shipping/Receiving</option>																																																																		
					<option value="Warehouse">Warehouse</option>	
				</select>				
				</td>	
				<td align="center" valign="top">
				<select multiple size="6" name="skillsManagement">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Accounting">Accounting</option>
					<option value="CPA">CPA</option>	
					<option value="Contruction">Contruction</option>
					<option value="Engineering">Engineering</option>										
					<option value="Farm">Farm</option>
					<option value="Financial Management ">Financial Management </option>	
					<option value="General Management">General Management</option>	
					<option value="Human Resources">Human Resources</option>											
					<option value="Information Systems">Information Systems</option>
					<option value="Public Relations">Public Relations</option>	
					<option value="Purchasing">Purchasing</option>	
					<option value="Quality Assurance">Quality Assurance</option>	
					<option value="Sales">Sales</option>	
					<option value="Technical">Technical</option>					
				</select>				
				</td>							
			</tr>
			<tr>
				<td align="center" STYLE CLASS="resumeTD">Bookkeeping</td>	
				<td align="center" STYLE CLASS="resumeTD">Sales</td>
				<td align="center" STYLE CLASS="resumeTD">Technical</td>	
				<td align="center" STYLE CLASS="resumeTD">Food Service</td>																
			</tr>
			<tr>
				<td align="center" valign="top">
				<select multiple size="6" name="skillsBookkeeping">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Accounting">Accounting</option>		
					<option value="Accounts Payable">Accounts Payable</option>								
					<option value="Accounts Receivable">Accounts Receivable</option>	
					<option value="Bank Reconciliation">Bank Reconciliation</option>
					<option value="Financial Statements">Financial Statements</option>
					<option value="Month End Close">Month End Close</option>										
					<option value="Payroll">Payroll</option>					
					<option value="Posting">Posting</option>
					<option value="Tax">Tax</option>						
					<option value="Trial Balance">Trial Balance</option>	
				</select>					
				</td>
				<td valign="top" align="center">
				<select multiple size="6" name="skillsSales">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Display Setup">Display Setup</option>					
					<option value="Marketing">Marketing</option>
					<option value="Outside Sales">Outside Sales</option>					
					<option value="Product Demo">Product Demo</option>										
					<option value="Retail Sales">Retail Sales</option>
					<option value="Route Sales">Route Sales</option>					
					<option value="Survey">Survey</option>						
					<option value="Telemarketing">Telemarketing</option>									
				</select>								
				</td>
				<td valign="top" align="center">				
				<select multiple size="6" name="skillsTechnical">
					<option value="Chose None">- Select all that apply -</option>
					<option value="CAD Drafting">CAD Drafting</option>
					<option value="Computer Networks">Computer Networks</option>					
					<option value="Computer Tech.">Computer Tech.</option>					
					<option value="Copier Tech.">Copier Tech.</option>
					<option value="Electronics Tech.">Electronics Tech.</option>															
					<option value="Engineer">Engineer</option>
					<option value="Help Desk">Help Desk</option>
					<option value="Telecom Tech.">Telecom Tech.</option>												
					<option value="Wireless">Wireless</option>																
				</select>
				</td>
				<td valign="top" align="center">
				<select multiple size="6" name="skillsFoodService">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Banquet">Banquet</option>											
					<option value="Chef">Chef</option>	
					<option value="Delivery">Delivery</option>						
					<option value="Dishwasher">Dishwasher</option>	
					<option value="Hostess">Hostess</option>	
					<option value="Line Cook">Line Cook</option>						
					<option value="Sanitation">Sanitation</option>									
					<option value="Supervisor">Supervisor</option>				
					<option value="Waitress">Waitress</option>					
					<option value="Warehouse">Warehouse</option>																				
				</select>				
				</td>									
			</tr>
			<tr>
				<td align="center" STYLE CLASS="resumeTD">Construction</td>
				<td align="center" STYLE CLASS="resumeTD">Health Care</td>	
				<td align="center" STYLE CLASS="resumeTD">General Labor</td>	
				<td align="center" STYLE CLASS="resumeTD">Skilled Labor</td>										
			</tr>
			<tr>
				<td align="center" valign="top">
				<select multiple size="6" name="skillsConstruction">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Concrete Rough">Concrete Rough</option>
					<option value="Concrete Finish">Concrete Finish</option>					
					<option value="Carpenter Rough">Carpenter Rough</option>	
					<option value="Carpenter Finish">Carpenter Finish</option>						
					<option value="Drywall/Sheetrock">Drywall/Sheetrock</option>
					<option value="Electrician">Electrician</option>	
					<option value="Flagger">Flagger</option>									
					<option value="Framing">Framing</option>						
					<option value="General Labor">General Labor</option>					
					<option value="HVAC">HVAC</option>	
					<option value="Landscaping">Landscaping</option>						
					<option value="Painting">Painting</option>
					<option value="Plumber">Plumber</option>					
					<option value="Machinist">Read Blueprints</option>
					<option value="Machinist">Roofing</option>
					<option value="Siding">Siding</option>						
				</select>				
				</td>
				<td align="center" valign="top">
				<select multiple size="6" name="skillsHealthCare">
					<option value="Chose None">- Select all that apply -</option>
					<option value="CMA">CMA</option>					
					<option value="CNA">CNA</option>
					<option value="Dental Assistant">Dental Assistant</option>
					<option value="Dietary">Dietary</option>
					<option value="General Labor">General Labor</option>
					<option value="Housekeeping">Housekeeping</option>																									
					<option value="LPN">LPN</option>					
					<option value="Lab Technician">Lab Technician</option>																										
					<option value="RN">RN</option>	
					<option value="Ward Clerk">Ward Clerk</option>						
				</select>				
				</td>				

				<td align="center" valign="top">
				<select multiple size="6" name="skillsGeneralLabor">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Cleanup">Cleanup</option>
					<option value="Dairy">Dairy</option>	
					<option value="Delivery">Delivery</option>									
					<option value="Farm / Field">Farm / Field</option>	
					<option value="Floral">Floral</option>
					<option value="Housekeeping">Housekeeping</option>																			
					<option value="Inventory">Inventory</option>	
					<option value="Janitorial">Janitorial</option>
					<option value="Landscaping">Landscaping</option>												
					<option value="Security">Security</option>				
					<option value="Shipping/Receiving">Shipping/Receiving</option>								
					<option value="Sprinkler">Sprinkler</option>
					<option value="Warehouse">Warehouse</option>					
					<option value="Yards & Grounds">Yards & Grounds</option>																														
				</select>					
				</td>
				<td valign="top" align="center">
				<select multiple size="6" name="skillsSkilledLabor">
					<option value="Chose None">- Select all that apply -</option>
					<option value="Auto Mechanic">Auto Mechanic</option>					
					<option value="Cabinet Maker">Cabinet Maker</option>						
					<option value="Diesel Mechanic">Diesel Mechanic</option>	
					<option value="Glazier">Glazier</option>													
					<option value="Machine Operator">Machine Operator</option>									
					<option value="Machinist">Machinist</option>
					<option value="Mill/Lathe">Mill/Lathe</option>
					<option value="Molding">Molding</option>
					<option value="Plastic/Injection">Plastic/Injection</option>										
					<option value="Small Engine">Small Engine</option>													
					<option value="Tool & Die">Tool & Die</option>									
					<option value="Welder">Welder</option>																	
				</select>				
				</td>				
			</tr>
			<tr>
				<td colspan="4" align="center"><img src="/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
			</tr>							
			<tr>
				<td colspan="4" align="center" bgcolor="#C7D2E0"><strong>Job Objective(s) and Work Summary</strong></td>
			</tr>
			<tr>
				<td colspan="4" align="center">
				<TEXTAREA wrap="soft" cols="58" rows="3" name="jobObjective"></TEXTAREA>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center"><img src="/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
			</tr>										
			<tr>
				<td colspan="4" align="center" bgcolor="#C7D2E0"><strong>Current or most recent employer</strong>
				</td>
			</tr>
<!-- START Work Hist 1 -->			
			<tr>
				<td colspan="4" align="center" width="100%">
					<table border="0" cellpadding="4" cellspacing="0">
						<tr>
						 <td align="right" width="50%"> Job Title: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistTitleOne"></td>
						</tr>
						<tr>
						 <td align="right" width="50%"> Company Name: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistCpnyOne"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%"> Company Phone #: </td>
						 <td><INPUT type="text" size="12" maxlength="15" name="jobHistPhoneOne"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%">From Date:
<SELECT name="jobHistSMonthOne" style="font-size: 9pt;">
		<option value="">----</option>	
		<option value="1">Jan</option>
		<option value="2">Feb</option>
		<option value="3">Mar</option>
		<option value="4">Apr</option>
		<option value="5">May</option>
		<option value="6">Jun</option>
		<option value="7">Jul</option>
		<option value="8">Aug</option>
		<option value="9">Sep</option>
		<option value="10">Oct</option>
		<option value="11">Nov</option>
		<option value="12">Dec</option>																								
</SELECT>
<SELECT name="jobHistSYearOne" style="font-size: 9pt;">
		<option value="">----</option>	
		<option value="2006">2006</option>	
		<option value="2005">2005</option>	
		<option value="2004">2004</option>							
		<option value="2003">2003</option>	
		<option value="2002">2002</option>	
		<option value="2001">2001</option>
		<option value="2000">2000</option>
		<option value="1999">1999</option>
		<option value="1998">1998</option>
		<option value="1997">1997</option>	
		<option value="1996">1996</option>	
		<option value="1995">1995</option>	
		<option value="1994">1994</option>	
		<option value="1993">1993</option>	
		<option value="1992">1992</option>	
		<option value="1991">1991</option>	
		<option value="1990">1990</option>			
		<option value="1989">1989</option>
		<option value="1988">1988</option>
		<option value="1987">1987</option>					
		<option value="1986">1986</option>
		<option value="1985">1985</option>
		<option value="1984">1984</option>
		<option value="1983">1983</option>	
		<option value="1982">1982</option>
		<option value="1981">1981</option>
		<option value="1980">1980</option>
		<option value="1979">1979</option>
		<option value="1978">1978</option>
		<option value="1977">1977</option>
		<option value="1976">1976</option>
		<option value="1975">1975</option>
		<option value="1974">1974</option>
		<option value="1973">1973</option>
		<option value="1972">1972</option>
		<option value="1971">1971</option>
		<option value="1970">1970</option>
		<option value="1969">1969</option>																																																	
</SELECT>&nbsp;&nbsp;					 
						 </td>
						 <td>To Date:
<SELECT name="jobHistEMonthOne" style="font-size: 9pt;">
		<option value="">----</option>	
		<option value="6" SELECTED>Present</option>						
		<option value="1">Jan</option>
		<option value="2">Feb</option>
		<option value="3">Mar</option>
		<option value="4">Apr</option>
		<option value="5">May</option>
		<option value="6">Jun</option>
		<option value="7">Jul</option>
		<option value="8">Aug</option>
		<option value="9">Sep</option>
		<option value="10">Oct</option>
		<option value="11">Nov</option>
		<option value="12">Dec</option>																								
</SELECT>
<SELECT name="jobHistEYearOne" style="font-size: 9pt;">
		<option value="">-------</option>		
		<option value="2003" SELECTED>Present</option>
		<option value="2006">2006</option>	
		<option value="2005">2005</option>	
		<option value="2004">2004</option>							
		<option value="2003">2003</option>	
		<option value="2002">2002</option>	
		<option value="2001">2001</option>
		<option value="2000">2000</option>
		<option value="1999">1999</option>
		<option value="1998">1998</option>
		<option value="1997">1997</option>	
		<option value="1996">1996</option>	
		<option value="1995">1995</option>	
		<option value="1994">1994</option>	
		<option value="1993">1993</option>	
		<option value="1992">1992</option>	
		<option value="1991">1991</option>	
		<option value="1990">1990</option>			
		<option value="1989">1989</option>
		<option value="1988">1988</option>
		<option value="1987">1987</option>					
		<option value="1986">1986</option>
		<option value="1985">1985</option>
		<option value="1984">1984</option>
		<option value="1983">1983</option>	
		<option value="1982">1982</option>
		<option value="1981">1981</option>
		<option value="1980">1980</option>
		<option value="1979">1979</option>
		<option value="1978">1978</option>
		<option value="1977">1977</option>
		<option value="1976">1976</option>
		<option value="1975">1975</option>
		<option value="1974">1974</option>
		<option value="1973">1973</option>
		<option value="1972">1972</option>
		<option value="1971">1971</option>
		<option value="1970">1970</option>
		<option value="1969">1969</option>																																																	
</SELECT>							 
						 </td>						 
						</tr>
					</table>
				</td>
			</tr>
<!-- END Work Hist 1 -->			
			<tr>
				<td colspan="4" align="center" bgcolor="#C7D2E0"><strong>2nd most recent employer </strong>
				</td>
			</tr>
<!-- START Work Hist 2 -->			
			<tr>
				<td colspan="4" align="center">
					<table border="0" cellpadding="4" cellspacing="0">
						<tr>
						 <td align="right" width="50%"> Job Title: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistTitleTwo"></td>
						</tr>
						<tr>
						 <td align="right" width="50%"> Company Name: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistCpnyTwo"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%"> Company Phone #: </td>
						 <td><INPUT type="text" size="12" maxlength="15" name="jobHistPhoneTwo"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%">From Date:
<SELECT name="jobHistSMonthTwo" style="font-size: 9pt;">
		<option value="">----</option>	
		<option value="1">Jan</option>
		<option value="2">Feb</option>
		<option value="3">Mar</option>
		<option value="4">Apr</option>
		<option value="5">May</option>
		<option value="6">Jun</option>
		<option value="7">Jul</option>
		<option value="8">Aug</option>
		<option value="9">Sep</option>
		<option value="10">Oct</option>
		<option value="11">Nov</option>
		<option value="12">Dec</option>																								
</SELECT>
<SELECT name="jobHistSYearTwo" style="font-size: 9pt;">
		<option value="">----</option>	
		<option value="2006">2006</option>	
		<option value="2005">2005</option>	
		<option value="2004">2004</option>							
		<option value="2003">2003</option>		
		<option value="2002">2002</option>	
		<option value="2001">2001</option>
		<option value="2000">2000</option>
		<option value="1999">1999</option>
		<option value="1998">1998</option>
		<option value="1997">1997</option>	
		<option value="1996">1996</option>	
		<option value="1995">1995</option>	
		<option value="1994">1994</option>	
		<option value="1993">1993</option>	
		<option value="1992">1992</option>	
		<option value="1991">1991</option>	
		<option value="1990">1990</option>			
		<option value="1989">1989</option>
		<option value="1988">1988</option>
		<option value="1987">1987</option>					
		<option value="1986">1986</option>
		<option value="1985">1985</option>
		<option value="1984">1984</option>
		<option value="1983">1983</option>	
		<option value="1982">1982</option>
		<option value="1981">1981</option>
		<option value="1980">1980</option>
		<option value="1979">1979</option>
		<option value="1978">1978</option>
		<option value="1977">1977</option>
		<option value="1976">1976</option>
		<option value="1975">1975</option>
		<option value="1974">1974</option>
		<option value="1973">1973</option>
		<option value="1972">1972</option>
		<option value="1971">1971</option>
		<option value="1970">1970</option>
		<option value="1969">1969</option>																																																	
</SELECT>&nbsp;&nbsp;					 
						 </td>
						 <td>To Date:
<SELECT name="jobHistEMonthTwo" style="font-size: 9pt;">
		<option value="">----</option>							
		<option value="1">Jan</option>
		<option value="2">Feb</option>
		<option value="3">Mar</option>
		<option value="4">Apr</option>
		<option value="5">May</option>
		<option value="6">Jun</option>
		<option value="7">Jul</option>
		<option value="8">Aug</option>
		<option value="9">Sep</option>
		<option value="10">Oct</option>
		<option value="11">Nov</option>
		<option value="12">Dec</option>																								
</SELECT>
<SELECT name="jobHistEYearTwo" style="font-size: 9pt;">
		<option value="">-------</option>		
		<option value="2006">2006</option>	
		<option value="2005">2005</option>	
		<option value="2004">2004</option>							
		<option value="2003">2003</option>		
		<option value="2002">2002</option>	
		<option value="2001">2001</option>
		<option value="2000">2000</option>
		<option value="1999">1999</option>
		<option value="1998">1998</option>
		<option value="1997">1997</option>	
		<option value="1996">1996</option>	
		<option value="1995">1995</option>	
		<option value="1994">1994</option>	
		<option value="1993">1993</option>	
		<option value="1992">1992</option>	
		<option value="1991">1991</option>	
		<option value="1990">1990</option>			
		<option value="1989">1989</option>
		<option value="1988">1988</option>
		<option value="1987">1987</option>					
		<option value="1986">1986</option>
		<option value="1985">1985</option>
		<option value="1984">1984</option>
		<option value="1983">1983</option>	
		<option value="1982">1982</option>
		<option value="1981">1981</option>
		<option value="1980">1980</option>
		<option value="1979">1979</option>
		<option value="1978">1978</option>
		<option value="1977">1977</option>
		<option value="1976">1976</option>
		<option value="1975">1975</option>
		<option value="1974">1974</option>
		<option value="1973">1973</option>
		<option value="1972">1972</option>
		<option value="1971">1971</option>
		<option value="1970">1970</option>
		<option value="1969">1969</option>																																																	
</SELECT>							 
						 </td>						 
						</tr>
					</table>
				</td>
			</tr>
<!-- END Work Hist 2 -->	
<tr>
				<td colspan="4" align="center" bgcolor="#C7D2E0"><strong>3rd most recent employer</strong>
				</td>
			</tr>
<!-- START Work Hist 3 -->			
			<tr>
				<td colspan="4" align="center">
					<table border="0" cellpadding="4" cellspacing="0">
						<tr>
						 <td align="right" width="50%"> Job Title: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistTitleThree"></td>
						</tr>
						<tr>
						 <td align="right" width="50%"> Company Name: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistCpnyThree"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%"> Company Phone #: </td>
						 <td><INPUT type="text" size="12" maxlength="15" name="jobHistPhoneThree"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%">From Date:
<SELECT name="jobHistSMonthThree" style="font-size: 9pt;">
		<option value="">----</option>	
		<option value="1">Jan</option>
		<option value="2">Feb</option>
		<option value="3">Mar</option>
		<option value="4">Apr</option>
		<option value="5">May</option>
		<option value="6">Jun</option>
		<option value="7">Jul</option>
		<option value="8">Aug</option>
		<option value="9">Sep</option>
		<option value="10">Oct</option>
		<option value="11">Nov</option>
		<option value="12">Dec</option>																								
</SELECT>
<SELECT name="jobHistSYearThree" style="font-size: 9pt;">
		<option value="">----</option>	
		<option value="2006">2006</option>	
		<option value="2005">2005</option>	
		<option value="2004">2004</option>							
		<option value="2003">2003</option>	
		<option value="2002">2002</option>	
		<option value="2001">2001</option>
		<option value="2000">2000</option>
		<option value="1999">1999</option>
		<option value="1998">1998</option>
		<option value="1997">1997</option>	
		<option value="1996">1996</option>	
		<option value="1995">1995</option>	
		<option value="1994">1994</option>	
		<option value="1993">1993</option>	
		<option value="1992">1992</option>	
		<option value="1991">1991</option>	
		<option value="1990">1990</option>			
		<option value="1989">1989</option>
		<option value="1988">1988</option>
		<option value="1987">1987</option>					
		<option value="1986">1986</option>
		<option value="1985">1985</option>
		<option value="1984">1984</option>
		<option value="1983">1983</option>	
		<option value="1982">1982</option>
		<option value="1981">1981</option>
		<option value="1980">1980</option>
		<option value="1979">1979</option>
		<option value="1978">1978</option>
		<option value="1977">1977</option>
		<option value="1976">1976</option>
		<option value="1975">1975</option>
		<option value="1974">1974</option>
		<option value="1973">1973</option>
		<option value="1972">1972</option>
		<option value="1971">1971</option>
		<option value="1970">1970</option>
		<option value="1969">1969</option>																																																	
</SELECT>&nbsp;&nbsp;					 
						 </td>
						 <td>To Date:
<SELECT name="jobHistEMonthThree" style="font-size: 9pt;">
		<option value="">----</option>						
		<option value="1">Jan</option>
		<option value="2">Feb</option>
		<option value="3">Mar</option>
		<option value="4">Apr</option>
		<option value="5">May</option>
		<option value="6">Jun</option>
		<option value="7">Jul</option>
		<option value="8">Aug</option>
		<option value="9">Sep</option>
		<option value="10">Oct</option>
		<option value="11">Nov</option>
		<option value="12">Dec</option>																								
</SELECT>
<SELECT name="jobHistEYearThree" style="font-size: 9pt;">
		<option value="">-------</option>		
		<option value="2006">2006</option>	
		<option value="2005">2005</option>	
		<option value="2004">2004</option>							
		<option value="2003">2003</option>	
		<option value="2002">2002</option>	
		<option value="2001">2001</option>
		<option value="2000">2000</option>
		<option value="1999">1999</option>
		<option value="1998">1998</option>
		<option value="1997">1997</option>	
		<option value="1996">1996</option>	
		<option value="1995">1995</option>	
		<option value="1994">1994</option>	
		<option value="1993">1993</option>	
		<option value="1992">1992</option>	
		<option value="1991">1991</option>	
		<option value="1990">1990</option>			
		<option value="1989">1989</option>
		<option value="1988">1988</option>
		<option value="1987">1987</option>					
		<option value="1986">1986</option>
		<option value="1985">1985</option>
		<option value="1984">1984</option>
		<option value="1983">1983</option>	
		<option value="1982">1982</option>
		<option value="1981">1981</option>
		<option value="1980">1980</option>
		<option value="1979">1979</option>
		<option value="1978">1978</option>
		<option value="1977">1977</option>
		<option value="1976">1976</option>
		<option value="1975">1975</option>
		<option value="1974">1974</option>
		<option value="1973">1973</option>
		<option value="1972">1972</option>
		<option value="1971">1971</option>
		<option value="1970">1970</option>
		<option value="1969">1969</option>																																																	
	</SELECT>							 
						 </td>						 
						</tr>
						
					</table>
				</td>
			</tr>	<!-- END Work Hist 3 -->	
			<tr>
				<td colspan="4" align="center"><img src="/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
			</tr>			
			<tr>
			<td colspan="3" align="center"><strong>What is the highest level of education you have completed?</strong></td>
			<td>
		<SELECT name="eduLevel">
		<option value="">-- Select One --</option>
		<option value="None">None</option>	
		<option value="High School">High School Diploma or GED</option>			
		<option value="2 Year">2 Year Degree</option>
		<option value="4 Year">4 Year Degree</option>
		<option value="Graduate School">Graduate Degree</option>		
		</SELECT>
			</td>		
			</tr>	
			<tr>
				<td colspan="4" align="center"><img src="/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
			</tr>					
			<tr>
			<td colspan="4" align="left" bgcolor="#C7D2E0"><strong>Any additional information? (spoken languages, associations, awards...)</strong></font></td>
			</tr>		
			<tr>
			<td colspan="4" align="center">	
<TEXTAREA wrap=soft cols=65 rows="2" name="additionalInfo"></TEXTAREA>		
			</td>
			</tr>
			<tr>
				<td colspan="4" align="center"><img src="/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
			</tr>				
		
		  </table>
		</td>
	</tr>	
	<tr>
		<td colspan="2" align="center" valign="top">
<font size="1" face="Helvetica">I agree that my employment with Personnel Plus may be terminated at any time with liability to me for wages or salary except such as may have been earned at the date of such termination. I understand that my compensation from Personnel Plus shall be limited to the duration of any temporary assignment hereunder. I agree that if at any time I sustain a work-related injury, I will submit myself to a drug/alcohol test and to an examination by a physician of the company's selection.	</font>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<INPUT TYPE="button" name="submit_btn" style="background:#003399; border:1 #C7D2E0 solid; font-size:9px; font-weight:bold; color:#FFFFFF;" VALUE="Save & Send Resume Now!" onClick="validateResume()">&nbsp;&nbsp;&nbsp;<INPUT TYPE="button" name="reset_btn" VALUE="Undo Changes & Start Over" onClick="javascript:document.onlineResume.reset();">
		</td>
	</tr>						
</TABLE>
</FORM>
	</td>
  </tr>
</table>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/inc/navi_btm.asp' -->
</BODY>
</HTML>