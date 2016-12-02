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
'        Checkin Log: $Log: owwikify.asp,v $
'        Checkin Log: Revision 1.67  2007/01/07 11:24:40  piixiiees
'        Checkin Log: gFS=Chr(222) due to problems working with Chr(179) in utf-8 and some files saved with encoding="utf-8"
'        Checkin Log:
'        Checkin Log: Revision 1.66  2006/08/10 09:34:46  piixiiees
'        Checkin Log: New format enhacement to pre-define table styles with dedicated classes in ow.css sheet.
'        Checkin Log: Reference: http://www.openwiking.com/devwiki/ow.asp?PiixiieesNamepage/Devs/FormatEnhacementNewStyleTables
'        Checkin Log:
'        Checkin Log: Revision 1.65  2006/03/19 23:00:41  piixiiees
'        Checkin Log: New option cUseInterWikiIcons to use icons for interwiki links:
'        Checkin Log:  * cUseInterWikiIcons=0 Help:HelpEditing
'        Checkin Log:  * cUseInterWikiIcons=1 ? HelpEditing (where ? is a small icon)
'        Checkin Log: Style for thumbs of ShowSharedImages splitted from ow.css. Now thumbs.css is available for evolution skin
'        Checkin Log:
'        Checkin Log: Revision 1.64  2006/03/13 20:48:15  piixiiees
'        Checkin Log: Point update 20060304.2
'        Checkin Log: owwikify.asp
'        Checkin Log: New folder images in every skin. All the icons will be retrieved from the skin folder.
'        Checkin Log: Change to use the link icons from this folder.
'        Checkin Log: vLink = vLink & "<img src=""" & GetSkinDir() & "/images" & vImg & " border=""0"" hspace=""2"" alt=""""/>"
'        Checkin Log:
'        Checkin Log: New macro ShowSharedImages to show all the files in the folder of shared images.
'        Checkin Log: New styles included in ow.css files.
'        Checkin Log:
'        Checkin Log: Revision 1.63  2006/02/16 18:33:16  gbamber
'        Checkin Log: General update:
'        Checkin Log: Rename improved
'        Checkin Log: local: now sharedimage:
'        Checkin Log: New imageupload macro
'        Checkin Log: added file uploadimage.asp
'        Checkin Log: changed owall to fix #includes with attach.asp
'        Checkin Log: new doctypes for google earth
'        Checkin Log: new urltype skype
'        Checkin Log: Userprefs has a password field
'        Checkin Log: Reaname template updated
'        Checkin Log:
'        Checkin Log: Revision 1.62  2006/01/09 10:56:41  gbamber
'        Checkin Log: Added #ALLOWVIEW
'        Checkin Log:
'        Checkin Log: Revision 1.61  2005/12/14 20:39:57  gbamber
'        Checkin Log: BugFix:Updated hardcoded 'Help' link in editing window
'        Checkin Log: BugFix:Updated gStrictLinkPattern to include underscores
'        Checkin Log: BugFix:Changed scope of userprefs cookie
'        Checkin Log: New:Action UpgradeFreelinks
'        Checkin Log: New:Added Maintainance link to admin control panel
'        Checkin Log: New:Added parameter to SuccessfulAction page
'        Checkin Log: New:owdb function to upgrade freelink pages
'        Checkin Log:
'        Checkin Log: Revision 1.60  2005/12/10 08:38:08  gbamber
'        Checkin Log: BUILD 20051210
'        Checkin Log: New: <RedirectPage>
'        Checkin Log: New <CreateSubPage>
'        Checkin Log: BugFix: CreatePage macro code
'        Checkin Log: BugFix: Userprefs back link
'        Checkin Log: BugFix: CAPTCHA now works
'        Checkin Log: BugFic: cUseFreeLinks=0 option works correctly
'        Checkin Log: BugFix: Page rename partly repaired
'        Checkin Log: BugFix: forceusername uses persistent cookie
'        Checkin Log: //Gordon//
'        Checkin Log:
'        Checkin Log: Revision 1.59  2005/02/11 11:38:53  gbamber
'        Checkin Log: Build 20050211
'        Checkin Log: Added:
'        Checkin Log: cShowOldEmoticons     = 1        ' 1 = Include OpenWiki0.78 syntax, 0 = Ignore old syntax
'        Checkin Log: cTitleIndexIgnoreCase = 0        ' 1 = Ignore case when compiling the Title Index, 0 = Differenciate LC and UC
'        Checkin Log:
'        Checkin Log: Revision 1.58  2004/11/07 15:07:25  gbamber
'        Checkin Log: Added: cWikifyPageHeadings=1|0
'        Checkin Log: Updated: Coloured text
'        Checkin Log: Updated: UpdateDB functions
'        Checkin Log: Added: default_css skin
'        Checkin Log: Updated: Myrthful skin
'        Checkin Log:
'        Checkin Log: Revision 1.57  2004/11/03 16:59:05  gbamber
'        Checkin Log: Added: new version of myrthful skin
'        Checkin Log: Bugfix: Nested positions.  <position[ ]> changed to <positionrel( )>
'        Checkin Log:
'        Checkin Log: Revision 1.56  2004/11/03 10:33:28  gbamber
'        Checkin Log: BugFix: TextSearch
'        Checkin Log: BugFix: <position>
'        Checkin Log:
'        Checkin Log: Revision 1.55  2004/10/30 20:42:50  gbamber
'        Checkin Log: Added gWikiAdministrator="Wikiadmin"
'        Checkin Log: Added 'Delete this page' if using admin name and local IP
'        Checkin Log: Changed FetchUsername function to owdb.asp
'        Checkin Log: Added auto-success page
'        Checkin Log:
'        Checkin Log: Revision 1.54  2004/10/30 13:06:52  gbamber
'        Checkin Log: BugFixes
'        Checkin Log: 1 ) @tokens can now be escaped using syntax ~@token  {{{@token}}} removed.
'        Checkin Log: 2 ) Macro names now automatically added to StopWords list (if enabled)
'        Checkin Log: 3 ) <CreatePage> macro now defaults to current page as template
'        Checkin Log: 4 ) New option cSortCategories=1|0
'        Checkin Log:
'        Checkin Log: Revision 1.53  2004/10/27 09:49:42  gbamber
'        Checkin Log: Round-up of small changes and bugfixes
'        Checkin Log:
'        Checkin Log: Revision 1.52  2004/10/20 18:30:28  gbamber
'        Checkin Log: RenamePage now does entire SubPage trees
'        Checkin Log: Some formatting improvements in owwikify
'        Checkin Log:
'        Checkin Log: Revision 1.51  2004/10/19 12:35:14  gbamber
'        Checkin Log: Massive serialising update.
'        Checkin Log:
'        Checkin Log: Revision 1.50  2004/10/13 12:17:22  gbamber
'        Checkin Log: Forced updates to make sure CVS reflects current work
'        Checkin Log:
'        Checkin Log: Revision 1.49  2004/10/10 22:47:42  gbamber
'        Checkin Log: Massive update!
'        Checkin Log: Added: Summaries
'        Checkin Log: Added: Default pages built-in
'        Checkin Log: Added: Auto-update from openwiki classic
'        Checkin Log: Modified: Default plugin status
'        Checkin Log: Modified: Default Page Names
'        Checkin Log: Modified: Default MSAccess DB to openwikidist.mdb
'        Checkin Log: BugFix: Many MSAccess bugs fixed
'        Checkin Log: Modified: plastic skin to show Summary
'        Checkin Log:
'        Checkin Log: Revision 1.48  2004/10/09 22:38:41  gbamber
'        Checkin Log: BugFix:: <position>  top,left now in the right order!
'        Checkin Log: ADDED: <position(top%,left%)>
'        Checkin Log:
'        Checkin Log: Revision 1.47  2004/10/09 20:00:42  gbamber
'        Checkin Log: Added: macro <position>
'        Checkin Log: '        // SYNTAX 1 (absolute): <position(top,left,width,height,z-order)>Text</position>
'        Checkin Log: '        // SYNTAX 2 (relative): <position[top,left,width,height,z-order]>Text</position>
'        Checkin Log: '        // SYNTAX 2 (absolute): <position(top,left,width,height)>Text</position>
'        Checkin Log: '        // SYNTAX 3 (relative): <position[top,left,width,height]>Text</position>
'        Checkin Log: '        // SYNTAX 4 (absolute) <position(top,left)>Text</position>
'        Checkin Log: '        // SYNTAX 5 (relative) <position[top,left]>Text</position>
'        Checkin Log: '        // SYNTAX 6 (error message) <position>
'        Checkin Log:
'        Checkin Log: Revision 1.46  2004/10/09 10:04:52  gbamber
'        Checkin Log: Added:
'        Checkin Log: 1)  preformatted smileys
'        Checkin Log: 2) <style(stylestatement)>Some Text</style>
'        Checkin Log:
'        Checkin Log: Revision 1.45  2004/10/07 14:27:30  gbamber
'        Checkin Log: Added
'        Checkin Log: cUseMultipleParents = 1|0 (default=1)
'        Checkin Log: and ServerDown = 1|0 (default=0)
'        Checkin Log:
'        Checkin Log: Revision 1.44  2004/10/03 10:49:14  gbamber
'        Checkin Log: BugFix: @ tokens now work with https://
'        Checkin Log:
'        Checkin Log: Revision 1.43  2004/10/01 22:39:58  gbamber
'        Checkin Log: BugFix: Fixed regex expression in <class(stylename)>text</class> markup.
'        Checkin Log:
'        Checkin Log: Revision 1.42  2004/10/01 09:45:45  gbamber
'        Checkin Log: BugFix: AbsoluteName
'        Checkin Log:
'        Checkin Log: Revision 1.41  2004/09/22 10:17:24  gbamber
'        Checkin Log: Added parameter to <TableOfContents> macro
'        Checkin Log:
'        Checkin Log: Revision 1.40  2004/09/14 11:31:46  gbamber
'        Checkin Log: Improved emoticon code.  Added <ListEmoticons> macro
'        Checkin Log:
'        Checkin Log: Revision 1.39  2004/09/11 09:35:37  gbamber
'        Checkin Log: Various minor bugfixes
'        Checkin Log:
'        Checkin Log: Revision 1.38  2004/09/10 10:01:33  gbamber
'        Checkin Log: Added @grandparent and @greatgrandparent
'        Checkin Log:
'        Checkin Log: Revision 1.37  2004/09/01 07:01:06  gbamber
'        Checkin Log: Bugfix for horizontal lines and strikethrough
'        Checkin Log:
'        Checkin Log: Revision 1.36  2004/08/31 11:39:08  gbamber
'        Checkin Log: '        // USER-DEFINED FORMATTING
'        Checkin Log: '        // Gordon Bamber 20040831
'        Checkin Log: '        // Syntax 1: <class(classname)>Some text</class> = span
'        Checkin Log: '        // Syntax 2: <class[classname]>Some text</class> = div
'        Checkin Log:
'        Checkin Log: Revision 1.35  2004/08/26 13:02:34  gbamber
'        Checkin Log: Added extra @this directives
'        Checkin Log:
'        Checkin Log: Revision 1.34  2004/08/26 08:30:55  gbamber
'        Checkin Log: This paragraph _
'        Checkin Log: will display _
'        Checkin Log: on three lines.
'        Checkin Log:
'        Checkin Log: This paragraph +
'        Checkin Log: will display +
'        Checkin Log: on one line
'        Checkin Log:
'        Checkin Log: Revision 1.33  2004/08/24 22:09:16  gbamber
'        Checkin Log: Coloured horizontal lines added:
'        Checkin Log: ---R- = Red line
'        Checkin Log: ---G- = Green line
'        Checkin Log: ---B- = Blue line
'        Checkin Log: ---#c0c0c0- = grey line
'        Checkin Log:
'        Checkin Log: Revision 1.32  2004/08/23 18:37:21  gbamber
'        Checkin Log: Added :LOL emoticon
'        Checkin Log:
'        Checkin Log: Revision 1.31  2004/08/19 11:40:23  gbamber
'        Checkin Log: Bugfix:  Changed syntax2 for paragraph alignment
'        Checkin Log:
'        Checkin Log: Revision 1.30  2004/08/19 11:24:56  gbamber
'        Checkin Log: Added syntax for externally-referenced images:
'        Checkin Log: image:, imageleft:, imageright:, imagecenter:
'        Checkin Log:
'        Checkin Log: Revision 1.29  2004/08/19 09:31:05  gbamber
'        Checkin Log: Paragraph Alignment:
'        Checkin Log: 1) Placed code earlier in wikify
'        Checkin Log: 2) Alternative syntax in place
'        Checkin Log:
'        Checkin Log: Revision 1.28  2004/08/17 00:11:14  carlthewebmaste
'        Checkin Log: Changes for new Image Library Upload.  Permits uploads to OPENWIKI_IMAGELIBRARY if cAllowImageLibrary = 1.
'        Checkin Log:
'        Checkin Log: Note old OPENWIKI_IMAGEUPLOADDIR var renamed to OPENWIKI_IMAGELIBRARY.
'        Checkin Log:
'        Checkin Log: Revision 1.27  2004/08/16 17:29:08  gbamber
'        Checkin Log: @parent token in a subpage is replaced by the parent page name.  Works alongside @this directive
'        Checkin Log:
'        Checkin Log: Revision 1.26  2004/08/13 12:45:55  gbamber
'        Checkin Log: Added local image syntax:
'        Checkin Log: local: localleft: localright:
'        Checkin Log: OPENWIKI_IMAGELIBRARY defined in owconfig_default
'        Checkin Log:
'        Checkin Log: Revision 1.25  2004/08/12 12:46:22  gbamber
'        Checkin Log: Added Synonym Links
'        Checkin Log:
'        Checkin Log: Revision 1.24  2004/08/11 22:21:13  gbamber
'        Checkin Log: Added the @this macro/directive.
'        Checkin Log: The string '@this' is replaced by the name of the current page
'        Checkin Log:
'        Checkin Log: Revision 1.23  2004/07/25 18:35:23  oddible
'        Checkin Log: New Tables - Fixed Old Table within a new table.
'        Checkin Log:
'        Checkin Log: Revision 1.17  2004/07/17 15:37:50  gbamber
'        Checkin Log: BanLinkList plugin added
'        Checkin Log:
'        Checkin Log: Revision 1.16  2004/07/16 11:05:41  gbamber
'        Checkin Log: ><( This paragraph is **centered**. )
'        Checkin Log:
'        Checkin Log: <-( This paragraph is **left-aligned**. )
'        Checkin Log:
'        Checkin Log: ->( This paragraph is **right-aligned**. )
'        Checkin Log:
'        Checkin Log: <>( This paragraph is **justified**. )
'        Checkin Log:
'        Checkin Log: Revision 1.15  2004/07/15 05:03:14  oddible
'        Checkin Log: New Table Syntax - Simple
'        Checkin Log:
'        Checkin Log: Revision 1.14  2004/07/01 10:04:45  gbamber
'        Checkin Log: Keyword added
'        Checkin Log:
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owwikify.asp,v $
'    $Revision: 1.67 $
'      $Author: piixiiees $
' ---------------------------------------------------------------------------
'

