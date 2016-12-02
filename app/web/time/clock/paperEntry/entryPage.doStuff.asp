<%

dim fromDate, toDate
fromDate = Request.QueryString("fromDate") 
if isDate(fromDate) = false then 
	fromDate = request.form("fromDate") 
	if isDate(fromDate) = false then fromDate = CStr(Date() - 14) 
end if

toDate = Request.QueryString("toDate") 
if isDate(toDate) = false then 
	toDate = request.form("toDate") 
	if isDate(toDate) = false then toDate = CStr(Date() + 1)
end if

dim likeName
likeName = Replace(Request.QueryString("likeName"), "'", "''")
if len(likeName) = 0 then 
	likeName = request.form("likeName") 
end if

function total_time(timeinfo)
	dim i, DayTimeInfo, WeekTimeInfo, FullTimeCard(6, 6), TimecardInfo, WeekEndsOn
	if len(timeinfo) >0 then 
		WeekTimeInfo = Split(timeinfo, ";")
		for i = 0 to 6
			DayTimeInfo = Split(WeekTimeInfo(i), ",")
			FullTimeCard(inTime, i) = DayTimeInfo(inTime)
			FullTimeCard(luoutTime, i) = DayTimeInfo(luoutTime)
			FullTimeCard(luinTime, i) = DayTimeInfo(luinTime)
			FullTimeCard(outTime, i) = DayTimeInfo(outTime)
			FullTimeCard(regularTime, i) = DayTimeInfo(regularTime)
			FullTimeCard(otherTime, i) = DayTimeInfo(otherTime)
			FullTimeCard(otherTypeTime, i) = DayTimeInfo(otherTypeTime)
			on error resume next
			weekTotal = weekTotal + Cint(FullTimeCard(regularTime, i))
			on error goto 0
		next
		total_time = TwoDecimals(weekTotal)
		weekTotal = 0
	end if
	erase WeekTimeInfo
	erase DayTimeInfo
end function

