<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		doNewJob.asp
'		Description:	Inserts new job listing into db, strips invalid characters 
'						from job description- such as HTML.
'		Created:		Monday, February 16, 2004
'		Developer(s):	James Werrbach
'	**********************************************************************

Function makeID(byVal maxLen)
dim strNewPass, whatsNext, upper, lower, intCounter, created, tmpjobID
Randomize
For intCounter = 1 To maxLen
	whatsNext = Int((1 - 0 + 1) * Rnd + 0)
   if whatsNext = 0 then
	upper = 90
	lower = 65
 Else
	upper = 57
	lower = 48
   end if
	strNewPass = strNewPass & Chr(Int((upper - lower + 1) * Rnd + lower))
Next
	makeID = strNewPass
End Function
created = "false"

Do Until created = "true" ' Start loop
tmpjobID = makeID(6)

Set rsJobNum = Server.CreateObject("ADODB.RecordSet")
rsJobNum.CursorLocation = 3
rsJobNum.Open "SELECT job_id, job_number FROM tbl_jobs WHERE job_number = '" & tmpjobID & "'",Connect

if rsJobNum.RecordCount = 0 then ' No Match found!
  created = "true"
dim rsInsertJob, sqlInsertJob
sqlInsertJob = "INSERT INTO tbl_jobs (emp_id, job_category, job_title, job_type, job_salary, job_company_name, job_city, job_location, job_number, job_is_deleted, job_view_count, job_date_created, job_description) VALUES (" & _
"" & session("empID") & "," & _
"'" & Request("job_category") & "'," & _
"'" & TRIM(ConvertString(Request("job_title"))) & "'," & _
"'" & Request("job_type") & "'," & _
"'" & TRIM(ConvertString(Request("job_salary"))) & "'," & _
"'" & company_name & "'," & _
"'" & TRIM(ConvertString(Request("job_city"))) & "'," & _
"'" & Request("job_location") & "'," & _
"'" & tmpjobID & "'," & _
"" & 0 & "," & _
"" & 0 & "," & _
" NOW()," & _
"'" & ConvertString(TRIM(Request("job_description"))) & "')"

Set rsInsertJob = Connect.Execute(sqlInsertJob)
Set rsInsertJob = Nothing
Connect.Close
Set Connect = Nothing

Response.redirect("index.asp")
end if
loop
%>