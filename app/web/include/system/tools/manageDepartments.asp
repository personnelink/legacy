<%
session("add_css") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/controlApplets.js"></script>
<!-- Revised: 4.7.2009 -->
<%
if userLevelRequired(userLevelPPlusStaff) = true then

	'---- App Directory and Native Image Constants
	FormPostTo = "manageDepartments.asp?Action="
	
	const linkImgDepartment = "<img style='border:none;' src='/include/style/images/ico_department.gif'>"
	
	dim LooksGood
	
	LooksGood="true"
	if CheckField("departmentname") <> "" then LooksGood = "false"
	
	if LooksGood = "true" And request.form("Submit") = "Create Department" then 
		CreateDepartment
		ShowDepartments
	elseif LooksGood = "true" And request.form("Submit") = "Update Department" then
		UpdateDepartment
		ShowDepartments
	end if
	
	if request.form("task") = "Delete Selected" then RemoveDepartment
	
	Select Case Trim(Request.QueryString("Action")) 
		Case remove
			RemoveDepartment
			ShowDepartments
		Case view
			ShowDepartmentForm
		Case Else
			ShowDepartments
	End Select
end if

Sub ShowDepartments
	dim DepartmentID, DisplayName, i, Departments(), AddressOne, AddressTwo, City, LocState, ZipCode, Country

	dLink = "<a href='/include/system/tools/manageDepartments.asp?Action=" & view & "&amp;DepartmentID="
	DepartmentID = 0
	Display = 1
	Database.Open MySql
	
	i = CountRecords("departmentID", "tbl_departments", "companyID=" & companyId)
	Redim Departments(i, 1)
	
	Set dbQuery = Database.Execute("Select departmentID, name From tbl_departments Where companyID=" & companyId) 
	i = 0
	if dbQuery.eof = true then NoDepartments = true
	do while not dbQuery.eof
		Departments(i, Display) =  dbQuery("name")
		Departments(i, DepartmentID) = dbQuery("departmentID") & "'>"
		i = i + 1
		dbQuery.Movenext
	loop
	%>

<%=decorateTop("manageDepartments", "marLR10", "Departments")%>
<form id="manageDepartments" name="manageDepartments" action="<%=FormPostTo & add%>" method="post">

      <table>
        <tr>
          <td width='25%'></td>
          <td width='25%'></td>
          <td width='25%'></td>
          <td width='25%'></td>
        </tr>
        <tr>
          <%
				For i = 0 to ubound(Departments) - 1
					
					if x > 3 then 
						x = 0
						response.write("</tr><tr></tr><tr>")
					end if
					x = x + 1
					response.write("<td style='text-align:center'><input style='margin-bottom:3px;'")
					response.write("type='checkbox' name='checkDepartment" & Departments(i, DepartmentID) & linkImgDepartment)
					response.write(dLink & Departments(i, DepartmentID) & Departments(i, Display) & "</a></td>")
				Next
				if NoDepartments = true then
					response.write("<td>No Departments Found, Click Add Department Below To Get Started.</td>")
				end if
				%>
        </tr>
      </table>
<p>Select A Department Above To Make Changes</p>
<a class="squarebutton" href="javascript:;" style="margin-left: 6px" onclick="document.forms['SignIn'].submit();"><span>Delete Selected</span></a> <a class="squarebutton" href="javascript:;" onclick="document.forms['SignIn'].submit();"><span>Add Department</span></a>
    </form>
<%=DecorateBottom()%>	
<%
	Set dbQuery = Nothing
	Database.Close
End Sub

Sub ShowDepartmentForm
dim UserName, FirstName, MiddleName, LastName, AddressOne, AddressTwo, City, UserState, ZipCode, Country, PrimaryPhone, SecondaryPhone, eMail, ReeMail


Submit = request.form("Submit")
if Submit = "Return To Manage Departments" then 
	Response.Redirect(FormPostTo & manage)
elseif Submit = "Update Department" Or Submit = "Revert Back" then
	SubmitValue = "Update Department"
	ResetValue = "Revert Back"
Else
	SubmitValue = "Create Department"
	ResetValue = "Start Over"
end if

if request.form("task") = "Delete Selected" then ShowDepartments

if Request.QueryString("action") = add then
	if request.form("Submit") <> "Start Over" then
		DepartmentID = request.form("departmentid")
		DepartmentName = request.form("departmentname")
		DepartmentLocation = request.form("location")
	end if
