<%

'
' ---------------------------------------------------------------------------
' Copyright(c) 2000-2002, Laurens Pit
' All rights reserved.
'
' Redistribution and use in source and binary forms, with or without
' modification, are permitted provided that the following conditions
' are met:
'
'   * Redistributions of source code must retain the above copyright
'     notice, this list of conditions and the following disclaimer.
'   * Redistributions in binary form must reproduce the above
'     copyright notice, this list of conditions and the following
'     disclaimer in the documentation and/or other materials provided
'     with the distribution.
'   * Neither the name of OpenWiki nor the names of its contributors
'     may be used to endorse or promote products derived from this
'     software without specific prior written permission.
'
' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
' "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
' LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
' FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
' REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
' INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
' BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
' LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
' CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
' LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
' ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
' POSSIBILITY OF SUCH DAMAGE.
'
' ---------------------------------------------------------------------------
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owprocessor.asp,v $
'    $Revision: 1.23 $
'      $Author: gbamber $
' ---------------------------------------------------------------------------
'
Sub OwProcessRequest
'        // This is the main application loop.
'        // 1) Initialise cookie stuff
'        // 2) Initialise the classes:
'        //        a) gTransformer in owtransformer.asp
'        //        b) gNamespace in owdb.asp
'        // 3) Call the action (initially view). - This is the route to the rest
'        // 4) Set gTransformer and gNamespace to Nothing
    Dim SCRIPT_NAME, SERVER_NAME, SERVER_PORT, SERVER_PORT_SECURE
    Dim vUserSkin
    SCRIPT_NAME        = Request.ServerVariables("SCRIPT_NAME")
    SERVER_NAME        = Request.ServerVariables("SERVER_NAME")
    SERVER_PORT        = Request.ServerVariables("SERVER_PORT")
    SERVER_PORT_SECURE = Request.ServerVariables("SERVER_PORT_SECURE")

    If SERVER_PORT_SECURE = 0 Then
        gServerRoot = "http://" & SERVER_NAME
    Else
        gServerRoot = "https://" & SERVER_NAME
    End If
    If SERVER_PORT <> 80 Then
        gServerRoot = gServerRoot & ":" & SERVER_PORT
    End If
    gServerRoot = gServerRoot & Left(SCRIPT_NAME, InStrRev(SCRIPT_NAME, "/"))

    If OPENWIKI_SCRIPTNAME <> "" Then
        gScriptName = OPENWIKI_SCRIPTNAME
    Else
        gTemp = InStrRev(SCRIPT_NAME, "/")
        If gTemp > 0 Then
            gScriptName = Mid(SCRIPT_NAME, gTemp + 1)
        Else
            gScriptName = SCRIPT_NAME
        End If
    End If

'    gCookieHash = "C" & Hash(gServerRoot & SCRIPT_NAME)
    gCookieHash = "C" & Hash(gServerRoot)

    If Request.Cookies(gCookieHash & "?up") <> "" Then
        If Request.Cookies(gCookieHash & "?up")("pwl") = "1" Then
            cPrettyLinks = 1
        Else
            cPrettyLinks = 0
        End If
        If Request.Cookies(gCookieHash & "?up")("new") = "1" Then
            cExternalOut = 1
        Else
            cExternalOut = 0
        End If
        If Request.Cookies(gCookieHash & "?up")("emo") = "1" Then
            cEmoticons = 1
        Else
            cEmoticons = 0
        End If
    End If

'        // Gordon Bamber 20040828
'        // Overrides value of OPENWIKI_ACTIVESKIN set in owconfig_default
'        // if the user has set their own skin in UserPreferences
        gSystemSkin=OPENWIKI_ACTIVESKIN
        vUserSkin = Trim(Request.Cookies(gCookieHash & "?up")("ski"))
        if (vUserSkin <> "") then
                gUserSkin=vUserSkin
                If (gUserSkin <> OPENWIKI_ACTIVESKIN) then
                        OPENWIKI_ACTIVESKIN=gUserSkin
                End If
        End If
