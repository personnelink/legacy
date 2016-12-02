<%
	Response.Buffer = false
	dim objXMLHTTP, magicvalley, craigslist, magicValleyPage(2)
	

	dim sSources(4)
	sSources(0) = "magicvalley.com"
	sSources(0) = "craigslist.org"
	Set sSource = Server.CreateObject("MSXML2.ServerXMLHTTP")

	For each item in sSources
		sSource.Open "GET", "/include/services/gatherOutsideJobs.asp/" & item & ".asp", false
		sSource.Send
		Response.write sSource.responseText
	Next	
	
	
	Set sSource = Nothing
%>