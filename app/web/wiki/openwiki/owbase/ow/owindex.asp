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
'      $Source: /cvsroot/openwiki-ng/openwiking/owbase/ow/owindex.asp,v $
'    $Revision: 1.14 $
'      $Author: by1mmm $
' ---------------------------------------------------------------------------
'

Class IndexSchemes
    Private Sub Class_Initialize()
    End Sub

    Private Sub Class_Terminate()
    End Sub

        ' Calls GetRecentChangesEx with the TitlesOnly flag
        ' Centralized so GetRecentChanges calls GetRecentChangesEx since they were so similar
        '  to prevent someone from editing one and not the other.
    Public Function GetRecentChanges(pDays, pMaxNrOfChanges, pFilter, pShortVersion)
                Dim pPattern, pTitlesOnly, pIncludeTitles
                pPattern = ".*"
                pTitlesOnly = true
                pIncludeTitles = true
                GetRecentChanges = GetRecentChangesEx(pPattern, pTitlesOnly, pIncludeTitles, pDays, pMaxNrOfChanges, pFilter, pShortVersion)
        End Function

    ' Calls TitleSearch or FullSearchEx
        Public Function GetRecentChangesEx(pPattern, pTitlesOnly, pIncludeTitles, pDays, pMaxNrOfChanges, pFilter, pShortVersion)
        Dim vList, vCount, i, j, vResult, vElem, vChange, vTimestamp

        If pMaxNrOfChanges > 0 Then
            vTimestamp = Now() - pDays
            If pTitlesOnly Then 'For GetRecentChanges original
                    Set vList = gNamespace.TitleSearch(pPattern, pDays, pFilter, 1, 1)
            Else
                    Set vList = gNamespace.FullSearchEx(pPattern, pIncludeTitles, pDays, pFilter, 1, 1)
            End If
            vCount = vList.Count - 1
            For i = 0 To vCount
                Set vElem = vList.ElementAt(i)
                Set vChange = vElem.GetLastChange()
                If vChange.Timestamp > vTimestamp Then
                    vResult = vResult & vElem.ToXML(False)
                    j = j + 1
                    If j >= pMaxNrOfChanges Then
                        Exit For
                    End If
                End If
            Next
        End If
        GetRecentChangesEx = "<ow:recentchanges"
        If pFilter = 0 Or pFilter = 1 Then
            GetRecentChangesEx = GetRecentChangesEx & " majoredits='true'"
        Else
            GetRecentChangesEx = GetRecentChangesEx & " majoredits='false'"
        End If
        If pFilter = 0 Or pFilter = 2 Then
            GetRecentChangesEx = GetRecentChangesEx & " minoredits='true'"
        Else
            GetRecentChangesEx = GetRecentChangesEx & " minoredits='false'"
        End If
        If pShortVersion Then
            GetRecentChangesEx = GetRecentChangesEx & " short='true'"
        Else
            GetRecentChangesEx = GetRecentChangesEx & " short='false'"
        End If
        GetRecentChangesEx = GetRecentChangesEx & ">" & vResult & "</ow:recentchanges>"
    End Function



    Public Function GetCategorySearch(sCategoryNumber)
        Dim vList, i, vCount, vResult,iCategoryNumber,sCategoryText
        iCategoryNumber=0 + CInt(sCategoryNumber)
        sCategoryText=gCategoryArray(iCategoryNumber)
'                // Borrow the pDays parameter to use as a Category Number
        Set vList = gNamespace.TitleSearch("",iCategoryNumber , 0, 4, 0)
        vCount = vList.Count - 1
'        // DEBUGGING LINE
'        Response.Write("vCount=" & vCount)
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetCategorySearch = "<ow:categorysearch category='" & sCategoryText & "' pagecount='" & gNamespace.GetPageCount() & "'>" & vResult & "</ow:categorysearch>"
    End Function

'============added by 1mmm for tag
    Public Function GetTagSearch(stagname) 
        Dim vList, i, vCount, vResult,stagText
		Set vList = gNamespace.TagSearch(stagname,0)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetTagSearch = "<ow:tagsearch value='" & stagname & "'>" & vResult & "</ow:tagsearch>"
    End Function
'============end by 1mmm for tag

