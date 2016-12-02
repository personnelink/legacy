<% @Language="VBScript" %>
<html>
<body>
<% 
Set theForm = Server.CreateObject("ABCUpload4.XForm")

Response.Write "Your favorite color is "
Response.Write theForm("color") & "<br>" 

Response.Write "You like these types of ice cream<br>"
For i = 1 to theForm("flavor").Count
   Response.Write theForm("flavor")(i) & "<br>"
Next 

Set theField = theForm.Files("file")
If theField.FileExists Then 
   theField.Save "images/" & theField.FileName
   Response.Write "File " & theField.FileName & " uploaded"
Else
   Response.Write "No file uploaded"
End If
%>
</body>
</html>
