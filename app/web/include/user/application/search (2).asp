<%@ Language="VBScript" %>
<% Option Explicit %>
<html>
<body>
...
Suchen nach...<br>
<form action="searchpdfs.asp" method="get" style="display:inline;">
    <input type="text" name="query" size="40" >
    <input type="submit" value="Search" >
</form>
</center>
<%
dim strQuery
dim objQuery
dim rstResults
dim objField

strQuery = Request.QueryString("query")
if strQuery <> "" then
    Set objQuery = Server.CreateObject("ixsso.Query")

    With objQuery
        .Catalog    = "datasheets"
        .Query      = "%"&strQuery&"%"
        .MaxRecords = 100
        .SortBy = "rank [d]"
        .Columns = "filename, path, size, write, " _
            & "characterization, " _
            & "rank, hitcount"
    End With

    Set rstResults = objQuery.CreateRecordset("nonsequential")
    Set objQuery = Nothing

    if rstResults.eof then
        response.write "Sorry. No results found."
    Else
        response.write "<p><strong>"
        response.write rstResults.RecordCount
        response.write "</strong> Ergebnisse:</p>"

        do while not rstResults.eof
%>
<div style="font-family:tahoma; font-size:12px; color:black; text-align:left; border:1px solid #808080; background:#bcc6ca; padding:4px;" onMouseOver="this.style.background='#c2d9e4';" onMouseOut="this.style.background='#bcc6ca';">
	<div style="font-size:14px; font-weight:bold;"><%=rstResults.Fields("rank")%> ~ <%=rstResults.Fields("filename")%></div>
	<div style="font-size:14px;"><%=rstResults.Fields("characterization")%></div>
	<div style="font-size:14px;"><%=CurrentURL%>/<%=strTempPath%></div>
	<div style="font-size:14px; font-weight:bold;"><%=rstResults.Fields("size")%> | <%=rstResults.Fields("hitcount")%> | <%=rstResults.Fields("write")%></div>
</div><br >
<%
            rstResults.MoveNext
        loop
    end if
    Set rstResults = Nothing
end if
%>
</body>
</html>