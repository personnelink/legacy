<%@ Language=VBScript %>
<HTML>
<HEAD>
</HEAD>
<%

'Put together some XML to post off
xmlString = "<?xml version=""1.0""?>" & vbcrlf
xmlString = xmlString & "<Req1>" & vbcrlf
xmlString = xmlString & " <Name>Jenny</Name>" & vbcrlf
xmlString = xmlString & "</Req1>"

'Load the XML into an XMLDOM object
Set SendDoc = server.createobject("Microsoft.XMLDOM")
SendDoc.ValidateOnParse= True
SendDoc.LoadXML(xmlString)

'Set the URL of the receiver
sURL = "http://idaho.personnel.com/pdfServer/pdfApplication/createApplication.asp"

'Call the XML Send function (defined below)
set NewDoc = xmlSend (sURL, SendDoc)'xmlString)
'We receive back another XML DOM object!

'Tell the user what happened
response.Write "<b>XML DOC posted off:</b><br>"
response.write SendDoc.XML & "<br>"
response.write "<b>Target URL:</b> " & sURL & "<br>"
response.write "<b>XML DOC Received back: </b><br>"
response.write (NewDoc.Xml)

private function xmlsend(url, docSubmit)
Set poster = Server.CreateObject("MSXML2.ServerXMLHTTP")
poster.open "POST", url, false
poster.setRequestHeader "CONTENT_TYPE", "text/xml"
poster.send docSubmit
Set NewDoc = server.createobject("Microsoft.XMLDOM")
newDoc.ValidateOnParse= True
newDoc.LoadXML(poster.responseTEXT)

Set XMLSend = NewDoc
Set poster = Nothing
end function

%>
</HTML>