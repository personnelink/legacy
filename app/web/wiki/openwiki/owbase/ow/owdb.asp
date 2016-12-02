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
'        $Log: owdb.asp,v $
'        Revision 1.74  2006/08/22 03:12:08  by1mmm
'        'New Functions for Tags.20060822 By1mmm(1mmmmmm@gmail.com)
'        '//added 2 new files:
'        	ow/owtag.asp
'        	ow/skins/common/tag.xsl
'        '//modified  6 files
'        	ow/owall.asp:
'        	ow/owpatterns.asp
'        	ow/owdb.asp:
'        	ow/owpage.asp:Class Change
'        	ow/owindex.asp
'        	ow/skins/default/ow.xsl
'
'        Revision 1.73  2006/04/10 08:59:29  gbamber
'        Build 20060407:
'
'        BugFix for Oracle:
'        When editing a page in invalid syntax was used to update attachments.
'        changes in:
'        owdb.asp
'
'        New Authorisation Subs for customizable Authorisation. New myauth.asp containing to the two new Subs.
'        changes in:
'        owall.asp
'        owplugin_viewrestrictions.asp
'        owplugin_editrestrictions.asp
'        myauth.asp
'
'        New Functions for more customizable wikify patterns.
'        changes in:
'        owpatterns.asp
'        mywikify.asp
'
'        New option cReadCategoriesFromDB. If its set to 1 then additional categories are read from the db.
'        changes in:
'        owconfig_default.asp
'        owpreamble.asp
'        owprocessor.asp
'
'        Note:
'        The values of KEY_CATEGORIES in OPENWIKI_CATEGORIES MUST MATCH their current entry !
'        e.g. last hardcoded categorie is No.22 "Protected View and Edit",
'        so the first entry in OPENWIKI_CATEGORIES must be 23 "whatever category" and the next 24 etc.
'
'        if you have any questions you can also mail me to vagabond@gmx.com.
'
'        Revision 1.72  2006/03/14 09:59:59  gbamber
'        Minor change to hardcoded pages code
'
'        Revision 1.71  2006/03/14 08:57:50  gbamber
'        Enhancement: ErrorStack now more configerable
'        BugFix: hardcoded pages now display correctly
'        Test: <showsharedimages(foobar)> shows the errorstack at work
'
'        Revision 1.70  2006/03/11 17:58:59  gbamber
'        Semicolons removed from SQL statements
'
'        Revision 1.69  2006/03/03 09:35:39  gbamber
'        Updated credits
'
'        Revision 1.68  2006/02/22 12:27:14  gbamber
'        Build 20060216.6
'        Bugfixes to ImageUpload and DeletePage
'        Hardcoded ImageUpload page into owdb.asp
'        Only if cAllowImageLibrary=1 will UploadImage work.
'
'        Revision 1.67  2006/02/22 11:26:03  gbamber
'        Build 20060216.5
'        ImageUpload now uses ActionView for it's result page.
'        Taken out some generic Requests so that we no longer have to use Response.Redirect to report an error to the user
'
'        Revision 1.66  2006/02/22 10:17:12  gbamber
'        Build 20060216.3
'        Changed refs of local: to sharedimage:
'        Softcoded error and success page names
'        Surrounded frontpage var with <nowiki> tags
'        Restored DeletePageAndAttachments function in owdb
'
'        Revision 1.65  2006/02/22 09:03:54  gbamber
'        Changed refs of local: to sharedimage:
'        Softcoded error and success page names
'        Surrounded frontpage var with <nowiki> tags
'
'        Revision 1.64  2006/02/16 18:33:16  gbamber
'        General update:
'        Rename improved
'        local: now sharedimage:
'        New imageupload macro
'        added file uploadimage.asp
'        changed owall to fix #includes with attach.asp
'        new doctypes for google earth
'        new urltype skype
'        Userprefs has a password field
'        Reaname template updated
'
'        Revision 1.63  2006/01/10 15:45:18  galleyslave
'        TitleSearch for the CategoryIndex page now returns records orderd by title, then pagename so pages are in alpha order rather than random within the categories.
'
'        Revision 1.62  2006/01/09 13:55:23  galleyslave
'        changes to 1.60 renamed table to use openwiki_ (as per rest of owdb.asp)
'
'        Revision 1.61  2006/01/09 13:46:03  galleyslave
'        Fixes sourceforge bugs:
'        1398461 - deleterevisions causes vilation of foreign key contrants as
'        attachments & attachments_log tables need to be deleted first
'        1400221 - attachments not updated - now updates correctly.
'
'        Revision 1.60  2006/01/03 12:10:35  galleyslave
'        Updated Attachment log code to fix cursor unable to support bookmarks error when saving pages with attachments.  Topics 61 & 83
'
'        Revision 1.59  2005/12/14 20:39:57  gbamber
'        BugFix:Updated hardcoded 'Help' link in editing window
'        BugFix:Updated gStrictLinkPattern to include underscores
'        BugFix:Changed scope of userprefs cookie
'        New:Action UpgradeFreelinks
'        New:Added Maintainance link to admin control panel
'        New:Added parameter to SuccessfulAction page
'        New:owdb function to upgrade freelink pages
'
'        Revision 1.58  2005/12/13 11:23:01  gbamber
'        Added new autogenerate page HelpOnEmoticons
'
'        Revision 1.57  2005/12/10 12:13:07  gbamber
'        Added autogenerated CaptchaError page (uses variable in owconfig_default)
'
'        Revision 1.56  2005/12/10 08:38:08  gbamber
'        BUILD 20051210
'        New: <RedirectPage>
'        New <CreateSubPage>
'        BugFix: CreatePage macro code
'        BugFix: Userprefs back link
'        BugFix: CAPTCHA now works
'        BugFic: cUseFreeLinks=0 option works correctly
'        BugFix: Page rename partly repaired
'        BugFix: forceusername uses persistent cookie
'        //Gordon//
'
'        Revision 1.55  2005/11/12 00:06:33  sansei
'        Translated text:openwiki2004 into OpenWiking in several documents
'        New default access DB (OpenWikiNG.mdb) (added in an earlier CVS session)
'
'        Revision 1.54  2005/11/08 15:42:06  sansei
'        updated the automagical HelpPage
'
'        Revision 1.53  2005/11/07 22:37:43  sansei
'        updated: CreditsPage (automagically created page)
'
'        Revision 1.52  2005/03/01 06:08:31  sansei
'        added OPTIONAL new syntax for PageBookmarks
'        If a * (star) is present in the macro data then use multible pagebookmarks syntax, if NOT then use single syntax.
'
'        Revision 1.51  2005/02/21 13:29:05  gbamber
'        BUGFIX: Error in rename function fixed
'
'        Revision 1.50  2005/02/16 15:31:57  gbamber
'        UPDATED: Automatic CreditsPage code
'        FIXED: Duplicate SummarySearch entries
'
'        Revision 1.49  2005/02/11 13:52:38  gbamber
'        Updated the hardcoded CreditsPage
'
'        Revision 1.48  2005/02/11 11:38:51  gbamber
'        Build 20050211
'        Added:
'        cShowOldEmoticons     = 1        ' 1 = Include OpenWiki0.78 syntax, 0 = Ignore old syntax
'        cTitleIndexIgnoreCase = 0        ' 1 = Ignore case when compiling the Title Index, 0 = Differenciate LC and UC
'
'        Revision 1.47  2005/01/18 19:14:30  sansei
'        Moved plugspecific code from MAIN code to owpluginfunnel.asp
'        -- Thats the task for the funnel! (= expose MAINCODE to the plugins!)
'
'        Revision 1.46  2005/01/18 18:49:34  sansei
'        dumps only badgeslist if allowbadges!
'
'        Revision 1.45  2005/01/17 18:07:05  sansei
'        EDITOR: added dropdown with 'installed badges' from badges.txt
'        PAGE: badge macro can now show list from badges.txt
'
'        Revision 1.44  2004/11/07 15:07:24  gbamber
'        Added: cWikifyPageHeadings=1|0
'        Updated: Coloured text
'        Updated: UpdateDB functions
'        Added: default_css skin
'        Updated: Myrthful skin
'
'        Revision 1.43  2004/11/01 12:14:24  gbamber
'        NEW: Admin function 'Nuke deprecated pages older than:'
'
'        Revision 1.42  2004/10/31 21:11:07  gbamber
'        New admin functions - Delete old revisions (this page | All) for default skin only
'
'        Revision 1.41  2004/10/30 20:42:50  gbamber
'        Added gWikiAdministrator="Wikiadmin"
'        Added 'Delete this page' if using admin name and local IP
'        Changed FetchUsername function to owdb.asp
'        Added auto-success page
'
'        Revision 1.39  2004/10/22 10:07:25  gbamber
'        BUGFIX: Create MacroHelp table error
'
'        Revision 1.38  2004/10/21 21:42:28  gbamber
'        BUGFIX: Improved Rename facility
'
'        Revision 1.37  2004/10/20 18:30:27  gbamber
'        RenamePage now does entire SubPage trees
'        Some formatting improvements in owwikify
'
'        Revision 1.36  2004/10/19 12:35:13  gbamber
'        Massive serialising update.
'
'        Revision 1.35  2004/10/13 12:17:21  gbamber
'        Forced updates to make sure CVS reflects current work
'
'        Revision 1.34  2004/10/13 11:31:48  gbamber
'        BugFix: Syntax error!
'
'        Revision 1.33  2004/10/13 10:53:25  gbamber
'        Modified: <showlinks>
'        BugFix: SavePage for MSSQL server
'        Updated: default and default_left skins with summaries template
'
'        Revision 1.32  2004/10/13 00:18:00  gbamber
'        1 ) More debugging options (1,2 and 3)
'        2 ) <systeminfo(appname)>
'        3 ) OPENWIKI_FINDNAME = FindPage
'        4 ) TitleIndex shows summary text
'        5 ) Page links show summary text + Date changed
'        6 ) CategoryIndex shows page visits
'        7 ) More robust database autoupgrade
'
'        Revision 1.31  2004/10/11 13:59:13  gbamber
'        Minor bugfix for SQL Server
'
'        Revision 1.30  2004/10/11 12:53:38  gbamber
'        Added: <SummarySearch(PP)>
'        Modified: <ow:link> to show summaries
'
'        Revision 1.29  2004/10/11 00:24:49  gbamber
'        Minor fixes:
'        vCols default=79
'        Default bookmarks are owClassic pages
'        Improved auto-HelpPage
'
'        Revision 1.28  2004/10/10 22:47:42  gbamber
'        Massive update!
'        Added: Summaries
'        Added: Default pages built-in
'        Added: Auto-update from openwiki classic
'        Modified: Default plugin status
'        Modified: Default Page Names
'        Modified: Default MSAccess DB to openwikidist.mdb
'        BugFix: Many MSAccess bugs fixed
'        Modified: plastic skin to show Summary
'
'        Revision 1.27  2004/10/09 13:54:21  gbamber
'        Bugfix: Error when deleting old revisions in line 62(n) (SavePage) of owdb.asp
'
'        Revision 1.26  2004/10/07 21:59:46  gbamber
'        BugFix: SavePage for when cUseCategories=0
'        No buildnumber update
'
'        Revision 1.25  2004/10/06 09:49:19  gbamber
'        Added Accessibility for Macro Forms
'        Bugfix on page delete (owdb)
'
'        Revision 1.24  2004/10/05 13:58:55  sansei
'        Added 2 global variables OPENWIKING_URL, OPENWIKING_TITLE (owdb.asp) - Changed Powered by logo to say: Powered by OpenWikiNG
'
'        Revision 1.23  2004/09/11 09:35:37  gbamber
'        Various minor bugfixes
'
'        Revision 1.22  2004/09/03 18:06:24  gbamber
'        Added Macro <CategorySearch>
'
'        Revision 1.21  2004/09/02 19:13:47  gbamber
'        Added <TitleCategoryIndex> macro
'
'        Revision 1.20  2004/09/02 10:33:24  gbamber
'        Added improved Category code
'
'        Revision 1.19  2004/08/30 09:48:37  gbamber
'        Bugfix: IsNull fault fixed
'
'        Revision 1.18  2004/08/29 11:20:35  gbamber
'        WikiBadge code added
'
'        Revision 1.17  2004/08/28 01:03:56  gbamber
'        Added UserPreferences Skinning
'
'        Revision 1.16  2004/08/22 20:54:50  gbamber
'        Bugfix:  Fixed TitleIndex bug for MSAccess goving wrong wpg_hits ordering
'
'        Revision 1.15  2004/08/15 22:28:49  carlthewebmaste
'        SQL query fix for Access Driver/ODBC, lines 495, 501.
'
'        Revision 1.14  2004/08/15 16:57:34  carlthewebmaste
'        Adding Upload Support, including fake progress bar.
'
'        Owpreamble:
'        Updated build to 20040815.1
'        Added constants for OPENWIKI_UPLOADMETHOD:
'        ' possible values for OPENWIKI_UPLOADMETHOD
'        Const UPLOADMETHOD_LEWISMOTEN         = 0
'        Const UPLOADMETHOD_ABCUPLOAD         = 1
'        Const UPLOADMETHOD_SAFILEUP                 = 2
'
'        owado.asp:
'        Added ado constants for owupload, owuploadfield.
'
'        owattach.asp:
'        Added support for uploads, script (lewis moten) and COM methods.
'
'        owconfig_default.asp:
'        added OPENWIKI_UPLOADMETHOD,
'        default = UPLOADMETHOD_LEWISMOTEN
'        NOTE: cAllowAttachments left at 0 for default
'
'        skins\\default\\owattach.xsl
'        skins\\graphical\\owattach.xsl
'        Added 'fake progress bar' capability to occupy user while upload is in progress.
'
'        images\\icons\\doc\\psd.gif - missing icon for psd filetype
'        images\\loading.swf - fake progressbar movie file
'        owupload.asp - Upload class for LewisMoten upload method
'        owuploadfield.asp - helper class for Upload
'
'        Revision 1.13  2004/08/13 23:02:48  gbamber
'        Tweaked TitleHitIndex code.  Minor change only.
'
'        Revision 1.12  2004/08/13 07:32:15  gbamber
'        Fixed Rename (again!)
'
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owdb.asp,v $
'    $Revision: 1.74 $
'      $Author: by1mmm $
' ---------------------------------------------------------------------------
'

