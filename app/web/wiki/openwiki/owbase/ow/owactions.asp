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
'                $Log: owactions.asp,v $
'                Revision 1.40  2007/01/07 11:24:40  piixiiees
'                gFS=Chr(222) due to problems working with Chr(179) in utf-8 and some files saved with encoding="utf-8"
'
'                Revision 1.39  2006/03/11 17:01:01  gbamber
'                Improved code for ActionDebug
'
'                Revision 1.37  2006/02/22 12:27:14  gbamber
'                Build 20060216.6
'                Bugfixes to ImageUpload and DeletePage
'                Hardcoded ImageUpload page into owdb.asp
'                Only if cAllowImageLibrary=1 will UploadImage work.
'
'                Revision 1.36  2006/02/22 11:26:03  gbamber
'                Build 20060216.5
'                ImageUpload now uses ActionView for it's result page.
'                Taken out some generic Requests so that we no longer have to use Response.Redirect to report an error to the user
'
'                Revision 1.35  2006/02/22 10:17:12  gbamber
'                Build 20060216.3
'                Changed refs of local: to sharedimage:
'                Softcoded error and success page names
'                Surrounded frontpage var with <nowiki> tags
'                Restored DeletePageAndAttachments function in owdb
'
'                Revision 1.34  2006/01/09 10:26:42  gbamber
'                Added view & edit restrictions to:
'                ActionEdit
'                ActionView
'                ActionPrint
'
'                Revision 1.33  2005/12/14 20:39:57  gbamber
'                BugFix:Updated hardcoded 'Help' link in editing window
'                BugFix:Updated gStrictLinkPattern to include underscores
'                BugFix:Changed scope of userprefs cookie
'                New:Action UpgradeFreelinks
'                New:Added Maintainance link to admin control panel
'                New:Added parameter to SuccessfulAction page
'                New:owdb function to upgrade freelink pages
'
'                Revision 1.32  2005/12/10 08:38:08  gbamber
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
'                Revision 1.31  2005/02/20 11:10:06  gbamber
'                UPDATED: #NOW directive
'                ADDED: #NOWD and #NOWT directives
'                UPDATED: WYSIWYG Macro dropdown
'
'                Revision 1.30  2004/11/03 10:33:28  gbamber
'                BugFix: TextSearch
'                BugFix: <position>
'
'                Revision 1.29  2004/11/01 12:14:24  gbamber
'                NEW: Admin function 'Nuke deprecated pages older than:'
'
'                Revision 1.28  2004/10/31 21:11:07  gbamber
'                New admin functions - Delete old revisions (this page | All) for default skin only
'
'                Revision 1.27  2004/10/30 20:42:50  gbamber
'                Added gWikiAdministrator="Wikiadmin"
'                Added 'Delete this page' if using admin name and local IP
'                Changed FetchUsername function to owdb.asp
'                Added auto-success page
'
'                Revision 1.26  2004/10/20 18:30:27  gbamber
'                RenamePage now does entire SubPage trees
'                Some formatting improvements in owwikify
'
'                Revision 1.25  2004/10/19 12:35:04  gbamber
'                Massive serialising update.
'
'                Revision 1.24  2004/10/13 12:17:21  gbamber
'                Forced updates to make sure CVS reflects current work
'
'                Revision 1.23  2004/10/11 12:53:38  gbamber
'                Added: <SummarySearch(PP)>
'                Modified: <ow:link> to show summaries
'
'                Revision 1.22  2004/10/10 22:47:42  gbamber
'                Massive update!
'                Added: Summaries
'                Added: Default pages built-in
'                Added: Auto-update from openwiki classic
'                Modified: Default plugin status
'                Modified: Default Page Names
'                Modified: Default MSAccess DB to openwikidist.mdb
'                BugFix: Many MSAccess bugs fixed
'                Modified: plastic skin to show Summary
'
'                Revision 1.21  2004/10/03 18:17:23  gbamber
'                Experimental.
'                New option cAllowAnyPageName in owconfig_default
'                When cAllowAnyPageName=0 then pages cannot contain
'                1 ) Spaces
'                2 ) + characters
'                3 ) underscores
'                4 )  lowercase(space)lowercase
'                In other words, the page names are 'cleaned up
'
'                Revision 1.20  2004/10/03 17:10:39  gbamber
'                When making a new pagename the following are deleted:
'                Any spaces
'                Any + characters
'                Any _ characters
'
'                Revision 1.19  2004/10/03 10:44:55  gbamber
'                BugFix: Edit comment now prefers GetUserAlias()
'
'                Revision 1.18  2004/09/20 13:07:14  gbamber
'                Fixed export RSS bug (line 142)
'
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owactions.asp,v $
'    $Revision: 1.40 $
'      $Author: piixiiees $
' ---------------------------------------------------------------------------
'

