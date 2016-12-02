<%

'*********************************************
'***  		Eliminiamo i tag principali	 *****
'*********************************************

Private Function removeAllTags(ByVal strInputEntry)

	strInputEntry = Replace(strInputEntry, "&", "&amp;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "<", "&lt;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, ">", "&gt;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "#", "&#035;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "%", "&#037;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "*", "&#042;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "\", "&#092;", 1, -1, 1)
	strInputEntry = Replace(strInputEntry, "'", "&#146;", 1, -1, 1)
	
	removeAllTags = strInputEntry
	
End Function

Private Function removemaligno(ByVal strInput)

	strInput = Replace(strInput, "&", "&amp;", 1, -1, 1)
	strInput = Replace(strInput, "#", "&#035;", 1, -1, 1)
	strInput = Replace(strInput, "%", "&#037;", 1, -1, 1)
	strInput = Replace(strInput, "*", "&#042;", 1, -1, 1)
	strInput = Replace(strInput, "\", "&#092;", 1, -1, 1)
	strInput = Replace(strInput, "'", "&#146;", 1, -1, 1)
	
	removemaligno = strInput
	
End Function


'******************************************
'***          UBB code                *****
'******************************************

Private Function UBBcode(ByVal strMessage)


	Dim strTempMessageLink
	Dim strMessageLink
	Dim lngLinkStartPos
	Dim lngLinkEndPos
	Dim intLoop

	strMessage = Replace(strMessage, "[B]", "<b>", 1, -1, 1)
	strMessage = Replace(strMessage, "[/B]", "</b>", 1, -1, 1)
	strMessage = Replace(strMessage, "[I]", "<i>", 1, -1, 1)
	strMessage = Replace(strMessage, "[/I]", "</i>", 1, -1, 1)
	strMessage = Replace(strMessage, "[U]", "<u>", 1, -1, 1)
	strMessage = Replace(strMessage, "[/U]", "</u>", 1, -1, 1)
	strMessage = Replace(strMessage, "[LIST=1]", "<ol>", 1, -1, 1)
	strMessage = Replace(strMessage, "[/LIST=1]", "</ol>", 1, -1, 1)
	strMessage = Replace(strMessage, "[LIST]", "<ul>", 1, -1, 1)
	strMessage = Replace(strMessage, "[/LIST]", "</ul>", 1, -1, 1)
	strMessage = Replace(strMessage, "[LI]", "<li>", 1, -1, 1)
	strMessage = Replace(strMessage, "[/LI]", "</li>", 1, -1, 1)
	strMessage = Replace(strMessage, "[CENTER]", "<center>", 1, -1, 1)
	strMessage = Replace(strMessage, "[/CENTER]", "</center>", 1, -1, 1)
	
	strMessage = Replace(strMessage, "[FONT FACE=Arial]", "<font face=""Arial, Helvetica, sans-serif"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT FACE=Courier]", "<font face=""Courier New, Courier, mono"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT FACE=Times]", "<font face=""Times New Roman, Times, serif"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT FACE=Verdana]", "<font face=""Verdana, Arial, Helvetica, sans-serif"">", 1, -1, 1)
	
	strMessage = Replace(strMessage, "[FONT COLOR=BLACK]", "<font color=""black"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT COLOR=WHITE]", "<font color=""white"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT COLOR=BLUE]", "<font color=""blue"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT COLOR=RED]", "<font color=""red"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT COLOR=ORANGE]", "<font color=""orange"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT COLOR=GREEN]", "<font color=""green"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT COLOR=YELLOW]", "<font color=""yellow"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT COLOR=GRAY]", "<font color=""gray"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[/FONT]", "</font>", 1, -1, 1)


	strMessage = Replace(strMessage, "[FONT SIZE=1]", "<font size=""1"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT SIZE=2]", "<font size=""2"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT SIZE=3]", "<font size=""3"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT SIZE=4]", "<font size=""4"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT SIZE=5]", "<font size=""5"">", 1, -1, 1)
	strMessage = Replace(strMessage, "[FONT SIZE=6]", "<font size=""6"">", 1, -1, 1)
	

	Do While InStr(1, strMessage, "[IMG]", 1) > 0  AND InStr(1, strMessage, "[/IMG]", 1) > 0

		lngLinkStartPos = InStr(1, strMessage, "[IMG]", 1)

		lngLinkEndPos = InStr(lngLinkStartPos, strMessage, "[/IMG]", 1) + 6
		strMessageLink = Trim(Mid(strMessage, lngLinkStartPos, (lngLinkEndPos - lngLinkStartPos)))

		strTempMessageLink = strMessageLink

		strTempMessageLink = Replace(strTempMessageLink, "[IMG]", "<img src=""", 1, -1, 1)
		strTempMessageLink = Replace(strTempMessageLink, "[/IMG]", """>", 1, -1, 1)

		strMessage = Replace(strMessage, strMessageLink, strTempMessageLink, 1, -1, 1)
	Loop




	Do While InStr(1, strMessage, "[URL=", 1) > 0 AND InStr(1, strMessage, "[/URL]", 1) > 0

		lngLinkStartPos = InStr(1, strMessage, "[URL=", 1)

		lngLinkEndPos = InStr(lngLinkStartPos, strMessage, "[/URL]", 1) + 6

		If lngLinkEndPos - lngLinkStartPos =< 5 Then lngLinkEndPos = lngLinkStartPos + 5

		strMessageLink = Trim(Mid(strMessage, lngLinkStartPos, (lngLinkEndPos - lngLinkStartPos)))

		strTempMessageLink = strMessageLink

		strTempMessageLink = Replace(strTempMessageLink, "[URL=", "<a href=""", 1, -1, 1)
		strTempMessageLink = Replace(strTempMessageLink, "[/URL]", "</a>", 1, -1, 1)
		strTempMessageLink = Replace(strTempMessageLink, "]", """ target=_blank"">", 1, -1, 1)
		
		strMessage = Replace(strMessage, strMessageLink, strTempMessageLink, 1, -1, 1)
	Loop




	Do While InStr(1, strMessage, "[EMAIL=", 1) > 0 AND InStr(1, strMessage, "[/EMAIL]", 1) > 0

		lngLinkStartPos = InStr(1, strMessage, "[EMAIL=", 1)

		lngLinkEndPos = InStr(lngLinkStartPos, strMessage, "[/EMAIL]", 1) + 8

		If lngLinkEndPos - lngLinkStartPos =< 7 Then lngLinkEndPos = lngLinkStartPos + 7

		strMessageLink = Trim(Mid(strMessage, lngLinkStartPos, (lngLinkEndPos - lngLinkStartPos)))

		strTempMessageLink = strMessageLink

		strTempMessageLink = Replace(strTempMessageLink, "[EMAIL=", "<a href=""mailto:", 1, -1, 1)
		strTempMessageLink = Replace(strTempMessageLink, "[/EMAIL]", "</a>", 1, -1, 1)
		strTempMessageLink = Replace(strTempMessageLink, "]", """>", 1, -1, 1)


		strMessage = Replace(strMessage, strMessageLink, strTempMessageLink, 1, -1, 1)
	Loop


	UBBcode = strMessage
End Function
%>