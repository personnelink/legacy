<%
session("add_css") = "./checkHistory.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff
 %>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/js/whoseHere.js"></script>
<%
dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 365) 
end if

toDate = Request.QueryString("toDate") 
if isDate(toDate) = false then 
	toDate = request.form("toDate") 
	if isDate(toDate) = false then toDate = CStr(Date() + 1)
end if

dim where, where_friendly, who, who_check
where_friendly = request.QueryString("where")
where = getTempsDSN(where_friendly)
who = request.QueryString("who")
if IsNumeric(who) then who = cdbl(who)

dim getCheckHistory, rsCheckHistory
set getCheckHistory = server.CreateObject("adodb.command")
with getCheckHistory
	.ActiveConnection = dsnLessTemps(where)
	.CommandText = "SELECT [PR3MSTR].[EmployeeNumber], [Applicants].[LastnameFirst], [PR3MSTR].[TaxJurisdiction], " & _
					"[CheckHistory].[GrossPay], [CheckHistory].[NetPay], [CheckHistory].[CheckNumber], [CheckHistory].[CheckDate], " & _
					"[CheckHistory].[HoursBucket1], [CheckHistory].[TypeA], [CheckHistory].[TypeK], [CheckHistory].[TypeU], " & _
					"[CheckHistory].[HoursBucket2], [CheckHistory].[TypeB], [CheckHistory].[TypeL], [CheckHistory].[TypeV], " & _
					"[CheckHistory].[HoursBucket3], [CheckHistory].[TypeC], [CheckHistory].[TypeM], [CheckHistory].[TypeW], " & _
					"[CheckHistory].[Type1], [CheckHistory].[TypeD], [CheckHistory].[TypeN], [CheckHistory].[TypeX], " & _
					"[CheckHistory].[Type2], [CheckHistory].[TypeE], [CheckHistory].[TypeO], [CheckHistory].[TypeY], " & _
					"[CheckHistory].[Type3], [CheckHistory].[TypeF], [CheckHistory].[TypeP], [CheckHistory].[TypeZ], " & _ 
					"[CheckHistory].[FedTax], [CheckHistory].[TypeG], [CheckHistory].[TypeQ], [CheckHistory].[StateTax], " & _
					"[CheckHistory].[TypeH], [CheckHistory].[TypeR], [CheckHistory].[SSTax], [CheckHistory].[TypeI], " &_
					"[CheckHistory].[TypeS], [CheckHistory].[MediTax], [CheckHistory].[TypeJ], [CheckHistory].[TypeT], " & _
					"[CheckHistory].[OtherAddsDeducts], [CheckHistory].[PayNumber], [Applicants].[Address], [Applicants].[City], " & _
					"[Applicants].[State], [Applicants].[Zip], [Applicants].[SSNumber], [PR3MSTR].[Birthdate], [PR3MSTR].[Sex], " & _
					"[PR3MSTR].[Race], [Applicants].[Telephone], [PR3MSTR].[MaritalStatus], [PR3MSTR].[ActivityStatus], " & _
					"[PR3MSTR].[FedExemptions], [PR3MSTR].[StateExemptions], [PR3MSTR].[Location], [PR3MSTR].[Department], " & _
					"[PR3MSTR].[DateHired], [PR3MSTR].[DateTerminated], [PR3MSTR].[DateLastRaise], [PR3MSTR].[PayPeriod], " &_
					"[PR3MSTR].[FedTaxPak], [PR3MSTR].[StateTaxPak], [PR3MSTR].[PayType], [PR3MSTR].[FixedFederalTax], " &_
					"[PR3MSTR].[FixedStateTax], [PR3MSTR].[SSTaxPak], [PR3MSTR].[MediTaxPak] " &_
					"FROM ([CheckHistory] [CheckHistory] " &_
					"LEFT OUTER JOIN [Applicants] [Applicants] ON [CheckHistory].[ApplicantId]=[Applicants].[ApplicantID]) " &_
					"LEFT OUTER JOIN [PR3MSTR] [PR3MSTR] ON [Applicants].[EmployeeNumber]=[PR3MSTR].[EmployeeNumber] " &_
					"WHERE [CheckHistory].[ApplicantId]=" & who & " " &_
					"ORDER BY [Applicants].[LastnameFirst], [CheckHistory].[CheckDate] DESC "
	.prepared = true
end with
set rsCheckHistory = getCheckHistory.Execute

response.write decorateTop("AccountActivity", "marLRB10", "Check History")

dim LastnameFirst, EmployeeNumber, TaxJurisdiction, GrossPay, CheckDate, CheckNumber, PayNumber, NetPay
dim HoursBucket1, HoursBucket2, HoursBucket3, Type1, Type2, Type3, FedTax, StateTax, SSTax, MediTax
dim TypeA, TypeB, TypeC, TypeD, TypeE, TypeF, TypeG, TypeH, TypeI, TypeJ, TypeK, TypeL, TypeM, TypeN
dim TypeO, TypeP, TypeQ, TypeR, TypeS, TypeT, TypeU, TypeV, TypeW, TypeX, TypeY, TypeZ

