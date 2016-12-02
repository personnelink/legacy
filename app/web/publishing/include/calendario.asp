<%
Function NameFromMonth(iMonth)
select case cint(iMonth)
case 1
s = strLangJan
case 2
s = strLangFeb
case 3
s = strLangMar
case 4
s = strLangApr
case 5
s = strLangMay
case 6
s = strLangJun
case 7
s = strLangJul
case 8
s = strLangAug
case 9 
s = strLangSep
case 10
s = strLangOct
case 11
s = strLangNov
case 12
s = strLangDec
end select
NameFromMonth = s
End Function

Function LastDay(testYear, testMonth)
    LastDay = Day(DateSerial(testYear, testMonth + 1, 0))
End Function


Function GetPrevMonth(iThisMonth,iThisYear)
GetPrevMonth=month(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetPrevMonthYear(iThisMonth,iThisYear)
GetPrevMonthYear=Year(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetNextMonth(iThisMonth,iThisYear)
GetNextMonth=month(dateserial(iThisYear,iThisMonth+1,1))
End Function

Function GetNextMonthYear(iThisMonth,iThisYear)
GetNextMonthYear=year(dateserial(iThisYear,iThisMonth+1,1))
End Function

Sub DisplaysmallCalendar(sMonth, iYear)
        Response.write ("<table border='0' CELLPADDING=2 CELLSPACING=0 align='center' width='130'><tr><td height=""16"" align='right' width='33%'>")
		Response.Write ("<a href='index.asp?month=" & GetPrevMonth(iMonth,iYear) & "&year=" & GetPrevMonthYear(iMonth,iYear) & "' title='"& strLangMonthPrev &"'><img src='immagini/frecciasx.gif' border='0'><img src='immagini/frecciasx.gif' border='0'></a>&nbsp;&nbsp;</td><td align='center' width='34%'><font class='green'><b>")
		Response.Write ( Ucase(sMonth) & "&nbsp;" & iYear & "</b></font></td><td width='33%'>&nbsp;&nbsp;" )
		Response.Write ("<a href='index.asp?month=" & GetNextMonth(iMonth,iYear) & "&year=" & GetNextMonthYear(iMonth,iYear) & "' title='"& strLangMonthNext &"'><img src='immagini/freccia.gif' border='0'><img src='immagini/freccia.gif' border='0'></a></td></tr></table>")
        Response.write ("<table border='0' CELLPADDING=2 CELLSPACING=0 align='center' width='130'><tr align='center'><td>" & strLangSun & "</td>")
        Response.write ("<td>" & strLangMon & "</td>")
        Response.write ("<td>" & strLangTue & "</td>")
        Response.write ("<td>" & strLangWed & "</td>")
        Response.write ("<td>" & strLangThu & "</td>")
        Response.write ("<td>" & strLangFri & "</td>")
        Response.write ("<td>" & strLangSat & "</td></tr>")
        Response.write ("<tr><td colspan=""7""><div class='hrgreen'><img src='immagini/spacer.gif'></div></td></tr>")

          i = 0
          dDay = DateSerial(iYear,iMonth,1)
          iMonth = Month(dDay)
          iYear = Year(dDay)
          iLastDay = LastDay(iYear, iMonth)
          iFirstDay=  Weekday(dDay)
          iLastDay = iFirstDay + iLastDay -1

          do while i<= iLastDay
			if i <> iLastDay then
			Response.Write ("<tr>")
			else
			exit do
			end if
			for j=1 to 7
												
				if (j < iFirstDay and i = 0) or (i + j > iLastDay)  then
					 
					Response.Write ("<td valign='top'></td>")
				else
					k =  k + 1
					giorno_cal = Right(CStr(100+k), 2)
					mese_cal = Right(CStr(100+iMonth), 2)
					strSQL = "SELECT blog.* FROM blog  WHERE giorno = '" & giorno_cal & "' AND mese = '" & mese_cal & "' AND anno = '" & iYear & "'"
					set rs_calendario = adoCon.Execute(strSQL) 
					if rs_calendario.eof then
					    if (k = Day(now)) and (iMonth = Month(now)) and (iYear = Year(now)) then
						sEvent = "<div class='giornocorrente'>" &  k & " </div>"
						else
						sEvent =  k 
						end if
					else 
					    if (k = Day(now)) and (iMonth = Month(now)) and (iYear = Year(now)) then
						sEvent = "<div class='back'><A HREF = 'index.asp?giorno=" & giorno_cal & "&month=" & mese_cal & "&year=" & iYear & "' title='" & strLangAltday & "'>" & k & "</A></div>"
						else
						sEvent = "<div class='back2'><A HREF = 'index.asp?giorno=" & giorno_cal & "&month=" & mese_cal & "&year=" & iYear & "' title='" & strLangAltday & "'>" & k & "</A></div>"
						end if
					End If	
					Response.Write ("<td valign='top' align='center'>")
					Response.write sEvent
					Response.Write ("</td>")
				end if
								
			next
			i=i+7
			
          loop
          Response.Write ("</tr>")
rs_calendario.close
set rs_calendario = nothing
Response.Write ("</table><br>")
end sub
%>