Sub ActionUpgradeFreelinks
'	// Code:Gordon Bamber 20051213
'	// Call as p=Pagename&a=UpgradeFreelinks
'	// Main routine in owdb.asp:UpgradeFreeLinks() returns false if in error
	If gNameSpace.UpgradeFreeLinks() then
		gSuccessPageText=gSuccessPageText & "<br/><br/>The operation was successful."
		gPage=OPENWIKI_SUCCESSPAGENAME
	else
		gPage=OPENWIKI_ERRORPAGENAME
		gErrorPageText="Reason: The Freelink pages were unable to be upgraded"
	end if
	gAction = "view"
    ActionView()
	gActionReturn = True
End Sub

Sub ActionDebug
	If NOT ShowErrors THEN
		gAction="view"
		ActionView()
	END IF
	gActionReturn = True
End Sub

Sub ActionXml
    ActionView()
End Sub

Sub ActionRss
    Dim vPage, vXmlStr
    If cAllowRSSExport Then
        If Request("p") <> "" And cAllowAggregations Then
            Set vPage = gNamespace.GetPage(gPage, gRevision, True, False)
            Set gAggregateURLs = New Vector
            Set gRaw = New Vector
            MultiLineMarkup(vPage.Text)   ' refreshes RSS feed(s) and fills the gAggregateURLs vector
            If gAggregateURLs.Count = 0 Then
                Response.ContentType = "text/xml; charset:" & OPENWIKI_ENCODING & ";"
                Response.Write "<?xml version='1.0' encoding='" & OPENWIKI_ENCODING & "'?><error>Nothing to aggregate</error>"
                Response.End
            Else
                Response.ContentType = "text/xml; charset:" & OPENWIKI_ENCODING & ";"
                Response.Write gNamespace.GetAggregation(gAggregateURLs)
                Response.End
            End If
        Else
            If cCacheXML Then
                vXmlStr = gNamespace.GetDocumentCache("rss")
            End If
            If vXmlStr = "" Then
                gPage = OPENWIKI_RCNAME
                Set vPage = gNamespace.GetPage(gPage, gRevision, False, False)
                ' make sure we execute only the RecentChanges macro
                vPage.Text = "<RecentChangesLong>"
                vXmlStr = gTransformer.TransformXmlStr(vPage.ToXML(1), "ow/skins/common/owrss10export.xsl")
                If cCacheXML Then
                    Call gNamespace.SetDocumentCache("rss", vXmlStr)
                End If
            End If
            gActionReturn = True
        End If
    Else
        Response.ContentType = "text/xml; charset:" & OPENWIKI_ENCODING & ";"
        Response.Write "<?xml version='1.0' encoding='" & OPENWIKI_ENCODING & "'?><error>RSS feed disabled</error>"
        Response.End
    End If
End Sub

Sub ActionRefresh
    Dim vPage
    If OPENWIKI_SCRIPTTIMEOUT > 0 Then
        Server.ScriptTimeout = OPENWIKI_SCRIPTTIMEOUT
    End If
    cCacheXML = False
    Set vPage = gNamespace.GetPage(gPage, gRevision, True, False)
    Set gAggregateURLs = New Vector
    Set gRaw = New Vector
    Call MultiLineMarkup(vPage.Text)   ' refreshes RSS feed(s)
    Call gNamespace.ClearDocumentCache2("", gPage)
    If Request("redirect") = "" Then
        Response.Redirect(gScriptName & "?" & Server.URLEncode(gPage))
    Else
        Response.Redirect(gScriptName & "?" & Server.URLEncode(Request("redirect")))
    End If
End Sub

Sub ActionNaked
    gAction = "view"
    ActionView()
End Sub

Sub ActionPrint
	if cFreeLinks = 0 then '	// Don't allow the display of FreeLink pages if cFreeLinks=0
		If ContainsFreeLinks(gPage) then
		'	// Setting the gPage name to 'ErrorPage' bypasses normal processing
		'	// and displays a hard-coded page with a body text set to the variable gErrorText
			gErrorPageText = "The page name '" & gPage & "' is invalid because <nowiki>cFreeLinks</nowiki>=0 in the configuration"
			gPage=OPENWIKI_ERRORPAGENAME
		end if
	End if
	Dim vPage
	Set vPage=gNamespace.GetPageAndAttachments(gPage, gRevision, True, False)
