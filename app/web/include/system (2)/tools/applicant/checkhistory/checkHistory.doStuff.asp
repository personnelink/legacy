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

dim LastnameFirst, EmployeeNumber, TaxJurisdiction, GrossPay, CheckDate, CheckNumber, PayNumber, NetPay
dim HoursBucket1, HoursBucket2, HoursBucket3, Type1, Type2, Type3, FedTax, StateTax, SSTax, MediTax
dim TypeA, TypeB, TypeC, TypeD, TypeE, TypeF, TypeG, TypeH, TypeI, TypeJ, TypeK, TypeL, TypeM, TypeN
dim TypeO, TypeP, TypeQ, TypeR, TypeS, TypeT, TypeU, TypeV, TypeW, TypeX, TypeY, TypeZ

sub GetCheck()

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
	If FedTax < 0 then
		FedTax = -TwoDecimals(FedTax*-1)
	else
		FedTax = TwoDecimals(FedTax)
	end if
	
	StateTax = TwoDecimals(rsCheckHistory("StateTax"))		
	If StateTax < 0 then
		StateTax = -TwoDecimals(StateTax*-1)
	else
		StateTax = TwoDecimals(StateTax)
	end if
		
	SSTax = rsCheckHistory("SSTax")
	If SSTax < 0 then
		SSTax = -TwoDecimals(SSTax*-1)
	else
		SSTax = TwoDecimals(SSTax)
	end if
	
	MediTax = rsCheckHistory("MediTax")
	If MediTax < 0 then
		MediTax = -TwoDecimals(MediTax*-1)
	else
		MediTax = TwoDecimals(MediTax)
	end if
	
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
	
end sub

%>