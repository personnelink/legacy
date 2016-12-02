<%
' sitemap_gen_spider.asp
' A simple script to automatically produce sitemaps for a webserver, in the Google Sitemap Protocol (GSP)
' by Francesco Passantino
' www.iteam5.net/francesco/sitemap_gen
' v0.1 released 9 june 2005
' v0.2 released 17 june 2005 iso8601dates http://www.tumanov.com/projects/scriptlets/iso8601dates.asp
'
' BSD 2.0 license,
' http://www.opensource.org/licenses/bsd-license.php


'script configuration
Url="http://www.yoursite.com/"
FinalDepth=3
LimitUrl=100
'leave sitemapDate empty if you want sitemapDate=now
sitemapDate=""
'sitemapPriority possible value are from 0.1 to 1.0
sitemapPriority="0.7"
'sitemapChangefreq possible value are: always, hourly, daily, weekly, monthly, yearly, never
sitemapChangefreq="monthly"
'see http://www.time.gov/ for utcOffset
utcOffset=1


Dim objRegExp,objUrlArchive,strHTML,objMatch
Server.ScriptTimeout=300
set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP")
Set objUrlArchive=Server.CreateObject("Scripting.Dictionary")
Set objRegExp = New RegExp
objRegExp.IgnoreCase = True
objRegExp.Global = True


'you can change this patterns for your needs
objRegExp.Pattern = "href=(.*?)[\s|>]"
'to remove elements from html urls
RemoveText=array("<",">","a href=",chr(34),"'","href=")
'to exclude elements from urls
ExcludeUrl=array("mailto:","javascript:",".css",".ico")


'if you want sitemapDate=now
if sitemapDate="" then filelmdate=now()

sitemapDate=iso8601date(filelmdate,utcOffset)


crawl url,0


For Depth=0 to FinalDepth
	arrUrl=objUrlArchive.Keys
	arrDepth=objUrlArchive.Items
	For LoopUrl= 0 to ubound(arrurl)-1

		'debugging
		'response.write "<!-- pagefound='"&loopurl&"'-->"

		crawl url&"/"&arrUrl(LoopUrl),Depth

		'if you want to limit the url number
		'if objUrlArchive.Count-1>LimitUrl then exit for

	Next
	erase arrUrl
	erase arrDepth
Next


' create the xml on the fly
arrUrl=objUrlArchive.Keys
arrDepth=objUrlArchive.Items
response.ContentType = "text/xml"
response.write "<?xml version='1.0' encoding='UTF-8'?>"
response.write "<!-- generator='http://www.iteam5.net/francesco/sitemap_gen'-->"
response.write "<!-- pagefound='"&ubound(arrurl)&"'-->"
response.write "<urlset xmlns='http://www.google.com/schemas/sitemap/0.84'>"
For LoopUrl=0 to ubound(arrurl)-1
	response.write "<url>"
	response.write "<loc>"&server.htmlencode(url&arrUrl(LoopUrl))&"</loc>"
	response.write "<lastmod>"&sitemapDate&"</lastmod>"
	response.write "<priority>"&sitemapPriority&"</priority>"
	response.write "<changefreq>"&sitemapChangefreq&"</changefreq>"
	response.write "</url>"
Next
response.write "</urlset>"


erase arrUrl
erase arrDepth
objUrlArchive.RemoveAll()
set xmlhttp = nothing




Sub crawl(url,depth)
	xmlhttp.open "GET", url, false
	xmlhttp.send ""
	strHTML = xmlhttp.responseText

	For Each objMatch in objRegExp.Execute(strHTML)
		for i=0 to ubound(excludeUrl)
			if instr(objmatch,excludeUrl(i))>0 then objmatch=""
		next
		if objmatch<>"" then
			for i=0 to ubound(RemoveText)
				objMatch=replace(lcase(objMatch),lcase(RemoveText(i)),"")
			next
			'in some cases this is better if left(objMatch,len(url))=Url then
			if instr(objMatch,"http://")=0 and objmatch<>"" then
				if objUrlArchive.Exists(objMatch)=false then
					objUrlArchive.Add objMatch,depth

					'debugging
					'response.write objmatch&"<br>"
					'response.flush

				end if
			end if
		end if
	Next
End Sub


Function iso8601date(dLocal,utcOffset)	
	Dim d
	' convert local time into UTC
	d = DateAdd("H",-1 * utcOffset,dLocal)

	' compose the date
	iso8601date = Year(d) & "-" & Right("0" & Month(d),2) & "-" & Right("0" & Day(d),2) & "T" & _
		Right("0" & Hour(d),2) & ":" & Right("0" & Minute(d),2) & ":" & Right("0" & Second(d),2) & "Z"
End Function
%>