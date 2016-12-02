<%
const FormPostTo = ""

dim LooksGood

LooksGood = true
if CheckField("username") <> "" then LooksGood = false
if CheckField("password") <> "" then LooksGood = false
if CheckField("nameF") <> "" then LooksGood = false
if CheckField("nameL") <> "" then LooksGood = false
	
if LooksGood = true and formAction = "update" then
	UpdateUserAccount
end if

dim listOfCompanies, currentCompany, whichCompany, companyName

dim CantChangeUserName
CantChangeUserName = "ReadOnly"

dim Title, Department, FirstName, LastName, PrimaryPhone, SecondaryPhone, eMail, ReeMail, Notify, AddressOne
dim AddressTwo, City, UserState, ZipCode, Country, Password, UserLevel, ConfirmPassword, AlternateeMail
dim SecurityLowScope, SecurityHighScope, UserName

Database.Open MySql
Set dbQuery = Database.Execute("Select tbl_users.*, tbl_addresses.* From tbl_users Left Join tbl_addresses On tbl_users.addressID=tbl_addresses.addressID Where userID=" & user_id & ";")
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
Notify = dbQuery("notify")
if isnull(Notify) then
	Notify = true
End if
AlternateeMail = dbQuery("userAlternateEmail")
AddressOne = dbQuery("address")
AddressTwo = dbQuery("addressTwo")
City = dbQuery("city")
UserState = dbQuery("state")
ZipCode = dbQuery("zip")
Country = dbQuery("country")
Database.Close

SecurityLowScope = userLevelSuspended
SecurityHighScope = user_level 


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

sub UpdateUserAccount
	Database.Open MySql
	dim notifyForMySql
	if request.form("notify") = "-1" then
		notifyForMySql = -1
	else
		notifyForMySql = 0
	end if
	
	dim sqlInformation

	sqlInformation = "UPDATE tbl_addresses SET " &_
		"address=" & insert_string(request.form("addOne")) & ", " &_
		"addressTwo=" & insert_string(request.form("addTwo")) & ",  " &_
		"city=" & insert_string(request.form("city")) & ",  " &_
		"state=" & insert_string(request.form("state")) & ",  " &_
		"zip=" & insert_string(request.form("zipcode")) & ",  " &_
		"country=" & insert_string(request.form("country")) & " Where addressID=" & addressId
	set dbQuery=Database.Execute(sqlInformation)
	
	sqlInformation = "UPDATE tbl_users SET " &_
		"userName=" & insert_string(request.form("username")) & ", " &_
		"userPassword=" & insert_string(request.form("password")) & ", " &_
		"userLevel=" & insert_number(request.form("security")) & ", " &_
		"departmentID=" & insert_number(request.form("department")) & ", " &_
		"userEmail=" & insert_string(request.form("email")) & ", " &_ 
		"notify=" & insert_number(notifyForMySql) & ", " &_ 
		"userAlternateeMail=" & insert_string(request.form("reemail")) & ", " &_
		"userPhone=" & insert_string(FormatPhone(request.form("pphone"))) & ", " &_
		"userSPhone=" & insert_string(FormatPhone(request.form("sphone"))) & ", " &_
		"title=" & insert_string(request.form("title")) & ", " &_
		"firstName=" & insert_string(request.form("nameF")) & ", " &_ 
		"lastName=" & insert_string(request.form("nameL")) & " " &_
		"WHERE userID=" & user_id
	set dbQuery=Database.Execute(sqlInformation)

	Database.Close
	Response.Redirect(FormPostTo & "/userHome.asp?AST=updated")
end sub

%>
