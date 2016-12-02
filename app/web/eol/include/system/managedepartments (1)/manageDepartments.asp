<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
<% 
'---- App Directory and Native Image Constants
FormPostTo = "/tools/system/managedepartments/manageDepartments.asp?Action="

Const linkImgDepartment = "<img style='border:none;' src='/include/style/images/ico_department.gif'>"

Dim LooksGood

LooksGood="true"
If CheckField("departmentname") <> "" Then LooksGood = "false"

If LooksGood = "true" And Request.Form("Submit") = "Create Department" Then 
	CreateDepartment
	ShowDepartments
ElseIf LooksGood = "true" And Request.Form("Submit") = "Update Department" Then
	UpdateDepartment
	ShowDepartments
End If

If Request.Form("task") = "Delete Selected" Then RemoveDepartment

Select Case Trim(Request.QueryString("Action")) 
	Case remove
		RemoveDepartment
		ShowDepartments
	Case manage
		ShowDepartments
	Case Else
		ShowDepartmentForm
End Select

Sub ShowDepartments
	Dim DepartmentID, DisplayName, i, Departments(), AddressOne, AddressTwo, City, LocState, ZipCode, Country

	dLink = "<a href='/tools/system/manageDepartments/manageDepartments.asp?Action=" & view & "&amp;DepartmentID="
	DepartmentID = 0
	Display = 1
	Database.Open MySql
	
	i = CountRecords("departmentID", "tbl_departments", "companyID=" & Session("companyID"))
	Redim Departments(i, 1)
	
	Set dbQuery = Database.Execute("Select departmentID, name From tbl_departments Where companyID=" & Session("companyID")) 
	i = 0
	If dbQuery.EOF = True Then NoDepartments = True
	Do While Not dbQuery.EOF
		Departments(i, Display) =  dbQuery("name")
		Departments(i, DepartmentID) = dbQuery("departmentID") & "'>"
		i = i + 1
		dbQuery.Movenext
	Loop
	%>
	
	<div class="bordered">
		<div class="normalTitle bottommargin">Manage Company Departments</div>
		<div class="pageSubContent">
		<form action=<%=FormPostTo & add%> method="post" name="taskaccount">
		<table>
			<tr>
				<td width='25%'></td><td width='25%'></td><td width='25%'></td><td width='25%'></td>
			</tr>
			<tr>
				<%
				For i = 0 to ubound(Departments) - 1
					
					If x > 3 Then 
						x = 0
						Response.Write("</tr><tr></tr><tr>")
					End If
					x = x + 1
					Response.Write("<td style='text-align:center'><input style='margin-bottom:3px;'")
					Response.Write("type='checkbox' name='checkDepartment" & Departments(i, DepartmentID) & linkImgDepartment)
					Response.Write(dLink & Departments(i, DepartmentID) & Departments(i, Display) & "</a></td>")
				Next
				If NoDepartments = True Then
					Response.Write("<td>No Departments Found, Click Add Department Below To Get Started.</td>")
				End If
				%>
			</tr>
		</table>
		</form>
		</div>
		</div>
	
			<p>Select A Department Above To Make Changes</p>
				<div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:;" style="margin-left: 6px" onclick="document.forms['SignIn'].submit();"><span>Delete Selected</span></a> <a class="squarebutton" href="javascript:;" onclick="document.forms['SignIn'].submit();"><span>Add Department</span></a> </div>

	<%
	Set dbQuery = Nothing
	Database.Close
	
	%>
	<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
	<%
	Response.End
End Sub

Sub ShowDepartmentForm
Dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail


Submit = Request.Form("Submit")
If Submit = "Return To Manage Departments" Then 
	Response.Redirect(FormPostTo & manage)
ElseIf Submit = "Update Department" Or Submit = "Revert Back" Then
	SubmitValue = "Update Department"
	ResetValue = "Revert Back"
Else
	SubmitValue = "Create Department"
	ResetValue = "Start Over"
End If

If Request.Form("task") = "Delete Selected" Then ShowDepartments

If Request.QueryString("action") = add Then
	If Request.Form("Submit") <> "Start Over" Then
		DepartmentID = Request.Form("departmentid")
		DepartmentName = Request.Form("departmentname")
		DepartmentLocation = Request.Form("location")
	End If
