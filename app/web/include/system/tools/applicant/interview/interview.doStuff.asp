<%
dim app_id
app_id = request.form("app_id")
if len(app_id) = 0 then
	app_id = request.querystring("app_id")
end if

dim return_QS
return_QS = request.form("return_QS")
if len(return_QS) = 0 then 
	return_QS = request.ServerVariables("HTTP_REFERER")
	return_QS = right(return_QS, len(return_QS) - instr(return_QS, "?"))
end if

'declare interview variables
dim interviewId
dim applicantId
dim interviewerid
dim interviewTime
dim modifiedDate
dim creationDate
dim kind_of_work
dim full_or_part_time
dim accept_temporary
dim accept_longterm
dim days_available
dim work_any_shift
dim which_shifts
dim special_availability
dim wage_willing
dim valid_dl
dim proof_insured
dim getting_there
dim commute_willingness
dim m_or_f
dim about_criminal
dim on_porp
dim porp_restrictions
dim currently_employed
dim pass_drug_screen
dim can_start_work
dim needs_awareness
dim needs_awareness_notes
dim worked_for_staffing
dim worked_for_staffing_notes
dim work_history
dim employment_gaps
dim more_skills
dim certifications
dim have_resume
dim paperwork_completed
dim w4_reviewed
dim i9_reviewed
dim any_questions
dim welcome_given
dim calling_explained
dim interview_complete

'work history schema
dim desiredWageAmount
dim minWageAmount
dim employerNameHistOne
dim jobHistAddOne
dim jobHistPhoneOne
dim jobHistCityOne
dim jobHistStateOne
dim jobHistZipOne
dim jobHistPayOne
dim jobHistSupervisorOne
dim jobDutiesOne
dim jobHistFromDateOne
dim jobHistToDateOne
dim jobReasonOne
dim employerNameHistTwo
dim jobHistAddTwo
dim jobHistPhoneTwo
dim jobHistCityTwo
dim jobHistStateTwo
dim jobHistZipTwo
dim jobHistPayTwo
dim jobHistSupervisorTwo
dim jobDutiesTwo
dim jobHistFromDateTwo
dim jobHistToDateTwo
dim jobReasonTwo
dim employerNameHistThree
dim jobHistAddThree
dim jobHistPhoneThree
dim jobHistCityThree
dim jobHistStateThree
dim jobHistZipThree
dim jobHistPayThree
dim jobHistSupervisorThree
dim jobDutiesThree
dim jobHistFromDateThree
dim jobHistToDateThree
dim jobReasonThree

dim application_says_full_or_part_time
dim application_says_wage_willing
dim application_says_valid_dl
dim application_says_proof_insured
dim application_says_m_or_f
dim application_says_about_criminal
dim application_says_currently_employed
dim application_says_work_history

'if interview has been completed go save it, else get started with a new interview ...
if frmAction = "completed" then
	save_interview
end if

