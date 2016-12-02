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
'                $Log: owmacros.asp,v $
'                Revision 1.105  2007/02/02 01:51:53  piixiiees
'                New macro TagSearch (included in wysiwyg editor)
'                Syntaxis (only one tag search):
'                  <TagSearch/>
'                  <TagSearch(ajax)/>
'
'                Revision 1.104  2007/01/29 21:48:16  sansei
'                changed ALT text from 'prueba' to picture filename in macro: ShowSharedImages
'
'                Revision 1.103  2006/08/10 01:20:23  piixiiees
'                Fixed bug with wrong number of "
'                // Replace parameters presented as "" with a true empty string
'                vParams = Replace(pParams,"""""","")
'
'                Revision 1.102  2006/04/20 01:00:25  piixiiees
'                Temporary copy of skins/common/*.* to evolution skin to be able to modify the structure of the skin without impacting to other skins.
'                New style of BrogressBar; now printable.
'                New file macros.xsl to include the templates for the macros.
'
'                Revision 1.101  2006/03/19 23:00:41  piixiiees
'                New option cUseInterWikiIcons to use icons for interwiki links:
'                 * cUseInterWikiIcons=0 Help:HelpEditing
'                 * cUseInterWikiIcons=1 ? HelpEditing (where ? is a small icon)
'                Style for thumbs of ShowSharedImages splitted from ow.css. Now thumbs.css is available for evolution skin
'
'                Revision 1.100  2006/03/18 20:03:39  piixiiees
'                *** empty log message ***
'
'                Revision 1.99  2006/03/18 19:53:19  piixiiees
'                Point Update 20060304.4
'                MacroShowSharedImages updated
'                 * cAllowImageLibrary checked
'                 * SyntaxErrorMessage included
'                 * parameters controlled
'                 * gImageExtensions validated
'                 * ow.css style updated: div.figure, div.figure p, img.scaled
'                Bug attachments fixed:
'                 * CreateFolders routine duplicated. The one in owuploadimage.asp renamed as CreateImageFolder
'
'                Revision 1.98  2006/03/14 08:57:50  gbamber
'                Enhancement: ErrorStack now more configerable
'                BugFix: hardcoded pages now display correctly
'                Test: <showsharedimages(foobar)> shows the errorstack at work
'
'                Revision 1.97  2006/03/13 20:48:15  piixiiees
'                Point update 20060304.2
'                owwikify.asp
'                New folder images in every skin. All the icons will be retrieved from the skin folder.
'                Change to use the link icons from this folder.
'                vLink = vLink & "<img src=""" & GetSkinDir() & "/images" & vImg & " border=""0"" hspace=""2"" alt=""""/>"
'
'                New macro ShowSharedImages to show all the files in the folder of shared images.
'                New styles included in ow.css files.
'
'                Revision 1.96  2006/02/22 12:56:31  gbamber
'                Build 20060216.6
'                Fixed problem in FireFox with ow:error in macro <showlinks>
'
'                Revision 1.95  2006/02/16 18:33:16  gbamber
'                General update:
'                Rename improved
'                local: now sharedimage:
'                New imageupload macro
'                added file uploadimage.asp
'                changed owall to fix #includes with attach.asp
'                new doctypes for google earth
'                new urltype skype
'                Userprefs has a password field
'                Reaname template updated
'
'                Revision 1.94  2005/12/10 08:38:08  gbamber
'                BUILD 20051210
'                New: <RedirectPage>
'                New <CreateSubPage>
'                BugFix: CreatePage macro code
'                BugFix: Userprefs back link
'                BugFix: CAPTCHA now works
'                BugFic: cUseFreeLinks=0 option works correctly
'                BugFix: Page rename partly repaired
'                BugFix: forceusername uses persistent cookie
'                //Gordon//
'
'                Revision 1.93  2005/11/07 20:47:11  sansei
'                Macro: ShowLinks now point to the new openwiking.com
'
'                Revision 1.92  2005/03/05 21:15:57  gbamber
'                BUGFIX: MacroBacklink
'
'                Revision 1.91  2005/03/01 06:08:38  sansei
'                added OPTIONAL new syntax for PageBookmarks
'                If a * (star) is present in the macro data then use multible pagebookmarks syntax, if NOT then use single syntax.
'
'                Revision 1.90  2005/01/24 17:25:14  sansei
'                Fixed Badge not working in Firefox like browsers
'
'                Revision 1.89  2005/01/21 20:35:00  sansei
'                Fixed skin default_left: fullsearch result not truncating MAIN bookmarks
'                Fixed skin default_left: not showing pagebookmarks bold
'                TextSearch can now use truncate syntax (see other truncate demo)
'                SummarySearch can now use truncate syntax (see other truncate demo)
'
'                Revision 1.88  2005/01/20 17:42:58  sansei
'                minor update - added linenumbers to ShowFile dumps.
'
'                Revision 1.87  2005/01/18 13:52:33  sansei
'                moved function OWGetFile(filepath) from The InlineXml plug to macroes.asp - because its a public function
'
'                Revision 1.86  2005/01/17 18:07:07  sansei
'                EDITOR: added dropdown with 'installed badges' from badges.txt
'                PAGE: badge macro can now show list from badges.txt
'
'                Revision 1.85  2004/12/11 15:41:47  sansei
'                Added cDatePagenameFormat - Giving different date-pagename options
'
'                Revision 1.84  2004/10/30 20:42:50  gbamber
'                Added gWikiAdministrator="Wikiadmin"
'                Added 'Delete this page' if using admin name and local IP
'                Changed FetchUsername function to owdb.asp
'                Added auto-success page
'
'                Revision 1.83  2004/10/30 13:06:52  gbamber
'                BugFixes
'                1 ) @tokens can now be escaped using syntax ~@token  {{{@token}}} removed.
'                2 ) Macro names now automatically added to StopWords list (if enabled)
'                3 ) <CreatePage> macro now defaults to current page as template
'                4 ) New option cSortCategories=1|0
'
'                Revision 1.82  2004/10/27 09:49:41  gbamber
'                Round-up of small changes and bugfixes
'
'                Revision 1.81  2004/10/19 12:35:13  gbamber
'                Massive serialising update.
'
'                Revision 1.80  2004/10/13 12:17:21  gbamber
'                Forced updates to make sure CVS reflects current work
'
'                Revision 1.79  2004/10/13 10:53:25  gbamber
'                Modified: <showlinks>
'                BugFix: SavePage for MSSQL server
'                Updated: default and default_left skins with summaries template
'
'                Revision 1.78  2004/10/13 00:18:01  gbamber
'                1 ) More debugging options (1,2 and 3)
'                2 ) <systeminfo(appname)>
'                3 ) OPENWIKI_FINDNAME = FindPage
'                4 ) TitleIndex shows summary text
'                5 ) Page links show summary text + Date changed
'                6 ) CategoryIndex shows page visits
'                7 ) More robust database autoupgrade
'
'                Revision 1.77  2004/10/11 12:53:38  gbamber
'                Added: <SummarySearch(PP)>
'                Modified: <ow:link> to show summaries
'
'                Revision 1.76  2004/10/07 14:27:30  gbamber
'                Added
'                cUseMultipleParents = 1|0 (default=1)
'                and ServerDown = 1|0 (default=0)
'
'                Revision 1.75  2004/10/06 09:49:19  gbamber
'                Added Accessibility for Macro Forms
'                Bugfix on page delete (owdb)
'
'                Revision 1.74  2004/10/03 18:17:23  gbamber
'                Experimental.
'                New option cAllowAnyPageName in owconfig_default
'                When cAllowAnyPageName=0 then pages cannot contain
'                1 ) Spaces
'                2 ) + characters
'                3 ) underscores
'                4 )  lowercase(space)lowercase
'                In other words, the page names are 'cleaned up
'
'                Revision 1.73  2004/10/03 17:01:25  gbamber
'                Added token @username for CreatePage, GoTo and CreateHomePage
'
'                Revision 1.72  2004/10/03 16:48:50  gbamber
'                Added <CreateHomePage(pageAsTemplate)>
'                Added waste:/ protocol
'                Updated macrohelp.csv
'
'                Revision 1.71  2004/10/03 10:40:49  gbamber
'                BugFix: <UserName> now prefers GetUserAlias()
'
'                Revision 1.70  2004/10/02 19:04:38  sansei
'                Refactor (temporary - needs total rewrite) Macro 'ShowLinks'
'
'                Revision 1.69  2004/10/02 17:17:20  sansei
'                Added truncate to macro: TitleSearch (Same syntax as Fullsearch-truncate!)
'
'                Revision 1.68  2004/10/02 17:02:57  gbamber
'                BugFix: Macros that take a pagename as a parameter will now accept @tokens and ./ and / syntax
'
'                Revision 1.66  2004/10/02 12:02:50  sansei
'                Added Fullsearch truncate facillity (Fullsearch macro now accepts one parameter!)
'
'                Revision 1.65  2004/10/01 11:35:19  gbamber
'                BugFix: <TitleHitIndex>
'
'                Revision 1.64  2004/09/29 10:32:06  gbamber
'                Bugfix:PageChanged macro
'                Updated my/mymacros docs
'                Bugfix: FirstnameLastname no-params
'
'                Revision 1.63  2004/09/29 09:43:25  gbamber
'                Page references fixed.
'
'                Revision 1.61  2004/09/28 16:02:08  gbamber
'                Lots of Error-trapping and BugFixes for when Macrohelp is disabled
'
'                Revision 1.59  2004/09/26 09:39:45  gbamber
'                cAllowWebframe config variable added
'
'                Revision 1.58  2004/09/22 10:17:24  gbamber
'                Added parameter to <TableOfContents> macro
'
'                Revision 1.57  2004/09/20 11:29:03  gbamber
'                Added <WebFrame> macro
'
'                Revision 1.56  2004/09/18 10:21:20  gbamber
'                Added <Highlight> macro
'
'                Revision 1.55  2004/09/17 09:27:29  gbamber
'                Bugfix for <CreatePage> and <GoTo> macros with no paramaters or textfield
'
'                Revision 1.54  2004/09/14 11:31:45  gbamber
'                Improved emoticon code.  Added <ListEmoticons> macro
'
'                Revision 1.53  2004/09/13 15:30:32  gbamber
'                Added Image,ImageList,Icon,IconList macros.
'                BugFixed other macros and error-trapping
'
'                Revision 1.52  2004/09/13 11:50:30  gbamber
'                Fixed Calendar bug
'                All macros now have a 'no parameter' version
'
'                Revision 1.51  2004/09/11 09:35:37  gbamber
'                Various minor bugfixes
'
'                Revision 1.50  2004/09/07 11:28:27  gbamber
'                Updated with IncludeOpenWikiPage
'
'                Revision 1.49  2004/09/05 11:36:37  sansei
'                removed wrong 'credit syntax' code ;)
'
'                Revision 1.48  2004/09/05 11:03:33  sansei
'                removed 'last' experimental code and refactored the 'badge' macro a bit
'
'                Revision 1.47  2004/09/03 18:06:24  gbamber
'                Added Macro <CategorySearch>
'
'                Revision 1.46  2004/09/03 17:16:40  sansei
'                refactor Badge code
'
'                Revision 1.45  2004/09/03 05:33:49  sansei
'                Added Macro: Badge (FlashButton removed!)
'
'                Revision 1.44  2004/09/02 23:28:02  gbamber
'                FlashButton macro update
'
'                Revision 1.42  2004/09/02 22:40:07  gbamber
'                FlashButton macro update
'
'                Revision 1.41  2004/09/02 19:13:47  gbamber
'                Added <TitleCategoryIndex> macro
'
'                Revision 1.40  2004/08/31 15:57:35  gbamber
'                Updated BackLink to take a text parameter
'
'                Revision 1.39  2004/08/28 01:03:56  gbamber
'                Added UserPreferences Skinning
'
'                Revision 1.38  2004/08/26 19:32:04  gbamber
'                Added gSystemSkin=OPENWIKI_ACTIVESKIN to owconfig_default
'                Fixed bug in <SystemInfo> macro
'
'                Revision 1.37  2004/08/25 08:59:33  gbamber
'                Added 2nd optional parameter for <AddBookmarks(list,heading)>
'
'                Revision 1.36  2004/08/24 18:30:42  gbamber
'                BugFix <AddBookmarks()>
'
'                Revision 1.35  2004/08/24 18:13:25  gbamber
'                <AddBookmarks()> added
'
'                Revision 1.34  2004/08/24 11:25:54  gbamber
'                Bugfix for <ActiveSkin(?)>
'
'                Revision 1.33  2004/08/24 10:57:32  gbamber
'                NEW: <ActiveSkin(SkinName[,1|2])> macro
'
'                Revision 1.31  2004/08/23 10:20:33  gbamber
'                Added: Lots of parameters for the <SystemInfo> macro.
'                see: <MacroHelp(systeminfo)>
'
'                Revision 1.30  2004/08/19 08:03:38  gbamber
'                Fixed Month(-1),Month(+1) macro code
'
'                Revision 1.29  2004/08/17 10:25:35  gbamber
'                Added <BuildNumber> macro
'
'                Revision 1.28  2004/08/12 12:08:33  gbamber
'                minor bugfix
'
'                Revision 1.26  2004/08/11 10:24:25  gbamber
'                Added new option in owdefault - cAutoComment.  Affects behaviour of edit mode:
'                1 = Comment field automatically filled in with username
'                0 = Blank comment field
'
'                Revision 1.25  2004/08/07 09:55:58  gbamber
'                Added ProgressBar macro
'
'                Revision 1.24  2004/08/04 22:33:28  gbamber
'                Added MacroHelp plugin.  Working, but not fully tested!
'
'                Revision 1.23  2004/08/04 09:08:33  gbamber
'                Minor Bugfix
'
'                Revision 1.22  2004/08/04 08:27:27  gbamber
'                Added Skin info to <systeminfo> macro.
'                Updated Build Number
'
'                Revision 1.21  2004/08/03 12:23:53  gbamber
'                Added <ShowMacroList> macro
'
'                Revision 1.20  2004/07/27 10:28:03  gbamber
'                Updated ShowLinks
'
'                Revision 1.19  2004/07/26 18:47:13  gbamber
'                Updated ShowLinks
'
'                Revision 1.18  2004/07/21 16:49:20  gbamber
'                Added links to <ShowLinks> macro
'
'                Revision 1.17  2004/07/21 16:41:13  gbamber
'                Added <ShowLinks> macro
'
'                Revision 1.16  2004/07/21 11:48:15  gbamber
'                Clean up code.  Make OpenWiki title a true variable.  Make 'adminpw' the admin password
'
'                Revision 1.15  2004/07/19 17:17:56  gbamber
'                Bad Link List plugin improved and bugfixed
'
'                Revision 1.14  2004/07/14 12:45:37  gbamber
'                <SystemInfo> change to show Version and Build.  New constant OPENWIKI_BUILD
'
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owmacros.asp,v $
'    $Revision: 1.105 $
'      $Author: piixiiees $
' ---------------------------------------------------------------------------
'
Sub ExecMacro(pMacro, pParams)
' On error resume next should be on, because in the event someone does e.g. <bogusmacroname>
    ' then it should nicely return.
    ' The side effect of having this option on is that if a programming error occurs in the
    ' processing of a macro, the programmer won't notice it.
