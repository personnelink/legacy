<%
Response.expires = 0
'create an instance of MS XMLDOM Object
'and load the QOffice.xml file where all the questions are.

set obj = server.createobject("Microsoft.XMLDOM")
obj.async = false
obj.load(Server.MapPath("QOffice.xml"))

'very first request from the client
if trim(request("Action")) = "Start" then
  'set no of questions per exam
  dim NoQ,TotalQ
  
  NoQ = 20 'set no less than the totalquestions
  
  'count no of questions in the xml file
  '( or from database)
  TotalQ = obj.selectNodes("data/question").length

  dim aQuest(),temp,isExist, strQ
  Redim aQuest(0) 'to store the question ids
  
  'generate (=NoQ) question ids randomly
  while ubound(aQuest) < NoQ
    isExist = false
    temp = Int((TotalQ * Rnd) + 1)
    for i = 1 to ubound(aQuest)
      if aQuest(i) = temp then
        isExist = true
        exit for
      end if
    next
    if Not isExist then
      Redim Preserve aQuest(ubound(aQuest)+1)
      aQuest(ubound(aQuest)) = temp
      strQ = aQuest(i) & "," & strQ
    end if
  wend
  
  'remove the last comma ',' from strQ
  strQ = left(strQ,len(strQ)-1)
  
  'send the question in the strQ to the client
  response.write strQ
  
'all further requests - after the first request
elseif trim(request("Action")) = "NextQ" then
  'fetch the question from the XML Object
  'and form the output string
  temp = "data/question[@id=" & trim(request("QNo")) & "]"

  set Node = obj.selectSingleNode(temp)

  strXML = "<data>"
  strXML = strXML & "<qtext>"
  strXML = strXML & Node.selectSingleNode("qtext").text
  strXML = strXML & "</qtext>"
  strXML = strXML & "<answer>"
  strXML = strXML & Node.selectSingleNode("answer").text
  strXML = strXML & "</answer>"

  set Node = Node.selectNodes("choices/choice")

  for i = 0 to Node.length-1
    strXML = strXML & "<choice>"
    strXML = strXML & Node.item(i).text
    strXML = strXML & "</choice>"
  next

  strXML = strXML & "</data>"

  'send the output to the client
  response.write (strXML)
end if
%>