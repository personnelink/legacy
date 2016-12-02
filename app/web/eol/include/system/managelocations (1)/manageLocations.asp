<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
<!-- Revised: 07.25.2008 -->

<% 
'---- App Directory and Native Image Constants
FormPostTo = "/tools/system/managelocations/manageLocations.asp?Action="
Const linkImgLocation = "<img style='border:none;' src='/include/style/images/ico_location.gif'>"

Dim LooksGood

LooksGood="true"
If CheckField("locationname") <> "" Then LooksGood = "false"
If CheckField("city") <> "" Then LooksGood = "false"
If CheckField("addressone") <> "" Then LooksGood = "false"
If CheckField("zipcode") <> "" Then LooksGood = "false"

If LooksGood = "true" And Request.Form("formAction") = "Create Location" Then 
	CreateLocation
	ShowLocations
ElseIf LooksGood = "true" And Request.Form("formAction") = "Update Location" Then
	UpdateLocation
	ShowLocations
End If

If Request.Form("task") = "Delete Selected" Then RemoveLocation

Select Case Trim(Request.QueryString("Action")) 
	Case remove
		DeleteLocation
		ShowLocations
	Case manage
		ShowLocations
	Case Else
		ShowLocationForm
End Select

Sub ShowLocations
	Dim ID, LocationID, DisplayName, i, Locations(), AddressOne, AddressTwo, City, LocState, ZipCode, Country

	dLink = "<a href='/tools/system/manageLocations/manageLocations.asp?Action=" & view & "&amp;AddressID="
	LocationID = 0
	Display = 1
	Database.Open MySql
	
	i = CountRecords("addressID", "tbl_addresses", "companyID=" & Session("companyID"))
	Redim Locations(i, 1)
	
	Set dbQuery = Database.Execute("Select addressID From tbl_addresses Where companyID=" & Session("companyID")) 
	i = 0
	If dbQuery.EOF = True Then NoLocations = True
	Do While Not dbQuery.EOF
		ID = dbQuery("addressID")
		If ID = Session("companyAddressID") Then
			Locations(i, Display) = "* " & GetAddress("addressID=" & ID, True)
		Else
			Locations(i, Display) = GetAddress("addressID=" & ID, True)
		End If
		Locations(i, LocationID) = ID & "'>"
		i = i + 1
	
		dbQuery.Movenext
	Loop
	%>
<div class="bordered">
	<div class="normalTitle" style="margin-bottom:0;">Manage Company Locations</div>
	<div class="pageSubContent">
		<form action=<%=FormPostTo & add%> method="post" name="taskaccount">
			<table style="margin:15px;border:none" width="605">
				<tr>
					<td width='40'></td>
					<td width='162'></td>
					<td width='40'></td>
					<td width='162'></td>
					<td width='40'></td>
					<td width='162'></td>
				</tr>
				<tr>
					<%
				For i = 0 to ubound(Locations) - 1
					
					If x > 2 Then 
						x = 0
						Response.Write("</tr><tr class='marB15'>")
					End If
					x = x + 1
					Response.Write("<td valign='top'><input class='alignT borNone' type='checkbox' name='checkLocation" & Locations(i, LocationID) & linkImgLocation)
					Response.Write("</td><td valign='top'>" & dLink & Locations(i, LocationID))
					Response.Write(Locations(i, Display) & "<br><br></a></td>")
				Next
				If NoLocations = True Then
					Response.Write("<td>No Locations Found, Click Add Locations Below To Get Started.</td>")
				End If
				%>
				</tr>
			</table>
		</form>
	</div>
</div>
			<p class="formErrMsg">* - Denotes Primary Company Location</p>
<div class="buttonwrapper" style="padding:10px 0 10px 0;"><a class="squarebutton" href="<%=FormPostTo & add%>" style="margin-left: 6px"><span>Add Location</span></a><a class="squarebutton" href="javascript:;" onclick="document.taskaccount.submit();"><span>Delete Selected</span></a></div>
<%
	Set dbQuery = Nothing
	Database.Close
	
	TheEnd

End Sub

Sub ShowLocationForm
Dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail


Submit = Request.Form("Submit")
If Submit = "Return To Manage Locations" Then 
	Response.Redirect(FormPostTo & manage)
ElseIf Submit = "Update Location" Or Submit = "Revert Back" Then
	SubmitValue = "Update Location"
	ResetValue = "Revert Back"
Else
	SubmitValue = "Create Location"
	ResetValue = "Start Over"
End If

If Request.Form("task") = "Delete Selected" Then ShowLocations

If Request.QueryString("action") = add Then
	If Request.Form("Submit") <> "Start Over" Then
		LocationID = Request.Form("locationid")
		LocationName = Request.Form("locationname")
		AddressOne = Request.Form("addressone")
		AddressTwo = Request.Form("addresstwo")
		City = Request.Form("city")
		LocState = Request.Form("locstate")
		ZipCode = Request.Form("zipcode")
		Country = FormatPhone(Request.Form("country"))
	End If
ElseIf Request.QueryString("action") = view Then
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
ElseIf Request.QueryString("action") = "" Then
	ShowLocations
End If

