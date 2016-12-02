<% session("add_css") = "tinyForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/jobSearch.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%=decorateTop("JobSearchForm", "notToShort marLR10", "Employment Opportunities")%>
<div id="jobsList">
  <%
	'Response.Buffer = true
	dim objXMLHTTP, jobOrders
	Set jobOrders = Server.CreateObject("MSXML2.ServerXMLHTTP")
	jobOrders.Open "GET", "http://primary.personnelplus.net:8008/include/system/tools/pushTemps/showJobs.dev.asp", false
	jobOrders.Send
	Response.write jobOrders.responseText
	Set jobOrders = Nothing
%>
</div>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
