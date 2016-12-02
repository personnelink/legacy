    <td width="180" align="center" valign="top"><% CALL DisplaysmallCalendar(sMonth, iYear) %>
                  <form  method="post" action="index.asp">
                    <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr align="center"> 
                        <td> <select name="month" class="form">
                           <% For u = 1 To 12 %>
                           <option value="<%=u%>"<% If u = iMonth Then %> selected<% End If %>>
						   <%=Left(NameFromMonth(u),3)%></option>
                           <% Next %>
                          </select> </td>
                        <td> <select name="year" class="form">
						<% For y = 2003 To 2050 %>
                            <option <% If y = iYear then %> selected <% End if %>><% = y %></option>
							<% Next %>
                             </select> </td>
                        <td> <input type="submit" name="Submit" value="<% = strLangDateGo %>" class="form"> 
                        </td>
                      </tr>
                    </table>
                  </form>
                  <a href="index.asp?month=<%=Month(now)%>&year=<%=Year(now)%>" ><% = strLangCurrentMonth %></a><br>
      <br>
      <br>
      <br>
      <a href="http://www.uapplication.com" target="_blank"><img src="immagini/powered.gif" alt="uapplication.com" border="0"></a> 
	</td>