%>
<form name="manageLocation" method="post" action="<%=FormPostTo & add%>">
	<div class="bordered">
		<div class="normalTitle" style="margin-bottom:5px;">Company Location Information</div>
		<div class="pageSubContent">
			<p class="h"><img src="/include/style/images/createLocation.jpg" style="padding:15px"></p>
			<p>
				<label for="locationname">Location Name</label>
				<input type="text" name="locationname" size="35" value="<%=locationname%>">
			</p>
			<p class="formErrMsg"><%=CheckField("locationname")%>&nbsp;</p>
			<p>
				<label for="addressone">Address</label>
				<input type="text" name="addressone" size="35" value="<%=AddressOne%>">
			</p>
			<p class="formErrMsg"><%=CheckField("addressone")%>&nbsp;</p>
			<p>
				<label for="addresstwo">Address Two</label>
				<input type="text" name="addresstwo" size="35" value="<%=AddressTwo%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="city">City</label>
				<input type="text" name="city" size="13" value="<%=City%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="locstate">State</label>
			<select name="locstate">
				<option value="ID">ID</option>
				<%=PopulateList("list_locations", "locCode", "locCode", "locCode", LocState)%>
			</select>
			</p>
			<p class="formErrMsg"><%=CheckField("city")%>&nbsp;</p>
			<p>
				<label for="zipcode">Zip Code</label>
				<input type="text" name="zipcode" size="13" value="<%=ZipCode%>">
			</p>
			<p class="formErrMsg">&nbsp;</p>
			<p>
				<label for="country">Country</label>
				<select name="country">
					<option value="USA">USA</option>
					<option value="CA">CA</option>
				</select>
			</p>
			<p class="formErrMsg"><%=CheckField("zipcode")%>&nbsp;</p>
			<p>
				<input name="locationid" id="locationid" type="hidden" value="<%=LocationID%>">
				<input name="formAction" type="hidden" value="">
			</p>
		</div>
	</div>
			<div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:;" onclick="document.manageLocation.formAction.value='<%=SubmitValue%>';document.manageLocation.submit();" style="margin-left: 6px"><span><%=SubmitValue%></span></a> <a class="squarebutton" href="javascript:;" style="margin-left: 6px" onclick="document.manageLocation.formAction.value='<%=ResetValue%>';document.manageLocation.submit();"><span><%=ResetValue%></span></a> <a class="squarebutton" href="<%=FormPostTo & manage%>"><span>Return To Manage Locations</span></a> </div>
	</div>
</form>
<%
End Sub

Function CheckField (formField)
	If Request.QueryString("action") <> view Then
		Select Case	formField
			Case "locationname"
				If Request.Form("locationname") = "" Then
					CheckField = "Location Name Required"
				Else
					CheckField = ""
				End If
			Case "addressone"
				If Request.Form("addressone") = "" Then
					CheckField = "Address Required"
				Else
					CheckField = ""
				End If
			Case "city"
				If Request.Form("city") = "" Then
					CheckField = "City Required"
				Else
					CheckField = ""
				End If
			Case "zipcode"
				If Request.Form("zipcode") = "" Then
					CheckField = "Zip Code Required"
				Else
					CheckField = ""
				End If

		End Select	
	End If
End Function

Sub CreateLocation
	Dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql

	sqlInformation = "INSERT INTO tbl_addresses (companyID, addressName, address, addressTwo, city, state, zip, country, CreationDate) VALUES (" & _
	"'" & Session("companyID") & "'," & _
	"'" & Request.Form("locationname") & "'," & _
	"'" & Request.Form("addressone") & "'," & _
	"'" & Request.Form("addresstwo") & "'," & _
	"'" & Request.Form("city") & "'," & _
	"'" & Request.Form("locstate") & "'," & _
	"'" & Request.Form("zipcode") & "'," & _
	"'" & Request.Form("country") & "'," & _
	"'" & Now() & "')"	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub UpdateLocation
	Database.Open MySql
	Dim sqlrealtionID, rsrelationID, addressID, userID, companyID

	sqlInformation = "Update tbl_addresses Set addressName='" & Request.Form("locationname") & "', address='" & _
	Request.Form("addressone") & "', addressTwo='" & Request.Form("addresstwo") & "', city='" & _ 
	Request.Form("city") & "', state='" & Request.Form("locstate") & "', zip='" & Request.Form("zipcode") & _
	"', country='" & Request.Form("country") & "' Where addressID=" & Request.Form("locationid")
	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Response.Redirect(FormPostTo & manage)
End Sub

Sub RemoveLocation
	Dim ID, DisplayName, i, LocationID, LocationsToAxe()
	LocationID = 1
	Database.Open MySql
	i = CountRecords("addressID", "tbl_addresses", "companyID=" & Session("companyID"))
	Redim LocationsToAxe(i)
	
	Set dbQuery = Database.Execute("Select addressID, addressName From tbl_addresses Where companyID=" & Session("companyID")) 
	i = 0
	Do While Not dbQuery.EOF
		LocationsToAxe(i) = dbQuery("addressID")
		If Request.Form("checkLocation" & LocationsToAxe(i)) = "on" Then
			If Not LocationsToAxe(i) = Session("companyAddressID") Then
				AxedLocations = AxedLocations & dbQuery("addressName") & "; "
			End If
		End If
		i = i + 1
		dbQuery.Movenext
	Loop

	For i = 0 To UBound(LocationsToAxe)
		If Request.Form("checkLocation" & LocationsToAxe(i)) = "on" Then
			If Not LocationsToAxe(i) = Session("companyAddressID") Then
				Database.Execute("Delete From tbl_addresses Where addressID=" & LocationsToAxe(i))
			Else
				CantAxePrimary = "<br><br>The Primary Company Address cannot be deleted only updated."
			End If
		End If
	Next
	Set dbQuery = Nothing
	Database.Close
	If Len(AxedLocations) > 0 Or Len(CantAxePrimary) > 0 Then
		If Len(AxedLocatins) = 0 Then AxedLocations = "None"
		%>
<div class="sideMargin bottommargin">
	<div class="normalTitle">Sub Company Locations Removed</div>
	<p style="text-align:left; margin:0 10 10 10;"> The following sub locations and related information has been removed from the system: <br>
		<br>
		<%=AxedLocations%><%=CantAxePrimary%> 
</div>
<%
	End If
End Sub
%>
<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
