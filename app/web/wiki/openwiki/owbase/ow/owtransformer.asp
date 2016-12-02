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
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owtransformer.asp,v $
'    $Revision: 1.20 $
'      $Author: sansei $
' ---------------------------------------------------------------------------
'

Class Transformer
    Private vXmlDoc, vXslDoc, vXslTemplate, vXslProc, vIsIE

'    Public Property Let MSXML_VERSION(pMSXML_VERSION)
'        vMSXML_VERSION = pMSXML_VERSION
'    End Property
'
'    Public Property Let Cache(pCacheXSL)
'        vCacheXSL = pCacheXSL
'    End Property
'
'    Public Property Let StylesheetsDir(pDir)
'        vStylesheetsDir = pDir
'    End Property
'
'    Public Property Let Encoding(pEncoding)
'        vEncoding = pEncoding
'    End Property
'
'    Public Property Let WriteToOutput(pWriteToOutput)
'        vWriteToOutput = pWriteToOutput
'    End Property

    Private Sub Class_Initialize()
        On Error Resume Next
        If MSXML_VERSION = 4 Then
            Set vXmlDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument.4.0")
        Else
            Set vXmlDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument")
        End If
        vXmlDoc.async = False
        vXmlDoc.preserveWhiteSpace = True
        If Not IsObject(vXmlDoc) Then
            ' As this is the first time we try to instantiate the XML Doc object
            ' let's assume the user hasn't configured his/her owconfig file
            ' correctly yet. Switch MS XML Version to try again.
            If MSXML_VERSION = 4 Then
                MSXML_VERSION = 3
            Else
                MSXML_VERSION = 4
            End If
            If MSXML_VERSION = 4 Then
                Set vXmlDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument.4.0")
            Else
                Set vXmlDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument")
            End If
            vXmlDoc.async = False
            vXmlDoc.preserveWhiteSpace = True
            If Not IsObject(vXmlDoc) Then
                EndWithErrorMessage()
            Elseif MSXML_VERSION = 3 Then
                Response.Write("<b>WARNING:</b>You've configured your OpenWiki to use the MSXML v4 component, but you don't appear to have this installed. The application now falls back to use the MSXML v3 component. Please update your config file (usually file owconfig_default.asp) or install MSXML v4.<br />")
            Else
                Response.Write("<b>WARNING:</b>You've configured your OpenWiki to use the MSXML v3 component, but you don't appear to have this installed. The application now falls back to use the MSXML v4 component. Please update your config file (usually file owconfig_default.asp) or install MSXML v3.<br />")
            End If
        End If

        Dim vTemp
        vTemp = Request.ServerVariables("HTTP_USER_AGENT")
        If (InStr(vTemp, " MSIE 5.5;") > 0) Or (InStr(vTemp, " MSIE 6") > 0) Then
            vIsIE = True
        Else
            vIsIE = False
        End If
    End Sub

    Private Sub Class_Terminate()
        Set vXslProc = Nothing
        Set vXslTemplate = Nothing
        Set vXslDoc = Nothing
        Set vXmlDoc = Nothing
    End Sub

    Private Sub EndWithErrorMessage()
        Response.Write("<h2>Error: Missing MSXML Parser 3.0 Release</h2>")
        Response.Write("In order for this script to work correctly the component " _
                     & "MSXML Parser 3.0 Release " _
                     & "or a higher version needs to be installed on the server. " _
                     & "You can download this component from " _
                     & "<a href=""http://msdn.microsoft.com/xml"">http://msdn.microsoft.com/xml</a>.")
        Response.End
    End Sub

    Public Sub LoadXSL(pFilename)
        On Error Resume Next
        Set vXslTemplate = Nothing
        vXslTemplate = ""
        If cCacheXSL = 1 Then
            If IsObject(Application("ow__" & pFilename)) Then
                Set vXslTemplate = Application("ow__" & pFilename)
            End If
        End If
        If Not IsObject(vXslTemplate) Then
            If MSXML_VERSION = 4 Then
                Set vXslDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument.4.0")
            Else
                Set vXslDoc = Server.CreateObject("Msxml2.FreeThreadedDOMDocument")
            End If
            vXslDoc.async = False
            If Not vXslDoc.load(Server.MapPath(pFilename)) Then
                Response.Write("<p><b>Error in " & Server.MapPath(pFilename) & ":</b> " & vXslDoc.parseError.reason & " line: " & vXslDoc.parseError.Line & " col: " & vXslDoc.parseError.linepos & "</p>")
                Response.End
            End If
            If MSXML_VERSION = 4 Then
                Set vXslTemplate = Server.CreateObject("Msxml2.XSLTemplate.4.0")
            Else
                Set vXslTemplate = Server.CreateObject("Msxml2.XSLTemplate")
            End If
            If Not IsObject(vXslTemplate) Then
                EndWithErrorMessage()
            End If
            Set vXslTemplate.stylesheet = vXslDoc
            If Err.Number <> 0 Then
                Response.Write("<p><b>Error in an included stylesheet</p>")
                Response.End
            End If
            If cCacheXSL Then
                Set Application("ow__" & pFilename) = vXslTemplate
            End If
        End If
        Set vXslProc = vXslTemplate.createProcessor()
        If Not IsObject(vXslProc) Then
            EndWithErrorMessage()
        End If
        On Error Goto 0
    End Sub

    Public Function TransformXmlDoc(pXmlDoc, pXslFilename)
		If Instr(pXslFilename,"skins/common") =0 then
	        LoadXSL(GetSkinDir() & "/" & pXslFilename)
		else
	        LoadXSL("ow/" & pXslFilename)
		end if
        vXslProc.input = pXmlDoc
        vXslProc.transform
        TransformXmlDoc = vXslProc.output
    End Function

    Public Function Transform(pXmlStr)
        Transform = TransformXmlStr(pXmlStr,GetSkinDir() & "/ow.xsl")
     End Function

    Public Function GrabWikiPage(pURL)
        Dim vXmlDoc, vRoot
            Set vXmlDoc = RetrieveXML(pURL)

        Set vRoot = vXmlDoc.documentElement
                If vRoot.NodeName = "html" Then
                        GrabWikiPage = TransformXmlDoc(vXmlDoc, "ow.xsl")
                else
                        GrabWikiPage = "<ow:error>" & vRoot.NodeName & " - Not a valid OpenWiki page</ow:error>"
                end if
    End Function

        Function PrepareSerialiseFolders(pFolderName,bForce)
        PrepareSerialiseFolders = false
