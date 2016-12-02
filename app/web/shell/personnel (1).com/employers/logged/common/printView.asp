<%response.buffer=true%>
<!-- #INCLUDE VIRTUAL = '/includes/connect.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpCookie.asp' -->
<!-- #INCLUDE VIRTUAL = '/includes/checkEmpAuth.asp' -->

<%
dim rsViewRes, resCount
Set rsViewRes = Server.CreateObject("ADODB.RecordSet")
rsViewRes.CursorLocation = 3
rsViewRes.Open "SELECT * FROM tbl_resumes WHERE res_id = " & request("id"),Connect

' Make sure we have a valid resume ID
resCount = rsViewRes.RecordCount
if resCount = 0 then
  response.redirect("/employers/logged/resumes/noResume.asp?id=" & request("id"))
end if

' Insert HTML line breaks
dim txtResDesc, txtResBody
txtResObj = Replace(rsViewRes("res_objective"),vbCrLf,"<BR>")
txtResSkills = Replace(rsViewRes("res_skills"),vbCrLf,"<BR>")
jobDuties1 = Replace(rsViewRes("res_comp_job_duties1"),vbCrLf,"<BR>")
jobDuties2 = Replace(rsViewRes("res_comp_job_duties2"),vbCrLf,"<BR>")
jobDuties3 = Replace(rsViewRes("res_comp_job_duties3"),vbCrLf,"<BR>")

' Nab our job posting data
dim rsJobData, sqlJobData
sqlJobData = "SELECT job_id,job_title, job_company_name,job_number,job_date_created FROM tbl_jobs WHERE job_id=" & request.querystring("jid")
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
	<td align="left"><strong>Applicant Name:</strong> <%=rsViewRes("res_first_name")%>&nbsp;<%=rsViewRes("res_last_name")%></td>
	<td align="right"><strong>Job Application Received:</strong> <%=FormatDateTime(request("d"),2)%></td>
	</tr>
	<tr>
    <td colspan="2">
<% IF TRIM(rsViewRes("res_objective")) <> "" then %>				
<hr size="1" noshade>				
<strong><strong>OBJECTIVE:</strong></strong>
<br>
<% response.write(txtResObj) %>

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

</td>
</tr>  

<tr> 
  <td colspan="2"><strong>CONTACT INFO:</strong>
  <br>
<%=rsViewRes("res_first_name")%>&nbsp;<%=rsViewRes("res_last_name")%>
<br>
<%=rsViewRes("res_address_one")%> &nbsp; &nbsp; 
<%
if TRIM(rsViewRes("res_address_two")) <> "" then 
response.write("<BR>" & rsViewRes("res_address_two"))
end if
%>
<br>
<%=rsViewRes("res_city")%>, <%=rsViewRes("res_location")%>&nbsp;<%=rsViewRes("res_zipcode")%>
<br>
<%=rsViewRes("res_phone_number")%>
<br>
<%=rsViewRes("res_email_address")%>
  </td>
</tr>

<tr>
	<td colspan="2">&nbsp;</td>
</tr>

<tr> 
<td colspan="2"><strong>EXPERIENCE:</strong>
<br>
<strong><%=rsViewRes("res_comp_job_title1")%></strong> - 
&nbsp;<%=rsViewRes("res_comp_name1")%> - 
&nbsp;<%=rsViewRes("res_comp_location1")%>
<br> 
[<%=rsViewRes("res_comp_start_date1")%> - <%=rsViewRes("res_comp_end_date1")%>]
<br>
Duties:
<%=jobDuties1%>
<br>
<br>
<% if rsViewRes("res_comp_location2") <> "" then %>
<strong><%=rsViewRes("res_comp_job_title2")%></strong> -
&nbsp;<%=rsViewRes("res_comp_name2")%> -
&nbsp;<%=rsViewRes("res_comp_location2")%>
<br> 
[<%=rsViewRes("res_comp_start_date2")%> - <%=rsViewRes("res_comp_end_date2")%>]
<br>
Duties: 
<%=jobDuties2%> 
<br>
<% End if %>
<% if rsViewRes("res_comp_location3") <> "" then %>
<br>
<strong><%=rsViewRes("res_comp_job_title3")%></strong> -
&nbsp;<%=rsViewRes("res_comp_name3")%> - 
&nbsp;<%=rsViewRes("res_comp_location3")%>
<br> 
[<%=rsViewRes("res_comp_start_date3")%> - <%=rsViewRes("res_comp_end_date3")%>]
<br>
Duties: 
<%=jobDuties3%>
<% End if %>
</td>
</tr>
<tr>
	<td colspan="2">&nbsp;</td>
</tr>							
<tr> 
<td colspan="2"><strong>EDUCATION:</strong></td>
</tr>
<tr>
	<td colspan="2">
		<table cellspacing="0" cellpadding="0" border="0" width="80%">
		<tr>
			<td><strong><%=rsViewRes("res_college_name1")%></strong></td>
			<td>Degree: <%=rsViewRes("res_college_degree1")%></td>
		</tr>
		<tr>
			<td><%=rsViewRes("res_college_city1")%>, <%=rsViewRes("res_college_location1")%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td><strong><%=rsViewRes("res_college_name2")%></strong></td>
			<td>Degree: <%=rsViewRes("res_college_degree2")%></td>
		</tr>
		<tr>
			<td><%=rsViewRes("res_college_city2")%>, <%=rsViewRes("res_college_location2")%></td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td><strong><%=rsViewRes("res_hs_name")%></strong></td>
			<td><% if CInt(rsViewRes("res_hs_diploma")) = 1 then %>
		High School Diploma 
		<% End if %></td>
		</tr>
		<tr>
			<td><%=rsViewRes("res_hs_city")%>, <%=rsViewRes("res_hs_location")%></td>
			<td>&nbsp;</td>
		</tr>
		
		</table>
	</td>
</tr>
<tr>
	<td colspan="2">&nbsp;</td>
</tr>
<tr> 
  <td colspan="2"><strong>SKILLS:</strong>
  <br>
<%=txtResSkills%>  
</td>  
</tr>
<tr>
	<td colspan="2">&nbsp;</td>
</tr>
<tr> 
<td colspan="2" colspan="2"><strong>REFERENCES:</strong></td>
</tr>
<tr>
	<td>
<strong><%=rsViewRes("res_refer_name1")%></strong>
<br>
<%=rsViewRes("res_refer_company1")%>
<br>
<strong><%=rsViewRes("res_refer_name2")%></strong>
<br>
<%=rsViewRes("res_refer_company2")%>
<br>
<strong><%=rsViewRes("res_refer_name3")%></strong>
<br>
<%=rsViewRes("res_refer_company3")%>	
	
	</td>
	<td>
<%=rsViewRes("res_refer_phone1")%><br>
<%=rsViewRes("res_refer_title1")%><br>
<%=rsViewRes("res_refer_phone2")%><br>
<%=rsViewRes("res_refer_title2")%><br>
<%=rsViewRes("res_refer_phone3")%><br>
<%=rsViewRes("res_refer_title3")%><br>	
	
	</td>
</tr>

<tr>
	<td colspan="2"><font color="#cccccc"><!-- #INCLUDE VIRTUAL='/includes/copyright.inc' --></font></td>
</tr>
</table>

</body>
</html>
<%
rsViewRes.Close
Set rsViewRes = Nothing
Connect.Close
Set Connect = Nothing
%>