' // START OF PLUGIN //
	CheckForAllowedView(vPage)
' // END OF PLUGIN //
	Set vPage=Nothing
	Dim vXmlStr
    cReadOnly = 1
    If cCacheXML Then
        vXmlStr = gNamespace.GetDocumentCache("print")
    End If
    If vXmlStr = "" Then
        vXmlStr = gNamespace.GetPageAndAttachments(gPage, gRevision, True, False).ToXML(1)
        If cCacheXML Then
            Call gNamespace.SetDocumentCache("print", vXmlStr)
        End If
    End If
    Call gTransformer.Transform(vXmlStr)
    gActionReturn = True
End Sub


Sub ActionNukeDeprecatedPages
	If Request("adminpassword")=gAdminPassword then
		If gNameSpace.NukeDeprecatedPages(Request("days")) then
			gActionReturn = True
			Response.Redirect(gScriptName & "?SuccessfulAction")
		else
			gActionReturn = True
			RESPONSE.WRITE("<h3>Sorry! The function failed for some reason.</h3>")
			RESPONSE.END
		end if
	else
		gActionReturn = True
			RESPONSE.WRITE("<h3>This action can only be used by a WikiAdministrator</h3>")
			RESPONSE.END
	End If
End Sub

Sub ActionDeletePage

	Dim pPageName
	If cFreeLinks = 0 Then '	// Don't allow editing or creation of FreeLink pages
		If ContainsFreeLinks(gPage) Then
			gAction = "view"
			ActionView() '	// This will pick up the pattern again and display an error page
			gActionReturn = True
			Exit Sub
		End If
	End If

	If Request("adminpassword")=gAdminPassword then

		If gNamespace.DeletePageAndAttachments(gPage) then
			'        // Display success message
			'        // Set the message
        	gSuccessPageText="==== " & gPage & " was deleted successfully ===="
			'        // Make sure ActionView works correctly
        	gAction = "view"
			'        // Set the page to view
        	gPage=OPENWIKI_SUCCESSPAGENAME
			'        // Display it
        	ActionView
	    	gActionReturn = True
		Else
			'      	// Display error message (gErrorPageText)
			'        // Make sure ActionView works correctly
        	gAction = "view"
			'        // Set the page to view
	        gPage=OPENWIKI_ERRORPAGENAME
			'        // Display it
        	ActionView
	    	gActionReturn = True
		End If
	End If
	
End Sub

Sub ActionView
    Dim vXmlStr,vPage,vHighlight,vTemp
	Dim tList,tUsername,tUsernameArray,ct
	if cFreeLinks = 0 then '	// Don't allow the display of FreeLink pages if cFreeLinks=0
		If ContainsFreeLinks(gPage) then
		'	// Setting the gPage name to 'ErrorPage' bypasses normal processing
		'	// and displays a hard-coded page with a body text set to the variable gErrorText
			gErrorPageText = "The page name '" & gPage & "' is invalid because <nowiki>cFreeLinks</nowiki>=0 in the configuration"
			gErrorPageText = gErrorPageText & "<br/>Resolution: You can go to " & gPage & "Page (or create it by by clicking the question mark)"
			gPage=OPENWIKI_ERRORPAGENAME
		end if
	End if
	Set vPage=gNamespace.GetPageAndAttachments(gPage, gRevision, True, False)
' // START OF PLUGIN //
	CheckForAllowedView(vPage)
' // END OF PLUGIN //
''        // START PAGEHITS CODE
    gNamespace.IncrementPageHits vPage
''        // END PAGEHITS CODE

        vHighlight=Request.Querystring("highlight")
        If (Len(Request.Querystring("highlight")) > 0) then
           vPage.Text=Highlight(vPage.Text, Request("highlight"), "{MP}", "{/MP}")
        End If

    If cNakedView Then
        gAction = "naked"
    End If
    If cAllowRSSExport And Request.Querystring("v") = "rss" Then
        gAction = "rssexport"
        Call gTransformer.TransformXmlStr(gNamespace.GetPage(gPage, gRevision, True, False).ToXML(1), "ow/skins/common/owrss10export.xsl")
    Else
        If cCacheXML Then
            gAction = "cached"
            vXmlStr = gNamespace.GetDocumentCache("view")
        End If
        If vXmlStr = "" Then
            vXmlStr = gNamespace.GetPageAndAttachments(gPage, gRevision, True, False).ToXML(1)
            If cCacheXML Then
                gAction = "cached"
                Call gNamespace.SetDocumentCache("view", vXmlStr)
            End If
        End If

