<%
' // $Log: owplugin_editrestrictions.asp,v $
' // Revision 1.3  2006/04/10 09:33:05  gbamber
' // Build 20060407:
' //
' // BugFix for Oracle:
' // When editing a page in invalid syntax was used to update attachments.
' // changes in:
' // owdb.asp
' //
' // New Authorisation Subs for customizable Authorisation. New myauth.asp containing to the two new Subs.
' // changes in:
' // owall.asp
' // owplugin_viewrestrictions.asp
' // owplugin_editrestrictions.asp
' // myauth.asp
' //
' // New Functions for more customizable wikify patterns.
' // changes in:
' // owpatterns.asp
' // mywikify.asp
' //
' // New option cReadCategoriesFromDB. If its set to 1 then additional categories are read from the db.
' // changes in:
' // owconfig_default.asp
' // owpreamble.asp
' // owprocessor.asp
' //
' // Note:
' // The values of KEY_CATEGORIES in OPENWIKI_CATEGORIES MUST MATCH their current entry !
' // e.g. last hardcoded categorie is No.22 "Protected View and Edit",
' // so the first entry in OPENWIKI_CATEGORIES must be 23 "whatever category" and the next 24 etc.
' //
' // if you have any questions you can also mail me to vagabond@gmx.com.
' //
' // Revision 1.3  2006/04/07 18:17:59  Vagabond
' // Build 200600407
' // added call to MyCheckForAllowedEdit
' //
' // Revision 1.2  2006/02/22 10:17:59  gbamber
' // Build 20060216.3
' // Softcoded viewerror and editerror page names
' //
' // Revision 1.1  2006/01/09 09:43:03  gbamber
' // Added #ALLOWVIEW directive
' // Changed filename 'accessrestrictions' to 'edfitrestrictions'
' // Added page name constants to owpreamble
' // Inactivated CAPTCHA plugin by default
' //
' **** ACTIVATION CODE ***
plugins.Add "Edit Restrictions",0
' ************************
Dim cLocalOverride

' ************************************************************************************
cLocalOverride = 1' 0=Private IP addresses cannot override restrictions, 1=Private IP addresses can always edit any page
'        // For most Intranets you will want to set this to zero, else there will be effectively no Edit Restrictions at all!
cUseParentRestrictions = 1        '0 = Access restricions for subpages individual, 1=Access restricions for subpages governed by parent page
If OPENWIKI_EDITERRORPAGE="" then OPENWIKI_EDITERRORPAGE="EditError"
' ************************************************************************************

' ** IMPORTANT! YOU CAN OVERRIDE ALL RESTRICTIONS BY DOING THIS! **
'        // Edit page URL to <serverroot>/ow.asp?p=<pagename>&a=edit&emergencyoverridecode=<gAdminPassword>
'        // in order to be able to edit any page on the Wiki

Sub CheckForAllowedEdit(vPage)
        If plugins.Item("Edit Restrictions") = 1 Then
                A_CheckForAllowedEdit vPage
		MyCheckForAllowedEdit
        End If

End Sub

Function myfind(pText, pPattern)
        If plugins.Item("Edit Restrictions") = 1 Then
                myfind = A_myfind(pText, pPattern)
        Else
                myfind=""
        End If
End Function


' **** ACTIVE CODE ***
Function A_myfind(pText, pPattern)
    dim matches, re
    set re = new RegExp
    re.IgnoreCase = 0
    re.Global     = 1
    re.Pattern    = pPattern
    set matches = re.Execute(pText)
    if matches.count then
                A_myfind = mid(matches(0).Value,2, matches(0).Length-2)
    else
                A_myfind = ""
    end if
End Function