'        // TitleSearch(SearchFor,0,3,1,0) = Summary Search
    Public Function GetSummarySearch(pPattern)
        Dim vList, i, vCount, vResult,vElem, vChange, pSummary
        Set vList = gNamespace.TitleSearch(pPattern,0,3,1,0)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetSummarySearch = "<ow:summarysearch value='" & CDATAEncode(pPattern) & "' pagecount='" & gNamespace.GetPageCount() & "' truncate=""" & gTitlesearchTemp & """>" & vResult & "</ow:summarysearch>"
    End Function


    Public Function GetTitleSearch(pPattern)
        Dim vList, i, vCount, vResult
        Set vList = gNamespace.TitleSearch(pPattern, 0, 0, 0, 0)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetTitleSearch = "<ow:titlesearch value='" & CDATAEncode(pPattern) & "' pagecount='" & gNamespace.GetPageCount() & "' truncate=""" & gTitlesearchTemp & """>" & vResult & "</ow:titlesearch>"
    End Function

    Public Function GetFullSearch(pPattern, pIncludeTitles)
        Dim vList, i, vCount, vResult
        Set vList = gNamespace.FullSearch(pPattern, pIncludeTitles)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetFullSearch = "<ow:fullsearch value='" & CDATAEncode(pPattern) & "' pagecount='" & gNamespace.GetPageCount() & "' truncate=""" & gFullsearchTemp & """>" & vResult & "</ow:fullsearch>"
    End Function

    Public Function GetTextSearch(pPattern, pIncludeTitles)
        Dim vList, i, vCount, vResult
        Set vList = gNamespace.FullSearch(pPattern, pIncludeTitles)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetTextSearch = "<ow:textsearch value='" & CDATAEncode(pPattern) & "' pagecount='" & gNamespace.GetPageCount() & "' truncate=""" & gFullsearchTemp & """>" & vResult & "</ow:textsearch>"
    End Function

    Public Function GetRandomPage(pNrOfPages)
        Dim vList, i, vCount, vIndex, vResult
        Set vList = gNamespace.TitleSearch(".*", 0, 0, 0, 0)
        Randomize
        vCount = vList.Count - 1
        For i = 1 To pNrOfPages
            vIndex = Int(vCount * Rnd)
            vResult = vResult & vList.ElementAt(vIndex).ToXML(False)
        Next
        GetRandomPage = "<ow:randompages>" & vResult & "</ow:randompages>"
    End Function

    Public Function GetTemplates(pPattern)
        Dim vList, i, vCount, vResult
        Set vList = gNamespace.TitleSearch(pPattern, 0, 0, 0, 0)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetTemplates = "<ow:templates>" & vResult & "</ow:templates>"
    End Function

    Public Function GetTitleIndex()
        Dim vList, vCount, i, vResult
        Set vList = gNamespace.TitleSearch(".*", 0, 0, 0, 0)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetTitleIndex = "<ow:titleindex>" & vResult & "</ow:titleindex>"
    End Function

'        // START CATEGORY HITS
    Public Function GetCategoryIndex()
        Dim vList, vCount, i, vResult
        Set vList = gNamespace.TitleSearch(".*", 0, 0, 4, 0)
        vCount = vList.Count - 1
        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetCategoryIndex = "<ow:categoryindex>" & vResult & "</ow:categoryindex>"
    End Function
'        // END CATEGORY HITS

'        // START PAGE HITS
    Public Function GetTitleHitIndex(numResults)
        Dim vList, vCount, i, vResult
        Set vList = gNamespace.TitleSearch(".*", 0, 0, 3, 0)
        if (numResults=0 OR numResults > vList.Count) then
                        vCount = vList.Count - 1
                else
                        vCount = numResults - 1
                end if

        For i = 0 To vCount
            vResult = vResult & vList.ElementAt(i).ToXML(False)
        Next
        GetTitleHitIndex = "<ow:titlehitindex>" & vResult & "</ow:titlehitindex>"
    End Function
'        // END PAGE HITS

    ' This function is pure crap! really really bad!
    ' needs a totally different implementation
    ' either needs an NT service or something similar that runs daily to
    ' generate the meta-data, or keep track of this meta-data when saving
    ' a new page.
    ' Also generate meta-data about concepts like TwinPages, MetaWiki, etc.
    Public Function GetWordIndex()
        Dim vList, vCount, i, j, vElem, vTitle, vWords, vValues, vRegEx, vMatches, vMatch, vKeys, vResult
        Dim vLast, vLastIndex
        Set vWords  = New Vector
        Set vValues = New Vector
        Set vRegEx  = New RegExp
        vRegEx.IgnoreCase = False
        vRegEx.Global = True
        vRegEx.Pattern = "[A-Z\xc0-\xde]+[a-z\xdf-\xff]+"
        Set vList = gNamespace.TitleSearch(".*", 0, 0, 0, 0)
        vCount = vList.Count
        For i = 0 To vCount - 1
            Set vElem = vList.ElementAt(i)
            vTitle = PrettyWikiLink(vElem.Name)
            Set vMatches = vRegEx.Execute(vTitle)
            For Each vMatch In vMatches
                vWords.Push(vMatch.Value)
                vValues.Push("<ow:word value='" & CDATAEncode(vMatch.Value) & "'>" & vElem.ToXML(False) & "</ow:word>")
            Next
			If Response.IsClientConnected = False then Exit Function
        Next

        vCount = vWords.Count - 1
        For i = 0 To vCount
            vLast = "\xff\xff\xff\xff\xff"
            vLastIndex = 0
            For j = 0 To vCount
                If vWords.ElementAt(j) < vLast Then
                    vLast = vWords.ElementAt(j)
                    vLastIndex = j
					If Response.IsClientConnected = False then Exit Function
                End If
            Next
            vWords.SetElementAt vLastIndex, "\xff\xff\xff\xff\xff"
            vResult = vResult & vValues.ElementAt(vLastIndex)
        Next

        Set vWords  = Nothing
        Set vValues = Nothing
        Set vRegEx  = Nothing
        GetWordIndex = "<ow:wordindex>" & vResult & "</ow:wordindex>"
    End Function

End Class
%>