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

dim nPage
nPage = CInt(Request.QueryString("Page"))
function navRecordsByPage(rs)

	nItemsPerPage = 50
	if not rs.eof then rs.PageSize = nItemsPerPage
	nPageCount = rs.PageCount

	
	rsQuery = request.serverVariables("QUERY_STRING")
	queryPageNumber = Request.QueryString("Page")

    if len(queryPageNumber) = 0 then
        queryPageNumber = request.Form("WhichPage")
        if instr(queryPageNumber, ",") > 0 then
            queryPageNumber = left(queryPageNumber, instr(queryPageNumber, ",") - 1)
        end if
    end if
 
	if len(queryPageNumber) > 0 and not isnull(queryPageNumber) then
        nPage = cint(queryPageNumber)
    end if

	if nPage < 1 Or nPage > nPageCount then
		nPage = 1
	end if
    
    if isnumeric(queryPageNumber) then
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
	response.write "<A HREF=""#"" onclick=""act_refresh_page('" & nPageCount & "');"">Last</A>"
	response.write("</div>")
end function

SQL = "SELECT tbl_companies.companyName, tbl_companies.Customer, tbl_companies.weekends, tbl_companies.companyid, " &_
	"tbl_companies.site, tbl_addresses.address, tbl_addresses.city, tbl_addresses.state, tbl_addresses.zip " &_
	"FROM tbl_companies LEFT JOIN tbl_addresses ON tbl_companies.addressid=tbl_addresses.addressid " &_
	"ORDER BY tbl_companies.companyName ASC;"
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
		
		Response.write "<div id='associations'><table><tr>" &_
			"<th class='smaller'>Company Name</th>" &_
			"<th class='smaller'>Address, City line</th>" &_
			"<th class='smaller'>Customer Code</th>" &_
			"<th class='smaller'>Week end</th>" &_
			"<th class='smaller'>Site</th>" &_
			"<th class='smaller widgets'>&nbsp;</th></tr>"
			
		inSystem = "class=" & Chr(34) & "inSystem" & Chr(34) & " "
		notInSystem = "class=" & Chr(34) & "notInSystem" & Chr(34) & " "
	
		emailLink = "/include/system/tools/images/email.gif"
		noEmailLink = "/include/system/tools/images/noEmail.gif"

		updatedLink = "/include/system/tools/images/updated.gif"
		notUpdatedLink = "/include/system/tools/images/notUpdated.gif"

		if Timecards.eof then response.write "No Items found."

		dim siteSelections, siteSelector
			siteSelections = "-1, - - -, 0, PER, 1, BUR, 2, BOI, 3, IDA, 4, PPI"
		
		dim daySelections, daySelector
			daySelections = "-1, - - -, 1, SUN, 2, MON, 3, TUE, 4, WED, 5, THU, 6, FRI, 7, SAT"

		dim cityline, mc_companyid, mc_weekends, status_indicator, mc_siteid

	'	do while not ( Timecards.Eof Or Timecards.AbsolutePage <> nPage )
	
		Timecards.AbsolutePage = nPage
		do while not ( Timecards.Eof  )
		
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
		siteSelector = mkSelectInputwChosen("sitefor"&mc_companyid, "customersite", siteSelections, mc_siteid)
		daySelector = mkSelectInputwChosen("dayfor"&mc_companyid, "customerweekends", daySelections, mc_weekends)
		status_indicator = "<span id=""status_" & mc_companyid & """ class=""notupdating"" " &_
			"onclick=""custcode.update('" & mc_companyid & "')"">&nbsp;</span>"
		
		'rowEmphasis = rowEmphasis & " not	Submitted"
		Response.write "<tr style='background-color:#" & ShadeData & "'>" &_
			"<td class='regular " & rowEmphasis & "'>" &  Timecards("companyName") & "</td>" &_
			"<td class='regular " & rowEmphasis & "'>" &  Timecards("address") & "<br>" & cityline & "</td>" &_
			"<td class='regular " & rowEmphasis & "'>" &  mkCustInput(mc_companyid, Timecards("Customer")) & "</td>" &_
			"<td class='regular " & rowEmphasis & "'>" & daySelector & "</td>" &_
			"<td class='regular " & rowEmphasis & "'>" &  siteSelector & "</td>" &_
			"<td class='regular " & rowEmphasis & "'>" & status_indicator & "</td>" &_
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
			"onChange=""custcode.compare(this)"" " &_
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
			"class=""customercode"" " &_
			"maxlength=""255"" " &_
			"onkeypress=""custcode.keypressed(this);"" " &_
			"onChange=""custcode.compare(this);"" " &_
			"type=""text"" />" &_
			"" &_
			"<input name=""" & input_id & "_x"" id=""" & input_id & "_x"" " &_
			"value=""" & input_value & """ " & "type=""hidden"" />"
end function


%>