elseif Request.QueryString("action") = view Or request.form("Submit") = "Revert Back" then
	SubmitValue = "Update Department"
	ResetValue = "Revert Back"
	
	Database.Open MySql

	Set dbQuery = Database.Execute("Select * From tbl_departments Where departmentID=" & Request.QueryString("DepartmentID"))
	DepartmentID = dbQuery("departmentID")
	DepartmentName = dbQuery("name")
	DepartmentLocation = dbQuery("addressID")

	Database.Close
	Set dbQuery = Nothing
elseif Request.QueryString("action") = "" then
	ShowDepartments
end if

%>

<%=decorateTop("departmentForm", "marLR10", "Details")%>
<form id="manageDepartments" name="manageDepartments" action="<%=FormPostTo & add%>" method="post">
      <p class="h"><img src="/include/style/images/createDepartment.jpg" style="padding-left:10;padding-bottom:10;"></p>
      <p>
        <label for="departmentname" class="ToolBox">Department Name</label>
        <input type="text" name="departmentname"  style="width:250;" value="<%=departmentname%>">
      </p>
      <p class="formErrMsg" style="padding-left:165px;"><%=CheckField("departmentname")%>&nbsp;</p>
      <p>
        <label for="location" class="ToolBox">Associate With</label>
        <select name="location" style="width:250;">
          <option value="0">Not Associated With Any Location (Global)</option>
          <%=populateList("tbl_addresses", "addressID", "addressName", "Where companyID=" & companyId & " Order By addressName", DepartmentLocation)%>
        </select>
      </p>
    <p class="v h">
      <input name="departmentid" id="departmentid" type="hidden" value="<%=DepartmentID%>">
      <input name="Submit" id="Submit" type="submit" class="normalbtn" value="Return To Manage Departments">
      <input name="Submit" id="Submit" type="submit" class="normalbtn" value="<%=ResetValue%>">
      <input name="Submit" id="Submit" type="submit" class="normalbtn" value="<%=SubmitValue%>">
    </p>
</form>
<%=DecorateBottom()%>
<%
End Sub

Function CheckField (formField)
	if Request.QueryString("action") <> view then
		Select Case	formField
			Case "departmentname"
				if request.form("departmentname") = "" then
					CheckField = "Department Name Required"
				Else
					CheckField = ""
				end if
		End Select	
	end if
End Function

Sub CreateDepartment
	dim sqlInformation
	Database.Open MySql

	sqlInformation = "INSERT INTO tbl_departments (companyID, name, addressID, CreationDate) VALUES (" & companyId & "," & _
	"'" & request.form("departmentname") & "'," & request.form("location") & "," & "'" & Now() & "')"
	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Set dbQuery = Nothing
	Response.Redirect(FormPostTo & manageUsers)
End Sub

Sub UpdateDepartment
	dim sqlrealtionID, rsrelationID, addressID, userID, companyID
	Database.Open MySql

	sqlInformation = "Update tbl_departments Set name='" & request.form("departmentname") & "', addressID='" & _
	request.form("location") & "' Where departmentID=" & request.form("departmentid")
	
	Set dbQuery = Database.Execute(sqlInformation)
	
	Database.Close
	Set dbQuery = Nothing
	Response.Redirect(FormPostTo & manage)
End Sub

Sub RemoveDepartment
	dim ID, DisplayName, i, DepartmentID, DepartmentsToAxe()
	DepartmentID = 1
	Database.Open MySql
	i = CountRecords("departmentID", "tbl_departments", "companyID=" & companyId)
	Redim DepartmentsToAxe(i)
	
	Set dbQuery = Database.Execute("Select departmentID, name From tbl_departments Where companyID=" & companyId) 
	i = 0
	do while not dbQuery.eof
		DepartmentsToAxe(i) = dbQuery("departmentID")
		if request.form("checkDepartment" & DepartmentsToAxe(i)) = "on" then
			AxedDepartments = AxedDepartments & dbQuery("name") & "; "
		end if
		i = i + 1
		dbQuery.Movenext
	loop

	For i = 0 To UBound(DepartmentsToAxe)
		if request.form("checkDepartment" & DepartmentsToAxe(i)) = "on" then
			Database.Execute("Delete From tbl_departments Where departmentID=" & DepartmentsToAxe(i))
		end if
	Next
	Set dbQuery = Nothing
	Database.Close
	if len(AxedDepartments) > 0 then
		%>
<div class="sideMargin bottommargin">
  <div class="normalTitle">Company Department(s) Removed</div>
  <p style="text-align:left; margin-bottom:10;margin-left:10;margin-right:10;"> The following sub departments and related information were removed from the system: <br>
    <br>
    <%=AxedDepartments%> 
</div>
<%
	end if
End Sub
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
