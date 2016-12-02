<% if session("adminAuth") <> "true" then 
response.redirect("/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<%
dim jobID		:	jobID = Request("jobID")
dim strSQL, rsDelJob	
dim srchStr			:	srchStr = "&keywords=" & request("keywords") & "&jobSchedule=" & request("jobSchedule") & "&jobCategory=" & request("jobCategory") & "&jobCity=" & request("jobCity") & "&jobState=" & request("jobState") & "&orderBy=" & request("orderBy")
		


strSQL = "UPDATE tbl_listings SET jobStatus = 'Closed', deleted = 'Yes', dateJobClosed ='" & now() & "' WHERE jobID = '" & jobID & "'"
'Connect.Execute(strSQL)
set rsDelJob = Connect.Execute(strSQL)			  
	
'	response.write(request("srchStr"))
'	response.end	  
%>

  

<%
response.redirect("/company/staff/jobModList.asp?xCrypt=" & srchStr)
%>