Class OpenWikiNamespace
    Private vConn, vRS, oConn, oRs, vQuery
    Private vIndexSchemes
    Private vCachedPages

    Private Sub Class_Initialize()
        If OPENWIKI_DB = "" Then
            cAllowAttachments = 0
            cWikiLinks = 0
            cCacheXML = 0
        Else
            Set vConn = Server.CreateObject("ADODB.Connection")
            vConn.Open OPENWIKI_DB
            Set vRS = Server.CreateObject("ADODB.Recordset")
            Set oConn = Server.CreateObject("ADODB.Connection")
            oConn.Open OPENWIKI_DB
            Set oRS = Server.CreateObject("ADODB.Recordset")
        End If
        Set vIndexSchemes = New IndexSchemes
        Set vCachedPages = Server.CreateObject("Scripting.Dictionary")
    End Sub

    Private Sub Class_Terminate()
        On Error Resume Next
        vConn.Close
        Set vConn = Nothing
        Set vRS = Nothing
        oConn.Close
        Set oConn = Nothing
        Set oRS = Nothing
        Set vIndexSchemes = Nothing
        Set vCachedPages = Nothing
    End Sub

    Sub BeginTrans(pConn)
        If OPENWIKI_DB_SYNTAX <> DB_MYSQL Then
            pConn.BeginTrans()
        End If
    End Sub

    Sub CommitTrans(pConn)
        If OPENWIKI_DB_SYNTAX <> DB_MYSQL Then
            pConn.CommitTrans()
        End If
    End Sub

    Sub RollbackTrans(pConn)
        If OPENWIKI_DB_SYNTAX <> DB_MYSQL Then
            pConn.RollbackTrans()
        End If
    End Sub

    Private Function CreatePageKey(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
        CreatePageKey = pRevision & "_" & pIncludeText & "_" & pIncludeAllChangeRecords & "_" & pPageName
    End Function

    Private Function GetCachedPage(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
        Dim vKey
        vKey = CreatePageKey(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
        If vCachedPages.Exists(vKey) Then
            Set GetCachedPage = vCachedPages.Item(vKey)
        Else
            Set GetCachedPage = Nothing
        End If
    End Function

    Private Sub SetCachedPage(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords, vPage)
        Dim vKey
        vKey = CreatePageKey(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
        vCachedPages.Add vKey, vPage
    End Sub

    Public Function IsLocalMachine
        Dim ct,iNumChars,gIP '        // Used in the Local IP loop
        IsLocalMachine = false '      // Assume failure
        gIP=Trim(Request.ServerVariables("REMOTE_ADDR"))
        for ct=0 to UBound(gOverrideIPArray)-1
            iNumChars=Len(gOverrideIPArray(ct))
            if Left(gIP,iNumChars)=gOverrideIPArray(ct) then
              IsLocalMachine = true
              Exit For
            end if
        next
    End Function

    Public Function GetIndexSchemes
        Set GetIndexSchemes = vIndexSchemes
    End Function

	Public Function DeleteOldRevisions(pPagename)
		Dim AttQuery1, AttQuery2, RevQuery1,RevQuery2,PageQuery
		' You could also delete any cached versions with this line
		' vQuery = "DELETE FROM openwiki_cache WHERE chc_name = '" & Replace(pPagename, "'", "''") & "'"

		' TODO - need to delete the old files that are removed when deleting the openwiki_attachments records.
		' need to ensure that the file is not still referenced by a live attachments

		DeleteOldRevisions = false '        // Assume failure
		If OPENWIKI_DB_SYNTAX = DB_ACCESS then
			AttQuery1 = "DELETE DISTINCTROW openwiki_attachments.*, openwiki_revisions.wrv_current FROM openwiki_revisions INNER JOIN openwiki_attachments ON (openwiki_attachments.att_wrv_revision = openwiki_revisions.wrv_revision) AND (openwiki_revisions.wrv_name = openwiki_attachments.att_wrv_name) WHERE (((openwiki_revisions.wrv_current)=0))"
			AttQuery2 = "DELETE DISTINCTROW openwiki_attachments_log.*, openwiki_revisions.wrv_current FROM openwiki_attachments_log INNER JOIN openwiki_revisions ON (openwiki_revisions.wrv_revision = openwiki_attachments_log.ath_wrv_revision) AND (openwiki_attachments_log.ath_wrv_name = openwiki_revisions.wrv_name) WHERE (((openwiki_revisions.wrv_current)=0))"
			RevQuery1 = "DELETE * FROM openwiki_revisions WHERE wrv_current = 0"
			RevQuery2 = "UPDATE openwiki_revisions SET wrv_revision=1, wrv_minoredit=0"
			PageQuery = "UPDATE openwiki_pages SET wpg_lastmajor=1, wpg_lastminor=1, wpg_changes=1"
		else
			AttQuery1 = "DELETE openwiki_attachments     FROM openwiki_attachments     INNER JOIN openwiki_revisions ON (openwiki_revisions.wrv_name = att_wrv_name) AND (openwiki_revisions.wrv_revision = att_wrv_revision) WHERE openwiki_revisions.wrv_current = 0"
			AttQuery2 = "DELETE openwiki_attachments_log FROM openwiki_attachments_log INNER JOIN openwiki_revisions ON (openwiki_revisions.wrv_name = ath_wrv_name) AND (openwiki_revisions.wrv_revision = ath_wrv_revision) WHERE openwiki_revisions.wrv_current = 0"
			RevQuery1 = "DELETE FROM openwiki_revisions WHERE wrv_current = 0"
			RevQuery2 = "UPDATE openwiki_revisions SET wrv_minoredit=0"
			PageQuery = "UPDATE openwiki_pages SET wpg_lastmajor=openwiki_revisions.wrv_revision, wpg_lastminor=openwiki_revisions.wrv_revision, wpg_changes=1 FROM openwiki_revisions WHERE openwiki_revisions.wrv_name = wpg_name AND openwiki_revisions.wrv_current = 1"
			' there is no need to set the revision number back to 1, the foreign key contrainst prevent this being done without
			' dropping the key then recreating it, & should not hard code DDL in the code
		end if

		if (pPagename <> "") then
			If PageExists(pPagename) then
				AttQuery1 = AttQuery1 & " AND att_wrv_name = '" & Replace(pPagename, "'", "''") & "'"
				AttQuery2 = AttQuery2 & " AND ath_wrv_name = '" & Replace(pPagename, "'", "''") & "'"
				RevQuery1 = RevQuery1 & " AND wrv_name = '" & Replace(pPagename, "'", "''") & "'"
				RevQuery2 = RevQuery2 & " WHERE wrv_name  = '" & Replace(pPagename, "'", "''") & "'"
				PageQuery = PageQuery & " AND wpg_name  = '" & Replace(pPagename, "'", "''") & "'"
			end if
		end if
		AttQuery1 = AttQuery1 
		AttQuery2 = AttQuery2 
		RevQuery1 = RevQuery1 
		RevQuery2 = RevQuery2 
		PageQuery = PageQuery 

		BeginTrans(vConn)
		vConn.Execute(AttQuery1)
		vConn.Execute(AttQuery2)
		vConn.Execute(RevQuery1)
		vConn.Execute(RevQuery2)
		vConn.Execute(PageQuery)

		If vConn.Errors.count = 0 Then
			CommitTrans(vConn)
			DeleteOldRevisions = true
		else
			RollbackTrans(vConn)
		end if
	End Function


        Public Function NukeDeprecatedPages(pDaysOlderThan)
        Dim rs, q, v, vText,iDaysToKeep
                ' If a page is marked as deprecated, but was last modified less than
                ' <pDaysOlderThan> days, then keep the page and/or attachment. Otherwise
                ' delete it.
                NukeDeprecatedPages = false '        // Assume failure
        if pDaysOlderThan="" then pDaysOlderThan = OPENWIKI_DAYSTOKEEP
        If NOT IsNumeric(pDaysOlderThan) then Exit Function
                iDaysToKeep = 0 + pDaysOlderThan
        q = "SELECT wrv_name, wrv_timestamp, wrv_text FROM openwiki_revisions WHERE wrv_current = 1"
        Set v = New Vector
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open q, OPENWIKI_DB, adOpenForwardOnly
        Do While Not rs.EOF
                If rs("wrv_timestamp") < (Now() - iDaysToKeep) Then
                        vText = rs("wrv_text")
                        If Len(vText) >= 11 Then
                                If Left(vText, 11) = "#DEPRECATED" Then
                                        ' Response.Write(rs("wrv_name") & "<br />")
                                        v.Push "" & rs("wrv_name")
                                End If
                        End If
                End If
                rs.MoveNext
        Loop
        Set rs = Nothing


        Dim vFSO, vPagename
        Set vFSO = Server.CreateObject("Scripting.FileSystemObject")

        ' delete pages and their attachments
        Do While Not v.IsEmpty
                vPagename = v.Pop
                BeginTrans(vConn)
                vConn.Execute("DELETE FROM openwiki_revisions WHERE wrv_name = '" & Replace(vPagename, "'", "''") & "'")
                vConn.Execute("DELETE FROM openwiki_attachments_log WHERE ath_wrv_name = '" & Replace(vPagename, "'", "''") & "'")
                vConn.Execute("DELETE FROM openwiki_attachments WHERE att_wrv_name = '" & Replace(vPagename, "'", "''") & "'")
                                If vConn.Errors.count = 0 Then
                                        CommitTrans(vConn)
                                        If vFSO.FolderExists(Server.MapPath(OPENWIKI_UPLOADDIR & vPagename & "/")) Then
                                                        vFSO.DeleteFolder(Server.MapPath(OPENWIKI_UPLOADDIR & vPagename & "/"))
                                        End If
                                else
                                        RollbackTrans(vConn)
                                end if
        Loop
        Set v = Nothing

        vConn.Execute("DELETE FROM openwiki_pages WHERE NOT EXISTS (SELECT 'x' FROM openwiki_revisions WHERE wrv_name = wpg_name)")

        ' delete deprecated attachments
        Dim vPath
        q = "SELECT att_wrv_name, att_filename, att_timestamp FROM openwiki_attachments WHERE att_deprecated = 1"
        Set v = New Vector
        Set rs = Server.CreateObject("ADODB.Recordset")
        'rs.Open q, OPENWIKI_DB, adOpenForwardOnly
        rs.Open q, OPENWIKI_DB, adOpenKeyset, adLockOptimistic, adCmdText
        Do While Not rs.EOF
                If rs("att_timestamp") < (Now() - iDaysToKeep) Then
                        vPath = Server.MapPath(OPENWIKI_UPLOADDIR & rs("att_wrv_name") & "/" & rs("att_filename"))
                        If vFSO.FileExists(vPath) Then
                                ' Response.Write(vPath & "<br />")
                                vFSO.DeleteFile(vPath)
                                rs.Delete
                        End If
                End If
                rs.MoveNext
        Loop
        Set rs = Nothing
        NukeDeprecatedPages = true
        End Function

	Function DeletePageAndAttachments(vPagename)
        Dim vFSO
        Set vFSO = Server.CreateObject("Scripting.FileSystemObject")
		BeginTrans(vConn)
		vConn.Execute("DELETE FROM openwiki_pages WHERE wpg_name = '" & Replace(vPagename, "'", "''") & "'")
		vConn.Execute("DELETE FROM openwiki_revisions WHERE wrv_name = '" & Replace(vPagename, "'", "''") & "'")
		vConn.Execute("DELETE FROM openwiki_attachments_log WHERE ath_wrv_name = '" & Replace(vPagename, "'", "''") & "'")
		vConn.Execute("DELETE FROM openwiki_attachments WHERE att_wrv_name = '" & Replace(vPagename, "'", "''") & "'")
		If vConn.Errors.count = 0 Then
				CommitTrans(vConn)
				DeletePageAndAttachments=True
				If vFSO.FolderExists(Server.MapPath(OPENWIKI_UPLOADDIR & vPagename & "/")) Then
					vFSO.DeleteFolder(Server.MapPath(OPENWIKI_UPLOADDIR & vPagename & "/"))
				End If
		else
			RollbackTrans(vConn)
			DeletePageAndAttachments=False
		end if
	End Function

    Function GetPageAndAttachments(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
         UpdateReferer(pPagename) '        PLUGIN

        Dim vPage
        Set vPage = GetCachedPage(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
        If TypeName(vPage) = TypeName(Nothing) Then
            Set vPage = GetPage(pPageName, pRevision, pIncludeText, False)
            If cAllowAttachments Then
                Call GetAttachments(vPage, pRevision, pIncludeAllChangeRecords)
            End If
        Elseif cAllowAttachments And Not vPage.AttachmentsLoaded Then
            Call GetAttachments(vPage, pRevision, pIncludeAllChangeRecords)
        End If
        Set GetPageAndAttachments = vPage
    End Function

'========added by 1mmm
        Sub TestForTagTable
                If OPENWIKING_UPDATEDB = 0 then exit sub
                On Error Resume Next
                vQuery="SELECT wrv_tag FROM openwiki_revisions"
                vRS.Open vQuery, vConn, adOpenForwardOnly
                If vConn.Errors.count <> 0 Then
                        If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                                vQuery="ALTER TABLE openwiki_revisions ADD COLUMN wrv_tag varchar(255) NULL"
                        else
                                vQuery="ALTER TABLE openwiki_revisions ADD [wrv_tag] [varchar](255) NULL"
                        end if
                        BeginTrans(vConn)
                        vConn.Execute(vQuery)
                        If vConn.Errors.count <> 0 Then RESPONSE.WRITE(vQuery & " caused a probelm")
                        'vQuery "UPDATE openwiki_revisions SET wrv_tag=''"
                        'vConn.Execute(vQuery)
                        CommitTrans(vConn)
                End if
                vRs.Close
        End Sub
'=======end by 1mmm

        Sub TestForBadLinkListTable
                If OPENWIKING_UPDATEDB = 0 then exit sub
                On Error Resume Next
                vQuery="SELECT bll_name FROM openwiki_badlinklist"
                vRS.Open vQuery, vConn, adOpenForwardOnly
                If vConn.Errors.count <> 0 Then
                        BeginTrans(vConn)
                        If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                                vQuery="CREATE TABLE openwiki_badlinklist (" &_
                                "bll_name varchar (255) NOT NULL ," &_
                                "bll_comment varchar (255) NULL DEFAULT 'Spam Link')"
                        else
                                vQuery="CREATE TABLE [dbo].[openwiki_badlinklist] (" &_
                                "[bll_name] [varchar] (255) NOT NULL ," &_
                                "[bll_comment] [varchar] (255) NULL DEFAULT 'Spam Link'" &_
                                ") ON [PRIMARY]"
                        end if
                        vConn.Execute(vQuery)
                        vQuery="INSERT INTO openwiki_badlinklist (bll_name,bll_comment) VALUES ('http://www.spam.com','Spam link')"
                        vConn.Execute(vQuery)
                        CommitTrans(vConn)
                End if
                vRs.Close
        End Sub

        Sub TestForReferrersTable
                If OPENWIKING_UPDATEDB = 0 then exit sub
                On Error Resume Next
                vQuery="SELECT rfr_name FROM openwiki_referers"
                vRS.Open vQuery, vConn, adOpenForwardOnly
                If vConn.Errors.count <> 0 Then
                        BeginTrans(vConn)
                        If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                                 vQuery="CREATE TABLE openwiki_referers (" &_
                                "rfr_name varchar (255) NULL ," &_
                                "rfr_date datetime NOT NULL DEFAULT Now())"
                        else
                                 vQuery="CREATE TABLE openwiki_referers (" &_
                                "[rfr_name] [varchar] (255) NULL ," &_
                                "[rfr_date] [datetime] NOT NULL DEFAULT GETDATE()" &_
                                ") ON [PRIMARY]"
                        end if
                        vConn.Execute(vQuery)
                        If vConn.Errors.count <> 0 Then RESPONSE.WRITE(vQuery & " caused a problem")
                        CommitTrans(vConn)
                End if
                vRs.Close
        End Sub

        Sub TestForMacroHelpTable
                If OPENWIKING_UPDATEDB = 0 then exit sub
                On Error Resume Next
                vConn.Errors.count = 0
                If OPENWIKING_UPDATEDB = 1 then
                                        vQuery="SELECT macro_name FROM openwiki_macrohelp"
                                        vRS.Open vQuery, vConn, adOpenForwardOnly
                                End If
                                If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                                                                                                 vQuery="CREATE TABLE openwiki_macrohelp (" &_
                                                                                                 "macro_name varchar (255) NOT NULL PRIMARY KEY," &_
                                                                                                 "macro_builtin int NULL DEFAULT 1," &_
                                                                                                 "macro_numparams int NULL DEFAULT 0," &_
                                                                                                 "macro_description varchar (255) NULL DEFAULT 'No description available'," &_
                                                                                                 "macro_param1 varchar (255) NULL DEFAULT 'None'," &_
                                                                                                 "macro_param2 varchar (255) NULL DEFAULT 'None'," &_
                                                                                                 "macro_param3 varchar (255) NULL DEFAULT 'None'," &_
                                                                                                 "macro_comment varchar (255) NULL DEFAULT 'None'" &_
                                                                                                 ")"
                                else
                                                                                                 vQuery="CREATE TABLE openwiki_macrohelp (" &_
                                                                                                 "macro_name [varchar] (255) NOT NULL PRIMARY KEY," &_
                                                                                                 "macro_builtin [int] NULL DEFAULT 1," &_
                                                                                                 "macro_numparams [int] NULL DEFAULT 0," &_
                                                                                                 "macro_description [varchar] (255) NULL DEFAULT 'No description available'," &_
                                                                                                 "macro_param1 [varchar] (255) NULL DEFAULT 'None'," &_
                                                                                                 "macro_param2 [varchar] (255) NULL DEFAULT 'None'," &_
                                                                                                 "macro_param3 [varchar] (255) NULL DEFAULT 'None'," &_
                                                                                                 "macro_comment [varchar] (255) NULL DEFAULT 'None'" &_
                                                                                                 ") ON [PRIMARY]"
                                end if
                                If (vConn.Errors.count <> 0) OR (OPENWIKING_UPDATEDB = 2) Then
                        BeginTrans(vConn)
                        vConn.Execute(vQuery)
                        If vConn.Errors.count <> 0 Then RESPONSE.WRITE(vQuery & " caused a problem")
                        CommitTrans(vConn)
                End if
                vRs.Close
        End Sub

        Sub TestForSummaryTable
                If OPENWIKING_UPDATEDB = 0 then exit sub
                On Error Resume Next
                vQuery="SELECT wrv_summary FROM openwiki_revisions"
                vRS.Open vQuery, vConn, adOpenForwardOnly
                If vConn.Errors.count <> 0 Then
                        If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                                vQuery="ALTER TABLE openwiki_revisions ADD COLUMN wrv_summary varchar(255) NULL"
                        else
                                vQuery="ALTER TABLE openwiki_revisions ADD [wrv_summary] [varchar](255) NULL"
                        end if
                        BeginTrans(vConn)
                        vConn.Execute(vQuery)
                        If vConn.Errors.count <> 0 Then RESPONSE.WRITE(vQuery & " caused a probelm")
                        vQuery "UPDATE openwiki_revisions SET wrv_summary=''"
                        vConn.Execute(vQuery)
                        CommitTrans(vConn)
                End if
                vRs.Close
        End Sub
        Sub TestForCategoriesTable
                If OPENWIKING_UPDATEDB = 0 then exit sub
                On Error Resume Next
                vQuery="SELECT wpg_FCategories FROM openwiki_pages"
                vRS.Open vQuery, vConn, adOpenForwardOnly
                If vConn.Errors.count <> 0 Then
                        BeginTrans(vConn)
'	// DEFAULT(0) value removed from SQL
'	// Gordon Bamber 20051202
						If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                                vQuery="ALTER TABLE openwiki_pages ADD COLUMN wpg_FCategories number NOT NULL"
                        else
                                vQuery="ALTER TABLE openwiki_pages ADD [wpg_FCategories] [int] NOT NULL"
                        end if
                        vConn.Execute(vQuery)
                        If vConn.Errors.count <> 0 Then RESPONSE.WRITE(vQuery & " caused a probelm")
                        vQuery "UPDATE openwiki_pages SET wpg_FCategories=0"
                        vConn.Execute(vQuery)
                        CommitTrans(vConn)
                End if
                vRs.Close
        End Sub
        Sub TestForPageHitsTable
                If OPENWIKING_UPDATEDB = 0 then exit sub
                On Error Resume Next
                vQuery="SELECT wpg_Hits FROM openwiki_pages"
                vRS.Open vQuery, vConn, adOpenForwardOnly
                If vConn.Errors.count <> 0 Then
                        BeginTrans(vConn)
                        If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                                vQuery="ALTER TABLE openwiki_pages ADD COLUMN wpg_Hits number NOT NULL"
                        else
                                vQuery="ALTER TABLE openwiki_pages ADD [wpg_Hits] [bigint] NOT NULL"
                        end if
                        vConn.Execute(vQuery)
                        If vConn.Errors.count <> 0 Then RESPONSE.WRITE(vQuery & " caused a probelm")
                        vQuery "UPDATE openwiki_pages SET wpg_Hits=0"
                        vConn.Execute(vQuery)
                        CommitTrans(vConn)
                End if
                vRs.Close
        End Sub

    Function GetPage(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
        Dim vPage, vChange
'        // START TESTS FOR openWiking database
        If cUseTags=1 then Call TestForTagTable '=====added by 1mmm
        If cUseSummary then Call TestForSummaryTable
        If cUseCategories then Call TestForCategoriesTable
        If plugins.Item("Page Hits") = 1 Then Call TestForPageHitsTable
        If plugins.Item("Site Referers") = "1" Then Call TestForReferrersTable
        If (plugins.Item("Bad Link List") = 1) Then Call TestForBadLinkListTable
        If plugins.Item("Macro Help") = 1 Then Call TestForMacroHelpTable
'        // END TESTS FOR openWiking database

'                // Allow for no UserPreferences or RecentChanges pages in the DB
                If ( (pPageName=OPENWIKI_UPNAME) _
                 OR (pPageName=OPENWIKI_RCNAME) _
                 OR (pPageName=OPENWIKI_FRONTPAGE) _
                 OR (pPageName=OPENWIKI_TINAME) _
                 OR (pPageName=OPENWIKI_HELPNAME) _
                 OR (pPageName=OPENWIKI_CINAME) _
                 OR (pPageName=OPENWIKI_FINDNAME) _
                 OR (pPageName=OPENWIKI_RPNAME) _
                 OR (pPageName=OPENWIKI_ERRORPAGENAME) _
                 OR (pPageName=OPENWIKI_EDITERRORPAGE) _
                 OR (pPageName=OPENWIKI_VIEWERRORPAGE) _
                 OR (pPageName=OPENWIKI_IMAGEUPLOADPAGE) _
                 OR (pPageName="HelpOnEmoticons") _
                 OR (pPageName=OPENWIKI_CAPTCHA_ERRORPAGE) _
                 OR (pPageName=OPENWIKI_SUCCESSPAGENAME) ) then
                        If NOT PageExists(pPageName) then
                                Dim s
                                s = "<comment>Auto-Generated Page.  Please save any altered version you make.</comment>" & VBCR
                                Set GetPage = New WikiPage
                                GetPage.Name = pPageName
				GetPage.Changes   = 1
				GetPage.LastMinor = 0
				GetPage.LastMajor = 0
                    GetPage.AddChange.Revision  = 1
                    GetPage.AddChange.Status    = 2
                    GetPage.AddChange.MinorEdit = 0
                    GetPage.AddChange.Timestamp = Now()
                    GetPage.AddChange.By        = OPENWIKI_APPNAME
                    GetPage.AddChange.ByAlias   = OPENWIKI_APPNAME
                    GetPage.AddChange.Comment   = "Auto-Generated Page"
                                GetPage.AddChange

                                Select Case pPageName
                                        Case OPENWIKI_FRONTPAGE
                                                s = s & "== Welcome to <nowiki>" & OPENWIKI_APPNAME & "</nowiki> build " & OPENWIKI_BUILD & " ==" & VBCR
                                                s = s & "----" & VBCR
                                                s = s & "{R}**This page has been automatically generated, as it does not yet exist yet in the database.**{/R}" & VBCR & VBCR
                                                s = s & "<br>{R}**You should now click the 'edit' link, delete this message, and then save the edited page.**{/R}" & VBCR
'                                                		s = s & "<br><br>//- [http://www.openwiking.com/forum/ The <nowiki>openWikiNG</nowiki> development team]//" & VBCR
                                                s = s & "<br><br><showlinks>"
						GetPage.Text = s
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_FRONTPAGE & " is a system page."
                                        Case OPENWIKI_UPNAME
                                                If (plugins.Item("Check for User Name") = 1) then
                                                        s = s & "**You must have a valid User Name before you can edit any pages in this Wiki**" & VBCR
                                                End If
                                                s = s & "sharedimage:userpreferences.gif <UserPreferences>"
                                                GetPage.Text = s
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_UPNAME & " is a system page."
                                        Case OPENWIKI_RCNAME
                                                GetPage.Text = s & "<RecentChangesLong>"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_RCNAME & " is a system page."
                                        Case OPENWIKI_FINDNAME
                                                s = s & "sharedimage:findpage.gif <TitleSearch>" & VBCR
                                                s = s & "<FullSearch>" & VBCR
                                                s = s & "<TextSearch>" & VBCR
                                                If cUseCategories = 1 then
                                                        s = s & "<CategorySearch>" & VBCR
                                                End If
                                                If cUseSummary = 1 then
                                                        s = s & "<SummarySearch>" & VBCR
                                                End If
                                                GetPage.Text = s
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_FINDNAME & " is a system page."
                                        Case OPENWIKI_CINAME
                                                GetPage.Text = s & "<CategoryIndex>"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_CINAME & " is a system page."
                                        Case OPENWIKI_TINAME
                                                GetPage.Text = s & "<TitleIndex>"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_TINAME & " is a system page."
                                        Case OPENWIKI_HELPNAME
                                                GetPage.Text = s & "<Include(HelpMenu,1)/><ShowLinks>"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_HELPNAME & " is a system page."
                                        Case OPENWIKI_RPNAME
                                                GetPage.Text = s & "<RandomPage(10)>"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_RPNAME & " is a system page."
                                        Case "HelpOnEmoticons"
                                                GetPage.Text = s & "<ListEmoticons>"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary=OPENWIKI_RPNAME & " is a system page."
										Case OPENWIKI_SUCCESSPAGENAME
                                                GetPage.Text = "== Success == **" & gSuccessPageText & "**"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary="This is an autogenerated Page.  Do not save it to disk"
                                        Case OPENWIKI_ERRORPAGENAME
                                                GetPage.Text = "=== Error === " & gErrorPageText
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary="This is an autogenerated Page.  Do not save it to disk"
                                        Case OPENWIKI_EDITERRORPAGE
                                                GetPage.Text = "=== Error === ====  Reason: You are not allowed to edit this page ===="
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary="This is an autogenerated Page.  Do not save it to disk"
                                        Case OPENWIKI_VIEWERRORPAGE
                                                GetPage.Text = "=== Error === ====  Reason: You are not allowed to view this page ===="
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary="This is an autogenerated Page.  Do not save it to disk"
                                        Case OPENWIKI_IMAGEUPLOADPAGE
						If cAllowImageLibrary = 1 then
							GetPage.Text = s & "== Image Upload Page ==" & vbCR &_
							"<br>To display a shared image, use {{{sharedimage:imagefile.ext}}}" & vbCR &_
							"<br>Upload method is: <systeminfo(uploadmethod)> on this Wiki" & vbCR &_
							"----" & vbCR &_
							"<UploadImage>"
							GetPage.Category="9"
							GetPage.AddChange.Summary="This is an autogenerated Page.  Do not save it to disk"
						Else
							GetPage.Text = s & "== Image Upload Page ==" & vbCR &_
							"{R}**Sorry, the uploading of shared images has been disallowed on this Wiki.**{/R}" & vbCR &_
							"<br><br>(<nowiki>cAllowImageLibrary = 0</nowiki>)"
							GetPage.Category="9"
							GetPage.AddChange.Summary="This is an autogenerated Page.  Do not save it to disk"
						End If
					Case OPENWIKI_CAPTCHA_ERRORPAGE
                                                GetPage.Text = s & "=== CAPTCHA error page ===" & vbCR &_
						"==== Your have failed the [http://www.captcha.net CAPTCHA] test! ===="  & vbCR &_
						"For one of the reasons below:"  & vbCR & vbCR &_
						"<br/>either a. You did not fill in the number correctly" & vbCR &_
						"<br/>or     b. You are an evil <nowiki>WIKISpamBot</nowiki>" & vbCR &_
						"<br/>or     c. There was an error that was not your fault"
                                                GetPage.Category="9"
                                                GetPage.AddChange.Summary="This is an autogenerated Page.  Do not save it to disk"
				End Select
                                Exit Function
                        End If
                End If

                If pPageName="CreditsPage" then
                Dim c
                        Set GetPage = New WikiPage
                        GetPage.AddChange
                        GetPage.Name = pPageName
                        c = "#ALLOWEDIT=Local_IP" & VBCR
                        c = c & "== The Development Team ==" & VBCR
                        c = c & " http://www.openwiking.com/images/DevTeam.jpg" & VBCR
		c = c & " ==== The ~OpenWikiNG core team ====" & VBCR
		c = c & " //(in alphabetic order)//<br/><br/>" & VBCR

		c = c & "   * **Carl** a.k.a. @~CarlTheWebmaster<br/>" & VBCR
		c = c & "   //Attachments man.//<br/>" & VBCR
		c = c & "   : sorted out COM-less attachment code and more<br/><br/>" & VBCR

		c = c & "   * **Gordon**<br>" & VBCR
		c = c & "   //Macro man. Enthusiast and ASP programmer.//<br/>" & VBCR
		c = c & "   : who resurrected and helped to organise the current project<br/><br/>" & VBCR

		c = c & "   * **Jack** a.k.a. @Oddible<br/>" & VBCR
		c = c & "   //Erstwhile OW anti-spammer become Skin Specialist//<br/>" & VBCR
		c = c & "   : invented the new table syntax, and custom skinning<br/><br/>" & VBCR

		c = c & "   * **Jeroen** a.k.a. @jroeterd<br>" & VBCR
		c = c & "   //Usibility tester//<br/>" & VBCR
		c = c & "   : keeps finding bugs! Hosts one of the testing servers<br/><br/>" & VBCR

		c = c & "   * **Jose** a.k.a. @piiXiieeS<br/>" & VBCR
		c = c & "   //CMS man//<br/>" & VBCR
		c = c & "   : trying to extend the OWNG functionality with features like discussion area and integrating new macros and skin improvements<br/><br/>" & VBCR

		c = c & "   * **Mike**<br>" & VBCR
		c = c & "   //Documentation//<br/>" & VBCR
		c = c & "   : very extensive work with the helppages<br/><br/>" & VBCR

		c = c & "   * **Paul** a.k.a. @prob<br/>" & VBCR
		c = c & "   //Head of our Legal Team//<br/>" & VBCR
		c = c & "   : who started the openwiki-ng SourceForge site, and has never given up! WYSIWYG editor specialist<br/><br/>"

		c = c & "   * **sEi**<br/>" & VBCR
		c = c & "   //AD, QA, Ideas factory, Advanced Flash implementations...//<br/>" & VBCR
		c = c & "   : in general trying to do IT nice.<br/><br/>" & VBCR

		c = c & "   * **Stephan** a.k.a. @vagabond<br/>" & VBCR
		c = c & "   //Oracle specialist//<br/>" & VBCR
		c = c & "   : database designer and overall Oracle guru<br/><br/>"

		c = c & "   * **@johan, @~BringerOD,@kaplanmyrth,@Jake**<br/>" & VBCR
		c = c & "   //Suggestions, help, questions, marketing//<br/>" & VBCR
		c = c & "   : keeps the team on its toes<br/><br/>" & VBCR

		c = c & " ----" & VBCR
		c = c & " ===== The following have not been part of the ~OpenWikiNG project team but have published code on openwiki.com that has been used in either original or modified form in the ~OpenWikiNG codebase.  We extend our thanks. =====" & VBCR

		c = c & " //(in no particular order)//<br><br>" & VBCR

		c = c & "   * **Per Nilsson**<br/>" & VBCR
		c = c & "     * Progress Bar macro code<br/>" & VBCR
		c = c & "     * Synonym Links code<br/><br/>" & VBCR

		c = c & "   * **Daniel Flippance**<br/>" & VBCR
		c = c & "     * Navigate up a Sub Page code<br/>" & VBCR
		c = c & "    * Pretty Wiki Links code<br/><br/>" & VBCR

		c = c & "   * **Ng Ming Hong**<br/>" & VBCR
		c = c & "     * Paragraph Alignment code<br/>" & VBCR
		c = c & "     * Font size code<br/>" & VBCR
		c = c & "     * Acronym and Abbr tags code<br/>" & VBCR
		c = c & "     * Content Type Negotiation code<br/><br/>" & VBCR

		c = c & "   * **Todd Burzynski**<br/>" & VBCR
		c = c & "     * Page rename code<br/><br/>" & VBCR

		c = c & "   * **Bentoit Pruneau**<br/>" & VBCR
		c = c & "     * Wiki names with single quotes code<br/><br/>" & VBCR

		c = c & "   * **Mike Trinder**<br/>" & VBCR
		c = c & "     * CreatePage macro code<br/><br/>" & VBCR

		c = c & "   * **Ijonas Kisselbach**<br/>" & VBCR
		c = c & "     * Tab key in edit box code<br/><br/>" & VBCR

		c = c & "   * **Dan Rawsthorne**<br/>" & VBCR
		c = c & "     * Comment tag code<br/><br/>" & VBCR

		c = c & "   * **Poptones**<br/>" & VBCR
		c = c & "     * Local image code<br/><br/>" & VBCR

		c = c & "   * **Leopold Faschalek, Dave Cantrell**<br/>" & VBCR
		c = c & "     * Local file listing macro code<br/><br/>" & VBCR

		c = c & "   * **Lewis Moten, Stephane Lussier**<br/>" & VBCR
		c = c & "     * Core file attachment code<br/>" & VBCR

		c = c & " "
                        GetPage.Text = c
                        GetPage.Category="2"
                        GetPage.AddChange.Summary="No need to save or alter this page."
                        Exit Function
                End If

'=====added by 1mmm
                If cUseTags=1 and pPageName=OPENWIKI_TagsName then
					Set GetPage = New WikiPage
					GetPage.AddChange
					GetPage.Name = pPageName
					GetPage.Text = "<TagsIndex>"
					GetPage.Category="9"
					GetPage.AddChange.Summary=OPENWIKI_TagsName & " is a system page."
					Exit Function
				end if
'=======end by 1mmm





        If cWikiLinks = 0 Then
            Set GetPage = New WikiPage
            GetPage.AddChange
            GetPage.Name = OPENWIKI_FRONTPAGE
            GetPage.Text = "Please provide a value for {{{OPENWIKI_DB}}} in your owconfig.asp file."
            Exit Function
        End If
        Set vPage = GetCachedPage(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords)
        If TypeName(vPage) = TypeName(Nothing) then
            ' Response.Write("LOAD PAGE: " & pPageName & "<br />")
            Set vPage = new WikiPage
            If pIncludeText Then
                vQuery = "SELECT * "
            Else
                vQuery=GetPageQuery()'        PLUGIN
            End If
            vQuery = vQuery & " FROM openwiki_pages, openwiki_revisions WHERE wpg_name = '" & Replace(pPageName, "'", "''") & "' AND wrv_name = wpg_name"
            If pRevision > 0 Then
                vQuery = vQuery & " AND wrv_revision = " & pRevision
            Elseif pIncludeAllChangeRecords Then
                vQuery = vQuery & " ORDER BY wrv_revision DESC"
            Else
                vQuery = vQuery & " AND wrv_current = 1"
            End If

            On Error Resume Next
            vRS.Open vQuery, vConn, adOpenForwardOnly
            If Err.Number <> 0 Then
                If Err.Number = -2147467259 Then
                    Response.Write("<h2>Error:</h2>")
                    Response.Write("Cannot find the data sources or the data sources are locked by another application.")
                    Response.Write("Make sure you've set the constant <code><b>OPENWIKI_DB</b></code> correctly in your config file, pointing it to your data sources.<br /><br /><br />")
                Else
                    Response.Write(Err.Number & "<br />" & Err.Description)
                End If
                Response.End
            End If
            On Error Goto 0
'           pPageName = UCase(Left(pPageName,1)) & Right(pPageName,Len(pPageName)-1)

            If vRS.EOF Then
                If pRevision = 0 Then
                    vPage.Name = pPageName
                    vPage.AddChange
                Else
                    ' TODO: addMessage("Revision " & pRevision & " not available (showing current version instead)"
                    vRS.Close
                    Set GetPage = GetPage(pPageName, 0, pIncludeText, pIncludeAllChangeRecords)
                    Exit Function
                End If
            Else
'                If cTitleIndexIgnoreCase then
'                        vPage.Name = UCase(Left(vRS("wpg_name"),1)) & Right(vRS("wpg_name"),Len(vRS("wpg_name"))-1)
'                else
                        vPage.Name      = vRS("wpg_name")
'                End If

                vPage.Changes   = CInt(vRS("wpg_changes"))
                vPage.LastMinor = CInt(vRS("wpg_lastminor"))
                vPage.LastMajor = CInt(vRS("wpg_lastmajor"))
                On Error Resume Next
                if cUseCategories then
                                        If ISNull(vRS("wpg_FCategories")) then
                                                if vConn.Errors.Count <> 0 then
                                                        ResetCookies
                                                        Exit Function
                                                End If
                                                vPage.Category = "0"
                                        else
                                                vPage.Category = CStr(vRS("wpg_FCategories"))
                                        End If
                                Else
                                        vPage.Category = "0"
                                End If
                DoDBHits vPage,vRS'  PLUGIN
                If pIncludeText Then
                    vPage.Text = vRS("wrv_text")
                End If
                If CInt(vRS("wpg_lastminor")) = CInt(vRS("wrv_revision")) Then
                    ' wrv_current = 1
                    ' vPage.Revision = vRS("wrv_revision") ??? ---> No! Because of the xsl script.
                    vPage.Revision = 0
                Elseif pRevision > 0 Then
                    vPage.Revision = pRevision
                End If
                Do While Not vRS.EOF
                    Set vChange = vPage.AddChange
                    vChange.Revision  = CInt(vRS("wrv_revision"))
                    vChange.Status    = CInt(vRS("wrv_status"))
                    vChange.MinorEdit = CInt(vRS("wrv_minoredit"))
                    vChange.Timestamp = vRS("wrv_timestamp")
                    vChange.By        = vRS("wrv_by")
                    vChange.ByAlias   = vRS("wrv_byalias")
                                        vChange.Summary   = "" & vRS("wrv_summary")
                    vChange.Comment   = vRS("wrv_comment")

					if cUseTags = 1 then vChange.Tag = vRS("wrv_tag") '========added by 1mmm'

                    vRS.MoveNext
                Loop
            End If
            vRS.Close

            ' TODO: move this out of this method
            ' If this is the RecentChanges page, then force the presence of the
            ' <RecentChanges> element in the page.
            ' ditto with the UserPreferences Page
            If vPage.Name = OPENWIKI_RCNAME Then
                'vPage.Text = s(vPage.Text, "\<RecentChanges\>", "<RecentChangesLong>", True, True)
                If Not m(vPage.Text, "\<RecentChangesLong\>", True, True) Then
                    vPage.Text = vPage.Text & "<RecentChangesLong>"
                End If
            End If
            If vPage.Name = OPENWIKI_UPNAME Then
                If Not m(vPage.Text, "\<UserPreferences\>", True, True) Then
                    vPage.Text = vPage.Text & "<UserPreferences>"
                End If
            End If

            Call SetCachedPage(pPageName, pRevision, pIncludeText, pIncludeAllChangeRecords, vPage)
        End If

        Set GetPage = vPage
    End Function
'        // START HITS CODE

    Sub IncrementPageHits(vPage)
        DoIncrementPageHits vPage,vConn'        PLUGIN
    End Sub

    Public Function GetMaxCategory()
    Dim Result,szSQL
        Result=0
        szSQL = "SELECT MAX(wpg_FCategories) AS MaxCategory FROM openwiki_pages"
        vRS.Open szSQL, vConn, adOpenForwardOnly
                If NOT vRS.EOF then
                        If NOT ISNull(vRS.Fields("MaxCategory")) then
                                Result=CInt(vRS.Fields("MaxCategory"))
                        End If
                End If
                vRS.Close
                GetMaxCategory=Result
        End Function

    Function GetMostPopularPage()
        dim theName,theHits
        vQuery = "SELECT wpg_name,wpg_Hits FROM openwiki_pages"
        vQuery = vQuery & " WHERE wpg_Hits = (SELECT MAX(wpg_Hits) FROM openwiki_pages)"
        oRS.Open vQuery, oConn, adOpenForwardOnly
        theName=oRS.Fields("wpg_name")
        theHits=CLng(oRS.Fields("wpg_Hits"))
        oRS.Close
        theName=MultiLineMarkup(theName)
        GetMostPopularPage = theName & " : " & theHits & " hits"
    End Function

    Function ResetPageHits(pPageName)
        vQuery = "UPDATE openwiki_pages SET wpg_Hits=0"
        vQuery = vQuery & " WHERE wpg_name = '" & Replace(pPageName, "'", "''") & "'"
        vConn.Execute(vQuery)
        if vConn.Errors.Count=0 then
                        ResetPageHits = "<ow:error>Success!</ow:error> Pagehits for " & pPageName & " set to 0."
                else
                        ResetPageHits = "<ow:error>There has been an error.  Cannot reset Page Hits for " & pPageName & "</ow:error>"
                end if
    End Function

    Function GetPageHits(pPageName)
        vQuery = "SELECT wpg_Hits FROM openwiki_pages"
        vQuery = vQuery & " WHERE wpg_name = '" & Replace(pPageName, "'", "''") & "'"

        vRS.Open vQuery, vConn, adOpenForwardOnly
        GetPageHits = CLng(vRS(0))
        vRS.Close
    End Function

    Function ResetAllPageHits()
        vQuery = "UPDATE openwiki_pages SET wpg_Hits=0"
        vConn.Execute(vQuery)
        if vConn.Errors.Count=0 then
                        ResetAllPageHits = "<ow:error>Success!</ow:error> ALL Pagehits set to 0."
                else
                        ResetAllPageHits = "<ow:error>There has been an error.  Cannot reset all Page Hits</ow:error>"
                end if
    End Function

    Function GetAllPageHits()
                On Error Resume Next
        vQuery = "SELECT SUM(wpg_Hits) FROM openwiki_pages"
        oRS.Open vQuery, oConn, adOpenForwardOnly
        GetAllPageHits = CLng(oRS(0))
        oRS.Close
    End Function
'        // END HITS CODE

    Function GetPageCount()
        vQuery = "SELECT COUNT(*) FROM openwiki_pages"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        GetPageCount = CInt(vRS(0))
        vRS.Close
    End Function

    Function GetRevisionsCount()
        vQuery = "SELECT COUNT(*) FROM openwiki_revisions"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        GetRevisionsCount = CInt(vRS(0))
        vRS.Close
    End Function

	Function UpgradeFreeLinks
'	// Code:Gordon Bamber 20051213
'	// This is called from owactions.asp:ActionUpgradeFreelinks
		Dim tPage,tNewPage
		UpgradeFreeLinks=False ' // Default=Failure
		gSuccessPageText=""
		' // Fetch all the page names from the tables
		' // including revisions and attachments
		' // The JOINS collect null entries
		If (OPENWIKI_DB_SYNTAX = DB_ACCESS) Then
		' // T-SQL for MSAccess
			vQuery = "SELECT openwiki_pages.wpg_name, openwiki_revisions.wrv_name, openwiki_attachments.att_wrv_name, openwiki_attachments_log.ath_wrv_name"
			vQuery = vQuery  & " FROM ((openwiki_pages LEFT JOIN openwiki_attachments_log ON openwiki_pages.wpg_name = openwiki_attachments_log.ath_wrv_name) LEFT JOIN openwiki_revisions ON openwiki_pages.wpg_name = openwiki_revisions.wrv_name) LEFT JOIN openwiki_attachments ON openwiki_pages.wpg_name = openwiki_attachments.att_wrv_name"
		ElseIf (OPENWIKI_DB_SYNTAX = DB_SQLSERVER) Then
		' // T-SQL for SQL Server
			vQuery = "SELECT wpg_name,wrv_name,att_wrv_name,ath_wrv_name"
			vQuery = vQuery  & " FROM openwiki_pages"
	        vQuery = vQuery  & " LEFT OUTER JOIN openwiki_revisions ON wpg_name=wrv_name"
			vQuery = vQuery  & " LEFT OUTER JOIN openwiki_attachments ON wpg_name=att_wrv_name"
			vQuery = vQuery  & " LEFT OUTER JOIN openwiki_attachments_log ON wpg_name=ath_wrv_name"
		Else ' // No query constructed for any other DB yet
			Exit Function
		End If
		vRS.Open vQuery, vConn, adOpenKeyset, adLockOptimistic, adCmdText
		BeginTrans(vConn)
		' Loop through every page name and subpages, and test for CamelCase
		Do While NOT vRS.EOF
			tPage=Trim(vRS("wpg_name"))
			' // ContainsFreeLinks is in owwikify.asp
			if ContainsFreeLinks(tPage) then
				tNewPage=ChangeFreeLink(tPage) ' // Add the string 'Page' to all FreeLink pagenames
				' // Correct apostrophes in name for TSQL
				tPage=replace(tPage,"'","''")
				tNewPage=replace(tNewPage,"'","''")
				gSuccessPageText=gSuccessPageText & "<br/>Replaced page:" & tPage & " with: " & tNewPage
				' Write the corrected page name to the db tables
				vConn.Execute("UPDATE openwiki_pages SET wpg_name='" & tNewPage & "' WHERE wpg_name='" & tPage & "'")
				If NOT IsNull(vRS("wrv_name")) then
					vConn.Execute("UPDATE openwiki_revisions SET wrv_name='" & tNewPage & "' WHERE wrv_name='" & tPage & "'")
				End If
				If NOT IsNull(vRS("att_wrv_name")) then
					vConn.Execute("UPDATE openwiki_attachments SET att_wrv_name='" & tNewPage & "' WHERE att_wrv_name='" & tPage & "'")
				End If
				If NOT IsNull(vRS("ath_wrv_name")) then
					vConn.Execute("UPDATE openwiki_attachments_log SET ath_wrv_name='" & tNewPage & "' WHERE ath_wrv_name='" & tPage & "'")
				End If
			End If
			vRS.MoveNext
        Loop
		vRS.Close
		CommitTrans(vConn)
		UpgradeFreeLinks=True
		If gSuccessPageText="" then gSuccessPageText="==== There were no Free Link pages to update ===="
	End Function

	Function ChangeFreeLink(pPagename)
	'	// Changes the pPagename if it, or a subpage part is not in CamelCase form
	' Note: pPageName has already failed the owwikify.asp:ContainsFreeLinks test once
	Dim vPageName,vTempArray,ct,NumSubPages
		ChangeFreeLink=pPagename '	// Default
		If pPagename="" then Exit Function ' // Shouldn't be needed!
		vPageName=Replace(pPageName,"%2F","/") ' // Normalise
		vTempArray=split(vPagename & "/","/") ' // Put all the subpages into an array
		NumSubPages=UBound(vTempArray)-1 ' // Store the top element number of the array
		If NumSubPages > 0 then ' // This page name is a subpage
			For ct=0 to NumSubPages
				' // Deal with subpage names that start LowerCase
				If Len(vTempArray(ct)) > 1 then
					vTempArray(ct)=UCase(Left(vTempArray(ct),1)) & Mid(vTempArray(ct),2)
				Else
					vTempArray(ct)=UCase(vTempArray(ct))
				End If
				' // Test for correct CamelCase
				if m(vTempArray(ct),gStrictLinkPattern,False,False)=False then
					' // Test fail!
					' // Deal with lowercase single letters (a)
					If Len(vTempArray(ct))=1 then vTempArray(ct)=Left(vTempArray(ct),1) & "_Page"
					If m(vTempArray(ct),"^[A-Z]+[A-Z]",False,False) then
						' // Deal with 2 uppercase (APage)
						vTempArray(ct)=Left(vTempArray(ct),1) & "_" & Mid(vTempArray(ct),2)
					else
						' // Deal with true freelinks (Anypage)
						vTempArray(ct)=vTempArray(ct) & "Page"
					end if
				end if
			Next
			' Make up the complete page name from the corrected array of subpagenames
			vPagename=Join(vTempArray,"/")
			' // Cut out the final slash
			vPagename=Left(vPagename,Len(vPagename)-1)
			ChangeFreeLink=vPagename '	// Subpage: All done!
		Else ' // This is a root page name which is a free link
			' // Deal with root names that start LowerCase
			If Len(vPageName) > 1 then
				vPageName=UCase(Left(vPageName,1)) & Mid(vPageName,2)
			Else
				vPageName=UCase(vPageName)
			End If
			' // Test for correct CamelCase again
			if m(vPageName,gStrictLinkPattern,False,False)=False then
					' // Test fail!
					' // Deal with lowercase single letters (a)
				If Len(vPageName)=1 then vPageName=Left(vPageName,1) & "_Page"
				If m(vPageName,"^[A-Z]+[A-Z]",False,False) then
						' // Deal with 2 uppercase (APage)
					vPageName=Left(vPageName,1) & "_" & Mid(vPageName,2)
				else
						' // Deal with true freelinks (Anypage)
					vPageName=vPageName & "Page"
				end if
			end if
			ChangeFreeLink=vPageName ' // RootPage: All Done!
		End if
	End Function


	Function ToXML(pXmlStr)
        Dim ct
        ToXML = "<ow:wiki version='" & OPENWIKI_XMLVERSION & "' xmlns:ow='" & OPENWIKI_NAMESPACE & "' encoding='" & OPENWIKI_ENCODING & "' mode='" & gAction & "'>" _
              & "<ow:useragent>" & PCDATAEncode(Request.ServerVariables("HTTP_USER_AGENT")) & "</ow:useragent>" _
              & "<ow:build>" & PCDATAEncode(OPENWIKI_BUILD) & "</ow:build>" _
              & "<ow:location>" & PCDATAEncode(gServerRoot) & "</ow:location>" _
              & "<ow:scriptname>" & PCDATAEncode(gScriptName) & "</ow:scriptname>" _
              & "<ow:imagepath>" & PCDATAEncode(OPENWIKI_IMAGEPATH) & "</ow:imagepath>" _
              & "<ow:iconpath>" & PCDATAEncode(OPENWIKI_ICONPATH) & "</ow:iconpath>" _
              & "<ow:skinpath>" & PCDATAEncode(GetSkinDir()) & "</ow:skinpath>" _
              & "<ow:openwiking_url>" & PCDATAEncode(OPENWIKING_URL) & "</ow:openwiking_url>" _
              & "<ow:openwiking_title>" & PCDATAEncode(OPENWIKING_TITLE) & "</ow:openwiking_title>" _
              & "<ow:about>" & PCDATAEncode(gServerRoot & gScriptName & "?" & Request.ServerVariables("QUERY_STRING")) & "</ow:about>" _
              & "<ow:title>" & PCDATAEncode(OPENWIKI_TITLE) & "</ow:title>" _
              & "<ow:frontpage name='" & CDATAEncode(OPENWIKI_FRONTPAGE) & "' href='" & gScriptName & "?" & Server.URLEncode(OPENWIKI_FRONTPAGE) & "'>" & PCDATAEncode(PrettyWikiLink(OPENWIKI_FRONTPAGE)) & "</ow:frontpage>"
              If IsLocalMachine then
                ToXML = ToXML & "<ow:userip>local</ow:userip>"
              else
                ToXML = ToXML & "<ow:userip>remote</ow:userip>"
              end if
              If (FetchUserName()=gWikiAdministrator) then
                ToXML = ToXML & "<ow:usertype>admin</ow:usertype>"
              else
                ToXML = ToXML & "<ow:usertype>user</ow:usertype>"
              end if

'========added by 1mmm
			if cUseTags = 1 then
				if cTagsSplit=1 then ToXML = ToXML & "<ow:tag active=""yes"" split=""blank""/>"
				if cTagsSplit=0 then ToXML = ToXML & "<ow:tag active=""yes"" split="",""/>"
			end if
'========end 1mmm

			  If Application("visitors") then
				ToXML = ToXML & "<ow:online>" & Join(Split(Application("userlist"),"|"),"<br/>") & "</ow:online>"
			  else
				ToXML = ToXML & "<ow:online>0</ow:online>"
			  End If
              ToXML = ToXML & "<ow:summary"
              If cUseSummary then
                                          ToXML = ToXML & " active=""yes""/>"
                          Else
                                          ToXML = ToXML & " active=""no""/>"
                          End If
              ToXML = ToXML & "<ow:categories"
              If cUseCategories then
                                  ToXML = ToXML & " active=""yes"">"
                                  for ct=1 to UBound(gCategoryArray)-1
                                        if Trim(gCategoryArray(ct)) <> "" then
                                                ToXML = ToXML & "<ow:category name=""" & gCategoryArray(ct) & """ />"
                                        End If
                                  next
                                ToXML = ToXML & "</ow:categories>"
                          Else
                                  ToXML = ToXML & " active=""no""/>"
                          End If
              ToXML = ToXML & "<ow:availableskins>"
              ToXML = ToXML & GetSkinNames()
              ToXML = ToXML & "</ow:availableskins>"
        If (cEmbeddedMode = 0) Then
            If cAllowAttachments = 1 Then
                ToXML = ToXML & "<ow:allowattachments/>"
            End If
            If Request.Querystring("redirect") <> "" Then
                ToXML = ToXML & "<ow:redirectedfrom name='" & CDATAEncode(URLDecode(Request("redirect"))) & "'>" & PCDATAEncode(PrettyWikiLink(URLDecode(Request("redirect")))) & "</ow:redirectedfrom>"
            End If
            ToXML = ToXML & getUserPreferences() & GetCookieTrail()
        End If
                '--- Plugin service
                ToXML = ToXML & PlugsToOwXml()
		'--- Collected PageBookmarks
		if len(gPageBookmarks)>0 then
			ToXML = ToXML & "<ow:pagebookmarks>" & gPageBookmarks & "</ow:pagebookmarks>"
		end if
                '---
        ToXML = ToXML & pXmlStr & "</ow:wiki>"
    End Function

    Private Function isValidDocument(pText)
        On Error Resume Next
        Dim vXmlStr, vXmlDoc
        vXmlStr = "<ow:wiki xmlns:ow='x'>" & Wikify(pText) & "</ow:wiki>"
        If MSXML_VERSION = 4 Then
            Set vXmlDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument.4.0")
        Else
            Set vXmlDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument")
        End If
        vXmlDoc.async = False
        If vXmlDoc.loadXML(vXmlStr) Then
            isValidDocument = True
        Else
            isValidDocument = False
            Response.Write("<h1>Error occured</h1>")
            Response.Write("<b>Your input did not validate to well-formed and valid Wiki format.<br />")
            Response.Write("Please go back and correct. The XML output attempt was:</b><br /><br />")
            Response.Write("<pre>" & vbCRLF & Server.HTMLEncode(vXmlStr) & vbCRLF & "</pre>" & vbCRLF)
        End If
    End Function

    Function SavePage(pRevision, pMinorEdit, pComment, pText, pCategory,pSummary, bForceSave)
        Dim vRevision, vStatus, vHost, vUserAgent, vBy, vByAlias, vReplacedTS, vRevsDeleted,vQuery1,vQuery2
        Dim vAttRS 'part of OpenWiki.com bugfix - DaveBrookes

        pText = pText 
        If Not isValidDocument(pText) Then
            SavePage = False
            Response.End
        End If

        vHost = GetRemoteHost()
        vUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
        vBy = GetRemoteUser()
        If vBy = "" Then
            vBy = vHost
        End If
        vByAlias = GetRemoteAlias()

        Dim conn
        Set conn = Server.CreateObject("ADODB.Connection")
        conn.Open OPENWIKI_DB
        BeginTrans(conn)
        vQuery = "SELECT * FROM openwiki_revisions WHERE wrv_name = '" & Replace(gPage, "'", "''") & "' AND wrv_current = 1"
        vRS.Open vQuery, conn, adOpenKeyset, adLockOptimistic, adCmdText
        If vRS.EOF Then
            If Trim(pText) = "" Then
                RollbackTrans(conn)
                conn.Close()
                Set conn = Nothing
                SavePage = True
                Exit Function
            End If
            vRevision  = 1
            vStatus    = 1  ' new
        Elseif (( vRS("wrv_text") = pText) AND (bForcesave=0) ) Then
            RollbackTrans(conn)
            conn.Close()
            Set conn = Nothing
            SavePage = True
            Exit Function
        Else
            If (CInt(vRS("wrv_revision")) <> (pRevision - 1)) Then
                If ((vRS("wrv_by") <> vBy) Or (vRS("wrv_host") <> vHost) Or (vRS("wrv_agent") <> vUserAgent)) Then
                    RollbackTrans(conn)
                    conn.Close()
                    Set conn = Nothing
                    SavePage = False
                    Exit Function
                End If
            End If
            vRevision = CInt(vRS("wrv_revision")) + 1
            If ((vRS("wrv_by") = vBy) And (vRS("wrv_host") = vHost) And (vRS("wrv_agent") = vUserAgent)) Then
                vStatus = CInt(vRS("wrv_status"))
            Else
                vStatus = 2  ' updated
            End If
        End If

        If InStr(pText, "#DEPRECATED") = 1 Then
            vStatus = 3  ' deleted
        Elseif vStatus = 3 Then
            vStatus = 2  ' updated
        End If

        If vRS.EOF Then
                                vQuery1 = "INSERT INTO openwiki_pages (wpg_name, wpg_lastminor, wpg_changes, wpg_lastmajor"
                                vQuery2 = "'" & Replace(gPage, "'", "''") & "'," & vRevision & " ,1 ," & vRevision
                        If cUseCategories then
                                vQuery1 = vQuery1 & ",wpg_FCategories"
                                vQuery2 = vQuery2 & "," & 0 + CInt(pCategory)
                        end if
                        If plugins.Item("Page Hits") = 1 Then
                                vQuery1 = vQuery1 & ",wpg_Hits"
                                vQuery2 = vQuery2 & "," & 0
                        End If
                        vQuery = vQuery1 & ") VALUES (" & vQuery2 & ")"
                        conn.execute(vQuery)

        Else
                        If cUseCategories then
                                vQuery = "UPDATE openwiki_pages " _
                                           & "SET wpg_changes = wpg_changes + 1" _
                                           & ",   wpg_lastminor = " & vRevision _
                                           & ",   wpg_FCategories = " & CInt(pCategory)
                        else
                                vQuery = "UPDATE openwiki_pages " _
                                           & "SET wpg_changes = wpg_changes + 1" _
                                           & ",   wpg_lastminor = " & vRevision
                        end if
            If pMinorEdit = 0 Then
                vQuery = vQuery & ", wpg_lastmajor = " & vRevision
            End If
            vQuery = vQuery & " WHERE wpg_name = '" & Replace(gPage, "'", "''") & "'"
            conn.execute(vQuery)

            vQuery = "UPDATE openwiki_revisions SET wrv_current = 0 WHERE wrv_name = '" & Replace(gPage, "'", "''") & "' AND wrv_current = 1"
            conn.execute(vQuery)
        End If
        vRS.Close

        vRS.Open "openwiki_revisions", conn, adOpenKeyset, adLockOptimistic, adCmdTable
        vRS.AddNew
        vRS("wrv_name")       = gPage
        vRS("wrv_revision")   = vRevision
        vRS("wrv_current")    = 1
        vRS("wrv_status")     = vStatus
        vRS("wrv_timestamp")  = Now()
        vRS("wrv_minoredit")  = pMinorEdit
        vRS("wrv_host")       = vHost
        vRS("wrv_agent")      = vUserAgent
        vRS("wrv_by")         = vBy
        vRS("wrv_byalias")    = vByAlias
        vRS("wrv_comment")    = pComment
        vRS("wrv_text")       = pText
'        If cUseSummary then
        vRS("wrv_summary") = pSummary
'        End If

        if cUseTags = 1 then vRS("wrv_tag") = getpostTag(Request.Form("edtTag")) '========added by 1mmm

        vRS.Update
        vRS.Close

If cAllowAttachments then
'// FROM OPENWIKI.COM - BUGFIX - DaveBrookes
		' BugFix - galleyslave - now updates att_wrv_revision correctly for multiple attachments with different versions
		' update attachments to link to new openwiki_revisions record
		if OPENWIKI_DB_SYNTAX = DB_ACCESS then
			vQuery = "UPDATE DISTINCTROW openwiki_attachments INNER JOIN" & _
				" (SELECT att_wrv_name, att_name, MAX(att_revision) AS LatestRev FROM openwiki_attachments" & _
					" WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND att_deprecated = 0 GROUP BY att_wrv_name, att_name) AS o1" & _
					" ON (openwiki_attachments.att_name = o1.att_name) AND (o1.LatestRev = openwiki_attachments.att_revision) AND (openwiki_attachments.att_wrv_name = o1.att_wrv_name)" & _
				" SET openwiki_attachments.att_wrv_revision = " & vRevision

		Elseif OPENWIKI_DB_SYNTAX = DB_ORACLE then
			vQuery = "UPDATE openwiki_attachments" & _
					" SET att_wrv_revision = " & vRevision & _
					" where exists( select 1 from " & _
					" ( SELECT x.att_wrv_name, x.att_name, MAX( x.att_revision) AS LatestRev FROM openwiki_attachments x " & _
					"   WHERE x.att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND x.att_deprecated = 0 GROUP BY x.att_wrv_name, x.att_name) o1 " & _
					" WHERE o1.att_name = openwiki_attachments.att_name AND openwiki_attachments.att_revision=o1.LatestRev AND openwiki_attachments.att_wrv_name = o1.att_wrv_name )"

		else
			vQuery = "UPDATE openwiki_attachments" & _
					" SET att_wrv_revision = " & vRevision & _
					" FROM openwiki_attachments, (SELECT att_wrv_name, att_name, MAX(att_revision) AS LatestRev FROM openwiki_attachments" & _
					" WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND att_deprecated = 0 GROUP BY att_wrv_name, att_name) AS o1" & _
					" WHERE o1.att_name = openwiki_attachments.att_name AND att_revision=o1.LatestRev AND openwiki_attachments.att_wrv_name = o1.att_wrv_name"
		end if

		conn.execute(vQuery)

		' ChrisG 2005-12-30
		' Add attachment log entry for each openwiki_attachments update
		Dim AttList, AttItem, AttRowCount
		vQuery = "SELECT MAX(att_revision) as max_att_revision, att_name FROM openwiki_attachments WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' GROUP BY att_name"
		vRS.Open vQuery, conn, adOpenKeyset, adLockOptimistic, adCmdText

		If Not vRS.EOF Then
			AttList = vRS.GetRows
			vRS.Close
			AttRowCount = UBound(AttList, 2)
			For AttItem = 0 to AttRowCount
			  Call SaveAttachmentLog(conn, AttList(1, AttItem), AttList(0, AttItem), "wrv_revision")
			next
		Else
			vRS.Close
		End If
End If
Dim tRevNum,tMaxDateToKeep
tMaxDateToKeep = (Now() - OPENWIKI_DAYSTOKEEP)
        ' delete old revisions
        vQuery = "SELECT wrv_revision, wrv_timestamp FROM openwiki_revisions WHERE wrv_name = '" & Replace(gPage, "'", "''") & "' ORDER BY wrv_revision DESC"
        vRS.Open vQuery, conn, adOpenKeyset, adLockOptimistic, adCmdText
        If Not vRS.EOF Then
            ' this is the current revision
            vRS.MoveNext '        // Go to the next oldest revision
            If Not vRS.EOF Then
                vReplacedTS = vRS("wrv_timestamp")
                ' keep at least one old revision
                vRS.MoveNext
                Do While Not vRS.EOF
                    ' check the timestamp of revision that replaced this revision
                    If (vReplacedTS <= tMaxDateToKeep) Then
                                                tRevNum = CInt(vRS("wrv_revision")) '        // Grab the revision number
                                                If (OPENWIKI_DB_SYNTAX = DB_ACCESS) Then
                                                        BeginTrans(conn) '        // Start a new transaction to avoid record-locking (MSAccess only)
                                                End If

'                                                // Deal with old attachment entries and their logs
                                                vQuery = "DELETE FROM openwiki_attachments WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND att_wrv_revision  <= " & tRevNum 
                                                conn.execute(vQuery)
                                                vQuery = "DELETE FROM openwiki_attachments_log WHERE ath_wrv_name = '" & Replace(gPage, "'", "''") & "' AND ath_wrv_revision  <= " & tRevNum 
                                                conn.execute(vQuery)

'                                                // Delete all the old revisions together
                                                vQuery = "DELETE FROM openwiki_revisions" &_
                                                                 " WHERE wrv_name = '" & Replace(gPage, "'", "''") & "' AND wrv_revision <= " & tRevNum &_
                                                                 " AND wrv_revision not in (SELECT att_wrv_revision FROM openwiki_attachments where att_wrv_name = '" & Replace(gPage, "'", "''") & "')"
                                                conn.execute(vQuery)
                                                vRs.Close()
'                                                // Find out how many revisions are left after the deletion
                        vQuery = "SELECT COUNT(*) FROM openwiki_revisions WHERE wrv_name = '" & Replace(gPage, "'", "''") & "'"
                        vRS.Open vQuery, conn, adOpenKeyset, adLockOptimistic, adCmdText
'                                                // Make sure the pages table hold the new correct number of revisions
                        vQuery = "UPDATE openwiki_pages SET wpg_changes = " & CInt(vRS(0)) & " WHERE wpg_name = '" & Replace(gPage, "'", "''") & "'"
                        conn.execute(vQuery)
                                                If (OPENWIKI_DB_SYNTAX = DB_ACCESS) Then
                                                        CommitTrans(conn)'        // End of deletions transaction
                                                End If
                        Exit Do
                    Else
                        vReplacedTS = vRS("wrv_timestamp")
                    End If
                    vRS.MoveNext
                Loop
            End If
        End If
        vRS.Close

        ' throw out the bath and the bathwater. TODO: keep the bath
        ClearDocumentCache(conn)

        CommitTrans(conn)
        conn.Close()

        Set conn = Nothing

        SavePage = True
    End Function


    ' returns the name of the file as you should save it
    ' pStatus : 0 = normal, 1 = hidden, 2 = deprecated
    Function SaveAttachmentMetaData(pFilename, pFilesize, pAddLink, pHidden, pComment)
        Dim vHost, vUserAgent, vBy, vByAlias, vPageRevision, vFileRevision, vFilename, vPos

        pFilename = Replace(pFilename, " ", "_")

        If pHidden = "" Then
            pHidden = 0
        End If

        vHost = GetRemoteHost()
        vUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
        vBy = GetRemoteUser()
        If vBy = "" Then
            vBy = vHost
        End If
        vByAlias = GetRemoteAlias()

        vQuery = "SELECT wpg_lastminor FROM openwiki_pages WHERE wpg_name = '" & Replace(gPage, "'", "''") & "'"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        If vRS.EOF Then
            vPageRevision = 1 ' page doesn't exist yet
        Else
            vPageRevision = CInt(vRS(0))
        End If
        vRS.Close
        vQuery = "SELECT MAX(att_revision) FROM openwiki_attachments WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND att_name = '" & Replace(pFilename, "'", "''") & "'"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        If IsNull(vRS(0)) Then
            vFileRevision = 1
        Else
            vFileRevision = CInt(vRS(0)) + 1
        End If
        vRS.Close

        vPos = InStrRev(pFilename, ".")
        If vPos > 0 Then
            vFilename = Left(pFilename, vPos - 1) & "-" & vFileRevision & Mid(pFilename, vPos)
        Else
            vFilename = pFilename & "-" & vFileRevision
        End If
        vFilename = SafeFileName(vFilename)

        BeginTrans(vConn)
        vRS.Open "openwiki_attachments", vConn, adOpenKeyset, adLockOptimistic, adCmdTable
        vRS.AddNew
        vRS("att_wrv_name")     = gPage
        vRS("att_wrv_revision") = vPageRevision
        vRS("att_name")         = pFilename
        vRS("att_revision")     = vFileRevision
        vRS("att_hidden")       = pHidden
        vRS("att_deprecated")   = 0
        vRS("att_filename")     = vFilename
        vRS("att_timestamp")    = Now()
        vRS("att_filesize")     = pFilesize
        vRS("att_host")         = vHost
        vRS("att_agent")        = vUserAgent
        vRS("att_by")           = vBy
        vRS("att_byalias")      = vByAlias
        vRS("att_comment")      = pComment
        vRS.Update
        vRS.Close

        Call SaveAttachmentLog(vConn, pFilename, vFileRevision, "uploaded")

        Call ClearDocumentCache(vConn)
        'Call ClearDocumentCache2(vConn, gPage)

        If pAddLink <> "" Then
            If OPENWIKI_DB_SYNTAX = DB_MYSQL Then
                vQuery = "UPDATE openwiki_revisions SET wrv_text = CONCAT(wrv_text, '" & vbCRLF & vbCRLF & "  * " & Replace(pFilename, "'", "''") & "') WHERE wrv_name = '" & Replace(gPage, "'", "''") & "' AND wrv_current = 1"
                vConn.execute(vQuery)
            Else
                                'BUGFIX FROM OPENWIKI.COM - http://www.openwiki.com/ow.asp?p=OpenWiki/Bugs
                vQuery = "SELECT wrv_text, wrv_name, wrv_revision FROM openwiki_revisions WHERE wrv_name = '" & Replace(gPage, "'", "''") & "' AND wrv_current = 1"
                vRS.Open vQuery, vConn, adOpenKeyset, adLockOptimistic, adCmdText
                If Not vRS.EOF Then
                    vRS("wrv_text") = vRS("wrv_text") & vbCRLF & vbCRLF & "  * " & pFilename
                    vRS.Update
                End If
                vRS.Close
            End If
        End If

        CommitTrans(vConn)

        SaveAttachmentMetaData = vFilename
    End Function


    Function HideAttachmentMetaData(pName, pRevision, pHide)
        BeginTrans(vConn)
        vConn.Execute "UPDATE openwiki_attachments SET att_hidden = " & pHide & " WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND att_name = '" & Replace(pName, "'", "''") & "' AND att_revision = " & pRevision
        If pHide = 1 Then
            Call SaveAttachmentLog(vConn, pName, pRevision, "hidden")
        Else
            Call SaveAttachmentLog(vConn, pName, pRevision, "made visible")
        End If
        Call ClearDocumentCache(vConn)
        'Call ClearDocumentCache2(vConn, gPage)
        CommitTrans(vConn)
    End Function


    Function TrashAttachmentMetaData(pName, pRevision, pTrash)
        BeginTrans(vConn)
        vConn.Execute "UPDATE openwiki_attachments SET att_deprecated = " & pTrash & " WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND att_name = '" & Replace(pName, "'", "''") & "'"
        If pTrash = 1 Then
            Call SaveAttachmentLog(vConn, pName, pRevision, "deprecated")
        Else
            Call SaveAttachmentLog(vConn, pName, pRevision, "restored")
        End If
        Call ClearDocumentCache(vConn)
        'Call ClearDocumentCache2(vConn, gPage)
        CommitTrans(vConn)
    End Function


    Sub SaveAttachmentLog(pConn, pName, pFileRevision, pAction)
        Dim vHost, vUserAgent, vBy, vByAlias
        Dim pPagename, pPageRevision

        vHost = GetRemoteHost()
        vUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
        vBy = GetRemoteUser()
        If vBy = "" Then
            vBy = vHost
        End If
        vByAlias = GetRemoteAlias()

        vQuery = "SELECT att_wrv_name, att_wrv_revision FROM openwiki_attachments WHERE att_wrv_name = '" & Replace(gPage, "'", "''") & "' AND att_name = '" & Replace(pName, "'", "''") & "' AND att_revision = " & pFileRevision
        vRS.Open vQuery, pConn, adOpenForwardOnly
        If vRS.EOF Then
            vRS.Close
            Exit Sub
        End If
        pPagename = vRS("att_wrv_name")
        pPageRevision = vRS("att_wrv_revision")
        vRS.Close

        vQuery = "SELECT wrv_timestamp FROM openwiki_revisions WHERE wrv_name = '" & Replace(pPagename, "'", "''") & "' AND wrv_revision = " & pPageRevision
        vRS.Open vQuery, pConn, adOpenKeyset, adLockOptimistic, adCmdText
        If vRS.EOF Then
            vRS.Close
            Exit Sub
        End If
        vRS("wrv_timestamp") = Now()
        vRS.Update
        vRS.Close

        vRS.Open "openwiki_attachments_log", pConn, adOpenKeyset, adLockOptimistic, adCmdTable
        vRS.AddNew
        vRS("ath_wrv_name")     = pPagename
        vRS("ath_wrv_revision") = pPageRevision
        vRS("ath_name")         = pName
        vRS("ath_revision")     = pFileRevision
        vRS("ath_timestamp")    = Now()
        vRS("ath_agent")        = vUserAgent
        vRS("ath_by")           = vBy
        vRS("ath_byalias")      = vByAlias
        vRS("ath_action")       = pAction
        vRS.Update
        vRS.Close
    End Sub


    ' Convert the filename to a filename with an extension that is safe
    ' to be served by the webserver.
    Function SafeFileName(pFilename)
        Dim vPos, vExtension
        SafeFileName = pFilename
        vPos = InStrRev(pFilename, ".")
        If vPos > 0 Then
            vExtension = Mid(pFilename, vPos + 1)
            If gNotAcceptedExtensions = "" Then
                ' accept nothing, except the ones enumerated in gDocExtensions
                If Not InStr("|" & gDocExtensions & "|", "|" & vExtension & "|") > 0 Then
                    SafeFileName = SafeFilename & ".safe"
                End If
            Else
                ' accept everything, except the ones enumerated in gNotAcceptedExtensions
                If InStr("|" & gNotAcceptedExtensions & "|", "|" & vExtension & "|") > 0 Then
                    SafeFileName = SafeFilename & ".safe"
                End If
            End If
        End If
    End Function


    Sub GetAttachments(pPage, pRevision, pIncludeAllChangeRecords)
        Dim vAttachment, vMaxRevision
        If pIncludeAllChangeRecords Then
            ' show all file revisions
            vQuery = "SELECT att_name, att_revision, att_hidden, att_deprecated, att_filename, att_timestamp, att_filesize, att_by, att_byalias, att_comment" _
            & " FROM openwiki_attachments" _
            & " WHERE att_wrv_name = '" & Replace(pPage.Name, "'", "''") & "'" _
            & " AND   att_name = '" & Replace(Request("file"), "'", "''") & "'" _
            & " ORDER BY att_revision DESC"
        Else
            ' show last file revision relative to page revision
            vQuery = "SELECT MAX(att_wrv_revision) FROM openwiki_attachments WHERE att_wrv_name = '" & Replace(pPage.Name, "'", "''") & "'"
            If pRevision > 0 Then
                vQuery = vQuery & " AND att_wrv_revision <= " & pRevision
            End If
            vRS.Open vQuery, vConn, adOpenForwardOnly
            If IsNull(vRS(0)) Then
                vMaxRevision = 0
            Else
                vMaxRevision = CInt(vRS(0))
            End If
            vRS.Close
            vQuery = "SELECT att_name, att_revision, att_hidden, att_deprecated, att_filename, att_timestamp, att_filesize, att_by, att_byalias, att_comment" _
            & " FROM openwiki_attachments" _
            & " WHERE att_wrv_name = '" & Replace(pPage.Name, "'", "''") & "'" _
            & " AND   att_wrv_revision <= " & vMaxRevision _
            & " ORDER BY att_name ASC, att_revision DESC"
        End If
        vRS.Open vQuery, vConn, adOpenForwardOnly
        Do While Not vRS.EOF
            Set vAttachment = New Attachment
            vAttachment.Name       = vRS("att_name")
            vAttachment.Revision   = CInt(vRS("att_revision"))
            vAttachment.Hidden     = CInt(vRS("att_hidden"))
            vAttachment.Deprecated = CInt(vRS("att_deprecated"))
            vAttachment.Filename   = vRS("att_filename")
            vAttachment.Timestamp  = vRS("att_timestamp")
            vAttachment.Filesize   = CLng(vRS("att_filesize"))
            vAttachment.By         = vRS("att_by")
            vAttachment.ByAlias    = vRS("att_byalias")
            vAttachment.Comment    = vRS("att_comment")
            Call pPage.AddAttachment(vAttachment, Not pIncludeAllChangeRecords)
            vRS.MoveNext
        Loop
        vRS.Close
        pPage.AttachmentsLoaded = True
    End Sub
        Private Function GoogleisePattern(pPattern)
        Dim sz
                sz=pPattern
                sz=s(sz,"\,\s+"," ",True,True) ' tom, dick = tom dick
                sz=s(sz,"(\s+or\s+)","|",True,True) ' tom or dick = tom|dick
                sz=s(sz,"(\s+and\s+)"," ",True,True) ' tom and dick = tom dick
                GoogleisePattern=sz
        End Function
'        // TitleSearch(SearchFor,0,3,1,0) = Summary Search
'        // TitleSearch("",CategoryNumber,0,3,0) = Category Search
    ' pFilter --> 0=All, 1=NoMinorEdit, 2=OnlyMinorEdit, 3=Summary Search
    ' pOrderBy --> 1=Timestamp(DESC), 2=Timestamp (ASC),3=PageHits, 4=Categories
    ' If pOrderBy=4 then pDays=Category
    Function TitleSearch(pPattern, pDays, pFilter, pOrderBy, pIncludeAttachmentChanges)
        Dim vTitle, vRegEx, vList, vPage, vChange, vCurPage, vAttachmentChange
        pPattern=GoogleisePattern(pPattern)
        Set vList = New Vector
        Set vRegEx = New RegExp
        vRegEx.IgnoreCase = True
        vRegEx.Global = True
        vRegEx.Pattern = EscapePattern(pPattern)
        vQuery = GetPageQuery '        //PLUGIN
        If cAllowAttachments AND pIncludeAttachmentChanges Then
            vQuery = vQuery & ", ath_name, ath_revision, ath_timestamp, ath_by, ath_byalias, ath_action "
            If OPENWIKI_DB_SYNTAX = DB_ORACLE Then
                vQuery = vQuery & " FROM   openwiki_pages, openwiki_revisions, openwiki_attachments_log " _
                                & " WHERE  wpg_name = wrv_name " _
                                & " AND    wrv_name = ath_wrv_name (+) " _
                                & " AND    wrv_revision = ath_wrv_revision (+)"
            Else
                vQuery = vQuery & " FROM (openwiki_pages LEFT JOIN openwiki_revisions ON openwiki_pages.wpg_name = openwiki_revisions.wrv_name) LEFT JOIN openwiki_attachments_log ON (openwiki_revisions.wrv_name = openwiki_attachments_log.ath_wrv_name) AND (openwiki_revisions.wrv_revision = openwiki_attachments_log.ath_wrv_revision) WHERE 1 = 1 "
            End If
        Else
            vQuery = vQuery & "FROM openwiki_pages, openwiki_revisions " _
                            & "WHERE wrv_name = wpg_name "
        End If
        If ((pDays > 0) AND (pOrderBy = 4)) then
                        vQuery = vQuery &  " AND (openwiki_pages.wpg_FCategories = " & CInt(pDays) & ")"
        End If

'        // Deal with any WHERE clauses to further filter the results
        If pFilter = 0 Then
            vQuery = vQuery & " AND wpg_lastminor = wrv_revision"
        Elseif pFilter = 1 Then
            vQuery = vQuery & " AND wpg_lastmajor = wrv_revision"
        Elseif pFilter = 2 Then
            vQuery = vQuery & " AND wpg_lastminor = wrv_revision AND wrv_minoredit = 1"
        Elseif pFilter = 3 Then
'                // 20050215 Gordon Bamber: Fix for duplicate SummarySearch entries
            vQuery = vQuery & " AND wpg_lastminor = wrv_revision"
            vQuery = vQuery & " AND (LEN(wrv_Summary) > 0)"
        End If
'        // Deal with any SORTING of the results

        If pOrderBy = 1 Then
            vQuery = vQuery & " ORDER BY wrv_timestamp DESC"
        Elseif pOrderBy = 2 Then
            vQuery = vQuery & " ORDER BY wrv_timestamp"
'        // START PAGE HITS
        Elseif pOrderBy = 3 Then
                        If (OPENWIKI_DB_SYNTAX=DB_SQLSERVER) then
                                vQuery = vQuery & " ORDER BY openwiki_pages.wpg_hits DESC, openwiki_pages.wpg_name ASC"
                        else
                                vQuery = vQuery & " ORDER BY ROUND(openwiki_pages.wpg_hits) DESC"
                        end if
'        // END PAGE HITS
'        // START CATEGORY
        Elseif (pOrderBy = 4) AND (pDays=0) Then
                        If (OPENWIKI_DB_SYNTAX=DB_SQLSERVER) then
                                vQuery = vQuery & " AND (openwiki_pages.wpg_FCategories > 0) ORDER BY openwiki_pages.wpg_FCategories DESC, openwiki_pages.wpg_name"
                        else
                                vQuery = vQuery & " AND (ROUND(openwiki_pages.wpg_FCategories) > 0) ORDER BY ROUND(openwiki_pages.wpg_FCategories) DESC, openwiki_pages.wpg_name"
                        end if
'        // END CATEGORY
        Else
            vQuery = vQuery & " ORDER BY wpg_name"
        End If
        If cAllowAttachments AND pIncludeAttachmentChanges Then
            vQuery = vQuery & ", ath_timestamp DESC"
        End If
        Dim ct, sWhatToTest

        vRS.Open vQuery, vConn, adOpenForwardOnly
        Do While Not vRS.EOF
            If pFilter=3 then
               sWhatToTest = vRS("wrv_Summary")
            else
               sWhatToTest = vRS("wpg_name")
            End If
            If vRegEx.Test(sWhatToTest) Then
                If (vCurPage <> vRS("wpg_name"))Then
                    vCurPage = vRS("wpg_name")
                    Set vPage = New WikiPage
                    vPage.Name = vRS("wpg_name")

'                // This forces indexed page names to be Uppercase
                If cTitleIndexIgnoreCase then
                        vPage.Name = UCase(Left(vRS("wpg_name"),1)) & Right(vRS("wpg_name"),Len(vRS("wpg_name"))-1)
                else
                        vPage.Name      = vRS("wpg_name")
                End If

                    If cUseCategories then
                                                If NOT IsNull(vRS("wpg_FCategories")) then
                                                                vPage.Category = CInt(vRS("wpg_FCategories"))
                                                else
                                                                vPage.Category = 0
                                                End if
                                        else
                                                vPage.Category = 0
                                        end if
                    vPage.Changes = CInt(vRS("wpg_changes"))
                    Set vChange = vPage.AddChange
                    vChange.Revision  = CInt(vRS("wrv_revision"))
                    vChange.Status    = CInt(vRS("wrv_status"))
                    vChange.MinorEdit = CInt(vRS("wrv_minoredit"))
                    vChange.Timestamp = vRS("wrv_timestamp")
                    vChange.By        = vRS("wrv_by")
                    vChange.ByAlias   = vRS("wrv_byalias")
                    vChange.Comment   = vRS("wrv_comment")
                    If cUseSummary then
                           vChange.Summary   = "" & vRS("wrv_summary")
                    End If
                    DoDBHits vPage,vRS '        // PLUGIN
'DEBUGLINE                    RESPONSE.WRITE(vChange.Summary)
                    vList.Push(vPage)
                End If

                If cAllowAttachments AND pIncludeAttachmentChanges Then
                    If (vRS("ath_name") <> "") And (vRS("ath_timestamp") > DateAdd("h", -24, Now())) Then
                        Set vAttachmentChange = New AttachmentChange
                        vAttachmentChange.Name = vRS("ath_name")
                        vAttachmentChange.Revision = CInt(vRS("ath_revision"))
                        vAttachmentChange.Timestamp = vRS("ath_timestamp")
                        vAttachmentChange.By = vRS("ath_by")
                        vAttachmentChange.ByAlias = vRS("ath_byalias")
                        vAttachmentChange.Action = vRS("ath_action")
                        vChange.AddAttachmentChange(vAttachmentChange)
                    End If
                End If
                ct=ct+1
            End If


            vRS.MoveNext
        Loop
        ' Response.Write("Pages returned = " & ct)
        vRS.Close
        Set vRegEx = Nothing
        Set TitleSearch = vList
    End Function

'======================added by 1mmm
'tag: gNamespace.TagSearch(pPattern,0)

    Function TagSearch(pPattern, pDays)
        Dim vTitle, vRegEx, vList, vPage, vChange, vCurPage, vAttachmentChange
        'pPattern=GoogleisePattern(pPattern)
        Set vList = New Vector
        vQuery = "SELECT wrv_name, wrv_tag FROM openwiki_revisions WHERE wrv_current = 1 AND wrv_tag LIKE '%{" & pPattern & "}%'"
		
		vRS.Open vQuery, vConn, adOpenForwardOnly
        Do While Not vRS.EOF
                    'vCurPage = vRS("wrv_name")

                    Set vPage = New WikiPage
                    vPage.Name = vRS("wrv_name")
					'vPage.Category = 0
                    'vPage.Changes = 1
                    Set vChange = vPage.AddChange
                    vChange.Revision  = 1
                    'vChange.Status    = 2
                    'vChange.MinorEdit = 0
                    vChange.Timestamp = "2006-8-18 18:18:18" 
                    'vChange.By        = "by1mmm"
                    'vChange.ByAlias   = "1mmm"
                    vChange.Tag   = vRS("wrv_tag")
                    vList.Push(vPage)
            vRS.MoveNext
        Loop
        vRS.Close
        Set TagSearch = vList
   End Function
'======================end by 1mmm

    Function FullSearch(pPattern, pIncludeTitles)
        Dim vTitle, vRegEx, vRegEx2, vList, vPage, vChange, vFound
        pPattern = EscapePattern(pPattern)
        Set vList = New Vector
        Set vRegEx = New RegExp
        vRegEx.IgnoreCase = True
        vRegEx.Global = True
        If Request("fromtitle") = "true" Then
            vRegEx.Pattern = Replace(pPattern, "_", " ")
        Else
            vRegEx.Pattern = pPattern
        End If
        If pIncludeTitles Then
            Set vRegEx2 = New RegExp
            vRegEx2.IgnoreCase = True
            vRegEx2.Global = True
            vRegEx2.Pattern = pPattern
        End If
        vQuery = "SELECT * FROM openwiki_pages, openwiki_revisions WHERE wrv_name = wpg_name AND wrv_current = 1 AND wrv_text IS NOT NULL ORDER BY wpg_name"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        Do While Not vRS.EOF
            vFound = False
            If pIncludeTitles Then
                If vRegEx2.Test(vRS("wpg_name")) Then
                    vFound = True
                End If
            End If
            If Not vFound Then
                If vRegEx.Test(vRS("wrv_text")) Then
                    vFound = True
                End If
            End If
            If vFound Then
                Set vPage = New WikiPage
                vPage.Name = vRS("wpg_name")
                vPage.Changes = CInt(vRS("wpg_changes"))
                Set vChange = vPage.AddChange
                vChange.Revision  = CInt(vRS("wrv_revision"))
                vChange.Status    = CInt(vRS("wrv_status"))
                vChange.MinorEdit = CInt(vRS("wrv_minoredit"))
                vChange.Timestamp = vRS("wrv_timestamp")
                vChange.By        = vRS("wrv_by")
                vChange.ByAlias   = vRS("wrv_byalias")
                vChange.Comment   = vRS("wrv_comment")
                                If cUseSummary then
                                        vChange.Summary   = "" & vRS("wrv_summary")
                                End If
                vList.Push(vPage)
            End If
            vRS.MoveNext
        Loop
        vRS.Close
        Set vRegEx = Nothing
        Set vRegEx2 = Nothing
        Set FullSearch = vList
    End Function

    ' An extension of FullSearch which takes a date range like TitleSearch
        ' pFilter --&gt; 0=All, 1=NoMinorEdit, 2=OnlyMinorEdit
    Function FullSearchEx(pPattern, pIncludeTitles, pDays, pFilter, pOrderBy, pIncludeAttachmentChanges)
        Dim vTitle, vRegEx, vRegEx2, vList, vPage, vChange, vCurPage, vAttachmentChange, vFound
        Set vList = New Vector
        Set vRegEx = New RegExp
        pPattern = EscapePattern(pPattern)
        vRegEx.IgnoreCase = True
        vRegEx.Global = True
        vRegEx.Pattern = pPattern
        If pIncludeTitles Then
            Set vRegEx2 = New RegExp
            vRegEx2.IgnoreCase = True
            vRegEx2.Global = True
            vRegEx2.Pattern = pPattern
        End If
        vQuery = "SELECT wpg_name, wpg_changes, wrv_revision, wrv_status, wrv_timestamp, wrv_minoredit, wrv_by, wrv_byalias, wrv_comment, wrv_text "
        If cAllowAttachments AND pIncludeAttachmentChanges Then
            vQuery = vQuery & ", ath_name, ath_revision, ath_timestamp, ath_by, ath_byalias, ath_action "
            If OPENWIKI_DB_SYNTAX = DB_ORACLE Then
                vQuery = vQuery & " FROM   openwiki_pages, openwiki_revisions, openwiki_attachments_log " _
                                & " WHERE  wpg_name = wrv_name " _
                                & " AND    wrv_name = ath_wrv_name (+) " _
                                & " AND    wrv_revision = ath_wrv_revision (+)"
            Else
                vQuery = vQuery & " FROM (openwiki_pages LEFT JOIN openwiki_revisions ON openwiki_pages.wpg_name = openwiki_revisions.wrv_name) LEFT JOIN openwiki_attachments_log ON (openwiki_revisions.wrv_name = openwiki_attachments_log.ath_wrv_name) AND (openwiki_revisions.wrv_revision = openwiki_attachments_log.ath_wrv_revision) WHERE 1 = 1 "
            End If
        Else
            vQuery = vQuery & "FROM openwiki_pages, openwiki_revisions " _
                            & "WHERE wrv_name = wpg_name "
        End If
        If pDays > 0 Then
            ' is there a database independent way to test the current date?
            'vQuery = vQuery & " AND wpg_timestamp >
        End If
        If pFilter = 0 Then
            vQuery = vQuery & " AND wpg_lastminor = wrv_revision"
        Elseif pFilter = 1 Then
            vQuery = vQuery & " AND wpg_lastmajor = wrv_revision"
        Elseif pFilter = 2 Then
            vQuery = vQuery & " AND wpg_lastminor = wrv_revision AND wrv_minoredit = 1"
        End If
        If pOrderBy = 1 Then
            vQuery = vQuery & " ORDER BY wrv_timestamp DESC"
        Elseif pOrderBy = 2 Then
            vQuery = vQuery & " ORDER BY wrv_timestamp"
        Else
            vQuery = vQuery & " ORDER BY wpg_name"
        End If
        If cAllowAttachments AND pIncludeAttachmentChanges Then
            vQuery = vQuery & ", ath_timestamp DESC"
        End If
        vRS.Open vQuery, vConn, adOpenForwardOnly
        Do While Not vRS.EOF
                        vFound = False
                        If pIncludeTitles Then
                If vRegEx2.Test(vRS("wpg_name")) Then
                    vFound = True
                End If
            End If
            If vRegEx.Test(vRS("wrv_text")) Then
                                 vFound = True
            End If
            If vFound = True Then
                If vCurPage <> vRS("wpg_name") Then
                    vCurPage = vRS("wpg_name")
                   Set vPage = New WikiPage
                    vPage.Name = vRS("wpg_name")
                    vPage.Changes = CInt(vRS("wpg_changes"))
                    Set vChange = vPage.AddChange
                    vChange.Revision  = CInt(vRS("wrv_revision"))
                    vChange.Status    = CInt(vRS("wrv_status"))
                    vChange.MinorEdit = CInt(vRS("wrv_minoredit"))
                    vChange.Timestamp = vRS("wrv_timestamp")
                    vChange.By        = vRS("wrv_by")
                    vChange.ByAlias   = vRS("wrv_byalias")
                    vChange.Comment   = vRS("wrv_comment")
                    vList.Push(vPage)
                End If
                If cAllowAttachments AND pIncludeAttachmentChanges Then
                    If (vRS("ath_name") <> "") And (vRS("ath_timestamp") > DateAdd("h", -24, Now())) Then
                        Set vAttachmentChange = New AttachmentChange
                        vAttachmentChange.Name = vRS("ath_name")
                        vAttachmentChange.Revision = CInt(vRS("ath_revision"))
                        vAttachmentChange.Timestamp = vRS("ath_timestamp")
                        vAttachmentChange.By = vRS("ath_by")
                        vAttachmentChange.ByAlias = vRS("ath_byalias")
                        vAttachmentChange.Action = vRS("ath_action")
                        vChange.AddAttachmentChange(vAttachmentChange)
                    End If
                End If
            End If
            vRS.MoveNext
        Loop
        vRS.Close
        Set vRegEx = Nothing
        Set FullSearchEx = vList
    End Function


    Function GetPreviousRevision(pDiffType, pDiffTo)
        Dim vBy, vHost, vAgent
        GetPreviousRevision = 0
        If pDiffTo <= 0 Then
            pDiffTo = 99999999
        End If
        vQuery = "SELECT wrv_revision, wrv_minoredit, wrv_by, wrv_host, wrv_agent FROM openwiki_revisions WHERE wrv_name = '" & Replace(gPage, "'", "''") & "' AND wrv_revision <= " & pDiffTo
        vQuery = vQuery & " ORDER BY wrv_revision DESC"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        If Not vRS.EOF Then
            vBy    = vRS("wrv_by")
            vHost  = vRS("wrv_host")
            vAgent = vRS("wrv_agent")
        End If
        Do While Not vRS.EOF
            GetPreviousRevision = CInt(vRS("wrv_revision"))
            If pDiffType = 0 Then
                ' previous major
                If CInt(vRS("wrv_minoredit")) = 0 Then
                    vRS.MoveNext
                    If Not vRS.EOF Then
                        GetPreviousRevision = CInt(vRS("wrv_revision"))
                    End If
                    Exit Do
                End If
            Elseif pDiffType = 1 Then
                ' previous minor
                vRS.MoveNext
                If Not vRS.EOF Then
                    GetPreviousRevision = CInt(vRS("wrv_revision"))
                End If
                Exit Do
            Else
                ' previous author
                If vRS("wrv_by") <> vBy Or vRS("wrv_host") <> vHost Or vRS("wrv_agent") <> vAgent Then
                    Exit Do
                End If
            End If
            vRS.MoveNext
        Loop
        vRS.Close
    End Function


    Function InterWiki()
        Dim vTemp
        vQuery = "SELECT wik_name, wik_url FROM openwiki_interwikis ORDER BY wik_name"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        Do While Not vRS.EOF
            Dim val
            vTemp = vTemp & "<ow:interlink href='" & CDATAEncode(vRS("wik_url")) & "'>" & PCDATAEncode(vRS("wik_name")) & "</ow:interlink>"
            vRS.MoveNext
        Loop
        vRS.Close
        InterWiki = "<ow:interlinks>" & vTemp & "</ow:interlinks>"
    End Function


    Function GetInterWiki(pName)
        If OPENWIKI_DB <> "" Then
            If pName = "This" Then
                GetInterWiki = gScriptName & "?p="
            Else
                vQuery = "SELECT wik_url FROM openwiki_interwikis WHERE wik_name = '" & Replace(pName, "'", "''") & "'"
                vRS.Open vQuery, vConn, adOpenForwardOnly
                If Not vRS.EOF Then
                    GetInterWiki = vRS("wik_url")
                End If
                vRS.Close
            End If
        End If
    End Function


    Function GetRSSFromCache(pURL, pRefreshRate, pFreshlyFromRemoteSite, pRetryLater)
        Dim conn, vRS
        Dim vLast, vNext, vRefreshRate
        Set conn = Server.CreateObject("ADODB.Connection")
        conn.Open OPENWIKI_DB
        vQuery = "SELECT rss_last, rss_next, rss_refreshrate, rss_cache FROM openwiki_rss WHERE rss_url = '" & Replace(pURL, "'", "''") & "'"
        Set vRS = Server.CreateObject("ADODB.Recordset")
        vRS.Open vQuery, conn, adOpenKeyset, adLockOptimistic, adCmdText
        If vRS.EOF Then
            GetRSSFromCache = "notexists"
        Else
            vLast        = vRS("rss_last")
            vNext        = vRS("rss_next")
            vRefreshRate = CInt(vRS("rss_refreshrate"))
            If vRefreshRate <> pRefreshRate Then
                vNext = DateAdd("n", pRefreshRate, vLast)
                vRS("rss_next")        = vNext
                vRS("rss_refreshrate") = pRefreshRate
                vRS.Update
            Elseif pRetryLater Then
                ' retry a minute from now
                vNext = DateAdd("n", 1, Now())
                vRS("rss_next") = vNext
                vRS.Update
            End If

            If pFreshlyFromRemoteSite Or (DateDiff("n", vNext, Now()) < 0) Then
                GetRSSFromCache = "<ow:feed href='" & Replace(pURL, "&", "&amp") & "' "
                If pFreshlyFromRemoteSite Then
                    GetRSSFromCache = GetRSSFromCache & "fresh='true' "
                Else
                    GetRSSFromCache = GetRSSFromCache & "fresh='false' "
                End If
                GetRSSFromCache = GetRSSFromCache & "last='" & FormatDateISO8601(vLast) & "' "
                GetRSSFromCache = GetRSSFromCache & "next='" & FormatDateISO8601(vNext) & "' "
                GetRSSFromCache = GetRSSFromCache & "refreshrate='" & pRefreshRate & "'>"
                GetRSSFromCache = GetRSSFromCache & vRS("rss_cache")
                GetRSSFromCache = GetRSSFromCache & "</ow:feed>"
            End If

        End If
        vRS.Close
        conn.Close
        Set vRS = Nothing
        Set conn = Nothing
    End Function

    Sub SaveRSSToCache(pURL, pRefreshRate, pCache)
        Dim conn, vRS
        Set conn = Server.CreateObject("ADODB.Connection")
        conn.Open OPENWIKI_DB
        vQuery = "SELECT * FROM openwiki_rss WHERE rss_url = '" & Replace(pURL, "'", "''") & "'"
        Set vRS = Server.CreateObject("ADODB.Recordset")
        vRS.Open vQuery, conn, adOpenKeyset, adLockOptimistic, adCmdText
        If vRS.EOF Then
            vRS.Close
            vRS.Open "openwiki_rss", conn, adOpenKeyset, adLockOptimistic, adCmdTable
            vRS.AddNew
            vRS("rss_url") = pURL
        End If
        vRS("rss_last")        = Now()
        If pCache = "" Then
            vRS("rss_next") = DateAdd("n", 30, Now())   ' 30 minutes from now
        Else
            vRS("rss_next") = DateAdd("n", pRefreshRate, Now())
        End If
        vRS("rss_refreshrate") = pRefreshRate
        vRS("rss_cache")       = pCache
        vRS.Update
        vRS.Close
        conn.Close
        Set vRS = Nothing
        Set conn = Nothing
    End Sub

    Sub Aggregate(pURL, pXmlDoc)
        Dim conn, vRS
        Dim vRoot, vItems, vItem
        Dim vXmlIsland, vAgXmlIsland, vNow, i
        Dim vRssLink, vRdfResource, vRdfTimestamp, vDcDate

        On Error Resume Next
        'Response.Write("<p />Aggregating " & pURL & "<br />")

        Set vRoot = pXmlDoc.documentElement

        If vRoot.NodeName = "rss" Then
            Set vItems = vRoot.selectNodes("channel/item")
        Elseif vRoot.getAttribute("xmlns") = "http://my.netscape.com/rdf/simple/0.9/" Then
            Set vItems = vRoot.selectNodes("item")
        Elseif vRoot.getAttribute("xmlns") = "http://purl.org/rss/1.0/" Then
            Set vItems = vRoot.selectNodes("item")
        Else
            Exit Sub
        End If

        vNow = Now()
        i = 0

        ' TODO: find workaround for bug in MSXML v4
        If Not vRoot.selectSingleNode("channel/wiki:interwiki") Is Nothing Then
            vAgXmlIsland = "<ag:source><rdf:Description wiki:interwiki=""" & vRoot.selectSingleNode("channel/wiki:interwiki").text & """><rdf:value>" & PCDATAEncode(vRoot.selectSingleNode("channel/title").text) & "</rdf:value></rdf:Description></ag:source>"
        Else
            vAgXmlIsland = "<ag:source>" & PCDATAEncode(vRoot.selectSingleNode("channel/title").text) & "</ag:source>"
        End If
        vAgXmlIsland = vAgXmlIsland & "<ag:sourceURL>" & PCDATAEncode(vRoot.selectSingleNode("channel/link").text) & "</ag:sourceURL>"

        Set conn = Server.CreateObject("ADODB.Connection")
        conn.Open OPENWIKI_DB
        Set vRS = Server.CreateObject("ADODB.Recordset")

        ' walk trough all item elements and store them in the openwiki_rss_aggregations table
        For Each vItem In vItems
            vRssLink = vItem.selectSingleNode("link").text

            vRdfResource = vItem.getAttribute("rdf:about")
            If IsNull(vRdfResource) Then
                vRdfResource = vRssLink
            End If

            If vItem.selectSingleNode("ag:timestamp") Is Nothing Then
                vRdfTimestamp = DateAdd("s", i, vNow)
            Else
                vRdfTimestamp = vItem.selectSingleNode("ag:timestamp").text
                Call s(vRdfTimestamp, gTimestampPattern, "&ToDateTime($1,$2,$3,$4,$5,$6,$7,$8,$9)", False, False)
                If DateDiff("d", vNow, sReturn) > 1 Then
                    ' we cannot take this date serious, it's too far in the future
                    vRdfTimestamp = DateAdd("s", i, vNow)
                Else
                    vRdfTimestamp = sReturn
                    vAgXmlIsland = vItem.selectSingleNode("ag:source").xml & vItem.selectSingleNode("ag:sourceURL").xml
                End If
            End If
            i = i - 1

            vXmlIsland = "<title>" & PCDATAEncode(vItem.selectSingleNode("title").text) & "</title><link>" & PCDATAEncode(vItem.selectSingleNode("link").text) & "</link>"
            If Not vItem.selectSingleNode("description") Is Nothing Then
                vXmlIsland = vXmlIsland & "<description>" & PCDATAEncode(vItem.selectSingleNode("description").text) & "</description>"
            End If
            If Not vItem.selectSingleNode("dc:creator") Is Nothing Then
                vXmlIsland = vXmlIsland & vItem.selectSingleNode("dc:creator").xml
            End If
            If Not vItem.selectSingleNode("dc:contributor") Is Nothing Then
                vXmlIsland = vXmlIsland & vItem.selectSingleNode("dc:contributor").xml
            End If
            If vItem.selectSingleNode("dc:date") Is Nothing Then
                vDcDate = ""
            Else
                vDcDate = vItem.selectSingleNode("dc:date").text
                vXmlIsland = vXmlIsland & "<dc:date>" & vItem.selectSingleNode("dc:date").text & "</dc:date>"
            End If
            If Not vItem.selectSingleNode("wiki:version") Is Nothing Then
                vXmlIsland = vXmlIsland & "<wiki:version>" & vItem.selectSingleNode("wiki:version").text & "</wiki:version>"
            End If
            If Not vItem.selectSingleNode("wiki:status") Is Nothing Then
                vXmlIsland = vXmlIsland & "<wiki:status>" & vItem.selectSingleNode("wiki:status").text & "</wiki:status>"
            End If
            If Not vItem.selectSingleNode("wiki:importance") Is Nothing Then
                vXmlIsland = vXmlIsland & "<wiki:importance>" & vItem.selectSingleNode("wiki:importance").text & "</wiki:importance>"
            End If
            If Not vItem.selectSingleNode("wiki:diff") Is Nothing Then
                vXmlIsland = vXmlIsland & vItem.selectSingleNode("wiki:diff").xml
            End If
            If Not vItem.selectSingleNode("wiki:history") Is Nothing Then
                vXmlIsland = vXmlIsland & vItem.selectSingleNode("wiki:history").xml
            End If
            vXmlIsland = vXmlIsland & vAgXmlIsland & "<ag:timestamp>" & FormatDateISO8601(vRdfTimestamp) & "</ag:timestamp>"

            vXmlIsland = "<item rdf:about='" & PCDATAEncode(vRdfResource) & "'>" & vXmlIsland & "</item>"

            ' TODO: erm... this is actually inefficient.. use better ADO techniques
            vQuery = "SELECT * FROM openwiki_rss_aggregations WHERE agr_feed='" & Replace(pURL, "'", "''") & "' AND agr_rsslink = '" & Replace(vRssLink, "'", "''") & "'"
            vRS.Open vQuery, conn, adOpenKeyset, adLockOptimistic, adCmdText
            If vRS.EOF Then
                vRS.Close
                vRS.Open "openwiki_rss_aggregations", conn, adOpenKeyset, adLockOptimistic, adCmdTable
                vRS.AddNew
                vRS("agr_feed")      = pURL
                vRS("agr_resource")  = vRdfResource
                vRS("agr_rsslink")   = vRssLink
                vRS("agr_timestamp") = vRdfTimestamp
                vRS("agr_dcdate")    = vDcDate
                vRS("agr_xmlisland") = vXmlIsland
                vRS.Update
            Elseif vRS("agr_dcdate") <> vDcDate Then
                vRS("agr_resource")  = vRdfResource
                vRS("agr_timestamp") = vRdfTimestamp
                vRS("agr_dcdate")    = vDcDate
                vRS("agr_xmlisland") = vXmlIsland
                vRS.Update
            End If
            vRS.Close
        Next

        conn.Close
        Set vRS = Nothing
        Set conn = Nothing

        'Response.Write("<p />Done aggregating " & pURL & "<br />")
    End Sub

    Function GetAggregation(pURLs)
        Dim vRdfSeq, vItems, vTemp, i
        vQuery = ""
        Do While Not pURLs.IsEmpty
            vQuery = vQuery & "'" & Replace(pURLs.Pop(), "'", "''") & "'"
            If pURLs.Count >  0 Then
                vQuery = vQuery & ","
            End If
        Loop
        vQuery = "SELECT * FROM openwiki_rss_aggregations WHERE agr_feed IN (" & vQuery & ") ORDER BY agr_timestamp DESC"
        vRS.Open vQuery, vConn, adOpenForwardOnly
        i = 0
        If OPENWIKI_MAXNROFAGGR <= 0 Then
            OPENWIKI_MAXNROFAGGR = 100
        End If
        Do While Not vRS.EOF
            i = i + 1
            If i > OPENWIKI_MAXNROFAGGR Then
                Exit Do
            End If
            vTemp = CDATAEncode(vRS("agr_resource"))
            vRdfSeq = vRdfSeq & "<rdf:li rdf:resource='" & vTemp & "'/>"
            vItems = vItems & vRS("agr_xmlisland")
            vRS.MoveNext
        Loop
        vRS.Close
        GetAggregation = "<?xml version='1.0' encoding='" & OPENWIKI_ENCODING & "'?>" & vbCRLF _
                      & "<!-- All Your Wiki Are Belong To Us -->" & vbCRLF _
                      & "<rdf:RDF xmlns='http://purl.org/rss/1.0/' xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#' xmlns:dc='http://purl.org/dc/elements/1.1/' xmlns:wiki='http://purl.org/rss/1.0/modules/wiki/' xmlns:ag='http://purl.org/rss/1.0/modules/aggregation/'>" _
                      & "<channel rdf:about='" & CDATAEncode(gServerRoot & gScriptName & "?p=" & gPage & "&a=rss") & "'>" _
                      & "<title>" & PCDATAEncode(OPENWIKI_TITLE & " -- " & PrettyWikiLink(gPage)) & "</title>" _
                      & "<link>" & PCDATAEncode(gServerRoot & gScriptName & "?" & gPage) & "</link>" _
                      & "<description>" & PCDATAEncode(OPENWIKI_TITLE & " -- " & PrettyWikiLink(gPage)) & "</description>" _
                      & "<image rdf:about='" & CDATAEncode(gServerRoot & "ow/images/aggregator.gif") & "'/>" _
                      & "<items><rdf:Seq>" _
                      & vRdfSeq _
                      & "</rdf:Seq></items>" _
                      & "</channel>" _
                      & "<image rdf:about='" & CDATAEncode(gServerRoot & "ow/images/aggregator.gif") & "'>" _
                      & "<title>" & PCDATAEncode(OPENWIKI_TITLE) & "</title>" _
                      & "<link>" & CDATAEncode(gServerRoot & gScriptName & "?p=" & gPage) & "</link>" _
                      & "<url>" & PCDATAEncode(gServerRoot & "ow/images/logo_aggregator.gif") & "</url>" _
                      & "</image>" _
                      & vItems _
                      & "</rdf:RDF>"
    End Function


    Private Function CreateDocKey(pSubKey)
        CreateDocKey = pSubKey & gFS _
                     & gCookieHash & gFS _
                     & gRevision & gFS _
                     & Request.Cookies(gCookieHash & "?up")("pwl") & gFS _
                     & Request.Cookies(gCookieHash & "?up")("new") & gFS _
                     & Request.Cookies(gCookieHash & "?up")("emo")
        CreateDocKey = Hash(CreateDocKey)
    End Function

    Function GetDocumentCache(pSubKey)
        vQuery = "SELECT chc_xmlisland FROM openwiki_cache WHERE chc_name = '" & Replace(gPage, "'", "''") & "' AND chc_hash = " & CreateDocKey(pSubKey)
        vRS.Open vQuery, vConn, adOpenForwardOnly
        If vRS.EOF Then
            GetDocumentCache = ""
        Else
            GetDocumentCache = vRS("chc_xmlisland")
        End If
        vRS.Close
    End Function

    Sub SetDocumentCache(pSubKey, pXmlStr)
        Dim vKey
        vKey = CreateDocKey(pSubKey)
        vQuery = "SELECT chc_xmlisland FROM openwiki_cache WHERE chc_name = '" & Replace(gPage, "'", "''") & "' AND chc_hash = " & vKey
        vRS.Open vQuery, vConn, adOpenKeyset, adLockOptimistic, adCmdText
        If vRS.EOF Then
            vRS.Close
            vRS.Open "openwiki_cache", vConn, adOpenKeyset, adLockOptimistic, adCmdTable
            vRS.AddNew
            vRS("chc_name") = gPage
            vRS("chc_hash") = vKey
        End If
        vRS("chc_xmlisland") = pXmlStr
        vRS.Update
        vRS.Close
    End Sub

    Sub ClearDocumentCache(pConn)
        pConn.Execute "DELETE FROM openwiki_cache"
    End Sub

    Sub ClearDocumentCache2(pConn, pPagename)
        If pConn = "" Then
            Set pConn = vConn
        End if
        pConn.Execute "DELETE FROM openwiki_cache WHERE chc_name = '" & Replace(pPagename, "'", "''") & "'"
    End Sub

' Added functions for rename functionalities
Function ChangeMultiPageNames(pPageName, vNewName)
Dim ct,tOldPageName,tNewPageName,vOldPageArray,vNewPageArray,NumSubPages,ChangedNameIndex
'	// This function will rename all siblings and children

	tOldPageName=pPageName
	tNewPageName=vNewName
	vOldPageArray=split(tOldPageName & "/","/") '        // Put all the subpages into an array
	NumSubPages=UBound(vOldPageArray)-1'        // Store the top element number of the array
	vNewPageArray=split(tNewPageName & "/","/") '        // Put all the subpages into an array
	ChangedNameIndex=0
	If NumSubPages > 0 then '	// This page has children
		For ct=0 to NumSubPages
			If vOldPageArray(ct) <> vNewPageArray(ct) then ChangedNameIndex=ct
		Next
	End If
	'	// vOldPageArray(ChangedNameIndex) is the old root
	'	// vNewPageArray(ChangedNameIndex) is the changed root
Response.Write("Old Root = " & vOldPageArray(ChangedNameIndex))
Response.End
	'	// Now we need to fetch each page that starts with the old root
	'	// and change its name to the new root
		'	// Old Behaviour as default
'        ChangeMultiPageNames = "p=" & pPageName & "&a=rename&step=error&errorText=" & Server.URLEncode("Old Root = " & vOldPageArray(ChangedNameIndex))
		ChangeMultiPageNames=ChangeSinglePageName(pPageName, vNewName)
End Function

Function ChangePageName(pPageName, vNewName,bChangeChildren)
Dim NewSubPageName,cConn,cRS,p,s,aResult,bError,IsSubpage,Root,NewRoot,RootLen,NewRootLen
'       On Error Resume Next
        bChangeChildren = NOT bChangeChildren
        If (pPageName=vNewName) then
                  ChangePageName = "p=" & pPageName & "&a=rename&step=error&errorText=" & Server.URLEncode("New name is the same as the old one!")
                  Exit Function
        End if
        If PageExists(vNewName) then
                  ChangePageName = "p=" & pPageName & "&a=rename&step=error&errorText=" & Server.URLEncode("Name already exists.")
                  Exit Function
        End if
        If NOT PageExists(pPageName) then
                  ChangePageName = "p=" & pPageName & "&a=rename&step=error&errorText=" & Server.URLEncode("Page does not exist.")
                  Exit Function
        End if
		If cFreeLinks=0 then
			If ContainsFreeLinks(vNewName) then
                  ChangePageName = "p=" & pPageName & "&a=rename&step=error&errorText=" & Server.URLEncode("FreeLink pages are not allowed (cFreeLinks=0).")
                  Exit Function
			End if
		End if
        If  bChangeChildren then
			ChangePageName=ChangeMultiPageNames(pPageName, vNewName)
		Else
			ChangePageName=ChangeSinglePageName(pPageName, vNewName)
        End if
End Function

Function ChangeSinglePageName(pPageName, vNewName)
              Dim conn, vExecute,WHEREClause
              WHEREClause = "='" & replace(pPageName,"'","''") & "'"
              Set conn = Server.CreateObject("ADODB.Connection")
              conn.Open OPENWIKI_DB
              BeginTrans(conn)
              ' This needed to be changed for SQL Server, Access doesn't enforce relational
              ' integrity but SQL does, so we tell SQL server to "Cascade Update Related Fields"
              ' otherwise update fails due to FK constraints. This also allows us to do one update only
              ' jthingelstad
              vExecute = "UPDATE openwiki_pages SET wpg_name='" & replace(vNewName,"'","''") & "' WHERE wpg_name" & WHEREClause
              conn.execute(vExecute)
              If OPENWIKI_DB_SYNTAX = DB_ACCESS then
                  vExecute = "UPDATE openwiki_revisions SET wrv_name='" & vNewName & "' WHERE wrv_name" & WHEREClause
                  conn.execute(vExecute)
              ' ----- the following 4 lines were added to update the attachment tables
                  vExecute = "UPDATE openwiki_attachments SET att_wrv_name='" & vNewName & "' WHERE att_wrv_name" & WHEREClause
                  conn.execute(vExecute)
                  vExecute = "UPDATE openwiki_attachments_log SET ath_wrv_name='" & vNewName & "' WHERE ath_wrv_name" & WHEREClause
                  conn.execute(vExecute)
              else
                  vExecute = "UPDATE openwiki_revisions SET wrv_name='" & vNewName & "' WHERE wrv_name" & WHEREClause
                  conn.execute(vExecute)
              end if
              ' ----- the following 4 lines were added to update the attachment tables
              vExecute = "UPDATE openwiki_attachments SET att_wrv_name='" & vNewName & "' WHERE att_wrv_name" & WHEREClause
              conn.execute(vExecute)
              vExecute = "UPDATE openwiki_attachments_log SET ath_wrv_name='" & vNewName & "' WHERE ath_wrv_name" & WHEREClause
              conn.execute(vExecute)


  ' ----- end of added lines
  ' added code to delete any entries in the openwiki_cache table otherwise you get odd behavior, jthingelstad
  vExecute = "DELETE FROM openwiki_cache"
  conn.execute(vExecute)
  If conn.Errors.Count > 0 then
                  RollbackTrans(conn)
                  ChangeSinglePageName = "p=" & pPageName & "&a=rename&step=error&errorText=Update%20failed!"
  Else
                  CommitTrans(conn)
                  ' ----- Added to rename folder containing attachments - 8/29/03
                  Dim vFSO
                  Set vFSO = Server.CreateObject("Scripting.FileSystemObject")
                  If vFSO.FolderExists(Server.MapPath(OPENWIKI_UPLOADDIR & pPageName & "/")) Then
                                  vFSO.MoveFolder Server.MapPath(OPENWIKI_UPLOADDIR & pPageName), Server.MapPath(OPENWIKI_UPLOADDIR & vNewName)
                  End If
                  Set vFSO = Nothing
                  ' ----- end of addition
                  ChangeSinglePageName = vNewName
  End If
End Function

Function ChangeHardCodedPages(pPageName, vNewName)

End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' End changes monloup

Function FetchUserName()
        FetchUserName = GetRemoteAlias()
        If FetchUserName="" then FetchUserName = GetRemoteUser()
        If FetchUserName="" then FetchUserName = "Anonymous"
End Function

End Class


'______________________________________________________________________________________________________________
Function FormatDateISO8601(pTimestamp)
    Dim vTemp
    FormatDateISO8601 = Year(pTimestamp) & "-"
    vTemp = Month(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & "-"
    vTemp = Day(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & "T"
    vTemp = Hour(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & ":"
    vTemp = Minute(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp & ":"
    vTemp = Second(pTimestamp)
    If vTemp < 10 Then
        FormatDateISO8601 = FormatDateISO8601 & "0"
    End If
    FormatDateISO8601 = FormatDateISO8601 & vTemp
    FormatDateISO8601 = FormatDateISO8601 & OPENWIKI_TIMEZONE
End Function

Sub ToDateTime(pYear, pMonth, pDay, pHour, pMinutes, pSeconds, pPlusMinTZ, pHourTZ, pMinutesTZ)
    sReturn = DateSerial(pYear, pMonth, pDay)
    If pPlusMinTZ = "-" Then
        sReturn = DateAdd("h", pHour + pHourTZ, sReturn)
        sReturn = DateAdd("n", pMinutes + pMinutesTZ, sReturn)
    Elseif pPlusMinTZ = "+" Then
        sReturn = DateAdd("h", pHour - pHourTZ, sReturn)
        sReturn = DateAdd("n", pMinutes - pMinutesTZ, sReturn)
    End If
    If pPlusMinTZ = "-" Or pPlusMinTZ = "+" Then
        ' it's in GMT, now move it to OPENWIKI_TIMEZONE
        If Left(OPENWIKI_TIMEZONE, 1) = "-" Then
            sReturn = DateAdd("h", -1 * Mid(OPENWIKI_TIMEZONE, 2, 2), sReturn)
            sReturn = DateAdd("n", -1 * Mid(OPENWIKI_TIMEZONE, 5, 2), sReturn)
        Else
            sReturn = DateAdd("h", Mid(OPENWIKI_TIMEZONE, 2, 2), sReturn)
            sReturn = DateAdd("n", Mid(OPENWIKI_TIMEZONE, 5, 2), sReturn)
        End If
    End If
End Sub

Function EscapePattern(pPattern)
    Dim vRegEx
    pPattern = Replace(pPattern, "''''''", "")
    Set vRegEx = New RegExp
    vRegEx.IgnoreCase = True
    vRegEx.Global = True
    vRegEx.Pattern = pPattern
    On Error Resume Next
    Err.Number = 0
    vRegEx.Test("x")
    If Err.Number <> 0 Then
        pPattern = Replace(pPattern, "\", "\\")
        pPattern = Replace(pPattern, "(", "\(")
        pPattern = Replace(pPattern, ")", "\)")
        pPattern = Replace(pPattern, "[", "\[")
        pPattern = Replace(pPattern, "+", "\+")
        pPattern = Replace(pPattern, "*", "\*")
        pPattern = Replace(pPattern, "?", "\?")
    End If

    'Response.Write("Pattern : " & pPattern & "<br />")
    EscapePattern = pPattern
End Function

Function PageExists(pPage)
   Dim vConn, vRS, vQuery
   Set vConn = Server.CreateObject("ADODB.Connection")
   vConn.Open OPENWIKI_DB
   Set vRS = Server.CreateObject("ADODB.Recordset")
   vQuery = "SELECT wpg_name FROM openwiki_pages WHERE wpg_name='" & Replace(pPage,"'","''") & "'"
   vRS.Open vQuery, vConn, adOpenForwardOnly
   If not vRS.EOF then
           PageExists = True
   Else
           PageExists = False
   End If
   vRS.Close
End Function

%>