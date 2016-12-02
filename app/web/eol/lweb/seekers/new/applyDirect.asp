<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/method.vb' -->
<HTML>
<HEAD>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META NAME="URL" CONTENT="HTTP://www.personnelplus-inc.com">
<link rel="stylesheet" href="/style/default.css">
<title>Direct Application for Personnel Plus, Inc.</title>
<!-- #INCLUDE VIRTUAL='/lweb/js/applyDirect.js' -->
</HEAD>
<BODY>
<noscript>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</noscript>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<BR> To apply, select the office location closest to you from the list below and 
complete the application that follows. The process takes 5-10 minutes and you 
only need to do this once in order to get registered with us!
<TABLE WIDTH=85% BORDER=0 CELLPADDING=0 CELLSPACING=2>
<% if request("gossner") = "true" then
	job_wanted = "Gossner Foods, Inc."
%>
		<tr>
			<td height="33">&nbsp;</td>
		</tr>
		<tr>
			<td align="center" height="37">
				<h3><%=job_wanted %>&nbsp;Referral</h3>
			</td>
  		</TR>
 <% end if %>

<!--FORM NAME="applyDirect" METHOD="POST" ACTION="applyDirect2.asp"-->
<FORM name="applyDirect" method="post" action="">
  		<TR>
			<TD ALIGN="center" height="182">
				<STRONG><FONT COLOR="#dc143c">STEP 1:</FONT> Choose An Office Nearest You -></STRONG> 
				<SELECT NAME="officeSelector" SIZE="1">
					<OPTION VALUE="">-----Select Office-----</OPTION>
					<OPTION VALUE="boise@personnel.com">Boise, ID</OPTION>
					<OPTION VALUE="burley@personnel.com">Burley, ID</OPTION>	
					<OPTION VALUE="nampa@personnel.com">Caldwell, ID</OPTION>
					<OPTION VALUE="burley@personnel.com">Jerome, ID</OPTION>	
					<OPTION VALUE="nampa@personnel.com">Nampa, ID</OPTION>
					<OPTION VALUE="twin@personnel.com">Twin Falls, ID</OPTION>
					<option value="other">- Other -</option>
				</SELECT><br><br>
				If Other, please tell us where you are located:<br><br>
<input type="text" name="other_location" size="30" maxlength="75">				
  			</td>
  		</tr>
	<TR>
    <td width="100%" align="center"><strong><font color="#dc143c">STEP 
	2:</font> Personal Information & Preferences</strong><br><strong><%=job_wanted%></strong>
	</td>
  </tr>
  
  <tr>
    	<td align="center">
