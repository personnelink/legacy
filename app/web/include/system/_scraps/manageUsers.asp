<%'Option Explicit%>
<%
session("add_css") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/controlApplets.js"></script>
<!-- Revised: 4.7.2009 -->
<!-- Revised: 07.23.2008 -->
<%
if userLevelRequired(userLevelPPlusStaff) = true then
	
	const FormPostTo = "manageUsers.asp?Action="
	
	const linkImgUser = "<img style='border:none;' src='/include/style/images/ico_user.gif' alt=''>"
	
	dim LooksGood
	
	LooksGood = true
	if CheckField("username") <> "" then LooksGood = false
	if CheckField("password") <> "" then LooksGood = false
	if CheckField("nameF") <> "" then LooksGood = false
	if CheckField("nameL") <> "" then LooksGood = false
	
	if LooksGood = true And request.form("formAction") = "Create User" then 
		CreateUserAccount
		ShowUsers
	elseif LooksGood = true And request.form("formAction") = "Update User" then
		UpdateUserAccount
		ShowUsers
	end if
	
	if request.form("task") = "Delete Selected" then DeleteUsers
	
	Select Case Trim(Request.QueryString("Action")) 
		Case remove
			DeleteUsers
			ShowUsers
		Case manage
			ShowUsers
		Case Else
			ShowUserForm
	End Select
end if
	
Sub ShowUsers
	dim listOfCompanies, currentCompany, whichCompany, companyName
%>
<%=decorateTop("manageUsers", "marLR10", "User Accounts")%>

<form id="manageUsersForm" name="manageUsersForm" action="<%=FormPostTo & remove%>" method="post">
  <p>
	<label for="whichCompany">Current Company</label>
	<SELECT name="whichCompany" id="whichCompany" class="styled" onchange="javascript:document.manageUsersForm.submit();">
	  <%
		whichCompany = request.form("whichCompany")
		if len(whichCompany & "") = 0 then
			if len(session("whichCompany") & "") = 0 then
				session("whichCompany") = companyId
			end if
		Else
			session("whichCompany") = whichCompany
		end if
		currentCompany = CInt(session("whichCompany"))
		Database.Open MySql
		Set listOfCompanies = Database.Execute("Select companyID, companyName From tbl_companies Order By companyName Asc")
			do while not listOfCompanies.eof
				companyID = CInt(listOfCompanies("companyID"))
				companyName = listOfCompanies("companyName")%>
	  <option value="<%=companyID%>" <% if currentCompany = companyID then Response.write "selected" %>><%=companyName%></option>
	  <%
				listOfCompanies.Movenext
			loop 
		Database.Close
		Set listOfCompanies = Nothing %>
	</SELECT>
  </p>
  <div id="letsScroll">
	<ul>
	  <%
		
	dim userInformation, NoUsers, userID, userName, firstNameLast
	Database.Open MySql
	Set userInformation = Database.Execute("Select userID, userName, firstName, lastName, title From tbl_users Where companyID=" & currentCompany) 

	if userInformation.eof = true then NoUsers = true
	do while not userInformation.eof
		userID = userInformation("userID")
		userName = userInformation("userName")
		firstNameLast = Pcase(userInformation("firstName")) & " " & Pcase(userInformation("lastName")) %>
	  <li>
		<input class="styled" type="checkbox" name="userID" id="userID" value="<%=userID%>">
		<a href="/include/system/tools/manageUsers.asp?Action=<%=view%>&amp;UserID=<%=userID%>"><%=firstNameLast%><span><%=userName%></span></a> </li>
	  <%
		userInformation.Movenext
	loop
%>
	</ul>
  </div>
  <input type="hidden" name="formAction" value="">
  <p>To Manage a User, Click on There Account Above</p>
  <a class="squarebutton" href="<%=FormPostTo & add%>" onclick="document.manageUser.formAction.value='Add User'"><span>Add User</span></a><a class="squarebutton" href="<%=FormPostTo & remove%>" onclick="document.taskaction.formAction.value='remove';document.taskaction.submit()"><span>Delete Selected</span></a>
</form>
<%=decorateBottom()%>
<%
	Set dbQuery = Nothing
	Database.Close
	TheEnd
End Sub

