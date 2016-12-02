<%
session("required_user_level") = 1024 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%

	dim which_applicant
	which_applicant = request.QueryString("id")
	if isnumeric(which_applicant) then
		which_applicant = cdbl(which_applicant)
	end if
	
	dim simcust, simsite
	simcust = replace(request.QueryString("simulate_customer"), "'", "''")
	if len(simcust & "") > 0 then
		whichCompanyID = "((HistoryDetail.Customer)='" & simcust & "') AND "
	elseif len(g_company_custcode.CustomerCode & "") > 0 then
		'whichCompanyID = "((HistoryDetail.Customer)='" & company_custcode & "') AND "
		g_company_custcode.SqlWhereAttribute = "HistoryDetail.Customer"
		whichCompanyID = "(" & g_company_custcode.SqlWhereString & ") AND "
	end if
	
	simsite = request.QueryString("simulate_site")
	if isnumeric(simsite) then
		simsite = cint(simsite)
	else
		simsite = ""
	end if

	dim order_how : order_how = "ORDER By LastnameFirst Asc"
	dim where_conditions : where_conditions = ""
	
	if company_dsn_site > -1 or simsite <> "" then
		
		if simsite <> "" then
			thisConnection = dsnLessTemps(simsite)
		else
			thisConnection = dsnLessTemps(company_dsn_site)
		end if

		Set getApplicants_cmd = Server.CreateObject ("ADODB.Command")
		With getApplicants_cmd
			.ActiveConnection = thisConnection
			.CommandText = "SELECT Applicants.ApplicantID, Applicants.LastnameFirst, Applicants.ApplicantStatus " &_
				"FROM Applicants " &_
				where_conditions & order_how
			.Prepared = true
		End With
		
		'break getApplicants_cmd.CommandText
		
		Set ApplicantList = getApplicants_cmd.Execute
		
		do while not ApplicantList.eof
			select case ApplicantList("ApplicantStatus")
			case 0
				Response.write "<span id=""id_" & ApplicantList("ApplicantID") & " class=""s0"">" & ApplicantList("LastnameFirst") & "</span>"
			case 1
				Response.write "<span id=""id_" & ApplicantList("ApplicantID") & " class=""s1"">" & ApplicantList("LastnameFirst") & "</span>"
			case 3
				Response.write "<span id=""id_" & ApplicantList("ApplicantID") & " class=""s3"">" & ApplicantList("LastnameFirst") & "</span>"
			case 2
				Response.write "<span id=""id_" & ApplicantList("ApplicantID") & " class=""s2"">" & ApplicantList("LastnameFirst") & "</span>"
			case 4
				Response.write "<span id=""id_" & ApplicantList("ApplicantID") & " class=""s4"">" & ApplicantList("LastnameFirst") & "</span>"
			end select

			ApplicantList.MoveNext
		loop
		Set ApplicantList = nothing
		Set getApplicants_cmd = Nothing
	end if
	
	session("no_header") = false
%>


-+