<input type="hidden" name="job_wanted" value="<%=job_wanted%>">
		<table width="100%" border="0" cellspacing="2" cellpadding="4" bgcolor="#FFFFFF">	
		<TR>
			<TD align="left" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="2">
				<tr>
					<td align="right"><font style class="smallTxt">First Name:</font></td><td> <input type="text" name="firstName" size="25" maxlength="30"></td>
				<tr>
					<td align="right"><font style class="smallTxt">Last Name:</font> </td><td><input type="text" name="lastName" size="25" maxlength="40"></td>
				</tr>				
				<tr>
					<td align="right"><font style class="smallTxt">Address:</font> </td><td><input type="text" name="addressOne" size="25" maxlength="120"></td>
				</tr>
				<tr>
					<td align="right"><font style class="smallTxt" color="#333333">
					Address:</font><br> <font size="1"  color="#333333">(line 2)</font></td><td><input type="text" name="addressTwo" size="25" maxlength="100"></td>
				</tr>		
				<tr>
					<td align="right"><font style class="smallTxt">City:</font> </td><td><input type="text" name="city" size="25" maxlength="30"> </td>
				</tr>
				<tr>
					<td align="right"><font style class="smallTxt">State:</font></td><td>
	<SELECT NAME="state">
		<% Do While NOT rsLocation.EOF %>
		<OPTION	VALUE="<%= rsLocation("LOCCODE")%>"
		<% If rsLocation("locCode") = "ID" then %>SELECTED<% End If %>> <%=rsLocation("locName") %></OPTION>
		<% rsLocation.MoveNext %>
		<% Loop %>	
	</SELECT>					
					</td>
				</tr>
				<tr>
					<td align="right"><font style class="smallTxt">Zip Code:</font> </td><td><input type="text" name="zipCode" size="10" maxlength="10"> </td>
				</tr>
				<tr>
					<td align="right"><font style class="smallTxt">Contact 
					Phone:</font> </td><td><input type="text" name="contactPhone" size="15" maxlength="15" onBlur="return ValidateForm()"></td>
				</tr>												
				<tr>
					<td align="right"><font style class="smallTxt">Contact 
					Email:</font> </td><td><input type="text" name="emailAddress" size="25" maxlength="75"></td>
				</tr>	
				<tr>
					<td colspan="2"><font style class="smallTxt">Desired 
					Salary/Wage:</font>
					&nbsp; $ <INPUT NAME="desiredWageAmount" TYPE="text" MAXLENGTH="20" SIZE="7">			
					</td>
				</tr>	
				<tr>
					<td colspan="2"><font style class="smallTxt">Minimum 
					Salary/Wage:</font>
					$ <INPUT NAME="minWageAmount" TYPE="text" MAXLENGTH="20" SIZE="7">			
					</td>
				</tr>						
			</table>			
			</TD>
			<td align="right" valign="top">
			<table width="100%" border="0" cellspacing="1" cellpadding="1">
				<tr>
				<td colspan="2" align="right"><font style class="smallTxt">What 
				type of work do you prefer?</font>
				<select size="1" name="workTypeDesired">
				<option value="">-- Select One --</option>			
				<option value="Full-Time">Full-Time</option>				
				<option value="Part-Time">Part-Time</option>
				</select>				
				</td>
				</tr>	
				<tr>
				<td colspan="2" align="right"><font style class="smallTxt">Are 
				you authorized to work in the U.S?</font>
				<select size="1" name="workAuth">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes</option>				
				<option value="No">No</option>
				</select>				
				</td>
				</tr>			
				<tr>
				<td colspan="2" align="right"><font style class="smallTxt">Do 
				you have proof of authorization?</font>
				<select size="1" name="workAuthProof">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes</option>				
				<option value="No">No</option>
				</select>				
				</td>
				</tr>	
				<tr>
				<td colspan="2" align="right"><font style class="smallTxt">Are 
				you 18 years or older?</font>
				<select size="1" name="workAge">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes</option>				
				<option value="No">No</option>
				</select>				
				</td>
				</tr>						

				<tr>
				<td colspan="2" align="right"><font style class="smallTxt">Do 
				you have a valid Drivers License?</font>
				<select size="1" name="workValidLicense">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes</option>				
				<option value="No">No</option>			
				</select>
				</td>
				</tr>	
				<tr>
				<td colspan="2" align="right"><font style class="smallTxt">
				Commercial License Type</font> <font size="1">(optional)</font>:
				<select size="1" name="workLicenseType">
					<option value="" selected>-- Select One --</option>
					<option>none</option>
					<option value="CDL-C">CDL-C</option>	
					<option value="CDL-B">CDL-B</option>											
					<option value="CDL-A">CDL-A</option>	
				</select>
				</td>
				</tr>
				<tr>
				<td colspan="2" align="right"><font style class="smallTxt"><strong>
				Are you planning to relocate for work?</strong></font><br>
				<select size="1" name="workRelocate">
				<option value="">-- Select One --</option>		
				<option value="N/A - I already reside in Idaho">N/A - I already 
				reside in Idaho</option>					
				<option value="Yes - I would move to Idaho for work reasons">Yes 
				- I would move to Idaho for work reasons</option>
				<option value="No">No - But I'd like to find work in my own 
				state</option>									

				</select>				
				</td>
				</tr>					
				<tr>
				<td colspan="2" align="right"><font style class="smallTxt"><strong>
				Have you ever been convicted of a felony?</strong></font><br>
				<select size="1" name="workConviction">
				<option value="">-- Select One --</option>			
				<option value="Yes">Yes - I have been convicted of a felony in 
				the U.S.</option>				
				<option value="No">No - I have never been convicted of a felony 
				in the U.S.</option>
				</select>				
				</td>
				</tr>	
				<tr>
				<td colspan="2" align="right" valign="top"><font size="1">If Yes 
				to above, please explain circumstances:</font><br>
				<textarea name="workConvictionExplain" rows="2" cols="33"></textarea></td>				
				</tr>																		
			</table>
			</td>
		</TR>	
		<TR>
			<td colspan="2" align="center"><br><strong>Highest level of education completed -></strong> 
			<SELECT name="eduLevel">
							<option value="" selected>-- Select One --</option>
							<option value="None">None</option>	
							<option value="GED">GED</option>			
							<option value="High School Diploma">High School 
							Diploma</option>			
							<option value="College Degree">College Degree</option>
							<option value="College (No Degree)">College (No 
							Degree)</option>		
							<option value="Graduate School">Graduate Degree</option>		
			</SELECT>
			
			</td>
		
		</TR>
		<tr>
			<td colspan="2" align="center"><br><br><strong>Preferred employer and job title: </strong><font size="1" color="#808080">(optional)</font></td>
		</tr>
		<tr>