'	// Hook here to fetch/change 'x is viewing this page' display
		If Application("visitors") then
		  tUsername=gNameSpace.FetchUserName()
		  tList=Application("userlist")
		  If Instr(tList,tUsername) = 0 then
			tList=tList  & tUsername & " viewing " & gPage & "|"
		  Else
			tUsernameArray=Split(tList,"|")
			For ct=0 to UBound(tUsernameArray)
				If Instr(tUsernameArray(ct),tUsername) > 0 then
					tUsernameArray(ct)=tUsername & " viewing " & gPage
				End If
			Next
			tList=Join(tUsernameArray,"|")
		  End If
		  Application("userlist")=tList
		End If
		Call gTransformer.Transform(vXmlStr)
	End If
    gActionReturn = True
End Sub

Sub ActionDeleteRevisions
Dim thePage
'	// If no page parameter given then all old revisions of all pages are deleted!
	thePage = "" & Request("page")
	if cFreeLinks = 0 then '	// Don't allow editing or creation of FreeLink pages
		If ContainsFreeLinks(gPage) then
			gAction = "view"
			ActionView() '	// This will pick up the pattern again and display an error page
			gActionReturn = True
			Exit Sub
		end if
	end if
	If gNameSpace.DeleteOldRevisions(thePage) then
		ActionView
		gActionReturn = True
		Response.Redirect(gScriptName & "?SuccessfulAction")
	else
		gActionReturn = True
			RESPONSE.WRITE("<h3>This action can only be used by a WikiAdministrator</h3>")
			RESPONSE.END
	End If
End Sub

Sub ActionPreview
    Dim vPage
    Set vPage = gNamespace.GetPage(gPage, 0, False, False)
    vPage.Text = Request("text")
    gAction = "print"
    Call gTransformer.Transform(vPage.ToXML(1))
    gActionReturn = True
End Sub

Sub ActionDiff
    Dim vXmlStr, vDiff, vDiffFrom, vDiffTo, vDiffType, vPageFrom, vPageTo, vMatcher
    vDiff     = GetIntParameter("diff")
    vDiffFrom = GetIntParameter("difffrom")
    vDiffTo   = GetIntParameter("diffto")

    If vDiffFrom <> 0 Or vDiffTo <> 0 Then
        cCacheXML = False
    End If

    If cCacheXML Then
        vXmlStr = gNamespace.GetDocumentCache("diff" & vDiff)
    End If

    If vXmlStr = "" Then

        If vDiff = 0 Then
            If vDiffFrom = 0 Then
                ' difference of prior major revision relative to vDiffTo
                vDiffType = "major"
                vDiffFrom = gNamespace.GetPreviousRevision(0, vDiffTo)
            Else
                ' difference of selected revision relative to vDiffTo
                vDiffType = "selected"
            End If
        Elseif vDiff = 1 Then
            ' difference of previous minor edit relative to vDiffTo
            vDiffType = "minor"
            vDiffFrom = gNamespace.GetPreviousRevision(1, vDiffTo)
        Else
            ' difference of previous author edit relative to vDiffTo
            vDiffType = "author"
            vDiffFrom = gNamespace.GetPreviousRevision(2, vDiffTo)
        End If

        ' difference of vDiffFrom to vDiffTo
        Set vPageFrom = gNamespace.GetPage(gPage, vDiffFrom, True, False)
        Set vPageTo   = gNamespace.GetPageAndAttachments(gPage, vDiffTo, True, False)
        vDiffFrom = vPageFrom.GetLastChange().Revision
        vDiffTo   = vPageTo.GetLastChange().Revision
        vXmlStr = "<ow:diff type='" & vDiffType & "' from='" & vDiffFrom & "' to='" & vDiffTo & "'>"
        If vDiffTo > vDiffFrom Then
            Set vMatcher = New Matcher
            vXmlStr = vXmlStr & vMatcher.Compare(Server.HTMLEncode(vPageFrom.Text), Server.HTMLEncode(vPageTo.Text))
        End If
        vXmlStr = vXmlStr & "</ow:diff>"
        vXmlStr = vXmlStr & vPageTo.ToXML(1)

        If cCacheXML Then
            Call gNamespace.SetDocumentCache("diff" & vDiff, vXmlStr)
        End If
    End If

    Call gTransformer.Transform(vXmlStr)
    Set vMatcher  = Nothing
    Set vPageTo   = Nothing
    Set vPageFrom = Nothing

    gActionReturn = True
