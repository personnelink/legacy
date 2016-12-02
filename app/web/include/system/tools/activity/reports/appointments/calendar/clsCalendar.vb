<%
Class Calendar

Private cShowDate
Private cValue
Private cBorder
Private cMonth
Private cYear
Private arrMonths(12)
Private cFonts
Private cFontSize
Private cShowNav
Private cShowForm

Private Sub  Class_Initialize()
   cBorder = True
'    arrMonths(1) = "January"
'    arrMonths(2) = "February"
'    arrMonths(3) = "March"
'    arrMonths(4) = "April"
'    arrMonths(5) = "May"
'    arrMonths(6) = "June"
'    arrMonths(7) = "July"
'    arrMonths(8) = "August"
'    arrMonths(9) = "September"
'    arrMonths(10) = "October"
'    arrMonths(11) = "November"
'    arrMonths(12) = "December"
   arrMonths(1) = "Jan"
   arrMonths(2) = "Feb"
   arrMonths(3) = "Mar"
   arrMonths(4) = "Apr"
   arrMonths(5) = "May"
   arrMonths(6) = "Jun"
   arrMonths(7) = "Jul"
   arrMonths(8) = "Aug"
   arrMonths(9) = "Sep"
   arrMonths(10) = "Oct"
   arrMonths(11) = "Nov"
   arrMonths(12) = "Dec"

   cValue = Now
   cMonth = Month(Now)
   cYear = Year(Now)
   cFonts = "Verdana"
   cFontSize = 2
   cShowNav = False
   cShowForm = False
   cShowDate = False
End Sub

Private Sub Class_Terminate()

End Sub


Public Property Let Border(byRef uBorder)
   cBorder = uBorder
End Property

Public Property Get Border()
   Border = cBorder
End Property


Public Property Get Value()
   Value = cValue
End Property

Public Property Let Value(byRef uValue)
   cValue = uValue
   cMonth = Month(uValue)
   cYear = Year(uValue)
End Property


Public Property Let CalMonth(byRef uMonth)
   cMonth = uMonth
End Property

Public Property Get CalMonth()
   CalMonth = cMonth
End Property


Public Property Let CalYear(byRef uYear)
   cYear = uYear
End Property

Public Property Get CalYear()
   CalYear = cYear
End Property


Public Property Let Fonts(byRef uFonts)
   cFonts = uFonts
End Property

Public Property Get Fonts()
   Fonts = cFonts
End Property


Public Property Let FontSize(byRef uFontSize)
   cFontSize = uFontSize
End Property

Public Property Get FontSize()
   FontSize = cFontSize
End Property

Public Property Let ShowNav(byRef uShowNav)
   cShowNav = uShowNav
End Property

Public Property Get ShowNav()
   ShowNav = cShowNav
End Property


Public Property Let ShowForm(byRef uShowForm)
   cShowForm = uShowForm
End Property

Public Property Get ShowForm()
   ShowForm = cShowForm
End Property


Public Property Let ShowDate(byRef uShowDate)
   cShowDate = uShowDate
End Property