<% if request("gossner") = "true" then %>
			<td colspan="2" align="center">
				<textarea wrap="soft" cols="50" rows="3" name="preferred"><%=job_wanted %></textarea>
			</td>
<% else %>
			<td colspan="2" align="center">
				<TEXTAREA wrap="soft" cols="50" rows="3" name="preferred"></TEXTAREA>
			</td>
<% end if %>
		</tr>
		<tr>
		  	<td align="center" colspan="2"  width="100%">
				<table border="0" cellpadding="2" cellspacing="0" width="100%">
					<tr>
						<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
					</tr>					
					<tr>
						<td colspan="4" align="center"><strong>
						Any additional information? (spoken languages, 
						associations, awards...)</strong> <font size="1" color="#808080">(optional)</font></td>
					</tr>
					<tr>
						<td colspan="4" align="center" valign="top">	
							<TEXTAREA wrap=soft cols=50 rows="3" name="additionalInfo"></TEXTAREA>		
						</td>
					</tr>	
					<tr>
						<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
					</tr>					
					<tr>
						<td colspan="4" align="center"><strong>
						Work References</strong></td>
					</tr>	
					<tr>
						<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="6" border="0"></td>
					</tr>						
					<tr>
						<td align="right">First/Last Name:&nbsp;&nbsp;</td>
						<td> <input type="text" name="referenceNameOne" size="26" maxlength="255"></td>
						<td align="right">Contact Phone #:&nbsp;&nbsp;</td>
						<td align="left"><input type="text" name="referencePhoneOne" size="15" maxlength="20"></td>				
					</tr>
					<tr>
						<td align="right">First/Last Name:&nbsp;&nbsp;</td>
						<td> <input type="text" name="referenceNameTwo" size="26" maxlength="255"></td>
						<td align="right">Contact Phone #:&nbsp;&nbsp;</td>
						<td align="left"><input type="text" name="referencePhoneTwo" size="15" maxlength="20"></td>				
					</tr>
					<tr>
						<td align="right">First/Last Name:&nbsp;&nbsp;</td>
						<td> <input type="text" name="referenceNameThree" size="26" maxlength="255"></td>
						<td align="right">Contact Phone #:&nbsp;&nbsp;</td>
						<td align="left"><input type="text" name="referencePhoneThree" size="15" maxlength="20"></td>				
					</tr>								
					<tr>
						<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
					</tr>				
			  	</table>
		  	</td>
		</tr>
		<tr>
		  	<td align="center" colspan="2" height="20" bgcolor="#f5f5dc">
				<strong><FONT COLOR="dc143c">STEP 3:</FONT> STOP here if you wish to 
				<INPUT TYPE="button" name="email_resume" STYLE="background:#dc143c; border:1 #333333 solid; font-size:11px; color:#FFFFFF" VALUE="Attach Your Resume" onClick="checkApplyDirect2()">
		  		<br>If you do not wish to attach a resume, complete the rest of the form below.
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
		</tr>	
		<tr>
			<td colspan="2" align="center"><strong><FONT COLOR="dc143c">STEP 4:</FONT>Skills & Work History</strong></td>
		</tr>				
		<tr> 
			<td colspan="2" align="center"><font size="1">To select more than 
			one skill, press and hold the [CTRL] key while clicking with your 
			mouse.</font></td>
		</tr>					
		<tr>
			<td colspan="2" align="center" width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td align="center" width="25%" STYLE CLASS="resumeTD">
					Clerical</td>
					<td align="center" width="25%" STYLE CLASS="resumeTD">
					Customer Service</td>
					<td align="center" width="25%" STYLE CLASS="resumeTD">
					Industrial</td>
					<td align="center" width="25%" STYLE CLASS="resumeTD">
					General Labor</td>					
				</tr>			
				<tr>
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
						<option value="Medical Office">Medical Office</option>	
						<option value="Medical Terminology">Medical Terminology</option>						
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
					<select multiple size="6" name="skillsCustomerSvc">
						<option value="Chose None">- Select all that apply -</option>
						<option value="Billing Support">Billing Support</option>					
						<option value="Catalog Sales">Catalog Sales</option>
						<option value="Call Monitor">Call Monitor</option>	
						<option value="Floor Lead">Floor Lead</option>									
						<option value="Help Desk">Help Desk</option>	
						<option value="New Hire Training">New Hire Training</option>	
						<option value="Operations">Operations</option>														
						<option value="Order Desk">Order Desk</option>									
						<option value="Phone Surveys">Phone Surveys</option>
						<option value="Phone Teller">Phone Teller</option>	
						<option value="Product Support">Product Support</option>	
						<option value="Quality">Quality</option>													
						<option value="Renewals">Renewals</option>					
						<option value="Subscriptions">Subscriptions</option>					
						<option value="Support Representative">Support 
						Representative</option>
						<option value="Telemarketing">Telemarketing</option>																					
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
					<select multiple size="6" name="skillsGeneralLabor">
						<option value="Chose None">- Select all that apply -</option>
						<option value="Cleanup">Cleanup</option>
						<option value="Dairy">Dairy</option>	
						<option value="Delivery">Delivery</option>		
						<option value="Delivery">Factory</option>													
						<option value="Farm/Field">Farm/Field</option>	
						<option value="Floral">Floral</option>
						<option value="Housekeeping">Housekeeping</option>																			
						<option value="Inventory">Inventory</option>	
						<option value="Janitorial">Janitorial</option>
						<option value="Landscaping">Landscaping</option>												
						<option value="Security">Security</option>				
						<option value="Shipping/Receiving">Shipping/Receiving</option>								
						<option value="Sprinkler">Sprinkler</option>
						<option value="Warehouse">Warehouse</option>					
						<option value="Yards & Grounds">Yards &amp; Grounds</option>																														
					</select>	
					</td>							
				</tr>
				<tr>
					<td align="center" STYLE CLASS="resumeTD">Construction</td>	
					<td align="center" STYLE CLASS="resumeTD">Skilled Labor</td>
					<td align="center" STYLE CLASS="resumeTD">Bookkeeping</td>	
					<td align="center" STYLE CLASS="resumeTD">Sales</td>																
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
						<option value="Foreman">Foreman</option>													
						<option value="Framing">Framing</option>						
						<option value="General Labor">General Labor</option>					
						<option value="HVAC">HVAC</option>	
						<option value="Landscaping">Landscaping</option>						
						<option value="Painting">Painting</option>
						<option value="Plumber">Plumber</option>					
						<option value="Read Blueprints">Read Blueprints</option>
						<option value="Roofing">Roofing</option>
						<option value="Siding">Siding</option>						
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
						<option value="Tool & Die">Tool &amp; Die</option>									
						<option value="Welder">Welder</option>	
						<option value="Welder">- HEALTH CARE -</option>	
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
					<td valign="top" align="center">				
					<select multiple size="6" name="skillsBookkeeping">
						<option value="Chose None">- Select all that apply -</option>
						<option value="Accounting">Accounting</option>		
						<option value="Accounts Payable">Accounts Payable</option>								
						<option value="Accounts Receivable">Accounts Receivable</option>	
						<option value="Bank Reconciliation">Bank Reconciliation</option>
						<option value="Financial Statements">Financial 
						Statements</option>
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
						<option value="Inside Sales">Inside Sales</option>										
						<option value="Marketing">Marketing</option>
						<option value="Outside Sales">Outside Sales</option>					
						<option value="Product Demo">Product Demo</option>										
						<option value="Retail Sales">Retail Sales</option>
						<option value="Route Sales">Route Sales</option>					
						<option value="Survey">Survey</option>						
						<option value="Telemarketing">Telemarketing</option>									
					</select>		
					</td>									
				</tr>
				<tr>
					<td align="center" STYLE CLASS="resumeTD">Management</td>
					<td align="center" STYLE CLASS="resumeTD">Technical</td>	
					<td align="center" STYLE CLASS="resumeTD">Food Service</td>	
					<td align="center" STYLE CLASS="resumeTD">Software Used</td>										
				</tr>
				<tr>
					<td align="center" valign="top">
					<select multiple size="6" name="skillsManagement">
						<option value="Chose None">- Select all that apply -</option>
						<option value="Accounting">Accounting</option>
						<option value="CPA">CPA</option>	
						<option value="Contruction">Contruction</option>
						<option value="Engineering">Engineering</option>										
						<option value="Farm">Farm</option>
						<option value="Financial Management ">Financial 
						Management </option>	
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
					<td align="center" valign="top">
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
						<option value="Wireless Tech.">Wireless Tech.</option>																
					</select>			
					</td>				
	
					<td align="center" valign="top">
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
					<td valign="top" align="center">
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
				</tr>
				<tr>
					<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
				</tr>							
				<tr>
					<td colspan="4" align="center"><strong>Job 
					Objective(s) and Work Summary</strong></td>
				</tr>
				<tr>
					<td colspan="4" align="center">
					<TEXTAREA wrap="soft" cols="50" rows="3" name="jobObjective"></TEXTAREA>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="20" border="0"></td>
				</tr>										
				<tr>
					<td colspan="4" align="center"><strong>
					Present or most recent employer</strong>
					</td>
				</tr>