End Sub

Sub ActionEdit
'	Page name is gPage
	if cFreeLinks = 0 then '	// Don't allow editing or creation of FreeLink pages
		If ContainsFreeLinks(gPage) then
			gAction = "view"
			ActionView() '	// This will pick up the pattern again and display an error page
			gActionReturn = True
			Exit Sub
		end if
	end if

	Dim vPage, vChange, vXmlStr,vTemp
    Dim vNewRev, vMinorEdit, vComment, vSummary, vText,vCategory,bForceSave
        bForceSave=0 '        // Default

'	// Deal with read-only Wikis
	If cReadOnly Then
		'	// Setting the gPage name to 'ErrorPage' bypasses normal processing
		'	// and displays a hard-coded page with a body text set to the variable gErrorText
        gAction = "view"
		gPage=OPENWIKI_ERRORPAGENAME
		gErrorPageText = "This Wiki is currently set to read-only.  You cannot edit any page"
        ActionView()
        gActionReturn = True
        Exit Sub
    End If

'	// Deal with password-protected Wikis
	If gEditPassword <> "" Then
        If gEditPassword <> gReadPassword Then
            If Request.Cookies(gCookieHash & "?pe") <> gEditPassword Then
                Call ActionLogin()
                Exit Sub
            End If
        End If
    End If

'	// Check for empty loginname and CAPTCHA protection
	CheckForUserName '        PLUGIN
    CheckForCAPTCHA '        PLUGIN

'	// Init vars
Dim DeprecateText,DeprecateCommentText,ForceDeprecate
DeprecateText = ""
DeprecateCommentText=""
ForceDeprecate = false

	' // User has checked the 'deprecate' checkbox?
    If Request("deprecate") <> "" Then
        DeprecateText = "#DEPRECATED "
        DeprecateCommentText = "AUTO-DEPRECATED (" & Date & ") "
        ForceDeprecate = true
    End If

' // SAVE PAGE //
    If (Request("save") <> "") OR (ForceDeprecate = true) Then
	' // User has clicked 'save'
        bForceSave=1
        vNewRev    = Int(Request("newrev"))
        vMinorEdit = Int(Request("rc")) Xor 1
        If ForceDeprecate = true then vMinorEdit=0
        vSummary = Trim(Request("summary") & "")
        vComment   = DeprecateCommentText & Trim(Request("comment") & "")
        vText      = DeprecateText & Request("text")
        vCategory = Request("categories")
        If cAllowAnyPageName=0 then
                        '        // Trap for silly names with spaces and pluses
                        gPage=Capitalise(gPage)
                        gPage=Replace(gPage," ","") '        // Take out spaces
                        gPage=Replace(gPage,"+","") '        // Take out plus signs
                        gPage=Replace(gPage,"_","") '        // Take out underscores
        End If

        If Len(vComment) > 1000 Then
            vXmlStr = vXmlStr & "<ow:error code='1'>Maximum length for the comment is 1000 characters.</ow:error>"
        End If

                ' 2002/07/17 - Jerome Tremblay
        ' TODO: Use a better formatting function to allow for customizable format. (ex. Months with French names on a US English server)
		' UPDATED 20050220 Gordon Bamber
        vText = Replace(vText, "#NOW", FormatDateTime(Date,1) & " (" & FormatDateTime(Time) & ")")
        vText = Replace(vText, "#NOWD", FormatDateTime(Date,1))
        vText = Replace(vText, "#NOWT", FormatDateTime(Time))
        
        vText = Replace(vText, "#USER", gNameSpace.FetchUserName())
        If Len(vText) > OPENWIKI_MAXTEXT Then
            vXmlStr = vXmlStr & "<ow:error code='2'>Maximum length for the text is " & OPENWIKI_MAXTEXT & " characters.</ow:error>"
        End If

        If vXmlStr <> "" Then    
            Set vPage = gNamespace.GetPage(gPage, 0, False, False)
            vPage.Revision = gRevision
            vPage.Text     = vText & vPage.Category
            if vPage.Category <> vCategory then
                 vPage.Category = vCategory
                 bForceSave=1
            end if

' ************** ACCESS RESTRICTION PLUGIN ******************************
            CheckForAllowedEdit(vPage) '        // PLUGIN
