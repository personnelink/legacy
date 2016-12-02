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
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owpatterns.asp,v $
'    $Revision: 1.44 $
'      $Author: piixiiees $
'		2 new MyInit...Pattern functions for advanced modifications of the wikify pattern
'    $Revision: 1.44 $
'      $Author: piixiiees $
' ---------------------------------------------------------------------------
'

Sub InitLinkPatterns
    Dim vUpperLetter, vLowerLetter, vAnyLetter, vQDelim, vTemp
    vUpperLetter = "A-Z"
    vLowerLetter = "a-z"
    If cNonEnglish Then
        vUpperLetter = vUpperLetter & "\xc0-\xde"
        vLowerLetter = vLowerLetter & "\xdf-\xff"
    End If
    vAnyLetter = vUpperLetter & vLowerLetter
    If Not cSimpleLinks Then
        vAnyLetter = vAnyLetter & "_0-9"
    End If
    vUpperLetter = "[" & vUpperLetter & "]"
    vLowerLetter = "[" & vLowerLetter & "]"
    vAnyLetter   = "[" & vAnyLetter   & "]"

    vQDelim = "(?:"""")?"     ' Optional quote delimiter (not in output)

    ' Main link pattern: lowercase between uppercase, then anything:
    ' i.e. basic CamelHumpedWordPattern.
    gLinkPattern = vUpperLetter & "+" & vLowerLetter & "+" & vUpperLetter & vAnyLetter & "*"
	gStrictLinkPattern = "^[A-Z]+[a-z0-9|_]+[A-Z]"

    'Vagabond 20060407 
    gLinkPattern = MyInitMainLinkPattern( gLinkPattern, vUpperLetter, vLowerLetter, vAnyLetter ) 

    If cAcronymLinks Then
        ' acronyms: three or more upper case letters
        gLinkPattern = gLinkPattern & "|" & vUpperLetter & "{3,}\b"
    End If

    ' Optional subpage link pattern: uppercase, lowercase, then anything
    If cUseSubpage Then
        gSubpagePattern = "\/" & vUpperLetter & "+" & vLowerLetter & "+" & vAnyLetter & "*"
        ' Loose pattern: If subpage is used, subpage may be simple name

	'Vagabond 20060407
	gSubpagePattern = MyInitSubPagePattern( gSubpagePattern, vUpperLetter, vLowerLetter, vAnyLetter ) 

        gLinkPattern = "(?:(?:(?:(?:" & gLinkPattern & ")|(?:\.))?(?:" & gSubpagePattern & ")+)|" & gLinkPattern & ")"
        ' Strict pattern: both sides must be the main LinkPattern
		if cFreeLinks = 0 then
'			gStrictLinkPattern = "((?:(?:" & gStrictLinkPattern & ")?\/)?" & gStrictLinkPattern & ")"
		end if

    End If
	

	If cTemplateLinking Then
        'main link pattern (gLinkPattern) looks like TemplateName->PageName or just PageName.
        gLinkPattern = "(?:(?:" & gLinkPattern & "\-&gt;" & gLinkPattern & ")|(?:" & gLinkPattern & "))"
    End If

    ' add anchor pattern
    gLinkPattern = "(" & gLinkPattern & "(?:#" & vAnyLetter & "+)?" & ")"

    ' add optional quote delimiter
    gLinkPattern = gLinkPattern & vQDelim

    ' Inter-site convention: sites must start with uppercase letter
    ' (Uppercase letter avoids confusion with URLs)
    gInterSitePattern = vUpperLetter & vAnyLetter & "+"
    gInterLinkPattern = "((?:" & gInterSitePattern & ":[^\]\s\""<>" & gFS & "]+)" & vQDelim & ")"

    If cFreeLinks Then
        ' Note: the - character must be first in vAnyLetter definition
        If cNonEnglish Then
            vAnyLetter = "[-,.()'# _0-9A-Za-z\xc0-\xff]"
        Else
            vAnyLetter = "[-,.()'# _0-9A-Za-z]"
        End If

        If cUseSubpage Then
            gFreeLinkPattern = "((?:" & vAnyLetter & "+)(?:\/" & vAnyLetter & "+)*)"
        Else
            gFreeLinkPattern = "(" & vAnyLetter & "+)"
        End If
        'gFreeLinkPattern = gFreeLinkPattern & vQDelim
    End If


    ' Url-style links are delimited by one of:
    '   1.  Whitespace                           (kept in output)
    '   2.  Left or right angle-bracket (< or >) (kept in output)
    '   3.  Right square-bracket (])             (kept in output)
    '   4.  A single double-quote (")            (kept in output)
    '   5.  A gFS (field separator) character    (kept in output)
    '   6.  A double double-quote ("")           (removed from output)

    gUrlProtocols = "http|https|ftp|afs|news|nntp|mid|cid|mailto|wais|" &_
    "prospero|telnet|gopher|sharedimage|irc|sharedimageright|sharedimageleft|image|imageleft|" &_
    "imageright|imagecenter|callto|ms-help|waste|skype"


    If cNetworkFile Then
        gUrlProtocols = gUrlProtocols & "|outlook|file"
    End If
    If cAllowAttachments Then
        gUrlProtocols = gUrlProtocols & "|attachment"
    End If
    gUrlPattern       = "((?:(?:" & gUrlProtocols & "):[^\]\s\""<>" & gFS & "]+)" & vQDelim & ")"
    gMailPattern      = "([-\w._+]+\@[\w.-]+\.[\w.-]+\w)"
    gImageExtensions  = "gif|jpg|png|bmp|jpeg"
    gImagePattern     = "^(http:|https:|ftp:|" & OPENWIKI_IMAGELIBRARY  & ").+\.(" & gImageExtensions & ")$"
    gDocExtensions    = gImageExtensions & "|doc|htm|html|xsl|xml|ps|txt|zip|gz|mov|avi|mpeg|mpg|mp3|pdf|ppt|chm|kml|kmz"
    gISBNPattern      = "ISBN:?([0-9- xX]{10,})"
    gHeaderPattern    = "(\=+)[ \t]+(.*?)[ \t]+\=+([ \t]*\r?\n)?"

    ' see comments in owattach.asp
    gNotAcceptedExtensions = "asp|cdx|asa|htr|idc|shtm|shtml|stm|printer|php|pl|plx|py"  ' default app mappings using W2000
    gNotAcceptedExtensions = gNotAcceptedExtensions & "|asax|ascx|ashx|asmx|aspx|axd|vsdisco|rem|soap|config|cs|csproj|vb|vbproj|webinfo|licx|resx|resources"  ' dotnet extensions

    gTimestampPattern = "(\d{4})-(\d{2})-(\d{2})(?:T(\d{2}):(\d{2}):(\d{2})(?:([+|-])(0\d|1[0-2]):([0-5]\d))?)?"

    If cEmbeddedMode <> 0 Then
        gMacros = "BR|TableOfContents|Anchor|Date|Time|DateTime|Footnote"
    Else
        If gSerialisingInProgress = true then
                gMacros = "BR|RecentChanges|RecentChangesLong|"
                gMacros = gMacros & "TableOfContents|TitleIndex|"
                gMacros = gMacros & "InterWiki|SystemInfo|Include|"
                gMacros = gMacros & "PageCount|Image|Icon|Anchor|"
                gMacros = gMacros & "PageHits|ResetPageHits|AllPageHits|ResetAllPageHits|MostPopularPage|TitleHitIndex|"
                gMacros = gMacros & "Date|Time|DateTime|Footnote|ShowPlugins|"
                gMacros = gMacros & "Month|RefererList|RecentChangesSearch|"
                gMacros = gMacros & "Glossary|Abbr|Acronym|PageChanged|CategoryIndex|"
                gMacros = gMacros & "BadLinkList|ShowLinks|ShowMacroList|MacroHelp|ProgressBar|ActiveSkin|"
                gMacros = gMacros & "AddBookmarks|IncludeOpenWikiPage|ImageList|IconList|ListEmoticons"
        Else
                ' override this in mymacros.asp or mywifify.asp if you want
                gMacros = "BR|RecentChanges|RecentChangesLong|TitleSearch|CategorySearch|"
                gMacros = gMacros & "FullSearch|TextSearch|TableOfContents|WordIndex|TitleIndex|GoTo|RandomPage|"
                gMacros = gMacros & "InterWiki|SystemInfo|Include|"
                gMacros = gMacros & "PageCount|UserPreferences|Image|Icon|Anchor|"
                gMacros = gMacros & "PageHits|ResetPageHits|AllPageHits|ResetAllPageHits|MostPopularPage|TitleHitIndex|"
                gMacros = gMacros & "Date|Time|DateTime|Syndicate|Aggregate|Footnote|ShowPlugins|"
                gMacros = gMacros & "UserName|IP|Month|RefererList|RecentChangesSearch|"
                gMacros = gMacros & "Referer|BackLink|Glossary|Abbr|Acronym|PageChanged|CreatePage|CategoryIndex|"
                gMacros = gMacros & "BadLinkList|ShowLinks|ShowMacroList|MacroHelp|ProgressBar|ActiveSkin|"
                gMacros = gMacros & "AddBookmarks|Badge|IncludeOpenWikiPage|ImageList|IconList|ListEmoticons|Highlight|"
                gMacros = gMacros & "RedirectPage|WebFrame|CreateHomePage|CreateSubPage|SummarySearch|Uploadimage|ShowSharedImages|TagSearch"
        end if
    End If
    vTemp = PlugMacroPatterns() ' // Service to plugins (owpluginfunnel.asp)
    if len(vTemp)>0 then
        gMacros = gMacros & "|" & vTemp
    end if
    vTemp = MyMacroPatterns()
    gMacros = gMacros & "|" & vTemp
    MyInitLinkPatterns()
	gMacros = gMacros & "|TagsIndex" '========added by 1mmm

End Sub
%>