'        // Gordon Bamber 20040828

    Set gTransformer = New Transformer
    Set gNamespace = New OpenWikiNamespace
    Set gErrorStack = New clsErrorStack
    gErrorStack.ShowPrefix = TRUE
    gErrorStack.DebugLevel = 0


    InitLinkPatterns()
    ParseQueryString()

    If gReadPassword <> "" Then
        If gEditPassword = "" Then
            gEditPassword = gReadPassword
        End If
        gTemp = Request.Cookies(gCookieHash & "?pr")
        If gTemp <> gReadPassword Then
            gAction = "login"
        End If
    End If

    If Not m(OPENWIKI_TIMEZONE, "^[+|-](0\d|1[0-2]):[0-5]\d$", False, False) Then
        OPENWIKI_TIMEZONE = "+00:00"
    End If

    gSerialisingInProgress = false '        // Only true when archiving pages from serialise.asp

	'Vagabond 20060407
	if ( cUseCategories = 1 ) AND ( cReadCategoriesFromDB = 1 ) then
		ReadCategories()
	end if

	if cSortCategories=1 then
		' // BubbleSorted, sir?
		Dim f,g,tmp
		For f = UBound(gCategoryArray) to 1 step -1
			for g = 1 to f-1
				If (gCategoryArray(g) > gCategoryArray(g + 1)) AND (gCategoryArray(g + 1) <> "") then
					tmp = gCategoryArray(g)
					gCategoryArray(g) = gCategoryArray(g + 1)
					gCategoryArray(g + 1) = tmp
				end if
			Next
		Next
	End If

	
    gActionReturn = False
    Execute("Call Action" & gAction) '        // THIS IS THE MAIN CALL TO DISPLAY ANY PAGE
' //DEBUGGING// RESPONSE.WRITE("gCookieHash=" & gCookieHash)
    If Not gActionReturn Then
        Response.ContentType = "text/xml; charset:" & OPENWIKI_ENCODING & ";"
        Response.Write "<?xml version='1.0' encoding='" & OPENWIKI_ENCODING & "'?><error>Illegal action</error>"
        Response.End
    End If
    Set gTransformer = Nothing
    Set gNamespace = Nothing
End Sub

Function Archive(pWhat)
Dim vConn,vRs,vQuery,pPageName,vPage
    On Error Resume Next
    gScriptName = OPENWIKI_SCRIPTNAME
    Set gTransformer = New Transformer
    Set gNamespace = New OpenWikiNamespace
    gSerialisingInProgress = true
    cEmbeddedMode = 0
    InitLinkPatterns() ' // Only inits gMacros if cEmbeddedMode = 0
    RESPONSE.WRITE("<h1>Archiving site " & OPENWIKI_TITLE & "</h1><hr/>")
    ' Make sure the folders are initialised
    If (pWhat="XML") then
        RESPONSE.WRITE("<p>Copying over css and image folders to " & cWriteXMLFoldername & " ..</p>")
        RESPONSE.FLUSH
        Call gTransformer.PrepareSerialiseFolders(cWriteXMLFoldername,true)
    else
        RESPONSE.WRITE("<p>Copying over css and image folders to " & cWriteHTMLFoldername & " ..</p>")
        RESPONSE.FLUSH
        Call gTransformer.PrepareSerialiseFolders(cWriteHTMLFoldername,true)
    end if
    Set vConn = Server.CreateObject("ADODB.Connection")
    vConn.Open OPENWIKI_DB
    Set vRS = Server.CreateObject("ADODB.Recordset")
    vQuery="SELECT DISTINCT wpg_name FROM openwiki_pages " &_
    "ORDER BY wpg_name ASC;"
    vRS.Open vQuery, vConn, adOpenForwardOnly
    If NOT vRS.EOF then
       RESPONSE.WRITE("<p>Please wait until all items have completed..</p>")
       RESPONSE.WRITE("<ol>")
       Do While NOT vRs.EOF
             pPageName = Trim(vRs.Fields("wpg_name"))
             If (pPageName <> "") then
                 RESPONSE.WRITE("<li>Saving " & pPageName & " to disk..")
                 If (pWhat="XML") then
                     If gTransformer.SavePageNameAsXML(pPageName) then
                         RESPONSE.WRITE(" - <strong>Saved as XML OK</strong>.</li>")
                     else
                         RESPONSE.WRITE(" - <strong>NOT SAVED!</strong>.</li>")
                     End If
                 else
                     If gTransformer.SavePageNameAsHTML(pPageName) then
                         RESPONSE.WRITE(" - <strong>Saved as HTML OK</strong>.</li>")
                     else
                         RESPONSE.WRITE(" - <strong>NOT SAVED!</strong>.</li>")
                     End If
                 end if
                 RESPONSE.FLUSH
             End If
       vRs.MoveNext
       Loop
       RESPONSE.WRITE("<ol>")
    else
       RESPONSE.WRITE(OPENWIKI_DB & " - No Records")
       RESPONSE.FLUSH
    End If
    vRs.Close()
    vConn.Close()
    Set vRs = Nothing
    Set vConn = Nothing

    Set vPage = New WikiPage
    vPage.AddChange
    vPage.Text = "Successfully Archived Site"
    ArchiveHTML = gTransformer.Transform(vPage.ToXML(1))
    Set gTransformer = Nothing
    Set gNamespace = Nothing

