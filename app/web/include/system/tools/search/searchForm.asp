<%option explicit%>
<%
session("add_css") = "./searchForm.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff


dim searchCatalog
searchCatalog = Request.QueryString("searchCatalog")
select case searchCatalog
	case "NetDocs"
		session("window_page_title")	= "Search Net_Docs - Personnel Plus"
	
	case "Resumes"
		session("window_page_title")	= "Search Resumes - Personnel Plus"

	case "HowTos"
		session("window_page_title") = "Search How-To's - Personnel Plus"
	
	case else
		searchCatalog = "NetDocs"
		session("window_page_title")	= "Search Net_Doc - Personnel Pluss"
end select

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->
<script type="text/javascript" src="searchForm.js"></script>
<% 

dim checkedText : checkedText = "checked=""checked"""

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim boise, nampa, twin, burley, pocatello, california, received, other, resume_age
boise = Request.QueryString("boise")
	if len(boise) = 0 then boise = request.Form("boise")
nampa =  Request.QueryString("nampa")
	if len(nampa) = 0 then nampa = request.Form("nampa")
twin = Request.QueryString("twin")
	if len(twin) = 0 then twin = request.Form("twin")
burley = Request.QueryString("burley")
	if len(burley) = 0 then burley = request.Form("burley")
pocatello = Request.QueryString("pocatello")
	if len(pocatello) = 0 then pocatello = request.Form("pocatello")
california = Request.QueryString("california")
	if len(california) = 0 then california = request.Form("california")
received = Request.QueryString("received")
	if len(received) = 0 then received = request.Form("received")
	
	
	
	
other = Request.QueryString("other")
	if len(other) = 0 then other = request.Form("other")
resume_age = Request.QueryString("resume_age")
	if len(resume_age) = 0 then resume_age = request.Form("resume_age")
	
if len( boise & nampa & twin & burley & pocatello & california & received & other ) = 0 then 'init option if all are empty
	select case lcase(whichCompany)
	case "bur"
		if len(burley) = 0 then burley = "checked"
		'if len(pocatello) = 0 then pocatello = "checked"
		if len(received) = 0 then received = "checked"
	case "poc"
		if len(pocatello) = 0 then pocatello = "checked"
		if len(received) = 0 then received = "checked"
	case "boi"
		if len(boise) = 0 then boise = "checked"
		if len(nampa) = 0 then nampa = "checked"
		if len(received) = 0 then received = "checked"
	case "per"
		if len(twin) = 0 then twin = "checked"
		if len(received) = 0 then received = "checked"
	case else
		if len(other) = 0 then other = "checked"
		if len(california) = 0 then california = "checked"
	end select
	
	if len(resume_age) = 0 then resume_age = "week"
end if

dim the_query
the_query = Request.QueryString("query")

%>

<%=decorateTop("", "notToShort marLR10", "Search")%>
<form method="GET" action="" name="frmSearch" id="frmSearch">
<div id="searchGuide">
Include:
<ul class="guide">
<li class="label_checkbox_pair"><input type="checkbox" name="boise" value="checked" <%if boise = "checked" then Response.write(checkedText)%> />Boise</li>
<li class="label_checkbox_pair"><input type="checkbox" name="nampa" value="checked" <%if nampa = "checked" then Response.write(checkedText)%> />Nampa</li>
<li class="label_checkbox_pair"><input type="checkbox" name="twin" value="checked" <%if twin = "checked" then Response.write(checkedText)%> />Twin Falls</li>
<li class="label_checkbox_pair"><input type="checkbox" name="burley" value="checked" <%if burley = "checked" then Response.write(checkedText)%> />Burley</li>
<li class="label_checkbox_pair"><input type="checkbox" name="pocatello" value="checked" <%if pocatello = "checked" then Response.write(checkedText)%> />Pocatello</li>
<li class="label_checkbox_pair"><input type="checkbox" name="received" value="checked" <%if received = "checked" then Response.write(checkedText)%> />New Received</li>
<li class="label_checkbox_pair"><input type="checkbox" name="california" value="checked" <%if california = "checked" then Response.write(checkedText)%> />California</li>
<li class="label_checkbox_pair"><input type="checkbox" name="other" value="checked" <%if other = "checked" then Response.write(checkedText)%> />Other</li>
</ul>
Include past:
<ul class="guide">
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="week" <%if resume_age = "week" then Response.write(checkedText)%>/>1 week</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="twoweeks" <%if resume_age = "twoweeks" then Response.write(checkedText)%>/>2 weeks</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="month" <%if resume_age = "month" then Response.write(checkedText)%>/>1 month</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="threemonth" <%if resume_age = "threemonth" then Response.write(checkedText)%>/>3 months</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="sixmonth" <%if resume_age = "sixmonth" then Response.write(checkedText)%>/>6 months</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="all" <%if resume_age = "all" then Response.write(checkedText)%>/>{all}</li>
</ul></div>
<div id="mainSearch">
<div id="sInput">
 <p style="margin:0; padding:0; text-align:left;">Search:</p>
  <div id="search_wrapper">
  <p>
    <input type="text" maxlength="255" name="query" id="query" size="35" value='<%=the_query%>'>
	<input type="submit" value="Search" name="B1" class="hide">
  </p>
  <div class="searchButton"><a class="squarebutton" href="#" style="float:none" onclick="javascript:document.frmSearch.submit();"><span style="text-align:center"> Search </span></a></div>
