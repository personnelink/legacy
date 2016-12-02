<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->

<%
'	*************************  File Description  *************************
'		FileName:		doDeleteJob.asp
'		Description:	Deletes a job_id by updating job_is_deleted with NOW()
'						Does NOT actually delete the job. We want to keep all job records at this time.
'		Created:		Monday, February 16, 2004
'		LastMod:
'		Developer(s):	James Werrbach
'	**********************************************************************

dim rsDelJob, sqlDelJob
sqlDelJob = "UPDATE tbl_jobs SET job_is_deleted = NOW() WHERE job_id= " & request("id") & " AND emp_id= " & session("empID")

Set rsDelJob = Connect.Execute(sqlDelJob)

Set rsDelJob = Nothing
Connect.Close
Set Connect = Nothing

response.redirect("index.asp")
%>