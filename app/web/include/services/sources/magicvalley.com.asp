<%
	Response.Buffer = false
	dim objXMLHTTP, magicvalley, craigslist, magicValleyPage(2)
	
	magicValleyPage(0) = "http://hotjobs.yahoo.com/job-search-l-Twin_Falls-ID-m-1-o-60#" &_
		"core={%22offset%22%3A0%2C%22detailed%22%3Atrue%2C%22sort%22%3A" &_
		"{%22type%22%3A%22relevancy%22%2C%22reverse%22%3Afalse}}"
		
	magicValleyPage(1) = "http://hotjobs.yahoo.com/job-search-l-Twin_Falls-ID-m-1-o-60#" &_
		"core={%22offset%22%3A%2230%22%2C%22detailed%22%3Atrue%2C%22sort%22%3A" &_
		"{%22type%22%3A%22relevancy%22%2C%22reverse%22%3Afalse}}"
		
	magicValleyPage(2) = "http://hotjobs.yahoo.com/job-search-l-Twin_Falls-ID-m-1-o-60#" &_
		"core={%22offset%22%3A%2260%22%2C%22detailed%22%3Atrue%2C%22sort%22%3A" &_
		"{%22type%22%3A%22relevancy%22%2C%22reverse%22%3Afalse}}"
	
	
	jobTitleStart = "?source=SRP"" >"
	jobTitleEnd = "</a></td>"
	
	companyStart = "<td class=""c"">"
	companyEnd = "</a></td>"
	
	locationStart = "<td class=""l"">"
	locationEnd = "</td>"
	
	dateStart = "class=""mid"""
	dateEnd = "</td>"
	
	descriptionStart = "<td class=""t"">"
	descriptionEnd = "</td>"
	
	
	response.write "<table>"
	Set magicvalley = Server.CreateObject("MSXML2.ServerXMLHTTP")
	Set detailedDescription = Server.CreateObject("MSXML2.ServerXMLHTTP")
	

	
	For i = 0 to 2
	
		magicvalley.Open "GET", magicValleyPage(i), false
		magicvalley.Send
		
		httpBlob = magicvalley.responseText
		aryHttpBlob = Split(httpBlob, jobTitleStart)
		
		for each item in aryHttpBlob
			'if i > 0 then
				Response.write stripHTML(item) & "<br><br><br><br>"
			'end if
			i = i + 1
		next

'		For cr = 1 to 31
'			httpBlob = Replace(httpBlob, Chr(cr), "")
'
'		Next

'		blobPosition = 1
'		do while Instr(blobPosition, httpBlob, jobTitleStart) <> 0
		
'			startchunk = Instr(blobPosition, httpBlob, jobTitleStart) + len(jobTitleStart)
'			endchunk = (Instr(startchunk, httpBlob, jobTitleEnd)) - startchunk
'			jobTitle = Mid(httpBlob, startchunk, endchunk)
'			blobPosition = startchunk + endchunk
'
'			startchunk = Instr(blobPosition, httpBlob, companyStart) + len(companyStart)
'			startchunk = Instr(startchunk, httpBlob, "'>") + 2
'			endchunk = (Instr(startchunk, httpBlob, companyEnd)) - startchunk
'			jobCompany = Mid(httpBlob, startchunk, endchunk)
'			blobPosition = startchunk + endchunk

			'startchunk = Instr(blobPosition, httpBlob, locationStart) + len(locationStart)
			'endchunk = (Instr(startchunk, httpBlob, locationEnd)) - startchunk
			'jobLocation = Mid(httpBlob, startchunk, endchunk)
			'blobPosition = startchunk + endchunk
			
			'startchunk = Instr(blobPosition, httpBlob, dateStart) + len(dateStart)
			'startchunk = Instr(startchunk, httpBlob, ">") + 1
			'endchunk = (Instr(startchunk, httpBlob, dateEnd)) - startchunk
			'jobDate = Mid(httpBlob, startchunk, endchunk)
			'blobPosition = startchunk + endchunk