'Check if user has had an interview already and if so load it ...
Database.Open MySql
if app_id > 0 then
	
	dim sql, main_sql
	main_sql = "SELECT tbl_interviews.*, tbl_applications.workConviction, tbl_applications.workConvictionExplain, tbl_applications.desiredWageAmount, " &_
		"tbl_applications.minWageAmount, tbl_applications.currentlyEmployed, " &_
		"tbl_applications.workTypeDesired, tbl_applications.workValidLicense, tbl_applications.autoInsurance, tbl_applications.additionalInfo, " &_
		"tbl_applications.employerNameHistOne, tbl_applications.jobHistAddOne, tbl_applications.jobHistPhoneOne, tbl_applications.jobHistCityOne, " &_
		"tbl_applications.jobHistStateOne, tbl_applications.jobHistZipOne, tbl_applications.jobHistPayOne, tbl_applications.jobHistSupervisorOne, " &_
		"tbl_applications.jobDutiesOne, tbl_applications.jobHistFromDateOne, tbl_applications.JobHistToDateOne, tbl_applications.jobReasonOne, " &_
		"tbl_applications.employerNameHistTwo, tbl_applications.jobHistAddTwo, tbl_applications.jobHistPhoneTwo, tbl_applications.jobHistCityTwo, " &_
		"tbl_applications.jobHistStateTwo, tbl_applications.jobHistZipTwo, tbl_applications.jobHistPayTwo, tbl_applications.jobHistSupervisorTwo, " &_
		"tbl_applications.jobDutiesTwo, tbl_applications.jobHistFromDateTwo, tbl_applications.JobHistToDateTwo, tbl_applications.jobReasonTwo, " &_
		"tbl_applications.employerNameHistThree, tbl_applications.jobHistAddThree, tbl_applications.jobHistPhoneThree, tbl_applications.jobHistCityThree, " &_
		"tbl_applications.jobHistStateThree, tbl_applications.jobHistZipThree, tbl_applications.jobHistPayThree, tbl_applications.jobHistSupervisorThree, " &_
		"tbl_applications.jobDutiesThree, tbl_applications.jobHistFromDateThree, tbl_applications.JobHistToDateThree, tbl_applications.jobReasonThree " &_
		"FROM  (tbl_users INNER JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID) " &_
		"INNER JOIN tbl_interviews ON tbl_applications.applicationID = tbl_interviews.applicationid " &_
		"WHERE tbl_applications.applicationID=" & app_id
	
	Set dbQuery = Database.Execute(main_sql)
	
	'check if interview exists
	if dbQuery.eof then
	
		'no initial interview exists, retrieve applicant's userID and create an initial interview
		sql = "SELECT tbl_users.userID "&_
		"FROM  tbl_users INNER JOIN tbl_applications ON tbl_users.applicationID = tbl_applications.applicationID " &_
		"WHERE tbl_applications.applicationID=" & app_id

		Set dbQuery = Database.Execute(sql)
		if not dbQuery.eof then 
			
			sql = "INSERT INTO tbl_interviews (creationDate, modifiedDate, applicationid, userID, interviewerid) " & _
								"VALUES (now(), " &_
								"now(), " &_
								app_id & ", " &_
								dbQuery("userID") & ", " &_
								user_id & "); " & _
								"SELECT last_insert_id()"

			Set dbQuery = Database.execute(sql).nextrecordset
			interviewID = CInt(dbQuery(0))
			Database.Execute("Update tbl_applications SET interviewID=" & interviewID & " WHERE applicationID=" & app_id)
			
			mkInitialInterviewAppnt
		else
			break "[Applicant hasn't completed application yes]"
		end if
		
		'interview record created, reload info again ...
		Set dbQuery = Database.Execute(main_sql)
		
		'double check that a record was successfully loaded this time, if not there's an issue somewhere
		if dbQuery.eof then
			break "[there was a problem, an interview was attempted but still was not able to load data]"
		end if
	end if

	interviewId = dbQuery("interviewID")
	interviewerId = user_id
	interviewTime = dbQuery("interviewTime")
	modifiedDate = dbQuery("modifiedDate")
	creationDate = dbQuery("modifiedDate")
	kind_of_work = dbQuery("kind_of_work")
		if isnull(kind_of_work) then kind_of_work = ""
	
	application_says_full_or_part_time = dbQuery("workTypeDesired")
	select case application_says_full_or_part_time
	case "f"
		application_says_full_or_part_time = "<p class=""appsays"">Employment Application says 'Full-Time'</p>"
	case "p"
		application_says_full_or_part_time = "<p class=""appsays"">Employment Application says 'Part-Time'</p>"
	case "a"
		application_says_full_or_part_time = "<p class=""appsays"">Employment Application says 'Any-Time'</p>"
	end select
	
	full_or_part_time = dbQuery("full_or_part_time")
		if isnull(full_or_part_time) then full_or_part_time = ""

	accept_temporary = dbQuery("accept_temporary")
		if isnull(accept_temporary) then accept_temporary = ""

	accept_longterm = dbQuery("accept_longterm")
		if isnull(accept_longterm) then accept_longterm = ""

	days_available = dbQuery("days_available")
		if isnull(days_available) then days_available = "0"

	work_any_shift = dbQuery("work_any_shift")
		if isnull(work_any_shift) then work_any_shift = ""
	which_shifts = dbQuery("which_shifts")
		if isnull(which_shifts) then which_shifts = ""

	special_availability = dbQuery("special_availability")
	
	wage_willing = dbQuery("wage_willing")
	minWageAmount = dbQuery("minWageAmount")
	desiredWageAmount = dbQuery("desiredWageAmount")
	
	if len(desiredWageAmount) > 0 then
		application_says_wage_willing = "<p class=""appsays"">" &_
			"Employment Application says that the desired Hourly Salary or Wage is: " & desiredWageAmount
	end if
	if len(minWageAmount) > 0 then
		if len(application_says_wage_willing) > 0 then
			application_says_wage_willing = application_says_wage_willing &_
				" and the minimum hourly Salary or Wage is: " & minWageAmount
		else
			application_says_wage_willing = "<p class=""appsays"">Employment Application says that the minimum hourly Salary or Wage is: " &_
				minWageAmount
		end if
	end if
	if len(application_says_wage_willing) > 0 then
		application_says_wage_willing = application_says_wage_willing & "</p>"
	end if
	
	'valid drivers license
	valid_dl = dbQuery("valid_dl")
		if isnull(valid_dl) then valid_dl = ""
	
	application_says_valid_dl = dbQuery("workValidLicense")
	select case application_says_valid_dl
	case "y"
		application_says_valid_dl = "<p class=""appsays"">Employment Application says they HAVE a Valid Drivers License.</p>"
	case "n"
		application_says_valid_dl = "<p class=""appsays"">Employment Application says they DO NOT have a valid drivers license.</p>"
	case else
		application_says_valid_dl = "<p class=""appsays"">Employment Application does not say.</p>"
	end select

	'proof of automobile insurance
	proof_insured = dbQuery("proof_insured")
		if isnull(proof_insured) then proof_insured = ""

	application_says_proof_insured = dbQuery("autoInsurance")
	select case application_says_proof_insured
	case "y"
		application_says_proof_insured = "<p class=""appsays"">Employment Application says they HAVE Automobile Insurance.</p>"
	case "n"
		application_says_proof_insured = "<p class=""appsays"">Employment Application says they DO NOT have Automobile Insurance.</p>"
	case else
		application_says_proof_insured = "<p class=""appsays"">Employment Application does not say.</p>"
	end select

	'commuting to work
	getting_there = dbQuery("getting_there")
	commute_willingness = dbQuery("commute_willingness")
	m_or_f = dbQuery("m_or_f")
		if isnull(m_or_f) then m_or_f = ""
	
	
	application_says_m_or_f = dbQuery("workConviction")
	select case application_says_m_or_f
	case "n"
		application_says_m_or_f = "<p class=""appsays"">Employment Application says they DO NOT have any Felonies or Misdemeanors.</p>"
	case "m"
		application_says_m_or_f = "<p class=""appsays"">Employment Application says they HAVE a Misdemeanor.</p>"
	case "f"
		application_says_m_or_f = "<p class=""appsays"">Employment Application says they HAVE a Felony.</p>"
	case else
		application_says_m_or_f = "<p class=""appsays"">Employment Application does not say.</p>"
	end select

	about_criminal = dbQuery("about_criminal")
	application_says_about_criminal = dbQuery("workConvictionExplain")
	if len(application_says_about_criminal) > 0 then
		application_says_about_criminal = "<p class=""appsays"">Employment Application says: " & application_says_about_criminal & "</p>"
	end if
	
	on_porp = dbQuery("on_porp")
		if isnull(on_porp) then on_porp = ""

	porp_restrictions = dbQuery("porp_restrictions")
	
	currently_employed = dbQuery("currently_employed")
		if isnull(currently_employed) then currently_employed = ""

	application_says_currently_employed = dbQuery("currentlyEmployed")
	select case application_says_currently_employed
	case "y"
		application_says_currently_employed = "<p class=""appsays"">Employment Application says they ARE currently employed.</p>"
	case "n"
		application_says_currently_employed = "<p class=""appsays"">Employment Application says they are NOT currently employed.</p>"
	case else
		application_says_currently_employed = "<p class=""appsays"">Employment Application does not say.</p>"
	end select

	pass_drug_screen = dbQuery("pass_drug_screen")
		if isnull(pass_drug_screen) then pass_drug_screen = ""

	can_start_work = dbQuery("can_start_work")
	needs_awareness = dbQuery("needs_awareness")
		if isnull(needs_awareness) then needs_awareness = ""
	needs_awareness_notes = dbQuery("needs_awareness_notes")
	
	worked_for_staffing = dbQuery("worked_for_staffing")
		if isnull(worked_for_staffing) then worked_for_staffing = ""
	worked_for_staffing_notes = dbQuery("worked_for_staffing_notes")
	
	work_history = dbQuery("work_history")
	
	application_says_work_history = "<p class=""appsays""><table class=""workhistory""><tr><th>Job One</th><th>Job Two</th><th>Job Three</th></tr><tr>" &_
		"<td>" &_	
		"Employer: " & dbQuery("employerNameHistOne") & "<br>" &_
		"Phone: " & dbQuery("jobHistPhoneOne")  & "<br>" &_
		"Address: " & dbQuery("jobHistAddOne")  & "<br>" &_
		"City, St ZIP:" & dbQuery("jobHistCityOne") & ", " & dbQuery("jobHistStateOne") & " " & dbQuery("jobHistZipOne") & "<br>" &_
		"Pay Info: " & dbQuery("jobHistPayOne") & "<br>" &_
		"Supervisor: " & dbQuery("jobHistSupervisorOne") & "<br><br>" &_
		"</td>" &_  
		"<td>" &_ 
		"Employer: " & dbQuery("employerNameHistTwo") & "<br>" &_
		"Phone: " & dbQuery("jobHistPhoneTwo") & "<br>" &_
		"Address: " & dbQuery("jobHistAddTwo") & "<br>" &_
		"City, St ZIP:" & dbQuery("jobHistCityTwo") & ", " & dbQuery("jobHistStateTwo") & " " & dbQuery("jobHistZipTwo") & "<br>" &_
		"Pay Info: " & dbQuery("jobHistPayTwo") & "<br>" &_
		"Supervisor: " &  dbQuery("jobHistSupervisorTwo") & "<br><br>" &_
		"</td>" &_ 
		"<td>" &_
		"Employer: " & dbQuery("employerNameHistThree") & "<br>" &_
		"Phone: " & dbQuery("jobHistPhoneThree") & "<br>" &_
		"Address: " & dbQuery("jobHistAddThree") & "<br>" &_
		"City, St ZIP:" & dbQuery("jobHistCityThree") & ", " & dbQuery("jobHistStateThree") & " " & dbQuery("jobHistZipThree") & "<br>" &_
		"Pay Info: " & dbQuery("jobHistPayThree") & "<br>" &_
		"Supervisor: " & dbQuery("jobHistSupervisorThree") & "<br><br>" &_
		"</td>" &_ 
		"</tr>" &_
		
		"<tr><td>" &_	
		"Duties were: " & dbQuery("jobDutiesOne") & "<br><br>" &_
		"</td>" &_  
		"<td>" &_ 
		"Duties were: " & dbQuery("jobDutiesTwo") & "<br><br>" &_
		"</td>" &_ 
		"<td>" &_
		"Duties were: " & dbQuery("jobDutiesThree") & "<br><br>" &_
		"</td></tr>" &_ 
		
			"<tr><td>" &_	
		
		"Worked from: " & dbQuery("jobHistFromDateOne") & " to " & dbQuery("jobHistToDateOne") & "<br><br>" &_
		"Reason left: " & dbQuery("jobReasonOne") &_
		"</td>" &_  
		"<td>" &_ 
	
		"Worked from: " & dbQuery("jobHistFromDateTwo") & " to " & dbQuery("jobHistToDateTwo") & "<br><br>" &_
		"Reason left: " & dbQuery("jobReasonTwo") &_
		"</td>" &_ 
		"<td>" &_

		"Worked from: " & dbQuery("jobHistFromDateThree") & " to " & dbQuery("jobHistToDateThree") & "<br><br>" &_
		"Reason left: " & dbQuery("jobReasonThree") &_
		"</td></tr>" &_ 
		"</table></p>" 
	
	employment_gaps = dbQuery("employment_gaps")
	more_skills = dbQuery("more_skills")
	certifications = dbQuery("certifications")
	have_resume = dbQuery("have_resume")
		if isnull(have_resume) then have_resume = ""
	paperwork_completed = dbQuery("paperwork_completed")
		if isnull(paperwork_completed) then paperwork_completed = ""
	w4_reviewed = dbQuery("w4_reviewed")
		if isnull(w4_reviewed) then w4_reviewed = ""
	i9_reviewed = dbQuery("i9_reviewed")
		if isnull(i9_reviewed) then i9_reviewed = ""
	any_questions = dbQuery("any_questions")
		if isnull(any_questions) then any_questions = ""
	welcome_given = dbQuery("welcome_given")
		if isnull(welcome_given) then welcome_given = ""
	calling_explained = dbQuery("calling_explained")
		if isnull(calling_explained) then calling_explained = ""
	interview_complete = dbQuery("interview_complete")
		if isnull(interview_complete) then interview_complete = ""

	modifiedDate = dbQuery("modifiedDate")
	employerNameHistOne = dbQuery("employerNameHistOne")
	jobHistAddOne = dbQuery("jobHistAddOne")
	jobHistPhoneOne = dbQuery("jobHistPhoneOne")
	jobHistCityOne = dbQuery("jobHistCityOne")
	jobHistStateOne = dbQuery("jobHistStateOne")
	jobHistZipOne = dbQuery("jobHistZipOne")
	jobHistPayOne = dbQuery("jobHistPayOne")
	jobHistSupervisorOne = dbQuery("jobHistSupervisorOne")
	jobDutiesOne = dbQuery("jobDutiesOne")
	jobHistFromDateOne = dbQuery("jobHistFromDateOne")
	JobHistToDateOne = dbQuery("JobHistToDateOne")
	jobReasonOne = dbQuery("jobReasonOne")
	employerNameHistTwo = dbQuery("employerNameHistTwo")
	jobHistAddTwo = dbQuery("jobHistAddTwo")
	jobHistPhoneTwo = dbQuery("jobHistPhoneTwo")
	jobHistCityTwo = dbQuery("jobHistCityTwo")
	jobHistStateTwo = dbQuery("jobHistStateTwo")
	jobHistZipTwo = dbQuery("jobHistZipTwo")
	jobHistPayTwo = dbQuery("jobHistPayTwo")
	jobHistSupervisorTwo = dbQuery("jobHistSupervisorTwo")
	jobDutiesTwo = dbQuery("jobDutiesTwo")
	jobHistFromDateTwo = dbQuery("jobHistFromDateTwo")
	JobHistToDateTwo = dbQuery("JobHistToDateTwo")
	jobReasonTwo = dbQuery("jobReasonTwo")
	employerNameHistThree = dbQuery("employerNameHistThree")
	jobHistAddThree = dbQuery("jobHistAddThree")
	jobHistPhoneThree = dbQuery("jobHistPhoneThree")
	jobHistCityThree = dbQuery("jobHistCityThree")
	jobHistStateThree = dbQuery("jobHistStateThree")
	jobHistZipThree = dbQuery("jobHistZipThree")
	jobHistPayThree = dbQuery("jobHistPayThree")
	jobHistSupervisorThree = dbQuery("jobHistSupervisorThree")
	jobDutiesThree = dbQuery("jobDutiesThree")
	jobHistFromDateThree = dbQuery("jobHistFromDateThree")
	JobHistToDateThree = dbQuery("JobHistToDateThree")
	jobReasonThree = dbQuery("jobReasonThree")

	Set dbQuery = Nothing
