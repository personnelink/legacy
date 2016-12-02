<%

function show_available_branches()
	dim buffer_response
		buffer_response = "<div id=""availablehistory"">"
		
	Database.Open MySql
	'debug
	dim this_user
	this_user = user_id

	'check what companies user is enrolled in
	dim sql
	sql = "SELECT tbl_applications.inPER, tbl_applications.inIDA, tbl_applications.inBOI, tbl_applications.inBUR " &_
			"FROM tbl_users INNER JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
			"WHERE tbl_users.userID=" & this_user
			
	dim inTemps(3)
	set dbQuery = Database.Execute(sql)
	if not dbQuery.eof then
			'PER = 0, BUR = 1, BOI = 2, IDA = 3
			inTemps(PER) = dbQuery("inPER")
			inTemps(BUR) = dbQuery("inBUR")
			inTemps(BOI) = dbQuery("inBOI")
			inTemps(IDA) = dbQuery("inIDA")
	else
		buffer_response = buffer_response & "<i>we couldn't find any enrollments</i>"
	end if	

	dim i
	dim inMoreThanOne
	dim qrtly_path_and_filename

	for i = 0 to 3
		if inTemps(i) > 0 then	

			select case i
				case BUR
					inMoreThanOne = inMoreThanOne + 1 
					buffer_response = buffer_response & "<a href=""/include/system/tools/applicant/check_history/?who=" & inTemps(i) & "&where=BUR"">Burley"
				case PER
					inMoreThanOne = inMoreThanOne + 1 
					buffer_response = buffer_response & "<a href=""/include/system/tools/applicant/check_history/?who=" & inTemps(i) & "&where=PER"">Twin Falls"
				case BOI
					inMoreThanOne = inMoreThanOne + 1 
					buffer_response = buffer_response & "<a href=""/include/system/tools/applicant/check_history/?who=" & inTemps(i) & "&where=BOI"">Boise and Nampa"
				case IDA
					inMoreThanOne = inMoreThanOne + 1 
					buffer_response = buffer_response & "<a href=""/include/system/tools/applicant/check_history/?who=" & inTemps(i) & "&where=BUR""> Idaho Department of Agriculture"
			end select
			buffer_response = buffer_response & "</a>"
		end if
	next
	
	buffer_response = buffer_response & "</div>"
	
	Database.Close

	show_available_branches = buffer_response
end function

%>