'       // Trap for empty folder name
        If (pFolderName = "") then
          If cWriteHTML then
             pFolderName="savedhtml"
          else
             pFolderName="savedxml"
          end if
        end if
        On Error Resume Next
                Dim vFSO,ct,szSkin
                Dim CURRDIR,savedhtmldir,savedimagedir,savedicondir,savedcssdir
                Dim savedskindir,savedskinimagesdir,savedlocalimagesdir,savedattachmentsdir
                Set vFSO = Server.CreateObject("Scripting.FileSystemObject")
                        savedhtmldir=pFolderName
        ' // Make folders to recieve the pages, and fetch all the images and attachments (once only)
                        CURRDIR=Server.MapPath(".")
                        savedhtmldir = CURRDIR & "\" & savedhtmldir
                        savedimagedir = savedhtmldir & "\images"
                        savedicondir = savedimagedir & "\icons"
                        savedlocalimagesdir = savedimagedir
                        savedattachmentsdir = savedhtmldir & "\attachments"

                        If ( (NOT vFSO.FolderExists(savedhtmldir)) OR (NOT vFSO.FolderExists(savedimagedir)) OR (bForce=true) ) then
                                If gSerialisingInProgress then
                                   RESPONSE.WRITE("TRANSFERRING FILES.. ")
                                   RESPONSE.FLUSH
                                End If
                                If Not vFSO.FolderExists(savedhtmldir) then vFSO.CreateFolder(savedhtmldir)
                                If Not vFSO.FolderExists(savedimagedir) then vFSO.CreateFolder(savedimagedir)
                                If Not vFSO.FolderExists(savedicondir) then vFSO.CreateFolder(savedicondir)
                                If Not vFSO.FolderExists(savedattachmentsdir) then vFSO.CreateFolder(savedattachmentsdir)
                                Call vFSO.CopyFile(Server.MapPath("ow/images") & "\*.*",savedimagedir & "\",true)
                                Call vFSO.CopyFolder(Server.MapPath("ow/images/icons") & "\*",savedicondir & "\",true)
                                Call vFSO.CopyFile(Server.MapPath("ow/images/icons") & "\*.*",savedicondir & "\",true)


                                Call vFSO.CopyFolder(Server.MapPath(OPENWIKI_UPLOADDIR) & "\*",savedattachmentsdir & "\",true)
                                Call vFSO.CopyFile(Server.MapPath(OPENWIKI_IMAGELIBRARY) & "\*.*",savedlocalimagesdir & "\",true)

                '                                        Grab the skin names from owskinning and copy over css files
                                For ct=0 to UBound(NameArray)
                                        if NameArray(ct) <> "" then
                                                szSkin = LCASE(Trim(NameArray(ct)))
                                                savedskindir = savedhtmldir & "\" & szSkin
                                                savedskinimagesdir = savedskindir & "\images"
                                                savedcssdir = savedskindir & "\css"
                                                If Not vFSO.FolderExists(savedskindir) then vFSO.CreateFolder(savedskindir)
                                                If Not vFSO.FolderExists(savedcssdir) then vFSO.CreateFolder(savedcssdir)
                                                If Not vFSO.FolderExists(savedskinimagesdir) then vFSO.CreateFolder(savedskinimagesdir)
                                                if vFSO.FolderExists(Server.MapPath("ow/skins/" & szSkin)) then
                                                        Call vFSO.CopyFile(Server.MapPath("ow/skins/" & szSkin) & "\*.css",savedcssdir & "\",true)
                                                End If
                                                if vFSO.FolderExists(Server.MapPath("ow/skins/" & szSkin & "/images")) then
                                                        Call vFSO.CopyFile(Server.MapPath("ow/skins/" & szSkin & "/images") & "\*.*",savedskinimagesdir & "\",true)
                                                End If
                                        end if
                                Next
                                If gSerialisingInProgress then
                                   RESPONSE.WRITE("..DONE")
                                   RESPONSE.FLUSH
                                End If
                        End If
                        Set vFSO = Nothing
        PrepareSerialiseFolders = true
        End Function

        Public Function SkinExists
        Dim ct
        SkinExists = false
          For ct=0 to UBound(NameArray)
            if NameArray(ct) <> "" then
                  if LCase(OPENWIKI_ACTIVESKIN) = LCASE(Trim(NameArray(ct))) then
                     SkinExists = true
                  Exit for
                  end if
            End If
          Next
        End Function

        Public Function SerialiseHTML(pHTMLStr)
        On Error Goto 0
        Dim vFSO,objTextStream,sz,vPageName
        Dim savedhtmldir,newattachmentsdir,oldattachmentsdir,oldimagedir,newimagedir
                vPageName=gPage '        // Grab the current page name
                SerialiseHTML=False '        // Assume an error
                ' // Don't save UserPreferences to disk!
                if (vPageName=OPENWIKI_UPNAME) then exit function
        '        // Assign from parameters
'               // DEBUGGING LINES START
'                if (gSerialisingInProgress = true) then
'                   RESPONSE.WRITE("<br />SerialiseXML(" & vPageName & ") called<br />")
'                   RESPONSE.FLUSH
'                 end if
'               // DEBUGGING LINES END
                sz=pHTMLStr
                savedhtmldir = Server.MapPath(".") & "\" & cWriteHTMLFoldername
                If NOT gTransformer.SkinExists then OPENWIKI_ACTIVESKIN="default"
                ' // Non-relative paths
                newattachmentsdir = "attachments/"
                oldattachmentsdir = gServerRoot & OPENWIKI_UPLOADDIR
                newimagedir = "images/"
                oldimagedir = gServerRoot & "images/"


        '        // Scrape the HTML, changing stuff as we go
        '        // Convert internal links (take out the ow.asp)

                sz = s(sz,"(ondblclick=\"".*?\"")","",true,true)
                sz = s(sz,"(Edit)</a>.*?(this page)","",true,true)
                sz = s(sz,"<a class=\""functions\"" href=\""\?p=(.*?)\""","<a href=""$1.html""",true,true)
                sz=s(sz,"ow.asp\?p=(.*?)\&\s\S\""","$1.html""",true,true)
                sz=s(sz,"ow.asp\?(.*?)\""","$1.html""",true,true)
        '                                        // Convert subpage references / and ./ to _
                sz=s(sz,"(\%2E)",vPageName,true,true)
                sz=s(sz,"([\s\S])\%2F([\s\S])","$1_$2",true,true)
        '                                        // Convert image and icon folder references


                sz = s(sz,OPENWIKI_ICONPATH & "\/(.*?)\""","images/icons/$1""",true,true)
                sz = s(sz,OPENWIKI_IMAGEPATH & "\/(.*?)\""","images/$1""",true,true)
                sz = s(sz,OPENWIKI_IMAGELIBRARY & "(.*?)\""","images/$1""",true,true)

                sz = s(sz,"ow/skins/.*?/(.*?)\.css\""",OPENWIKI_ACTIVESKIN & "/css/$1.css""",true,true)
                sz = s(sz,"ow/skins/.*?/images/(.*?)\""",OPENWIKI_ACTIVESKIN & "/images/$1""",true,true)
        '                                        // Take out function links

                sz = s(sz,"(Attachments.*?\(\d\))","",true,true)
                sz = s(sz,"(<a class=\""functions\"".*?</a>)","",true,true)
                sz = s(sz,"by browsing, searching or an index","",true,true)

                ' Brute-force replacements
                sz = Replace(sz,oldattachmentsdir,newattachmentsdir)
                sz = Replace(sz,oldimagedir,newimagedir)

                vPageName=Replace(vPageName,"/","_") '        // Replace links with underscores

        '        // Write the pages to disk, overwriting any previous versions
                Set vFSO = Server.CreateObject("Scripting.FileSystemObject")
                Set objTextStream = vFSO.OpenTextFile(savedhtmldir & "\" & vPageName & ".html", 2, True)
                objTextStream.Write sz

        '        // Tidy up
                objTextStream.Close
                Set objTextStream = Nothing
                Set vFSO = Nothing
                If (Err.Number = 0) then SerialiseHTML=True
        End Function


        Public Function SerialiseXML(pXMLStr)
        On Error Resume Next
        Dim vFSO,objTextStream,sz,vPageName
        Dim savedxmldir,savedimagedir,savedicondir,savedcssdir,savedSkinDir,saveddocdir
        Dim newattachmentsdir,oldattachmentsdir,oldimagedir,newimagedir,mappedxmlDir
                vPageName=gPage
'               // DEBUGGING LINES START
'                if (gSerialisingInProgress = true) then
'                   RESPONSE.WRITE("<br />SerialiseXML(" & vPageName & ") called<br />")
'                   RESPONSE.FLUSH
'                 end if
'               // DEBUGGING LINES END
                SerialiseXML=False '        // Assume an error
                if (vPageName=OPENWIKI_UPNAME) then exit function
                If (OPENWIKI_ACTIVESKIN = "") then OPENWIKI_ACTIVESKIN="default"
                If NOT SkinExists then OPENWIKI_ACTIVESKIN="default"
        '        // Assign from parameters
                sz=pXMLStr
                savedxmldir = cWriteXMLFoldername
                mappedxmlDir = Server.MapPath(".") & "\" & savedxmldir
                savedimagedir = savedxmldir & "/images"
                savedicondir = savedimagedir & "/icons"
                saveddocdir = savedicondir & "/doc/"
                savedSkinDir = savedxmldir & "/" & OPENWIKI_ACTIVESKIN
                savedcssdir = savedSkinDir & "/css"

                newattachmentsdir = savedxmldir & "/attachments/"
                oldattachmentsdir = gServerRoot & OPENWIKI_UPLOADDIR
                newimagedir = savedimagedir
                oldimagedir = gServerRoot & "images/"



                sz=Replace(sz,gServerRoot & "/","")

        '                                        // Convert internal links
                sz=s(sz,"<ow:location>.*?</ow:location>","<ow:location>" & savedxmldir & "</ow:location>",true,true)

                sz=s(sz,"<ow:imagepath>.*?</ow:imagepath>","<ow:imagepath>" & savedimagedir & "</ow:imagepath>",true,true)
                sz=s(sz,"<ow:iconpath>.*?</ow:iconpath>","<ow:iconpath>" & savedicondir & "</ow:iconpath>",true,true)
                sz=s(sz,"<ow:skinpath>.*?</ow:skinpath>","<ow:skinpath>" & savedSkinDir & "</ow:skinpath>",true,true)
        '                                        // Concert internal links
                sz=s(sz,"'ow.asp\?p=(.*?)\&amp;.*?'","'" & cWriteXMLFoldername & "/$1.html'",true,true)
                sz=s(sz,"'ow.asp\?(.*?)\&amp;.*?'","'" & cWriteXMLFoldername & "/$1.html'",true,true)
                sz=s(sz,"'ow.asp\?(.*?)\'","'" & cWriteXMLFoldername & "/$1.html'",true,true)

        '                                        // Convert subpage references / to _
                sz=s(sz,"([\s\S])\%2F([\s\S])","$1_$2",true,true)
        '                                        // Convert image and icon folder references
                sz = s(sz,"ow/images/(.*?)\""","images/$1""",true,true)
                sz = s(sz,"ow/skins/(.*?)/(.*?)\""","css/$1/$2""",true,true)
                sz = s(sz,"icon=\'(.*?)\'","icon='" & saveddocdir & "$1.gif'",true,true)

                ' Brute-force replacements
                sz = Replace(sz,oldattachmentsdir,newattachmentsdir)
                sz = Replace(sz,oldimagedir,newimagedir)
                vPageName=Replace(vPageName,"/","_") '        // Replace links with underscores

        '        // Write the pages to disk, overwriting any previous versions
                Set vFSO = Server.CreateObject("Scripting.FileSystemObject")
                Set objTextStream = vFSO.OpenTextFile(mappedxmlDir & "\" & vPageName & ".xml", 2, True)
                objTextStream.Write sz
                objTextStream.Close
                Set objTextStream = Nothing
                Set vFSO = Nothing
                If (Err.Number = 0) then SerialiseXML=True
        End Function

        Public Function SavePageNameAsXML(pPageName)
                Dim saved_cWriteHTML,saved_gAction,saved_cWriteXML,vXmlStr,vPage
                SavePageNameAsXML = false
 '               // Init the PageBookmarks to empty
                gDefaultPageBookmarks=""
                gDefaultPageBookmarksHeading=""
                cEmbeddedMode = 0
                On Error GoTo 0
                ' // Preserve the 3 vars
                saved_cWriteHTML = cWriteHTML
                saved_cWriteXML = cWriteXML
                saved_gAction = gAction
                ' Set up for silent writing
                cWriteHTML = 0
                cWriteXML = 1
                cCacheXSL = 0
                ' Make sure the folders are initialised
                Call PrepareSerialiseFolders(cWriteXMLFoldername,false)
                ' Fetch the XML
                gPage=pPageName
                gRevision=0
                Set vPage=gNamespace.GetPageAndAttachments(gPage, gRevision, True, False)
                if (vPage.Text <> "") then
                                vXmlStr = vPage.ToXML(1)
                                gAction = "view"
                                gPage = pPageName
                                ' Transform and write the page to disk
                                Call gTransformer.Transform(vXmlStr)
                                If Err.Number = 0 then SavePageNameAsXML = true
                end if
                ' Tidy up
                cWriteHTML = saved_cWriteHTML
                cWriteXML = saved_cWriteXML
                gAction = saved_gAction
        End Function

        Public Function SavePageNameAsHTML(pPageName)
                Dim saved_cWriteHTML,saved_gAction,saved_cWriteXML,vXmlStr,vPage
                SavePageNameAsHTML = false
'               // Init the PageBookmarks to empty
                gDefaultPageBookmarks=""
                gDefaultPageBookmarksHeading=""
                cEmbeddedMode = 0
                On Error GoTo 0
                ' // Preserve the 3 vars
                saved_cWriteHTML = cWriteHTML
                saved_cWriteXML = cWriteXML
                saved_gAction = gAction
                ' Set up for silent writing
                cWriteHTML = 1
                cWriteXML = 0
                cCacheXSL = 0
                ' Make sure the folders are initialised
                Call PrepareSerialiseFolders(cWriteHTMLFoldername,false)
                ' Fetch the XML
                gPage=pPageName
                gRevision=0
                Set vPage=gNamespace.GetPageAndAttachments(gPage, gRevision, True, False)
                if (vPage.Text <> "") then
                                vXmlStr = vPage.ToXML(1)
                                gAction = "view"
                                gPage = pPageName
                                ' Transform and write the page to disk
                                Call gTransformer.Transform(vXmlStr)
                                If Err.Number = 0 then SavePageNameAsHTML = true
                end if
                ' Tidy up
                cWriteHTML = saved_cWriteHTML
                cWriteXML = saved_cWriteXML
                gAction = saved_gAction
        End Function

    Public Function TransformXmlStr(pXmlStr, pXslFilename)
        Dim vXmlStr
        vXmlStr = "<?xml version='1.0' encoding='" & OPENWIKI_ENCODING & "'?>" & vbCRLF _
                & gNamespace.ToXML(pXmlStr)

        If gAction = "xml" Or InStrRev(Request.QueryString, "&xml=1") > 0 Then
            If vIsIE Or gAction = "xml" Then
                Response.ContentType = "text/xml; charset:" & OPENWIKI_ENCODING & ";"
                Response.Write(vXmlStr)
                Response.End
            Else
                pXslFilename = "../common/xmldisplay.xsl"
            End If
        End If

        If Not vXmlDoc.loadXML(vXmlStr) Then
            Response.ContentType = "text/html; charset:" & OPENWIKI_ENCODING & ";"
            Response.Write("<html><body><b>Invalid XML document</b>:<br /><br />")
            Response.Write(vXmlDoc.parseError.reason & " line: " & vXmlDoc.parseError.Line & " col: " & vXmlDoc.parseError.linepos)
            Response.Write("<br /><br /><hr />")
            Response.Write("<pre>" & Replace(Server.HTMLEncode(vXmlStr), vbCRLF, "<br />") & "</pre>")
            Response.Write("</body></html>")
        Else
            LoadXSL(pXslFilename)
            vXslProc.input = vXmlDoc

                'Add parameters here (name/value)
            if cFullsearchHighlight = 1 then
                vXslProc.addParameter "FullsearchHighlight","1"
                vXslProc.addParameter "AllowBadges", cAllowBadge
                vXslProc.addParameter "AllowFlash", cAllowFlash
                vXslProc.addParameter "AllowImageLibrary", cAllowImageLibrary
                vXslProc.addParameter "AllowAttachments", cAllowAttachments
                vXslProc.addParameter "AllowShowFile", int(plugins.Item("Show File"))
                vXslProc.addParameter "InlineXml", int(plugins.Item ("Inline Xml"))
		
                vXslProc.addParameter "hido",trim(request.querystring("hido"))
                vXslProc.addParameter "hiterm",trim(request.querystring("hiterm"))
            end if
            If cShowGoogleAds then
                vXslProc.addParameter "google","yes"
            else
                vXslProc.addParameter "google","no"
            End If
            vXslProc.addParameter "adminpassword",gAdminPassword
            'Do the transform
            vXslProc.transform
            TransformXmlStr = vXslProc.output

    if (cWriteHTML  AND ( (gAction = "view") OR (gAction = "print") ) ) then
        Call PrepareSerialiseFolders(cWriteHTMLFoldername,false)
         SerialiseHTML(TransformXmlStr)
        if (gSerialisingInProgress = true) then Exit Function
    End If
    if (cWriteXML  AND ( (gAction = "view") OR (gAction = "print") ) ) then
        Call PrepareSerialiseFolders(cWriteXMLFoldername,false)
        SerialiseXML(vXmlStr)
        if (gSerialisingInProgress = true) then Exit Function
    End If

            WriteToScreen(TransformXmlStr)
        End If
    End Function

        Private Function WriteToScreen(pTransformXmlStr)
            If cEmbeddedMode = 0 Then
                If gAction = "edit" Then
                    Response.ContentType = "text/html; charset:" & OPENWIKI_ENCODING & ";"
                    Response.Expires = 0   ' expires in a minute
                Elseif gAction = "rss" Then
                    Response.ContentType = "text/xml; charset:" & OPENWIKI_ENCODING & ";"
                Else
                    Response.ContentType = "text/html; charset:" & OPENWIKI_ENCODING & ";"
                    Response.Expires = -1  ' expires now
                    Response.AddHeader "Cache-Control", "no-cache"
                End If
                Response.Write(pTransformXmlStr)
            End If
        End Function

End Class
%>