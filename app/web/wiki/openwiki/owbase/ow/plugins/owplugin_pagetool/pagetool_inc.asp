<%
' // $Log: pagetool_inc.asp,v $
' // Revision 1.3  2004/09/27 13:18:48  sansei
' // minor edit
' //
' // Revision 1.2  2004/09/24 21:12:46  sansei
' // Dump of Variables now inline (PageTool)
' //
' // Revision 1.1  2004/09/24 17:06:24  sansei
' // Added dump of OW Variables functionality
' //
function FetchVariableValue(varname)
	dim str
	'TODO: check if on positivelist here!!!
	str = eval(varname)
	FetchVariableValue = str
end function

Function FetchVariableValues()
	FetchVariableValues = fetchVarlist("xml/variables.xml")
end function

function fetchVarlist(path)
	dim oXML,url,node,varvalue,str
	set oXML = server.CreateObject("Msxml2.DOMDocument")
	oXML.async = False
	url = server.MapPath(path)
	oXML.load(url)
	str = "<variables>" & vbcrlf
	for each node in oXML.documentElement.childNodes
	varvalue = FetchVariableValue(node.tagname)
	str = str & "<p><font size=""9""><b>" & node.tagname & "</b> = " & varvalue & "</font></p>" & vbcrlf
	next
	str = str & "</variables>"
	fetchVarlist = str
	set oXML = nothing
end function
%>