Sub ShowUserForm
	dim Submit, SubmitValue, CantChangeUserName
	
	Submit = request.form("formAction")
	if Submit = "Update User" Or Submit = "Revert Back" then
		SubmitValue = "Update User"
	Else
		SubmitValue = "Create User"
	end if
	
	if request.form("UserNameReadOnly") = "true" then CantChangeUserName = "ReadOnly"
	
	if request.form("task") = "Delete Selected" then ShowUsers
	
	dim Title, Department, CompanyName, FirstName, LastName, PrimaryPhone, SecondaryPhone, eMail, ReeMail, AddressOne
	dim AddressTwo, City, UserState, ZipCode, Country, UserName, Password, UserLevel, ConfirmPassword, AlternateeMail
	dim addressID, SecurityLowScope, SecurityHighScope
	
	if Request.QueryString("action") = add then
		if request.form("formAction") <> "Start Over" then
			Title = request.form("title")
			Department = request.form("department")
			CompanyName = request.form("companyname")
			FirstName = request.form("nameF")
			LastName = request.form("nameL")
			PrimaryPhone = FormatPhone(request.form("Pphone"))
			SecondaryPhone = FormatPhone(request.form("Sphone"))
			eMail = request.form("email")
			ReeMail = request.form("reemail")
			AddressOne = request.form("addOne")
			AddressTwo = request.form("addTwo")
			City = request.form("city")
			UserState = request.form("state")
			ZipCode = request.form("zipcode")
			Country = request.form("country")
			UserName = request.form("userName")
			Password = request.form("password")
			UserLevel = request.form("security")
			ConfirmPassword = request.form("retypedpassword")
			
		end if
	elseif Request.QueryString("action") = view then
		SubmitValue = "Update User"
		
		Database.Open MySql
		Set dbQuery = Database.Execute("Select * From tbl_users Where userID=" & Request.QueryString("UserID"))
		Title = dbQuery("title")
		Department = dbQuery("departmentID")
		UserLevel = dbQuery("userLevel")
		UserName = dbQuery("userName") : CantChangeUserName = "ReadOnly"
		Password = dbQuery("userPassword")
		ConfirmPassword = Password
		FirstName = dbQuery("firstName")
		LastName = dbQuery("lastName")
		PrimaryPhone = dbQuery("userPhone")
		SecondaryPhone = dbQuery("userSPhone")
		eMail = dbQuery("userEmail")
		AlternateeMail = dbQuery("userAlternateEmail")
		addressID = dbQuery("addressID")
		
		Set dbQuery = Database.Execute("Select * From tbl_addresses Where addressID=" & addressID)
		if Not dbQuery.eof then
			AddressOne = dbQuery("address")
			AddressTwo = dbQuery("addressTwo")
			City = dbQuery("city")
			UserState = dbQuery("state")
			ZipCode = dbQuery("zip")
			Country = dbQuery("country")
		end if
		Database.Close
	elseif Request.QueryString("action") = "" then
		ShowUsers
	end if
	
	SecurityLowScope = userLevelSuspended
	Select Case user_level
	Case userLevelPPlusStaff
		SecurityHighScope = userLevelAdministrator
	Case userLevelPPlusSupervisor
		SecurityHighScope = userLevelPPlusStaff
	Case userLevelPPlusAdministrator
		SecurityHighScope = userLevelPPlusAdministrator
	Case Else
		SecurityHighScope = userLevelEngaged
	End Select


	Set getPlacements_cmd = Server.CreateObject ("ADODB.Command")
	With getPlacements_cmd
		.ActiveConnection = tempsPER
		.CommandText = "SELECT EmployeeNumber FROM Placements WHERE PlacementStatus=0"
		.Prepared = true
	End With
	Set Placements = getPlacements_cmd.Execute
	
	Set getApplicantsName_cmd = Server.CreateObject("ADODB.Command")
	With getApplicantsName_cmd
		.ActiveConnection = tempsPER
		.Prepared = true
	End With

%>
	
<%=decorateTop("manageUser", "marLR10", "User Information")%>

<SCRIPT TYPE="text/javascript" LANGUAGE="JavaScript">
function getApplicantIDs() {

	document.body.style.cursor = 'wait';
	
	var dropdownIndex = document.getElementById('companyid').selectedIndex;
	var companyid = document.getElementById('companyid')[dropdownIndex].value;
	
	var xmlhttp = new XMLHttpRequest();
	var sURL = "/include/system/tools/timecards/getApplicants.asp?companyid=" + companyid;
	xmlhttp.open( "POST", sURL, false );
	xmlhttp.send('something');
	if (xmlhttp.status == 200 ) {
		document.getElementById('tempsid').innerHTML = xmlhttp.responseText;
	} else {
		alert('There\'s an issue');
	}
	}
	document.body.style.cursor = 'default';
	