do while not rsCheckHistory.eof
	LastnameFirst = rsCheckHistory("LastnameFirst")
	EmployeeNumber = rsCheckHistory("EmployeeNumber")
	TaxJurisdiction = rsCheckHistory("TaxJurisdiction")
	GrossPay = "$" & TwoDecimals(rsCheckHistory("GrossPay"))
	CheckNumber = rsCheckHistory("CheckNumber")
	CheckDate = rsCheckHistory("CheckDate")
	PayNumber = rsCheckHistory("PayNumber")
	NetPay = "$" & TwoDecimals(rsCheckHistory("NetPay"))
	
	HoursBucket1 = TwoDecimals(rsCheckHistory("HoursBucket1"))
	HoursBucket2 = TwoDecimals(rsCheckHistory("HoursBucket2"))
	HoursBucket3 = TwoDecimals(rsCheckHistory("HoursBucket3"))
	Type1 = TwoDecimals(rsCheckHistory("Type1"))
	Type2 = TwoDecimals(rsCheckHistory("Type2"))
	Type3 = TwoDecimals(rsCheckHistory("Type3"))
	FedTax = TwoDecimals(rsCheckHistory("FedTax"))
	StateTax = TwoDecimals(rsCheckHistory("StateTax"))
	SSTax = TwoDecimals(rsCheckHistory("SSTax"))
	MediTax = TwoDecimals(rsCheckHistory("MediTax"))
	TypeB = TwoDecimals(rsCheckHistory("TypeB"))
	TypeC = TwoDecimals(rsCheckHistory("TypeC"))
	TypeD = TwoDecimals(rsCheckHistory("TypeD"))
	TypeE = TwoDecimals(rsCheckHistory("TypeE"))
	TypeF = TwoDecimals(rsCheckHistory("TypeF"))
	TypeG = TwoDecimals(rsCheckHistory("TypeF"))
	TypeH = TwoDecimals(rsCheckHistory("TypeH"))
	TypeI = TwoDecimals(rsCheckHistory("TypeI"))
	TypeJ = TwoDecimals(rsCheckHistory("TypeJ"))
	TypeK = TwoDecimals(rsCheckHistory("TypeK"))
	TypeL = TwoDecimals(rsCheckHistory("TypeL"))
	TypeM = TwoDecimals(rsCheckHistory("TypeM"))
	TypeN = TwoDecimals(rsCheckHistory("TypeN"))
	TypeO = TwoDecimals(rsCheckHistory("TypeO"))
	TypeP = TwoDecimals(rsCheckHistory("TypeP"))
	TypeQ = TwoDecimals(rsCheckHistory("TypeQ"))
	TypeR = TwoDecimals(rsCheckHistory("TypeR"))
	TypeS = TwoDecimals(rsCheckHistory("TypeS"))
	TypeT = TwoDecimals(rsCheckHistory("TypeT"))
	TypeU = TwoDecimals(rsCheckHistory("TypeU"))
	TypeV = TwoDecimals(rsCheckHistory("TypeV"))
	TypeW = TwoDecimals(rsCheckHistory("TypeW"))
	TypeX = TwoDecimals(rsCheckHistory("TypeX"))
	TypeY = TwoDecimals(rsCheckHistory("TypeY"))
	TypeZ = TwoDecimals(rsCheckHistory("TypeZ"))
%>
<table><tr><th>Employee</th>

<th>Details</th></tr>
<tr><td>
<table>
<tr><td colspan=5></td></tr>
<tr><td colspan=4></td><th>Adds/Deds</th></tr>
<tr><td colspan=2><%=LastnameFirst%></td><td colspan=3></td></tr>
<tr><td><%=EmployeeNumber%></td><td><%=TaxJurisdiction%></td><td colspan=3></td></tr>
<tr><th>Gross:</th><td><%=GrossPay%></td><td>&nbsp;</td><th>Net</th><td><%=NetPay%></td></tr>
<tr><th>Check #</th><td><%=CheckNumber%></td><td><%=CheckDate%></td><th>Pay#:</th><td><%=PayNumber%></td></tr>
</table></td><td><table>
<tr><td>RegHrs</td><td>OTHrs</td><td>DTHrs</td><td>RegPay</td><td>OTPay</td><td>DTPay</td><td>FedWith</td><td>StWith</td><td>SS With</td><td>MedWith</td></tr>

<tr><td>A/K/U</td><td>B/L/V</td><td>C/M/W</td><td>D/N/X</td><td>E/O/Y</td><td>F/P/Z</td><td>G/Q</td><td>H/R</td><td>I/S</td><td>J/T</td></tr>
<tr><td><%=HoursBucket1%></td><td><%=HoursBucket2%></td><td><%=HoursBucket3%></td><td><%=Type1%></td><td><%=Type2%></td><td><%=Type3%></td><td><%=FedTax%></td><td><%=StateTax%></td><td><%=SSTax%></td><td><%=MediTax%></td></tr>
<tr><td><%=TypeA%></td><td><%=TypeB%></td><td><%=TypeC%></td><td><%=TypeD%></td><td><%=TypeE%></td><td><%=TypeF%></td><td><%=TypeG%></td><td><%=TypeH%></td><td><%=TypeI%></td><td><%=TypeJ%></td></tr>
<tr><td><%=TypeK%></td><td><%=TypeL%></td><td><%=TypeM%></td><td><%=TypeN%></td><td><%=TypeO%></td><td><%=TypeP%></td><td><%=TypeQ%></td><td><%=TypeR%></td><td><%=TypeS%></td><td><%=TypeT%></td></tr>
<tr><td><%=TypeU%></td><td><%=TypeV%></td><td><%=TypeW%></td><td><%=TypeX%></td><td><%=TypeY%></td><td><%=TypeZ%></td><td colspan=4></td></tr>
</table></td></tr></table>
<%
	rsCheckHistory.movenext
loop
%>
<%=decorateBottom()%><%
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