'        // This sub is always called as it only hides the #ALLOWEDIT, #ALLOWVIEW and #GROUP text from the page
Sub WikifyAllowedEdit(pText,vText)
        if m(pText, "^#ALLOWEDIT", False, False) then
                        gTemp = InStr(1, pText, vbCr)'        // Fetch position of the end-of-line
                          if (gTemp > 0) then
                                           vText = mid(pText, gTemp + 2) '        // Cut out 1st line from page text
                        else
                                        vText=vbCr '        // #ALLOWEDIT was the only entry
                          end if
        End If
        gTemp = InStr(1,vText, "#GROUP") '        // Look for #GROUP on next line
        if  gTemp > 0 then
                        gTemp = InStr(gTemp, vText, vbCr)'        // Find end-of-line
                        if (gTemp > 0) then
                                        vText = mid(vText, gTemp + 2) '        // Cut out 2st line from page text
                        else
                                        vText=vbCr '        // #GROUP was the only other entry
                          end if

        end if
        gTemp = InStr(1,vText, "#ALLOWVIEW") '        // Look for #ALLOWVIEW on next line
        if  gTemp > 0 then
                        gTemp = InStr(gTemp, vText, vbCr)'        // Find end-of-line
                        if (gTemp > 0) then
                                        vText = mid(vText, gTemp + 2) '        // Cut out line from page text
                        else
                                        vText=vbCr '        // #ALLOWVIEW was the only other entry
                          end if

        end if
        if vText="" then
                         vText = vbCr
        end if
End Sub

Private Function GetOverrideList(vPage)
'	// TODO:
'	// Use this function (currently unused) to
'	// Find the Pos in the page text where #ALLOWEDIT starts
'	// Skip 11 places, and do a myfind to get the name list from Mid(pagetext,pos)
'	// Return the list of names

Dim OverrideList,tPage,tPageName
		Dim Pos
        OverrideList="" '        // Initialise to empty
        Set tPage=vPage '        // Initialise temp page object to current page object
        tPageName=tPage.Name
        if (InstrRev(tPageName,"/") > 0) then '        // Current page is a SubPage. Loop wil go at least once.

                do While (InstrRev(tPageName,"/") > 0)
						Pos=Instr(tPage.Text,"#ALLOWEDIT=")
                        if Pos > 0 then
								Pos=Pos+11 '	// Skip past #ALLOWEDIT=
                                OverrideList = OverrideList & "|" & A_myfind(Mid(tPage.Text,Pos),"=.*;")
                        End If

                        tPage=Left(tPage,InstrRev(tPage.Name,"/")-1)
                        Set tPage = gNamespace.GetPage(tPage, 0, True, False)
                        tPageName=tPage.Name
                Loop
        End If
        GetOverrideList=OverrideList
		Set tPage=Nothing
End Function

Sub A_CheckForAllowedEdit(vPage)

Dim gTopParentPage,vTopParentPage,tPageObject,tPagename,OverrideNamelist,tempList,Pos

        Set vTopParentPage = vPage '        // Default: Assume that this page is the highest.
        gTopParentPage=vTopParentPage.Name '        // Default: This is not a subpage
        OverrideNamelist="" '        // Default: No override permissions

                '        // Deal with any names that might be on this page, even though permissions are
                '        // set on the parent page. This makes an Override list of names only (not groups)
                '        // Anything in the override list is IN ADDITION to the parent permissions
                'OverrideNamelist=GetOverrideList(vPage)


        If cUseParentRestrictions = 1 then
        '        // 1) Find highest page in the tree that has permissions set (maybe there is no tree)
        '        // 2) Add non-duplicate permissions from any pages below this highest page (not including the highest page itself)
                If (InstrRev(vPage.Name,"/") > 0) then'        // is this a subpage (or subsubpage or whatever) at all?
                        Set tPageObject=VPage
                        tPageName=tPageObject.Name
                        Do While (InstrRev(tPageName,"/") > 0)'        // is this a subpage (or subsubpage or whatever)?
                                '        // Fetch the parent page
                                tPageName=Left(tPageName,InstrRev(tPageName,"/")-1)
                                Set tPageObject = gNamespace.GetPage(tPageName, 0, True, False)
                                if (Instr(tPageObject.Text,"#ALLOWEDIT=") > 0 ) then
                                        Set vTopParentPage = tPageObject '        // Found a permissions page! Store it.
                                        gTopParentPage=vTopParentPage.Name
                                End If
                        Loop
                        '        // The Object vTopParentPage is now the highest page in the hierarchy with permissions set

                        '        // Now start again from the base of the hierarchy to find override permissions
                        Set tPageObject=VPage '        // Initialise to the current page
                        tPageName=tPageObject.Name
                        '        // Fetch any names on the current page
						Pos = Instr(tPageObject.Text,"#ALLOWEDIT=")
                        if Pos > 0 then
                                OverrideNamelist = OverrideNamelist & "|" & A_myfind(Mid(tPageObject.Text,Pos),"=.*;")
                        End If

                        Do While (InstrRev(tPageName,"/") > 0) '        // is this a subpage (or subsubpage or whatever)?
                                '        // Fetch the parent page
                                tPageName=Left(tPageName,InstrRev(tPageName,"/")-1)
                                if tPageName=gTopParentPage then Exit Do '        // Dont want to add highest page permisiions again!

                                ' // This is not the highest page, so add the permissions
                                Set tPageObject = gNamespace.GetPage(tPageName, 0, True, False)
								Pos = Instr(tPageObject.Text,"#ALLOWEDIT=")
                                if Pos > 0 then
                                        OverrideNamelist = OverrideNamelist & "|" & A_myfind(Mid(tPageObject.Text,Pos),"=.*;")
                                End If
                        Loop
                        Set tPageObject = Nothing '        // Tidy up
                End If

        End If

