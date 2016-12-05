<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		doEditJob.asp
'		Description:	Updates tbl_jobs using job_id and posted data from editJob.asp
'		Created:		Monday, February 16, 2004
'		LastMod:
'		Developer(s):	James Werrbach
'	**********************************************************************

dim rsUpdJob, sqlUpdJob, sqlPart1, sqlPart2, sqlValues
sqlPart1 = "UPDATE tbl_jobs SET "
sqlPart2 = "WHERE job_id=" & Request("id") & " AND emp_id= " & session("empID")
sqlValues = ""
sqlValues = sqlValues & "job_category='" & Request("job_category") & "', "
sqlValues = sqlValues & "job_title='" & ConvertString(TRIM(Request("job_title"))) & "', "
sqlValues = sqlValues & "job_type='" & Request("job_type") & "', "
sqlValues = sqlValues & "job_salary='" & ConvertString(TRIM(Request("job_salary"))) & "', "
sqlValues = sqlValues & "job_company_name='" & ConvertString(TRIM(Request("job_company_name"))) & "', "
sqlValues = sqlValues & "job_city='" & ConvertString(TRIM(Request("job_city"))) & "', "
sqlValues = sqlValues & "job_location='" & Request("job_location") & "', "
' Check if employer wants to retain the original job_date_created value
'if Request("retain_date") <> "yes" then
'sqlValues = sqlValues & "job_date_created= NOW()" & ", "
'end if
sqlValues = sqlValues & "job_description='" & ConvertString(TRIM(Request("job_description"))) & "'"

sqlUpdJob = sqlPart1 & sqlValues & sqlPart2
Set rsUpdJob = Connect.Execute(sqlUpdJob)

Set rsUpdJob = Nothing
Connect.Close
Set Connect = Nothing


response.redirect("index.asp")
%>
