<%
if userLevelRequired(userLevelSupervisor) = true then

	const FormPostTo = "?Action="
	
	const linkImgUser = "<img style='border:none;' src='/include/style/images/ico_user.gif' alt=''>"
	
	dim LooksGood
	
	LooksGood = true
	if CheckField("username") <> "" then LooksGood = false
	if CheckField("password") <> "" then LooksGood = false
	if CheckField("nameF") <> "" then LooksGood = false
	if CheckField("nameL") <> "" then LooksGood = false
	
	'if LooksGood = true then
		Select Case formAction
		Case "create"
			CreateUserAccount
		Case "update"
			UpdateUserAccount
		Case else
			
		End Select
	'end if
	
	if request.form("formAction") = "remove" or Trim(Request.QueryString("Action")) = "3" then
		DeleteUsers
	end if
end if

dim listOfCompanies, currentCompany, whichCompany, companyName

function buildCompanySelector(inpName, selectedCompany, strOnChange)
	dim strTemp, intCompany
	if isnull(selectedCompany) then
		intCompany = 0
	elseif isnumeric(selectedCompany) then
		intCompany = cint(selectedCompany)
	else
		intCompany = selectedCompany
	end if
		
	strTemp = "" &_
		"<SELECT name=""" & inpName & """ id=""" & inpName & """ class=""styled""" & strOnChange & ">"

	dim cmd
	set cmd = Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText = "SELECT companyID, companyName FROM tbl_companies Order By companyName Asc;"
		.Prepared = true
	end with
	
	Set Companies = cmd.Execute()
	do while not Companies.eof
		companyID = Companies("companyID")
		companyName = Companies("companyName")

		'if internal employee is not at least an administrator hide Personnel Plus from list
		if companyID = "67" and user_level < userLevelPPlusAdministrator then
			companyName = ""
		end if
		
		'add company selection
		if len(trim(companyName)) > 0 then
			
			if intCompany = companyID then
				strTemp = strTemp & "<option value=""" & companyID & """ selected=""selected"">" & companyName & "</option>"
			else
				strTemp = strTemp & "<option value=""" & companyID & """>" & companyName & "</option>"
			end if
		end if
		Companies.Movenext
	loop 

	Set Companies = Nothing
	Set cmd = Nothing

	buildCompanySelector = strTemp & "</SELECT>"
	
end function

function CheckField (formField)
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
			Case "typedpassword"
				TempValue = unmask_length(request.form("typedpassword"))
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
end function

function mask_length(password, length)
	mask_length = password & string(length - (len(password)), 255) 'null fill 

end function

function unmask_length(password)
	unmask_length = replace(password, chr(255), "") 
end function

function CheckPhone (PhoneNumber)
	if PhoneNumber = "" then
		CheckPhone = "Phone Number Required"
	elseif len(PhoneNumber) < 13 then
		CheckPhone = "Not enough numbers"
	elseif len(PhoneNumber) > 13 then
		CheckPhone = "Invalid Phone Number"
	Else
		CheckPhone = ""
	end if
end function

sub CreateUserAccount
	dim sqlrealtionID, rsrelationID, addressID, companyID
	
	dim cmd
	set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = MySql
	

	'Database.Open MySql
	' * Note for Future: Need to sanitize database data injection!
	'
	dim creationStamp : creationStamp = Now()
	
	cmd.CommandText = "INSERT INTO tbl_addresses (addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
		"'Personnel'," & _
		"'" & request.form("addOne") & "'," & _
		"'" & request.form("addTwo") & "'," & _
		"'" & request.form("city") & "'," & _
		"'" & request.form("state") & "'," & _
		"'" & request.form("zipcode") & "'," & _
		"'" & request.form("country") & "'," & _
		"Now());SELECT last_insert_id() AS addressID;"	
	
	set dbQuery = cmd.Execute().nextrecordset
	
	dim rsAddressId : rsAddressId = dbQuery("addressID")
	
	cmd.CommandText = "INSERT INTO tbl_users (addressID, userName, userPassword, userLevel, companyID, departmentID, userEmail, userAlternateeMail, userPhone, userSPhone" & _
		", title, firstName, lastName, CreationDate) VALUES (" & _ 
		"'" & rsAddressId & "'," & _
		"'" & request.form("username") & "'," & _
		"'" & request.form("typedpassword") & "'," & _
		"'" & request.form("security") & "'," & _
		"'" & request.form("inpAssignedToCompany") & "'," & _
		"'" & request.form("department") & "'," & _
		"'" & request.form("email") & "'," & _
		"'" & request.form("reemail") & "'," & _
		"'" & FormatPhone(request.form("pphone")) & "'," & _
		"'" & FormatPhone(request.form("sphone")) & "'," & _
		"'" & request.form("title") & "'," & _
		"'" & request.form("nameF") & "'," & _
		"'" & request.form("nameL") & "'," & _
		"Now());SELECT last_insert_id() AS userID;"	
	
	set dbQuery = cmd.Execute().nextrecordset
	
	set cmd = Nothing
	set dbQuery = Nothing
	
	Response.Redirect(FormPostTo & qrySrchAndCompany)
end sub

sub UpdateUserAccount
	dim this_userId
	this_userId =  request.form("userID")
    if this_userId <> "0" then
        Database.Open MySql
	    dim sqlrealtionID, rsrelationID, addressID, userID, companyID, sqlInformation
	    dim this_addressId
	    this_addressId = request.form("addressId")
	


	    dim cmd
	    set cmd = Server.CreateObject("ADODB.Command")
	    cmd.ActiveConnection = MySql
	
	    if len(this_addressId) > 0 then 
		    cmd.CommandText = "UPDATE tbl_addresses SET " &_
			    "address=" & insert_string(request.form("addOne")) & ", " &_
			    "addressTwo=" & insert_string(request.form("addTwo")) & ",  " &_
			    "city=" & insert_string(request.form("city")) & ",  " &_
			    "state=" & insert_string(request.form("state")) & ",  " &_
			    "zip=" & insert_string(request.form("zipcode")) & ",  " &_
			    "country=" & insert_string(request.form("country")) & " Where addressID=" & this_addressId

		    cmd.Execute()
	    end if

	
	    dim this_nameF : this_nameF = request.form("nameF")
	    dim this_nameL : this_nameL = request.form("nameL")
	    dim this_userEmail : this_userEmail = request.form("email")
	
	    if len(this_userId) > 0 then
		    cmd.CommandText = "UPDATE tbl_users SET " &_
			    "userName=" & insert_string(request.form("username")) & ", " &_
			    "userPassword=" & insert_string(request.form("typedpassword")) & ", " &_
			    "userLevel=" & insert_number(request.form("security")) & ", " &_
			    "companyID=" & insert_number(request.form("inpAssignedToCompany")) & ", " &_
			    "departmentID=" & insert_string(request.form("department")) & ", " &_
			    "userEmail=" & insert_string(this_userEmail) & ", " &_ 
			    "userAlternateeMail=" & insert_string(request.form("reemail")) & ", " &_
			    "userPhone=" & insert_string(FormatPhone(request.form("pphone"))) & ", " &_
			    "userSPhone=" & insert_string(FormatPhone(request.form("sphone"))) & ", " &_
			    "title=" & insert_string(request.form("title")) & ", " &_
			    "firstName=" & insert_string(this_nameF) & ", " &_ 
			    "lastName=" & insert_string(this_nameL) & " " &_
			    "WHERE userID=" & this_userId
			
		    cmd.Execute()
		
		    'update Application Info
		    dim ApplicationId
		    cmd.CommandText = "SELECT applicationID FROM tbl_users WHERE userID=" & this_userId
		    set ApplicationId = cmd.Execute
		    if not ApplicationId.eof then
			    dim this_applicationId
			    this_applicationId = cdbl("0" & ApplicationId(0))
			    if this_applicationId > 0 then
				    cmd.CommandText = "UPDATE tbl_applications SET " &_
						    "lastName=" & insert_string(this_nameL) & ", " &_
						    "firstName=" & insert_string(this_nameF) & ", " &_
						    "email=" & insert_string(this_userEmail) & " " &_
						    "WHERE applicationID=" & this_applicationId
				    cmd.Execute
			    end if
		    end if
		    set ApplicationId = nothing
	    end if
	
	    set cmd = Nothing
	    set dbQuery = Nothing
	
	end if

	Response.Redirect(FormPostTo & view & "&UserID=" & this_userId & qrySrchAndCompany)
end sub

function qrySrchAndCompany()

	dim this_company, strOptions
	this_company = request.form("comp")
	if len(this_company) = 0 then
		this_company = request.queryString("comp")
	end if
	
	if len(this_company) > 0 then
			strOptions = "&comp=" & this_company
	end if

	dim this_likeName
	this_likeName = request.form("likeName")
	if len(this_likeName) > 0 then
			strOptions = strOptions & "&likeName=" & this_likeName
	end if

	qrySrchAndCompany = strOptions
	
end function

sub DeleteUsers

	dim UserID : UserID = request.queryString("axe")
	
	Database.Open MySql

	if len(UserID) > 0 then
		
		Set dbQuery = Database.Execute("Select addressID, userID FROM tbl_users WHERE UserID='" & UserID & "'")
		
		if not dbQuery.eof then
			dim addressId : addressId = dbQuery("addressID")
			set dbQuery = Database.Execute("DELETE FROM tbl_users WHERE userID=" & UserID)
			set dbQuery = Database.Execute("DELETE FROM tbl_addresses WHERE addressID=" & addressId)
		end if

		Set dbQuery = Nothing
	end if
	
	Database.Close

end sub

%>
