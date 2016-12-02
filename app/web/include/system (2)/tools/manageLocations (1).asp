<%
session("add_css") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/controlApplets.js"></script>
<!-- Revised: 4.9.2009 -->
<!-- Original: 07.25.2008 -->
<% 
if userLevelRequired(userLevelPPlusStaff) = true then
	
	'---- App Directory and Native Image Constants
	dim FormPostTo, LooksGood
	
	FormPostTo = "manageLocations.asp?Action="
	const linkImgLocation = "<img style='border:none;' src='/include/style/images/ico_location.gif'>"
	
	LooksGood="true"
	if CheckField("locationname") <> "" then LooksGood = "false"
	if CheckField("city") <> "" then LooksGood = "false"
	if CheckField("addressone") <> "" then LooksGood = "false"
	if CheckField("zipcode") <> "" then LooksGood = "false"
	
	if LooksGood = "true" And request.form("formAction") = "Create Location" then 
		CreateLocation
		ShowLocations
	elseif LooksGood = "true" And request.form("formAction") = "Update Location" then
		UpdateLocation
		ShowLocations
	end if
	
	if request.form("task") = "Delete Selected" then RemoveLocation
	
	Select Case Trim(Request.QueryString("Action")) 
		Case remove
			DeleteLocation
			ShowLocations
		Case view
			ShowLocationForm
		Case Else
			ShowLocations
	End Select
end if