'    On Error Resume Next
    Dim vMacro, vParams, vPos, vTemp1, vTemp2, vCmd
    vMacro  = pMacro
 '	// Replace parameters presented as "" with a true empty string
	vParams = Replace(pParams,"""""","")
'	// DEBUGGING START
'	RESPONSE.WRITE("pParams=" & pParams)
'	RESPONSE.WRITE("<BR>vParams=" & vParams)
'	// DEBUGGING END
	If vParams <> "" Then
        If IsNumeric(vParams) Then
            If InStr(vParams, ",") > 0 Then
                vMacro = vMacro & "P"
            End If
        Else
            If Mid(vParams, 2, 1) = """" Then
                vPos = InStr(3, vParams, """")
                If InStr(vPos, vParams, ",") > 0 Then
                    vMacro = vMacro & "P"
                End If
            Else
                vPos = InStr(vParams, ",")
                If vPos > 0 Then
                    vTemp1 = Mid(vParams, 2, vPos - 2)
                    If Not IsNumeric(vTemp1) Then
                        vTemp1 = """" & vTemp1 & """"
                    End If
                    vTemp2 = Mid(vParams, vPos + 1, Len(vParams) - vPos - 1)
                    If Not IsNumeric(vTemp2) Then
                        vTemp2 = """" & vTemp2 & """"
                    End If
                    vParams = "(" & vTemp1 & "," & vTemp2 & ")"
                    vMacro = vMacro & "P"
                Else
                    vParams = "(""" & Mid(vParams, 2, Len(vParams) - 2) & """)"
                End If
            End If
        End If
        vMacro = vMacro & "P"
    End If
'        // DEBUGGING START
'        Response.Write("<h4>" & vMacro & "</h4>")
'        // DEBUGGING END
    gMacroReturn = ""

    vCmd = "Macro" & vMacro & vParams
    vCmd = Replace(vCmd, vbCRLF, """ & vbCRLF & """)
'    Response.Write("<br />MACRO CMD: " & Server.HTMLEncode(vCmd))
    Execute("Call " & vCmd)
'    Response.Write("<br />" & gMacroReturn)
    If (gMacroReturn = "") Then
'        // Context-sensitive Help
        If (Instr(vMacro,"MacroHelp",1) = 0) then
                        vMacro=Replace(vMacro,"?","")
                        If (Right(vMacro,1)="P") then vMacro=Left(vMacro,LEN(vMacro)-1)
                        If (Right(vMacro,1)="P") then vMacro=Left(vMacro,LEN(vMacro)-1)
                        If (Right(vMacro,1)="P") then vMacro=Left(vMacro,LEN(vMacro)-1)
                                If plugins.Item("Macro Help") = 1 Then
                                        sReturn = GetMacroHelpList(vMacro)
                                else
                                        sReturn = SyntaxErrorMessage(vMacro,"Sorry.  No extra information available")
                                End If
                Else
                        If vParams <> "" Then
                                sReturn = SyntaxErrorMessage(vMacro & "(" & pParams & ")","Cannot execute this macro")
                        else
                                sReturn = SyntaxErrorMessage(vMacro,"Cannot execute this macro")
                        end if
        End If
    Else
	StoreRaw(gMacroReturn)
    End If
End Sub

' ==================================================================================
'        // Badge Macro Code by sEi'2004, 2005
Sub MacroBadge
        Call MacroBadgeP("")
End Sub

Sub MacroBadgeP(pParam)
        Dim bIsEmpty,tabs
        tabs = "  "
        if cAllowBadge and cAllowFlash then
                if (Trim(pParam)="") then '        // Trap empty parameter//
                        bIsEmpty = true
                        pParam = "label=Help|linkpage=Help"
                end if
                pParam=Server.HTMLEncode(pParam)
                gMacroReturn="<object classid=""clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"" codebase=""http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0"" width=""100"" height=""30"" id=""badge"" align=""middle"">" & vbcrlf
                gMacroReturn=gMacroReturn & tabs & "<param name=""allowScriptAccess"" value=""sameDomain"" />" & vbcrlf
                gMacroReturn=gMacroReturn & tabs & "<param name=""movie"" value=""ow/flash/badge.swf?parameters=" & pParam & """ />" & vbcrlf
                gMacroReturn=gMacroReturn & tabs & "<param name=""quality"" value=""high"" />" & vbcrlf
                gMacroReturn=gMacroReturn & tabs & "<param name=""bgcolor"" value=""#ffffff"" />" & vbcrlf
                gMacroReturn=gMacroReturn & tabs & "<embed src=""ow/flash/badge.swf?parameters=" & pParam & """ quality=""high"" bgcolor=""#ffffff"" width=""100"" height=""30"" name=""badge"" align=""middle"" allowScriptAccess=""sameDomain"" type=""application/x-shockwave-flash"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" />" & vbcrlf
                gMacroReturn=gMacroReturn & "</object>" & vbcrlf
                if (bIsEmpty) then
                        gMacroReturn=replace(MacroBadgeHelp,"[MACROBADGEHELP_TOKEN]",gMacroReturn) & vbcrlf
                        gMacroReturn=replace(gMacroReturn,"[MACROBADGEHELP_TOKEN2]","label=Help|linkpage=Help") & vbcrlf
                end if
        else
        if cAllowBadge then
                gMacroReturn = SyntaxErrorMessage("Badge","Sorry, The macro: ""Badge"" require the use of Flash Movies, and Flash has been disabled in this Wiki.")
        else
                gMacroReturn=SyntaxErrorMessage("Badge","Sorry, Badge has been disabled in this Wiki")
        end if
        end if
End Sub

'        // Use <Badge(param,1)> to display the HTML output
Sub MacroBadgePP(pParam,sParam)
        dim str,tabs,node,nodes
        tabs = "  "
        if cAllowBadge and cAllowFlash then
                Call MacroBadgeP(pParam)
                if (sParam <> "") then
                        select case ucase(sParam)
                        case "HELP" ' // help with the parameters inserted
                                gMacroReturn = replace(MacroBadgeHelp,"[MACROBADGEHELP_TOKEN]",gMacroReturn) & vbcrlf
                                gMacroReturn = replace(gMacroReturn,"[MACROBADGEHELP_TOKEN2]",pParam) & vbcrlf
                        case "BADGES" ' // Show badges list (xmlBadges)
								set nodes = FetchBadgeslistAsXml()
								gMacroReturn = "Installed BADGES:<ul>"
								for each node in nodes.childnodes
									gMacroReturn = gMacroReturn & "<li>" & node.text & "</li>" & vbcrlf
								next
								gMacroReturn = gMacroReturn & "</ul>"
                        case else ' //default output if second parameter unknown //
                                gMacroReturn = replace(MacroBadgeHelp,"[MACROBADGEHELP_TOKEN]",gMacroReturn) & vbcrlf
                                gMacroReturn = replace(gMacroReturn,"[MACROBADGEHELP_TOKEN2]",pParam) & vbcrlf
                                gMacroReturn= "MACRO: Badge - Second parameter: [" & ucase(sParam) & "] is UNKNOWN - Showing help:" & gMacroReturn
                        end select
                End If
        else
                gMacroReturn=SyntaxErrorMessage("Badge","Sorry, Badge has been disabled in this Wiki")
        end if
End Sub

Function MacroBadgeHelp()
        Dim str,tabs
        tabs = "  "
        str = vbcrlf
        str = str & "<table width=""100%"" border=""0"" cellpadding=""4"" cellspacing=""1"" bgcolor=""#000000"">" & vbcrlf
        str = str & tabs & "<tr>" & vbcrlf
        str = str & tabs & tabs & "<td bgcolor=""#eeeeee"">MACRO: <strong><code>&lt;Badge&gt;</code></strong></td>" & vbcrlf
        str = str & tabs & "</tr>" & vbcrlf
        str = str & tabs & "<tr>" & vbcrlf
        str = str & tabs & tabs & "<td bgcolor=""#FFFFFF"">Example code: <code><strong>&lt;Badge([MACROBADGEHELP_TOKEN2])/&gt;</strong></code><br/>RESULT: " & vbcrlf
        str = str & "[MACROBADGEHELP_TOKEN]"
        str = str & tabs & tabs & "</td>" & vbcrlf
        str = str & tabs & "</tr>" & vbcrlf
        str = str & tabs & "<tr>" & vbcrlf
        'str = str & tabs & tabs & "<td bgcolor=""#eeeeee"">HelpOnThis | HelpOnThat |</td>" & vbcrlf
        str = str & tabs & tabs & "<td align=""right"" bgcolor=""#eeeeee""></td>" & vbcrlf
        str = str & tabs & "</tr>" & vbcrlf
        str = str & "</table>" & vbcrlf
        MacroBadgeHelp = str
end function

' ==================================================================================

Sub MacroUploadimage()
		If cUseAccessibility then
			gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Upload Shared Image Form""><LEGEND>Upload new Shared Image (accessible)</LEGEND>" &_
				"<form name=""uploadimage"" action=""" & CDATAEncode(gScriptName) & "?p=" & gPage & "&amp;a=Imageupload""   encType=""multipart/form-data"" method=""post"">" & _
				"<LABEL FOR=""file"" LANG=""en"" TITLE=""Upload Shared Image"" ACCESSKEY=""U"" >File to <u>U</u>pload : </LABEL>" &_
				"<input type=""hidden"" name=""a"" value=""Imageupload"" />" & _
				"<input type=""file"" name=""file"" size=""60"" />" & _
				"<input id=""doit"" LANG=""en"" TITLE=""Upload"" type=""submit"" value=""Upload""/></form>" &_
				"</FIELDSET>"
		else
				gMacroReturn = "<form name=""uploadimage"" action=""" & CDATAEncode(gScriptName)  & "?p=" & gPage & "&amp;a=Imageupload"" encType=""multipart/form-data"" method=""post"">" & _
				"<input type=""hidden"" name=""a"" value=""Imageupload"" />" & _
				"<input type=""file"" size=""60"" name=""file"" ondblclick='event.cancelBubble=true;' />" & _
				"<input id=""goto"" type=""submit"" value=""Upload""/></form>"
		end if

End Sub

' ==================================================================================

Sub MacroTitleIndexP(family)
'	// Code by Alan Gregory 20060101
'	// SYNTAX: <TitleIndex[(ParentPageName)]>
'	// Action: Produces a list of page titles in the directory "family"
Dim vList, vCount, i, vResult, ChIndex
Set vList = gNamespace.TitleSearch(family & "/.*", 0, 0, 0, 0)
vCount = vList.Count - 1
If vList.Count = 0 Then
gMacroReturn = " - No Titles": Exit Sub
Else
For i = 0 To vCount: vResult = vResult & vList.ElementAt(i).ToXML(False): Next
End If
gMacroReturn = "<ow:titleindex>" & vResult & "</ow:titleindex>"
End Sub

' ==================================================================================

'       // Code by Gordon Bamber 20051204
'       // SYNTAX: <RedirectPage(validExternalURL[,Description Text])>
'		// Note: this macro will work even if html is disallowed on the Wiki
Sub MacroRedirectPagePP(vParam,vPageTitle)
Dim HTMLstr
'	// Check if setting in owconfig_default disallows this macro
	If cAllowRedirectPage then
'        // Check if URL starts with http://
		If NOT m(vParam, "(http://?.*)", False, True) then
                gMacroReturn=SyntaxErrorMessage("RedirectPage","Sorry - " & URLDecode(vParam) & " is not a recognised webpage URL")
				Exit Sub
		End If