dim nPage
nPage = CInt(Request.QueryString("Page"))
function navRecordsByPage(rs)

	nItemsPerPage = 50
	if not rs.eof then rs.PageSize = nItemsPerPage
	nPageCount = rs.PageCount

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if
	
	rsQuery = request.serverVariables("QUERY_STRING")
	queryPageNumber = Request.QueryString("Page")
	if queryPageNumber then
		rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
	end if


	response.write "<div id=""topPageRecords"" class=""navPageRecords"">" &_
				"<input name=""WhichPage"" id=""WhichPage"" type=""hidden"" value="""" />"

	response.write "<A HREF=""#"" onclick=""act_refresh_page('1');"">First</A>"
	For i = 1 to nPageCount
		response.write "<A HREF=""#"" onclick=""act_refresh_page('" & i & "');"">&nbsp;"
		if i = nPage then
			response.write "<span style=""color:red"">" & i & "</span>"
		Else
			response.write i
		end if
		response.write "&nbsp;</A>"
			nav_break = nav_break + 1
			if nPageCount > 35 and nav_break > 22 then
				nav_break = 0
				response.write "<br>"
			end if

	Next
	response.write "<A HREF=""#"" onclick=""act_refresh_page('" & whichCompany & "');"">Last</A>"
	response.write("</div>")
end function

SQL = "SELECT tbl_companies.companyName, tbl_companies.Customer, tbl_companies.weekends, tbl_companies.companyid, " &_
	"tbl_companies.site, tbl_addresses.address, tbl_addresses.city, tbl_addresses.state, tbl_addresses.zip " &_
	"FROM tbl_companies LEFT JOIN tbl_addresses ON tbl_companies.addressid=tbl_addresses.addressid "
	'"WHERE " & sSearchString & "tbl_companies.creationDate>='" & fromMySqlFriendlyDate &_
	'"' AND tbl_companies.creationDate<='" & toMySqlFriendlyDate & "' " &_
	'"ORDER BY tbl_companies.companyName ASC, tbl_addresses.city ASC;"
		
Set Timecards = Server.CreateObject ("ADODB.RecordSet")
	Timecards.CursorLocation = 3 ' adUseClient
	Timecards.Open SQL, MySql

sub showInputTables ()

	dim whichCompany, linkInvoice, inIDA, inPER, inBUR, inBOI, inAtLeastOne, inSystem, notInSystem, rowEmphasis
	dim ModifiedTime, InsertedTime, Updated
	
	dim applicationLink
	
	'whichCompany = "IDA"
	'if len(whichCompanyID & "") > 0 then
		'whichCompanyID = "((HistoryDetail.Customer)='" & whichCompanyID & "') AND "
	'end if
	
	'if len(whichCompany & "") > 0 then
		'Select Case whichCompany
		'Case "IDA"
			'thisConnection = TempsPlus(IDA)
		'End Select
		dim sSearchString
		if len(likeName) > 0 then
			sSearchString = "((CONCAT(tbl_users.lastName,', ',tbl_users.firstName)) LIKE '%" & likeName & "%') AND "
		end if
		
		fromMySqlFriendlyDate = Year(fromDate) & "/" & Month(fromDate) & "/" & Day(fromDate)
		toMySqlFriendlyDate = Year(toDate) & "/" & Month(toDate) & "/" & Day(toDate) + 1


		
		dim addressLine, userAddressId, getUserAddress, employeeDisplayName
		Database.Open MySql
		
		Response.write "<div style='position:relative;z-index:99;' id='placements'><table><tr>" &_
			"<th class=''>Company Name</th>" &_
			"<th class=''>Job Id</th>" &_
			"<th class=''>Placement</th>" &_
			"<th class=''>Hours</th>" &_
			"<th class=''>Type</th>" &_
			"<th class=''>Timecard</th>" &_
			"<th class='widgets'>&nbsp;</th></tr>"
			
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		if Timecards.eof then response.write "No Items found."

		dim siteSelections, siteSelector
			siteSelections = "0, PER, 1, BUR, 2, BOI, 3, IDA, 4, PPI"
		
		dim hourstypeSelections, hourstypeSelector, HoursTypes
		Set HoursTypes = Server.CreateObject ("ADODB.RecordSet")
		HoursTypes.CursorLocation = 3 ' adUseClient
		HoursTypes.Open "SELECT type, description FROM tbl_hourstype", MySql
		
		do while not HoursTypes.EOF
			hourstypeSelections	= hourstypeSelections &_
				HoursTypes("type") & ", " &_
				HoursTypes("description") & ", "
			
			HoursTypes.MoveNext
		loop
		
		dim lengthofselections
		lengthofselections = len(hourstypeSelections)
		if lengthofselections > 0 then
			hourstypeSelections = left(hourstypeSelections, lengthofselections - 2) 'remove trailing comma
		end if

		dim cityline, mc_companyid, mc_weekends, status_indicator, mc_siteid

	do while not ( Timecards.Eof Or Timecards.AbsolutePage <> nPage )
	
		if Timecards.eof then
			Timecards.Close
			' Clean up
			' Do the no results HTML here
			response.write "No Items found."
				' Done
			Response.End 
		end if

		if i > 0 then
			ShadeData = "FFFFFF"
			i = 0
		Else
			ShadeData = "EFF5FA"
			i = 1
		end if
		cityline = Timecards("city") & ", " & Timecards("state") & " " & Timecards("zip")
		
		mc_companyid = Timecards("companyid")
		mc_siteid = Timecards("site")
		mc_weekends = Timecards("weekends")
		inpHoursText = "<img src=""noimage.jpeg"" id=""thumb_" & mc_companyid & """ width=""32"" height=""29"" />"
		hourstypeSelector = mkSelectInputwChosen("hourstype"&mc_companyid, "customerweekends", hourstypeSelections, mc_weekends)
		status_indicator = "<span id=""status_" & mc_companyid & """ class=""notupdating"" " &_
			"onclick=""custcode.update('" & mc_companyid & "')"">&nbsp;</span>"
		
		'rowEmphasis = rowEmphasis & " not	Submitted"
		Response.write "<tr style='background-color:#" & ShadeData & "'>" &_
			"<td class='" & rowEmphasis & "'>" &  Timecards("companyName") & "</td>" &_
			"<td class='" & rowEmphasis & "'>" &  Timecards("address") & "<br>" & cityline & "</td>" &_
			"<td class='" & rowEmphasis & "'>" & daySelector & "</td>" &_
			"<td class='" & rowEmphasis & "'>" &  mkCustInput(mc_companyid, Timecards("Customer")) & "</td>" &_
			"<td class='" & rowEmphasis & "'>" &  hourstypeSelector & "</td>" &_
			"<td class='" & rowEmphasis & "'>" &  inpHoursText & "</td>" &_
			"<td class='" & rowEmphasis & "'>" & status_indicator & "</td>" &_
			"</tr>"
				
		Timecards.MoveNext
			
	loop
	Response.write "</table></div>"

end sub

function mkSelectInputwChosen (sName, sClass, sOptionsAndValues, Chosen)
		dim strHoldSelect
		strHoldSelect = "<input " &_
			"name=""" & sName & "_x"" " & "id=""" & sName & "_x"" " &_
			"value=""" & Chosen & """ " &_
			"type=""hidden"" " &_
			"/>" &_
			"<select " &_
			"name=""" & sName & """ " & "id=""" & sName & """ " &_
			"class=""" & sClass & """ " &_
			"onChange=""emphours.compare(this)"" " &_
			" />"

		dim arryValuesAndOptions, holdValsAndOpts
		arryValuesAndOptions = split(sOptionsAndValues, ",")
		for i = 0 to ubound(arryValuesAndOptions) step 2
			''print arryValuesAndOptions(i) & " = " & Chosen
			if trim(arryValuesAndOptions(i)) = trim(Chosen) then
				holdValsAndOpts = holdValsAndOpts & "<option value=""" & arryValuesAndOptions(i) & """ " &_
				"selected=""selected"">" &_
					arryValuesAndOptions(i+1) & "</option>"
			else
				holdValsAndOpts = holdValsAndOpts & "<option value=""" & arryValuesAndOptions(i) & """>" &_
					arryValuesAndOptions(i+1) & "</option>"
			end if
		next
		
		mkSelectInputwChosen = strHoldSelect & holdValsAndOpts & "</select>"
end function

function mkSelectInput (sName, sClass, sOptionsAndValues)
	mkSelectInput = mkSelectInputwChosen (sName, sCalss, sOptionsAndValues, "")
end function

function mkCustInput(input_id, input_value)
	mkCustInput = "" &_
			"<input " &_
			"name=""" & input_id & """ " & "id=""" & input_id & """ " &_
			"value=""" & input_value & """ " &_
			"class=""inpHours"" " &_
			"maxlength=""6"" " &_
			"onkeypress=""emphours.keypressed(this);"" " &_
			"onChange=""emphours.compare(this);"" " &_
			"type=""text"" />" &_
			"" &_
			"<input name=""" & input_id & "_x"" id=""" & input_id & "_x"" " &_
			"value=""" & input_value & """ " & "type=""hidden"" />"
end function

function UnreviewedTimecards ()
	dim strHoldPane
	strHoldPane = createtop("", "marLRB10", "Unreviewed Timecards")
	strHoldPane = strHoldPane & "<div id=""thumbnails"">" &_
			"</div><a hrer=""#"" onclick=""Services.init()"" />refresh</a>"
	strHoldPane = strHoldPane & closeit()

	UnreviewedTimecards = strHoldPane
	
end function

%>