' ************** ACCESS RESTRICTION PLUGIN ******************************

            Set vChange = vPage.GetLastChange()
            vChange.Revision  = vNewRev
            vChange.MinorEdit = vMinorEdit
            vChange.Summary   = vSummary
            vChange.Comment   = vComment
            vChange.Timestamp = Now()
            vChange.UpdateBy()
            vXmlStr = vXmlStr & vPage.ToXML(2)
        Elseif gNamespace.SavePage(vNewRev, vMinorEdit, vComment, vText,vCategory,vSummary,bForceSave) Then  
            Response.Redirect(gScriptName & "?" & Server.URLEncode(gPage))
        Else
        
            Set vPage = gNamespace.GetPage(gPage, 0, True, False)
            Set vChange = vPage.GetLastChange()
            vChange.Revision  = vChange.Revision + 1
            vChange.MinorEdit = Int(Request("rc")) Xor 1
            vChange.Comment   = Trim(Request("comment") & "")
            vChange.Summary   = Trim(Request("summary") & "")
            vChange.Timestamp = Now()
            vChange.UpdateBy()
            vXmlStr = vXmlStr & "<ow:error code='4'>Somebody else just edited this page.</ow:error>"
            vXmlStr = vXmlStr & "<ow:textedits>" & PCDATAEncode(Request("text")) & "</ow:textedits>"
            vXmlStr = vXmlStr & vPage.ToXML(2)
        End If
    Elseif Request("cancel") <> "" Then
        Dim vBacklink
        If gRevision = 0 Then
            vBacklink = gScriptName & "?" & Server.URLEncode(gPage)
        Else
            vBacklink = gScriptName & "?p=" & Server.URLEncode(gPage) & "&revision=" & gRevision
        End If
        Response.Redirect(vBacklink)
    Else
' // EDIT PAGE //
'		// Fetch the page
		Set vPage = gNamespace.GetPage(gPage, 0, True, False)
        CheckForAllowedEdit(vPage) '        // PLUGIN
        If gRevision > 0 Then
            Set gTemp = gNamespace.GetPage(gPage, gRevision, True, False)
            vPage.Revision = gTemp.Revision
            vPage.Text     = gTemp.Text
            vPage.Category = vCategory
        End If

        If vPage.Revision = 0 And Request("template") <> "" Then
            Set gTemp = gNamespace.GetPage(URLDecode(Request("template")), 0, True, False)
'			// BUGFIX START 20051224 Gordon Bamber
			If vPage.Exists then
				gAction = "view"
				gPage=OPENWIKI_ERRORPAGENAME
				gErrorPageText = "Cannot create this page. The page name '" & vPage.Name & "' already exists, and would be overwritten with"
				gErrorPageText = gErrorPageText & " the contents of " & gTemp.Name & "."
				ActionView()
				gActionReturn = True
				Exit Sub
			End If
'			// BUGFIX END 20051224 Gordon Bamber
            vPage.Text = gTemp.Text
        End If

        Set vChange = vPage.getLastChange()
        vChange.Revision  = vChange.Revision + 1
        vChange.MinorEdit = 0


        Dim EditorName
        EditorName=gNameSpace.FetchUserName()

'	// Hook here to fetch/change 'x is editing this page' display

        If EditorName = "Anonymous" then EditorName = "An anonymous user"
        if (cAutoComment = 1) then
           vChange.Comment = EditorName & " edited this page at " & Time()
        else
                        vChange.Comment = ""
        end if
        If ( (Request("template") <> "") AND (cAutoComment = 1) ) then vChange.Comment   = "Created from a Template by " & EditorName
        vChange.Timestamp = Now()
        vChange.UpdateBy()
        vXmlStr = vPage.ToXML(2)
    End If

    Call gTransformer.Transform(vXmlStr)
    gActionReturn = True
End Sub

Sub ActionCategorySearch
    Dim vXmlStr
    dim CategoryNumber
    CategoryNumber = Request("categorynumber")
    vXmlStr = gNamespace.GetIndexSchemes.GetCategorySearch(CategoryNumber)
    If cAllowRSSExport And Request("v") = "rss" Then
        Call gTransformer.TransformXmlStr(vXmlStr, "owsearchrss10export.xsl")
    Else
        Call gTransformer.Transform(vXmlStr)
    End If
    gActionReturn = True
End Sub

