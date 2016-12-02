<%
if userLevelRequired(userLevelPPlusStaff) = true then

	'---- App Directory and Native Image Constants
	FormPostTo = "departments.asp?Action="
	
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

%>
