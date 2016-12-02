<%Option Explicit%>
<%
session("add_css") = "submitapplication.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff

dim debug_mode
	select case request.querystring("debug")
	case "1"
	debug_mode = true
	end select

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%

Dim	JobOrderNumber
Dim	OrderDate
Dim	TimeRecieved
Dim	TakenBy
Dim	ProposalDate
Dim	CustomerCode
Dim	NewClientY
Dim	NewClientN
Dim	CorporationY
Dim	IndividualY
Dim	CompanyName
Dim	OrderPlacer
Dim	CompanyPhone
Dim	CompanyFax
Dim	CompanyAddress
Dim	CompanyCityLine
Dim	SiteDirections
Dim	CompanyBillingAddress
Dim	CompanyEIN_SSN
Dim	CompanyBankReference
Dim	CompanySupplierReference
Dim	CreditCheckY
Dim	CreditApprovedY
Dim	CreditLimit
Dim	CreditComments
Dim	BusinessType
Dim	EmployeeType
Dim	NumofEmployees
Dim	DutiesandActions
Dim	SkillsRequired
Dim	SoftKnowReq
Dim	EquipmentUsed
Dim	ToolsUsed
Dim	ToolsRequired
Dim	PhysicalTasks
Dim	PPOE
Dim	RepeatMotion
Dim	WeightLift
Dim	BondingRequired
Dim	DriversLicence
Dim	CDL
Dim	WorkCompRate
Dim	WorkCompCode
Dim	SafetyClothingY
Dim SafetyClothingDetail 
Dim	HardhatY
Dim EyeProtectY
Dim	HearingProtectY
Dim SpecialComment
Dim StartDate
Dim EndDate
Dim ReportTo
Dim ShiftHours


dim ssnRE
Set ssnRE = New RegExp
ssnRE.Pattern = "[()-.<>'$\s]"
ssnRE.Global = True

if this_applicant > 0 then
	dim whatToDo
	whatToDo = Request.QueryString("action")
	If whatToDo = "agreeanddownload" Then
		generate_w2
	end If
end if
response.End()