</SCRIPT>


<form id="manageUserForm" name="manageUserForm" action="<%=FormPostTo & add%>" method="post">
<div class="notes">

		<h4>User Information</h4>
		<p>Please enter and verify the user name, address and contact information as they are listed on their application, resume, or other document.</p>
		<p class="last">Also verify that they are assigned to the correct client company, and if needed, assign them to the correct department and/or location.</p>
	   </div>

<div class="picture">
  <p>
	<label for="companyid">Which Company</label>
	
	<select id="companyid" name="companyid" class="notstyled" onchange="getApplicantIDs()">
	  <option value="">-- Select Company --</option>
	  <option value="BUR">Burley</option>
	  <option value="PER">Twin Falls</option>
	  <option value="BOI">Boise</option>
	  <option value="IDA">Idaho Department of Ag</option>
	</select>
 </p>

  <p>
	<label for="tempsid">Temps Applicant ID</label>
	
	<select id="tempsid" name="tempsid" class="styled">
	  <option value="">Not Registered In Temps Plus</option>
	</select>
 </p>
  <p>
	<label for="nameF">First Name</label>
	<input type="text" id="nameF" name="nameF" size="30" value="<%=FirstName%>">
  </p>
  <p>
	<label for="nameL">Last Name</label>
	<input type="text" id="nameL" name="nameL" size="30" value="<%=LastName%>">
  </p>
  <p>
	<label for="Pphone">Phone</label>
	<input type="text" id="Pphone" name="Pphone" size="30" value="<%=PrimaryPhone%>">
  </p>
  <p>
	<label for="Sphone">Other Phone</label>
	<input type="text" id="Sphone" name="Sphone" size="30" value="<%=SecondaryPhone%>">
  </p>
  <p>
	<label for="email">Email</label>
	<input type="text" id="email" name="email" size="30" value="<%=eMail%>">
  </p>
  <p>
	<label for="reemail">Other Email</label>
	<input type="text" id="reemail" name="reemail" size="30" value="<%=AlternateeMail%>">
  </p>
  <p>
	<label for="company">Company</label>
	
	<select id="company" name="company" class="styled">
	  <option value="000">Not Assigned to a Company</option>
	  <SCRIPT TYPE="text/javascript" LANGUAGE="JavaScript">
		document.body.style.cursor = 'wait';

		var xmlhttp = new XMLHttpRequest();
		var sURL = "/include/system/tools/timecards/getCustomers.asp?companyid=BUR";
		xmlhttp.open( "GET", sURL, false );
		xmlhttp.send('something');
				if (xmlhttp.status == 200 ) {
			document.write(xmlhttp.responseText);
		} else {
			alert('There\'s an issue');
		}
		
		document.body.style.cursor = 'default';
	</SCRIPT>
	</select>
 </p>
  <p>
	<label for="department">Department</label>
	
	<select id="department" name="department" class="styled">
	  <option value="000">Not Assigned a Department</option>
	  <%=PopulateList("tbl_departments Where companyID=" & companyId, "departmentID", "name", "Order By name", Department)%>
	</select>
 </p>
  <p>
	<label for="location">Location</label>
	
	<select id="location" name="location" class="styled">
	  <option value="000">Not Assigned to a Department</option>
	  <%=PopulateList("tbl_departments Where companyID=" & companyId, "departmentID", "name", "Order By name", Department)%>
	</select>
 </p>
  <p>
	<label for="addOne">Address</label>
	<input type="text" id="addOne" name="addOne" size="30" value="<%=AddressOne%>">
  </p>
  <p>
	<label for="addTwo">Address Two</label>
	<input type="text" id="addTwo" name="addTwo" size="30" value="<%=AddressTwo%>">
  </p>
  <p>
	<label for="City">City</label>
	<input type="text" id="City" name="City" size="20" value="<%=City%>">
  </p>
  <p>
	<label for="state">State</label>
	<select id="state" name="state" class="styled">
	  <option value="ID">ID</option>
	  <%=PopulateList("list_locations", "locCode", "locName", "locCode", UserState)%>
	</select>
  </p>
  <p>
	<label for="zipcode">Zip Code</label>
	<input type="text" id="zipcode" name="zipcode" size="19" value="<%=ZipCode%>">
  </p>
  <p>
	<label for="country">Country</label>

	<select id="country" name="country" class="styled">
	  <option value="USA">USA</option>
	  <option value="CA">CA</option>
	</select></p>