'______________________________________________________________________________________________________________

Function Wikify(pText)
On Error Goto 0
    Dim vText
    vText = pText

    gIncludingAsTemplate = False
    If gIncludeLevel = 0 Then
        Set gRaw            = New Vector
        Set gBracketIndices = New Vector
        Set gTOC            = New TableOfContents
        If gAction <> "edit" And Not cEmbeddedMode Then
                    If Left(vText, 1) = "#" Then
                        WikifyAllowedEdit pText,vText ' PLUGIN
                        WikifyAllowedView pText,vText ' PLUGIN
                        If m(vText, "^#RANDOMPAGE", False, False) Then
                                    ActionRandomPage()
                        Elseif m(vText, "^#REDIRECT\s+", False, False) And Request("redirect") = "" Then
                                    gTemp = InStr(10, vText, vbCR)
                                    If gTemp > 0 Then
                                        gTemp = Trim(Mid(vText, 10, gTemp - 10))
                                    Else
                                        gTemp = Trim(Mid(vText, 10))
                                    End If
                                    Response.Redirect(gScriptName & "?a=" & gAction & "&p=" & Server.URLEncode(gTemp) & "&redirect=" & Server.URLEncode(FreeToNormal(gPage)))
                        Elseif m(vText, "^#INCLUDE_AS_TEMPLATE", False, False) Then
                                    vText = Mid(vText, 21)
                        Elseif m(vText, "^#MINOREDIT", False, False) Then
                                    vText = Mid(vText, 11)
                        Elseif m(vText, "^#DEPRECATED", False, False) Then
                                    StoreRaw("#DEPRECATED")
                                    vText = sReturn & Mid(vText, 12)
                        End If
                        vText = MyWikifyProcessingInstructions(vText)
                End If
        End If
    Else
        If gAction <> "edit" And Not cEmbeddedMode Then
            If Left(vText, 1) = "#" Then
                If m(vText, "^#INCLUDE_AS_TEMPLATE", False, False) Then
                    vText = Mid(vText, 21)
                    gIncludingAsTemplate = True
                End If
            End If
        End If
    End If

    vText = MultiLineMarkup(vText)  ' Multi-line markup

    vText = WikiLinesToHtml(vText)  ' Line-oriented markup
    
    'Response.Write "<br />Text3: <pre>" & vText & "</pre>"
    

    vText = s(vText, gFS & "(\d+)" & gFS, "&GetRaw($1)", False, True)  ' Restore saved text
    vText = s(vText, gFS & "(\d+)" & gFS, "&GetRaw($1)", False, True)  ' Restore nested saved text

    If gIncludeLevel = 0 Then
        If cUseHeadings Then
                        If (Instr(vText,gFS & "TOC1" & gFS) > 0) then
                                vText=Replace(vText,gFS & "TOC1" & gFS,gFS & "TOC" & gFS)
                                Dim tText,sText
                                sText=Left(vText,Instr(vText,gFS & "TOC" & gFS)-1) '        // Pre TOC
                                tText=Mid(vText,Instr(vText,gFS & "TOC" & gFS)) '        // TOC and after

                                tText = s(tText, gFS & "(\=+)[ \t]+(.*?)[ \t]+\=+ " & gFS, "&GetWikiHeading($1, $2)", False, True)
                                tText = Replace(tText, gFS & "TOC" & gFS, gTOC.GetTOC)

                                sText = s(sText, gFS & "(\=+)[ \t]+(.*?)[ \t]+\=+ " & gFS, "&GetWikiHeading($1, $2)", False, True)
                                vText=sText + tText
                        else
                                vText = s(vText, gFS & "(\=+)[ \t]+(.*?)[ \t]+\=+ " & gFS, "&GetWikiHeading($1, $2)", False, True)
                                vText = Replace(vText, gFS & "TOC" & gFS, gTOC.GetTOC)
                        end if
        End If

        If InStr(gMacros, "Footnote") > 0 Then
            vText = InsertFootnotes(vText)
        End If

        vText = MyLastMinuteChanges(vText)
        Set gRaw            = Nothing
        Set gBracketIndices = Nothing
        Set gTOC            = Nothing
    End If

    Wikify = vText
End Function


'______________________________________________________________________________________________________________
'/// <summary> PiiXiieeS
'/// SendSMSMessage sends a text message to a valid mobile number
'/// </summary>
'/// <param name="pText">String with the wiki formated text</param>
'/// <returns>String with the xhtml format of the wiki page</returns>
Function MultiLineMarkup(pText)
Dim p,tPage

    pText = Replace(pText & "", Chr(9), Space(8))
    'pText = Replace(pText, gFS, "")    ' remove separators

    If cRawHtml Then
        pText = s(pText, "<html>([\s\S]*?)<\/html>", "&StoreHtml($1)", True, True)
    End If
    If cMathML Then
        pText = s(pText, "<math>([\s\S]*?)<\/math>", "&StoreMathML($1)", True, True)
    End If

    pText = MyMultiLineMarkupStart(pText)


'       //*** THE @this DIRECTIVES START ***//
'                // Inline tokens: @this,@username,@serverroot,@date,@time,@parent
'                // Inline directives: @editthis,@printthis,@historythis,@attachmentthis,@xmlthis,@printthis
'       // Gordon Bamber 20041007
'       // precede a token with ~ to avoid autolinking: ~@this, ~@parent, ~@parent/~@parent for example
'                // Also {{{also @this is not autolinked}}} <code>also @this is not autolinked</code>
         pText = s(pText, "~(@\S+)", "&StoreRaw(""<tt>"" & $1 & ""</tt>"")", True, True)
         pText = s(pText, "\{\{\{(.*?@\S+.*?)\}\}\}", "&StoreRaw(""<tt>"" & $1 & ""</tt>"")", True, True)
         pText = s(pText, "\<code\>(.*?@\S+.*?)\<\/code\>", "&StoreRaw(""<tt>"" & $1 & ""</tt>"")", True, True)

'                // First do the formatted versions //
        pText = Replace(pText,"@editlink","[" & gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=edit edit]",1,-1,1)
        pText = Replace(pText,"@historylink","[" & gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=changes history]",1,-1,1)
        pText = Replace(pText,"@attachmentlink","[" & gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=attach attachment]",1,-1,1)
        pText = Replace(pText,"@xmllink","[" & gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=xml&revision=" & gRevision & " xml]",1,-1,1)
        pText = Replace(pText,"@printlink","[" & gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=print&revision=" & gRevision & " print]",1,-1,1)
'                // (the global gServerRoot is initialised in owprocessor.asp)