ElseIf Request.QueryString("action") = view Or Request.Form("Submit") = "Revert Back" Then
	SubmitValue = "Update Department"
	ResetValue = "Revert Back"
	
	Database.Open MySql

	Set dbQuery = Database.Execute("Select * From tbl_departments Where departmentID=" & Request.QueryString("DepartmentID"))
	DepartmentID = dbQuery("departmentID")
	DepartmentName = dbQuery("name")
	DepartmentLocation = dbQuery("addressID")

	Database.Close
	Set dbQuery = Nothing
ElseIf Request.QueryString("action") = "" Then
	ShowDepartments
End If

%>

<form method="post" action="<%=FormPostTo & add%>">
<div class="sideMargin border" style="margin-left:-2px">
	<div class="normalTitle" style="margin-bottom:5px;">Company Department Information</div>
	<div class="divided"> 
		<p class="h"><img src="/include/style/images/createDepartment.jpg" style="padding-left:10;padding-bottom:10;"></p>
	</div>
	<div class="divided"> 
		<p><label for="departmentname" class="ToolBox">Department Name</label>
		<input type="text" name="departmentname"  style="width:250;" value="<%=departmentname%>"></p>
		<p class="formErrMsg" style="padding-left:165px;"><%=CheckField("departmentname")%>&nbsp;</p>

		<p><label for="location" class="ToolBox">Associate With</label>
		<select name="location" style="width:250;">
		<option value="0">Not Associated With Any Location (Global)</option>
		<%=populateList("tbl_addresses", "addressID", "addressName", "Where companyID=" & Session("companyID") & " Order By addressName", DepartmentLocation)%></select></p>
	</div>
</div>

<div class="sideMargin">
	<p class="v h">
	<input name="departmentid" id="departmentid" type="hidden" value="<%=DepartmentID%>">
	<input name="Submit" id="Submit" type="submit" class="normalbtn" value="Return To Manage Departments">
	<input name="Submit" id="Submit" type="submit" class="normalbtn" value="<%=ResetValue%>">
	<input name="Submit" id="Submit" type="submit" class="normalbtn" value="<%=SubmitValue%>"></p>
</div>
</form>

<%
End Sub

Function CheckField (formField)
	If Request.QueryString("action") <> view Then
		Select Case	formField
			Case "departmentname"
				If Request.Form("departmentname") = "" Then
					CheckField = "Department Name Required"
				Else
					CheckField = ""
				End If
		End Select	
	End If
End Function

Sub CreateDepartment
	Dim sqlInformation
	Database.Open MySql

	sqlInformation = "INSERT INTO tbl_departments (companyID, name, addressID, CreationDate) VALUES (" & Session("companyID") & "," & _
	"'" & Request.Form("departmentname") & "'," & Request.Form("location") & "," & "'" & Now() & "')"
	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Set dbQuery = Nothing
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub UpdateDepartment
	Dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql

	sqlInformation = "Update tbl_departments Set name='" & Request.Form("departmentname") & "', addressID='" & _
	Request.Form("location") & "' Where departmentID=" & Request.Form("departmentid")
	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Set dbQuery = Nothing
	Response.Redirect(FormPostTo & manage)
End Sub

Sub RemoveDepartment
	Dim ID, DisplayName, i, DepartmentID, DepartmentsToAxe()
	DepartmentID = 1
	Database.Open MySql
	i = CountRecords("departmentID", "tbl_departments", "companyID=" & Session("companyID"))
	Redim DepartmentsToAxe(i)
	
	Set dbQuery = Database.Execute("Select departmentID, name From tbl_departments Where companyID=" & Session("companyID")) 
	i = 0
	Do While Not dbQuery.EOF
		DepartmentsToAxe(i) = dbQuery("departmentID")
		If Request.Form("checkDepartment" & DepartmentsToAxe(i)) = "on" Then
			AxedDepartments = AxedDepartments & dbQuery("name") & "; "
		End If
		i = i + 1
		dbQuery.Movenext
	Loop

	For i = 0 To UBound(DepartmentsToAxe)
		If Request.Form("checkDepartment" & DepartmentsToAxe(i)) = "on" Then
			Database.Execute("Delete From tbl_departments Where departmentID=" & DepartmentsToAxe(i))
		End If
	Next
	Set dbQuery = Nothing
	Database.Close
	If Len(AxedDepartments) > 0 Then
		%>
		<div class="sideMargin bottommargin">
			<div class="normalTitle">Company Department(s) Removed</div>
			<p style="text-align:left; margin-bottom:10;margin-left:10;margin-right:10;">
			The following sub departments and related information were removed from the system:
			<br><br><%=AxedDepartments%>
		</div>
		<%
	End If
End Sub
%>

<!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
