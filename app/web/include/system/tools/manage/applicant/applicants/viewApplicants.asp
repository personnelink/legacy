<%

session("add_css") = "./viewApplicants.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Maintain Applicants - Personnel Plus"
dim is_service
if request.QueryString("isservice") = "true" then
	is_service = true
	session("no_header") = true
end if

noSocial = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="viewApplicants.js"></script>

<!-- #include file='viewApplicants.doStuff.asp' -->

<%=ifNotServiceShow("topnav")%>

<div id="accountActivityDetail" class="pad10">

<form id="viewActivityForm" name="viewActivityForm" action="viewApplicants.asp" method="get" />
<table id="formOptions"><tr><td>
      <label style="float:left; clear:left" for="fromDate">From </label>
      <input  style="float:left; clear:left" name="fromDate" id="fromDate" type="text" value="<%=fromDate%>" onKeyPress="return submitenter(this,event)">
</td><td>
	<label for="toDate" style="float:left; clear:left">To </label>
	<input name="toDate" id="toDate" type="text" value="<%=toDate%>" onKeyPress="return submitenter(this,event)">
</td><td>
	
<div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="avascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></td></tr>
<tr><td colspan=3>
      <label style="float:left; clear:left" for="likeName">Search</label>
      <input  style="float:left; clear:left" name="likeName" id="likeName" type="text" value="<%=likeName%>" onKeyPress="return submitenter(this,event)">
</td></tr>
<tr><td colspan=3><%=objCompanySelector(whichCompany, false, "javascript:document.manageUsersForm.submit();")%>
</td></tr>
</table>


<%=navRecordsByPage(Applicants)%>

<% showApplicantsTable %>

</form></div>
<%=ifNotServiceShow("navbottom")%>

<%=ifNotServiceShow("bottom")%>
