<%Option Explicit%>
<%Response.Buffer = False%> 
<%
session("add_css") = "./manageUsers.001.css"
session("window_page_title") = "Manage Users - Personnel Plus"

dim page_title
page_title = "Manage Users"

dim formAction
formAction = request.form("formAction")

if formAction = "update" or formAction = "create" then
	session("no_header") = true
end if

%>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<script type="text/javascript" src="manageUsers.js"></script>

<!-- #include file='manageUsers.doStuff.asp' -->

<%=decorateTop("manageUsers", "marLR10 notToShort", "User accounts and information")%>

<!-- <%=FormPostTo & remove%> -->

<form id="manageUsersForm" name="manageUsersForm" action="#" method="post">
<input id="page_title" name="page_title" type="hidden" class="hidden" value="<%=page_title%>">
  <%
	dim selectedCompany
	dim Companies
	dim objCompSelector
	
	if user_level => userLevelPPlusStaff then
		'user is PPlus Staff, display option to select companies and unassigned
		response.write "<div id=""dataSourceSelection"">" &_
			"<label for=""whichCompany"">Current Company</label>"
		 
		selectedCompany = request.form("whichCompany")

        
        if vartype(selectedCompany) = 0 or len(selectedCompany) = 0 then
            selectedCompany = request.QueryString("comp")
        end if

		if len(selectedCompany & "") = 0 then
			selectedCompany = cint(request.querystring("comp"))
		end if
		
		objCompSelector = buildCompanySelector("whichCompany", selectedCompany, " onchange=""javascript:document.manageUsersForm.submit();""")
		response.write objCompSelector & "</div>"
		
		objCompSelector = replace(objCompSelector, "whichCompany", "inpAssignedToCompany")
		objCompSelector = replace(objCompSelector, " onchange=""javascript:document.manageUsersForm.submit();""", "")
	else
		'create hidden input in place of select and set value to current company since not internal
		objCompSelector = "<input id=""whichCompany"" name=""whichCompany"" type=""hidden"" class=""hidden"" value=""" & companyId & """>"
		selectedCompany = companyId
	end if

	dim likeName
	likeName = Replace(Request.QueryString("likeName"), "'", "''")
	if len(likeName) = 0 then 
		likeName = request.form("likeName") 
	end if
	
	dim selected_userId
	selected_userId = Request.QueryString("UserID")
	if selected_userId = "" then
		selected_userId = Request.Form("UserID")
	end if
	
	dim sSearchString
	if len(likeName) > 0 then
		sSearchString = " AND ((CONCAT(tbl_users.lastName, ', ', tbl_users.firstName)) LIKE '%" & likeName & "%')"
	end if
			
	dim VMS_Users, SQL
	Set VMS_Users = Server.CreateObject ("ADODB.RecordSet")
	VMS_Users.CursorLocation = 3 ' adUseClient
	
	if selectedCompany = "0" then
		SQL = "SELECT userID, firstName, lastName, userName, creationDate, lastloginDate FROM tbl_users WHERE (companyID=" & selectedCompany & " OR companyID is null)" & sSearchString & " ORDER By lastName, firstName Asc"
	else	
		SQL = "SELECT userID, firstName, lastName, userName, creationDate, lastloginDate  FROM tbl_users WHERE companyID=" & selectedCompany & " ORDER By lastName, firstName Asc"
	end if

	VMS_Users.Open SQL, MySql

	dim nPage, qsPage, nPageCount, nItemsPerPage
	qsPage = Request.QueryString("Page")
	if len(qsPage) > 0 then	nPage = Cint(qsPage)
	nItemsPerPage = 50
	VMS_Users.PageSize = nItemsPerPage
	nPageCount = VMS_Users.PageCount

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if


	dim NoUsers, userID, userName, firstNameLast
	dim qryOptions, i
	
	%>
    <div id="UsersList">
    <h5>Users</h5>
	<table>
	<tr><td>
     <label style="float:left; clear:left" for="likeName">Search</label>
     <input  style="margin:0; padding:0" name="likeName" id="likeName" type="text" value="<%=likeName%>" onKeyPress="return submitenter(this,event)"></td><td style="padding:0; margin:0" class="changeView">
	<a class="squarebutton" href="#" style="float:none" onclick="javascript:document.manageUsersForm.submit();"><span style="text-align:center"> Search </span></a>
		</td></tr></table>
<%
		
	dim maxPages, slidePages

	const StartSlide = 10 ' when to start sliding
	const StopSlide = 100 'when to stop sliding and show the smallests amount
	const SlideRange = 4 'the most pages to show minus this = smallest number to show aka the slide
	const TopPages = 8 'the most records to show

	if nPage <= StartSlide then
		maxPages = TopPages
	elseif nPage > StartSlide and nPage < StopSlide then
		maxPages = TopPages - (SlideRange - Cint(SlideRange * ((StopSlide - nPage)/(StopSlide - StartSlide))))
	else
		maxPages = TopPages - SlideRange
	end if
	slidePages = cint((maxPages/2)+0.5)


	dim startPage, stopPage
	
	'check if we need to slide page navigation "window"
	if nPageCount > maxPages then
		startPage = nPage - slidePages
		stopPage = nPage + slidePages
		
		'check if startPages is less than 1
		if startPage < 1 then
			startPage = 1
			stopPage = maxPages
		end if
		'check if stopPages is greater than total pages
		if stopPage > nPageCount then
			stopPage = nPageCount
			startPage = nPageCount - slidePages
		end if
	else
		startPage = 1
		stopPage = nPageCount
	end if

	dim qsLikeName
	qsLikeName = Server.URLEncode(likeName)
	qryOptions = "&comp=" & selectedCompany & "&likeName=" & qsLikeName
	
	const linktohere = "/include/system/tools/manage/users/?Action=2"
	response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
	response.write "<A HREF=""" & linktohere & "&Page=1" & qryOptions & """>First</A>"
	For i = startPage to stopPage
	
		response.write "<A HREF=""" & linktohere & "&Page="& i & qryOptions & """>&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			if (i = stopPage and i < nPageCount) or (i = startPage and i > 1) then
				response.write "..."
			else
				response.write i
			end if
		end if
		response.write "&nbsp;</A>"
	Next
	response.write "<A HREF=""" & linktohere & "&Page=" & nPageCount & qryOptions & """>Last</A>"
	response.write("</div>")
%>
    <div id="Users">
      <ul>
        <%
		
	if Not VMS_Users.eof then
		VMS_Users.AbsolutePage = nPage
	else
		NoUsers = true
	end if
	
	dim srchUserID
	dim srchUserName
	dim srchDates

	do while not ( VMS_Users.Eof Or VMS_Users.AbsolutePage <> nPage )
		srchUserID = VMS_Users("userID")
		srchUserName = VMS_Users("userName")
		firstNameLast =  Pcase(VMS_Users("lastName")) & ", " & Pcase(VMS_Users("firstName"))
		srchDates = "born:" & VMS_Users("creationDate") & "<br />last: " & VMS_Users("lastloginDate")
		%>
        <li>
          <input class="styled" style="border:none;" type="checkbox" name="userID" id="userID" value="<%=userID%>">
          <a href="?Action=<%=view%>&amp;UserID=<%=srchUserID%><%=qryOptions%>"><%=firstNameLast%><span><%=srchUserName%><span><%=srchDates%></span></span></a></li>
        <%
		response.flush
		VMS_Users.Movenext
	loop
%>
        <li>
          <input class="styled" style="border:none;" type="checkbox" name="userID" id="Checkbox1" value="0">
          <a href="?Action=0&amp;UserID=-1<%=qryOptions%>"><i>Create New User</i><span><i>add a new user account...</i></span></a></li>
      </ul>
    </div>
  </div>
  <%
	Set dbQuery = nothing
	VMS_Users.Close

	dim Submit, SubmitValue, CantChangeUserName
	
	Submit = request.form("formAction")
	if Submit = "Update" Or Submit = "Revert" then
		SubmitValue = "Save"
	Else
		SubmitValue = "Add"
	end if
	
	if request.form("UserNameReadOnly") = "true" then CantChangeUserName = "ReadOnly"
	
	if request.form("task") = "Remove" then ShowUsers
	
	dim Title, Department, FirstName, LastName, PrimaryPhone, SecondaryPhone, eMail, ReeMail, AddressOne
	dim AddressTwo, City, UserState, ZipCode, Country, Password, UserLevel, ConfirmPassword, AlternateeMail
	dim AssignedTo, SecurityLowScope, SecurityHighScope
	dim DateCreated, DateLastLogin
	
	select case Request.QueryString("action")
	case add 
		SubmitValue = "Add"
		AssignedTo = request.form("inpAssignedToCompany")
				objCompSelector = buildCompanySelector("inpAssignedToCompany", AssignedTo, "")
		
		Title = trim(request.form("title"))
		Department = trim(request.form("department"))
		CompanyName = trim(request.form("companyname"))
		FirstName = trim(request.form("nameF"))
		LastName = trim(request.form("nameL"))
		PrimaryPhone = FormatPhone(request.form("Pphone"))
		SecondaryPhone = FormatPhone(request.form("Sphone"))
		eMail = trim(request.form("email"))
		ReeMail = trim(request.form("reemail"))
		AddressOne = trim(request.form("addOne"))
		AddressTwo = trim(request.form("addTwo"))
		City = trim(request.form("city"))
		UserState = request.form("state")
		ZipCode = trim(request.form("zipcode"))
		Country = trim(request.form("country"))
		UserName = trim(request.form("userName"))
		Password = unmask_length(request.form("typedpassword"))
		UserLevel = request.form("security")
		ConfirmPassword = unmask_length(request.form("retypedpassword"))
		
	case view
		SubmitValue = "Update"
		dim this_userid
		this_userid = Request.QueryString("UserID")
		if isNumeric(this_userid) and len(this_userid) > 0 then
            if cdbl(this_userid) > 0 then
			    Database.Open MySql
			    Set dbQuery = Database.Execute("Select tbl_users.*, tbl_addresses.* From tbl_users Left Join tbl_addresses On tbl_users.addressID=tbl_addresses.addressID Where userID=" & this_userid & ";")
			    AssignedTo = dbQuery("companyID")
				    objCompSelector = buildCompanySelector("inpAssignedToCompany", AssignedTo, "")
                    
			    Title = dbQuery("title")
			    Department = dbQuery("departmentID")
			    UserLevel = dbQuery("userLevel")
			    UserName = dbQuery("userName") : CantChangeUserName = "ReadOnly"
				DateCreated = dbQuery("creationDate")
				DateLastLogin = dbQuery("lastloginDate")
			    Password = dbQuery("userPassword")
			    ConfirmPassword = Password
			    FirstName = dbQuery("firstName")
			    LastName = dbQuery("lastName")
			    PrimaryPhone = dbQuery("userPhone")
			    SecondaryPhone = dbQuery("userSPhone")
			    eMail = dbQuery("userEmail")
			    AlternateeMail = dbQuery("userAlternateEmail")
			    addressID = dbQuery("addressID")
			    AddressOne = dbQuery("address")
			    AddressTwo = dbQuery("addressTwo")
			    City = dbQuery("city")
			    UserState = dbQuery("state")
			    ZipCode = dbQuery("zip")
			    Country = dbQuery("country")
	    	    Database.Close
	        end if
        end if
	case else
		'ShowUsers
	end select
	
	SecurityLowScope = userLevelSuspended
	SecurityHighScope = user_level %>

	<div id="UserDetails">
    <h5>User Details</h5>
    <div id="UserForm">
	<% if instr(objCompSelector, "select") > 0 then %>
	   <table><tr><td>
			<label for="inpAssignedToCompany">Assigned To Company</label></td>
			</tr><tr>
				<td><%=objCompSelector%></td>
			</tr></table>
	<% end if %>
	
		<p>
        <label for="departments">Departments</label>
        <input type="text" id="department" name="department" size="30" value="<%=Department%>" autocomplete="off">
		<span class="helptext">(Separate multiple departments using a comma: ',')</i></span>
      </p>
	  <p>
        <label for="email">Email</label>
        <input type="text" id="email" name="email" size="30" value="<%=eMail%>" autocomplete="off">
      </p>
      <p>
        <label for="nameF">First Name</label>
        <input type="text" id="nameF" name="nameF" size="30" value="<%=FirstName%>" autocomplete="off">
      </p>
      <p>
        <label for="nameL">Last Name</label>
        <input type="text" id="nameL" name="nameL" size="30" value="<%=LastName%>" autocomplete="off">
      </p>
      <p>
        <label for="Pphone">Phone</label>
        <input type="text" id="Pphone" name="Pphone" size="30" value="<%=PrimaryPhone%>" autocomplete="off">
      </p>
      <p>
        <label for="Sphone">Other Phone</label>
        <input type="text" id="Sphone" name="Sphone" size="30" value="<%=SecondaryPhone%>" autocomplete="off">
      </p>
      <p>
        <label for="addOne">Address</label>
        <input type="text" id="addOne" name="addOne" size="30" value="<%=AddressOne%>" autocomplete="off">
      </p>
      <p>
        <label for="addTwo">Address Two</label>
        <input type="text" id="addTwo" name="addTwo" size="30" value="<%=AddressTwo%>" autocomplete="off">
      </p>
      <p>
        <label for="City">City</label>
        <input type="text" id="City" name="City" size="20" value="<%=City%>" autocomplete="off">
     </p>
     <table><tr><td>
        <label for="state">State</label></td></tr><tr><td>
        <select id="state" name="state" class="styled">
          <option value="ID">ID</option>
          <%=PopulateList("list_locations", "locCode", "locName", "locCode", UserState)%>
        </select></td></tr></table>
    <p>
        <label for="zipcode">Zip Code</label>
        <input type="text" id="zipcode" name="zipcode" size="19" value="<%=ZipCode%>" autocomplete="off">
      </p>
    <table><tr><td>
        <label for="country">Country</label></td></tr><tr><td>
        <select id="country" name="country" class="styled">
          <option value="USA">USA</option>
          <option value="CA">CA</option>
        </select>
      </td></tr></table>
      <hr>
    <table><tr><td>
        <label for="security">Security Level</label></td></tr><tr><td>
        <select id="security" name="security" class="styled">
          <%=PopulateList("list_security Where userlevel >= " & SecurityLowScope & " and userlevel <= " & SecurityHighScope, "userlevel", "displayname", "Order By userlevel", UserLevel)%>
        </select>
      </td></tr></table>
      <p>
        <label for="userName">User Name</label>
        <input type="text" id="userName" name="userName" autocomplete="off" size="60" value="<%=userName%>"  <%=CantChangeUserName%>>
      </p> <p><span class="smaller">Created: <%=DateCreated%>, <br /> Last logged in: <%=DateLastLogin%></span></p>  <p>
        <label for="typedpassword">Password</label>
        <input type="password" id="typedpassword" name="typedpassword" autocomplete="off" size="30" value="<%=mask_length(Password, 31)%>" >
      </p>
      <p>
        <label for="retypedpassword">Retype Password</label>
        <input type="password" id="retypedpassword" name="retypedpassword" size="30" value="<%=mask_length(ConfirmPassword, 31)%>" autocomplete="off">
      </p>
      <%if CantChangeUserName <> "" then response.write("<input name='UserNameReadOnly' type='hidden' value='true'>")	%>
      <input name="userID" type="hidden" value="<%=selected_userId%>">
      <input name="addressId" type="hidden" value="<%=addressID%>">
      <input name="comp" type="hidden" value="<%=selectedCompany%>">
  <input type="hidden" name="formAction" value="">
</div>

<%
	leftSideMenu = "<div class=""notes"">" &_
    "<h4> Online Users </h4>" &_
    "<p>Locate and select the user from the list on the far left that you want to manage.</p>" &_
    "<p class=""last"">* Please note that changes made here do not directly affect information inside Temps Plus.</p>" &_
  "</div>" &_
  "<div class=""notes"">" &_
    "<h4>User Details</h4>" &_
    "<p>You can use this tool to change and update user information and reset their login password. Verify the user name, address and contact information.</p>" &_
  "</div>" &_
  "<div class=""notes"">" &_
    "<h4>Add New User</h4>" &_
    "<p class=""last"">Select the 'Create User' button below to create a new user account.</p>" &_
  "</div>"
%>

  
	<a id="updateuserbtn" style="margin-right:2em;margin-left:7em;" class="squarebutton" href="javascript:;" onclick="user.update();" ><span id="btnUserValue"><%=SubmitValue%></span></a>
	<a class="squarebutton" style="margin-right:2em;" href="<%=FormPostTo & manage%>"><span>Cancel</span></a>
	<% if SubmitValue = "Update" then %>
		<a class="squarebutton" style="margin-right:2em;" href="<%=FormPostTo & remove%><%=qrySrchAndCompany%>&axe=<%=selected_userId%>" onclick="user.remove();"><span>Remove</span></a>
	<% end if %>
</div>
</form>

<%=decorateBottom()%>

<% noSocial = true %>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
