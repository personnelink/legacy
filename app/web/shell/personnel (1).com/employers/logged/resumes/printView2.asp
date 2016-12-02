<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL='/includes/checkEmpAuth.asp' -->


<%
dim rsViewRes, resCount
Set rsViewRes = Server.CreateObject("ADODB.RecordSet")
rsViewRes.CursorLocation = 3
rsViewRes.Open "SELECT * FROM tbl_resumes WHERE res_id = " & request("id"),Connect

' Insert HTML line breaks
dim txtResDesc, txtResBody
txtResDesc = Replace(rsViewRes("res_description"),vbCrLf,"<BR>")
txtResBody = Replace(rsViewRes("res_body"),vbCrLf,"<BR>")

' Make sure we have a valid resume ID
resCount = rsViewRes.RecordCount
if resCount = 0 then
  response.redirect("noResume.asp?id=" & request("id"))
end if


' Nab our job posting data
sqlJobData = "SELECT job_id,job_title, job_company_name,job_number,job_date_created FROM tbl_jobs WHERE job_id =" & request.querystring("jid")
Set rsJobData = Connect.Execute(sqlJobData)
%>

<html>
<head>
<title>Applicant Resume - Printer-Friendly View - www.personnel.com</title>
<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</head>

<body>

		<table width="100%" border="0" cellspacing="2" cellpadding="0" bgcolor="#FFFFFF">
			<tr>
   				<td align="left" colspan="2"><strong><%=rsJobData("job_company_name")%> - <%=rsJobData("job_title")%></strong></td>
   			</tr>
   			<tr>
				<td align="left"><strong>Applicant:</strong> <%=rsViewRes("res_first_name")%>&nbsp;<%=rsViewRes("res_last_name")%></td>
   				<td align="right"><strong>Application Received:</strong> <%=FormatDateTime(request("d"),2)%></td>
   			</tr> 
   			<tr>
   				<td colspan="2">
<% IF TRIM(rsViewRes("res_description")) <> "" then %>				
<hr size="1" noshade>				
<strong><strong>DESCRIPTION / COVER LETTER:</strong></strong>
<br>
<% response.write(txtResDesc) %>

<% End if %>
<hr size="1" noshade>	
<strong>APPLICANT WORK STATUS:</strong>
<br>

                                    <% if CInt(rsViewRes("res_is_eligible")) = 1 then %>
                                    - Eligible to work in the US. 
                                    <% else %>
                                    - Not eligible to work in the US. 
                                    <% end if %>
                                    <br>
<%
Select Case rsViewRes("res_availability")
			     Case "FP" %>
                                    - Seeking full or part-time work. 
                                    <%
				 Case "FT" %>
                                    - Seeking full-time work. 
                                    <%
				 Case "PT" %>
                                    - Seeking part-time work. 
<% End Select %>
<br>

<%
Select Case rsViewRes("res_date_available") %>
<% Case "asap" %>
- Available for work immediately. 
<% Case "onemonth" %>
- Available for work in under one month. 
<% Case "twomonths" %>
- Available for work in one to two months. 
<% Case "threemonths" %>
- Available for work in three or more months. 
<% 
End Select 
%>
<br>
<%
Select Case CInt(rsViewRes("res_will_relocate")) %>
<% Case 1 %>
- Willing to relocate. 
<% Case 0 %>
- Not willing to relocate.
<%
End Select 
%>    
<br>  
- Desired Salary:  
<% if TRIM(rsViewRes("res_pref_salary")) = "" then response.write("<EM>Not Provided</EM>") end if%>
<% if TRIM(rsViewRes("res_pref_salary")) <> "" then response.write(rsViewRes("res_pref_salary")) end if%>
<hr size="1" noshade>
<%
response.write(txtResBody)
%>

	</td>
   </tr>  
</table>								

<br>
<font color="#cccccc"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></font>


</body>
</html>
<%
rsViewRes.Close
Set rsViewRes = Nothing
Set rsJobData = Nothing
Connect.Close
Set Connect = Nothing
%>