end if
Database.Close

function save_interview ()
	
	applicantId = request.form("app_id")
	interviewId = request.form("int_id")
	interviewerid = request.form("interviewerid")
	interviewTime = request.form("interviewTime")
	modifiedDate = request.form("modifiedDate")
	creationDate = request.form("creationDate")
	kind_of_work = request.form("kind_of_work")
	full_or_part_time = request.form("full_or_part_time")
	accept_temporary = request.form("accept_temporary")
	accept_longterm = request.form("accept_longterm")
	days_available = request.form("days_available")
	dim arrWeekDays, intWeekDays, strWeekDay
		arrWeekDays = split(days_available, ",")
		intWeekDays = 0
		for each strWeekDay in arrWeekDays
			intWeekDays = intWeekDays + cint(strWeekDay)
		next
	
	work_any_shift = request.form("work_any_shift")
	which_shifts = replace(request.form("which_shifts"), ", ", ",")
	special_availability = request.form("special_availability")
	wage_willing = request.form("wage_willing")
	valid_dl = request.form("valid_dl")
	proof_insured = request.form("proof_insured")
	getting_there = request.form("getting_there")
	commute_willingness = request.form("commute_willingness")
	m_or_f = replace(request.form("m_or_f"), ", ", ",")
	about_criminal = request.form("about_criminal")
	on_porp = request.form("on_porp")
	porp_restrictions = request.form("porp_restrictions")
	currently_employed = request.form("currently_employed")
	pass_drug_screen = request.form("pass_drug_screen")
	can_start_work = request.form("can_start_work")
	needs_awareness = request.form("needs_awareness")
	needs_awareness_notes = request.form("needs_awareness_notes")
	worked_for_staffing = request.form("worked_for_staffing")
	worked_for_staffing_notes = request.form("worked_for_staffing_notes")
	work_history = request.form("work_history")
	employment_gaps = request.form("employment_gaps")
	more_skills = request.form("more_skills")
	certifications = request.form("certifications")
	have_resume = request.form("have_resume")
	paperwork_completed = request.form("paperwork_completed")
	w4_reviewed = request.form("w4_reviewed")
	i9_reviewed = request.form("i9_reviewed")
	any_questions = request.form("any_questions")
	welcome_given = request.form("welcome_given")
	calling_explained = request.form("calling_explained")
	interview_complete = request.form("interview_complete")
	