'		// Start with the META_REFRESH block
'		// Note: It waits for 2 seconds to allow the anigif to show,
'		// and also give a user time to cancel the redirect
		HTMLstr = "<html>"
		HTMLstr = HTMLstr & "<meta http-equiv=""Refresh"" content=""2;URL=" & vParam & """ />"
		HTMLstr = HTMLstr & "</html>"
		If cShowRedirectPageloader=0 then
'		// Don't show a loader dialog - just a text message
			If vPageTitle = "" then
				HTMLstr = HTMLstr & "<ow:error>Redirecting to " & URLDecode(vParam) & "...</ow:error>"
			else
				HTMLstr = HTMLstr & "<ow:error>Redirecting to " & vPageTitle & "...</ow:error>"
			end if
		else
'		// Construct the loader dialog html code block
			HTMLstr = HTMLstr & "<table width=""100%"" height=""100"">"
			HTMLstr = HTMLstr & "<tr>"
			HTMLstr = HTMLstr & "<td align=""center"" valign=""middle"">"
			HTMLstr = HTMLstr & "<table width=""50%"" align=""center"" style=""border: 1 #666666 solid"">"
			HTMLstr = HTMLstr & "<tr>"
			HTMLstr = HTMLstr & "<td align=""center"">"
			HTMLstr = HTMLstr & "<span><br />"
'		// Show a Page description if there is one
			If vPageTitle = "" then
				HTMLstr = HTMLstr & "<b>" & URLDecode(vParam) & "<br />Loading... please wait!</b>"
			else
				HTMLstr = HTMLstr & "<b>" & vPageTitle & "<br />Loading... please wait!</b>"
			end if
			HTMLstr = HTMLstr & "<p /><img src=""" & OPENWIKI_IMAGEPATH & "/loading.gif""/>"
			HTMLstr = HTMLstr & "<p />The page still does not show? Click <a href=""" & URLDecode(vParam) & """>here</a><br /></span>"
			HTMLstr = HTMLstr & "</td>"
			HTMLstr = HTMLstr & "</tr>"
			HTMLstr = HTMLstr & "</table>"
			HTMLstr = HTMLstr & "</td>"
			HTMLstr = HTMLstr & "</tr>"
			HTMLstr = HTMLstr & "</table>"
		end if
'		// Return the whole HTML block
		gMacroReturn = HTMLstr
	else
'		// Macro was disallowed in owdefault_config
		gMacroReturn=SyntaxErrorMessage("RedirectPage","Sorry - this macro has been disabled by the Wiki administrator")
	end if
End Sub
	
'	// 1-Parameter version - OK
Sub MacroRedirectPageP(vParam)
'	// Just shows the URL, because there's no title supplied
	Call MacroRedirectPagePP(vParam,"")
End Sub

'        // No-parameter version - Error
Sub MacroRedirectPage
'        // This macro needs at least 1 parameter
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("redirectpage")
        else
                gMacroReturn = SyntaxErrorMessage("RedirectPage","This macro requires a valid URL in brackets")
        End If
End Sub

' ==================================================================================

'        // Code by Gordon Bamber 20040920
'        // SYNTAX1: <WebFrame(validURL)> - shows a 640 x 480 frame
'        // SYNTAX1: <WebFrame(validURL,big)> - shows a 800 x 600 frame
Sub MacroWebFramePP(vParam,bigFrame)
Dim ISIE,framestring,URLString,pWidth,pheight
  If cAllowWebFrame then
        If ( (bigFrame="") OR (Instr(bigframe,"small") > 0) ) then
                pWidth="640"
                pHeight="480"
        else
                pWidth="800"
                pHeight="600"
        end if
'        // This macro only works with Microsoft Internet Explorer
        ISIE=(Instr(Request.ServerVariables("HTTP_USER_AGENT"),"MSIE") > 0)
'        // Check against http://
		If NOT m(vParam, "(http://?.*)", False, True) then
                gMacroReturn=SyntaxErrorMessage("WebFrame","Sorry - " & URLDecode(vParam) & " is not a recognised webpage URL")
        Exit Sub
        End If
        If ISIE then
'                // Form a title row
                URLString="External Web Page - " & URLDecode(vParam)
'                // Form the body row
                framestring="<iframe src=""" & vParam & """ width=""" & pWidth & """ height=""" & pHeight & """ />"
'                // Present in a table with red borders, like <IncludeWikiPage>
                gMacroReturn = "<table width=""" & pWidth & """ height=""" & pHeight & """ border=""1"" bordercolor=""red"" cellpadding=""5""><tr><th align=""center"">" & URLString & "</th></tr><tr><td>" & framestring & "</td></tr></table>"
        else
'                // Trap for non-IE browsers
                gMacroReturn=SyntaxErrorMessage("WebFrame","Sorry, only Internet Explorer supports this macro")
        end if
  else
                gMacroReturn=SyntaxErrorMessage("WebFrame","WebFrame has been disabled in this Wiki")
  end if
End Sub

'        // Single-parameter version.  Shows a 640 x 480 frame
Sub MacroWebFrameP(vParam)
        Call MacroWebFramePP(vParam,"")
End Sub

'        // No-parameter version
Sub MacroWebFrame
'        // This macro needs at least 1 parameter
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("WebFrame")
        else
                gMacroReturn = SyntaxErrorMessage("WebFrame","This macro requires a valid webpage address in brackets")
        End If
End Sub

' ==================================================================================

'        // Code by Gordon Bamber
'        // Modified 20041016 Gordon Bamber
'        // Modified 20050301 sEi
Sub MacroAddBookmarksP(vParam)
	if instr(1,vParam,"*")>0 then 'use multiple Pagebookmarks syntax
        gPageBookmarks = gPageBookmarks & LinkifyPageBookmarks(replace(vParam,"*",""),"","pagebookmarks")
	else
	    gDefaultPageBookmarks=vParam
	    gDefaultPageBookmarksHeading=""
	end if
	gMacroReturn=" "'vParam
End Sub

Sub MacroAddBookmarksPP(vParam,hParam)
	if (instr(1,vParam,"*")>0) or (instr(1,hParam,"*")>0) then 'use multiple Pagebookmarks syntax
        gPageBookmarks = gPageBookmarks & LinkifyPageBookmarks(replace(vParam,"*",""),replace(hParam,"*",""),"pagebookmarks")
	else
        gDefaultPageBookmarks=vParam
        gDefaultPageBookmarksHeading=hParam
    end if
    gMacroReturn=" "'vParam
End Sub
'        // No-parameter version
Sub MacroAddBookmarks
        If plugins.Item("Macro Help") = 1 Then
                MacroMacroHelpP "AddBookmarks"
        else
                gMacroReturn = SyntaxErrorMessage("AddBookmarks","This macro requires at least a page name in brackets")
        End If
End Sub


' ==================================================================================
'        // Code by Gordon Bamber
'        // Switches the Active Skin
'        // vParam(String)=Name of Skin
'        // iParam(String)=0|1|2
'        //        0=Silently switch skin.  Show one space character.
'        //        1=Display information message
'        //         2=Display Macro itself
Sub MacroActiveSkinPP(vParam,iParam)
If (Len(Trim(vParam)) < 2) then
        If plugins.Item("Macro Help") = 1 Then
                MacroMacroHelpP "ActiveSkin"
        else
                gMacroReturn=SyntaxErrorMessage("ActiveSkin","This macro needs at least a valid Skin Name as a parameter")
                Exit Sub
        End If
End If
Dim sz_OldActiveSkin
        '        // Preserve the system skin name
        sz_OldActiveSkin=OPENWIKI_ACTIVESKIN
        '        // Switch to the new skin
        If vParam <> "" then OPENWIKI_ACTIVESKIN=Trim(vParam)

        '        // If the skin folder does not exist, switch back to the system skin and display error msg.
        If NOT FileExists(Server.MapPath(GetSkinDir & "/ow.xsl")) then
                OPENWIKI_ACTIVESKIN=sz_OldActiveSkin
                gMacroReturn=SyntaxErrorMessage("ActiveSkin","The skin name '" & vParam & "' has not been installed on this Wiki")
                Exit Sub
        End If

'        // New skin is valid.  Display depends on iParam.
        If iParam = "1" then
                gMacroReturn="<ow:error>Current " & OPENWIKI_TITLE & " skin is '" & vParam & "'</ow:error>"
        ElseIf iParam = "2" then
                gMacroReturn=CDATAEncode("<ActiveSkin(" & vParam & "," & iParam & ")>")
        else
                gMacroReturn=" "
        End If
End Sub
' ==================================================================================
'        // Single-parameter version for ease-of-use
Sub MacroActiveSkinP(vParam)
  Call MacroActiveSkinPP(vParam,0)
End Sub
'        // No-parameter version
Sub MacroActiveSkin
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("ActiveSkin")
        else
                gMacroReturn=SyntaxErrorMessage("ActiveSkin","This macro requires a skin name in brackets")
        End If
End Sub


' ==================================================================================
'        // Code by PerNilsson
'        // Modified Gordon Bamber 20040928
Sub MacroProgressBarPP(pWidth, pPercent)
'        // Trap for non-numeric parameters
  If ( (IsNumeric(pWidth)= false) OR (IsNumeric(pPercent)= false) ) then
                gMacroReturn = SyntaxErrorMessage("ProgressBar(" & pWidth & "," & pPercent & ")","Both parameters must be numbers")
                Exit Sub
  End If
'        // Trap for impossible percentage
  if ((pPercent < 1) OR (pPercent > 100)) then
                gMacroReturn = SyntaxErrorMessage("ProgressBar(" & pWidth & "," & pPercent & ")","Percent must be [0..100]")
                Exit Sub
  end if
'        // Trap for impossible width
  if ((pWidth < 1) OR (pWidth > 1000)) then
                gMacroReturn = SyntaxErrorMessage("ProgressBar(" & pWidth & "," & pPercent & ")","Pixel width must be [0..1000]")
                Exit Sub
  end if

'        // All OK, so proceed
  gMacroReturn= _
      "<ow:progressbar pbWidth=""" & pWidth & """ pbPercent=""" & pPercent & """ pbWidthPercent=""" & pPercent*pWidth/100 & """ pbPercentLeft=""" & 100-pPercent & """ />"
End sub

'        // 1-parameter version (not allowed)
Sub MacroProgressBarP(pParam)
        MacroProgressBar
End Sub

'        // No-parameter version
Sub MacroProgressBar
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("ProgressBar")
        else
                gMacroReturn = SyntaxErrorMessage("ProgressBar","This macro requires 2 parameters: (pixelWidth,Percent Done)")
        End If
End Sub

' ==================================================================================

Sub MacroPagechangedP(pParams)
    Dim vPage, vTimestamp
    If pParams = "" then
        Set vPage = gNamespace.GetPage(gPage, gRevision, False, False)
    Else
          pParams=ReplacePageTokens(pParams,gPage) '        // Substitute @this,@parent etc. references
      Set vPage = gNamespace.GetPage(AbsoluteName(pParams), gRevision, False, False)
    End If
    If vPage.Exists Then
        vTimestamp = vPage.GetLastChange().Timestamp()
        gMacroReturn = FormatDate(vTimestamp)
    else
        If plugins.Item("Macro Help") = 1 Then
                        Call MacroMacroHelpP("Pagechanged")
                else
                        gMacroReturn = SyntaxErrorMessage("Pagechanged(" & AbsoluteName(pParams) & ")","This page does not exist!")
                End If
    End If
End Sub
'        // No-parameter version
Sub MacroPagechanged
        Call MacroPagechangedP(gPage)
End Sub

' ==================================================================================

'	// SYNTAX: <CreatePage>
'	// Current page is used as the template
Sub MacroCreatePage
	Call MacroCreatePagePP(gPage,"")
End sub

'	// SYNTAX: <CreatePage(Page to use as a template)>
Sub MacroCreatePageP(pTemplatePage)
        Call MacroCreatePagePP(pTemplatePage,"")
End Sub

'	// SYNTAX: <CreatePage(Page to use as a template[,New page name to put in the dialog])>
Sub MacroCreatePagePP(pTemplatePage,pNewPageName)
'	// DEBUGGING START
'	RESPONSE.WRITE("pTemplatePage=" & pTemplatePage)
'	RESPONSE.WRITE("pNewPageName=" & pNewPageName)
'	// DEBUGGING END
Dim vPage,StrPageType,StrTemplate

		'   // Normalise the Template Page, if specified
        pTemplatePage=ReplacePageTokens(pTemplatePage,gPage) '        // Substitute @this,@parent etc. references
        pTemplatePage=AbsoluteName(pTemplatePage)'        // Substitute / and ./ references

        '	// Normalise the NewPageName Page, if it exists
		'	// An empty parameter is OK
        If (Trim(pNewPageName) <> "") then
          pNewPageName=ReplacePageTokens(pNewPageName,gPage) '        // Substitute @this,@parent etc. references
          pNewPageName=AbsoluteName(pNewPageName)'        // Substitute / and ./ references
		End If

		If (Trim(pTemplatePage) <> "") then
		'	// Does the specified Template page already exist as a page?
			Set vPage = gNamespace.GetPage(pTemplatePage, 0, False, False)
			If NOT vPage.Exists Then '	// Return an error message
				gMacroReturn = SyntaxErrorMessage("CreatePage(" & AbsoluteName(pTemplatePage) & ")","The specified template page '" & AbsoluteName(pTemplatePage) & "' does not exist!")
				Set vPage = Nothing
				Exit Sub
			End If
		End If

		' Differenciate between new pages and subpages
		StrPageType="Page"
		StrTemplate=""
        If (Trim(pTemplatePage) <> "") then StrTemplate = "using template """ & CDATAENCODE(pTemplatePage) & """" 
		If Instr(pNewPageName,"/") > 0 then StrPageType="SubPage"

		'	// If a new page name is specified, does it already exist?
		If (Trim(pNewPageName) <> "") then
			Set vPage = gNamespace.GetPage(pNewPageName, 0, False, False)
			If vPage.Exists Then '	// Return an error message
				gMacroReturn = SyntaxErrorMessage("CreatePage(" &  AbsoluteName(pTemplatePage) & "," & AbsoluteName(pNewPageName) & ")","The page '" & AbsoluteName(pNewPageName) & "' already exists,  You cannot create a duplicate!")
				Set vPage = Nothing
				Exit Sub
			End If
		End If

		Set vPage = Nothing
		If cUseAccessibility then
			gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Create New Page Form""><LEGEND>Create new " & StrPageType & " (accessible) " & StrTemplate & "</LEGEND>" &_
				"<form name=""CreatePage"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" & _
				"<LABEL FOR=""createtxt"" LANG=""en"" TITLE=""Create " & StrPageType & " Input"" ACCESSKEY=""R"" >C<u>r</u>eated " & StrPageType & " name: </LABEL>" &_
				"<input type=""hidden"" name=""a"" value=""edit"" />" & _
				"<input type=""hidden"" name=""template"" value=""" & pTemplatePage & """ />" & _
				"<input type=""text"" id=""createtxt"" LANG=""en"" TITLE=""Created " & StrPageType & " Input"" size=""30"" name=""p"" value=""" & CDATAEncode(pNewPageName) & """ ondblclick='event.cancelBubble=true;' />" & _
				"<input id=""goto"" LANG=""en"" TITLE=""Create " & StrPageType & " Submit"" type=""submit"" value=""Create" & StrPageType & """/></form>" &_
				"</FIELDSET>"
		else
				gMacroReturn = "<form name=""Create" & StrPageType & """ action=""" & CDATAEncode(gScriptName) & """ method=""get"">" & _
				"<input type=""hidden"" name=""a"" value=""edit"" />" & _
				"<input type=""hidden"" name=""template"" value=""" & pTemplatePage & """ />" & _
				"<input type=""text"" size=""30"" name=""p"" value=""" & CDATAEncode(pNewPageName) & """ ondblclick='event.cancelBubble=true;' />" & _
				"<input id=""goto"" type=""submit"" value=""Create" & StrPageType & """/></form>"
		end if
end sub

' ==================================================================================
'       // Code by Gordon Bamber 20041003
'		// Creates a new SubPage off the current page
'		// SYNTAX: <CreateSubPage[(Page to use as Template[,Name of new SubPage])]
Sub MacroCreateSubPagePP(pTemplatePage,pNewSubPageName)
	If Trim(pNewSubPageName)="" then pNewSubPageName = gPage & "/NewPage"