<!-- START Work Hist 1 -->			
				<tr>
					<td colspan="4" align="center" width="100%">
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
							 <td align="right" width="50%"> Job Title: </td>
							 <td><INPUT type="text" size="42" maxlength="50" name="jobHistTitleOne"></td>
							</tr>
							<tr>
							 <td align="right" width="50%"> Company Name: </td>
							 <td><INPUT type="text" size="42" maxlength="50" name="jobHistCpnyOne"></td>
							</tr>	
							<tr>
							 <td align="right" width="50%"> Phone #: </td>
							 <td><INPUT type="text" size="12" maxlength="15" name="jobHistPhoneOne"></td>
							</tr>	
							<tr>
							 <td align="right" width="50%"> City: </td>
							 <td><INPUT type="text" size="14" maxlength="30" name="jobHistCityOne">
								State: 
	<SELECT NAME="jobHistStateOne">
		<% Do While NOT rsLocation2.EOF %>
		<OPTION	VALUE="<%= rsLocation2("LOCCODE")%>" selected
		<% If rsLocation2("locCode") = "ID" then %>SELECTED<% End If %>> <%=rsLocation2("locName") %></OPTION>
		<% rsLocation2.MoveNext %>
		<% Loop %>	
	</SELECT>						 

						 </td>
						</tr>							
						<tr>
						 <td align="right" width="50%" valign="top">Job Duties: </td>
						 <td><TEXTAREA wrap="soft" cols="45" rows="2" name="jobDutiesOne"></TEXTAREA></td>
						</tr>						
						<tr>
						 <td align="right" width="50%">From Date:
<SELECT name="jobHistSMonthOne" style="font-size: 9pt;">
		<option value="" selected>----</option>	
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
		<option value="" selected>----</option>
		<option value="2008">2008</option>	
		<option value="2007">2007</option>	
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
		<option value="1968">1968</option>																																																	
</SELECT>&nbsp;&nbsp;					 
						 </td>
						 <td>To Date:
<SELECT name="jobHistEMonthOne" style="font-size: 9pt;">
		<option value="" selected>----</option>						
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
		<option value="" selected>-------</option>
		<option value="2008">2008</option>	
		<option value="2007">2007</option>
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
						<tr>
						 <td align="right" width="50%">Reason For Leaving: </td>
						 <td>
						 <SELECT name="jobReasonOne">
		<option value="" selected>- Select Reason -</option>							 
		<option value="Assignment ended">Assignment ended</option>	
		<option value="Relocated">Relocated</option>	
		<option value="Found a better job">Found a better Job</option>	
		<option value="Layoff">Layoff</option>	
		<option value="Medical / Health">Medical / Health</option>			
		<option value="Terminated">Terminated</option>	
		<option value="Other">* Other Reason -&gt;</option>														 
						 </SELECT>&nbsp;<em>Other Reason</em>: <input type="text" name="jobOtherReasonOne" size="17" maxlength="255">
						 </td>
						</tr>							
					</table>
				</td>
			</tr>
