<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

<%
Function getXML(sourceFile)
dim styleFile
dim source1, style
styleFile = Server.MapPath("hipaa2.xsl")

Dim xmlhttp
Set xmlhttp = Server.CreateObject("Microsoft.XMLHTTP")
xmlhttp.Open "GET", sourceFile, false
xmlhttp.Send

set source1 = Server.CreateObject("Microsoft.XMLDOM")
source1.async = false
source1.loadxml(xmlhttp.ResponseText)

set style = Server.CreateObject("Microsoft.XMLDOM")
style.async = false
style.load(styleFile)

getXML = source1.transformNode(style)
set source1 = nothing
set style = nothing
End Function
%>

<%=getXML("http://www.computerworld.com/news/xml/coverage/0,5451,1408,00.xml")
%>

</body>
</html>
