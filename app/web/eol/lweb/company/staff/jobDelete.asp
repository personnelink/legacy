<% if session("adminAuth") <> "true" then 
response.redirect("/index.asp")
end if
%>
<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<%
dim jobID		:	jobID = Request("jobID")
dim strSQL, rsDelJob	
dim srchStr			:	srchStr = "&keywords=" & request("keywords") & "&jobSchedule=" & request("jobSchedule") & "&jobCategory=" & request("jobCategory") & "&jobCity=" & request("jobCity") & "&jobState=" & request("jobState") & "&orderBy=" & request("orderBy")
		


strSQL = "DELETE FROM tbl_listings WHERE jobID = '" & jobID & "'"
'Connect.Execute(strSQL)
set rsDelJob = Connect.Execute(strSQL)

Connect.Close

'	response.write(request("srchStr"))
'	response.end	  
%>

  

<%
response.redirect("/lweb/company/staff/jobModList.asp?xCrypt=" & srchStr)
%>