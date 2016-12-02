<% session("add_css") = "tinyForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/jobSearch.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
if userLevelRequired(userLevelPPlusStaff) = true then
%>
<%=decorateTop("JobSearchForm", "notToShort marLR10", "Open and Unfilled Job Orders")%>
<div id="jobsList">
<form id="jobSearchForm" name="jobSearchForm" action="managePlacements.asp" method="post">
  <p><%=objCompanySelector(whichCompany, false, "javascript:document.jobSearchForm.submit();")%></p>
</form>
  <%
	dim whichCompany
	whichCompany = request.form("whichCompany")
	if len(whichCompany & "") > 0 then
		'Response.Buffer = true
		dim objXMLHTTP, jobOrders
		Set jobOrders = Server.CreateObject("MSXML2.ServerXMLHTTP")
		jobOrders.Open "GET", "http://primary.personnelplus.net:8008/include/system/tools/pushTemps/getJobOrders.asp?companyid=" & whichCompany, false
		jobOrders.Send
		Response.write jobOrders.responseText
		Set jobOrders = Nothing
	end if
End if %>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
