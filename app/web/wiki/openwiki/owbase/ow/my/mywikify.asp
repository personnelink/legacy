
<%

Sub MyInitLinkPatterns()

    ' add here any custom defined link patterns

    ' and/or change cq override the patterns defined by default in InitLinkPatterns.

End Sub

'Short description for the MyInit... functions:
'There function are called while the wikify patterns are build.
'You can change the most basic patterns ( MainPattern and Subpagepattern ) here by concating
'to the current linkpattern or replace the current linkpattern.
' "|" means for a new group of letters
' "+" means for an additional set of letters that must existing within the current word
' "*" means any kind of letter
' "\" is the escape character for special characters


Function MyInitMainLinkPattern( pLinkPattern, pUpperLetter, pLowerLetter, pAnyLetter ) 
	'Example ( wikifies all words beginning with 2 uppercase letters:
	'pLinkPattern = pLinkPattern & "|" & vUpperLetter & "+" & vUpperLetter & vAnyLetter & "*" 

	MyInitMainLinkPattern = pLinkPattern 
End Function 

Function MyInitSubPagePattern( pSubpagePattern, pUpperLetter, pLowerLetter, pAnyLetter )
	'Example:
'	pSubpagePattern= "\/" & vUpperLetter & vAnyLetter & "+" & vLowerLetter & vAnyLetter & "*" 

	MyInitSubPagePattern = pSubpagePattern 
End Function 


' Here you can define your own custom made Processing Instructions.
' See also http://openwiki.com/?HelpOnProcessingInstructions
Function MyWikifyProcessingInstructions(pText)

    ' example of dealing with a processing instruction
    If m(pText, "^#STOPWORDS\s+", False, False) Then
        ' Add every word following the #STOPWORDS PI to the gStopWords string
        ' All these words, when present in the current page, will NOT be hyperlinked.
        Dim vPos, vTemp
        vPos = InStr(pText, vbCR)
        If vPos > 0 Then
            vTemp = Trim(Mid(pText, 11, vPos - 11))
            If vTemp <> "" Then
                vTemp = s(vTemp, "\s+", "|", False, True)
                gStopWords = gStopWords & "|" & vTemp
            End If
            pText = Mid(pText, vPos + 1)
        End If
    End If

    ' process other processing instructions you'd like to create here


    MyWikifyProcessingInstructions = pText
End Function


Function MyMultiLineMarkupStart(pText)

    MyMultiLineMarkupStart = pText
End Function


Function MyMultiLineMarkupEnd(pText)

    MyMultiLineMarkupEnd = pText
End Function


Function MyLastMinuteChanges(pText)
    MyLastMinuteChanges = pText
End Function
' *****************************************************************************
' Example:
' Response.Write Highlight(myText, "someword", "<font color=red>", "</font>")
' HIGHLIGHT function will search text for a specific string
' When string is found it will be surrounded by supplied strings
'
' NOTE: Unfortunately Replace() function does not preserve the original case
' of the found string. This function does.
'
' Parameters:
' strText         - string to search in
' strFind        - string to look for
' strBefore        - string to insert before the strFind
' strAfter         - string to insert after the strFind
'
' Example:
' This will make all the instances of the word "the" bold
'
' Response.Write Highlight(strSomeText, "the", "<b>", "</b>")
'
Function Highlight(strText, strFind, strBefore, strAfter)
        Dim nPos
        Dim nLen
        Dim nLenAll

        nLen = Len(strFind)
        nLenAll = nLen + Len(strBefore) + Len(strAfter) + 1

        Highlight = strText

        If nLen > 0 And Len(Highlight) > 0 Then
                nPos = InStr(1, Highlight, strFind, 1)
                Do While nPos > 0
                        Highlight = Left(Highlight, nPos - 1) & _
                                strBefore & Mid(Highlight, nPos, nLen) & strAfter & _
                                Mid(Highlight, nPos + nLen)

                        nPos = InStr(nPos + nLenAll, Highlight, strFind, 1)
                Loop
        End If
End Function
'********************************************************************************

%>