Sub ShowLocations
	dim ID, LocationID, DisplayName, i, Locations(), AddressOne, AddressTwo, City, LocState, ZipCode, Country

	dLink = "<a href='/include/system/tools/manageLocations.asp?Action=" & view & "&amp;AddressID="
	LocationID = 0
	Display = 1
	Database.Open MySql
	
	i = CountRecords("addressID", "tbl_addresses", "companyID=" & companyId)
	Redim Locations(i, 1)
	
	Set dbQuery = Database.Execute("Select addressID From tbl_addresses Where companyID=" & companyId) 
	i = 0
	if dbQuery.eof = true then NoLocations = true
	do while not dbQuery.eof
		ID = dbQuery("addressID")
		if ID = company_addressId then
			Locations(i, Display) = "* " & GetAddress("addressID=" & ID, True)
		Else
			Locations(i, Display) = GetAddress("addressID=" & ID, True)
		end if
		Locations(i, LocationID) = ID & "'>"
		i = i + 1
	
		dbQuery.Movenext
	loop
	response.write decorateTop("manageLocations", "marLR10", "Company Locations")
	response.write "<form action=" & FormPostTo & add & " method=""post"" name=""taskaccount"">" &_
		"<table style=""margin:15px;border:none"" width=""605"">" &_
    "<tr>" &_
      "<td width=""40""></td>" &_
      "<td width=""162""></td>" &_
      "<td width=""40""></td>" &_
      "<td width=""162""></td>" &_
      "<td width=""40""></td>" &_
      "<td width=""162""></td>" &_
    "</tr>" &_
    "<tr>"
      
	For i = 0 to ubound(Locations) - 1
		
		if x > 2 then 
			x = 0
			response.write("</tr><tr class='marB15'>")
		end if
		x = x + 1
		response.write("<td valign='top'><input class='alignT borNone' type='checkbox' name='checkLocation" & Locations(i, LocationID) & linkImgLocation)
		response.write("</td><td valign='top'>" & dLink & Locations(i, LocationID))
		response.write(Locations(i, Display) & "<br><br></a></td>")
	Next
	if NoLocations = true then
		response.write("<td>No Locations Found, Click Add Locations Below To Get Started.</td>")
	end if
	
	response.write "</tr>" &_
		"</table>" &_
		"<a class=""squarebutton"" href=""" & FormPostTo & add & """ style=""margin-left: 6px"">" &_
		"<span>Add Location</span></a><a class=""squarebutton"" href=""javascript:;"" onclick=""document.taskaccount.submit();"">" &_
		"<span>Delete Selected</span></a>" &_
		"<p class=""formErrMsg"">* - Denotes Primary Company Location</p>" &_
		"</form>"
		
	response.write  decorateBottom()

	Set dbQuery = Nothing
	Database.Close
End Sub

Sub ShowLocationForm
	dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail
	
	
	Submit = request.form("Submit")
	if Submit = "Return To Manage Locations" then 
		Response.Redirect(FormPostTo & manage)
	elseif Submit = "Update Location" Or Submit = "Revert Back" then
		SubmitValue = "Update Location"
		ResetValue = "Revert Back"
	Else
		SubmitValue = "Create Location"
		ResetValue = "Start Over"
	end if
	
	if request.form("task") = "Delete Selected" then ShowLocations
	
	if Request.QueryString("action") = add then
		if request.form("Submit") <> "Start Over" then
			LocationID = request.form("locationid")
			LocationName = request.form("locationname")
			AddressOne = request.form("addressone")
			AddressTwo = request.form("addresstwo")
			City = request.form("city")
			LocState = request.form("locstate")
			ZipCode = request.form("zipcode")
			Country = FormatPhone(request.form("country"))
		end if
	elseif Request.QueryString("action") = view then
		SubmitValue = "Update Location"
		ResetValue = "Revert Back"
		
		Database.Open MySql
	
		Set dbQuery = Database.Execute("Select * From tbl_addresses Where addressID=" & Request.QueryString("AddressID"))
		LocationID = dbQuery("addressID")
		LocationName = dbQuery("addressName")
		AddressOne = dbQuery("address")
		AddressTwo = dbQuery("addresstwo")
		City = dbQuery("city")
		LocState = dbQuery("state")
		ZipCode = dbQuery("zip")
		Country = dbQuery("country")
	
		Database.Close
		Set dbQuery = Nothing
	elseif Request.QueryString("action") = "" then
		ShowLocations
	end if
	
	Response.write decorateTop("", "marLR10", "Location Information")
	Response.write "<form name=""manageLocation"" id=""manageLocation"" method=""post"" action=""" & FormPostTo & add & """>" &_
      "<div id=""locationView""><p>" &_
        "<label for=""locationname"">Location Name</label>" &_
        "<input type=""text"" name=""locationname"" size=""35"" value=""" & locationname & """>" &_
      "</p>" &_
      "<p class=""formErrMsg"">" & CheckField("locationname") & "&nbsp;</p>" &_
      "<p>" &_
        "<label for=""addressone"">Address</label>" &_
        "<input type=""text"" name=""addressone"" size=""35"" value=""" & AddressOne & """>" &_
      "</p>" &_
      "<p class=""formErrMsg"">" & CheckField("addressone") & "&nbsp;</p>" &_
      "<p>" &_
        "<label for=""addresstwo"">Address Two</label>" &_
        "<input type=""text"" name=""addresstwo"" size=""35"" value=""" & AddressTwo & """>" &_
      "</p>" &_
      "<p class=""formErrMsg"">&nbsp;</p>" &_
      "<p>" &_
        "<label for=""city"">City</label>" &_
        "<input type=""text"" name=""city"" size=""13"" value=""" & City & """>" &_
      "</p>" &_
      "<p class=""formErrMsg"">&nbsp;</p>" &_
      "<p>" &_
        "<label for=""locstate"">State</label>" &_
        "<select name=""locstate"">" &_
         "<option value=""ID"">ID</option>"
	
	response.write PopulateList("list_locations", "locCode", "locCode", "locCode", LocState)
       
	response.write "</select>" &_
      "</p>" &_
      "<p class=""formErrMsg"">" & CheckField("city") & "&nbsp;</p>" &_
      "<p>" &_
        "<label for=""zipcode"">Zip Code</label>" &_
        "<input type=""text"" name=""zipcode"" size=""13"" value=""" & ZipCode & """>" &_
      "</p>" &_
      "<p class=""formErrMsg"">&nbsp;</p>" &_
      "<p>" &_
        "<label for=""country"">Country</label>" &_
        "<select name=""country"">" &_
         "<option value=""USA"">USA</option>" &_
          "<option value=""CA"">CA</option>" &_
        "</select>" &_
      "</p>" &_
      "<p class=""formErrMsg"">" & CheckField("zipcode") & "&nbsp;</p>" &_
      "<p>" &_
        "<input name=""locationid"" id=""locationid"" type=""hidden"" value=""" & LocationID& """>" &_
        "<input name=""formAction"" type=""hidden"" value="""">" &_
      "</p>" &_