'	// Uncommenting the line below forces the subpage to be a copy of the current
'	If Trim(pTemplatePage)="" then pTemplatePage = gPage
    Call MacroCreatePagePP(pTemplatePage,gPage & "/" & pNewSubPageName)
End Sub

Sub MacroCreateSubPageP(pTemplatePage)
'	// Uncommenting the line below forces the subpage to be a copy of the current
'	If Trim(pTemplatePage)="" then pTemplatePage = gPage
    Call MacroCreatePagePP(pTemplatePage,gPage & "/NewPage")
End Sub
'        // No-parameter version - uses current page as template
Sub MacroCreateSubPage
    Call MacroCreatePagePP(gPage,gPage & "/NewPage")
end sub

' ==================================================================================
'        // Code by Gordon Bamber 20041003
Sub MacroCreateHomePageP(pTemplatePage)
If Trim(pTemplatePage)="" then pTemplatePage = gPage
        Call MacroCreatePagePP(pTemplatePage,"HomePages/" & gNameSpace.FetchUserName())
End Sub
'        // No-parameter version - uses current page as template
sub MacroCreateHomePage
        Call MacroCreatePagePP(gPage,"HomePages/" & gNameSpace.FetchUserName())
end sub

' ==================================================================================
'        // Original code by minghong
'        // Modified Gordon Bamber 20040928
Sub MacroAbbrPP(pAbbr, pTitle)
        If ( (Trim(pAbbr)="") OR (Trim(pTitle)="") ) then MacroAbbr '        // Raise error
        If IsIE then
           gMacroReturn = "<acronym style=""border-bottom: 1px dotted black;cursor:help"" title=""" & pAbbr & " : " & pTitle & """>" & pAbbr & "</acronym>"
        else
           gMacroReturn = "<abbr title=""" & pTitle & """>" & pAbbr & "</abbr>"
        end if
End Sub
'        // 1-parameter version
Sub MacroAbbrP(pAbbr)
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Abbr")
        else
                gMacroReturn = SyntaxErrorMessage("Abbr(" & pAbbr & ")","This macro requires 2 parameters:(AbbrText,NormalText)")
        End If
End Sub
'        // No-parameter version
Sub MacroAbbr
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Abbr")
        else
                gMacroReturn = SyntaxErrorMessage("Abbr","This macro requires 2 parameters:(AbbreviationLetters,NormalText)")
        End If
End Sub

' ==================================================================================
'        // Original code by minghong
'        // Modified Gordon Bamber 20040928
Sub MacroAcronymPP(pAcronym, pTitle)
        If ( (Trim(pAcronym)="") OR (Trim(pTitle)="") ) then MacroAcronym '        // Raise error
        If IsIE then
           gMacroReturn = "<acronym style=""border-bottom: 1px dotted black;cursor:help"" title=""" & pAcronym & " : " & pTitle & """>" & pAcronym & "</acronym>"
        else
           gMacroReturn = "<acronym title=""" & pTitle & """>" & pAcronym & "</acronym>"
        end if
End Sub
'        // 1-parameter version
Sub MacroAbbrP(pAcronym)
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Acronym")
        else
                gMacroReturn = SyntaxErrorMessage("Acronym(" & pAcronym & ")","This macro requires 2 parameters:(AcronymText,NormalText)")
        End If
End Sub
'        // No-parameter version
Sub MacroAcronym
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Acronym")
        else
                gMacroReturn = SyntaxErrorMessage("Acronym","This macro requires 2 parameters:(AcronymText,NormalText)")
        End If
End Sub
' ==================================================================================

'        // Fetch Referer. Code by Gordon Bamber
'        // Returns previously visited URL as Text
'        // Usage:
'        // <Referer>
Sub MacroReferer
Dim sResult
        sResult=CDATAEncode(Request.ServerVariables("HTTP_REFERER"))
        If (Trim(sResult)="") then
              gMacroReturn = " "
        else
                gMacroReturn = sResult
        End If
End Sub

' ==================================================================================

'        // Fetch Back Link. Code by Gordon Bamber
'        // Returns a live link to the last page visited
'        // Usage:
'        // Syntax1: <BackLink>
'                 // Syntax2: <BackLink(myText)>
Sub MacroBackLink
        MacroBackLinkP "Back"
End Sub

Sub MacroBackLinkP(vText)
if (Trim(vText) = "") then
                If plugins.Item("Macro Help") = 1 Then
                        Call MacroMacroHelpP("BackLink")
                        Exit Sub
                else
                        gMacroReturn = SyntaxErrorMessage("BackLink","You have supplied a blank parameter instead of no parameter")
                        Exit Sub
                End If
End If
Dim sResult
        sResult=CDATAEncode(Request.ServerVariables("HTTP_REFERER"))
        If (Trim(sResult)="") then
'	// Edit 20050303 Gordon Bamber //
            gMacroReturn = " "
        else
            gMacroReturn="<ow:link name='" & vText & "' href='" & sResult & "' date='" & FormatDateISO8601(Now()) &"'>" & vText & "</ow:link>"
        End If
End Sub

' ==================================================================================

'        // Original code by Dan Rawsthorne
'        // taken from http://openwiki.com/?OpenWiki/Suggestions
'        // Modified Gordon Bamber 20040928
Sub MacroGlossaryP(pParams)
        If (Trim(pParams)="") then
                MacroGlossary '        // Raise an error
                Exit Sub
        End If
    gMacroReturn = GetGlossaryP(pParams)
End Sub
'        // No-parameter version
Sub MacroGlossary
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Glossary")
        else
                gMacroReturn = SyntaxErrorMessage("Glossary","This macro requires text in brackets")
        End If
End Sub

Private Function GetGlossaryP(pPattern)
'        // Called by the MacroGlossary subs only
    Dim vList, vCount, i, vResult
    Set vList = gNamespace.FullSearch(pPattern, False)
    vCount = vList.Count - 1
    For i = 0 To vCount
        vResult = vResult & vList.ElementAt(i).ToXML(False)
    Next
    GetGlossaryP = "<ow:titleindex>" & vResult & "</ow:titleindex>"
End Function

' ==================================================================================

'        // TitleIndex sorted by pagevisits. Code by Gordon Bamber
'        // Usage:
'        // <TitleHitIndex()> or <TitleHitIndex(0)> = Full list
'        // <TitleHitIndex(n)> = Top n visited pages
Sub MacroTitleHitIndexP(iNumresults)
        if iNumResults="" then iNumResults=0
        gMacroReturn = gNamespace.GetIndexSchemes.GetTitleHitIndex(iNumresults)
End Sub
'        // No Parameter version
Sub MacroTitleHitIndex
        Call MacroTitleHitIndexP(0)
End Sub

' ==================================================================================

'        // Return the Bad Link List from the DB. Code by Gordon Bamber
'        // Usage:
'        // <BadLinkList>
Sub MacroBadLinkList
    gMacroReturn = GetBadLinkList '        // Routine in plugin code
End Sub

' ==================================================================================

'        // Return an ordered list of external referers. Code by Gordon Bamber
'        // Ignores google.
'        // Usage:
'        // <RefererList>
Sub MacroRefererList
        gMacroReturn = GetRefererList'         // Function in plugin code
End Sub

' ==================================================================================

sub MacroMonth
        gMacroReturn = printMonth(year(now()),month(now()))
end sub

sub MacroMonthP(pMonth)
        dim nDate
        if left(Cstr(pMonth),1) = "+" or left(Cstr(pMonth),1) = "-" then
                        nDate = DateAdd("m",CInt(pMonth),now())
                        gMacroReturn = printMonth(year(nDate),month(nDate))
                else
                        gMacroReturn = checkMonth(pMonth)
                if gMacroReturn = "" then gMacroReturn = printMonth(year(now()),pMonth)
            end if
end sub

sub MacroMonthPP(pYear,pMonth)
        if (not isnumeric(pYear)) then
                gMacroReturn = SyntaxErrorMessage("Month(<i>" & pYear & "</i>," & pMonth & ")","year not numeric")
                exit sub
        end if
        gMacroReturn = checkMonth(pMonth)
        if gMacroReturn = "" then gMacroReturn = printMonth(pYear,pMonth)
end sub

private function checkMonth(pMonth)
' checks for a numeric input within range 1-12
        if (not isnumeric(pMonth))then
                checkMonth = SyntaxErrorMessage("Month(" & pMonth & ")","month not numeric")
                Exit Function
        end if
        if (pMonth < 1 or pMonth > 12) then
                checkMonth = SyntaxErrorMessage("Month(" & pMonth & ")","month out of range [1-12]")
                Exit Function
        end if
end function

function printMonth(pYear,pMonth)
' this function does the output for Month, MonthP,MonthPP macros
        dim dateStart,dateEnd, i, sOutput, sTitle, sWikiLink, sDateLink,sDateName,d

        dateStart = dateserial(pYear,pMonth,1)
        dateEnd = dateAdd("m",1,dateStart)
        
        '---
        'Wrong date by one day??
        'Then use number 2 line instead!
        d = dateAdd("d",-Weekday(dateStart,0),  dateStart) ' sunday of week that starts in current month}}}
        'd = dateAdd("d",-Weekday(dateStart,0)+1,  dateStart) ' sunday of week that starts in current month}}}
        '---
        
        sTitle = MonthName(pMonth,false) & " " & pYear
        sOutput = "<ow:month title=""" & sTitle & """>"

        while d <= dateEnd
                sOutput = sOutput & "<ow:week>"
                for i = 0 to 6
                        sOutput = sOutput & "<ow:day>"
                        if Month(d)        = pMonth then
                        select case cDatePagenameFormat
							case "1" 'sortable long
                                sDateLink = "Date" & pYear & "-" & right("0" & pMonth,2) & "-" & right("0" & Day(d),2)
							case "2" 'sortable medium
                                sDateLink = "Date" & pYear & right("0" & pMonth,2) & right("0" & Day(d),2)
							case "3" 'sortable short
                                sDateLink = pYear & "-" & right("0" & pMonth,2) & "-" & right("0" & Day(d),2)
							case "4" 'sortable mini
                                sDateLink = pYear & right("0" & pMonth,2) & right("0" & Day(d),2)
                            case else '(0) default
                                sDateLink = "Date" & Day(d) & MonthName(pMonth,false) & pYear
                            end select
                            sDateName = Day(d)
                            sWikiLink = GetWikiLink("",sDateLink,sDateName)
                            If d=Date() then
                                    sOutput = sOutput & "<span style=""color:red;font-weight:bold;"">" & sWikiLink & "</span>"
                            Else
                                    sOutput = sOutput & sWikiLink
                            End If
                        else
                                sOutput = sOutput & "&#160;" ' nothing, date is not in our month
                        end if

                        sOutput = sOutput & "</ow:day>"
                        d=dateadd("d",1,d)
                next
                sOutput = sOutput & "</ow:week>"
        wend
        sOutput = sOutput & "</ow:month>"
        printMonth = sOutput
end function

' ==================================================================================

'        // Display page with most visits. Code by Gordon Bamber
'        // Usage:
'        // <MostPopularPage>
Sub MacroMostPopularPage
        gMacroReturn=gNamespace.GetMostPopularPage()
End Sub


' ==================================================================================

'        // Reset Page Hits count. Code by Gordon Bamber
'        // Usage:
'        // <ResetPageHits()> = Current Page
'        // <ResetPageHits(PageName)> = Named Page
Sub MacroResetPageHitsP(pPageName)
If (pPageName <> "") then
                Dim vPage
                Set vPage = gNamespace.GetPage(AbsoluteName(pPageName), gRevision, False, False)
                If vPage.Exists Then
                        Set vPage = Nothing
                        pPageName=ReplacePageTokens(pPageName,gPage) '        // Substitute @this,@parent etc. references
                        gMacroReturn=CStr(gNamespace.ResetPageHits(AbsoluteName(pPageName)))
                else
                        gMacroReturn=SyntaxErrorMessage("ResetPageHits(" & AbsoluteName(pPageName) & ")","This page does not exist in the Wiki")
                end if
Else
'        // Default to current page
        MacroResetPageHits
End If
End Sub
'        // No-Parameter version
Sub MacroResetPageHits
        gMacroReturn=CStr(gNamespace.ResetPageHits(gPage))
End Sub

' ==================================================================================

'        // Fetch Page Hits count. Code by Gordon Bamber
'        // Usage:
'        // <PageHits()> = Hits for Current Page
'        // <PageHits(PageName)> = Hits for Named Page
Sub MacroPageHitsP(pPageName)
If (pPageName <> "") then
                Dim vPage
                Set vPage = gNamespace.GetPage(AbsoluteName(pPageName), gRevision, False, False)
                If vPage.Exists Then
                        Set vPage = Nothing
                        pPageName=ReplacePageTokens(pPageName,gPage) '        // Substitute @this,@parent etc. references
                        gMacroReturn=CStr(gNamespace.GetPageHits(AbsoluteName(pPageName)))
                else
                        gMacroReturn=SyntaxErrorMessage("PageHits(" & AbsoluteName(pPageName) & ")","This page does not exist in the Wiki")
                end if
Else
'        // Default to current page
        MacroPageHits
End If
End Sub
'        // No-Parameter version
Sub MacroPageHits
'        // Default to current page
        gMacroReturn=CStr(gNamespace.GetPageHits(gPage))
End Sub

' ==================================================================================

'        // Reset total of all page visits on the site to zero. Code by Gordon Bamber
'        // Usage:
'        // <ResetAllPageHits>
Sub MacroResetAllPageHits
        gMacroReturn=CStr(gNamespace.ResetAllPageHits())
End Sub


' ==================================================================================

'        // Display total of all page visits on the site. Code by Gordon Bamber
'        // Usage:
'        // <AllPageHits>
Sub MacroAllPageHits
        gMacroReturn=CStr(gNamespace.GetAllPageHits())
End Sub


' ==================================================================================

'        // Fetch User Name. Code by Gordon Bamber
'        // Usage:
'        // <Username>
Sub MacroUsername
                gMacroReturn = gNameSpace.FetchUserName() '        // Call function in owdb.asp
End Sub

' ==================================================================================

'        // Fetch IP (and Host). Code by Gordon Bamber
'        // If Reverse DNS is inactivated, then only IP is returned
'        // Usage:
'        // <IP()> = IP address only
'        // <IP(Host)> = IP and hostname (if available, else just IP)
Sub MacroIPP(vParam)
        Dim IP,Host
        IP=Request.ServerVariables("REMOTE_ADDR")
        Host=Request.ServerVariables("REMOTE_HOST")
        If ((IP=Host) OR (vParam="")) then
                gMacroReturn=IP
        Else
                gMacroReturn=IP & "  (DNS name=" & Host & ")"
        End If
End Sub
'        // No-parameter version
Sub MacroIP
        Call MacroIPP("")
End Sub

' ==================================================================================

'                // Show list of installed Macros.  Code by Gordon Bamber
'                // Parameters: None
Sub MacroShowMacroList
                Dim s,vMacro
            s = "<ow:error>List of Macros available in this Wiki (some require parameters)</ow:error>"
                s = s & "<ol>"
                For Each vMacro In Split(gMacros, "|")
                        s = s & "<li>&lt;" & vMacro & "&gt;</li>"
                Next
                s = s & "</ol>"
                gMacroReturn = s
End Sub


' ==================================================================================

'                // Show Help text for a Macro.  Code by Gordon Bamber
'                // Parameter: Macroname or ?
'                // Uses plugin code
Sub MacroMacroHelpP(vParam)
                Dim s,vMacro
                If (vParam="") then
                        gMacroReturn = GetMacroHelpList("?")
                        Exit Sub
                End If

                gMacroReturn = GetMacroHelpList(vParam)'        // CALL PLUGIN//
End Sub
'        // No=parameter version
Sub MacroMacroHelp
        gMacroReturn = GetMacroHelpList("?")
End Sub

' ==================================================================================

Sub MacroShowLinks
'        gMacroReturn = "<ow:error>" & OPENWIKI_APPNAME & " links</ow:error>" &_
        gMacroReturn = "<ul><li><strong>" & OPENWIKI_APPNAME & " links</strong></li>" &_
        "<ul>" &_
        "<li>" &_
        OPENWIKI_APPNAME & " Portal: <a href='http://www.openwiking.com/' target='_top'>Main portal site OpenWikiNG.com</a>" &_
        "</li>" &_
        "<li>" &_
        OPENWIKI_APPNAME & " OpenWikiNG Wiki: <a href='http://www.openwiking.com/wiki/' target='_top'>OpenWikiNG Wiki</a>" &_
        "</li>" &_
        "<li>" &_
        OPENWIKI_APPNAME & " Forum: <a href='http://www.openwiking.com/forum/' target='_top'>OpenWikiNG Forum</a>" &_
        "</li>" &_
		"<li>" &_
        OPENWIKI_APPNAME & " SourceForge project site: <a href='https://sourceforge.net/projects/openwiki-ng/' target='_top'>OpenWikiNG Project site</a>" &_
        "</li>" &_
        "<li>" &_
        OPENWIKI_APPNAME & " Email contact: <a href='mailto:webmaster@openwiking.com'>webmaster@openwiking.com</a>" &_
        "</li>" &_
        "<li>" &_
        OPENWIKI_APPNAME & " Lauren Pit's OpenWiki site: <a href='http://www.openwiki.com/' target='_top'>OpenWiki.com</a>" &_
        "</li>" &_
        "<li>" &_
        OPENWIKI_APPNAME & "'s page on Lauren's OpenWiki site: <a href='http://www.openwiki.com/ow.asp?OpenWikiNG' target='_top'>OpenWikiNG page</a>" &_
        "</li>" &_
        "<li>" &_
        OPENWIKI_APPNAME & " <a href=""" & OPENWIKI_SCRIPTNAME & "?CreditsPage"" title=""Developers page"" target=""_blank"">Credits</a>" &_
        "</li>" &_
        "</ul>"
		gMacroReturn=gMacroReturn & "</ul>"
