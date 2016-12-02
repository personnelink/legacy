<% @Language="VBScript" %>
<html>
<body>
<% 

Set cn = Server.CreateObject("ADODB.Connection")
theConn = "Provider=SQLOLEDB;Data Source=CC2;Initial Catalog=mydbase;User Id=myuser;Password=password"
cn.Open theConn
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "select * from mytable", cn
Do While Not rs.EOF
  Response.Write "Image<br>"
  Response.Write "LBound = " & LBound(rs("myimage")) & "<br>"
  Response.Write "UBound = " & UBound(rs("myimage")) & "<br>"
  rs.MoveNext
Loop
rs.Close
cn.Close

%>
</body>
</html>