<hr>
  <p>
	<label for="username">User Name</label>
	<input type="text" id="username" name="username" size="30" <%=CantChangeUserName%> value="<%=UserName%>">
  </p>
  <p>
	<label for="security">Security Level</label>
	<select id="security" name="security" class="styled">
	  <%=PopulateList("list_security Where userlevel >= " & SecurityLowScope & " and userlevel <= " & SecurityHighScope, "userlevel", "displayname", "Order By userlevel", UserLevel)%>
	</select>
  </p>
  <p>
	<label for="password">Password</label>
	<input type="password" id="password" name="password" size="30" value="<%=Password%>">
  </p>
  <p>
	<label for="retypedpassword">Retype Password</label>
	<input type="password" id="retypedpassword" name="retypedpassword" size="30" value="<%=ConfirmPassword%>"></p>
	<%if CantChangeUserName <> "" then response.write("<input name='UserNameReadOnly' type='hidden' value='true'>")	%>
	<input name="userID" type="hidden" value="<%=Request.QueryString("UserID")%>">
	<input name="address" type="hidden" value="<%=addressID%>">
	<input name="formAction" type="hidden" value="">
	<a class="squarebutton" href="javascript:;" onclick="document.manageUser.formAction.value='<%=SubmitValue%>';document.manageUser.submit();" style="margin-left: 6px"><span><%=SubmitValue%></span></a> <a class="squarebutton" href="<%=FormPostTo & manage%>"><span>Cancel</span></a>
</form>
</div>

<%=decorateBottom()%>
<%
End Sub

Function CheckField (formField)
	dim TempValue
	if Request.QueryString("action") <> view then
		Select Case	formField
			Case "username"
				TempValue = request.form("username")
				if TempValue = "" then
					CheckField = "User name is required"
				elseif len(TempValue) < 5 then
					CheckField = "User name cannot be less than 5 characters"
				elseif request.form("formAction") = "Create User" then
					Database.Open MySql
					Set dbQuery = Database.Execute("Select userName From tbl_users Where userName = '" + request.form("username")+"'")
					do while not dbQuery.eof
						i = i + 1
						dbQuery.Movenext
					loop
					Database.Close
					if i > 0 then
						CheckField = "User name already taken, please choose a different one."
					end if
				Else	
					CheckField = ""
				end if
			Case "password"
				TempValue = request.form("password")
				if TempValue = "" then
					CheckField = "Password is required"
				elseif TempValue <> request.form("retypedpassword") then
					CheckField = "Passwords do not match"
				Else
					CheckField = ""
				end if
			Case "nameF"
				if request.form("nameF") = "" then
					CheckField = "First name is required"
				Else
					CheckField = ""
				end if
			Case "nameL"
				if request.form("nameL") = "" then
					CheckField = "Last name is required"
				Else
					CheckField = ""
				end if
			Case "email"
				TempValue = request.form("email")
				if TempValue = "" then
					CheckField = "eMail Address Required"
				elseif Instr(TempValue,"@") = 0 then
					CheckField = "Invalid eMail Address"
				elseif Trim(TempValue) <> Trim(request.form("reemail")) then
					CheckField = "eMail Addresses Don't Match"
				Else
					CheckField = ""
				end if
		End Select	
	end if
End Function


Function CheckPhone (PhoneNumber)
	if PhoneNumber = "" then
		CheckPhone = "Phone Number Required"
	elseif len(PhoneNumber) < 13 then
		CheckPhone = "Not enough numbers"
	elseif len(PhoneNumber) > 13 then
		CheckPhone = "Invalid Phone Number"
	Else
		CheckPhone = ""
	end if
End Function