End Sub
' ==================================================================================

Sub MacroShowPlugins
' ** DEPENDS ON: owpatterns.asp, owplugins.asp **
' ** USES: plugins (Dictionary object declared in owplugins)
If NOT IsObject(plugins) then Exit Sub

        Dim ItemsArray, KeysArray,ct,thekey,thevalue
        If (plugins.Count > 0) then
                gMacroReturn = "<ow:error>Installed plugins: " & CDATAEncode(plugins.count) & "</ow:error><br /><br />"
                ItemsArray = plugins.Items
                KeysArray = plugins.Keys
                gMacroReturn = gMacroReturn & "<table class=""systeminfo"">" &_
                "<tr>" &_
                "<th>Plugin Name</th>" &_
                "<th>Plugin Status</th>" &_
                "</tr>"
                For ct=0 to plugins.count-1
                        thekey=KeysArray(ct)
                        theValue=ItemsArray(ct)
                        If theValue = 1 Then
                                theValue = "Active"
                        Else
                                theValue = "Inactive"
                        End If
                        gMacroReturn = gMacroReturn & "<tr>" &_
                        "<td>" & thekey & " plugin</td>" &_
                        "<td>" & theValue & "</td>" &_
                        "</tr>"
                next
                gMacroReturn = gMacroReturn & "</table>"
        Else
                gMacroReturn = "<ow:error>No plugins installed or active</ow:error>"
        End If
End Sub

' ==================================================================================
'        // TODO: Why are there 2 similar functions here? - Gordon 20040913
Private Function DisplayPlugins
' ** UsedBy <systeminfo> macro
' ** DEPENDS ON: owpatterns.asp, owplugins.asp **
' ** USES: plugins (Dictionary object declared in owplugins)
        Dim s
        If NOT IsObject(plugins) then Exit Function
        Dim ItemsArray, KeysArray,ct,thekey,thevalue
        If (plugins.Count > 0) then
                ItemsArray = plugins.Items
                KeysArray = plugins.Keys
                s = "<tr>" &_
                "<td>Installed Plugins</td>" &_
                "<td>" & CDATAEncode(plugins.count) & "</td>" &_
                "</tr>"
                For ct=0 to plugins.count-1
                        thekey=KeysArray(ct)
                        theValue=ItemsArray(ct)
                        If theValue = 1 Then
                                theValue = "Active"
                        Else
                                theValue = "Inactive"
                        End If
                        s = s & "<tr>" &_
                        "<td>" & thekey & " plugin</td>" &_
                        "<td>" & theValue & "</td>" &_
                        "</tr>"
                next
                DisplayPlugins = s
        Else
                DisplayPlugins = "<tr><td>No plugins installed or active</td></tr>"
        End If
End Function


' ==================================================================================
'        Usage:
'        <RecentChangesSearch(searchterm,[[NumDays|]NumEntriesToShow]>
Sub MacroRecentChangesSearchP(pPattern)
        Dim sDays, sNrOfChanges, sParams
        sDays = OPENWIKI_RCDAYS
        sNrOfChanges = "9999"
        sParams = sDays & "|" & sNrOfChanges
    Call MacroRecentChangesSearchPP(pPattern, sParams)
End Sub

Sub MacroRecentChangesSearchPP(pPattern, pParams)
        Dim pDays, pNrOfChanges, nPipe
        nPipe = InStr(pParams,"|")
        If ( nPipe > 0 ) Then
                pDays = Left(pParams, (nPipe - 1))
                pNrOfChanges = Mid(pParams, (nPipe+1))
        Else
                pDays = OPENWIKI_RCDAYS
                pNrOfChanges = pParams
        End If
    If Not IsNumeric(pDays) Or Not IsNumeric(pNrOfChanges) Then
        Exit Sub
    End If
    If pDays <= 0 Then
        pDays = OPENWIKI_RCDAYS
    End If
    If pNrOfChanges <= 0 Then
        pNrOfChanges = 0
    End If
    gMacroReturn = gNamespace.GetIndexSchemes.GetRecentChangesEx(pPattern, false, true, pDays, pNrOfChanges, 1, True)

End Sub
'        //No-parameter version
Sub MacroRecentChangesSearch
    Call MacroRecentChangesPP(OPENWIKI_RCDAYS, 9999)
End Sub

' ==================================================================================

Sub MacroRecentChangesSearchLongP(pPattern)
    Dim vDays, vMaxNrOfCha
    nges, vFilter
    vDays = GetIntParameter("days")
    vMaxNrOfChanges = GetIntParameter("max")
    vFilter = GetIntParameter("filter")
    If vDays <= 0 Then
        vDays = OPENWIKI_RCDAYS
    End If
    If vMaxNrOfChanges <= 0 Then
        If gAction = "rss" Then
            vMaxNrOfChanges = 15
        Else
            vMaxNrOfChanges = 9999
        End If
    End If
    If vFilter = 0 Then
        vFilter = 1  ' major edits only
    Elseif vFilter = 3 Then
        vFilter = 0  ' major and minor edits
    End If
    gMacroReturn = gNamespace.GetIndexSchemes.GetRecentChangesEx(pPattern, false, true, vDays, vMaxNrOfChanges, vFilter, False)
End Sub
'        // No-parameter version
Sub MacroRecentChangesSearchLong
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("RecentChangesSearchLong")
        else
                gMacroReturn=SyntaxErrorMessage("RecentChangesSearchLong","This macro requires search text as a parameter in brackets")
        End If
End Sub


' ==================================================================================
'        // Code by Gordon Bamber 20040922

'        // SYNTAX1: <TableOfContents(1)>
'        // Table of contents lists headings AFTER the macro.
'        // SYNTAX2: <TableOfContents>
'        // Table of contents lists all headings.
Sub MacroTableOfContentsP(pParam)
    If cUseHeadings Then
                If pParam <> "" then
                        gMacroReturn = gFS & "TOC1" & gFS
                else
                        gMacroReturn = gFS & "TOC" & gFS
        End If
    End If
End Sub

Sub MacroTableOfContents
    If cUseHeadings Then
        gMacroReturn = gFS & "TOC" & gFS
        ' at the end of the Wikify function this pattern will be
        ' replaced by the actual table of contents
    End If
End Sub

' ==================================================================================

Sub MacroBR
    gMacroReturn = "<br />"
End Sub

' ==================================================================================

Sub MacroHighlightP(pParam)
        If (pParam <> "") then
                Dim vPage
                pParam=ReplacePageTokens(pParam,gPage) '        // Substitute @this,@parent etc. references
                pParam=AbsoluteName(pParam)'        // Substitute / and ./ references

                Set vPage = gNamespace.GetPage(pParam, gRevision, False, False)
                If vPage.Exists Then
                        Set vPage = Nothing
                If cUseAccessibility then
                gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Highlight Word Form""><LEGEND>Highlight Word (accessible)</LEGEND>" &_
                                "<form name=""Highlight"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
                "<LABEL FOR=""hitxt"" LANG=""en"" TITLE=""Highlight Text Input"" ACCESSKEY=""H"" ><u>H</u>ighlight text: </LABEL>" &_
                                "<input type=""hidden"" name=""a"" value=""view""/>" &_
                                "<input type=""hidden"" name=""p"" value=""" & CDataEncode(pParam) & """/>" &_
                                " <input type=""text"" LANG=""en"" TITLE=""Highlight Text Input"" id=""hitxt"" name=""highlight"" value="""" ondblclick='event.cancelBubble=true;' />" &_
                                "<input id=""DOIT"" LANG=""en"" TITLE=""Highlight Text Submit"" type=""submit"" value=""Do Highlight""/></form>" &_
                                "</FIELDSET>"
                        else
                                gMacroReturn = "<form name=""Highlight"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
                                "<input type=""hidden"" name=""a"" value=""view""/>" &_
                                "<input type=""hidden"" name=""p"" value=""" & CDataEncode(pParam) & """/>" &_
                                "<br/>Text to highlight on page '" & CDataEncode(pParam)  & "'" &_
                                "<br/><input type=""text"" name=""highlight"" value="""" ondblclick='event.cancelBubble=true;' />" &_
                                "<input id=""DOIT"" type=""submit"" value=""Do Highlight""/></form>"
                        end if
                else
                        gMacroReturn=SyntaxErrorMessage("Highlight(" & pParam & ")","This page does not exist in the Wiki")
                end if
        Else
                If plugins.Item("Macro Help") = 1 Then
                        Call MacroMacroHelpP("Highlight")
                else
                        gMacroReturn=SyntaxErrorMessage("Highlight","This macro requires a page name as a parameter in brackets")
                End If
        End If
End Sub

' ==================================================================================
'        // No-parameter version
Sub MacroHighlight
        Call MacroHighlightP(gPage)
End Sub

' ==================================================================================

Sub MacroSummarySearch
'        cUseAccessibility=1
If cUseAccessibility then
    gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Summary Search Form""><LEGEND>Summary Search (accessible)</LEGEND>" &_
    "<form name=""SummarySearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
     "<LABEL FOR=""summarysrch"" LANG=""en"" TITLE=""Summary Search Input"" ACCESSKEY=""M"" >Su<u>m</u>mary: </LABEL>" &_
    "<input type=""hidden"" name=""a"" value=""summarysearch""/>" &_
    "<input type=""text"" LANG=""en"" TITLE=""Summary Search Input"" id=""summarysrch"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mts"" type=""submit"" LANG=""en"" TITLE=""Summary Search Submit"" value=""Do Summary Search""/></form>" &_
     "</FIELDSET>"

else
    gMacroReturn = "<form name=""SummarySearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<input type=""hidden"" name=""a"" value=""summarysearch""/>" &_
    "<input type=""text"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mss"" type=""submit"" value=""Do Summary Search""/></form>"
end if
End Sub

Sub MacroSummarySearchP(pParam)
        gTitlesearchTemp = ""
    gMacroReturn = gNamespace.GetIndexSchemes.GetSummarySearch(pParam)
End Sub

Sub MacroSummarySearchPP(pParam,pTruncate)
    gTitlesearchTemp = pTruncate
    'gMacroReturn = "<ow:error>TRON: Have additional parameters: [" & trim(pTruncate) & "] and gTitlesearchTemp: [" & gTitlesearchTemp & "]</ow:error>"
    gMacroReturn = gMacroReturn & gNamespace.GetIndexSchemes.GetSummarySearch(pParam)
End Sub

' ==================================================================================