'			startchunk = Instr(blobPosition, httpBlob, descriptionStart) + len(descriptionStart)
'			startchunk = Instr(startchunk, httpBlob, "<a href=""") + 9
'			endchunk = (Instr(startchunk, httpBlob, """ >")) - startchunk
'			jobDescriptionLink = Mid(httpBlob, startchunk, endchunk)
'			blobPosition = blobPosition + endchunk
'			
'			detailedDescription.Open "GET", "http://hotjobs.yahoo.com" & jobDescriptionLink, false
'			detailedDescription.Send
'	
'			descriptionChunk = detailedDescription.responseText
'			startDescript = Instr(descriptionChunk, "<div id=""jobDescription"">") + 25
'			endDescript = Instr(startDescript, descriptionChunk, "</div>")
'			jobDescription = RemoveHTML(Mid(descriptionChunk, startDescript, endDescript - startDescript))
'			
'			response.write "<tr>" &_
'				"<td>" & jobTitle & "</td>" &_
'				"<td>" & "</td>" &_
'				"<td>" & "</td>" &_
'				"<td>" & "</td>" &_
'				"</tr><tr>" &_
'				"<td colspan=""4"">" & jobDescription & "</td>" &_
'				"</tr>"
'		loop
	Next
	Set magicvalley = Nothing
	Set detailedDescription = Nothing
	
'	dim craigsURL(2)
	
'	craigsURL(0) = "http://twinfalls.craigslist.org/jjj/"
'	craigsURL(1) = "http://twinfalls.craigslist.org/jjj/index100.html"
'	craigsURL(2) = "http://twinfalls.craigslist.org/jjj/index200.html"
'	
	jobTitleStart = "<p><a href=""http://twinfalls.craigslist.org"
	
	companyStart = "<td class=""c"">"
	companyEnd = "</a></td>"
	
	Set craigslist = Server.CreateObject("MSXML2.ServerXMLHTTP")


	Do
		url = url + 1 
		
		
		craigslist.Open "GET", "http://boise.craigslist.org/jjj/index" & url & "00.html", false
		'craigslist.Open "GET", "http://boise.craigslist.org/jjj/index1900.html", false
		craigslist.Send
		response.write len(craigslist.responseText)
		'Response.End()
		httpBlob = craigslist.responseText
		
		if len(httpBlob) < 5400 then Exit Do
		
		aryHttpBlob = Split(httpBlob, jobTitleStart)
		
		for each item in aryHttpBlob
			'if i > 0 then
				Response.write stripHTML(item) & "<br><br><br><br>"
			'end if
			i = i + 1
		next
		
		'For cr = 1 to 31
		'	httpBlob = Replace(httpBlob, Chr(cr), "")

		'Next

	loop while url < 30
	
	url = 0
	Do
		url = url + 1 
		
		
		craigslist.Open "GET", "http://twinfalls.craigslist.org/jjj/index" & url & "00.html", false
		'craigslist.Open "GET", "http://boise.craigslist.org/jjj/index1900.html", false
		craigslist.Send
		response.write len(craigslist.responseText)
		'Response.End()
		httpBlob = craigslist.responseText
		
		if len(httpBlob) < 5400 then Exit Do
		
		aryHttpBlob = Split(httpBlob, jobTitleStart)
		
		for each item in aryHttpBlob
			'if i > 0 then
				Response.write regStripHTML(item) & "<br><br><br><br>"
			'end if
			i = i + 1
		next
		
		'For cr = 1 to 31
		'	httpBlob = Replace(httpBlob, Chr(cr), "")

		'Next

	loop while url < 30





		'blobPosition = 1
		'do while Instr(blobPosition, httpBlob, jobTitleStart) <> 0
		
		'	startchunk = Instr(blobPosition, httpBlob, jobTitleStart) + len(jobTitleStart)
		'	startchunk = Instr(startchunk, httpBlob, """>") + 2
		'	endchunk = (Instr(startchunk, httpBlob, jobTitleEnd)) - startchunk
		'	jobTitle = RemoveHTML(Mid(httpBlob, startchunk, endchunk))
		'	blobPosition = startchunk + endchunk

			'startchunk = Instr(blobPosition, httpBlob, companyStart) + len(companyStart)
			'startchunk = Instr(startchunk, httpBlob, "'>") + 2
			'endchunk = (Instr(startchunk, httpBlob, companyEnd)) - startchunk
			'jobCompany = Mid(httpBlob, startchunk, endchunk)
			'blobPosition = startchunk + endchunk

			'startchunk = Instr(blobPosition, httpBlob, locationStart) + len(locationStart)
			'endchunk = (Instr(startchunk, httpBlob, locationEnd)) - startchunk
			'jobLocation = Mid(httpBlob, startchunk, endchunk)
			'blobPosition = startchunk + endchunk
			
			'startchunk = Instr(blobPosition, httpBlob, dateStart) + len(dateStart)
			'startchunk = Instr(startchunk, httpBlob, ">") + 1
			'endchunk = (Instr(startchunk, httpBlob, dateEnd)) - startchunk
			'jobDate = Mid(httpBlob, startchunk, endchunk)
			'blobPosition = startchunk + endchunk

			'startchunk = Instr(blobPosition, httpBlob, descriptionStart) + len(descriptionStart)
			'startchunk = Instr(startchunk, httpBlob, "<a href=""") + 9
			'endchunk = (Instr(startchunk, httpBlob, """ >")) - startchunk
			'jobDescriptionLink = Mid(httpBlob, startchunk, endchunk)
			'blobPosition = blobPosition + endchunk
			
			'detailedDescription.Open "GET", "http://hotjobs.yahoo.com" & jobDescriptionLink, false
			'detailedDescription.Send
	
			'descriptionChunk = detailedDescription.responseText
			'startDescript = Instr(descriptionChunk, "<div id=""jobDescription"">") + 25
			'endDescript = Instr(startDescript, descriptionChunk, "</div>")
			'jobDescription = RemoveHTML(Mid(descriptionChunk, startDescript, endDescript - startDescript))
			
		'	response.write "<tr>" &_
		'		"<td>" & jobTitle & "</td>" &_
		'		"<td>" & "</td>" &_
		'		"<td>" & "</td>" &_
		'		"<td>" & "</td>" &_
		'		"</tr><tr>" &_
		'		"<td colspan=""4"">" & "</td>" &_
		'		"</tr>"
		'loop

	'craigslist.Open "GET", "http://twinfalls.craigslist.org/search/acc?query=+", false
	'craigslist.Send
	'Response.write craigslist.responseText
	'Set craigslist = Nothing

