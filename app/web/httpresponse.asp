<%
Response.ContentType = "text/xml" 
response.write "<?xml version=""1.0""?>" & vbCRLF
response.write "<note>" & vbCRLF

dim xmlResponseContent
xmlResponseContent = "<note>" & vbCRLF &_
	"<to>Tove</to>" & vbCRLF &_
	"<from>Jani</from>" & vbCRLF &_
	"<heading>Reminder</heading>" & vbCRLF &_
	"<body>Don't forget me this weekend!</body>" & vbCRLF &_
	"</note>" & vbCRLF

Response.write xmlResponseContent
response.write "</note>" & vbCRLF
Response.End()
%>