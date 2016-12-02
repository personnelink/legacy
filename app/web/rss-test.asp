<html>
<head>
	<title>RSS Feed Using ASP Classic - For Texas Longhorns Football Schedule from TicketCity.com</title>
	<style>
		*{font-family:verdana;}
		td{vertical-align:top;padding:5px 5px 5px 5px;}
	</style>
</head>
<body>
<%
	' change the RSSURL variable to the exact URL of the RSS Feed you want to pull
	RSSURL = "http://www.ticketcity.com/rss/Texas-Longhorns-Football-Tickets.rss"

	dim objHTTP ' this object is used to call the RSS Feed remotely
	dim RSSURL,RSSFeed ' these variables hold the URL and Content for the RSS Feed
	dim xmlRSSFeed ' this variable hold the XML data in a DOM Object
	dim objItems,objItem, objChild ' these variables are used to temporarily hold data from the various RSS Items
	dim title,description,link '  these are local variables that will hold the data to be displayed
	dim OutputHTML_1,OutputHTML_2,OutputHTML_3 ' these variables will hold the HTML that was converted from the RSS Feed

	' this code requests the raw RSS/XML and saves the response as a string <RSSFeed>
	Set objHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")
	objHTTP.open "GET",RSSURL,false
	objHTTP.send
	RSSFeed = objHTTP.responseText

	' this code takes the raw RSSFeed and loads it into an XML Object
	Set xmlRSSFeed = Server.CreateObject("MSXML2.DOMDocument") 
	xmlRSSFeed.async = false
	xmlRSSFeed.LoadXml(RSSFeed)

	' this code disposes of the object we called the feed with
	Set objHTTP = Nothing

	' this is where you determine how to display the content from the RSS Feed

	' this code grabs all the "items" in the RSS Feed
	Set objItems = xmlRSSFeed.getElementsByTagName("item")

	' this code disposes of the XML object that contained the entire feed
	Set xmlRSSFeed = Nothing

	' loop over all the items in the RSS Feed
	For x = 0 to objItems.length - 1
		' this code places the content from the various RSS nodes into local variables
		Set objItem = objItems.item(x)
		For Each objChild in objItem.childNodes
			Select Case LCase(objChild.nodeName)
				Case "title"
					  title = objChild.text
				Case "link"
					  link = objChild.text
				Case "description"
					  description = objChild.text
			End Select
		Next
		' Here are some various display samples.
		OutputHTML_1 = OutputHTML_1 & "<a href=""" & link & """>" & title & "</a><br />" & description & "<br /><br />"
		OutputHTML_2 = OutputHTML_2 & "<a href=""" & link & """>" & title & "</a><br />"
		OutputHTML_3 = OutputHTML_3 & "<a href=""" & link & """>" & title & "</a><hr />"
	Next
%>

<!-- This is the HTML Layout that will render content from the RSS Feed -->
Here is the output, with content provided by the RSS Feed located at:<br /><%=RSSURL%><hr />

<table border="1">
	<tr>
		<td>Ouput Style 1</td>
		<td>Ouput Style 2</td>
		<td>Ouput Style 3</td>
	</tr>
	<tr>
		<td><%=OutputHTML_1%></td>
		<td><%=OutputHTML_2%></td>
		<td><%=OutputHTML_3%></td>
	</tr>
</table>
</body>
</html>