Function getInfoPiece(infoStart, infoStop, offest, httpBlob)
	if len(httpBlob) > 0 then
		startchunk = Instr(offest, httpBlob, infoStart) + len(infoStart)
		endchunk = Instr(offest, httpBlob, infoStop)
		getInfoPiece = Mid(httpBlob, startchunk, endchunk)
		offset = endchunk + len(endchunk)
	end if
End Function
	
Function RemoveHTML(strText)
dim nPos1
dim nPos2
nPos1 = InStr(strText, "<")
do while nPos1 > 0
nPos2 = InStr(nPos1 + 1, strText, ">")
if nPos2 > 0 then
strText = Left(strText, nPos1 - 1) & Mid(strText, nPos2 + 1)
Else
Exit Do
end if
nPos1 = InStr(strText, "<")
loop
RemoveHTML = strText
End Function

Function stripHTML(strHTML)
'Strips the HTML tags from strHTML

  dim objRegExp, strOutput
  Set objRegExp = New Regexp

  objRegExp.IgnoreCase = true
  objRegExp.Global = true
  objRegExp.Pattern = "<(.|\n)+?>"

  'Replace all HTML tag matches with the empty string
  strOutput = objRegExp.Replace(strHTML, "")
  
  'Replace all < and > with &lt; and &gt;
  strOutput = Replace(strOutput, "<", "&lt;")
  strOutput = Replace(strOutput, ">", "&gt;")
  
  stripHTML = strOutput    'Return the value of strOutput

  Set objRegExp = Nothing
End Function

Function regStripHTML(strHTML)
'Strips the HTML tags from strHTML

  dim objRegExp, strOutput
  Set objRegExp = New Regexp

  objRegExp.IgnoreCase = true
  objRegExp.Global = true
  objRegExp.Pattern = "<(.|\n)+?>"

  'Replace all HTML tag matches with the empty string
  strOutput = objRegExp.Replace(strHTML, "")
  
  'Replace all < and > with &lt; and &gt;
  strOutput = Replace(strOutput, "<", "&lt;")
  strOutput = Replace(strOutput, ">", "&gt;")
  
  regStripHTML = strOutput    'Return the value of strOutput

  Set objRegExp = Nothing
End Function

%>