Sub ActionSummarySearch
    Dim vXmlStr
    Dim SearchFor
    SearchFor = Trim(Request("txt"))
    vXmlStr = gNamespace.GetIndexSchemes.GetSummarySearch(SearchFor)
    If cAllowRSSExport And Request("v") = "rss" Then
        Call gTransformer.TransformXmlStr(vXmlStr, "owsearchrss10export.xsl")
    Else
        Call gTransformer.Transform(vXmlStr)
    End If
    gActionReturn = True
End Sub


Sub ActionTitleSearch
    Dim vXmlStr
    vXmlStr = gNamespace.GetIndexSchemes.GetTitleSearch(Replace(gTxt,"+","_"))
    If cAllowRSSExport And Request("v") = "rss" Then
        Call gTransformer.TransformXmlStr(vXmlStr, "owsearchrss10export.xsl")
    Else
        Call gTransformer.Transform(vXmlStr)
    End If
    gActionReturn = True
End Sub

Sub ActionFullSearch
    Dim vXmlStr
    vXmlStr = gNamespace.GetIndexSchemes.GetFullSearch(Replace(gTxt,"+","_"), True)
    If cAllowRSSExport And Request("v") = "rss" Then
        Call gTransformer.TransformXmlStr(vXmlStr, "owsearchrss10export.xsl")
    Else
        Call gTransformer.Transform(vXmlStr)
    End If
    gActionReturn = True
End Sub

Sub ActionTextSearch
    Dim vXmlStr
    vXmlStr = gNamespace.GetIndexSchemes.GetTextSearch(Replace(gTxt,"+","_"), False)
    If cAllowRSSExport And Request("v") = "rss" Then
        Call gTransformer.TransformXmlStr(vXmlStr, "owsearchrss10export.xsl")
    Else
        Call gTransformer.Transform(vXmlStr)
    End If
    gActionReturn = True
End Sub

Sub ActionRandomPage
    Randomize
    Set gTemp = gNamespace.TitleSearch(".*", 0, 0, 0, 0)
    Response.Redirect(gScriptName & "?a=" & gAction & "&p=" & Server.URLEncode(gTemp.ElementAt(Int((gTemp.Count - 1) * Rnd)).Name) & "&redirect=" & Server.URLEncode(gPage))
End Sub

Sub ActionChanges
    Dim vXmlStr
        If cCacheXML Then
            vXmlStr = gNamespace.GetDocumentCache("changes")
        End If
        If vXmlStr = "" Then
            vXmlStr = gNamespace.GetPage(gPage, 0, False, True).ToXML(0)
            If cCacheXML Then
                Call gNamespace.SetDocumentCache("changes", vXmlStr)
            End If
        End If
        Call gTransformer.Transform(vXmlStr)
    gActionReturn = True
End Sub

Sub ActionUserPreferences
    If Request("save") <> "" Then
        Response.Cookies(gCookieHash & "?up").Expires  = Date + 365
        Response.Cookies(gCookieHash & "?up")("un")   = FreeToNormal(Request("username"))
        Response.Cookies(gCookieHash & "?up")("up")   = Request("userpassword")
        Response.Cookies(gCookieHash & "?up")("bm")   = Request("bookmarks")
        Response.Cookies(gCookieHash & "?up")("cols") = Request("cols")
        Response.Cookies(gCookieHash & "?up")("rows") = Request("rows")
        Response.Cookies(gCookieHash & "?up")("pwl")  = Request("prettywikilinks")
        Response.Cookies(gCookieHash & "?up")("bmt")  = Request("bookmarksontop")
        Response.Cookies(gCookieHash & "?up")("elt")  = Request("editlinkontop")
        Response.Cookies(gCookieHash & "?up")("trt")  = Request("trailontop")
        Response.Cookies(gCookieHash & "?up")("new")  = Request("opennew")
        Response.Cookies(gCookieHash & "?up")("emo")  = Request("emoticons")
        Response.Cookies(gCookieHash & "?up")("ski")  = Request("skin")
		If Request("userpassword")="" then
			Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&up=3")
		else
			Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&up=1")
		End If
    Elseif Request("clear") <> "" Then
        Response.Cookies(gCookieHash & "?up").expires  = #01/01/1990#
        Response.Cookies(gCookieHash & "?up") = ""
        Response.Redirect(gScriptName & "?p=" & Server.URLEncode(gPage) & "&up=2")
    End If
    gActionReturn = False
End Sub