Public Sub Display
   If cShowNav or cShowForm Then

       Select Case request("CalAction")

       Case "back"
           cYear = request("currYear")
           If request("currMonth") < 1 Then
               cMonth = 12
               cYear = request("currYear") - 1
           Else
               cMonth = request("currMonth")
           End If
       Case "forward"
   
           cYear = request("currYear")
           If request("currMonth") > 12 Then
               cMonth = 1
               cYear = request("currYear") + 1
           Else
               cMonth = request("currMonth")
           End If
       Case "goto"
       
           cMonth = request("currMonth")
           If request("currYear") <> "" Then
               cYear = Int(request("currYear"))
           End IF

       End Select
   End If


   cDay = Weekday(arrMonths(cMonth) & "/" & 1 & "/" & cYear)

   Days = DaysInMonth()
   If cBorder Then%>
       <table border="0" cellpadding=0 bgcolor="#000000">
       <tr><td bgcolor="#FFFFFF">
   <%End If%>
   <table border="0" cellspacing=1 cellpadding=1>
     <tr>

   <%If cShowNav Then%>
     
       <td align="center" bgcolor="#666666"><font color="#FFFFFF" size=1 face="<%=cFonts%>"><a href="<%= Request.ServerVariables("SCRIPT_NAME") %>?CalAction=back&currMonth=<%=cMonth - 1%>&currYear=<%=cYear%>">««</a></font></td>
       <td colspan="5"align="center" bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b><%=arrMonths(cMonth) & " " & cYear%></b></font></td>
   <td align="center" bgcolor="#666666"><font color="#FFFFFF" size=1 face="<%=cFonts%>"><a href="<%= Request.ServerVariables("SCRIPT_NAME") %>?CalAction=forward&currMonth=<%=cMonth + 1%>&currYear=<%=cYear%>">»»</a></font></td>

   <%Else%>
       <td colspan="7"align="center" bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b><%=arrMonths(cMonth) & " " & cYear%></b></font></td>

   <%End If%>

     </tr>
       <tr>
       <td align="center" width=25 bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b>S</b></font></td>
       <td align="center" width=25 bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b>M</b></font></td>
       <td align="center" width=25 bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b>T</b></font></td>
       <td align="center" width=25 bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b>W</b></font></td>
       <td align="center" width=25 bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b>Th</b></font></td>
       <td align="center" width=25 bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b>F</b></font></td>
       <td align="center" width=25 bgcolor="#666666"><font color="#FFFFFF" size=<%=cFontSize%> face="<%=cFonts%>"><b>S</b></font></td>
     </tr>
     <tr>
       <%i = 1
       For j = 1 to cDay - 1%>
           <td align="center" bgcolor="#999999"></td>
           <%If i > 6 Then
               response.write("</tr><tr>")
               i = 0
           End If
           i = i + 1
       Next
       For j = 1 to Days%>
           <td align="center" bgcolor="#999999"><font color="#000000" size=<%=cFontSize%> face="<%=cFonts%>"><b><%=j%></b></font></td>
           <%If i > 6 And j <= Days - 1 Then
               response.write("</tr><tr>")
               i = 0
           End If
           i = i + 1
       Next
       If i > 1 Then
           For m = i to 7%>
               <td align="center" bgcolor="#999999"></td>
           <%Next
       End IF%>
     </tr>
   </table>
   <%If cBorder Then%>
       </td></tr>
       </table>
   <%End If
   If cShowForm Then BottomForm
End Sub


Private Sub BottomForm%>
   <table border="0" cellspacing=1 cellpadding=1 width=200>
   <form method="GET" action="<%= Request.ServerVariables("SCRIPT_NAME") %>">
   <tr>
   <td align="right" width="25%"><font color="#000000" size=<%=cFontSize%> face="<%=cFonts%>"><b>Month</b></font></td>
   <td><select name="currMonth">
   <%For i = 1 to 12%>
   <option value=<%=i%><%If i = Int(cMonth) Then response.write " Selected"%>><%=arrMonths(i)%></option>
   <%Next%>
   </select></td>
   <td align="right" width="25%"><font color="#000000" size=<%=cFontSize%> face="<%=cFonts%>"><b>Year</b></font></td>
   <td><input type="text" name="currYear" maxlength=4 size=4  value="<%=cYear%>"></td>
   </tr>
   <tr><td colspan=4 align="right"><input type="submit" value="GO"></td></tr>
   <input type="hidden" name="calAction" value="goto">
   </form>
   </table>
<%End Sub


Private Function DaysInMonth()
   Select Case cMonth
       Case 1,3,5,7,8,10,12
           DaysInMonth = 31
       Case 4,5,6,9,11
           DaysInMonth = 30
       Case 2
           If cYear Mod 4 Then
               DaysInMonth = 28
           Else
               DaysInMonth = 29
           End If
   Case Else
       Exit Function
   End Select
End Function

End Class


%>
