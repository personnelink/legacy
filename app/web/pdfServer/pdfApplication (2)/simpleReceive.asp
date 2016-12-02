<%
'Create an XML DOM Object to receive the request
set docReceived = CreateObject("Microsoft.XMLDOM")
docReceived.async = False
docReceived.load Request

'Create a piece of XML to send back
Set listItem = docReceived.selectnodes("Req1")

strResponse = "<?xml version=""1.0""?>" & vbcrlf
strResponse = strResponse & "<Person>" & vbcrlf

'For the purposes of this example we modify
'the response based on the request
for each node in listItem
name = node.selectsinglenode("Name").firstchild.nodevalue
strResponse = strResponse & " <Name>Thanks " & name & "</Name>" & vbcrlf
next

strResponse = strResponse & "</Person>"

'Send the response back
response.write strResponse
% >