"<a class=""squarebutton"" href=""javascript:;"" onclick=""document.manageLocation.formAction.value='" & SubmitValue &_
	"';document.manageLocation.submit();"" style=""margin-left: 6px""><span>" & SubmitValue & "</span></a> <a class=""" &_
	"squarebutton"" href=""javascript:;"" style=""margin-left: 6px"" onclick=""document.manageLocation.formAction.value='" &_
	ResetValue & "';document.manageLocation.submit();""><span>" & ResetValue & "</span></a>" &_
	"<a class=""squarebutton"" href=""" & FormPostTo & manage & """><span>Return To Manage Locations</span></a></div>" &_
"</div></form>"
Response.write DecorateBottom()

End Sub

Function CheckField (formField)
	if Request.QueryString("action") <> view then
		Select Case	formField
			Case "locationname"
				if request.form("locationname") = "" then
					CheckField = "Location Name Required"
				Else
					CheckField = ""
				end if
			Case "addressone"
				if request.form("addressone") = "" then
					CheckField = "Address Required"
				Else
					CheckField = ""
				end if
			Case "city"
				if request.form("city") = "" then
					CheckField = "City Required"
				Else
					CheckField = ""
				end if
			Case "zipcode"
				if request.form("zipcode") = "" then
					CheckField = "Zip Code Required"
				Else
					CheckField = ""
				end if

		End Select	
	end if
End Function

Sub CreateLocation
	dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql

	sqlInformation = "INSERT INTO tbl_addresses (companyID, addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
	"'" & companyId & "'," & _
	"'" & request.form("locationname") & "'," & _
	"'" & request.form("addressone") & "'," & _
	"'" & request.form("addresstwo") & "'," & _
	"'" & request.form("city") & "'," & _
	"'" & request.form("locstate") & "'," & _
	"'" & request.form("zipcode") & "'," & _
	"'" & request.form("country") & "'," & _
	"'" & Now() & "')"	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub UpdateLocation
	Database.Open MySql
	dim sqlrealtionID, rsrelationID, addressID, userID, companyID

	sqlInformation = "Update tbl_addresses Set addressName='" & request.form("locationname") & "', address='" & _
	request.form("addressone") & "', addressTwo='" & request.form("addresstwo") & "', city='" & _ 
	request.form("city") & "', state='" & request.form("locstate") & "', zip='" & request.form("zipcode") & _
	"', country='" & request.form("country") & "' Where addressID=" & request.form("locationid")
	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Response.Redirect(FormPostTo & manage)
End Sub

Sub RemoveLocation
	dim ID, DisplayName, i, LocationID, LocationsToAxe()
	LocationID = 1
	Database.Open MySql
	i = CountRecords("addressID", "tbl_addresses", "companyID=" & companyId)
	Redim LocationsToAxe(i)
	
	Set dbQuery = Database.Execute("Select addressID, addressName From tbl_addresses Where companyID=" & companyId) 
	i = 0
	do while not dbQuery.eof
		LocationsToAxe(i) = dbQuery("addressID")
		if request.form("checkLocation" & LocationsToAxe(i)) = "on" then
			if Not LocationsToAxe(i) = company_addressId then
				AxedLocations = AxedLocations & dbQuery("addressName") & "; "
			end if
		end if
		i = i + 1
		dbQuery.Movenext
	loop

	For i = 0 To UBound(LocationsToAxe)
		if request.form("checkLocation" & LocationsToAxe(i)) = "on" then
			if Not LocationsToAxe(i) = company_addressId then
				Database.Execute("Delete From tbl_addresses Where addressID=" & LocationsToAxe(i))
			Else
				CantAxePrimary = "<br><br>The Primary Company Address cannot be deleted only updated."
			end if
		end if
	Next
	Set dbQuery = Nothing
	Database.Close
	if len(AxedLocations) > 0 Or len(CantAxePrimary) > 0 then
		if len(AxedLocatins) = 0 then AxedLocations = "None"
		%>
<div class="sideMargin bottommargin">
  <div class="normalTitle">Sub Company Locations Removed</div>
  <p style="text-align:left; margin:0 10 10 10;"> The following sub locations and related information has been removed from the system: <br>
    <br>
    <%=AxedLocations%><%=CantAxePrimary%> 
</div>
<%
	end if
End Sub


%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