End Function


Function TransformEmbedded(pText)
    Dim vPage

    gScriptName = OPENWIKI_SCRIPTNAME
    Set gTransformer = New Transformer
    Set gNamespace = New OpenWikiNamespace
    gAction = "embedded"

    InitLinkPatterns()

    Set vPage = New WikiPage
    vPage.AddChange
    vPage.Text = pText
    TransformEmbedded = gTransformer.Transform(vPage.ToXML(1))
End Function



' As you may notice I never use Request.Query and/or Request.Form, only Request(vSomeParam).
' The reason is that I plan to support platforms where submitted data cannot always go
' through a form, but only through the use of a URL. Another reason is that the presentation
' layer is separated from the logic, therefor no assumption should be made about whether the
' parameters are passed through the URL or posted as a form.
'______________________________________________________________________________________________________________
Sub ParseQueryString()
    gPage = Request("p")
    Dim vPos, vPos2
        If len(OPENWIKI_WELCOMEPAGE)<1 then
           OPENWIKI_WELCOMEPAGE = OPENWIKI_FRONTPAGE
        End if
    If gPage = "" Then
        gPage = Request.ServerVariables("QUERY_STRING")
        vPos = InStr(gPage, "&")
        vPos2 = InStr(gPage, "=")
        If vPos2 <= 0 Or vPos2 > vPos Then
            If vPos > 0 Then
                'Dim vArgs
                'vArgs = Mid(gPage, vPos)
                'Call s(vArgs, "\&(.*?)[^\&]", "&AddParameter($1,$2)", True, True)
                gPage = Left(gPage, vPos - 1)
            Elseif gPage = "" Then
                ' ow.asp?, no parameters passed at all
                gPage = OPENWIKI_WELCOMEPAGE
            Elseif vPos2 > 0 Then
                ' ow.asp?a=login, no page parameter
                      If (( Request("p")="")AND(Request("a")="")) then
                                        gPage=OPENWIKI_WELCOMEPAGE
                                else
                                        gPage = ""   ' gNamespace.Frontpage
                                end if
            End If
        Else
            ' ow.asp?foo=bar, no page posted, rescue to the welcomepage or the frontpage
            gPage = OPENWIKI_WELCOMEPAGE
        End If
    End If


    gPage = URLDecode(gPage)

    ' determine MainPage/SubPage
    vPos = InStr(gPage, "/")
    If vPos = 1 Then
        gPage = OPENWIKI_FRONTPAGE & gPage
    End If

    gRevision = GetIntParameter("revision")

    gAction = Request("a")
    If gAction = "" Then
        gAction = "view"
    End If

    If Request("refresh") <> "" Then
        cCacheXML = False
    End If

    gTxt = Request("txt")

        If cAllowAnyPageName=0 then
                '        // Trap for silly names with spaces and pluses
                gPage=Capitalise(gPage)
                gPage=Replace(gPage," ","") '        // Take out spaces
                gPage=Replace(gPage,"+","") '        // Take out plus signs
                gPage=Replace(gPage,"_","") '        // Take out underscores
        End If

End Sub


Function GetIntParameter(pParam)
    GetIntParameter = Request(pParam)
    If IsNumeric(GetIntParameter) Then
        GetIntParameter = Int(GetIntParameter)
    Else
        GetIntParameter = 0
    End If
End Function

