<% @Language="VBScript" %>
<% 
Set theForm = Server.CreateObject("ABCUpload4.XForm")
Set theField = theForm("filefield")(1)

If theField.FileExists and theField.ImageType <> 0 Then
  Set cn = Server.CreateObject("ADODB.Connection")
  theConn = "Provider=SQLOLEDB;Data Source=CC2;Initial Catalog=mydbase;User Id=myuser;Password=password"
  cn.Open theConn
  Set rs = Server.CreateObject("ADODB.Recordset")
  rs.Open "mytable", cn, 1, 3
  rs.AddNew
  rs("myimage").Value = theField.Data
  rs.Update
  rs.Close
  cn.Close
End If

%>
<html>
<body>
File uploaded...
</body>
</html>