sub generate_w2
	'make a record of who, when, from where and what

	Database.Open MySql
	'debug
	dim this_user
	this_user = user_id

	dim sql
	'check that user is authorized to retrieve W2 by reverse lookup of user id and requested siteID / Temps ApplicantID relationship
	sql = "SELECT tbl_users.userID " &_
			"FROM tbl_users INNER JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
			"WHERE tbl_applications.in" & this_site & "=" & this_applicant

	if user_level < userLevelPPlusStaff then
		set dbQuery = Database.Execute(sql)
		if dbQuery.eof  or dbQuery("userID") <> user_id then
			'Account not associated and or Not Authorized, please contact 1 (877) 733-7300 or email accounts@personnel.com... check if user_level is pplusStaff and if not cranks
			response.write "Account not associated and or Not Authorized, please contact 1 (877) 733-7300 or email accounts@personnel.com"
			response.end()
		end if
	end if

	'user passes security checks
	Database.Execute("INSERT INTO downloaded_w2s " &_
		"(userid, applicantId, year, siteid, ip, accessed) " &_
		"VALUES (" &_
		insert_number(user_id) & ", " &_
		insert_number(this_applicant) & ", " &_
		insert_number(this_year) & ", " &_
		insert_number(which_site) & ", " &_
		insert_string(request.serverVariables("REMOTE_ADDR")) & ", Now())")

	Database.Close

	'get W2 Info from qtrly database
	Dim getW2_cmd, getW2
	Set getW2_cmd = Server.CreateObject ("ADODB.Command")
	
	With getW2_cmd
		'print qtrly_path & "web.services\" & "4" & this_site & this_year & ".mdb"
		.ActiveConnection = aceProvider & qtrly_path & "web.services\" & "4" & this_site & this_year & ".mdb;Jet OLEDB:Database Password=onlyme;"
		'.ActiveConnection = dsnLessTemps(this_site)
		.CommandText = "" &_
			"SELECT YtdW2Totals.BoxC1, YtdW2Totals.BoxC2, YtdW2Totals.BoxC3, YtdW2Totals.Box17, YtdW2Totals.Box7, " &_
			"YtdW2Totals.Box8, YtdW2Totals.Box9, YtdW2Totals.Box10, YtdW2Totals.Box1, YtdW2Totals.Box3, YtdW2Totals.Box5, " &_
			"YtdW2Totals.Box11, YtdW2Totals.Box2, YtdW2Totals.Box4, YtdW2Totals.Box6, YtdW2Totals.Boxb, YtdW2Totals.Box14a, " &_
			"YtdW2Totals.Box14b, YtdW2Totals.Box14c, YtdW2Totals.Box14aLetter, YtdW2Totals.Box14bLetter, YtdW2Totals.Box14cLetter, " &_
			"YtdW2Totals.Box15b, YtdW2Totals.Box18, QtdMaster.LastnameFirst, QtdMaster.Address, QtdMaster.City & "", "" & " &_
			"QtdMaster.State & "" "" & QtdMaster.Zip as CityLine, QtdMaster.SSNumber, YtdW2Totals.Box12a, YtdW2Totals.Box12b, " &_
			"YtdW2Totals.Box12c, YtdW2Totals.Box12d, YtdW2Totals.Box12aLetter, YtdW2Totals.Box12bLetter, YtdW2Totals.Box12cLetter, " &_
			"YtdW2Totals.Box12dLetter, YtdW2Totals.Box16, YtdW2Totals.Box15, YtdW2Totals.Box19, YtdW2Totals.Box20, YtdW2Totals.Box13a, " &_
			"YtdW2Totals.Box13b, YtdW2Totals.Box13c, YtdW2Totals.Box14d, YtdW2Totals.Box14dLetter " &_
			"FROM YtdW2Totals YtdW2Totals LEFT OUTER JOIN QtdMaster QtdMaster ON YtdW2Totals.ApplicantId=QtdMaster.ApplicantID " &_
			"WHERE YtdW2Totals.ApplicantId=" & this_applicant
		.Prepared = true
	End With

	Set getW2 = getW2_cmd.Execute
	if not getW2.eof then
		BoxC1 = getW2("BoxC1")
		BoxC2 = getW2("BoxC2")
		BoxC3 = getW2("BoxC3")
		Box17 = getW2("Box17")
		Box7 = getW2("Box7")
		Box8 = getW2("Box8")
		Box9 = getW2("Box9")
		Box10 = getW2("Box10")
		Box1 = getW2("Box1")
		Box3 = getW2("Box3")
		Box5 = getW2("Box5")
		Box11 = getW2("Box11")
		Box2 = getW2("Box2")
		Box4 = getW2("Box4")
		Box6 = getW2("Box6")
		Boxb = getW2("Boxb")
		Box14a = getW2("Box14a")
		Box14b = getW2("Box14b")
		Box14c = getW2("Box14c")
		Box14aLetter = getW2("Box14aLetter")
		Box14bLetter = getW2("Box14bLetter")
		Box14cLetter = getW2("Box14cLetter")
		Box15b = getW2("Box15b")
		Box18 = getW2("Box18")
		LastnameFirst = getW2("LastnameFirst")
		Address = getW2("Address")
		CityLine = getW2("CityLine")
		SSNumber = getW2("SSNumber")
			if len(SSNumber) > 0 then SSNumber = ssnRE.Replace(SSNumber, "")
		Box12a = getW2("Box12a")
		Box12b = getW2("Box12b")
		Box12c = getW2("Box12c")
		Box12d = getW2("Box12d")
		Box12aLetter = getW2("Box12aLetter")
		Box12bLetter = getW2("Box12bLetter")
		Box12cLetter = getW2("Box12cLetter")
		Box12dLetter = getW2("Box12dLetter")
		Box16 = getW2("Box16")
		Box15 = getW2("Box15")
		Box19 = getW2("Box19")
		Box20 = getW2("Box20")
		Box13a = getW2("Box13a")
		Box13b = getW2("Box13b")
		Box13c = getW2("Box13c")
		Box14d = getW2("Box14d")
		Box14dLetter = getW2("Box14dLetter")
	end if
	getW2.close
	set getW2_cmd = nothing
	set getW2 = nothing

	Dim PDF, Doc, Font, field
	Set PDF = Server.CreateObject("Persits.PDF")

	if debug_mode then print this_year & "\w2.pdf"
	' Open an existing form
	Set Doc = PDF.OpenDocument( Server.MapPath( this_year & "\w2.pdf" ) )

	' Create font object
	'Set Font = Doc.Fonts("Helvetica")
	Set Font = Doc.Fonts("Arial")

	' Remove XFA support from it
	Doc.Form.RemoveXFA

	'On Error Resume Next

	dim canvas, page

	for page = 1 to 5 step 2

		Set canvas = Doc.Pages(page).Canvas

		Set Font = Doc.Fonts("Arial")

		dim param
		Set param = pdf.CreateParam("x=50;y=50;height=442;width=130; size=11;")

		'param("x") = x
		''Param("y") = y - 263 * 1 'what is 263?
		'param("y") = y

		'print_f Doc, 2, date(), 442, 130 'setFieldAndValue Doc, "applicationP2[0].date", date()

		' Draw text on canvas

		'range x between 10 to 550
		'range y between 550 to 750

		'a - SSNumber
		param("x") = 166
		param("y") = 748
		if len(SSNumber) > 5 then
			Canvas.DrawText left(SSNumber, 3) & " - " & mid(SSNumber, 4, 2)  & " - " & right(SSNumber, 4), param, Font
		end if

 		'b - Employer Identification
		param("x") = 48
		param("y") = 723
		Canvas.DrawText Boxb, param, Font

		'c - Employer name and address
		param("x") = 48
		param("y") = 695
		Canvas.DrawText BoxC1 & vbCrLf & BoxC2 & vbCrLf & BoxC3, param, Font

		'e - Employee's name and address
		param("x") = 48
		param("y") = 600
		Canvas.DrawText LastnameFirst & vbCrLf & Address & vbCrLf & CityLine, param, Font

		'1 - Wages
		param("x") = 350
		param("y") = 722
		Canvas.DrawText TwoDecimals(Box1), param, Font

		'3 - Social Security	Wages
		param("x") = 350
		param("y") = 700
		Canvas.DrawText TwoDecimals(Box3), param, Font

		'5 - Medicare Wages
		param("x") = 350
		param("y") = 675
		Canvas.DrawText TwoDecimals(Box5), param, Font

		'2 - Federal Tax
		param("x") = 475
		param("y") = 722
		Canvas.DrawText TwoDecimals(Box2), param, Font

		'4 - Social Tax
		param("x") = 475
		param("y") = 700
		Canvas.DrawText TwoDecimals(Box4), param, Font

		'6 - Medicare Tax
		param("x") = 475
		param("y") = 675
		Canvas.DrawText TwoDecimals(Box6), param, Font

		'box 15
		param("x") = 42
		param("y") = 495
		Canvas.DrawText Box15, param, Font

		'box 15b
		param("x") = 75
		param("y") = 495
		Canvas.DrawText Box15b, param, Font

		'box  16
		param("x") = 210
		param("y") = 495
		Canvas.DrawText TwoDecimals(Box16), param, Font

		'box 17
		param("x") = 300
		param("y") = 495
		Canvas.DrawText TwoDecimals(Box17), param, Font

	next

	if user_level => userLevelPPlusStaff then
		'email notice to branches
		dim msgBody, msgSubject
		msgSubject = user_firstname & " " & user_lastname & " downloaded their " & this_year & " W2 (" & tempsApplicantId & ")."
		msgBody = "A" & forWhatBranch & " " & this_year & " W2 form was successfully downloaded by " & user_firstname & " " & user_lastname & " (Applicant ID: " & tempsApplicantId & ")."

		Call SendEmail (branchEmail, w2_system_email, msgSubject, msgBody, "")
	end if
	
	'Save document
	Dim FilenameWithPath, Path, SitePath, FileName, FileNameNoPath, hrefLink, getAttachmentInfo, NewDoc, NewAttachment
	Dim pagesToAttach, pagesToPrint, isItSigned, CurrentPage

	SitePath = "\\personnelplus.net.\web\pdfServer\pdfW2\generated\"
	pagesToPrint  = "Page1=1; Page2=2; Page3=3; Page4=4; Page5=5; Page6=6; "

	Set NewDoc = Pdf.OpenDocumentBinary(Doc.SaveToMemory).ExtractPages(pagesToPrint)

	Response.Buffer = true
	Response.Clear()
	Response.ContentType = "application/pdf"
	Response.AddHeader "Content-Type", "application/pdf"
	Response.AddHeader "Content-Disposition", "attachment;filename=""W2-" & this_year & this_site & ", " & LastnameFirst & ".pdf"""
	Response.BinaryWrite NewDoc.SaveToMemory
	Set Doc = Nothing
	Set Pdf = Nothing
	Session("noHeaders") = false
	Response.End