Function LinkifyBookmarks(pBookMarks,pHeading,pXMLNode)
' // Code by Gordon Bamber 20041016
' // Parameters:
' //            pBookMarks = Page1 Page2 Page 3
' //            pHeading = "" or any string
' //            pXMLNode = "bookmarks" or "pagebookmarks"
' // Action:
' // Turns Page1 Page2 etc into <ow:links
' // and wraps them into an <ow:pXMLNode></ow:pXMLNode> pair
    Dim vRegEx, vMatches, vMatch, vValue
    Set vRegEx = New RegExp
    vRegEx.IgnoreCase = False
    vRegEx.Global = True
    vRegEx.Pattern = "\s+([^ ]*)"
    Set vMatches = vRegEx.Execute(" " & Trim(pBookMarks))
    LinkifyBookmarks = ""
    For Each vMatch In vMatches
        vValue = Mid(vMatch.Value, 2)
        LinkifyBookmarks = LinkifyBookmarks & toLinkXML(vValue)
    Next
    If (pHeading <> "") then
        LinkifyBookmarks = "<ow:" & pXMLNode &_
        " heading=""" & pHeading & """>" &_
        LinkifyBookmarks & "</ow:" & pXMLNode & ">"
    else
        LinkifyBookmarks = "<ow:" & pXMLNode  & ">" &_
        LinkifyBookmarks & "</ow:" & pXMLNode & ">"
    End If

    Set vRegEx   = Nothing
    Set vMatches = Nothing
    Set vMatch   = Nothing
End Function

Function LinkifyPageBookmarks(pBookMarks,pHeading,pXMLNode)
' // LinkifyBookmarks - Code by Gordon Bamber 20041016
' // Modified for PageBookmarks by sEi'2005
' // Parameters:
' //            pBookMarks = Page1 Page2 Page 3
' //            pHeading = "" or any string
' //            pXMLNode = "nodename"
' // Action:
' // Turns Page1 Page2 etc into links
' // and wraps them into an <pXMLNode></pXMLNode> pair
    Dim vRegEx, vMatches, vMatch, vValue,strReturn
    Set vRegEx = New RegExp
    vRegEx.IgnoreCase = False
    vRegEx.Global = True
    vRegEx.Pattern = "\s+([^ ]*)"
    Set vMatches = vRegEx.Execute(" " & Trim(pBookMarks))
    strReturn = ""
    For Each vMatch In vMatches
        vValue = Mid(vMatch.Value, 2)
        strReturn = strReturn & toLinkXML(vValue)
    Next
    If (pHeading <> "") then
        strReturn = "<" & pXMLNode & " heading=""" & pHeading & """>" & strReturn & "</" & pXMLNode & ">"
    else
        strReturn = "<" & pXMLNode  & ">" & strReturn & "</" & pXMLNode & ">"
    End If

    LinkifyPageBookmarks = strReturn

    Set vRegEx   = Nothing
    Set vMatches = Nothing
    Set vMatch   = Nothing
End Function

Function getUserPreferences()
'        // Called in owdb (~line 348) in the .ToXML method
' // Modified by Gordon Bamber 20041016
        If gSerialisingInProgress = true then
        '   // Make up a UserPreferences with just the defaults
        '   // No Cookies allowed in Serialise mode!
                getUserPreferences = "<ow:userpreferences>" &_
                "<ow:bookmarksontop/><ow:editlinkontop/><ow:trailontop/>" &_
                "<ow:cols>79</ow:cols>" &_
                "<ow:rows>25</ow:rows>" &_
                "<ow:username>Serialiser</ow:username>" &_
                "<ow:password></ow:password>" &_
                "<ow:userskin>" & OPENWIKI_ACTIVESKIN & "</ow:userskin>"
                getUserPreferences = getUserPreferences & LinkifyBookmarks(gDefaultBookmarks,"","bookmarks")
                getUserPreferences = getUserPreferences & LinkifyBookmarks(gDefaultPageBookmarks,gDefaultPageBookmarksHeading,"pagebookmarks")
                getUserPreferences = getUserPreferences & "</ow:userpreferences>"
                Exit Function
        End If

    Dim vUsername,vUserpassword,vUserSkin
    Dim vCols, vRows, vBookmarks,vPageBookmarks,vPageBookmarksheading

'        // ROWS AND COLUMNS CODE START
    vCols = CInt("0" & Request.Cookies(gCookieHash & "?up")("cols"))
    If vCols = 0 Then
        vCols = 79 '        // Optimum for wysiwyg 580px
    End If
    vRows = CInt("0" & Request.Cookies(gCookieHash & "?up")("rows"))
    If vRows = 0 Then
        vRows = 25
    End If
'        // ROWS AND COLUMNS CODE END

'        // STANDARD BOOKMARKS CODE START
    vBookmarks = Request.Cookies(gCookieHash & "?up")("bm")
    If vBookmarks = ""  Then
        vBookmarks = gDefaultBookmarks
    End If
    vBookmarks = LinkifyBookmarks(vBookmarks,"","bookmarks")
    vPageBookmarks = gDefaultPageBookmarks
    vPageBookmarksheading = gDefaultPageBookmarksHeading
'        // STANDARD BOOKMARKS CODE END

'        // PAGE BOOKMARKS CODE START
    If vPageBookmarks <> "" Then
       vPageBookmarks = LinkifyBookmarks(vPageBookmarks,vPageBookmarksheading,"pagebookmarks")
    End If
'        // PAGE BOOKMARKS CODE END

'        // USER SKIN CODE START
    vUserSkin = Trim(Request.Cookies(gCookieHash & "?up")("ski"))
    if (vUserSkin <> "") then
         gUserSkin=vUserSkin
    else
         gUserSkin=OPENWIKI_ACTIVESKIN
    end If
    vUserSkin="<ow:userskin>" & gUserSkin & "</ow:userskin>"
'        // USER SKIN CODE END

	If Request.Cookies(gCookieHash & "?up") = "" Then
        If cPrettyLinks Then
            getUserPreferences = getUserPreferences & "<ow:prettywikilinks/>"
        End If
        If cExternalOut Then
            getUserPreferences = getUserPreferences & "<ow:opennew/>"
        End If
        If cEmoticons Then
            getUserPreferences = getUserPreferences & "<ow:emoticons/>"
        End If
        getUserPreferences = getUserPreferences & "<ow:bookmarksontop/><ow:editlinkontop/><ow:trailontop/>"
    Else
        If Request.Cookies(gCookieHash & "?up")("pwl") = "1" Then
            getUserPreferences = getUserPreferences & "<ow:prettywikilinks/>"
        End If
        If Request.Cookies(gCookieHash & "?up")("bmt") = "1" Then
            getUserPreferences = getUserPreferences & "<ow:bookmarksontop/>"
        End If
        If Request.Cookies(gCookieHash & "?up")("elt") = "1" Then
            getUserPreferences = getUserPreferences & "<ow:editlinkontop/>"
        End If
        If Request.Cookies(gCookieHash & "?up")("trt") = "1" Then
            getUserPreferences = getUserPreferences & "<ow:trailontop/>"
        End If
        If Request.Cookies(gCookieHash & "?up")("new") = "1" Then
            getUserPreferences = getUserPreferences & "<ow:opennew/>"
        End If
        If Request.Cookies(gCookieHash & "?up")("emo") = "1" Then
            getUserPreferences = getUserPreferences & "<ow:emoticons/>"
        End If
    End If
'	// USER LOGIN//
    vUsername = Request.Cookies(gCookieHash & "?up")("un")
	vUserpassword = Request.Cookies(gCookieHash & "?up")("up")
	If cNTAuthentication = 1 And vUsername = "" Then
        vUsername = GetRemoteUser()
    End If
	If gEditPassword="" then gEditPassword=vUserpassword
    getUserPreferences = "<ow:userpreferences>" _
            & "<ow:cols>" & vCols & "</ow:cols>" _
            & "<ow:rows>" & vRows & "</ow:rows>" _
            & "<ow:username>" & vUsername & "</ow:username>" _
            & "<ow:userpassword>" & vUserPassword & "</ow:userpassword>" _
            & vBookmarks _
            & vPageBookmarks _
            & vUserSkin _
            & getUserPreferences _
            & "</ow:userpreferences>"
'    Response.Cookies("pbm")=""
'    Response.Cookies("pbmh")=""
End Function

Dim gCookieTrail
Sub AddCookieTrail(pPage)
    gCookieTrail.Push pPage
End Sub

Function GetCookieTrail()
If gSerialisingInProgress = true then
   GetCookieTrail = ""
   Exit Function
End If

    Dim vTrailStr, vLast, vCount, vExists, vElem, i
    If cEmbeddedMode=3 then
            Response.Cookies(gCookieHash & "?up").expires  = #01/01/1990#
            Response.Cookies(gCookieHash & "?up") = ""
    End If

    vTrailStr = Request.Cookies(gCookieHash & "?tr")("trail")

    Set gCookieTrail = New Vector
    Call s(vTrailStr, "#(.*?)#", "&AddCookieTrail($1)", False, True)

    vTrailStr = ""
    vExists = False
    vCount = gCookieTrail.Count
    For i = 1 To vCount - 1
        vElem = gCookieTrail.ElementAt(i)
        If vElem = gPage Then
            vExists = True
        Else
            GetCookieTrail = GetCookieTrail & toLinkXML(vElem)
            vTrailStr = vTrailStr & "#" & vElem & "#"
        End If
    Next
    If vExists Or (vCount < OPENWIKI_MAXTRAIL) Then
        If vCount > 0 Then
            vElem = gCookieTrail.ElementAt(0)
            If vElem <> gPage Then
                GetCookieTrail = toLinkXML(vElem) & GetCookieTrail
                vTrailStr = "#" & vElem & "#" & vTrailStr
            End If
        End If
        If gPage <> "" Then
            vElem = gPage
            GetCookieTrail = GetCookieTrail & toLinkXML(vElem)
            vTrailStr = vTrailStr & "#" & vElem & "#"
        End If
    Elseif vCount > 0 Then
        vElem = gPage
        GetCookieTrail = GetCookieTrail & toLinkXML(vElem)
        vTrailStr = vTrailStr & "#" & vElem & "#"
    End If


    Response.Cookies(gCookieHash & "?tr")("trail") = vTrailStr
    Response.Cookies(gCookieHash & "?tr")("last") = gPage

    Set gCookieTrail = Nothing
    GetCookieTrail = "<ow:trail>" & GetCookieTrail & "</ow:trail>"
End Function

Function ToLinkXML(pID)
'        // Added ability so separate anchor links Gordon Bamber 20040912
    Dim vTemp,tAnchor
    If (Instr(pID,"#") > 1) then
                tAnchor=Mid(pId,Instr(pID,"#"))
                tAnchor=Replace(tAnchor," ","_")
                pId=Left(pID,Instr(pID,"#")-1)
        Else
                tAnchor=""
    End If
    If gAction = "print" Then
        vTemp = gScriptName & "?p=" & Server.URLEncode(pID) & "&amp;a=print"
    Else
        vTemp = gScriptName & "?" & Server.URLEncode(pID)
    End If
    ToLinkXML = "<ow:link name='" & CDATAEncode(pID) & "' href='" & vTemp & "'"
    If tAnchor <> "" then
                ToLinkXML = ToLinkXML & " anchor='" & CDATAEncode(tAnchor) & "' "
    End If
    ToLinkXML = ToLinkXML & ">" & PCDATAEncode(PrettyWikiLink(pID)) & "</ow:link>"
End Function


Function GetCookieTrail_Alternative()
    Dim vTrailStr, vLast, vCount, vExists, vElem, i, vPosLast, vStart, vEnd

    vTrailStr = Request.Cookies(gCookieHash & "?tr")("trail")
    vLast     = Request.Cookies(gCookieHash & "?tr")("last")

    Set gCookieTrail = New Vector
    Call s(vTrailStr, "#(.*?)#", "&AddCookieTrail($1)", False, True)

    vExists = False
    vCount = gCookieTrail.Count
    vPosLast = OPENWIKI_MAXTRAIL
    For i = 0 To vCount - 1
        vElem = gCookieTrail.ElementAt(i)
        If vElem = gPage Then
            vExists = True
        End If
        If vElem = vLast Then
            vPosLast = i
        End If
    Next

    If vExists Then
        vStart = 0
        vEnd   = vCount - 1
    Elseif vPosLast < (OPENWIKI_MAXTRAIL - 1) Then
        vStart = 0
        vEnd   = vPosLast
    Else
        vStart = 1
        vEnd   = vCount - 1
    End If

    vTrailStr = ""
    For i = vStart To vEnd
        vElem = gCookieTrail.ElementAt(i)
        GetCookieTrail = GetCookieTrail & "<ow:trailmark name='" & CDATAEncode(vElem) & "'>" & PCDATAEncode(PrettyWikiLink(vElem)) & "</ow:trailmark>"
        vTrailStr = vTrailStr & "#" & vElem & "#"
    Next

    If (Not vExists) And ((vEnd - vStart + 1) < OPENWIKI_MAXTRAIL) Then
        vElem = gPage
        GetCookieTrail = GetCookieTrail & "<ow:trailmark name='" & CDATAEncode(vElem) & "'>" & PCDATAEncode(PrettyWikiLink(vElem)) & "</ow:trailmark>"
        vTrailStr = vTrailStr & "#" & vElem & "#"
        Response.Cookies(gCookieHash & "?tr")("trail") = vTrailStr
    End If

    Response.Cookies(gCookieHash & "?tr")("last") = gPage

    Set gCookieTrail = Nothing
    GetCookieTrail = "<ow:trail>" & GetCookieTrail & "</ow:trail>"
End Function


Private Function Hash(pText)
    Dim i, vCount, vMax
    vMax = 2 ^ 30
    Hash = 0
    vCount = Len(pText)
    For i = 1 To vCount
        If Hash > vMax Then
            Hash = Hash - vMax
            Hash = Hash * 2
            Hash = Hash Or 1
        Else
            Hash = Hash * 2
        End If
        Hash = Hash Xor AscW(Mid(pText, i, 1))
    Next
    If Hash = 0 Then
        Hash = 1
    End If
End Function

'        // Quick & dirty function
'        // Gordon Bamber 20040826
Function Capitalise(pWord)
Dim words,sWord
        pWord=Replace(pword,"_"," ")
        CapitalIse=""
        If Instr(pWord," ") > 0 then
                Words=split(pWord," ")
                For Each sWord in Words
                        If Len(sWord) > 1 then
                                Capitalise = Capitalise & UCase(Left(sWord, 1)) & Mid(sWord, 2) & " "
                        Else
                                Capitalise = Capitalise & UCase(Left(sWord, 1)) & " "
                        End If
                Next
        Else
                Capitalise = UCase(Left(pWord, 1)) & Mid(pWord, 2)
        End If
        Capitalise=Trim(Capitalise)
End Function

'	// Helper functions for StackError class
'	// 20060311 Gordon Bamber
Sub StackError(pLevel,pParam1,pParam2,pParam3)
' // Level 0 = No error
' // Level 1 = Minor
' // Level 2 = Serious
' // Level 3 = Major
' // Level 4 = Fatal
    gErrorStack.ErrorLevel = pLevel
    gErrorStack.ErrorParam1 = pParam1
    gErrorStack.ErrorParam2 = pParam2
    gErrorStack.ErrorParam3 = pParam3
    gErrorStack.PushError
End Sub

Sub ClearErrors
	gErrorStack.ClearErrors
End Sub

Function ShowErrors
	If gErrorStack.IsError then
		ShowErrors=True
		gErrorPageText=gErrorStack.ErrorList
		gAction="view"
		gPage=OPENWIKI_ERRORPAGENAME
		gErrorStack.ClearErrors
		Call ActionView()
	Else
		ShowErrors=False
	End If
End Function

'Vagabond 20060406
Sub ReadCategories
	dim vQuery, nUpperBound, vConn, vRS
	
	Set vConn = Server.CreateObject("ADODB.Connection")
	Set vRS = Server.CreateObject("ADODB.Recordset")
	
	vConn.Open OPENWIKI_DB
	vQuery="SELECT key_categories, categories_name FROM openwiki_categories order by categories_name"
	vRS.Open vQuery, vConn, adOpenForwardOnly

	Do While NOT vRs.EOF
		If NOT vRS.EOF then
			nUpperBound = UBound( gCategoryArray ) + 1
			if nUpperBound = 1 then
				nUpperBound = 2
			end if
			Redim PRESERVE gCategoryArray( nUpperBound )
			gCategoryArray( nUpperBound - 1 ) = vRS("categories_name")
		end if
		vRs.MoveNext
	Loop
	
	vRs.Close()
	vConn.Close()
	
	Set vRs = Nothing
	Set vConn = Nothing
end Sub

%>