Sub ActionLogout
     Response.Cookies(gCookieHash & "?pr").Expires = #01/01/1990#
     Response.Cookies(gCookieHash & "?pr") = ""
     Response.Cookies(gCookieHash & "?pe").Expires = #01/01/1990#
     Response.Cookies(gCookieHash & "?pe") = ""
     Response.Redirect(gScriptName & "?" & Server.URLEncode(gPage))
End Sub

Sub ActionLogin
    Dim vMode, vPwd, vXmlStr
    If gAction = "edit" Then
        vMode = "edit"
        gAction = "login"
    Else
        vMode = Request("mode")
    End If
    vPwd = Request("pwd")
    If vMode = "edit" Then
        If vPwd = gEditPassword Then
            If Request("r") = "1" Then
                Response.Cookies(gCookieHash & "?pe").Expires = Date + 60
            End If
            Response.Cookies(gCookieHash & "?pe") = vPwd
            Response.Redirect(gScriptName & "?" & Request("backlink"))
        End If
    Else
        If vPwd = gReadPassword Then
            If Request("r") = "1" Then
                Response.Cookies(gCookieHash & "?pr").Expires = Date + 60
            End If
            Response.Cookies(gCookieHash & "?pr") = vPwd
            Response.Redirect(gScriptName & "?" & Request("backlink"))
        End If
    End If
    If vPwd <> "" Then
        vXmlStr = "<ow:error code='3'>Incorrect password</ow:error>"
    End If
    If Request("backlink") <> "" Then
        gTemp = Request("backlink")
    Else
        gTemp = Request.ServerVariables("QUERY_STRING")
        If gTemp = "" Then
            gTemp = OPENWIKI_WELCOMEPAGE
        End If
    End If
    vXmlStr = vXmlStr & "<ow:login"
    If vMode = "edit" Then
        vXmlStr = vXmlStr & " mode='edit'>"
    Else
        vXmlStr = vXmlStr & " mode='view'>"
    End If
    vXmlStr = vXmlStr & "<ow:backlink>" & PCDATAEncode(gTemp) & "</ow:backlink>"
    If Request("r") <> "" Then
        vXmlStr = vXmlStr & "<ow:rememberme>true</ow:rememberme>"
    End If
    vXmlStr = vXmlStr & "</ow:login>"
    Call gTransformer.Transform(vXmlStr)
    gActionReturn = True
End Sub

Sub ActionRename
'	// Deal with read-only Wikis
	If cReadOnly Then
		'	// Setting the gPage name to 'ErrorPage' bypasses normal processing
		'	// and displays a hard-coded page with a body text set to the variable gErrorText
        gAction = "view"
		gPage=OPENWIKI_ERRORPAGENAME
		gErrorPageText = "This Wiki is currently set to read-only.  You cannot edit any page"
        ActionView()
        gActionReturn = True
        Exit Sub
    End If

    If gEditPassword <> "" Then
        If gEditPassword <> gReadPassword Then
            If Request.Cookies(gCookieHash & "?pe") <> gEditPassword Then
                        Call ActionLogin()
                        Exit Sub
            End If
        End If
    End If

	If Request("cancel") = "Cancel" then
		gSuccessPageText="Cancel accepted!  Return to " & gPage
		gPage=OPENWIKI_SUCCESSPAGENAME
        gAction = "view"
        ActionView()
        gActionReturn = True
        Exit Sub
	End If
        Dim vPage, vXmlStr, vRename,bRenameChildren
     Set vPage = gNamespace.GetPage(gPage, 0, True, False)

        CheckForUserName '        // PLUGIN
        CheckForCAPTCHA '        // PLUGIN
' ************** ACCESS RESTRICTION PLUGIN ******************************
        CheckForAllowedEdit(vPage) '        // PLUGIN
' ************** ACCESS RESTRICTION PLUGIN ******************************

        vRename = ""
        If Request("step") = "process" and not gPage = "" then
                bRenameChildren = (Request("nochildrename") = "")
                
'                vRename = gNamespace.ChangePageName(gPage, Request("newName"),true)
                vRename = gNamespace.ChangePageName(gPage, Request("newName"),bRenameChildren)
                If not vRename = "" then Response.Redirect(gScriptName & "?" & vRename)
        ElseIf Request("step") = "error" then
                vXmlStr = "<ow:error code='3'>" & Request("errorText") & "</ow:error>"
        End If
        vXmlStr = vXmlStr & "<ow:rename page='" & gPage & "'>"
        vXmlStr = vXmlStr & "</ow:rename>"

        Call gTransformer.Transform(vXmlStr)
        gActionReturn = True
End Sub


%>