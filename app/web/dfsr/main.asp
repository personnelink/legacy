<%
session("add_css") = "./hilpol.css"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<!-- Begin Site content -->
<div id="reports" style="text-align:right">
<%
	dim dfsrreports
	Set dfsrreports = Server.CreateObject("MSXML2.ServerXMLHTTP")
	
	dfsrreports.Open "GET", "https://www.personnelinc.com/dfsr/reports/", false
	dfsrreports.Send
	response.write DecorateTop("dfsrreports", "dashboard marLRB10", "Distributed File Sytem Replication (DFSR) Reports")
	
	dim strippedReponse
	
	strippedReponse = split(dfsrreports.responseText, "<br>")
	
	for filelink = 0 to ubound(strippedReponse)
		if instr(strippedReponse(filelink), ".html") > 0 then
			response.write strippedReponse(filelink) & "<br>"
		end if
	next
	
	Set dfsrreports = Nothing
	Response.write DecorateBottom()
	
%>
	</div>
<!-- End of Site content -->


<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->


