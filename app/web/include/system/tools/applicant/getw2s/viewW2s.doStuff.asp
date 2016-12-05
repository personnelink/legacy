<%

function show_available_w2s()
	dim buffer_response

	Database.Open MySql
	'debug
	dim this_user
	this_user = user_id

	'check what companies user is enrolled in
	dim sql
	sql = "SELECT tbl_applications.inPER, tbl_applications.inIDA, tbl_applications.inBOI, tbl_applications.inBUR " &_
			"FROM tbl_users INNER JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
			"WHERE tbl_users.userID=" & this_user
    'print sql
	dim inTemps(3)
	set dbQuery = Database.Execute(sql)
	if not dbQuery.eof then
			'PER = 0, BUR = 1, BOI = 2, IDA = 3, TWI = 4, PPI = 5, POC = 6, BLY = 7, BSE = 8, ALL = 9, ORE = 10, WYO = 11
			inTemps(PER) = dbQuery("inPER")
			inTemps(BUR) = dbQuery("inBUR")
			inTemps(BOI) = dbQuery("inBOI")
			inTemps(IDA) = dbQuery("inIDA")
	end if

	dim fs
	set fs=Server.CreateObject("Scripting.FileSystemObject")

	dim i, inMoreThanOne, w2_year

	'on error resume next
	
	const firstW2Year = 2011
	dim lastW2Year : lastW2Year = Cint(Year(Date())) - 1

	dim qrtly_path_and_filename
	dim getW2_cmd, getW2
	
	set getW2_cmd = Server.CreateObject ("ADODB.Command")

	for w2_year = firstW2Year to lastW2Year

		for i = 0 to 3
			if inTemps(i) > 0 then

				'check if qrtly file exists
				qrtly_path_and_filename = qtrly_path & "web.services\" & "4" & site_by_name(i) & w2_year & ".mdb"
				if fs.FileExists(qrtly_path_and_filename) = true then
    'print w2_year
	'print qrtly_path_and_filename
					'file exists, check if applicant has a w2 for the year
					if request.querystring("debug") = "1" then print w2_year & " : " & site_by_name(i)
					with getW2_cmd
						'print aceProvider & qrtly_path_and_filename 
						.ActiveConnection = aceProvider & qrtly_path_and_filename
						.CommandText = "" &_
							"SELECT QtdMaster.LastnameFirst, QtdMaster.Address " &_
							"FROM YtdW2Totals YtdW2Totals LEFT OUTER JOIN QtdMaster QtdMaster ON YtdW2Totals.ApplicantId=QtdMaster.ApplicantID " &_
							"WHERE YtdW2Totals.ApplicantId=" & inTemps(i)
						.Prepared = true
					end with
    'print getW2_cmd.CommandText
					'on error resume next
					set getW2 = getW2_cmd.Execute
					'on error goto 0

					if not getW2.eof  then
						buffer_response = buffer_response & "<li><a href=""/pdfServer/pdfW2/?year=" & w2_year & "&site=" & i & "&id=" & inTemps(i) & "&action=agreeanddownload"">"
						select case i
						case BUR
							inMoreThanOne = inMoreThanOne + 1
							buffer_response = buffer_response & w2_year & " W2 for Burley Idaho"
						case PER
							inMoreThanOne = inMoreThanOne + 1
							buffer_response = buffer_response & w2_year & " W2 for Twin Falls Idaho"
						case BOI
							inMoreThanOne = inMoreThanOne + 1
							buffer_response = buffer_response & w2_year & " W2 for Boise and Nampa Idaho"
						case IDA
							inMoreThanOne = inMoreThanOne + 1
							buffer_response = buffer_response & w2_year & " W2 for Idaho Department of Agriculture"
						end select
						buffer_response = buffer_response & "</a></li>"
					end if
					getW2.close
				end if
			end if
		next
	next

	if len(buffer_response) > 0 then
		buffer_response = "<p id=""download_instructions"">Click on a link below to download your W2</p><ul>" & buffer_response & "</ul>"

		if inMoreThanOne < 1 then
			show_available_w2s = buffer_response & "<p style=""margin:1em 2em"">An active enrollment could not be located for you. Please contact your local office if you believe this is an error. Thank you."
		else
			show_available_w2s = buffer_response & "<p id=""bottom_note"">*Note: You may have more than one W2 listed if you have worked at more than one location.</p>"
		end if

	else
		show_available_w2s = "<p style=""margin:1em 2em"">We were unable to locate any wages for you... Please contact your local office if you believe this is an error.<br /><br /> Thank you."
	end if

	set fs=nothing
	set dbQuery = Nothing
	set getW2_cmd = nothing
	set getW2 = nothing
	Database.Close

end function

function site_by_name (site)
	select case cint(site)
	case PER
		site_by_name = "PER"
	case BUR
		site_by_name = "BUR"
	case IDA
		site_by_name = "IDA"
	case BOI
		site_by_name = "BOI"
	case PPI
		site_by_name = "PPI"
	case TWI
		site_by_name = "TWI"
	case BSE
		site_by_name = "BSE"
	case BLY
		site_by_name = "BLY"
    case ORE
        site_by_name = "ORE"
	end select
end function

%>