'        // DEBUGGING START //
'        vPage.Text="===" & vTopParentPage.Text & "===" & vPage.Text
'        // DEBUGGING END //

        ' ============== START CHANGES FOR ALLOWEDIT ===================
        Pos = Instr(vTopParentPage.Text,"#ALLOWEDIT=")
		if Pos > 0 then
                Dim edit, user, group, groups, groupPage, editOK, gIP,pGroup,tempText,DebugMode
                editOK = False'        // default
                '        // If the page contains "#DEBUG" anywhere, then produce a debugging report in the editbox
                '                // (Unless there is already one on the page, of course)
                DebugMode=((Instr(vPage.Text,"#DEBUG") > 0) AND (Instr(vPage.Text,"END OF DEBUG REPORT") = 0))
                '        // Get a username
                user = GetRemoteUser()
                If user="" then user = GetRemoteAlias()
                If user="" then user = "Anonymous"
                if DebugMode then
                                        vPage.Text=vPage.Text & VBCR & VBCR & "================================================================="
                                        vPage.Text=vPage.Text & VBCR & "=== " &  vPage.Name & ": DEBUG REPORT (delete text before saving this page!) ==="
                                        If cUseParentRestrictions = 1 then
                                                vPage.Text=vPage.Text & VBCR & "==== (Using Edit Restrictions set in the page " & gTopParentPage & ") ===="
                                        End If
                                        vPage.Text=vPage.Text & VBCR & "==== This code is in /plugins/owplugin_editrestrictions.asp  ====" & VBCR
                end if
                '        // Fetch list i.e. "User1|Group1|User1" into variable 'edit'
                edit = myfind(Mid(vTopParentPage.Text,Pos),"=.*;") & OverrideNamelist
                if ((DebugMode) AND (OverrideNamelist <> "") ) then
                        vPage.Text=vPage.Text & VBCR & "  * Found Top Permissions list: '" & myfind(vTopParentPage.Text,"=.*;") & "'" & VBCR
                        vPage.Text=vPage.Text & VBCR & "  * Adding OverRides list: '" & OverrideNamelist & "'" & VBCR
                end if
                if DebugMode then vPage.Text=vPage.Text & VBCR & "  * Total #ALLOWEDIT list: '" & edit & "'" & VBCR
                if (Instr(edit,user) > 0) then
                        editOK = True '        // Username found in variable 'edit'
                        if DebugMode then
                                        vPage.Text=vPage.Text & VBCR & "  * **Found username: '" & user & "'. Setting editOK to TRUE (editing allowed)**"
                                        vPage.Text=vPage.Text & VBCR & "====================== END OF EDIT DEBUG REPORT ======================"
                                        vPage.Text=vPage.Text & VBCR & "================================================================="
                        end if
                Else
                        if DebugMode then vPage.Text=vPage.Text & VBCR & "    * '" & user & "' is **NOT** in the #ALLOWEDIT list!"

                        '        // user name is not explicitly in the #ALLOWEDIT list.
                        '        // If there is a Group name(s) in the list, go on to search in the Group Page #GROUP lists

                                '        // Split variable 'edit' into an array variable 'groups'
                                groups = split(edit,"|")

                        For each group in groups
                                if DebugMode then vPage.Text=vPage.Text & VBCR & VBCR & "  * Found user or groupname '" & group & "' in #ALLOWEDIT list." & VBCR

                                '        // Is there a page that matches the name '(groupname)Group'? i.e. 'AdminGroup'
                                set groupPage = gNamespace.GetPage(group & "Group", 0, True, False)
                                if groupPage.Exists then '        // There is a page!
                                                if DebugMode then vPage.Text=vPage.Text & VBCR & "  * Found corresponding '" & group & "Group' Page." & VBCR
                                                '        // Has the Group page got a #GROUP directive in it?
                                                if (Instr(groupPage.Text,"#GROUP") > 0) then
                                                                if DebugMode then vPage.Text=vPage.Text & VBCR & "    * '" & group & "Group' Page contains a GROUP directive." & VBCR

                                                                '        // Skip past any #ALLOWEDIT line, and just look at text after the #GROUP string
                                                                pGroup=Instr(groupPage.Text,"#GROUP") '        // Find the start position of the string '#GROUP'
                                                                tempText = Mid(groupPage.Text,pGroup) '        // Get all the page text after the string '#GROUP'

                                                                '        // Fetch the list "user1|user2|user3" from the GROUP list (strip out the '#GROUP=' and the ';')
                                                                edit = "|" & myfind(tempText,"=.*;") & "|"

                                                                if DebugMode then  vPage.Text=vPage.Text & VBCR & "    * Group list in '" & group & "Group' Page is '" & edit & "'" & VBCR

                                                                if (Instr(edit,"|" & user & "|") > 0) then '        // Is the username in the #Group list?
                                                                                if DebugMode then vPage.Text=vPage.Text & VBCR & "  * **Found '" & user & "' in the " & group & " GROUP list, so setting editOK to TRUE (editing allowed)**" & VBCR
                                                                                editOK = True
                                                                                Exit for '        // Don't look in any nore groups - just exit the loop early
                                                                else
                                                                                if DebugMode then vPage.Text=vPage.Text & VBCR & "    * '" & user & "' is **NOT** in the " & group & " GROUP list!"
                                                                end if '        // of user in #Group list
                                                end if'        // of groupPage contains #GROUP
                                end if'        // of GroupPage exists
                        Next '        // group loop
                        if DebugMode then
                                vPage.Text=vPage.Text & VBCR & "====================== END OF EDIT DEBUG REPORT ======================"
                                vPage.Text=vPage.Text & VBCR & "================================================================="
                        end if
                End if

                '        // ALWAYS ALLOW IPs in gOverrideIPArray //
                gIP=Trim(Request.ServerVariables("REMOTE_ADDR"))
                If (cLocalOverride=1) then
                   if gNameSpace.IsLocalMachine then
                      editOK = True
                            if DebugMode then
                                    vPage.Text=vPage.Text & VBCR & "================================================================="
                                    vPage.Text=vPage.Text & VBCR & "=============== Local IP (" & Trim(gIP) & ") Override activated! ===================="
                                    vPage.Text=vPage.Text & VBCR & "================================================================="
                            End If
                    end if
                End If

'                // Edit page URL to /ow.asp?p=<pagename>&a=edit&emergencyoverridecode=<gAdminPassword>
'                // in order to be able to edit any page on the Wiki
                If Request.Querystring("emergencyoverridecode")=gAdminPassword then
                         editOK = True
                                        if DebugMode then
                                                vPage.Text=vPage.Text & VBCR & "================================================================="
                                                vPage.Text=vPage.Text & VBCR & "=============== Emergency Override activated! ==================="
                                                vPage.Text=vPage.Text & VBCR & "================================================================="
                                        End If
                End If

        '        // User is not allowed to edit this page
                if NOT editOK then
                   Response.Redirect(gScriptName & "?a=view&p=" & OPENWIKI_EDITERRORPAGE & "&redirect=" &  Server.URLEncode(FreeToNormal(gPage)))
                   exit sub
                end if'        // of edit not allowed
        End if '        // of #ALLOWEDEDIT found at start of page
         ' =============== END CHANGES FOR ALLOWEDIT =======================
End Sub
%>