</div>

      <ul id="search_which">
      <li>
          <label for="netdocs"><input id="netdocs" name="searchCatalog" class="" type="radio" value="NetDocs" <%if searchCatalog = "NetDocs" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
          Documents</label></li>
      <li>
         <label for="howto"><input id="howto" name="searchCatalog" class="" type="radio" value="HowTos" <%if searchCatalog = "HowTos" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
          How-To's</label></li>
      <li>
         <label for="resumes"><input id="resumes" name="searchCatalog" class="" type="radio" value="Resumes" <%if searchCatalog = "Resumes" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
          Resumes</label></li>
    </ul>
  <input name="action" type="hidden" value="" />
  </div>
  	
  
<script type="text/javascript"><!-- 
						document.frmSearch.query.focus()
							//--></script>
	<%
	dim sGuideString
	dim sSearchString
	dim oQuery
	dim do_search 
	
	dim where_path
	where_path = "@path"
	if boise <> "checked" then where_path = where_path & " NOT #path *\_Boise\* AND"
	if nampa <> "checked" then where_path = where_path & " NOT #path *\_Nampa\* AND"
	if twin <> "checked" then where_path = where_path & " NOT #path *\_Twin\* AND"
	if burley <> "checked" then	where_path = where_path & " NOT #path *\_Burley\* AND"
	if pocatello <> "checked" then where_path = where_path & " NOT #path *\_Pocatello\* AND"
	if california <> "checked" then where_path = where_path & " NOT #path *\Other States\California\* AND"
	if received <> "checked" then where_path = where_path & " NOT #path *\Received\* AND"

	if other <> "checked" then	where_path = where_path & " NOT #path *Other* AND"


	if right(where_path, 3) = "AND" then
		where_path = left(where_path, len(where_path)-3)
	end if
	if where_path = "@path" then where_path = ""
		
	dim where_when
	select case resume_age
	case "week"
		where_when = "@write > -6d24h "
	case "twoweeks"
		where_when = "@write > -13d24h "
	case "month"
		where_when = "@write > -30d24h "
	case "threemonth"
		where_when = "@write > -92d24h "
	case "sixmonth"
		where_when = "(@write > -186d24h) "
	case else
		where_when = "(@write > -9999d24h) "
	end select
		
	dim isname
	if request.QueryString("isname") = "true" then
		isname = true
	else
		isname = false
	end if
		