Sub MacroTitleSearch
'        cUseAccessibility=1
If cUseAccessibility then
    gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Title Search Form""><LEGEND>Title Search (accessible)</LEGEND>" &_
    "<form name=""TitleSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
     "<LABEL FOR=""titlesrch"" LANG=""en"" TITLE=""Title Search Input"" ACCESSKEY=""I"" >T<u>i</u>tle: </LABEL>" &_
    "<input type=""hidden"" name=""a"" value=""titlesearch""/>" &_
    "<input type=""text"" LANG=""en"" TITLE=""Title Search Input"" id=""titlesrch"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mts"" type=""submit"" LANG=""en"" TITLE=""Title Search Submit"" value=""Do Title Search""/></form>" &_
     "</FIELDSET>"

else
    gMacroReturn = "<form name=""TitleSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<input type=""hidden"" name=""a"" value=""titlesearch""/>" &_
    "<input type=""text"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mts"" type=""submit"" value=""Do Title Search""/></form>"
end if
End Sub

Sub MacroTitleSearchP(pParam)
        gTitlesearchTemp = ""
    gMacroReturn = gNamespace.GetIndexSchemes.GetTitleSearch(pParam)
End Sub

Sub MacroTitleSearchPP(pParam,pTruncate)
    gTitlesearchTemp = pTruncate
    'gMacroReturn = "<ow:error>TRON: Have additional parameters: [" & trim(pTruncate) & "] and gTitlesearchTemp: [" & gTitlesearchTemp & "]</ow:error>"
    gMacroReturn = gMacroReturn & gNamespace.GetIndexSchemes.GetTitleSearch(pParam)
End Sub

' ==================================================================================

Sub MacroCategorySearch
if cUseCategories then
'        // Debugging line
'        cUseAccessibility=1
Dim ct

        If cUseAccessibility then
                gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Category Search Form""><LEGEND>Category Search (accessible)</LEGEND>" &_
                "<form name=""CategorySearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
                "<LABEL FOR=""cateselect"" LANG=""en"" TITLE=""Category Selection"" ACCESSKEY=""C"" ><u>C</u>ategory: </LABEL>" &_
                "<input type=""hidden"" name=""a"" value=""categorysearch""/>" &_
                "<select name=""categorynumber"" id=""cateselect"">" &_
                "<option name=""mcopt"" value=""0"" >All categorised pages</option>"
                For ct = 1 to UBound(gCategoryArray)-1
                        If gCategoryArray(ct) <> "" then
                                gMacroReturn = gMacroReturn & "<option name=""mcopt"" value=""" & CStr(ct) & """ >" & CDATAEncode(gCategoryArray(ct)) & "</option>"
                        End If
                Next
                gMacroReturn = gMacroReturn & "</select>" &_
                " <input id=""doit"" type=""submit"" LANG=""en"" TITLE=""Category Search Submit"" value=""Do Category Search""/>" &_
                "</form>" &_
                "</FIELDSET>"
        else
                gMacroReturn="<form name=""CategorySearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
                "<input type=""hidden"" name=""a"" value=""categorysearch""/>" &_
                "<select name=""categorynumber"" id=""cateselect"">" &_
                "<option name=""mcopt"" value=""0"" >All categorised pages</option>"
                For ct = 1 to UBound(gCategoryArray)-1
                        If gCategoryArray(ct) <> "" then
                                gMacroReturn = gMacroReturn & "<option name=""mcopt"" value=""" & CStr(ct) & """ >" & CDATAEncode(gCategoryArray(ct)) & "</option>"
                        End If
                Next
                gMacroReturn = gMacroReturn & "</select>" &_
                " <input id=""doit"" type=""submit"" LANG=""en"" TITLE=""Category Search Submit"" value=""Do Category Search""/>" &_
                "</form>"
        end if
else
        gMacroReturn=SyntaxErrorMessage("CategorySearch","Categories are not enabled on this Wiki")
end if
End Sub

' ==================================================================================

Sub MacroFullSearch
'        cUseAccessibility=1
If cUseAccessibility then
    gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Full text Search Form""><LEGEND>Full text Search (accessible)</LEGEND>" &_
    "<form name=""FullSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<LABEL FOR=""fsrchtxt"" LANG=""en"" TITLE=""Full Search Input"" ACCESSKEY=""U"" >F<u>u</u>llSearch: </LABEL>" &_
    "<input type=""hidden"" name=""a"" value=""fullsearch""/>" &_
    "<input type=""text"" id=""fsrchtxt"" LANG=""en"" TITLE=""Full Search Input""  name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mfs"" LANG=""en"" TITLE=""Full Search Submit"" type=""submit"" value=""Do Full Search""/></form>" &_
    "</FIELDSET>"
else
    gMacroReturn = "<form name=""FullSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<input type=""hidden"" name=""a"" value=""fullsearch""/>" &_
    "<input type=""text"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mfs"" type=""submit"" value=""Do Full Search""/></form>"
end if
End Sub

Sub MacroFullSearchP(pParam)
        gFullsearchTemp = ""
    gMacroReturn = gNamespace.GetIndexSchemes.GetFullSearch(pParam, True)
End Sub

Sub MacroFullSearchPP(pParam,pTruncate)
    gFullsearchTemp = pTruncate
    'gMacroReturn = "<ow:error>TRON: Have additional parameters: [" & trim(pTruncate) & "] and gFullsearchTemp: [" & gFullsearchTemp & "]</ow:error>"
    gMacroReturn = gMacroReturn & gNamespace.GetIndexSchemes.GetFullSearch(pParam, True)
End Sub

' ==================================================================================

Sub MacroTextSearch
If cUseAccessibility then
    gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Page text Search Form""><LEGEND>Page text Search (accessible)</LEGEND>" &_
    "<form name=""TextSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<LABEL FOR=""tsrchtxt"" LANG=""en"" TITLE=""Page text Search Input"" ACCESSKEY=""G"" >Pa<u>g</u>e text Search: </LABEL>" &_
    "<input type=""hidden"" name=""a"" value=""textsearch""/>" &_
    "<input type=""text"" id=""tsrchtxt"" LANG=""en"" TITLE=""Page text Search Input"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mfs"" type=""submit"" LANG=""en"" TITLE=""Page text Search Submit"" value=""Do Text Search""/></form>" &_
    "</FIELDSET>"
else
    gMacroReturn = "<form name=""TextSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<input type=""hidden"" name=""a"" value=""textsearch""/>" &_
    "<input type=""text"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mfs"" type=""submit"" value=""Do Text Search""/></form>"
end if
End Sub

Sub MacroTextSearchP(pParam)
    gFullsearchTemp = ""
    gMacroReturn = gNamespace.GetIndexSchemes.GetFullSearch(pParam, False)
End Sub

Sub MacroTextSearchPP(pParam,pTruncate)
    gFullsearchTemp = pTruncate
    gMacroReturn = gNamespace.GetIndexSchemes.GetFullSearch(pParam, False)
End Sub

' ==================================================================================

Sub MacroGoToP(pPagename)
'gMacroReturn=ReplacePageTokens(pPagename,gPage)
' Exit Sub
'        // Deal with the Page Name
If (Trim(pPagename) <> "") then
  pPagename=ReplacePageTokens(pPagename,gPage) '        // Substitute @this,@parent etc. references
  pPagename=AbsoluteName(pPagename)'        // Substitute / and ./ references
End If

If cUseAccessibility then
    gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Go To Page Form""><LEGEND>Go To Page (accessible)</LEGEND>" &_
    "<form name=""GoTo"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<LABEL FOR=""gototxt"" LANG=""en"" TITLE=""Go To Page Input"" ACCESSKEY=""O"" >G<u>o</u> To: </LABEL>" &_
    "<input type=""text"" id=""gototxt"" LANG=""en"" TITLE=""Go To Page Input"" name=""p"" value=""" & CDATAEncode(pPagename) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""goto"" type=""submit"" value=""Find/Make Page""/></form>" &_
    "</FIELDSET>"