<!-- END Work Hist 1 -->	
<tr>
					<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="20" border="0"></td>
				</tr>		
			<tr>
				<td colspan="4" align="center"><strong>2nd 
				most recent employer </strong>
				</td>
			</tr>
<!-- START Work Hist 2 -->			
			<tr>
				<td colspan="4" align="center">
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
						 <td align="right" width="50%"> Job Title: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistTitleTwo"></td>
						</tr>
						<tr>
						 <td align="right" width="50%"> Company Name: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistCpnyTwo"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%"> Phone #: </td>
						 <td><INPUT type="text" size="12" maxlength="15" name="jobHistPhoneTwo"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%"> City: </td>
						 <td><INPUT type="text" size="14" maxlength="30" name="jobHistCityTwo">
							State: 
	<SELECT NAME="jobHistStateTwo">
		<% Do While NOT rsLocation3.EOF %>
		<OPTION	VALUE="<%= rsLocation3("LOCCODE")%>"
		<% If rsLocation3("locCode") = "ID" then %>SELECTED<% End If %>> <%=rsLocation3("locName") %></OPTION>
		<% rsLocation3.MoveNext %>
		<% Loop %>	
	</SELECT>						 

						 </td>
						</tr>							
						
						
						<tr>
						 <td align="right" width="50%" valign="top">Job Duties: </td>
						 <td><TEXTAREA wrap="soft" cols="45" rows="2" name="jobDutiesTwo"></TEXTAREA></td>
						</tr>						
						<tr>
						 <td align="right" width="50%">From Date:
<SELECT name="jobHistSMonthTwo" style="font-size: 9pt;">
		<option value="" selected>----</option>	
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
		<option value="" selected>----</option>
		<option value="2008">2008</option>	
		<option value="2007">2007</option>	
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
		<option value="" selected>----</option>							
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
		<option value="" selected>-------</option>
		<option value="2008">2008</option>	
		<option value="2007">2007</option>	
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
						<tr>
						 <td align="right" width="50%">Reason For Leaving: </td>
						 <td>
						 <SELECT name="jobReasonTwo">
		<option value="" selected>- Select Reason -</option>							 
		<option value="Assignment ended">Assignment ended</option>	
		<option value="Relocated">Relocated</option>	
		<option value="Found a better job">Found a better Job</option>	
		<option value="Layoff">Layoff</option>	
		<option value="Medical / Health">Medical / Health</option>			
		<option value="Terminated">Terminated</option>	
		<option value="Other">* Other Reason -&gt;</option>														 
						 </SELECT>&nbsp;<em>Other Reason</em>: <input type="text" name="jobOtherReasonTwo" size="17" maxlength="255">
						 </td>
						</tr>							
					</table>
				</td>
			</tr>
<!-- END Work Hist 2 -->	
				<tr>
					<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="20" border="0"></td>
				</tr>	