'break sGuideString
	dim try_it_again, retry
	for retry = 0 to 1 'double check in case of no results

		if len(searchCatalog) <> 0 then
			sSearchString = Trim(reduceNoise(Request.QueryString("query")))
			if len(sSearchString) > 0 then
				if retry > 0 and try_it_again = true and isname = false then
					sSearchString = "$contents " & Replace(sSearchString, ",", " ") & " AND " & where_when & " AND " & where_path
				elseif retry = 0 then
					sSearchString = "@contents " & Replace(sSearchString, ",", " ") & " AND " & where_when & " AND " & where_path
				end if
			else
				if len(where_when) > 0 and len(where_path) > 0 then
					sSearchString = where_when & " AND " & where_path
				elseif len(where_when) > 0 then
					sSearchString = where_when
				elseif len(where_path) > 0 then
					sSearchString = where_path
				end if
			end if
				
			if len(sSearchString) > 0 or len(sSearchString) = 0 and searchCatalog = "Resumes" then

				if len(sSearchString) = 0 and searchCatalog = "Resumes" then
					sSearchString = "@write > -13d24h"
					print "{ * no search specified, showing this weeks received resumes instead ... }"
				end if
				
			if right(sSearchString, 5) = " AND " then
				sSearchString = left(sSearchString, len(sSearchString)-5)
			end if
		
				dim oRS
				' Set oQuery = Server.CreateObject("IXSSO.Query")
				Set oQuery = Server.CreateObject("MSIDXS")
				With oQuery
					.Catalog = searchCatalog
					.Dialect = 2
					.Query = sSearchString
					.MaxRecords = 200
					.SortBy = "write[d]"
					.Columns = "DocAuthor, vpath, doctitle, FileName, Path, Write, Size, Rank, Create, Characterization, DocCategory"
					'print oQuery.Query
					Set oRS = .CreateRecordSet("nonsequential")
				End With
				
				dim nPage, nItemsPerPage, nPageCount
				nPage = CInt(Request.QueryString("Page"))
				nItemsPerPage = 10
				oRS.PageSize = nItemsPerPage
				nPageCount = oRS.PageCount
		
				if nPage < 1 Or nPage > nPageCount then
					nPage = 1
				end if
			
				dim rsQuery, queryPageNumber
				rsQuery = request.serverVariables("QUERY_STRING")
				queryPageNumber = Request.QueryString("Page")
				if queryPageNumber then
					if right(sSearchString, 5) = " AND " then
						sSearchString = left(sSearchString, len(sSearchString)-5)
					end if
		
					rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
				end if
		
		
				if oRS.eof then
					if retry > 0 then
						response.write "<div id=""topPageRecords"" class=""navPageRecords"">"
						response.write "No results were found for: <i>" & sSearchString & "</i>"
						if instr(sSearchString, "*") = 0 then
							response.write "<br>Try adding an asterisk in your search phrase.</div>"
						end if
					else
						if isname = false then
							response.write "<p>{ not found as phrase, retrying as free-text }</p>"
							try_it_again = true
						elseif isname = true then
							response.write  "<p>Resume for: " & the_query & " was not found.</p>"
							response.write "<p>{ it may not have been indexed yet or it could be missing from net_docs\resumes }</p>"
							try_it_again = false
							retry = 1
						end if
					end if					
				else
					retry = 1
					response.write("<div id=""topPageRecords"" class=""navPageRecords"">")
					response.write "<A HREF=""/include/system/tools/searchForm.asp?Page=1&" & rsQuery & """>First</A>"
					dim i
					For i = 1 to nPageCount
						response.write "<A HREF=""/include/system/tools/searchForm.asp?Page="& i & "&" & rsQuery & """>&nbsp;"
						if i = nPage then
							response.write "<span style=""color:red"">" & i & "</span>"
						Else
							response.write i
						end if
						response.write "&nbsp;</A>"
					Next
					response.write "<A HREF=""/include/system/tools/searchForm.asp?Page=" & nPageCount & "&" & rsQuery & """>Last</A>"
					response.write("</div><div id=""searchResults"">")
					' Position recordset to the correct page
					oRS.AbsolutePage = nPage
							
					dim correctPath, docTitle, searchDescription, fileSize, internalPath
					do while not ( oRS.Eof Or oRS.AbsolutePage <> nPage )
						if oRS.eof then
							oRS.Close
							' Clean up
							' Do the no results HTML here
							response.write "No Items found."
								' Done
							Response.End 
						end if
						
						correctPath = Replace(oRS("Path"), "\", "/")
						correctPath = Replace(correctPath, "//personnelplus.net", "//www.personnelinc.com")
						correctPath = Replace(correctPath, ".net.", ".net")
						Response.write "<div class=" & Chr(34) & "searchSummary" & Chr(34) & "><p><a href=" & chr(34) & replace(correctPath, " ", "%20") & Chr(34) & ">" & oRS("FileName") & "</a></p>"
						
						docTitle = oRS("doctitle")
						if len(docTitle) > 0 then
							Response.write "<p><b>Document Title:</b> " & docTitle & "</p>"
						end if
						
						searchDescription = oRS("Characterization")
						if len(searchDescription) > 0 then
							Response.write "<p>" & Server.HTMLEncode(searchDescription) & "</p>"
						end if
						
						fileSize = CLng(oRS("Size"))/1024
						Response.write "<p><b>Size:</b> "
						if fileSize > 1023 then
							Response.write CInt(fileSize/1024) & "m"
						Else
							Response.write CInt(fileSize) & "k"
						end if
						
						Response.write "<b> Created:</b> " & oRS("Create") & "<b> Modified:</b> " & oRS("Write") & "</p>"
						internalPath = Left(oRS("Path"), Instr(oRS("Path"), oRS("FileName")) - 1)
						Response.write "<p class='intraLink'>" & internalPath & "</p></div>"
						oRS.MoveNext
					loop
				end if

				if retry > 0 then 'cleanup after second round
					Set oRS = nothing
					Set oQuery = nothing
					response.write bottomPageRecords (nPageCount, rsQuery)
					response.write "</div>"
				end if	
			end if
		elseif len(request.form("B1")) > 0 then
					response.write "I'm sorry, but you need to type something to search for first."
	
		end if
	next

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
		
		
		dim Line, searchNoise
		do while not TextStream.AtEndOfStream
			Line = TextStream.readline
			searchNoise = searchNoise & Line & " "
		loop
		Set TextStream = nothing
	end if
	Set FSO = nothing
	
	dim SearchArray, Word
	SearchArray = Split(search, " ")
	
	dim quieterSearch
	For Each Word in SearchArray
		if Instr(searchNoise, Word) = 0 then
			quieterSearch = quieterSearch & Word & " "
		Else
			noiseWords = noiseWords & Word & " "
		end if
	Next
	
	dim noiseWords
	if len(noiseWords) > 0 then response.write "<pre>The following words were ommitted from the search: " & noiseWords & "</pre><br><hr><br>"
	reduceNoise = quieterSearch
End Function
%>

</form>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
