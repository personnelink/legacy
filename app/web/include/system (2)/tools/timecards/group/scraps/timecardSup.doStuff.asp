<%
dim whichCompany
whichCompany = Request.QueryString("company")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
		if len(whichCompany) = 0 then

			whichCompany = "PER"
		end if
	end if
end if

dim is_internal
if companyId = 67 then
	is_internal = true
else
	is_internal = false
end if

if is_internal then leftSideMenu = makeSideMenu ()

showDashboard

const inTime = 0, luoutTime = 1, luinTime = 2, outTime = 3, regularTime = 4, otherTime = 5, otherTypeTime = 6

'Creating new or retrieving previously saved timecard
	PlacementID = Replace(Request.QueryString("placementID"), "'", "")
	TimecardID = Replace(Request.QueryString("timecardID"), "'", "")
	if VarType(TimecardID) = 8 then
		if Instr(TimecardID, "new") > 0 then
			TimecardID = -1
		elseif IsNumeric(TimecardID) then
			TimecardID = CLng(TimecardID)
		Else
			TimecardID = 0
		End IF
	end if

	whatToDo = request.form("formAction")
	if whatToDo = "save" then
		SaveTimecard
	end if

Sub showDashboard
	if len(session("timecardMessageBody")) > 0 then
		response.write(decorateTop("timecardMessageArea", "marLR10", session("timecardMessageHeading")))
		response.write(session("timecardMessageBody"))
		response.write(decorateBottom())
	
		session("timecardMessageBody") = ""
		session("timecardMessageHeading") = ""
	End if 

	'Response.Buffer = true
	dim objXMLHTTP, placements, ws_request
	
	if user_level >= userLevelSupervisor and thisCustomer = "" then 'change after debug and testing
		dim some_guiding_text
		some_guiding_text = "<p>Please select a customer code on the left to get started.</p>"
	end if
	response.write DecorateTop("currentOrders", "dashboard marLR10", "Open Job Orders")
	response.write "<div id=""putOrdersHere"">" & some_guiding_text & "</div>"
	response.Flush()
	response.write DecorateBottom()
End Sub

function makeSideMenu ()
	dim strTmp
	strTmp = "<div id=""compCodeSelections"">" &_
		"<p>" &_
		  "<label for=""whichCompany"">Branch Location:</label>" &_
		  "<select name=""whichCompany"" id=""whichCompany"" class=""styled"" onchange=""javascript:document.timecardForm.submit();"">" &_
		    "<option value="""">--- Select Area ---</option>"

		    if whichCompany = "BUR" then
				  strTmp = strTmp & "<option value=""BUR"" selected>Burley</option>"
				else
				  strTmp = strTmp & "<option value=""BUR"">Burley</option>"
				end if

				if whichCompany = "PER" then
			    strTmp = strTmp & "<option value=""PER"" selected>Twin Falls / Jerome</option>"
				else
			    strTmp = strTmp & "<option value=""PER"">Twin Falls / Jerome</option>"
				end if

				if whichCompany = "BOI" then
			    strTmp = strTmp & "<option value=""BOI"" selected>Boise / Nampa</option>"
				else
			    strTmp = strTmp & "<option value=""BOI"">Boise / Nampa</option>"
				end if

		 strTmp = strTmp & "" &_
		 		"</SELECT>" &_
			"</p></form>"

		if len(whichCompany & "") > 0 then
			Select Case whichCompany
			Case "BUR"
				thisConnection = dsnLessTemps(BUR)
			Case "PER"
				thisConnection = dsnLessTemps(PER)
			Case "BOI"
				thisConnection = dsnLessTemps(BOI)
			End Select
		
			Set WhichCustomer = Server.CreateObject("ADODB.RecordSet")
			sqlWhichCustomer = "SELECT Placements.Customer " &_
				"FROM Applicants INNER JOIN Placements ON Applicants.ApplicantID = Placements.ApplicantId " &_
				"GROUP BY Placements.PlacementStatus, Placements.Customer " &_
				"HAVING (((Placements.PlacementStatus)<2));" 

			'break sqlWhichCustomer
		
			WhichCustomer.CursorLocation = 3 ' adUseClient
			WhichCustomer.Open sqlWhichCustomer, thisConnection
		
			dim thisCustomer
			thisCustomer = Replace(Request.QueryString("masquerade"), "'", "''")
	
			dim CurrentCustomer
			strTmp = strTmp & "<br><p>Company Code:</p> <div id=""compCodes"" class=""altNavPageRecords"">" &_
				"<A HREF=""?customer=PERSON&masquerade=ALL&company=" &_
				WhichCompany & """>&nbsp;ALL&nbsp;</A>"
				
			do while not WhichCustomer.Eof
				CurrentCustomer = WhichCustomer("Customer")
				strTmp = strTmp & "<A HREF=""javascript:;"" " & "onclick=""get_client_orders('" & CurrentCustomer & "', '" & whichCompany & "')"" >&nbsp;"
				if thisCustomer = CurrentCustomer then
					strTmp = strTmp & "<span style=""color:red"">" & CurrentCustomer & "</span>"
				Else
					strTmp = strTmp & CurrentCustomer
				end if
				strTmp = strTmp & "&nbsp;</A><br>"
				WhichCustomer.MoveNext
			loop
			strTmp = strTmp & "</div></div>"
		end if

	makeSideMenu = strTmp
end function

%>

