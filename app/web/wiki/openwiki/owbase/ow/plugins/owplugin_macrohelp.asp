<%
' // $Log: owplugin_macrohelp.asp,v $
' // Revision 1.4  2004/10/13 12:20:07  gbamber
' // Forced updates to make sure CVS reflects current work
' //
' // Revision 1.3  2004/08/12 16:35:29  gbamber
' // Fixed MSAccess incompatibility bug
' //
' // Revision 1.2  2004/08/05 19:05:49  gbamber
' // MacroHelp(?) now gives a sorted list
' //
' // Revision 1.1  2004/08/04 22:38:21  gbamber
' // Added MacroHelp plugin.  Working, but not fully tested!
' //
' **** ACTIVATION CODE ***
plugins.Add "Macro Help",0
' ************************


Function GetMacroHelpList(vParam)
    If plugins.Item("Macro Help") = 1 Then
           GetMacroHelpList=A_GetMacroHelpList(vParam)
    else
           GetMacroHelpList="<ow:error>Macro Help plugin is inactive</ow:error>"
    End If
End Function

Function A_GetMacroHelpList(vParam)
Dim s,vMacro
	Dim gMacroArray


       s = "<h4>Macro Help</h4>"
       If (vParam = "?") then
	'	// Get a sorted array of macro names
	gMacroArray=Split(gMacros, "|") '	// Assign to the array
	SingleSorter gMacroArray'	// Sort the array

      // DEBUGGING START
'       s="Disabled"
'       A_GetMacroHelpList = s
'       Exit Function
'      // DEBUGGING END

           s = s & "<ol>"
       ' // Get the full list
			For vMacro = 0 To UBound(gMacroArray) 
                s = s & "<li>" & GetMacroData(gMacroArray(vMacro)) & "</li>"
            Next
           s = s & "</ol>"
       Else
       ' // Fetch DB data on one macro
            s = s & GetMacroData(vParam)
       End If
       A_GetMacroHelpList = s
End Function

Private Function SQLUnFixup(TextIn)
  Dim temp
  temp = CStr(TextIn)
  temp = Replace(temp, "''", "'")
  temp = Replace(temp, "&", "&amp;")
  temp = Replace(temp, "<", "&lt;")
  temp = Replace(temp, ">", "&gt;")
  temp = Replace(temp, "/^", "^")

  SQLUnFixup = temp
End Function


Private Function GetMacroData(vMacroname)
On Error GoTo 0
Dim mConn,mRs,szSQL,temp,s,s1
     If (Trim(vMacroname)="") then
        GetMacroData="<ul><li>No macro name specified</li></ul>"
        Exit Function
     End If
    '    // Valid Parameter.  Query the database
    Set mConn = Server.CreateObject("ADODB.Connection")
    mConn.Open OPENWIKI_DB

    Set mRs = Server.CreateObject("ADODB.Recordset")
    If Instr(vMacroname,"?") > 0 then
       GetMacroData="<ul><li>Not yet implemented</li></ul>"
       Exit Function
    Else
        szSQL="SELECT * FROM openwiki_macrohelp WHERE macro_name LIKE '" & vMacroname & "';"

'	   DEBUGGING START
'       GetMacroData="Debugging Point"
'       Exit Function
'	   DEBUGGING END
        mRs.Open szSQL, mConn'  , adForwardOnly


        If mRs.EOF then
           GetMacroData="<ul><li>&lt;" & vMacroname & "&gt; - No data for this Macro</li></ul>"
           Exit Function
        Else
            s = ""
            Do While Not mRs.EOF
               s = s & "<ul>"


               ' // Name of Macro
               s = s & "<li><strong>&lt;" & mRs.Fields("macro_name")
               temp=CInt(mRs.Fields("macro_numparams"))
               If temp > 0 then s = s & "()"
               s = s & "&gt;</strong></li>"

               ' // Built-In
               s = s & "<ul><li>Uses Plugin?: "
               temp = CInt(mRs.Fields("macro_builtin"))
               if temp = 1 then
                  s = s & "No - native to " & OPENWIKI_TITLE
               else
                  s = s & "Yes. Plugin needs to be active."
               End If
               s = s & "</li></ul>"

               ' // Description
               s = s & "<ul><li>Description: <ul>"
               s = s & "<li>" & SQLUnFixup(mRs.Fields("macro_description")) & "</li>"
               s = s & "</ul></li></ul>"

               ' // Comments
               s = s & "<ul><li>Comments: <ul>"
               s = s & "<li>" & SQLUnFixup(mRs.Fields("macro_comment")) & "</li>"
               s = s & "</ul></li></ul>"

               ' // Parameters
               s = s & "<ul><li>Parameters: <ul>"

               temp=0 + CInt(mRs.Fields("macro_numparams"))
               If temp = 0 then
                  s = s & "<li>None</li>"
               else
                   If temp > 10 then '   // Optional parameters have 10 added to their number
                      temp = temp - 10
                      s = s & "<li>" & CStr(temp) & " (optional)</li>"
                   Else
                       s = s & "<li>" & CStr(temp) & " (required)</li>"
                   End If
                   if temp = 1 then
                      s = s & "<li>Parameter 1:" & SQLUnFixup(mRs.Fields("macro_param1")) & "</li>"
                   End if
                   if temp = 2 then
                      s = s & "<li>Parameter 1:" & SQLUnFixup(mRs.Fields("macro_param1")) & "</li>"
                      s = s & "<li>Parameter 2:" & SQLUnFixup(mRs.Fields("macro_param2")) & "</li>"
                   End if
                   if temp = 3 then
                      s = s & "<li>Parameter 1:" & SQLUnFixup(mRs.Fields("macro_param1")) & "</li>"
                      s = s & "<li>Parameter 2:" & SQLUnFixup(mRs.Fields("macro_param2")) & "</li>"
                      s = s & "<li>Parameter 3:" & SQLUnFixup(mRs.Fields("macro_param3")) & "</li>"
                   End if
               End If

               s = s & "</ul></li></ul>"

               mRs.MoveNext
               s = s & "</ul>"
            Loop
            GetMacroData=s
        End If
    End If


    '    // Tidy up
    set mConn = Nothing
    set mRs = Nothing
End Function

Sub SingleSorter( byRef arrArray )
    Dim row, j
    Dim StartingKeyValue, NewKeyValue, swap_pos

    For row = 0 To UBound( arrArray ) - 1
    'Take a snapshot of the first element
    'in the array because if there is a 
    'smaller value elsewhere in the array 
    'we'll need to do a swap.
        StartingKeyValue = arrArray ( row )
        NewKeyValue = arrArray ( row )
        swap_pos = row
	    	
        For j = row + 1 to UBound( arrArray )
        'Start inner loop.
            If arrArray ( j ) < NewKeyValue Then
            'This is now the lowest number - 
            'remember it's position.
                swap_pos = j
                NewKeyValue = arrArray ( j )
            End If
        Next
	    
        If swap_pos <> row Then
        'If we get here then we are about to do a swap
        'within the array.		
            arrArray ( swap_pos ) = StartingKeyValue
            arrArray ( row ) = NewKeyValue
        End If	
    Next
End Sub

%>