<%
session("add_css") = "./checkHistory.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
 %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<script type="text/javascript" src="/include/js/whoseHere.js"></script>


<!-- #include file='checkHistory.doStuff.asp' -->

<%=decorateTop("AccountActivity", "marLRB10", "Check History")%>
<% do while not rsCheckHistory.eof
	GetCheck %>

<table class="check"><tr><th></th>

<th>Details</th></tr>
<tr><td>
<table class="check">
<tr><td colspan=5></td></tr>
<tr><th class="LastnameFirst alignL" colspan=2>Employee</th><td colspan=2></td><th>Adds/Deds</th></tr>
<tr><td class="LastnameFirst" colspan=2><%=LastnameFirst%></td><td colspan=3></td></tr>
<tr><td><%=EmployeeNumber%></td><td><%=TaxJurisdiction%></td><td colspan=3></td></tr>
<tr><th>Gross:</th><td><%=GrossPay%></td><td>&nbsp;</td><th>Net:</th><td><%=NetPay%></td></tr>
<tr><th>Ck #</th><td><%=CheckNumber%></td><td><%=CheckDate%></td><th>Pay#:</th><td><%=PayNumber%></td></tr>
</table></td><td><table class="check">
<tr><th>Reg<br />Hrs</th><th>OT/<br />Hrs/</th><th>DT<br />Hrs/</th><th>Reg<br />Pay/</th><th>OT<br />Pay/</th><th>DT<br />Pay/</th><th>Fed<br />With/</th><th>St<br />With/</th><th>SS<br />With/</th><th>Med<br />With/</th></tr>

<tr><th>A/K/U</th><th>B/L/V</th><th>C/M/W</th><th>D/N/X</th><th>E/O/Y</th><th>F/P/Z</th><th>G/Q</th><th>H/R</th><th>I/S</th><th>J/T</th></tr>
<tr><td><%=HoursBucket1%></td><td><%=HoursBucket2%></td><td><%=HoursBucket3%></td><td><%=Type1%></td><td><%=Type2%></td><td><%=Type3%></td><td><%=FedTax%></td><td><%=StateTax%></td><td><%=SSTax%></td><td><%=MediTax%></td></tr>
<tr><td><%=TypeA%></td><td><%=TypeB%></td><td><%=TypeC%></td><td><%=TypeD%></td><td><%=TypeE%></td><td><%=TypeF%></td><td><%=TypeG%></td><td><%=TypeH%></td><td><%=TypeI%></td><td><%=TypeJ%></td></tr>
<tr><td><%=TypeK%></td><td><%=TypeL%></td><td><%=TypeM%></td><td><%=TypeN%></td><td><%=TypeO%></td><td><%=TypeP%></td><td><%=TypeQ%></td><td><%=TypeR%></td><td><%=TypeS%></td><td><%=TypeT%></td></tr>
<tr><td><%=TypeU%></td><td><%=TypeV%></td><td><%=TypeW%></td><td><%=TypeX%></td><td><%=TypeY%></td><td><%=TypeZ%></td><td colspan=4></td></tr>
</table></td></tr></table>

<% rsCheckHistory.movenext
loop %>

<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