'			"interviewID=" & insert_number(interviewID) &_
'			"applicantid = '', " &_ insert_string()

		sql = "UPDATE tbl_interviews SET " &_
			"interviewerid=" & insert_number(user_id) & ", " &_
			"interviewTime=now()" & ", " &_
			"modifiedDate=now()" & ", " &_
			"kind_of_work=" & insert_string(kind_of_work) & ", " &_
			"full_or_part_time=" & insert_string(full_or_part_time) & ", " &_
			"accept_temporary=" & insert_string(accept_temporary) & ", " &_
			"accept_longterm=" & insert_string(accept_longterm) & ", " &_
			"days_available=" & insert_number(intWeekDays) & ", " &_
			"work_any_shift=" & insert_string(work_any_shift) & ", " &_
			"which_shifts=" & insert_string(which_shifts) & ", " &_
			"special_availability=" & insert_string(special_availability) & ", " &_
			"wage_willing=" & insert_string(wage_willing) & ", " &_
			"valid_dl=" & insert_string(valid_dl) & ", " &_
			"proof_insured=" & insert_string(proof_insured) & ", " & _
			"getting_there=" & insert_string(getting_there) & ", " &_
			"commute_willingness=" & insert_string(commute_willingness) & ", " &_
			"m_or_f=" & insert_string(m_or_f) & ", " &_
			"about_criminal=" & insert_string(about_criminal) & ", " &_
			"on_porp=" & insert_string(on_porp) & ", " &_
			"porp_restrictions=" & insert_string(porp_restrictions) & ", " &_
			"currently_employed=" & insert_string(currently_employed) & ", " &_
			"pass_drug_screen=" & insert_string(pass_drug_screen) & ", " &_
			"can_start_work=" & insert_string(can_start_work) & ", " &_
			"needs_awareness=" & insert_string(needs_awareness) & ", " &_
			"needs_awareness_notes=" & insert_string(needs_awareness_notes) & ", " &_
			"worked_for_staffing=" & insert_string(worked_for_staffing) & ", " &_
			"worked_for_staffing_notes=" & insert_string(worked_for_staffing_notes) & ", " &_
			"work_history=" & insert_string(work_history) & ", " &_
			"employment_gaps=" & insert_string(employment_gaps) & ", " &_
			"more_skills=" & insert_string(more_skills) & ", " &_
			"certifications=" & insert_string(certifications) & ", " &_
			"have_resume=" & insert_string(have_resume) & ", " &_
			"paperwork_completed=" & insert_string(paperwork_completed) & ", " &_
			"w4_reviewed=" & insert_string(w4_reviewed) & ", " &_
			"i9_reviewed=" & insert_string(i9_reviewed) & ", " &_
			"any_questions=" & insert_string(any_questions) & ", " &_
			"welcome_given=" & insert_string(welcome_given) & ", " &_
			"calling_explained=" & insert_string(calling_explained) & ", "  &_
			"interview_complete=" & insert_string(interview_complete) & " "  &_
			"WHERE applicationid=" & applicantid
	'save interview
	Database.Open MySql

	set dbQuery = Database.Execute(sql)
	
	if not userLevelRequired(userLevelScreened) then
	
		Database.Execute("UPDATE tbl_users SET userLevel=" & insert_number(userLevelScreened) & "' WHERE applicationID=" & insert_number(applicationid))
			
	end if

	'build interview note
	dim strNoteTemplate
	strNoteTemplate = "/* " &_
		"Id=" & interviewId & ", Applicant=" & applicantId &_
		", Interviewer=" & user_id & ", Created='" & Date & "' */" & vbCrLf &_
	
		"             Kind of work : { " & kind_of_work & " }" & vbCrLf &_
		"        Willing to accept : { "
		
		select case full_or_part_time
		case "f"
			strNoteTemplate = strNoteTemplate & "Full-Time"
		case "p"
			strNoteTemplate = strNoteTemplate & "Part-Time"
		end select
		
		strNoteTemplate = strNoteTemplate & " }" & vbCrLf &_
		"Temporary/Short-term work : { "
		
		select case accept_temporary
		case "y"
			strNoteTemplate = strNoteTemplate & "Yes"
		case "n"
			strNoteTemplate = strNoteTemplate & "No"
		end select

		strNoteTemplate = strNoteTemplate & " }" & vbCrLf &_
		"      Long-term work okay : { "
		
		select case accept_longterm
		case "y"
			strNoteTemplate = strNoteTemplate & "Yes"
		case "n"
			strNoteTemplate = strNoteTemplate & "No"
		end select
		
		dim strTheseDays
		strTheseDays = days_available
		strTheseDays = replace(strTheseDays, "128,", "Any")
		strTheseDays = replace(strTheseDays, "8,", "Thu")
		strTheseDays = replace(strTheseDays, "32,", "Sat")
		strTheseDays = replace(strTheseDays, "64", "Sun")
		strTheseDays = replace(strTheseDays, "1,", "Mon")
		strTheseDays = replace(strTheseDays, "2,", "Tue")
		strTheseDays = replace(strTheseDays, "4,", "Wed")
		strTheseDays = replace(strTheseDays, "16,", "Fri")
		
		strNoteTemplate = strNoteTemplate & " }" & vbCrLf &_
		"   Days of week available : { " & strTheseDays & " }" & vbCrLf &_
		"          Shifts Can work : { "
		
		if instr(work_any_shift, "d") > 0 then
			strNoteTemplate = strNoteTemplate & "Day"
		end if
		if instr(work_any_shift, "s") > 0 then
			strNoteTemplate = strNoteTemplate & "Swing"
		end if
		if instr(work_any_shift, "g") > 0 then
			strNoteTemplate = strNoteTemplate & "Graveyard"
		end if
		strNoteTemplate = replace(strNoteTemplate, "DaySwing", "Day / Swing")
		strNoteTemplate = replace(strNoteTemplate, "SwingGraveyard", "Swing / Graveyard")

		strNoteTemplate = strNoteTemplate & "}" & vbCrLf &_
		"    Special Circumstances : { " & special_availability & " }" & vbCrLf &_
		"              Needed wage : { " & wage_willing & " }" & vbCrLf &_
		"         Driver’s license : { "
		
		select case valid_dl
		case "y"
			strNoteTemplate = strNoteTemplate & "Yes"
		case "n"
			strNoteTemplate = strNoteTemplate & "No"
		end select
		strNoteTemplate = strNoteTemplate & "}" & vbCrLf &_
		"           Vehicle to use : { " & getting_there & " }" & vbCrLf &_
		"  Proof of Auto-Insurance : { "
		
		select case proof_insured
		case "y"
			strNoteTemplate = strNoteTemplate & "Yes"
		case "n"
			strNoteTemplate = strNoteTemplate & "No"
		end select
		strNoteTemplate = strNoteTemplate & " }" & vbCrLf &_
		"            Area for work : { " & commute_willingness & " }" & vbCrLf &_
		"     Criminal Convictions : { "
		
		select case m_or_f
		case "n"
			strNoteTemplate = strNoteTemplate & "None"
		case "m"
			strNoteTemplate = strNoteTemplate & "Misdemeanor: " & about_criminal
		case "f"
			strNoteTemplate = strNoteTemplate & "Felony: " & about_criminal
		end select
			
		strNoteTemplate = strNoteTemplate & " }" & vbCrLf &_
		"         P&P Restrictions : { "
		
		select case on_porp
		case "y"
			if len(porp_restrictions) > 0 then
				strNoteTemplate = strNoteTemplate & "Yes, with restrictions: " & porp_restrictions
			else
				strNoteTemplate = strNoteTemplate & "Yes, No Restrictions"
			end if
			
		case "n"
			strNoteTemplate = strNoteTemplate & "No"
		end select
		
		strNoteTemplate = strNoteTemplate & " }" & vbCrLf &_
		"       Currently employed : { " & currently_employed & " }" & vbCrLf &_
		"     Can pass drug screen : { " & pass_drug_screen & " }" & vbCrLf &_
		"  Available to start work : { " &  can_start_work & " }" & vbCrLf &_
		"                   Resume : { have_resume }" & vbCrLf &_
		vbCrLf &_
		"Work history: { " & work_history & " }" & vbCrLf &_
		vbCrLf &_
		"-------------- Applicant Application Work History --------------" & vbCrLf &_
		application_says_work_history &_
		"----------------------------------------------------------------" & vbCrLf &_
		vbCrLf &_
		"Additional Job skills:" & vbCrLf &_
		"{ " & more_skills & " }" & vbCrLf &_
		vbCrLf &_
		"Certifications or any high-skill: " & vbCrLf &_
		"{ " & certifications & " }"

	sql = "SELECT inPER, inIDA, inBOI, inBUR " &_
		"FROM tbl_applications " &_
		"WHERE tbl_applications.applicationID=" & app_id

	set dbQuery = Database.Execute(sql)
	if not dbQuery.eof then
		dim inTemps(3)
		'PER = 0, BUR = 1, BOI = 2, IDA = 3
		inTemps(PER) = dbQuery("inPER")
		inTemps(BUR) = dbQuery("inBUR")
		inTemps(BOI) = dbQuery("inBOI")
		inTemps(IDA) = dbQuery("inIDA")
	end if	
	set dbQuery = Nothing
	Database.Close

	dim dbTemps
	Set dbTemps = Server.CreateObject("ADODB.Connection")
	
	dim i, t_str
	for i = 0 to 3
		if inTemps(i) > 0 then
			dbTemps.Open dsnLessTemps(i)
			sql = "SELECT * FROM NotesApplicants WHERE ApplicantId=" & inTemps(i)
			set dbQuery = dbTemps.Execute(sql)
			if not dbQuery.eof then

				strNoteTemplate = Replace(strNoteTemplate & vbCrLf & dbQuery("Notes"), Chr(34), Chr(34) & Chr(34))
				
				sql = "UPDATE NotesApplicants " &_
					"SET Notes='+strNoteTemplate+' " &_
					"WHERE ApplicantId=" & inTemps(i)

				set dbQuery = dbTemps.Execute(sql)
			end if
			dbTemps.Close			
		end if

	next
	
	Response.Redirect("/include/system/tools/activity/applications/view/?" & request.form("return_QS"))