<tr>
				<td colspan="4" align="center"><strong>3rd 
				most recent employer</strong>
				</td>
			</tr>
<!-- START Work Hist 3 -->			
			<tr>
				<td colspan="4" align="center">
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
						 <td align="right" width="50%"> Job Title: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistTitleThree"></td>
						</tr>
						<tr>
						 <td align="right" width="50%"> Company Name: </td>
						 <td><INPUT type="text" size="42" maxlength="50" name="jobHistCpnyThree"></td>
						</tr>	
						<tr>
						 <td align="right" width="50%"> Phone #: </td>
						 <td><INPUT type="text" size="12" maxlength="15" name="jobHistPhoneThree"></td>
						</tr>
						
						<tr>
						 <td align="right" width="50%"> City: </td>
						 <td><INPUT type="text" size="14" maxlength="30" name="jobHistCityThree">
							State: 
	<SELECT NAME="jobHistStateThree">
		<% Do While NOT rsLocation4.EOF %>
		<OPTION	VALUE="<%= rsLocation4("LOCCODE")%>"
		<% If rsLocation4("locCode") = "ID" then %>SELECTED<% End If %>> <%=rsLocation4("locName") %></OPTION>
		<% rsLocation4.MoveNext %>
		<% Loop %>	
	</SELECT>						 

						 </td>
						</tr>						
						
						<tr>
						 <td align="right" width="50%" valign="top">Job Duties: </td>
						 <td><TEXTAREA wrap="soft" cols="45" rows="2" name="jobDutiesThree"></TEXTAREA></td>
						</tr>							
						<tr>
						 <td align="right" width="50%">From Date:
<SELECT name="jobHistSMonthThree" style="font-size: 9pt;">
		<option value="" selected>----</option>	
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
		<option value="" selected>----</option>
		<option value="2008">2008</option>	
		<option value="2007">2007</option>	
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
		<option value="" selected>-------</option>
		<option value="2008">2008</option>	
		<option value="2007">2007</option>	
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
						<tr>
						 <td align="right" width="50%">Reason For Leaving: </td>
						 <td>
						 <SELECT name="jobReasonThree">
		<option value="" selected>- Select Reason -</option>							 
		<option value="Assignment ended">Assignment ended</option>	
		<option value="Relocated">Relocated</option>	
		<option value="Found a better job">Found a better Job</option>	
		<option value="Layoff">Layoff</option>	
		<option value="Medical / Health">Medical / Health</option>			
		<option value="Terminated">Terminated</option>	
		<option value="Other">* Other Reason -&gt;</option>														 
						 </SELECT>&nbsp;<em>Other Reason</em>: <input type="text" name="jobOtherReasonThree" size="17" maxlength="255">
						 </td>
						</tr>							
						
					</table>
				</td>
			</tr>	<!-- END Work Hist 3 -->	
			<tr>
				<td colspan="4" align="center"><img src="/lweb/img/spacer.gif" alt="" width="2" height="12" border="0"></td>
			</tr>			
					
		  </table>
		</td>
	</tr>	
	<tr>
		<td colspan="2" align="center" valign="top">
<font size="1" face="Helvetica">I agree that my employment with Personnel Plus 
may be terminated at any time with liability to me for wages or salary except 
such as may have been earned at the date of such termination. I understand that 
my compensation from Personnel Plus shall be limited to the duration of any 
temporary assignment hereunder. I agree that if at any time I sustain a 
work-related injury, I will submit myself to a drug/alcohol test and to an 
examination by a physician of the company's selection.	</font>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<INPUT TYPE="button" name="submit_btn" style="background:#dc143c; border:1 #333333 solid; font-size:11px; font-weight:bold; color:#FFFFFF;" VALUE="Send My Application Now!" onClick="checkApplyDirect()">
		</td>
	</tr>						
</TABLE>
	</td>
  </tr>
</FORM>
</table>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->

</div>
</BODY>
</HTML>
<%
Set rsLocation = Nothing
Set rsLocation2 = Nothing
Set rsLocation3 = Nothing
Set rsLocation4 = Nothing
Set Connect = Nothing
%>