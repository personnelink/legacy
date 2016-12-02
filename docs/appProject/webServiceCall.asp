<%
Dim JobID
Response.Write(StartJob & "<br>")
Response.Write(EndJob & "<br>")

function StartJob()
Dim xmlDOC
Dim HTTP
Set HTTP = CreateObject("MSXML2.XMLHTTP")
Set xmlDOC =CreateObject("MSXML.DOMDocument")
xmlDOC.Async=False
HTTP.Open "GET","fullApplication.xml", False
HTTP.Send()
xmlDOC.load(HTTP.responseXML)
JobID = ParseRootNode(xmlDOC)
set HTTP = nothing
set xmlDoc = nothing
StartJob = JobID
end Function

function EndJob()
Dim endResponse
Dim xmlDOC
Dim bOK
Dim HTTP
Set HTTP = CreateObject("MSXML2.XMLHTTP")
Set xmlDOC =CreateObject("MSXML.DOMDocument")
xmlDOC.Async=False
HTTP.Open "GET","http://webserver/MyService.asmx/JobEnd?jobID=" & JobID, False
HTTP.Send()
xmlDOC.load(HTTP.responseXML)
endResponse = ParseRootNode(xmlDOC)
set HTTP = nothing
set xmlDoc = nothing
EndJob = endResponse
end Function


' Used to extract the elements from the returned XMLDOC.
' For this code there should always only be one element
' returned from the webservice; Any more and the code will
' need to be changed
function ParseRootNode(xmlDoc)
Dim x
Dim returnValue
for each x in xmlDoc.documentElement.childNodes
returnValue = x.text
next
ParseRootNode = returnValue
end function
%>