end function

sub checked
	response.write "checked=""checked"""
end sub

sub mkInitialInterviewAppnt

	dim cmd
	set cmd = Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = MySql
		.CommandText =	"" &_
			"SELECT inPER, inIDA, inBOI, inBUR " &_
			"FROM tbl_applications " &_
			"WHERE tbl_applications.applicationID=" & app_id
	end with
	dim rsTempsIds
	set rsTempsIds = cmd.Execute()

	if not rsTempsIds.eof then
		dim inTemps(3)
		'PER = 0, BUR = 1, BOI = 2, IDA = 3
		inTemps(PER) = rsTempsIds("inPER")
		inTemps(BUR) = rsTempsIds("inBUR")
		inTemps(BOI) = rsTempsIds("inBOI")
		inTemps(IDA) = rsTempsIds("inIDA")
	end if	
	set rsTempsIds = Nothing

	const DispTypeCode = 3 'Disposistion status for 'TookPlace'
	Const ApptType = 19 'Appointment type for 'Initial Interview'
	
	dim strWhatWasDone
	dim strApplicantInterviewed

	dim rsName

	dim i, t_str
	for i = 0 to 3
		if inTemps(i) > 0 then
			with cmd
				.ActiveConnection = dsnLessTemps(i)
				.CommandText = "SELECT LastnameFirst FROM Applicants WHERE ApplicantId=" & inTemps(i)
			end with
			set rsName = cmd.Execute()
			
			if not rsName.eof then
				strApplicantInterviewed = rsName("LastnameFirst")
			
				strWhatWasDone = "Initial Interview for " & strApplicantInterviewed & " by " &_
				"VMS User " & user_name & " (" & Request.ServerVariables("REMOTE_ADDR") & ")"
			
				cmd.CommandText = "" &_
					"INSERT INTO Appointments " &_
						"(AppDate, ApplicantId, Comment, AssignedTo, ApptTypeCode, DispTypeCode, ContactId, Entered, EnteredBy, LocationId)" &_
						"VALUES (" &_
							"'" & Date() & "', " & _
							insert_number(inTemps(i)) & ", " &_
							insert_string(strWhatWasDone) & ", " &_
							insert_string("{Anyone}") & ", " &_
							insert_number(ApptType) & ", " &_
							insert_number(DispTypeCode) & ", 0, " &_
							"'" & Date() & "', " & _
							insert_string(tUser_id) & ", 1" &_
						")"
				cmd.Execute()
			end if
		end if
	next
	
	set cmd = nothing
	set rsName = nothing

end sub

%>
