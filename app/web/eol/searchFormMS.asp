<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Index Server Example Search Results Page</title>
</head>

<body>
<%
Dim sSearchString
Dim oQuery

sSearchString = Request.Form("query")

Const SEARCH_CATALOG = "System" 'remember to change this
%>
<%
Set oQuery = Server.CreateObject("IXSSO.Query")

oQuery.Catalog = SEARCH_CATALOG
oQuery.Query = "@all " & sSearchString & " AND NOT #path *_* AND NOT #path *downloads* AND NOT #path *images* AND NOT #filename *.class AND NOT #filename *.asa AND NOT #filename *.css AND NOT #filename *postinfo.html"
oQuery.MaxRecords = 200
oQuery.SortBy = "rank[d]"
oQuery.Columns = "DocAuthor, vpath, doctitle, FileName, Path, Write, Size, Rank, Create, Characterization, DocCategory"
Set oRS = oQuery.CreateRecordSet("nonsequential")
%>
<%
If oRS.EOF Then
Response.Write "No pages were found for the query <i>" & sSearchString & "</i>"
Else
Do While Not oRS.EOF

Response.write "<b>FileName:</b> " & oRS("FileName") & "<br>"
Response.write "<b>doctitle:</b> " & oRS("doctitle") & "<br>"
Response.write "<b>Size:</b> " & oRS("Size") & "<br>"
Response.write "<b>Create:</b> " & oRS("Create") & "<br>"
Response.write "<b>Write:</b> " & oRS("Write") & "<br>"
Response.write "<b>Characterization:</b> " & oRS("Characterization") & "<hr>"

oRS.MoveNext
Loop
End If
%>
<%
Set oRS = nothing
Set oQuery = nothing
%>
</body>
</html>