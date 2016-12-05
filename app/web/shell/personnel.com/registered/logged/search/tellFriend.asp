<!-- #INCLUDE VIRTUAL='/includes/connect.asp' -->

<%
dim loc_name	:	loc_name = Request.QueryString("jLoc")

dim rsJ, sqlJ
sqlJ = "SELECT job_id,emp_id,job_category,job_title,job_type,job_salary,job_company_name,job_city,job_location,job_number,job_is_deleted,job_view_count,job_date_created,job_description from tbl_jobs WHERE job_id= " & Request.QueryString("id")

Set rsJ = Connect.Execute(sqlJ)
%>


<html>
<head>
<title>Tell A Friend About This Job - www.personnel.com</title>
<SCRIPT src="/includes/scripts/formVal.js" language="JavaScript" type= "text/javascript">
</SCRIPT>

<script type="text/javascript" language="JavaScript">
function checkForm()
{

var Error = 0
document.frmTellFriend.submit_btn.disabled = true;	

if (IsBlank(document.frmTellFriend.taf_to.value))
  {  
  alert("Please enter the email address of the recipient."); 
  document.frmTellFriend.taf_to.value == "";   
  document.frmTellFriend.taf_to.focus();  
  Error = 1 ;
  document.frmTellFriend.submit_btn.disabled = false;	
  return false  
  }
  
if (IsBlank(document.frmTellFriend.taf_from.value))
  {  
  alert("Please enter your email address."); 
  document.frmTellFriend.taf_from.value == "";   
  document.frmTellFriend.taf_from.focus();  
  Error = 1 ;
  document.frmTellFriend.submit_btn.disabled = false;	
  return false  
  }
   
  
if (Error != 1)
  {  document.frmTellFriend.submit();  }
}


<!-- // hide from old browsers
if (self != top) top.location.href = window.location.href;


function closeWindow(close){
        window.close( )
}
//-->
</SCRIPT>

<!-- #INCLUDE VIRTUAL='/includes/meta.asp' -->
</head>
<body onLoad="javascript:document.frmTellFriend.taf_to.focus();">
<form name="frmTellFriend" method="post" action="doTellFriend.asp" onsubmit="return submitHandler(document);">
<table bgcolor="#FFFFFF" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
  		<td width="100%" align="center">
			<table width="100%" border="0" cellspacing="0" cellpadding="5">
  		 		<tr>
    				<td colspan="2" bgcolor="#5187CA" width="100%" align="center"><font color="#FFFFFF"><strong>Tell a friend about this job:</strong></font></td>
  		  		</tr>		
  		  		<tr>
    				<td colspan="2" width="100%" bgcolor="#efefef">
Job Title: <strong><%=rsJ("job_title")%></strong>
<br>					
Company: <strong><%=rsJ("job_company_name")%></strong>
<br>
Location: <strong><%=rsJ("job_city")%>, <%=loc_name%></strong>
<br>
	
					</td>
		  		</tr>

  		  		<tr>
    				<td colspan="2" width="100%" bgcolor="#FFFFFF">
<b>Send this Job to:</b>
<br>
<input type="text" name="taf_to" size = "40" maxlength="100" onBlur="IsEmail(this);">	
<br>
Enter the email address of the recipient.
					</td>
		  		</tr>
		  		<tr>
    				<td bgcolor="#FFFFFF" colspan="2">
<b>Email Subject:</b>
<br>
<input type="text" name="taf_subject" size = "40" maxlength="255">
<br>
Enter your own subject for the email, otherwise a default subject will be used. 
<br>
<br>
<b>Additional Comments:</b> (optional) 
<br>
<textarea name="taf_comments" cols="43" rows="4"></textarea>
<br>
<br>
<b>Your Email Address:</b>
<br>
<input type="text" name="taf_from" value="<%=request.querystring("sEmail")%>" size="40" maxlength="100" onBlur="IsEmail(this);" DISABLED>
<br>
This is only used for mail delivery, and will not be used for any other purpose.
<br>
</font>
    				</td>
				</tr>
				<tr>
					<td align="left" width="50%">			
<input type="hidden" name="jobID" value="<%=Request.QueryString("id")%>">
<input type="hidden" name="jCat" value="<%=rsJ("job_category")%>">
<input type="hidden" name="jTitle" value="<%=rsJ("job_title")%>">
<input type="hidden" name="jCompany" value="<%=rsJ("job_company_name")%>">
<input type="hidden" name="jCity" value="<%=rsJ("job_city")%>">
<input type="hidden" name="jLoc" value="<%=loc_name%>">
<input type="hidden" name="jNum" value="<%=rsJ("job_number")%>">
<input type="hidden" name="jSalary" value="<%=rsJ("job_salary")%>">
<input type="hidden" name="jType" value="<%=rsJ("job_type")%>">
<input type="hidden" name="jDesc" value="<%=rsJ("job_description")%>">
<input type="hidden" name="sEmail" value="<%=Request.QueryString("sEmail")%>">


<input type="button" name="submit_btn" value="Send Message" onClick="checkForm();">					
					</td>				
					<td align="right" width="50%"><a href="javascript:closeWindow();">Close Window</a>
</td>				
				</tr>

  				</tr>
			</table>
    	</td>
  	</tr>
</table>
</form>

</body>
</html>
<%
Set rsJ = Nothing
Connect.Close
set Connect = Nothing
%>