Sub CreateUserAccount
	dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql
	' * Note for Future: Need to sanitize outside information to prevent database injection hacking!
	'
	creationStamp=Now()
	sqlInformation = "INSERT INTO tbl_addresses (addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
	"'Personnel'," & _
	"'" & request.form("addOne") & "'," & _
	"'" & request.form("addTwo") & "'," & _
	"'" & request.form("city") & "'," & _
	"'" & request.form("state") & "'," & _
	"'" & request.form("zipcode") & "'," & _
	"'" & request.form("country") & "'," & _
	"'" & creationStamp & "')"	
	set dbQuery=Database.Execute(sqlInformation)
	
	'Retrieve assigned autonumbered addressID (To update table relationships with)
	'
	set dbQuery=Database.Execute("Select addressID From tbl_addresses WHERE CreationDate=#" & creationStamp & "#")
	
	sqlInformation = "INSERT INTO tbl_users (addressID, companyID, userName, userPassword, userLevel, departmentID, userEmail, userAlternateeMail, userPhone, userSPhone" & _
	", title, firstName, lastName, CreationDate) VALUES (" & _ 
	"'" & dbQuery("addressID") & "'," & _
	"'" & companyId & "'," & _
	"'" & request.form("username") & "'," & _
	"'" & request.form("password") & "'," & _
	"'" & request.form("security") & "'," & _
	"'" & request.form("department") & "'," & _
	"'" & request.form("email") & "'," & _
	"'" & request.form("reemail") & "'," & _
	"'" & FormatPhone(request.form("pphone")) & "'," & _
	"'" & FormatPhone(request.form("sphone")) & "'," & _
	"'" & request.form("title") & "'," & _
	"'" & request.form("nameF") & "'," & _
	"'" & request.form("nameL") & "'," & _
	"'" & creationStamp & "')"	
	set dbQuery=Database.Execute(sqlInformation)

	set dbQuery=Database.Execute("Select userID From tbl_users WHERE CreationDate=#" & creationStamp & "#")
	userID=dbQuery("userID")
	
	set dbQuery=Database.Execute("UPDATE tbl_addresses SET userID=" & userID & " WHERE CreationDate=#" & creationStamp & "#")
	Database.Close
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub UpdateUserAccount
	Database.Open MySql
	dim sqlrealtionID, rsrelationID, addressID, userID, companyID

	sqlInformation = "Update tbl_addresses Set address='" & request.form("addOne") & "', addressTwo='" & request.form("addTwo") & "', city='" & request.form("city") & _
	"', state='" & request.form("state") & "', zip='" & request.form("zipcode") & "', country='" & request.form("country") & "' Where addressID=" & _
	request.form("address")
	set dbQuery=Database.Execute(sqlInformation)
	
	sqlInformation = "Update tbl_users Set userName='" & request.form("username") & "', userPassword='" & request.form("password") & "', userLevel=" & _
	request.form("security") & ", departmentID=" & request.form("department") & ", userEmail='" & request.form("email") & "', userAlternateeMail='" & _
	request.form("reemail") & "', userPhone='" & FormatPhone(request.form("pphone")) & "', userSPhone='" & FormatPhone(request.form("sphone")) & _
	"', title='" & request.form("title") & "', firstName='" & request.form("nameF") & "', lastName='" & _
	request.form("nameL") & "' Where userID=" & request.form("userID")
	set dbQuery=Database.Execute(sqlInformation)

	Database.Close
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub DeleteUsers

	dim ID, DisplayName, i, UserID, UsersToAxe(), PPlusTemps(), AxedUsers
	UserID = 1
	Database.Open MySql
	i = CountRecords("userID", "tbl_users", "companyID=" & companyId)
	Redim UsersToAxe(i)
	
	Set dbQuery = Database.Execute("Select userID, firstName, lastName From tbl_users Where companyID=" & companyId) 
	i = 0
	do while not dbQuery.eof
		UsersToAxe(i) = dbQuery("userID")
		if request.form("checkUser" & UsersToAxe(i)) = "on" then
			AxedUsers = AxedUsers & dbQuery("firstName") & " " & " " & dbQuery("lastName") & "; "
		end if
		i = i + 1
		dbQuery.Movenext
	loop

	For i = 0 To UBound(UsersToAxe)
		if request.form("checkUser" & UsersToAxe(i)) = "on" then
			Database.Execute("Delete From tbl_users Where userID=" & UsersToAxe(i))
			Database.Execute("Delete From tbl_addresses Where userID=" & UsersToAxe(i))
			Database.Execute("Delete From tbl_messages Where userID=" & UsersToAxe(i))
			'Database.Execute("Delete From tbl_jobRequisitions Where userID=" & UsersToAxe(i))
			'Database.Execute("Delete From tbl_timesheets Where userID=" & UsersToAxe(i))
		end if
	Next
	Set dbQuery = Nothing
	Database.Close
	if len(AxedUsers) > 0 then
		%>
<div style="float:right; width:635px;border: 1px solid #97A4B3;margin-bottom:10;">
  <div class="normalTitle">User Account(s) Deleted</div>
  <p style="text-align:left; margin-bottom:20;padding:20;">The following users and all related information (less Time Data and Job Requisitions) have been removed from the system:<br>
    <br>
    <%=AxedUsers%> 
</div>
<%
	end if
End Sub
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
