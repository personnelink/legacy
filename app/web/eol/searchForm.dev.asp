<% session("add_css") = "shortForms.asp.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/masterPageTop.asp' -->
<script type="text/javascript" src="/include/js/searchForm.js"></script>
<!-- Created: 12.15.2008 -->
<!-- Revised: 3.18.2009 -->
<%
if userLevelRequired(userLevelPPlusStaff) = true then
%>

<%=decorateTop("searchForm", "notToShort marLR10", "Search")%>
<form method="GET" action="searchForm.dev.asp" name="frmSearch" id="frmSearch">
  <p><img src="../../core/pplusLogo.gif" ></p>
  <p>
    <input type="text" maxlength="255" name="query" id="query" size="50" value='<%=filteredSearchString%>'>
    <input type="submit" value="Search" name="B1" class="hide">
  </p>
  <%
	searchCatalog = Request.QueryString("searchCatalog")
	if len(searchCatalog & "") = 0 then searchCatalog = "Net_docs" %>
  <p> <span style="height:6em"><span style="padding-top:1em">
    <input name="searchCatalog" class="styled" type="radio" value="Net_docs" <%if searchCatalog = "Net_docs" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
    </span><span style="padding-bottom:1em"> Documents </span><span style="padding-top:1em">
    <input name="searchCatalog" class="styled" type="radio" value="Resumes" <%if searchCatalog = "Resumes" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
    </span><span style="padding-bottom:1em"> Resumes </span></span></p>
  <div class="searchButton"><a class="squarebutton" href="#" style="float:none" onclick="document.forms['frmSearch'].submit();"><span style="text-align:center"> Search </span></a></div>
  <div id="searchResults">
    
<script type="text/javascript"><!-- 
						document.frmSearch.query.focus()
							//--></script>
	
	<%
	dim sSearchString
	dim oQuery
	

	sSearchString = reduceNoise(Request.QueryString("query"))
	
	if InStr(sSearchString, "@") = 0 And InStr(sSearchString, Chr(34)) = 0 then sSearchString = Replace(sSearchString, " ", " and ")
	if len(sSearchString) <> 0 and len(searchCatalog) <> 0 then
		Set oQuery = Server.CreateObject("IXSSO.Query")
		With oQuery
			.Catalog = searchCatalog
			.Query = "@contents " & sSearchString & " "
			'.Query = "@all " & sSearchString & " AND NOT #path *_* AND NOT #path *downloads* AND NOT #path *images* AND NOT #filename *.class AND NOT #filename *.asa AND NOT #filename *.css AND NOT #filename *postinfo.html"
			.MaxRecords = 200
			.SortBy = "rank[d]"
			.Columns = "DocAuthor, vpath, doctitle, FileName, Path, Write, Size, Rank, Create, Characterization, DocCategory"
			Set oRS = .CreateRecordSet("nonsequential")
		End With
	

		if oRS.eof then
		response.write "No pages were found for the query <i>" & sSearchString & "</i>"
		Else
		do while not oRS.eof
		
		correctPath = Replace(oRS("Path"), "\", "/")
		correctPath = Replace(correctPath, "//personnelplus.net", "https://secure.personnelplus.net")
		Response.write "<div class=" & Chr(34) & "searchSummary" & Chr(34) & "><p><a href=" & chr(34) & correctPath & Chr(34) & ">" & oRS("FileName") & "</a></p>"
		docTitle = oRS("doctitle")
		if len(docTitle) > 0 then Response.write "<p><b>Document Title:</b> " & docTitle & "</p>"
		searchDescription = oRS("Characterization")
		if len(searchDescription) > 0 then Response.write "<p>" & Server.HTMLEncode(searchDescription) & "</p>"
		Response.write "<p><b>Size:</b> "
		fileSize = CLng(oRS("Size"))/1024
		if fileSize > 1023 then
			Response.write CInt(fileSize/1024) & "m"
		Else
			Response.write CInt(fileSize) & "k"
		end if
		Response.write "<b> Created:</b> " & oRS("Create") & "<b> Modified:</b> " & oRS("Write") & "</p>"
		internalPath = oRS("Path")
		Response.write "<p><a class='intraLink' href='" & internalPath & "'>" & internalPath & "</a></p></div>"
		oRS.MoveNext
		loop
		end if
		
		Set oRS = nothing
		Set oQuery = nothing
	Elseif len(request.form("B1")) > 0 then
				response.write "I'm sorry, but you need to type something for me to search for first."

	end if

Function reduceNoise (search)
	const Filename = "c:\windows\system32\noise.dat"    ' Noise index file
	const ForReading = 1, ForWriting = 2, ForAppending = 3
	const TristateUseDefault = -2, TristateTrue = -1, Tristatefalse = 0
	
	' Create a filesystem object
	dim FSO
	set FSO = server.createObject("Scripting.FileSystemObject")
	
	' Map the logical path to the physical system path
	'dim Filepath
	'Filepath = Server.MapPath(Filename)

	if FSO.FileExists(Filename) then
		' Get a handle to the file
		dim file    
		set file = FSO.GetFile(Filename)
	
		' Open the file
		dim TextStream
		Set TextStream = file.OpenAsTextStream(ForReading, TristateUseDefault)
		do while not TextStream.AtEndOfStream
			dim Line
			Line = TextStream.readline
			searchNoise = searchNoise & Line & " "
		loop
		Set TextStream = nothing
	end if
	Set FSO = nothing
	
	SearchArray = Split(search, " ")
	For Each Word in SearchArray
		if Instr(searchNoise, Word) = 0 then
			quieterSearch = quieterSearch & Word & " "
		Else
			noiseWords = noiseWords & Word
		end if
	Next
	
	response.write "<pre>The following words were ommitted from the search: " & noiseWords & "</pre><br><hr><br>"
	reduceNoise = quieterSearch
End Function
%>

  </div>
</form><%
End if %>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