'                // Then the unformatted versions //
        pText = Replace(pText,"@editthis",gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=edit",1,-1,1)
        pText = Replace(pText,"@historythis",gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=changes",1,-1,1)
        pText = Replace(pText,"@attachmentthis",gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=attach",1,-1,1)
        pText = Replace(pText,"@xmlthis",gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=xml&revision=" & gRevision & "",1,-1,1)
        pText = Replace(pText,"@printthis",gServerRoot & OPENWIKI_SCRIPTNAME & "?p=" & gPage & "&a=print&revision=" & gRevision & "",1,-1,1)

'       // Gordon Bamber 20041007
'       // all the rest of the @tokens are done here
        pText = ReplacePageTokens(pText,gPage) '        // This function is also used by macro code
'        // *** THE @this DIRECTIVES END ***//

    pText = QuoteXml(pText)

    If cRawHtml Then
        ' transform our field separator back
        pText = Replace(pText, "&#179;", gFS)
    End If

    pText = s(pText, " \\ *\r?\n", " ", False, True)  ' Join lines with backslash at end



    ' The <nowiki> tag stores text with no markup (except quoting HTML)
    pText = s(pText, "\&lt;nowiki\&gt;([\s\S]*?)\&lt;\/nowiki\&gt;", "&StoreRaw($1)", True, True)
    ' <code></code> and {{{ }}} do the same thing.
    pText = s(pText, "\{\{\{(.*?)\}\}\}", "&StoreRaw(""<tt>"" & $1 & ""</tt>"")", True, True)
    pText = s(pText, "\&lt;code\&gt;(.*?)\&lt;\/code\&gt;", "&StoreRaw(""<tt>"" & $1 & ""</tt>"")", True, True)
    pText = s(pText, "\{\{\{([\s\S]*?)\}\}\}", "&StoreCode($1)", True, True)
    pText = s(pText, "\&lt;code\&gt;([\s\S]*?)\&lt;\/code\&gt;", "&StoreCode($1)", True, True)
    pText = s(pText, "\&lt;pre\&gt;([\s\S]*?)\&lt;\/pre\&gt;", "<pre>$1</pre>", True, True)

'        // SYNTAX 1 (absolute): <position(top,left,width,height,z-order)>Text</position>
'        // SYNTAX 2 (relative): <positionrel(top,left,width,height,z-order)>Text</positionrel>
'        // SYNTAX 2 (absolute): <position(top,left,width,height)>Text</position>
'        // SYNTAX 3 (relative): <positionrel(top,left,width,height)>Text</positionrel>
'        // SYNTAX 4 (absolute) <position(top,left)>Text</position>
'        // SYNTAX 5 (relative) <positionrel(top,left)>Text</positionrel>


   pText = s(pText, "\&lt;position\((\d+)\,(\d+)\,(\d+)\,(\d+),(\d+)\)\&gt;([\s\S]+?)\&lt;\/position\&gt;", "<div style=""position:absolute; top:$1px; left:$2px; width:$3px; height:$4px; z-index:$5"">$6</div>", false, True)
   pText = s(pText, "\&lt;position\(([-\d|\d]+)\,([-\d|\d]+)\,(\d+)\,(\d+)\)\&gt;([\s\S]+?)\&lt;\/position\&gt;", "<div style=""position:absolute; top: $1px; left:$2px; width: $3px; height: $4px; z-index: 10"">$5</div>", false, True)
   pText = s(pText, "\&lt;position\((\d+)\,(\d+)\)\&gt;([\s\S]+?)\&lt;\/position\&gt;", "<div style=""position:absolute; top: $1px; left:$2px; z-index:10"">$3</div>", true, true)
'        // SYNTAX 7 (absolute) <position(top%,left%)>Text</position>
   pText = s(pText, "\&lt;position\((\d+)\%\,(\d+)\%\)\&gt;([\s\S]+?)\&lt;\/position\&gt;", "<div style=""position:absolute; top: $1%; left:$2%; z-index:10"">$3</div>", true, true)

   pText = s(pText, "\&lt;positionrel\((\d+)\,(\d+)\,(\d+)\,(\d+),(\d+)\)\&gt;([\s\S]+?)\&lt;\/positionrel\&gt;", "<span style=""position:relative; top: $1px; left:$2px; width:$3px; height:$4px; z-index: $5"">$6</span>", false, True)
   pText = s(pText, "\&lt;positionrel\(([-\d|\d]+)\,([-\d|\d]+)\,(\d+)\,(\d+)\)\&gt;([\s\S]+?)\&lt;\/positionrel\&gt;", "<span style=""position:relative; top: $1px; left:$2px; width: $3px; height: $4px; z-index: 10"">$5</span>", false, True)
   pText = s(pText, "\&lt;positionrel\(([-\d|\d]+)\,([-\d|\d]+)\)\&gt;([\s\S]+?)\&lt;\/positionrel\&gt;", "<span style=""position:relative; top: $1px; left:$2px; z-index:10"">$3</span>", true, true)

'        // SYNTAX 6 (error message) <position>
   pText = s(pText, "\&lt;position\&gt;", "<ow:error>This tag needs at least 2-5 parameters - (top,left[,width][,height][,z-order])</ow:error>", false, true)

'        // Gordon Bamber 20040826
'        // This paragraph _
'        // will display _
'        // on three lines.
    pText = Replace(pText," _" & VBCR,"<br />")

'        // This paragraph +
'        // will display +
'        // on one line
    pText = Replace(pText," +" & VBCR,"")
'        // Gordon Bamber 20040826

    If cHtmlTags Then
        ' Scripting is currently possible with these tags, so they are *not* particularly "safe".
        Dim vTag
        For Each vTag In Split("b,i,u,font,big,small,sub,sup,h1,h2,h3,h4,h5,h6,cite,code,em,s,strike,strong,tt,var,div,center,blockquote,ol,ul,dl,table,caption,br,p,hr,li,dt,dd,tr,td,th,iframe", ",")
            pText = s(pText, "\&lt;" & vTag & "(\s[^<>]+?)?\&gt;([\s\S]*?)\&lt;\/" & vTag & "\&gt;", "<" & vTag & "$1>$2</" & vTag & ">", True, True)
        Next
        For Each vTag In Split("br,p,hr,li,dt,dd,tr,td,th", ",")
            pText = s(pText, "\&lt;" & vTag & "(\s[^<>]+?)?\&gt;", "<" & vTag & "$1 />", True, True)
        Next
    End If


    If cHtmlLinks Then
        pText = s(pText, "\&lt;a\s([^<>]+?)\&gt;([\s\S]*?)\&lt;\/a\&gt;", "&StoreHref($1, $2)", True, True)
    End If

    If IsObject(gAggregateURLs) Then
        ' we are in the process of refreshing RSS feeds
        If m(gMacros, "Include", True, True) Then
            pText = s(pText, "\&lt;(Include)(\(.*?\))?(?:\s*\/)?\&gt;", "&ExecMacro($1, $2)", True, True)
        End If
        pText = s(pText, "\&lt;(Syndicate)(\(.*?\))?(?:\s*\/)?\&gt;", "&ExecMacro($1, $2)", True, True)
        MultiLineMarkup = pText
        Exit Function
    End If

    ' process macro's
    pText = s(pText, "\&lt;(" & gMacros & ")(\(.*?\))?(?:\s*\/)?\&gt;", "&ExecMacro($1, $2)", True, True)

    If cFreeLinks Then
        pText = s(pText, "\[\[" & gFreeLinkPattern & "(?:\|([^\]]+))*\]\]", "&StoreFreeLink($1, $2)", False, True)
    End If

    ' Links like [URL] and [URL text of link]
    pText = s(pText, "\[" & gUrlPattern & "(\s+[^\]]+)*\]", "&StoreBracketUrl($1, $2)", False, True)
    pText = s(pText, "\[" & gInterLinkPattern & "(\s+[^\]]+)*\]", "&StoreInterPage($1, $2, True)", False, True)
    pText = s(pText, "\[" & gISBNPattern & "([^\]]+)*\]", "&StoreISBN($1, $2, True)", False, True)


'        ********************************************************************************************************
'   //        Aligned paragraphs
'        //        SYNTAX 1:
'        >=<This paragraph is **centered**.>=<
'        <=This paragraph is **left-aligned**.<=
'        =>This paragraph is **right-aligned**=>
'        Note: No justified paragraph syntax
        pText = s(pText, "\&gt;=\&lt;([\s\S]*?)\&gt;=\&lt;", "<div style='text-align: center;'>$1</div>", False, True)
        pText = s(pText, "\&lt;=([\s\S]*?)\&lt;=", "<div style='text-align: left;'>$1</div>", False, True)
        pText = s(pText, "=\&gt;([\s\S]*?)=\&gt;", "<div style='text-align: right;'>$1</div>", False, True)
'        ********************************************************************************************************
'        //        SYNTAX 2:
'        ><( This paragraph is **centered**./)
'        <-( This paragraph is **left-aligned**./)
'        ->( This paragraph is **right-aligned**./)
'        <>( This paragraph is **justified**./)
        pText = s(pText, "\&gt;\&lt;\(([\s\S]*?)/\)", "<div style='text-align: center;'>$1</div>", False, True)
        pText = s(pText, "\&lt;-\(([\s\S]*?)/\)", "<div style='text-align: left;'>$1</div>", False, True)
        pText = s(pText, "-\&gt;\(([\s\S]*?)/\)", "<div style='text-align: right;'>$1</div>", False, True)
        pText = s(pText, "\&lt;\&gt;\(([\s\S]*?)/\)", "<div style='text-align: justify;'>$1</div>", False, True)
'        ********************************************************************************************************

        ' The <quote> tag stores text that shows up in a quote box.
        pText = s(pText, "\&lt;quote\&gt;([\s\S]*?)\&lt;\/quote\&gt;", "<div class='quote'>$1</div>", True, True)

        ' The <box> tag stores text that shows up in a box.
        pText = s(pText, "\&lt;box\&gt;([\s\S]*?)\&lt;\/box\&gt;", "<div class='box'>$1</div>", True, True)

    If cAllowAttachments Then
        Dim vAttachmentPattern
        If IsObject(gCurrentWorkingPages) Then
            ' we're including a page
            Set gTemp = gNamespace.GetPageAndAttachments(gCurrentWorkingPages.Top(), 0, True, False)
        Else
            Set gTemp = gNamespace.GetPageAndAttachments(gPage, gRevision, True, False)
        End If
        vAttachmentPattern = gTemp.GetAttachmentPattern()
        If vAttachmentPattern <> "" Then
            pText = s(pText, "\[(" & gTemp.GetAttachmentPattern & ")(\s+[^\]]+)*\]", "&StoreBracketAttachmentLink($1, $2)", False, True)
        End If
    End If

    If cWikiLinks And cBracketText And cBracketWiki Then
        ' Local bracket-links
        pText = s(pText, "\[" & "(#?)" & gLinkPattern & "(\s+[^\]]+?)\]", "&StoreBracketWikiLink($1, $2, $3)", False, True)
    End If

    pText = s(pText, gUrlPattern, "&StoreUrl($1)", False, True)
    pText = s(pText, gInterLinkPattern, "&StoreInterPage($1, """", False)", False, True)
    pText = s(pText, gMailPattern, "&StoreMail($1)", False, True)
    pText = s(pText, gISBNPattern, "&StoreISBN($1, """", False)", False, True)

    If cAllowAttachments Then
        If IsObject(gCurrentWorkingPages) Then
            ' we are including a page
            Set gTemp = gNamespace.GetPageAndAttachments(gCurrentWorkingPages.Top(), 0, True, False)
        Else
            Set gTemp = gNamespace.GetPageAndAttachments(gPage, gRevision, True, False)
        End If
        vAttachmentPattern = gTemp.GetAttachmentPattern()
        If vAttachmentPattern <> "" Then
            pText = s(pText, "(" & gTemp.GetAttachmentPattern & ")", "&StoreAttachmentLink($1)", False, True)             
            ' Error PiiXiieeS con * image.gif
        End If
    End If

    pText = s(pText, "-{4,}", "<hr size=""1""/>", False, True)
'        // START Coloured Horizontal lines
    pText = s(pText, "---R-", "<hr size=""1"" color=""#ff0000""/>", True, True)
    pText = s(pText, "---G-", "<hr size=""1"" color=""#008000""/>", True, True)
    pText = s(pText, "---B-", "<hr size=""1"" color=""#0000ff""/>", True, True)
    pText = s(pText, "---([\s\S]*?)-", "<hr size=""1"" color=""$1""/>", True, True)
'        // END Coloured Horizontal lines
    pText = s(pText, "\&gt;\&gt;([\s\S]*?)\&lt;\&lt;", "<center>$1</center>", True, True)

'        // START USER-DEFINED FORMATTING (STYLES AND CLASSES)
'        // Gordon Bamber 20040831
'        // Syntax 1: <class(classname)>Some text</class> = span
'        // Syntax 2: <class[classname]>Some text</class> = div
   pText = s(pText, "\&lt;class\((.*?)\)\&gt;(.*?)\&lt;\/class\&gt;", "<span class=""$1"">$2</span>", True, True)
   pText = s(pText, "\&lt;class\[(.*?)\]\&gt;(.*?)\&lt;\/class\&gt;", "<div class=""$1"">$2</div>", True, True)


'        // Syntax: <style(element1:style;element2:style; etc.)>Some text</style> = lines or paras
   pText = s(pText, "\&lt;style\((.*?)\)\&gt;(.*?)\&lt;\/style\&gt;", "<span style=""$1"">$2</span>", True, True)
'        // END USER-DEFINED FORMATTING


'        // START ADDED EXTENSION
'        // Coloured text
'        // Syntax1: {r}This is red{/R} This is normal
'        // Syntax2: {#c0c0c0}This is grey{/#} This is normal
        pText = s(pText, "\{#([\S]+?)\}(.*?)\{/#}", "<span style=""color:$1"">$2</span>", True, True)
        pText = s(pText, "\{R\}(.*?)\{/R\}", "<span class=""redtext"">$1</span>", True, True)
        pText = s(pText, "\{DR\}(.*?)\{/DR\}", "<span class=""darkredtext"">$1</span>", True, True)
        pText = s(pText, "\{G\}(.*?)\{/G\}", "<span class=""greentext"">$1</span>", True, True)
        pText = s(pText, "\{DG\}(.*?)\{/DG\}", "<span class=""darkgreentext"">$1</span>", True, True)
        pText = s(pText, "\{B\}(.*?)\{/B\}", "<span class=""bluetext"">$1</span>", True, True)
        pText = s(pText, "\{DB\}(.*?)\{/DB\}", "<span class=""darkbluetext"">$1</span>", True, True)
        pText = s(pText, "\{MP\}(.*?)\{/MP\}", "<span class=""markerpentext"">$1</span>", True, True)

'        // Coloured Paragraphs
'        // Syntax: {R}This is a whole coloured paragraph
        pText = s(pText, "\{R\}(.*?\n+)", "<p class=""redtext"">$1</p>", True, True)
        pText = s(pText, "\{DR\}(.*?)[\n+|#]", "<p class=""darkredtext"">$1</p>", True, True)
        pText = s(pText, "\{G\}(.*?)[\n+|#]", "<p class=""greentext"">$1</p>", True, True)
        pText = s(pText, "\{DG\}(.*?)[\n+|#]", "<p class=""darkgreentext"">$1</p>", True, True)
        pText = s(pText, "\{B\}(.*?)[\n+|#]", "<p class=""bluetext"">$1</p>", True, True)
        pText = s(pText, "\{DB\}(.*?)[\n+|#]", "<p class=""darkbluetext"">$1</p>", True, True)
        pText = s(pText, "\{MP\}(.*?)[\n+|#]", "<p class=""markerpentext"">$1</p>", True, True)
        pText = s(pText, "\{#([\S]+?)\}(.*?)[\n+|#]", "<p style=""color:$1"">$2</p>", True, True)

'        // END ADDED EXTENSION

    If cNewSkool Then
        pText = s(pText, "\*\*([^\s\*].*?)\*\*", "<b>$1</b>", False, True)
        pText = s(pText, "\/\/([^\s\/].*?)\/\/", "<i>$1</i>", False, True)
        pText = s(pText, "__([^\s_].*?)__", "<u>$1</u>", False, True)
        pText = s(pText, "--([^\s-].*?)--", "<strike>$1</strike>", False, True)
        pText = s(pText, "!!([^\s!].*?)!!", "<big>$1</big>", False, True)
        pText = s(pText, "\^\^([^\s\^].*?)\^\^", "<sup>$1</sup>", False, True)
        pText = s(pText, "vv([^\sv].*?)vv", "<sub>$1</sub>", False, True)
'        // START ADDED EXTENSION
        pText = s(pText, "!-([^\s!].*?)-!", "<small>$1</small>", False, True)
'        // END ADDED EXTENSION

    End If

    If cUseHeadings And cWikifyHeaders = 0 Then
        pText = s(pText, gHeaderPattern, "&StoreWikiHeading($1, $2, $3)", False, True)
    End If

    If cWikiLinks Then
        If OPENWIKI_STOPWORDS <> "" Then
            gStopWords = gNamespace.GetPage(OPENWIKI_STOPWORDS, 0, True, False).Text
            gStopWords = Replace(gStopWords & "", Chr(9), " ")
            gStopWords = Replace(gStopWords, gFS, "")    ' remove separators
            gStopWords = Replace(gStopWords, vbCR, " ")
            gStopWords = Replace(gStopWords, vbLF, " ")
                        ' // Add in the Macros so as they are not linked as pages
                        ' Commented by PiiXiieeS 
                        ' the reason is in owpatterns.asp, we have define Image as a macro, 
                        ' so in "== Image Upload Page ==", the code take Image as a macro, not a string
                        ' StoreWikiHeading("==", "#17388;5#17388; Upload Page", "") generates the error
                        'gStopWords = gStopWords & " " & join(split(gMacros,"|")," ")
            gStopWords = Trim(gStopWords)
            gStopWords = s(gStopWords, "\s+", "|", False, True)
        End If

        If gStopWords <> "" Then
            pText = s(pText, "\b(" & gStopWords & ")\b", "&StoreRaw($1)", True, True)            
        End If
        'response.Write "<br/>hola7<pre>" & pText & "</pre>"
        'dim micont
        'For micont=1 to gRaw.Count
        '    response.Write "<br/>Raw Element " & micont & "<pre>" & gRaw.ElementAt(micont - 1) & "</pre>"
        'Next
        If cNewSkool Then
            pText = s(pText, "(~?)" & gLinkPattern, "&GetWikiLink($1, $2, """")", False, True)
        Else
            pText = s(pText, gLinkPattern, "&GetWikiLink("""", $1, """")", False, True)
        End If
        
    End If

    If cOldSkool Then
        ' The quote markup patterns avoid overlapping tags (with 5 quotes)
        ' by matching the inner quotes for the strong pattern.
        pText = Replace(pText, "''''''", "")
        pText = s(pText, "('*)'''(.*?)'''", "$1<strong>$2</strong>", False, True)
        pText = s(pText, "''(.*?)''", "<em>$1</em>", False, True)
    End If

'        // Emoticons have the pattern: (space):emoticonname:(space)
'        // Special cases - :) :-) :-( :-D
'        // They are not case-sensitive
    If cEmoticons Then
        pText = s(pText, "[\s|\b]:([a-zA-Z]*?):[\s|\b]", "&StoreEmoticon($1)",False,true)
        pText = s(pText, "\s\:\-?\)($|\s)", "&StoreEmoticon(""smily"")",False,true)
        pText = s(pText, "\s\:\-\(($|\s)", "&StoreEmoticon(""angry"")",False,true)
        pText = s(pText, "\s\;\-\)($|\s)", "&StoreEmoticon(""wink"")",False,true)
        pText = s(pText, "\s\:\-D($|\s)", "&StoreEmoticon(""bigsmile"")",False,true)
	If cShowOldEmoticons then
	' // This is for backwards-compatibility with OpenWiki Classic
	        pText = s(pText, "\s\:\-?\)($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-smile.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
        	pText = s(pText, "\s\;\-?\)($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-wink.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
	        pText = s(pText, "\s\:\-?\(($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-sad.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
	        pText = s(pText, "\s\:\-?\|($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-ambivalent.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
	        pText = s(pText, "\s\:\-?D($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-laugh.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
	        pText = s(pText, "\s\:\-?O($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-surprised.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
	        pText = s(pText, "\s\:\-?P($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-tongue-in-cheek.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
	        pText = s(pText, "\s\:\-?S($|\s)", " <img src=""" & OPENWIKI_ICONPATH & "/emoticon-unsure.gif"" width=""14"" height=""12"" alt=""""/>$1", True, True)
	        pText = s(pText, "(^|\s)\(([Y|N|L|U|K|G|F|P|B|D|T|C|I|H|S|8|E|M])\)($|\s)", "$1<img src=""" & OPENWIKI_ICONPATH & "/emoticon-$2.gif"" width=""14"" height=""12"" alt=""""/>$3", True, True)
	        pText = s(pText, "(^|\s)\(\*\)($|\s)", "$1<img src=""" & OPENWIKI_ICONPATH & "/emoticon-star.gif"" width=""14"" height=""12"" alt=""""/>$2", True, True)
	        pText = s(pText, "(^|\s)\(\@\)($|\s)", "$1<img src=""" & OPENWIKI_ICONPATH & "/emoticon-cat.gif"" width=""14"" height=""12"" alt=""""/>$2", True, True)
	        pText = s(pText, "(^|\s)\/i\\($|\s)", "$1<img src=""" & OPENWIKI_ICONPATH & "/icon-info.gif"" width=""16"" height=""16"" alt=""""/>$2", True, True)
	        pText = s(pText, "(^|\s)\/w\\($|\s)", "$1<img src=""" & OPENWIKI_ICONPATH & "/icon-warning.gif"" width=""16"" height=""16"" alt=""""/>$2", True, True)
	        pText = s(pText, "(^|\s)\/s\\($|\s)", "$1<img src=""" & OPENWIKI_ICONPATH & "/icon-error.gif"" width=""16"" height=""16"" alt=""""/>$2", True, True)
	End If
    End If

    If cUseHeadings And cWikifyHeaders Then
        pText = s(pText, gHeaderPattern, "&StoreWikiHeading($1, $2, $3)", False, True)
    End If


    ' The <comment> tag stores text that doesn't show up at all.
    ' Uncomment the next line if you want to support the <comment> tag
     pText = s(pText, "\&lt;comment\&gt;([\s\S]*?)\&lt;\/comment\&gt;", "", True, True)

    pText = MyMultiLineMarkupEnd(pText)

    MultiLineMarkup = pText
End Function


'______________________________________________________________________________________________________________
Function WikiLinesToHtml(pText)
    Dim vTagStack, vRegEx, vMatch, vMatches, vLine
    Dim vFirstChar, vCode, vDepth, vPos, vStart, vAttrs
    Dim vInTable, vNewTable, vStartTr
    Dim vLineDef, vLineCount
    Dim vText

    vText = ""
    vDepth = 0
    vInTable = 0
    vNewTable = 0
    vLineCount = 0
    vLineDef = False
    Set vTagStack = new Vector
    Set vRegEx = New RegExp
    vRegEx.IgnoreCase = False
    vRegEx.Global = True
    vRegEx.Pattern = ".+"
    Set vMatches = vRegEx.Execute(pText)
    For Each vMatch In vMatches
        'vLine = vMatch.Value
        vLine = RTrim(Replace(vMatch.Value, vbCR, ""))
        vLine = s(vLine, "^\s*$", "<p></p>", False, True)  ' Blank lines

        ' The following piece of code is not as bad as you could hope for
        vFirstChar = Left(vLine, 1)
        If (vFirstChar = " ") Or (vFirstChar = Chr(8)) Then
            If (vDepth = 0) And (vInTable > 0) Then
                vText = vText & vbCRLF & "</table>" & vbCRLF
                vInTable = 0
            End If

            vAttrs = ""
            gListSet = False
            vLine = s(vLine, "^(\s+)\;(.*?) \:", "&SetListValues(True, $1, ""<dt>"" & $2 & ""</dt><dd>"")", False, True)
            If gListSet Then
                vLine = vLine & "</dd>"
                vCode = "dl"
                vDepth = Len(gDepth) / 2
            Else
                vLine = s(vLine , "^(\s+)\:\s(.*?)$", "&SetListValues(True, $1, ""<dt> </dt><dd>"" & $2 & ""</dd>"")", False, True)
                If gListSet Then
                  vCode = "dl"
                  vDepth = Len(gDepth) / 2
                Else
                    vLine = s(vLine, "^(\s+)\*\s(.*?)$", "&SetListValues(True, $1, ""<li>"" & $2 & ""</li>"")", False, True)
                    If gListSet Then
                        vCode  = "ul"
                        vDepth = Len(gDepth) / 2
                    Else
                        vLine = s(vLine, "^(\s+)([0-9aAiI]\.(?:#\d+)? )", "&SetListValues(True, $1, $2)", False, True)
                        If gListSet Then
                            vPos   = InStr(vLine, " ")
                            vCode  = Left(vLine, vPos - 1)
                            vLine  = "<li>" & Mid(vLine, vPos + 1) & "</li>"

                            vPos   = InStr(vCode, "#")
                            vStart = ""
                            If vPos > 0 Then
                                vStart = "start=""" & Mid(vCode, vPos + 1) & """"
                            End If
                            vCode = Left(vCode, 1)
                            If IsNumeric(vCode) Then
                                vAttrs = " type=""1"""
                            Else
                                vAttrs = " type=""" & vCode & """"
                            End If
                            If vStart <> "" Then
                                vAttrs = vAttrs & " " & vStart
                            End If
                            vCode  = "ol"
                            vDepth = Len(gDepth) / 2
                        Elseif vDepth > 0 And vCode <> "pre" Then
                            Dim vTemp
                            vTemp = Trim(vLine)
                            If (Left(vTemp, 2) = "||") And (Right(vTemp, 2) = "||") Then
                                vLine = vTemp
                            Elseif vInTable = 0 Then
                                vText = vText & "<br />"
                            End If
                        Else
                            vCode = "pre"
                            vDepth = 1
                        End If
                    End If
                End If
            End If
        Else
            If (vDepth > 0) And (vInTable > 0) Then
                vText = vText & vbCRLF & "</table>" & vbCRLF
                vInTable = 0
            End If

            vDepth = 0
            vLineCount = vLineCount + 1
        End If

        Do While (vTagStack.Count > vDepth)
            vText = vText & "</" & vTagStack.Pop() & ">" & vbCRLF
        Loop

        If (vDepth > 0) Then
            If vDepth > gIndentLimit Then
                vDepth = gIndentLimit
            End If
            Do While (vTagStack.Count < vDepth)
                vTagStack.Push(vCode)
                vText = vText & "<" & vCode & vAttrs & ">" & vbCRLF
            Loop
            If Not vTagStack.IsEmpty Then
                If vTagStack.Top <> vCode Then
                    vText = vText & "</" & vTagStack.Pop() & ">"  & vbCRLF & "<" & vCode & vAttrs & ">"
                    vTagStack.Push(vCode)
                End If
            End If
        End If


        '2 Character IDs
        Dim vID2
        vID2 = Left(vLine, 2)

        'Tables
        Dim vTR, vTD, vColSpan, vNrOfTDs, vResult, vSaveReturn

        vTD = ""
        '''''''''''
        'New Tables
        'New format enhacement by PiiXiieeS #20060810.1
        Select Case vID2
                Case "{|"
                        Dim vTable, vAttribs, vStyle, vFirstRow
                        vFirstRow = True
                        vAttribs = ""
                        vStyle = ""
                        vStyle = s(vLine, "^(\{\|)(\s+)(id=)(.+)", "$4", False, True)
                        If Left(vStyle,2) = vID2 Then 
                            vStyle = ""
                            vAttribs = s(vLine, "^(\{\|)(\s+)(style=)(.+)", "$4", False, True)
                            If Left(vAttribs,2) = vID2 Then 
                                vAttribs = ""
                            Else
                                vAttribs = s(vAttribs, "(\"")(.+)(\"")(.+)", "$2", False, True)
                                vAttribs = " style=" & vAttribs
                            End If
                        Else
                            vStyle = " id=" & vStyle
                        End If
                        vTable = "<div" & vStyle & ">" & "<table" & vAttribs & "><tr><td class=""firstcell"">"
                        vText = vText & vTable
                        vNewTable = vNewTable + 1
                        vStartTr = vLineCount
                        vLineDef = True
                Case "|}"
                        If vInTable Then        'Old Table
                                vText = vText & "</table>"
                                vInTable = 0
                        End If
                        vText = vText & "</td></tr></table></div>"
                        vNewTable = vNewTable - 1
                        vLineDef = True
                Case "|-"
                        If vNewTable > 0 Then
                        vFirstRow = False
                            vAttribs = ""
                            vAttribs = s(vLine, "^(\|\-)(.+)", "$2", False, True)
                            If vAttribs = vID2 Then vAttribs = ""
                                If vInTable Then        'Old Table
                                        vText = vText & "</table>"
                                        vInTable = 0
                                End If
                                vText = vText & "</td></tr><tr " & vAttribs & "><td class=""firstcol"">"
                                vStartTr = vLineCount
                                vLineDef = True
                        End If
                Case "||"        ' Skip Old Tables

                Case Else
                        If vFirstChar = "|" and vNewTable > 0 Then
                                If vFirstRow = True Then 
                                    vStyle = "class=""firstrow"""
                                Else
                                    vStyle = "class=""middle"""
                                End If
                                If vLineCount > vStartTr + 1 Then
                                        vTD = "</td><td " & vStyle & ">"
                                End If
                                If vInTable Then        'Old Table
                                        vTD = "</table>" & vTD
                                        vInTable = 0
                                End If
                                If vID2 = "| " Then
                                        vTR = s(vLine, "^(\|\s)(.*?)", vTD & "$2", False, True)
                                        vResult = s(vTR, "(\|{2,})(.*?)", "</td><td class=""middleold"">$2", False, True)
                                        vText = vText & vResult
                                        vLineDef = True
                                ElseIf Len(vID2) = 1 Then
                                        vText = vText & vTD
                                        vLineDef = True
                                End If
                        End If
        End Select
        'New format enhacement by PiiXiieeS #20060810.1
        ''''''''''
                
                vTD = ""


                'Old Tables
        If vID2 = "||" And Right(vLine, 2) = "||" Then
            ' tables
            vTR = vLine
            vNrOfTDs = 0
            vResult = ""

            Do While vTR <> ""
                gListSet = False
                vTD = s(vTR, "^(\|{2,})(.*?)\|\|", "&SetListValues(True, $1, $2)", False, True)
                If gListSet Then
                    vColSpan = Int(Len(gDepth) / 2)
                    vNrOfTDs = vNrOfTDs + vColSpan
                    If vColSpan = 1 Then
                        vColSpan = "<td class=""wiki"">"
                    Else
                        vColSpan = "<td class=""wiki"" align=""center"" colspan=""" & vColSpan & """>"
                    End If
                    vSaveReturn = sReturn
                    If Trim(sReturn) = "" Then
                        sReturn = "&#160;"
                    End If
                    vResult = vResult & vColSpan & sReturn & "</td>"
                    'Response.Write("GOT: " & Server.HTMLEncode(vResult) & "<br>")
                    vTR = Mid(vTR, Len(gDepth) + Len(vSaveReturn) + 1)
                Else
                    vTR = ""
                End If
            Loop

            If (vInTable > 0) And (vInTable <> vNrOfTDs) Then
                vText = vText & vbCRLF & "</table>" & vbCRLF
                vInTable = 0
            End If

            If vInTable = 0 Then
                vText = vText & "<table cellspacing=""0"" cellpadding=""2"" border=""1"" class=""oldtable"">"
                vInTable = vNrOfTDs
            End If
            vText = vText & vbCRLF & "<tr class=""wiki"">" & vResult & "</tr>"
        Elseif vInTable > 0 Then
            vText = vText & vbCRLF & "</table>" & vbCRLF
            vInTable = 0
        End If

        If vLineDef = False and vInTable = 0 Then
            vText = vText & vLine & vbCRLF
        Else
            vLineDef = False
        End If
    Next

    If vInTable > 0 Then
        vText = vText & vbCRLF & "</table>" & vbCRLF
    End If

    Do While vNewTable > 0
                vText = vText & "</td></tr></table>"
                vNewTable = vNewTable - 1
    Loop

    Do While Not vTagStack.IsEmpty
        vText = vText & "</" & vTagStack.Pop() & ">" & vbCRLF
    Loop

    Set vRegEx = Nothing
    Set vTagStack = Nothing

    WikiLinesToHtml = vText
End Function

Dim gListSet, gDepth
Sub SetListValues(pListSet, pDepth, pText)
    gListSet = pListSet
    gDepth   = pDepth
    sReturn  = pText
End Sub

'______________________________________________________________________________________________________________
Function QuoteXml(ByRef pText)

    QuoteXml = Replace(pText, "&", "&amp;")
    QuoteXml = Replace(QuoteXml, "<", "&lt;")
    QuoteXml = Replace(QuoteXml, ">", "&gt;")

    ' In XML data HTML character references are invalid (unless these are
    ' defined in the DTD). Special characters can be entered in XML without
    ' the use of character references. Make sure you've set the constant
    ' OPENWIKI_ENCODING correct though in owconfig.asp and also the encoding
    ' attribute at the first line of the stylesheets.
    If cAllowCharRefs Then
        QuoteXml = s(QuoteXml, "\&amp;([#a-zA-Z0-9]+);", "&StoreCharRef($1)", False, True)
    End If

End Function

Function CDATAEncode(pText)
    If pText <> "" Then
        CDATAEncode = Replace(pText, "&", "&amp;")
        CDATAEncode = Replace(CDATAEncode, "<", "&lt;")
        CDATAEncode = Replace(CDATAEncode, "'", "&apos;")
    End If
End Function

Function PCDATAEncode(pText)
    If pText <> "" Then
        PCDATAEncode = Replace(pText, "&", "&amp;")
        PCDATAEncode = Replace(PCDATAEncode, "<", "&lt;")
        PCDATAEncode = Replace(PCDATAEncode, "]]>", "]]&gt;")
    End If
End Function

'Function URLDecode(ByVal strIn) 'thanks for 1mmm
'URLDecode = ""
'Dim sl: sl = 1
'Dim tl: tl = 1
'Dim key: key = "%"
'Dim kl: kl = Len(key)
'sl = InStr(sl, strIn, key, 1)
'Do While sl>0
'If (tl=1 And sl<>1) Or tl<sl Then
'URLDecode = URLDecode & Mid(strIn, tl, sl-tl)
'End If
'Dim hh, hi, hl
'Dim a
'Select Case UCase(Mid(strIn, sl+kl, 1))
'Case "U":'Unicode URLEncode
'a = Mid(strIn, sl+kl+1, 4)
'URLDecode = URLDecode & ChrW("&H" & a)
'sl = sl + 6
'Case "E":'UTF-8 URLEncode
'hh = Mid(strIn, sl+kl, 2)
'a = Int("&H" & hh)'ascii code
'If Abs(a)<128 Then
'sl = sl + 3
'URLDecode = URLDecode & Chr(a)
'Else
'hi = Mid(strIn, sl+3+kl, 2)
'hl = Mid(strIn, sl+6+kl, 2)
'a = ("&H" & hh And &H0F) * 2 ^12 Or ("&H" & hi And &H3F) * 2 ^ 6 Or ("&H" & hl And &H3F)
'If a<0 Then a = a + 65536
'URLDecode = URLDecode & ChrW(a)
'sl = sl + 9
'End If
'Case Else:'Asc URLEncode
'hh = Mid(strIn, sl+kl, 2)'hight
'a = Int("&H" & hh)'ascii code
'If Abs(a)<128 Then
'sl = sl + 3
'Else
'hi = Mid(strIn, sl+3+kl, 2)'low
'a = Int("&H" & hh & hi)'not ascii code
'sl = sl + 6
'End If
'URLDecode = URLDecode & Chr(a)
'End Select
'tl = sl
'sl = InStr(sl, strIn, key, 1)
'Loop
'URLDecode = URLDecode & Mid(strIn, tl)
'End Function
'========end 1mmm

Function URLDecode(pURL)
    Dim vPos
    If pURL <> "" Then
        pURL = Replace(pURL, "+", " ")
        vPos = InStr(pURL, "%")
        Do While vPos > 0
            pURL = Left(pURL, vPos - 1) _
                 & Chr(CLng("&H" & Mid(pURL, vPos + 1, 2))) _
                 & Mid(pURL, vPos + 3)
            vPos = InStr(vPos + 1, pURL, "%")
        Loop
    End If
    URLDecode = pURL
End Function


'______________________________________________________________________________________________________________
Sub StoreRaw(pText)
    gRaw.Push(pText)
    sReturn = gFS & (gRaw.Count - 1) & gFS
    'Response.Write "<br />StoreRaw: " & gFS & (gRaw.Count - 1) & gFS
End Sub

Sub GetRaw(pIndex)
    sReturn = gRaw.ElementAt(pIndex)
End Sub

Sub StoreCharRef(pText)
    StoreHtml("&" & pText & ";")
End Sub

Sub StoreEmoticon(pText)
  StoreRaw("<span><img hspace=""5"" align=""center"" src=""" & OPENWIKI_ICONPATH & "/emoticon-" & pText & ".gif"" alt=""" & pText & """/></span>")
End Sub

Sub StoreHtml(pText)
    StoreRaw("<ow:html><![CDATA[" & Replace(pText, "]]>", "]]&gt;") & "]]></ow:html>")
End Sub

Sub StoreMathML(pText)
    StoreRaw("<ow:math><![CDATA[" & Replace(pText, "]]>", "]]&gt;") & "]]></ow:math>")
End Sub

Sub StoreCode(pText)
    StoreRaw("<pre class=""code"">" & s(pText, "'''(.*?)'''", "<b>$1</b>", False, True) & "</pre>")
End Sub

Sub StoreMail(pText)
    StoreRaw("<a href=""mailto:" & pText & """ class=""external"">" & pText & "</a>")
End Sub

Sub StoreUrl(pURL)
    Call UrlLink(pURL)
    StoreRaw(gTempLink)
    sReturn = sReturn & gTempJunk
End Sub

Sub StoreBracketUrl(pURL, pText)
    If pText = "" Then
        If cUseLinkIcons Then
            pText = pURL
        End If
    Else
        If cBracketText = 0 Then
            sReturn = "[" & pURL & " " & pText & "]"
            Exit Sub
        End If
    End If
    StoreRaw(GetExternalLink(pURL, pText, "", True))
End Sub

Sub StoreHref(pAnchor, pText)
    Dim vLink
    vLink = "<a " & pAnchor
    If cExternalOut Then
        If Not m(pAnchor, " target=\""", True, True) Then
            vLink = vLink & " target=""_blank"""
        End If
    End If
    If Not m(pAnchor, " class=\""", True, True) Then
        vLink = vLink & " class=""external"""
    End If
    vLink = vLink & ">"
    If cUseLinkIcons Then
        vLink = vLink & "<img src=""" & GetSkinDir() & "/images" & "/wiki-http.gif"" border=""0"" hspace=""4"" alt=""""/>"
    End If
    vLink = vLink & pText & "</a>"
    StoreRaw(vLink)
End Sub

Sub StoreFreeLink(pID, pText)
'*************************************************************************************
'*************************************************************************************
'*************************************************************************************
	if cFreeLinks = 0 then
        StoreRaw("<ow:error>[[" & pID & "]] is a Non CamelCase link and is disallowed. (cFreeLinks=0)</ow:error>")
		Exit Sub
	end if
'*************************************************************************************
'*************************************************************************************
'*************************************************************************************

    ' trim spaces before/after subpages
    pID = s(pID, "\s*\/\s*", "/", False, True)
    gTemp = GetWikiLink("", Trim(pID), Trim(pText))
    If Left(gTemp, 1) <> "<" Then
        sReturn = "[[" & pID & pText & "]]"
    Else
        StoreRaw(gTemp)
    End If
End Sub

Sub StoreBracketWikiLink(pPrefix, pID, pText)
'*************************************************************************************
'*************************************************************************************
'*************************************************************************************
	if ( (cFreeLinks = 0) AND (m(pID, gStrictLinkPattern, true, true)=false ) ) then
        StoreRaw("<ow:error>" & pID & " is a free link and is disallowed. (cFreeLinks=0)</ow:error>")
		Exit Sub
	end if
'*************************************************************************************
'*************************************************************************************
'*************************************************************************************
	If pID = gPage Then
        ' don't link to oneself
        sReturn = pText
    Else
        gTemp = GetWikiLink(pPrefix, pID, LTrim(pText))
        If Left(gTemp, 1) <> "<" Then
            sReturn = "[" & pPrefix & pID & pText & "]"
        Else
            StoreRaw(gTemp)
        End If
    End If
End Sub

Sub StoreInterPage(pID, pText, pUseBrackets)
    Dim vPos, vSite, vRemotePage, vURL, vTemp
    If pUseBrackets Then
        gTempLink = pID
        gTempJunk = ""
    Else
        SplitUrlPunct(pID)
    End If
    vPos = InStr(gTempLink, ":")
    If vPos > 0 Then
        vSite = Left(gTempLink, vPos - 1)
        vRemotePage = Mid(gTempLink, vPos + 1)
' *************************************
' START INTERWIKI CODE
' *************************************
        vRemotePage=Replace(vRemotePage,"*"," ")
' *************************************
' END INTERWIKI CODE
' *************************************
        vURL = gNamespace.GetInterWiki(vSite)
    End If

    If vURL = "" Then
        sReturn = pID & pText
        If pUseBrackets Then
            sReturn = "[" & sReturn & "]"
        End If
    Else
        If pText = "" Then
            If pUseBrackets And cBracketIndex And (cUseLinkIcons = 0) Then
                pText = ""
            Else
                ' pText = Mid(pID, Len(vSite) + 2)
                ' pText = pID
                pText = gTempLink
            End If
        Elseif cBracketText = 0 Then
            If pUseBrackets Then
                sReturn = "[" & pID & pText & "]"
                Exit Sub
            End If
        End If
        If vPos > 0 Then
            If InStr(vURL, "$1") > 0 Then
                vURL = Replace(vURL, "$1", vRemotePage)
            Else
                vURL = vURL & vRemotePage
            End If
        Else
            vURL = vURL & vRemotePage
        End If
        vURL = Replace(vURL, "&", "&amp;")
' *************************************
' START INTERWIKI CODE
' *************************************
        pText=Replace(pText,"*"," ")
' *************************************
' END INTERWIKI CODE
' *************************************
        vURL = Replace(vURL, "&amp;amp;", "&amp;")  ' correction back
        If vSite = "This" Then
            StoreRaw("<ow:link name='" & pText & "' href='" & vURL & "' date='" & FormatDateISO8601(Now()) & "'>" & pText & "</ow:link>" & gTempJunk)
        Else
            StoreRaw(GetExternalLink(vURL, pText, vSite, pUseBrackets) & gTempJunk)
        ' StackError 0, "hola","MessageStrin","OtherString"
        ' If ShowErrors Then Exit Sub
        End If
    End If
End Sub

Sub StoreISBN(pNumber, pText, pUseBrackets)
    If pText <> "" And cBracketText = 0 And pUseBrackets Then
        sReturn = "[ISBN" & pNumber & pText & "]"
    Else
        Dim vRawPrint, vNumber, vText
        vRawPrint = Replace(pNumber, " ", "")
        vNumber = Replace(vRawPrint, "-", "")

        If Len(vNumber) = 11 Then
            If UCase(Right(vNumber, 1)) = "X" Then
                pText = Right(vNumber, 1) & pText
                vNumber = Left(vNumber, 10)
            End If
        End If

        If Len(vNumber) <> 10 Then
            If pText = "" Then
                sReturn = "ISBN " & pNumber
            Else
                sReturn = "[ISBN " & pNumber & pText & "]"
            End If
        Else
            If pText = "" Then
                If pUseBrackets And cBracketIndex And (cUseLinkIcons = 0) Then
                    vText = ""
                Else
                    vText = "ISBN " & vRawPrint
                End If
            Else
                vText = pText
            End If
            sReturn = GetExternalLink("http://www.amazon.com/exec/obidos/ISBN=" & vNumber, vText, "Amazon", pUseBrackets) _
                    & " (" & GetExternalLink("http://shop.barnesandnoble.com/bookSearch/isbnInquiry.asp?isbn=" & vNumber, "alternate", "Barnes & Noble", False) _
                    & ", " & GetExternalLink("http://www1.fatbrain.com/asp/bookinfo/bookinfo.asp?theisbn=" & vNumber, "alternate", "FatBrain", False) & ")"

            If (pText = "") And (Right(pNumber, 1) = " ") Then
                sReturn = sReturn & " "
            End If
            StoreRaw(sReturn)
        End If
    End If
End Sub

Sub StoreWikiHeading(pSymbols, pText, pTrailer)
    StoreRaw(gFS & pSymbols & " " & pText & " " & pSymbols & " " & gFS)
    sReturn = sReturn & pTrailer
End Sub

Sub GetWikiHeading(pSymbols, pText)
    Dim vLevel, vTemp
    vLevel = Len(pSymbols)
    If vLevel > 6 Then
        vLevel = 6
    End If
    vTemp = s(pText, "<ow:link name='(.*?)' href=.*?</ow:link>", "$1", False, False)
    Call gTOC.AddTOC(vLevel, "<li><a href=""#h" & gTOC.Count & """>" & vTemp & "</a></li>")
    sReturn = "<a name=""h" & (gTOC.Count - 1) & """/><h" & vLevel & ">" & pText & "</h" & vLevel & ">"
End Sub


Sub StoreBracketAttachmentLink(pName, pText)
    gTemp = AttachmentLink(pName, pText)
    If gTemp = "" Then
        sReturn = "[" & pName & " " & pText & "]"
    Else
        StoreRaw(gTemp)
    End If
End Sub

Sub StoreAttachmentLink(pName)
   gTemp = AttachmentLink(pName, "")
   'Response.Write "<br />StoreAttachmentLink: " & Server.HTMLEncode(pName)
   If gTemp = "" Then
        sReturn = pName
   Else
        StoreRaw(gTemp)
   End If
   'Response.Write "<br />sReturn: " & Server.HTMLEncode(sReturn)
End Sub



'______________________________________________________________________________________________________________
Function PrettyWikiLink(pID)
    If cPrettyLinks Then
        PrettyWikiLink = s(pID, "([a-z\xdf-\xff0-9])([A-Z\xc0-\xde]+)", "$1 $2", False, True)
        PrettyWikiLink = s(PrettyWikiLink, "([A-Z\xc0-\xde]+)([A-Z\xc0-\xde]+)([a-z\xdf-\xff0-9])", "$1 $2$3", False, True)
    Else
        PrettyWikiLink = pID
    End If
    If cFreeLinks Then
        PrettyWikiLink = Replace(PrettyWikiLink, "_", " ")
    End If
End Function


Function GetWikiLink(pPrefix, pID, pText)
    Dim vID, vPage, vAnchor, vTemplate, vTemp
	
	If cFreeLinks = 0 then
	'	// Prevent linking any pagename or subpage that is a FreeLink
		if ContainsFreeLinks(pID) then
			GetWikiLink = pID
			sReturn=pID
			Exit Function
		End If
	End If

    If pPrefix = "~" Then
        GetWikiLink = pID
        sReturn = GetWikiLink
        Exit Function
    End If

    If ( (pPrefix = "#") OR (pPrefix = "%23")) Then
        vAnchor = "#" & pID
        pID = gPage
    Elseif pID = gPage Then
        ' don't link to oneself
        GetWikiLink = PrettyWikiLink(pID)
        sReturn = GetWikiLink
        Exit Function
    End If

    ' detect anchor
    vTemp = ( (InStr(pID, "#")) OR (InStr(pID, "%23")) )
    If vTemp > 0 Then
        vAnchor = Mid(pID, vTemp)
        pID = Left(pID, vTemp - 1)
    End If

    ' detect template
    vTemp = InStr(pID, "-&gt;")
    If vTemp > 0 then
        vTemplate = Left(pID, vTemp - 1)
        pID = Mid(pID, vTemp + 5)
    End if

    vID = AbsoluteName(pID)
    vID = ResolveSynonymLink(vID)'    // SYNONYM LINKS
    Set vPage = gNamespace.GetPage(vID, 0, False, False)
    vPage.Anchor = vAnchor
    If vPage.Exists Then
        If pText = "" Then
            GetWikiLink = vPage.ToLinkXML(PrettyWikiLink(pID), vTemplate, True)
        Else
            GetWikiLink = vPage.ToLinkXML(pText, vTemplate, False)
        End If
    Else
        If cReadOnly Or gAction = "print" Then
            GetWikiLink = pID & vAnchor
        Else
            If pText = "" Then
                pText = pID
            End If

            If cFreeLinks Then
                If InStr(pText, " ") > 0 Then
                    pText = "[" & pText & "]" ' Add brackets so boundaries are obvious
                End If
            End If

            ' non existent link
            GetWikiLink = vPage.ToLinkXML(pText, vTemplate, True)
        End If
    End If
    sReturn = GetWikiLink
End Function


Function AbsoluteName(pID)
    Dim vPos, vTemp, vCurrentPage, vMainpage

    If Not gIncludingAsTemplate And IsObject(gCurrentWorkingPages) Then
        vCurrentPage = gCurrentWorkingPages.Top()
    Else
        vCurrentPage = gPage
    End If

    ' asbolute subpage
    vPos = InStrRev(vCurrentPage, "/")
    If vPos > 0 Then
        vMainpage = Left(vCurrentPage, vPos - 1)
    Else
        vMainpage = vCurrentPage
    End If
    AbsoluteName = s(pID, "^/", vMainpage & "/", False, True)

    ' relative subpage
    AbsoluteName = s(AbsoluteName, "^\./", vCurrentPage & "/", False, True)

    If cFreeLinks Then
        AbsoluteName = FreeToNormal(AbsoluteName)
    End If
End Function


Function FreeToNormal(pID)
    Dim vID
    vID = Replace(pID, " ", "_")
    vID = UCase(Left(vID, 1)) & Mid(vID, 2)
    If InStr(vID, "_") > 0 Then
        vID = s(vID, "__+", "_",  False, True)
        vID = s(vID, "^_", "", False, True)
        vID = s(vID, "_$", "", False, True)
        If cUseSubpage Then
            vID = s(vID, "_\/", "/", False, True)
            vID = s(vID, "\/_", "/", False, True)
        End If
    End If
    If cFreeUpper Then
        vID = s(vID, "([-_\.,\(\)\/])([a-z])", "&Capitalize($1, $2)", False, True)
    End If
    FreeToNormal = vID
End Function

Sub Capitalize(pChars, pWord)
    sReturn = pChars & UCase(Left(pWord, 1)) & Mid(pWord, 2)
End Sub


Function GetExternalLink(pURL, pText, pTitle, pUseBrackets)
    Dim vLink, vLinkedImage, vTemp, vInterWiki
    If pUseBrackets And pText = "" Then
        If cBracketIndex Then
            pText = "[" & GetBracketUrlIndex(pURL) & "]"
        Else
            pText = pURL
        End If
    Else
        pText = Trim(pText)
    End If

    If cAllowAttachments And (Left(pURL, 13) = "attachment://") Then
        If pUseBrackets And cShowBrackets Then
            pText = "[" & pText & "]"
        End If
        GetExternalLink = AttachmentLink(Mid(pURL, 14), pText)
        If GetExternalLink = "" Then
            GetExternalLink = "[" & pURL & " " & pText & "]"
        End If
        Exit Function
    End If

    ' ~~~~~~~~~ PiiXiieeS 20060313 ~~~~~~~~~
    vLinkedImage = False
    If pText <> "" Then
        If m(pText, gImagePattern, False, True) Then
            vLinkedImage = True
        End If
    End If

    ' ~~~~~~~~~ PiiXiieeS 20060319 ~~~~~~~~~
    If pText <> "" Then
        If m(pText, "^[A-Z]+[a-z0-9|_]+[A-Z]:[A-Z]+[a-z0-9|_]+[A-Z]\b", True, True) Then
            vInterWiki = True
        End If
    End If
    ' ~~~~~~~~~ PiiXiieeS 20060319 ~~~~~~~~~    

    If pUseBrackets And cUseLinkIcons And Not vLinkedImage Then
        Dim vScheme, vImg, vPos
        vPos = Instr(pURL, ":")
        vScheme = Left(pURL, vPos - 1)
        vImg = "/wiki-" & vScheme & ".gif"""
        vLink = vLink & "<img src=""" & GetSkinDir() & "/images" & vImg & " border=""0"" hspace=""2"" alt=""""/>"
    End If

    ' ~~~~~~~~~ PiiXiieeS 20060319 ~~~~~~~~~
    If vInterWiki And cUseInterWikiIcons Then
        vLink = vLink & "<img src=""" & GetSkinDir() & "/images/" & pTitle & ".jpg"" border=""0"" hspace=""2"" alt='" & CDATAEncode(pTitle) & "'/>"
        pText = s(pText, pTitle & ":", "", False, True)
    End If
    ' ~~~~~~~~~ PiiXiieeS 20060319 ~~~~~~~~~    
    
    vLink = vLink & "<a href='" & pURL & "' class='external'"

    If cExternalOut AND (Instr(vLink,gPage) = 0) Then
        vLink = vLink & " target='_blank'"
    End If

    If pTitle <> "" Then
        vLink = vLink & " title='" & CDATAEncode(pTitle) & "'"
    End If
    vLink = vLink & ">"

    If vLinkedImage Then
        pText = "<img src=""" & pText & """ border=""0"" alt=""""/>"
    End If

    If pUseBrackets And cUseLinkIcons And Not vLinkedImage Then
        vLink = vLink & pText
    Else
        If vLinkedImage Then
            vLink = vLink & pText
        Else
            If pUseBrackets And cShowBrackets Then
                vLink = vLink & "["
            End If
            vLink = vLink & pText
            If pUseBrackets And cShowBrackets Then
                vLink = vLink & "]"
            End If
        End If
    End If
   ' ~~~~~~~~~ PiiXiieeS 20060313 ~~~~~~~~~

    vLink = vLink & "</a>"
'        // BADLINKLIST PLUGIN START //
                vLink=ReplaceBadLink(vLink)
'        // BADLINKLIST PLUGIN END //

    GetExternalLink = vLink
End Function

Function GetBracketUrlIndex(pID)
    Dim i, vCount
    vCount = gBracketIndices.Count
    For i = 0 To vCount
        If gBracketIndices.ElementAt(i) = pID Then
            GetBracketUrlIndex = i + 1
            Exit Function
        End If
    Next
    gBracketIndices.Push(pID)
    GetBracketUrlIndex = gBracketIndices.Count
End Function

Sub UrlLink(pURL)
    Dim vLink, vTemp
    SplitUrlPunct(pURL)
    If cNetworkFile And (Left(pURL, 5) = "file:") Then
        ' only do remote file:// links. No file:///c|/windows.
        If (Left(pURL, 8) <> "file:///") Then
            gTempLink = "<a href=""" & gTempLink & """>" & gTempLink & "</a>"
        End If
        Exit Sub
    Elseif cAllowAttachments And (Left(pURL, 13) = "attachment://") Then
        gTempLink = AttachmentLink(Mid(gTempLink, 14), "")
        If gTempLink = "" Then
            gTempLink = pURL
        End If
        Exit Sub
    End If

' **********************************************************************************************************************
'        // MODIFIED TO ALLOW local: AND LEFT/RIGHT-ALIGNED IMAGES
'        // GORDON BAMBER 20040511
        If cLinkImages Then
'                // Trap attempts to use local syntax with an externally-referenced image
                If ( (Left(pURL,11)="sharedimage") AND (Instr(gTempLink,"http") > 0) ) then pURL=Replace(pURL,"local","image")

'        // SYNTAX:
'        // sharedimage:imagefilename, sharedimage:imagefilename, sharedimage:imagefilename
        If Left(pURL, 12) = "sharedimage:" Then
            gTempLink = Replace( gTempLink, "sharedimage:", OPENWIKI_IMAGELIBRARY )
                        If m(gTempLink, gImagePattern, False, True) Then '        // Check its an image type (gif, jpg etc)
                                vLink = "<img src=""" & gTempLink & """ hspace=""5"" vspace=""5"" alt=""Local Embedded Image""/>"
                        End If
        ElseIf Left(pURL, 17) = "sharedimageright:" Then
            gTempLink = Replace( gTempLink, "sharedimageright:", OPENWIKI_IMAGELIBRARY )
                        If m(gTempLink, gImagePattern, False, True) Then
                                vLink = "<img src=""" & gTempLink & """ align=""right"" hspace=""5"" vspace=""5"" alt=""Local Right-Embedded Image""/>"
                        End If
        ElseIf Left(pURL, 16) = "sharedimageleft:" Then
            gTempLink = Replace( gTempLink, "sharedimageleft:", OPENWIKI_IMAGELIBRARY )
                        If m(gTempLink, gImagePattern, False, True) Then
                                vLink = "<img src=""" & gTempLink & """ align=""left"" hspace=""5"" vspace=""5"" alt=""Local Left-Embedded Image""/>"
                        End If
' **********************************************************************************************************************
'        // (ALIGNED) EXTERNAL IMAGE CODE
'        // SYNTAX:
'        // image:URL, imageleft:URL, imageright:URL, imagecenter:URL
'        // 20040819 - Gordon Bamber
'        // Allowed pURLs are defined in owpatterns.asp
'        // Disabled code start
'        ElseIf Left(pURL, 6) = "image:" Then ' allow references to images stored in attachment dir manually
'            vTemp = Mid(pURL, 7)
'            gTempLink = OPENWIKI_UPLOADDIR & vTemp
'                        If m(gTempLink, gImagePattern, False, True) Then
'                                vLink = "<img src=""" & gTempLink & """ alt=""Local Embedded Image""/>"
'                        End If
'        // Disabled code end
        ElseIf Left(pURL, 6) = "image:" Then
            gTempLink = Replace( gTempLink, "image:", "" )
                        If m(gTempLink, gImagePattern, False, True) Then
                                vLink = "<img src=""" & gTempLink & """ hspace=""5"" vspace=""5"" alt=""External Image""/>"
                        End If
        ElseIf Left(pURL, 12) = "imagecenter:" Then
            gTempLink = Replace( gTempLink, "imagecenter:", "" )
                        If m(gTempLink, gImagePattern, False, True) Then
                                vLink = "<div align=""center""><img src=""" & gTempLink & """ hspace=""5"" vspace=""5"" alt=""Centred External Image""/></div>"
                        End If
        ElseIf Left(pURL, 10) = "imageleft:" Then
            gTempLink = Replace( gTempLink, "imageleft:", "" )
                        If m(gTempLink, gImagePattern, False, True) Then
                                vLink = "<img src=""" & gTempLink & """ align=""left"" hspace=""5"" vspace=""5"" alt=""External Left-aligned Image""/>"
                        End If
        ElseIf Left(pURL, 11) = "imageright:" Then
            gTempLink = Replace( gTempLink, "imageright:", "" )
                        If m(gTempLink, gImagePattern, False, True) Then
                                vLink = "<img src=""" & gTempLink & """ align=""right"" hspace=""5"" vspace=""5"" alt=""External Right-aligned Image""/>"
                        End If
' **********************************************************************************************************************
                Else
                        If m(gTempLink, gImagePattern, False, True) Then
                                vLink = "<img src=""" & gTempLink & """ alt=""Externally-referenced Image""/>"
                        End If
        End If
        End If

    If vLink = "" Then
        vLink = "<a href=""" & gTempLink & """ class=""external"""
        If cExternalOut Then
            vLink = vLink & " target=""_blank"""
        End If
        vLink = vLink & ">" & gTempLink & "</a>"
'        // BADLINKLIST PLUGIN START //
                vLink=ReplaceBadLink(vLink)
'        // BADLINKLIST PLUGIN END //
    End If
    gTempLink = vLink
End Sub

Dim gTempLink, gTempJunk
Sub SplitUrlPunct(pURL)
    If Len(pURL) > 2 Then
        If Right(pURL, 2) = """""" Then
            gTempLink = Mid(pURL, 1, Len(pURL) - 2)
            gTempJunk = ""
            Exit Sub
        End If
    End If

    gTempLink = s(pURL, "([^a-zA-Z0-9\/\xc0-\xff]+)$", "", False, True)
    gTempJunk = Mid(pURL, Len(gTempLink) + 1)

    'Response.Write("GOT: " & Server.HTMLEncode(gTempLink) & "  :  " & Server.HTMLEncode(gTempJunk)& "<br>")

    ' check the rare case where a semicolon was actually part of the link
    ' e.g. http://x.com?x=<y> is, at this point, translated to <a ...>http://x.com?x=&lt;y&gt</a>;
    ' which is invalid XML
    If Left(gTempJunk, 1) = ";" Then
        gTemp = InStrRev(gTempLink, "&")
        If gTemp > 0 Then
            Dim vPosSemiColon
            vPosSemiColon = InStrRev(gTempLink, ";")
            If vPosSemiColon < gTemp Then
                ' invalid XML, restore
                gTempLink = gTempLink & ";"
                gTempJunk = Mid(gTempJunk, 2)
            End If
        End If
    End If
End Sub

Function AttachmentLink(pName, pText)
    Dim vPos, vPagename, vPage, vAttachment, vText
    If pText = "" Then
        vText = pName
    Else
        vText = Trim(pText)
    End If
    vPos = InStrRev(pName, "/")
    If vPos > 1 Then
        vPagename = Left(pName, vPos - 1)
        pName = Mid(pName, vPos + 1)
    Elseif IsObject(gCurrentWorkingPages) Then
        ' we're including a page
        vPagename = gCurrentWorkingPages.Top()
    Else
        vPagename = gPage
    End If

    Set vPage = gNamespace.GetPageAndAttachments(vPagename, gRevision, True, False)
    Set vAttachment = vPage.GetAttachment(pName)
    If vAttachment Is Nothing Then
        AttachmentLink = ""
        'AttachmentLink = "<ow:link name='" & CDATAEncode(pName) & "'" _
        '     & " href='" & gScriptName & "?p=" & Server.URLEncode(gPage) & "&amp;a=attach'" _
        '     & " attachment='true'>" _
        '     & PCDATAEncode(vText) & "</ow:link>"
    Elseif vAttachment.Deprecated Then
        AttachmentLink = ""
    Else
        AttachmentLink = vAttachment.ToXML(vPagename, vText)
    End If
End Function


Function InsertFootnotes(pText)
    pText = s(pText, gFS & gFS & "(.*?)" & gFS & gFS, "&AddFootnote($1)", False, True)
    If IsObject(gFootnotes) Then
        Dim i, vCount
        pText = pText & "<ow:footnotes>"
        For i = 0 To gFootnotes.Count - 1
            pText = pText & "<ow:footnote index='" & (i + 1) & "'>" & gFootnotes.ElementAt(i) & "</ow:footnote>"
        Next
        pText = pText & "</ow:footnotes>"
        Set gFootnotes = Nothing
    End If
    InsertFootnotes = pText
End Function

Dim gFootnotes
Sub AddFootnote(pParam)
    If Not IsObject(gFootnotes) Then
        Set gFootnotes = New Vector
    End If
    gFootnotes.Push(pParam)
    sReturn = "<sup><a href='#footnote" & gFootnotes.Count & "' class='footnote'>" & gFootnotes.Count & "</a></sup>"
End sub
function ResolveSynonymLink(vID)
    If OPENWIKI_SYNONYMLINKPAGE <> "" AND NOT IsArray(gSynonymArray) Then
        Dim synonyms
        synonyms = gNamespace.GetPage(OPENWIKI_SYNONYMLINKPAGE, 0, True, False).Text

        ' Convert all whitespaces to a single space.
'        // This could probably be done better with a RegExp - Gordon
        synonyms = Replace(synonyms & "", Chr(9), " ")
        synonyms = Replace(synonyms, vbCR, " ")
        synonyms = Replace(synonyms, vbLF, " ")
        synonyms = Trim(synonyms)
        synonyms = Replace(synonyms, "  ", " ")

        gSynonymArray = Split(synonyms)

    end if

    if IsArray(gSynonymArray) then

      Dim first,i,strElem
      for i=0 to UBound(gSynonymArray)
        strElem = gSynonymArray(i)
        if (Left(strElem,1)=".") then
          first = Mid(strElem,2)
        else
          if vID = strElem then
            ResolveSynonymLink = first
            exit function
          end if
        end if
      next
    End If

    ResolveSynonymLink = vID
end function

Function ReplacePageTokens(pPagename,pRootpage)
'        // Called in MultiLineMarkup and in many macros
'        // When called in MultilineMarkup, the token cannot be escaped
'        // inside a <code>block </code>
'        // If a Page Name contains the tokens
'        // @this,@parent,@grandparent or @greatgrandparent
'        // Then the tokens are replaced by relations of pRootpage
'
'        // Example1: pPagename=@this/ChildPage   pRootPage=AnyPage/SubPage
'        // Result would be: AnyPage/SubPage/ChildPage
'
'        // Example2: pPagename=@parent/ChildPage   pRootPage=AnyPage/SubPage
'        // Result would be: AnyPage/ChildPage
Dim aResult,tPage,p
        if (pRootPage="") then pRootPage=gPage '        // Default if blank 2nd parameter
'        If (Instr(pPagename,"@")= -1) then
'                // Getoutofjail
'                ReplacePageTokens=pPageName
'                Exit Function
'        End If
'        // Replace the fixed var tokens
        aResult = pPageName
        aResult = Replace(aResult,"@this",pRootpage,1,-1,1)
        aResult = Replace(aResult,"@username",gNameSpace.FetchUserName(),1,-1,1)
        aResult = Replace(aResult,"@serverroot",gServerRoot,1,-1,1)
        aResult = Replace(aResult,"@date",FormatDateTime(Now(),1),1,-1,1)
        aResult = Replace(aResult,"@time",FormatDateTime(Now(),3),1,-1,1)
        If cUseMultipleParents then
                aResult=Replace(aResult,"@greatgreatgreatgreatgrandparent","@parent/@parent/@parent/@parent/@parent/@parent")
                aResult=Replace(aResult,"@greatgreatgreatgrandparent","@parent/@parent/@parent/@parent/@parent")
                aResult=Replace(aResult,"@greatgreatgrandparent","@parent/@parent/@parent/@parent")
                aResult=Replace(aResult,"@greatgrandparent","@parent/@parent/@parent")
                aResult=Replace(aResult,"@grandparent","@parent/@parent")
                if Instr(aResult,"@parent") > 0 then
                        ReplacePageTokens=ReplaceParents(aResult,pRootpage)
                else
                        ReplacePageTokens=aResult
                End If
                Exit Function
        End If

        aResult=s(aResult,"@parent/","This syntax is not allowed!",true, true)
        if InstrRev(pRootpage,"/") then
                tPage=gPage
                p=InstrRev(tPage,"/")
                if (p > 1) then
                        tPage=Left(pRootpage,p-1)
                        aResult = Replace(aResult,"@parent",tPage)
                        p=InstrRev(tPage,"/")
                        if (p > 1) then
                                tPage=Left(pRootpage,p-1)
                                aResult = Replace(aResult,"@grandparent",tPage)
                                p=InstrRev(tPage,"/")
                                if (p > 1) then
                                        tPage=Left(pRootpage,p-1)
                                        aResult = Replace(aResult,"@greatgrandparent",tPage)
                                        p=InstrRev(tPage,"/")
                                        if (p > 1) then
                                                tPage=Left(pRootpage,p-1)
                                                aResult = Replace(aResult,"@greatgreatgrandparent",tPage)
                                                p=InstrRev(tPage,"/")
                                        End If
                                End If
                        End If
                End If
        End If
        ReplacePageTokens=aResult
End Function

Function ReplaceParents(pPagename,pRootpage)
Dim pParents,pParentTokens,parray,NumParents,ct
        ReplaceParents=pPagename '        // Default
        pParents=split(pRootpage & "/","/") '        // Put all the subpages into an array
        NumParents=UBound(pParents)-1 '        // Store the top element number of the array
        If NumParents=0 then Exit Function '        // Top page: Nothing for this function to do

        pParentTokens=pParents '        // Initialise an array of the right size
        pParentTokens(0)="@parent" '        // Seed the array
        If (NumParents > 0) then
                For ct= 1 to NumParents
                        pParents(ct)=pParents(ct - 1) & "/" & pParents(ct) ' // Make up correct array of links
                        pParentTokens(ct)=pParentTokens(ct-1) & "/@parent" '        // Make up the tokens
                Next
                pArray = pParentTokens '        // Temporary array of the right size
                For ct= 0 to NumParents-1
                        pArray(ct) = pParentTokens(NumParents - ct -1) '        // Order the tokens correctly
                        If (Instr(pPagename,pArray(ct)) > 0) then '        // Look for any @parent tokens of this type
                                pPagename=s(pPagename,pArray(ct),pParents(ct),true,true) ' // Replace instances of the tokens
                        End If
                Next
'        // Cannot error-trap for too many parents, as they have already been replaced by bad references
        End If
		ReplaceParents=pPagename '        // New value
End Function

Public Function ContainsFreeLinks(pPagename)
'	// Returns TRUE if any page or subpage is not in CamelCase form
'	// Called when cFreeLinks=0 by actionEdit and actionView
'	// Uses a RegEx to validate all pages and subpages to
'	// gStrictLinkPattern (defined in owpatterns.asp)
Dim vPageName,vTempArray,ct,NumSubPages
	ContainsFreeLinks=false '	// Default
	vPageName=Replace(pPageName,"%2F","/")
    vTempArray=split(vPagename & "/","/") '        // Put all the subpages into an array
	NumSubPages=UBound(vTempArray)-1'        // Store the top element number of the array
	For ct=0 to NumSubPages
		if m(vTempArray(ct),gStrictLinkPattern,False,False)=False then
			ContainsFreeLinks=True
			Exit Function
		end if
	Next
End Function


%>