else
    gMacroReturn = "<form name=""GoTo"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<input type=""text"" name=""p"" value=""" & CDATAEncode(pPagename) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""goto"" type=""submit"" value=""Find/Make Page""/></form>"
end if
End Sub
'        // No-parameter version
Sub MacroGoTo
        Call MacroGoToP("")
End Sub
' ==================================================================================
'        // Code by Gordon Bamber
Sub MacroSystemInfoP(vParam)
        If vParam = "" then MacroSystemInfo
        vParam=Trim(LCase(vParam))
        Select Case vParam
                Case "buildnumber":
                        gMacroReturn=OPENWIKI_BUILD
                Case "version":
                        gMacroReturn=OPENWIKI_VERSION
                Case "skin":
                    if gUserSkin = "" then
                                gMacroReturn="Default Skin"
                        else
                                gMacroReturn=Capitalise(Replace(gUserSkin,"_"," "))
                        End If
                Case "systemskin":
                        if gSystemSkin = "" then
                           gSystemSkin="Default Skin"
                        else
                            gSystemSkin=Replace(gSystemSkin,"_"," ")
                        End If
                        gMacroReturn=Capitalise(gSystemSkin)
                Case "plugins":
                        Call MacroShowPlugins
                Case "pages":
                                gMacroReturn=CStr(gNamespace.GetPageCount())
                Case "revisions":
                                gMacroReturn=CStr(gNamespace.GetRevisionsCount())
                Case "pagehits":
                                gMacroReturn=CStr(gNamespace.GetAllPageHits())
                Case "mostpopularpage":
                                gMacroReturn=gNamespace.GetMostPopularPage()
                Case "uploadmethod":
                                If OPENWIKI_UPLOADMETHOD=UPLOADMETHOD_SAFILEUP then
                                        gMacroReturn="SA-FileUp component"
                                ElseIf OPENWIKI_UPLOADMETHOD=UPLOADMETHOD_ABCUPLOAD then
                                        gMacroReturn="ABC Upload component"
                                Else
                                        gMacroReturn="Native ASP (Lewis Moten)"
                                End If
                Case "database":
                                Select Case OPENWIKI_DB_SYNTAX
                                        Case DB_ORACLE:gMacroReturn="Oracle server"
                                        Case DB_MYSQL:gMacroReturn="MySQL server"
                                        Case DB_POSTGRESQL:gMacroReturn="PostGreSQL server"
                                        Case DB_SQLSERVER:gMacroReturn="MS SQL server"
                                        Case Else
                                                gMacroReturn="MS Access (File-based)"
                                End Select
                Case "title":
                                gMacroReturn=OPENWIKI_TITLE
                Case "appname":
                                gMacroReturn=OPENWIKI_APPNAME
                Case "timezone":
                                gMacroReturn="GMT " & OPENWIKI_TIMEZONE
                Case "deprecatedays":
                                gMacroReturn=OPENWIKI_DAYSTOKEEP
                Case "bookmarks":
                                gMacroReturn=gDefaultBookmarks
                Case "attachments":
                                if cAllowAttachments=1 then
                                        gMacroReturn="allowed"
                                else
                                        gMacroReturn="disallowed"
                                end if
                Case "accessibility":
                                if cUseAccessibility=1 then
                                        gMacroReturn="on"
                                else
                                        gMacroReturn="off"
                                end if
                Case "imagelibrary":
                                if cAllowImageLibrary=1 then
                                        gMacroReturn="allowed"
                                else
                                        gMacroReturn="disallowed"
                                end if
                Case "html":
                                if cRawHtml=1 then
                                        if cHtmlTags=1 then
                                                gMacroReturn="all tags allowed"
                                        else
                                                gMacroReturn="allowed but restricted"
                                        end if
                                else
                                        gMacroReturn="disallowed"
                                end if
                Case "imageextensions":
                        gMacroReturn="<ow:error>Image extensions allowed in this Wiki:</ow:error>" &_
                        "<ol>" &_
                        "<li>." & join(split(gImageExtensions,"|"),"</li><li> .") &_
                        "</li></ol>"
                Case "docextensions":
                        gMacroReturn="<ow:error>Document extensions allowed in this Wiki:</ow:error>" &_
                        "<ol>" &_
                        "<li>." & join(split(gDocExtensions,"|"),"</li><li> .") &_
                        "</li></ol>"
                Case Else
                        If plugins.Item("Macro Help") = 1 Then
                                Call MacroMacroHelpP("SystemInfo")
                        Else
                                Dim systeminfoerror
                                systeminfoerror=SyntaxErrorMessage("SystemInfo","Unknown parameter """ & vParam & """ passed to &lt;SystemInfo()&gt; macro")
                                Call MacroSystemInfo
                                gMacroReturn = systeminfoerror & gMacroReturn
                        End If
        End Select
End Sub

' ==================================================================================

Sub MacroSystemInfo
    On Error Resume Next
    Dim vFSO, vFile,vSkinName
    if OPENWIKI_ACTIVESKIN = "" then
                vSkinName="Default Skin"
        else
                vSkinName=Replace(OPENWIKI_ACTIVESKIN,"_"," ")
        End If
    if gSystemSkin = "" then
                gSystemSkin="Default Skin"
        else
                gSystemSkin=Replace(gSystemSkin,"_"," ")
        End If
    Set vFSO = server.CreateObject("Scripting.FileSystemObject")
    Set vFile = vFSO.GetFile(Server.MapPath(Request.ServerVariables("SCRIPT_NAME")))
    Dim vRev
    gMacroReturn = "<table class=""systeminfo"">" _
            & "<tr><td>" & OPENWIKI_TITLE & " Version:</td><td>" & OPENWIKI_VERSION & "  Build:" & OPENWIKI_BUILD & "</td></tr>" _
            & "<tr><td>XML Schema Version:</td><td>" & OPENWIKI_XMLVERSION & "</td></tr>" _
            & "<tr><td>Namespace:</td><td>" & OPENWIKI_NAMESPACE & "</td></tr>" _
            & "<tr><td>" & ScriptEngine & " Version:</td><td>" & ScriptEngineMajorVersion & "." & ScriptEngineMinorVersion & "." & ScriptEngineBuildVersion & "</td></tr>"
    Dim vConn
    Set vConn = Server.CreateObject("ADODB.Connection")
    gMacroReturn = gMacroReturn & "<tr><td>ADO Version:</td><td>" & vConn.Version & "</td></tr>"
    Set vFile = Nothing
    Set vFSO = Nothing
    gMacroReturn = gMacroReturn & "<tr><td>Nr Of Pages:</td><td>" & gNamespace.GetPageCount() & "</td></tr>"
    gMacroReturn = gMacroReturn & "<tr><td>Nr Of Revisions:</td><td>" & gNamespace.GetRevisionsCount() & "</td></tr>"
        If cUseCategories then
                gMacroReturn = gMacroReturn & "<tr><td>Nr Of PageTypes used:</td><td>" & gNamespace.GetMaxCategory() & "</td></tr>"
        End If
    gMacroReturn = gMacroReturn & "<tr><td>Accessibility features:</td><td>"
                                if cUseAccessibility=1 then
                                        gMacroReturn=gMacroReturn & "Enabled"
                                else
                                        gMacroReturn=gMacroReturn & "Disabled"
                                end if
    gMacroReturn = gMacroReturn & "</td></tr>"
    gMacroReturn = gMacroReturn & "<tr><td>System set skin name:</td><td>" & Capitalise(gSystemSkin) & "</td></tr>"
    gMacroReturn = gMacroReturn & "<tr><td>Current skin name:</td><td>" & Capitalise(vSkinName) & "</td></tr>"
    gMacroReturn = gMacroReturn & DisplayPlugins
    'gMacroReturn = gMacroReturn & "<tr><td>Now:</td><td>" & FormatDate(Now()) & " " & FormatTime(Now()) & "</td></tr>"
    gMacroReturn = gMacroReturn & "</table>"
End Sub

' ==================================================================================

Sub MacroDate
    cCacheXML = False
    gMacroReturn = FormatDate(Now())
End Sub

' ==================================================================================

Sub MacroTime
    cCacheXML = False
    gMacroReturn = FormatTime(Now())
End Sub

' ==================================================================================

Sub MacroDateTime
    cCacheXML = False
    gMacroReturn = FormatDate(Now()) & " " & FormatTime(Now())
End Sub

' ==================================================================================

Sub MacroPageCount
    gMacroReturn = gNamespace.GetPageCount()
End Sub

' ==================================================================================

Sub MacroRecentChanges
    Call MacroRecentChangesPP(OPENWIKI_RCDAYS, 9999)
End Sub

Sub MacroRecentChangesP(pParams)
    Call MacroRecentChangesPP(pParams, 9999)
End Sub

Sub MacroRecentChangesPP(pDays, pNrOfChanges)
    If Not IsNumeric(pDays) Or Not IsNumeric(pNrOfChanges) Then
        Exit Sub
    End If
    If pDays <= 0 Then
        pDays = OPENWIKI_RCDAYS
    End If
    If pNrOfChanges <= 0 Then
        pNrOfChanges = 0
    End If
    gMacroReturn = gNamespace.GetIndexSchemes.GetRecentChanges(pDays, pNrOfChanges, 1, True)
End Sub

' ==================================================================================

Sub MacroRecentChangesLong
    Dim vDays, vMaxNrOfChanges, vFilter
    vDays = GetIntParameter("days")
    vMaxNrOfChanges = GetIntParameter("max")
    vFilter = GetIntParameter("filter")
    If vDays <= 0 Then
        vDays = OPENWIKI_RCDAYS
    End If
    If vMaxNrOfChanges <= 0 Then
        If gAction = "rss" Then
            vMaxNrOfChanges = 15
        Else
            vMaxNrOfChanges = 9999
        End If
    End If
    If vFilter = 0 Then
        vFilter = 1  ' major edits only
    Elseif vFilter = 3 Then
        vFilter = 0  ' major and minor edits
    End If
    ' vFilter = 2  ' minor edits only
    gMacroReturn = gNamespace.GetIndexSchemes.GetRecentChanges(vDays, vMaxNrOfChanges, vFilter, False)
End Sub

' ==================================================================================

Sub MacroTitleIndex
    gMacroReturn = gNamespace.GetIndexSchemes.GetTitleIndex
End Sub

' ==================================================================================

Sub MacroCategoryIndex
    gMacroReturn = gNamespace.GetIndexSchemes.GetCategoryIndex
End Sub

' ==================================================================================

Sub MacroWordIndex
    gMacroReturn = gNamespace.GetIndexSchemes.GetWordIndex
End Sub


' ==================================================================================

Sub MacroRandomPageP(pParam)
    If IsNumeric(pParam) Then
        gMacroReturn = gNamespace.GetIndexSchemes.GetRandomPage(pParam)
        else
                If plugins.Item("Macro Help") = 1 Then
                        Call MacroMacroHelpP("RandomPage")
                else

                end if
    End If
End Sub
'        // No-parameter version
Sub MacroRandomPage
    gMacroReturn = gNamespace.GetIndexSchemes.GetRandomPage(1)
End Sub

' ==================================================================================

Sub MacroListEmoticons
        gMacroReturn=DisplayEmoticons()
End Sub

' ==================================================================================
Sub MacroIconList
        gMacroReturn=VirtualListing(OPENWIKI_ICONPATH)
End Sub

Sub MacroIconP(pParam)
'        // Trap for errors, including the real existence of the file
        If pParam="" then Exit Sub
        If (Instr(LCase(pParam),".") > 0) then pParam=Left(pParam,Instr(LCase(pParam),".")-1)

        If VirtualFileExists(OPENWIKI_ICONPATH & "/" & pParam & ".gif") then
                gMacroReturn = "<img src=""" & OPENWIKI_ICONPATH & "/" & pParam & ".gif"" border=""0"" alt=""" & pParam & """/>"
        else
                gMacroReturn = SyntaxErrorMessage("Icon","Specified image does not exist in the icons folder on this Wiki")
        end if
End Sub
'        // No-parameter version
Sub MacroIcon
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Icon")
        else
                gMacroReturn = SyntaxErrorMessage("Icon","This macro requires an icon name in brackets")
        End If
End Sub

' ==================================================================================

Sub MacroImageList
        gMacroReturn=VirtualListing(OPENWIKI_IMAGEPATH)
End Sub

' ==================================================================================

Sub MacroImageP(pParam)
'        // Trap for errors, including the real existence of the file
        If pParam="" then Exit Sub
        If (Instr(LCase(pParam),".") > 0) then pParam=Left(pParam,Instr(LCase(pParam),".")-1)

        If VirtualFileExists(OPENWIKI_IMAGEPATH & "/" & pParam & ".gif") then
                gMacroReturn = "<img src=""" & OPENWIKI_IMAGEPATH & "/" & pParam & ".gif"" border=""0"" alt=""" & pParam & """/>"
        else
                gMacroReturn = SyntaxErrorMessage("Image(" & pParam & ")","Specified image does not exist in the images folder on this Wiki")
        end if
End Sub
'        // No-parameter version
Sub MacroImage
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Image")
        else
                gMacroReturn = SyntaxErrorMessage("Image","This macro requires an image name in brackets")
        End If
End Sub

' ==================================================================================

Sub MacroAnchorP(pParam)
    gMacroReturn = "<a name='" & CDATAEncode(pParam) & "'></a>"
End Sub
'        // No-parameter version
Sub MacroAnchor
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Anchor")
        else
                gMacroReturn = SyntaxErrorMessage("Anchor","This macro requires an anchor name in brackets")
        End If
End Sub

' ==================================================================================

Sub MacroIncludeOpenWikiPagePP(ServerRoot,PageName)
Dim pURL,XMLstr,IsValid,ThisRoot
On Error Resume Next
IsValid=True '        // Assume good.  Look for bad
'        // Rudimentary error-trapping
        ServerRoot=LCase(ServerRoot) '        // Force to lower case for easier testing
        If Left(ServerRoot,7) <> "http://" then IsValid=false '        // Must start with http://
        If Instr(ServerRoot,".") = 0 then IsValid=false '        // Must have at least one period in it
        If (Right(ServerRoot,1) <> "/") then ServerRoot=ServerRoot & "/" '        // Must end in a slash
        If (Len(PageName) < 2) then IsValid=false '        // Page name must have at least one character
        PageName=URLDecode(PageName)
        pURL=ServerRoot & "ow.asp?p=" & PageName & "&amp;a=xml"
        XMLStr="<ow:error>Sorry, this page cannot be rendered correctly</ow:error>"
        XMLstr=gTransformer.GrabWikiPage(pURL)

'        // Replace page links to this wiki with page links to the included page wiki
        XMLStr=Replace(XMLStr,"ow.asp",ServerRoot & "ow.asp")
'        // Replace any references to this server with the remote server
        ThisRoot="http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("SCRIPT_NAME")
        ThisRoot=Left(THisRoot,InstrRev(ThisRoot,"/"))
        XMLStr=Replace(XMLStr,ThisRoot,ServerRoot)
        if IsValid then
                gMacroReturn = "<table width=""100%"" border=""1"" bordercolor=""red"" cellpadding=""5""><tr><td>" & XMLstr & "</td></tr></table>"
        else
                Call MacroMacroHelpP("IncludeWikiPage")
        end if
End Sub
'        // No-parameter version
Sub MacroIncludeOpenWikiPage
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("IncludeOpenWikiPage")
        else
                gMacroReturn = SyntaxErrorMessage("IncludeOpenWikiPage","This macro requires 2 parameters in brackets: (ServerRoot,Pagename)")
        End If
End Sub

' ==================================================================================

Sub MacroIncludeP(pParam)
 MacroIncludePP pParam,0
End Sub

Sub MacroIncludePP(pParam,pSilentInclude)
Dim tPage
        pParam=ReplacePageTokens(pParam,gPage) '        // Substitute @this,@parent etc. references
        Set tPage = gNamespace.GetPage(AbsoluteName(pParam), gRevision, False, False)
        If tPage.Exists Then
                Set tPage = Nothing
                Dim i, vCount, vID,vSilentInclude
                vSilentInclude="" & CStr(pSilentInclude)
                If Not IsObject(gCurrentWorkingPages) Then
                        Set gCurrentWorkingPages = New Vector
                        gCurrentWorkingPages.Push(gPage)
                End If
                For i = 0 To gCurrentWorkingPages.Count - 1
                        If UCase(gCurrentWorkingPages.ElementAt(i)) = UCase(pParam) Then
                                Exit Sub
                        End If
                Next

                vID = AbsoluteName(pParam)

                gIncludeLevel = gIncludeLevel + 1
                If (gIncludeLevel <= OPENWIKI_MAXINCLUDELEVEL) Then
                        Dim vPage
                        Set vPage = gNamespace.GetPageAndAttachments(vID, 0, True, False)
                        If vPage.Exists Then
                                if ( (vSilentInclude <> "") AND (vSilentInclude <> "0") ) then
                                        vPage.SilentInclude = 1
                                End If
                                vPage.Summary = ""
                                gCurrentWorkingPages.Push(vPage.Name)
                                gMacroReturn = vPage.ToXML(1)
                                gCurrentWorkingPages.Pop()
                        End If
                End If
                gIncludeLevel = gIncludeLevel - 1
        else
                Set tPage = Nothing
                If plugins.Item("Macro Help") = 1 Then
                        Call MacroMacroHelpP("Include")
                else
                        gMacroReturn = SyntaxErrorMessage("Include(" & AbsoluteName(pParam) & ")","The page name specified does not exist in this Wiki")
                end if
        end if
End Sub
'        // No-parameter version
Sub MacroInclude
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Include")
        else
                gMacroReturn = SyntaxErrorMessage("Include","This macro requires a pagename in brackets")
        End If
End Sub

' ==================================================================================

Sub MacroInterWiki
    gMacroReturn = gNamespace.InterWiki()
End Sub

' ==================================================================================
'   // Code by Gordon Bamber 20051204
'	// Used by UserPreferences and forceusername plugin
'	// The plugin sets a cookie with the name of the failed page
'	// This function picks it up, and puts a backlink to it
'	// on the userpreferences page when saved
Private Function ShowReferringPage
Dim vText,gRef
	gRef=Request.Cookies(gCookieHash & "?referringpage")
	If gRef="" then gRef = gPage
	vText=OPENWIKI_SCRIPTNAME & "?p=" & gRef
    ShowReferringPage="  <ow:link name='" & gRef & "' href='" & vText & "' date='" & FormatDateISO8601(Now()) & "'>Go to " & gRef & "</ow:link>"
End Function

Sub MacroUserPreferences
    gMacroReturn = ""
    If Request.QueryString("up") = 1 Then
        gMacroReturn = gMacroReturn & "<p/><ow:message code=""userpreferences_saved""/>" & ShowReferringPage
    Elseif Request.QueryString("up") = 2 Then
        gMacroReturn = gMacroReturn & "<p/><ow:message code=""userpreferences_cleared""/>"
    Elseif Request.QueryString("up") = 3 Then
        gMacroReturn = gMacroReturn & "<p/><ow:message code=""userpreferences_blankpassword""/>"
    End If
    gMacroReturn = gMacroReturn &  "<ShowReferringPage/><ow:userpreferences/>"
End Sub

' ==================================================================================

Sub MacroFootnoteP(pText)
        If (pText="") then
                If (plugins.Item("Macro Help") = 1) Then
                        Call MacroMacroHelpP("Footnote")
                        Exit Sub
                else
                        MacroFootnote '        // Raise an error
                        Exit Sub
                end if
        End If
    ' processed at the end of wikify
    gMacroReturn = gFS & gFS & pText & gFS & gFS
End Sub
'        // No-parameter version
Sub MacroFootnote
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Footnote")
        else
                gMacroReturn = SyntaxErrorMessage("Footnote","This macro requires some text in brackets")
        End If
End Sub

' ==================================================================================

Sub MacroAggregateP(pPage)
    If cAllowAggregations <> 1 Then
        Exit Sub
    End If

    If Request("preview") <> "" Then
        Exit Sub
    End If

    pPage = AbsoluteName(pPage)

    Dim vPage
    Set vPage = gNamespace.GetPage(pPage, gRevision, True, False)
        If vPage.Exists Then
                Set gAggregateURLs = New Vector
                MultiLineMarkup(vPage.Text)   ' refreshes RSS feed(s) and fills the gAggregateURLs vector
                gMacroReturn = GetAggregation(pPage)
                gAggregateURLs = ""
        else
                If plugins.Item("Macro Help") = 1 Then
                        Call MacroMacroHelpP("Aggregate")
                else
                        gMacroReturn = SyntaxErrorMessage("Aggregate(" & pPage & ")","The page name specified does not exist in this Wiki")
                end if
        end if
End Sub
'        // No-parameter version
Sub MacroAggregate
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Aggregate")
        else
                gMacroReturn = SyntaxErrorMessage("Aggregate","This macro requires a page name in brackets")
        End If
End Sub

' ==================================================================================

Sub MacroSyndicateP(pURL)
    Call MacroSyndicatePP(pURL, 240)  ' default = 4 * 60 minutes
End Sub

Sub MacroSyndicatePP(pURL, pRefreshRate)
    Dim vURL, vCache, vRefreshURL

    If Request("preview") <> "" Then
        Exit Sub
    End If

    vURL = Replace(pURL, "&amp;", "&")
    If Not m(vURL, "^https?://", False, False) Or Not IsNumeric(pRefreshRate) Then
        Exit Sub
    End If
    If pRefreshRate < 0 Then
        pRefreshRate = 0
    End If

    If IsObject(gAggregateURLs) And cAllowAggregations Then
        gAggregateURLs.Push(vURL)
    End If

    vRefreshURL = URLDecode(Request("refreshurl"))

    If (gAction <> "refresh") Or ((vRefreshURL <> "") And (vRefreshURL <> vURL)) Then
        vCache = gNamespace.GetRSSFromCache(vURL, pRefreshRate, False, False)
        If vCache = "notexists" Then
            If cAllowNewSyndications = 0 Then
                Exit Sub
            End If
        Elseif vCache <> "" Then
            gMacroReturn = vCache
            Exit Sub
        End If
    End If
    If gAction = "refresh" Or vRefreshURL = vURL Or vCache = "notexists" Or gNrOfRSSRetrievals < OPENWIKI_MAXWEBGETS Then
        gMacroReturn = RetrieveRSSFeed(vURL)
        gNrOfRSSRetrievals = gNrOfRSSRetrievals + 1
    End If
    If gMacroReturn = "" Then
        ' failure to retrieve RSS feed from remote source
        If vCache = "notexists" Then
            Call gNamespace.SaveRSSToCache(vURL, pRefreshRate, "")
            gMacroReturn = gNamespace.GetRSSFromCache(vURL, pRefreshRate, True, False)
        Else
            ' retry later, and get the cached version
            gMacroReturn = gNamespace.GetRSSFromCache(vURL, pRefreshRate, True, True)
            If gMacroReturn = "notexists" Then
                gMacroReturn = ""
            End If
        End If
    Else
        Call gNamespace.SaveRSSToCache(vURL, pRefreshRate, gMacroReturn)
        gMacroReturn = gNamespace.GetRSSFromCache(vURL, pRefreshRate, True, False)
    End If
End Sub
'        // No-parameter version
Sub MacroSyndicate
        If plugins.Item("Macro Help") = 1 Then
                Call MacroMacroHelpP("Syndicate")
        else
                gMacroReturn = SyntaxErrorMessage("Syndicate","This macro requires at least an rss feed URL in brackets")
        End If
End Sub

' ~~~~~ MacroShowSharedImages ~~~~~~ PiiXiieeS 20060318 ~~~~~~
' Show all the shared images in the Image Library folder (OPENWIKI_IMAGELIBRARY)
Sub MacroShowSharedImages
    Dim fs, f, f1, fc
    If cAllowImageLibrary Then
        Set fs = CreateObject("Scripting.FileSystemObject")  
        Set f = fs.GetFolder(Server.MapPath(OPENWIKI_IMAGELIBRARY))  
        Set fc = f.files
        gMacroReturn = "" 
        For Each f1 in fc 
        If m(f1.name, gImageExtensions, True, True) Then
            gMacroReturn = gMacroReturn & "<div class=""figure"">"
            gMacroReturn = gMacroReturn & "<p><img class=""scaled"" src=""" & OPENWIKI_IMAGELIBRARY & "" & f1.name & """ width=""50px"" height=""50px"" alt=""" & f1.name & """/></p>"
            gMacroReturn = gMacroReturn & "<p>" & f1.name & "</p></div>"
        End If
        Next
        gMacroReturn = gMacroReturn & "<br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br>"
    Else
        gMacroReturn = SyntaxErrorMessage("ShowSharedImages","The Image Library is disabled")
    End If
End Sub

Sub MacroShowSharedImagesP(pParam)
    ' StackError 0, "hola","MessageStrin","OtherString"
    ' If ShowErrors Then Exit Sub
    Call MacroShowSharedImages
    ' gMacroReturn = SyntaxErrorMessage("ShowSharedImages","This macro should not have a parameter")
End Sub

Sub MacroShowSharedImagesPP(pParam1, pParam2)
    Call MacroShowSharedImages
    ' gMacroReturn = SyntaxErrorMessage("ShowSharedImages","This macro should not have any parameter")
End Sub
' ~~~~~ MacroShowSharedImages ~~~~~~ PiiXiieeS 20060318 ~~~~~~

' ==================================================================================
'        // Public Functions
' ==================================================================================
function OWGetFile(filepath,numbers)
	'numbers: 0=no line numbers 1=line numbers
	Dim FSO
	Set FSO = CreateObject("Scripting.FileSystemObject")
	Dim TextStream
	dim t
	Dim File

	Set TextStream = FSO.OpenTextFile(filepath , 1)
	Do While Not TextStream.AtEndOfStream
		if numbers <> 0 then
			t = t + 1
			OWGetFile = OWGetFile & right("000000" & t,6) & "|" & TextStream.ReadLine & vbcrlf
		else
			OWGetFile = OWGetFile & TextStream.ReadLine & vbcrlf
		end if
	loop
	TextStream.Close
	set TextStream = nothing
	set FSO = nothing
end function

Function FormatDate(pTimestamp)
    ' TODO: apply user preferences
    FormatDate = MonthName(Month(pTimestamp)) & " " & Day(pTimestamp) & ", " & Year(pTimestamp)
End Function

Function FormatTime(pTimestamp)
    ' TODO: apply user preferences
    FormatTime = FormatDateTime(pTimestamp, 4)  ' 4 = vbShortTime
End Function

function FetchBadgeslistAsXml()
	dim vFSO,vFile,TextStream,s,temp,t
	'fetch and show badges. (names only)
	'RETURN: XML node
    Set vFSO = server.CreateObject("Scripting.FileSystemObject")
    on error resume next
    Set vFile = vFSO.GetFile(Server.MapPath("ow/badges.txt"))
    if err.number > 0 then
		'return a 'error' node!
		set FetchBadgeslistAsXml = loadXMLText("<error>File not found or currupt (Badges.txt)</error>")
		err.Clear 
	else    
		Set TextStream = vFile.OpenAsTextStream(1)
		temp = "<badgeslist>"
		t = 1
		Do While Not TextStream.AtEndOfStream
			s = TextStream.ReadLine
			if t = 1 then
				temp = temp & "<name>" & mid(s,2,(instr(1,s,"=")-2)) & "</name>"
			end if
			t=t*-1
		Loop
		TextStream.Close
		temp = temp & "</badgeslist>"
    
		set FetchBadgeslistAsXml = loadXMLText(temp).documentElement
    end if
    
    set vFSO = nothing
    set vFile = nothing
    set TextStream = nothing
end function

function loadXMLText(xmlText)
	dim xml
	set xml = Server.CreateObject("Msxml2.DOMDocument")
	if not xml.loadXML(xmlText) then
		call xmlError(xml, "Unable to load the XML string '" & left(xmlText, 300) & "...'")
	else
		set loadXMLText = xml
	end if
end function

sub xmlError(xml, errmsg)
	Response.Write "<pre>XML ERROR:" & vbcrlf
	Response.Write  server.HTMLEncode(errmsg) & vbcrlf
	Response.Write  "Reason: " & xml.parseerror.reason & vbcrlf
	Response.Write  "Line: " & xml.parseerror.line & vbcrlf
	Response.Write  "Line Pos: " & xml.parseerror.linePos & vbcrlf
	Response.Write "<pre>" & vbcrlf
	Response.end
end sub
' ==================================================================================
'        // Private Functions
' ==================================================================================
'        // Code by Gordon Bamber
'        // Tests for the existence of a file on the system with a real path
Private Function FileExists(fspath)
Dim fs,istream
        On Error Resume Next
        FileExists = False
        set fs = CreateObject("Scripting.FileSystemObject")
        Err.Clear
        set istream = fs.OpenTextFile(fspath)
        if Err.Number = 0 then
                FileExists = True
                istream.Close
        end if
        set istream = Nothing
        set fs = Nothing
End Function

'        // THIS FUNCTION DISPLAYS A LISTING USING AN ABSOLUTE REFERENCE I.E. Listing("C:\PHP")
Private Function Listing(pPath )
  dim oFso, oFolder, oFiles, oFile
  If (LEN(pPath) < 6) then
    Listing = "<ow:error>Invalid short path: " & pPath & "</ow:error>"
    Exit Function
  End If
  Set oFso = Server.CreateObject( "Scripting.FileSystemObject" )
  If oFso.FolderExists( pPath ) then
    Set oFolder = oFso.GetFolder( pPath )
    Set oFiles  = oFolder.Files
    Listing = "<b>Listing:</b><ul>"
    For each oFile in oFiles
        Listing = Listing & "<li>" & oFile.Name & "</li>"
    Next
    Listing = Listing & "</ul>"
  Else
    Listing = "<ow:error>error in path: " & pPath & "</ow:error>"
  End If
  Set oFile   = Nothing
  Set oFiles  = Nothing
  Set oFolder = Nothing
  Set oFso    = Nothing
End Function

'        // THIS FUNCTION DISPLAYS A LISTING USING A VIRTUAL REFERENCE I.E. VirtualListing("ow/images")
Private Function VirtualListing(pVirtualPath )
        On Error Resume Next
        VirtualListing=Listing(Server.MapPath(pVirtualPath))
End Function

' ==================================================================================
'        // Code by Gordon Bamber
'        // Tests for the existence of a file on the system with a virtual path
Private Function VirtualFileExists(pVirtualpath)
Dim pRealPath
        On Error Resume Next
        pRealPath=Server.MapPath(pVirtualpath)
        VirtualFileExists=FileExists(pRealPath)
End Function

Private Function DisplayEmoticons
  dim oFso, oFolder, oFiles, oFile,sResult,pPath,sFilename,sEmoticonName
  pPath=Server.MapPath(OPENWIKI_ICONPATH)
  Set oFso = Server.CreateObject( "Scripting.FileSystemObject" )
  If oFso.FolderExists( pPath ) then
    Set oFolder = oFso.GetFolder( pPath )
    Set oFiles  = oFolder.Files
        sResult = "<table class=""systeminfo"">"
    sResult = sResult & "<tr><th colspan=""2"">- Available Emoticons -</th></tr>"
    sResult = sResult & "<tr><th>Emoticon</th><th>WikiText</th></tr>"
    For each oFile in oFiles
                sFilename=CStr(oFile.Name)
        sEmoticonName = s(sFilename, "emoticon-([^0-9]*).gif", "$1",false,false)
        If Instr(sEmoticonName,".gif") = 0 then
                        sResult = sResult & "<tr>"
'                        <a href='javascript:add_smilie(":huh:")'>
                        sResult = sResult & "<td><img src=""" & OPENWIKI_ICONPATH & "/" & sFilename & """/></td>"
                        sResult = sResult & "<td>:" & sEmoticonName & ":</td>"
                        sResult = sResult & "</tr>"
                End If
    Next
    sResult = sResult & "</table>"
  Else
    sResult = "<ow:error>error in path: " & pPath & "</ow:error>"
  End If
  Set oFile   = Nothing
  Set oFiles  = Nothing
  Set oFolder = Nothing
  Set oFso    = Nothing
  DisplayEmoticons=sResult
End Function

Private Function SyntaxErrorMessage(pMacroname,pErrMsg)
'        // SYNTAX: gMacroReturn=SyntaxErrorMessage(NameOfMacro,Error message/Information to display)
'        // Use this function as the error conditin in a Macro
'        // If MacroHelp is active - use that instead
Dim ErrorPic,InfoPic, ErrorMessage
                If (LCase(pMacroname) <> "icon") then
                        Call MacroIconP("icon-error")
                        ErrorPic = gMacroReturn
                        Call MacroIconP("icon-info")
                        InfoPic = gMacroReturn
                End If
                If (Instr(ErrorPic,"<img") = 0) then ErrorPic = "*"
                If (Instr(InfoPic,"<img") = 0) then InfoPic = "*"
                ErrorMessage="<hr width=""50%"" align=""left"" color=""#ff0000""/><table border=""0"" cellpadding=""2""><tr>" &_
                        "<td>" & ErrorPic & "</td>" &_
                        "<td><b><span style=""color:#ff0000"">&lt;" & pMacroname & "&gt; macro error!</span></b></td></tr>" &_
                        "<tr><td>" & InfoPic & "</td>" &_
                        "<td><span style=""color:#ff0000"">" & pErrMsg & "</span></td>" &_
                        "</tr></table><hr width=""50%"" align=""left"" color=""#ff0000""/>"
                SyntaxErrorMessage = ErrorMessage
End Function

Private Function IsIE
  if Instr(Request.ServerVariables("HTTP_USER_AGENT"),"MSIE") > 0 then
   IsIE=True
  else
   IsIE=False
  end if
End Function

Sub MacroTagSearch
       cUseAccessibility=0
If cUseAccessibility then
    gMacroReturn = "<FIELDSET STYLE=""padding-left=5;padding-top=10;padding-bottom=20;"" LANG=""en"" TITLE=""Tag Search Form""><LEGEND>Summary Search" & Chr(160) & "</LEGEND>" &_
    "<form name=""TagSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
     "<LABEL FOR=""tagsrch"" LANG=""en"" TITLE=""Tag Search Input"" ACCESSKEY=""M"" >Ta<u>g</u>: </LABEL>" &_
    "<input type=""hidden"" name=""a"" value=""tagsearch""/>" &_
    "<input type=""text"" size=""80"" LANG=""en"" TITLE=""Tag Search Input"" id=""tagsrch"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mts"" type=""submit"" LANG=""en"" TITLE=""Tag Search Submit"" value=""Do Tag Search""/><br/><br/></form>" &_
     "</FIELDSET>"

else
    gMacroReturn = "<form name=""TagSearch"" action=""" & CDATAEncode(gScriptName) & """ method=""get"">" &_
    "<input type=""hidden"" name=""a"" value=""tagsearch""/>" &_
    "<input type=""text"" name=""txt"" value=""" & CDATAEncode(gTxt) & """ ondblclick='event.cancelBubble=true;' />" &_
    "<input id=""mss"" type=""submit"" value=""Do Tag Search""/></form>"
end if
End Sub

Sub MacroTagSearchP(pParam)
    gTitlesearchTemp = ""
    gMacroReturn = gNamespace.GetIndexSchemes.GetTagSearch(pParam)
End Sub

%>