End Sub

Public Function PCase(strInput)
	Dim iPosition  ' Our current position in the string (First character = 1)
	Dim iSpace     ' The position of the next space after our iPosition
	Dim strOutput  ' Our temporary string used to build the function's output

	iPosition = 1
	Do While InStr(iPosition, strInput, " ", 1) <> 0
		iSpace = InStr(iPosition, strInput, " ", 1)
		strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
		strOutput = strOutput & LCase(Mid(strInput, iPosition + 1, iSpace - iPosition))
		iPosition = iSpace + 1
	Loop
	strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
	strOutput = strOutput & LCase(Mid(strInput, iPosition + 1))
	PCase = strOutput
End Function

' ------------------------------------------------------------------
'  StripCharacters
' ------------------------------------------------------------------
Function StripCharacters (TextString)
	Dim RegularExpression
	If Len(TextString) > 0 Then
		Set RegularExpression = New RegExp
		RegularExpression.Pattern = "[<>']"
		RegularExpression.Global = True
		If VarType(TextString) = 8 Then
			StripCharacters = RegularExpression.Replace(TextString, "")
		End If
	End If
End Function

sub print_f_wWidth_and_font(Doc, Page, text, x, y, width, height, fontsize)

		dim pdf
		Set pdf = Server.CreateObject("Persits.PDF")

		dim canvas
		Set canvas = Doc.Pages(page).Canvas

		dim font
		Set Font = Doc.Fonts("Arial")

		dim param
		Set param = pdf.CreateParam("x=" & x & ";y=" & y & ";height=" & height & ";width=" & width & "; size=" & fontsize & ";")

    param("x") = x
    ''Param("y") = y - 263 * 1 'what is 263?
    param("y") = y

    ' Draw text on canvas
    Canvas.DrawText text, param, Font

end sub

sub print_f_wWidth(Doc, Page, text, x, y, width, height)
	print_f_wWidth_and_font Doc, page, text, x, y, 196, 196, 11

end sub

sub print_f(Doc, page, text, x, y)
	print_f_wWidth Doc, page, text, x, y, 196, 196
end sub

%>