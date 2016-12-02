<%

class cAppointment

	'Private, class member variable
	private m_id
	private m_Comment
	private m_ApplicantPhone
	private m_CustomerPhone
	private m_WorkSitePhone
	private m_ApplicantId
	private m_LastnameFirst
	private m_LnkMaintain
	private m_LnkResource
	private m_WhichCompany
	private m_ApptDate
	private m_ApptType
	private m_ApptTypeCode
	private m_Disposition
	private m_DispTypeCode
	private m_EnteredBy
	private m_AssignedTo
	private m_CustomerCode
	private m_CustomerName
	private m_CustomerContact
	private m_JobSupervisor
	private m_ReferenceId
	private m_JobDescription

	public property get id()
		id = m_id
	end property
	public property let id(p_id)
		m_id = p_id
	end property

	'Comment
	Public Property Get Comment()
		if len(m_Comment) = 0 then
			Comment = "{none}"
		else
			Comment = m_Comment
		end if
	end property
	public property let Comment(p_Comment)
		m_Comment = p_Comment
	end property

	public property get ApplicantPhone()
		ApplicantPhone = FormatPhone(m_ApplicantPhone)
	end property
	public property let ApplicantPhone(p_ApplicantPhone)
		m_ApplicantPhone = p_ApplicantPhone
	end property

	public property get CustomerPhone()
		CustomerPhone = FormatPhone(m_CustomerPhone)
	end property
	public property let CustomerPhone(p_CustomerPhone)
		m_CustomerPhone = p_CustomerPhone
	end property

	public property get WorkSitePhone()
		WorkSitePhone = FormatPhone(m_WorkSitePhone)
	end property
	public property let WorkSitePhone(p_WorkSitePhone)
		m_WorkSitePhone = p_WorkSitePhone
	end property

	public property get ApplicantId()
		ApplicantId = m_ApplicantId
	end property
	public property let ApplicantId(p_ApplicantId)
		m_ApplicantId = p_ApplicantId
	end property

	public property get LastnameFirst()
		LastnameFirst = m_LastnameFirst
	end property
	public property let LastnameFirst(p_LastnameFirst)
		m_LastnameFirst = p_LastnameFirst
	end property
	public property get LnkMaintain()
		m_LnkResource = "/include/system/tools/activity/forms/maintainApplicant.asp?"
		LnkMaintain = "<a href=""" & m_LnkResource & "who=" & m_ApplicantId & "&where=" & whichCompany & """>" &_
					m_ApplicantId & " : " & m_LastnameFirst

	end property
	public property let LnkMaintain(p_LnkMaintain)
		m_LnkMaintain = p_LnkMaintain
	end property

	public property get LnkResource()
		if m_LnkResource = "" then
			m_LnkResource = "/include/system/tools/activity/forms/maintainApplicant.asp?"
		end if
		
		LnkResource = m_LnkResource
	end property
	public property let LnkResource(p_LnkResource)
		m_LnkResource = p_LnkResource
	end property

	public property get ApptDate()
		ApptDate = m_ApptDate
	end property
	public property let ApptDate(p_ApptDate)
		m_ApptDate = cstr(p_ApptDate)
	end property

	public property get ApptType()
		dim ChangeAppointment, CurrentAppointment(19)
		if not isnull(m_ApptTypeCode) then
			CurrentAppointment(cint(m_ApptTypeCode)) = " selected=""selected"""
		end if
			
		ChangeAppointment = "" &_
			"<span id=""appointment" & m_id & """ class=""disposition"" onclick=""appttype.show('" & m_id & "')"">" &_
				m_ApptType &_
			"</span>" &_
			"<span id=""setappointment" & m_id & """ class=""hide"">" &_
				"<select class=""setdispo"" name=""setappt" & m_id & """ id=""setappt" & m_id & """ onblur=""appttype.hide('" & m_id & "')"" onchange=""appttype.set('" & m_id & "')"">" &_
					"<option value=""0""" & CurrentAppointment(0) & ">Initial Interview</option>" &_
					"<option value=""3""" & CurrentAppointment(3) & ">Other</option>" &_
					"<option value=""4""" & CurrentAppointment(4) & ">Arrival Call</option>" &_
					"<option value=""5""" & CurrentAppointment(5) & ">Marketing Call</option>" &_
					"<option value=""6""" & CurrentAppointment(6) & ">Placement Follow-Up</option>" &_
					"<option value=""7""" & CurrentAppointment(7) & ">Sent Resume</option>" &_
					"<option value=""8""" & CurrentAppointment(8) & ">Unemployment</option>" &_
					"<option value=""9""" & CurrentAppointment(9) & ">CS Order/Garnishment</option>" &_
					"<option value=""11""" & CurrentAppointment(11) & ">Collection Call</option>" &_
					"<option value=""12""" & CurrentAppointment(12) & ">Separation</option>" &_
					"<option value=""13""" & CurrentAppointment(13) & ">Job Order Correspondence</option>" &_
					"<option value=""14""" & CurrentAppointment(14) & ">Client QA & Correspondence</option>" &_
					"<option value=""15""" & CurrentAppointment(15) & ">Availability</option>" &_
					"<option value=""16""" & CurrentAppointment(16) & ">Rates</option>" &_
					"<option value=""17""" & CurrentAppointment(17) & ">Work Comp</option>" &_
					"<option value=""18""" & CurrentAppointment(18) & ">Accident</option>" &_
					"<option value=""19""" & CurrentAppointment(19) & ">Interviewed</option>" &_
				"</select>" &_
			"</span>"

		ApptType = ChangeAppointment

	end property
	public property let ApptType(p_ApptType)
		m_ApptType = p_ApptType
	end property
	public property let ApptTypeCode(p_ApptTypeCode)
		m_ApptTypeCode = p_ApptTypeCode
	end property

	public property get Disposition()
		dim ChangeDisposition, CurrentDisposition(4)
			select case m_DispTypeCode
				case 0
					CurrentDisposition(0) = " selected=""selected"""
				case 1
					CurrentDisposition(1) = " selected=""selected"""
				case 2
					CurrentDisposition(2) = " selected=""selected"""
				case 3
					CurrentDisposition(3) = " selected=""selected"""
				case 4
					CurrentDisposition(4) = " selected=""selected"""
			end select
			
			ChangeDisposition = "" &_
				"<span id=""disposition" & m_id & """ class=""disposition"" onclick=""dispositions.show('" & m_id & "')"">" &_
					m_Disposition &_
				"</span>" &_
				"<span id=""setdisposition" & m_id & """ class=""hide"">" &_
					"<select class=""setdispo"" name=""setdisp" & m_id & """ id=""setdisp" & m_id & """ onblur=""dispositions.hide('" & m_id & "')"" onchange=""dispositions.set('" & m_id & "')"">" &_
						"<option value=""0""" & CurrentDisposition(0) & ">Active</option>" &_
						"<option value=""1""" & CurrentDisposition(1) & ">Re-scheduled</option>" &_
						"<option value=""2""" & CurrentDisposition(2) & ">Called-In</option>" &_
						"<option value=""3""" & CurrentDisposition(3) & ">Took Place</option>" &_
						"<option value=""4""" & CurrentDisposition(4) & ">No Show</option>" &_
					"</select>" &_
				"</span>"

		Disposition = ChangeDisposition
	end property
	public property let Disposition(p_Disposition)
		m_Disposition = p_Disposition
	end property

	public property let DispTypeCode(p_DispTypeCode)
		m_DispTypeCode = p_DispTypeCode
	end property

	public property get EnteredBy()
		EnteredBy = m_EnteredBy
	end property
	public property let EnteredBy(p_EnteredBy)
		m_EnteredBy = p_EnteredBy
	end property

	public property get AssignedTo()
		AssignedTo = m_AssignedTo
	end property
	public property let AssignedTo(p_AssignedTo)
		m_AssignedTo = p_AssignedTo
	end property

	public property get CustomerCode()
		CustomerCode = m_CustomerCode
	end property
	public property let CustomerCode(p_CustomerCode)
		m_CustomerCode = p_CustomerCode
	end property

	public property get CustomerName()
		CustomerName = m_CustomerName
	end property
	public property let CustomerName(p_CustomerName)
		m_CustomerName = p_CustomerName
	end property

	public property get CustomerContact()
		if len(m_CustomerContact) > 0 then
			CustomerContact = m_CustomerContact & " : "
		end if
	end property
	public property let CustomerContact(p_CustomerContact)
		m_CustomerContact = p_CustomerContact
	end property

	public property get JobSupervisor()
		JobSupervisor = m_JobSupervisor
	end property
	public property let JobSupervisor(p_JobSupervisor)
		m_JobSupervisor = p_JobSupervisor
	end property

	public property get ReferenceId()
		ReferenceId = m_ReferenceId
	end property
	public property let ReferenceId(p_ReferenceId)
		m_ReferenceId = p_ReferenceId
	end property

	public property get JobDescription()
		JobDescription = m_JobDescription
	end property
	public property let JobDescription(p_JobDescription)
		m_JobDescription = p_JobDescription
	end property

end class

class cPlacements

	'Private, class member variable
	private m_Appointments
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Appointments = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Appointments = Nothing
	End Sub

	'Read the current Placements
	Public Property Get Appointments()
		Set Appointments = m_Appointments
	End Property

	'Read the current Placements
	Public Property Get PageCount()
		PageCount = m_PageCount
	End Property

	'set page size
	Public Property Let ItemsPerPage(p_ItemsPerPage)
		m_ItemsPerPage = p_ItemsPerPage
	end property

	public property let Page(p_Page)
		m_Page = p_Page
	end property


	'#############  Public Functions ##############

		public function GetAllAppointments()
		
		dim strWhere
		if onlyactive then
			strWhere = "(ApptTypes.ApptTypeCode >= 0 AND Appointments.DispTypeCode=0)"
		else
			strWhere = "(ApptTypes.ApptTypeCode >= 0)"
		end if
		
		
		if len(foruser) > 0 then
			strWhere = "((AssignedTo='" & foruser & "' OR (AssignedTo='{anyone}' AND EnteredBy='" & foruser &"')) AND " & strWhere & ") "
		end if
		
		if is_service then
			strWhere = "(" & strWhere & "AND AppDate <= '" & Date() & "') "
		end if
		strWhere = "WHERE " & strWhere
		
			dim strSQL
			strSQL  = "" &_
					"SELECT Appointments.Id, Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
					"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
					"Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.EnteredBy, " &_
					"Dispositions.Disposition, Dispositions.DispTypeCode, ApptTypes.ApptType, ApptTypes.ApptTypeCode, Appointments.AssignedTo " &_
					"FROM Dispositions RIGHT JOIN (ApptTypes  " &_
					"RIGHT JOIN (((Appointments LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID)  " &_
					"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer)  " &_
					"LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode)  " &_
					"ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
					strWhere &_
					"ORDER BY Appointments.AppDate DESC;"
			
		end function

		
		public function GetPageSelection()

			const StartSlide = 32 ' when to start sliding
			const StopSlide = 112 'when to stop sliding and show the smallest amount
			const SlideRange = 8 'the most pages to show minus this = smallest number to show aka the slide
			const TopPages = 25 'the most records to show
			
			dim maxPages, slidePages

			if m_Page <= StartSlide then
				maxPages = TopPages
			elseif m_Page > StartSlide and m_Page < StopSlide then
				maxPages = TopPages - (SlideRange - Cint(SlideRange * ((StopSlide - m_Page)/(StopSlide - StartSlide))))
			else
				maxPages = TopPages - SlideRange
			end if
			slidePages = cint((maxPages/2)+0.5)

			dim startPage, stopPage
			if m_PageCount > maxPages then
				startPage = nPage - slidePages
				stopPage = nPage + slidePages
				
				'check if startPages is less than 1
				if startPage < 1 then
					startPage = 1
					stopPage = maxPages
				end if
				'check if stopPages is greater than total pages
				if stopPage > m_PageCount then
					stopPage = m_PageCount
					startPage = m_PageCount - slidePages
				end if
			else
				startPage = 1
				stopPage = m_PageCount
			end if

			
			rsQuery = request.serverVariables("QUERY_STRING")
			queryPageNumber = Request.QueryString("Page")
			if queryPageNumber then
				rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
			end if
			
			dim p_strPageSelection
			p_strPageSelection = "<div id=""topPageRecords"" class=""navPageRecords"">" &_
				"<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & whichCompany & """>First</A>"
				For i = startPage to stopPage
					p_strPageSelection = p_strPageSelection &_
						"<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & """>&nbsp;"
					if i = nPage then
						p_strPageSelection = p_strPageSelection &_
							"<span style=""color:red"">" & i & "</span>"
					Else
						p_strPageSelection = p_strPageSelection & i
					end if
					p_strPageSelection = p_strPageSelection &"&nbsp;</A>"
				Next
			p_strPageSelection = p_strPageSelection &_
				"<A HREF=""" & aspPageName & "?Page=" & m_PageCount & "&whichCompany=" & whichCompany & """>Last</A>" &_
				"</div>"

			GetPageSelection = p_strPageSelection
		end function

	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillPlacementsFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
					
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisAppointment
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				set thisAppointment = New cAppointment
				thisAppointment.id                = p_RS.fields("Id").Value
				thisAppointment.Comment           = p_RS.fields("Comment").Value
				thisAppointment.ApplicantPhone    = p_RS.fields("TelePhone").Value
				thisAppointment.CustomerPhone     = p_RS.fields("Phone").Value
				thisAppointment.WorkSitePhone     = p_RS.fields("WorkSite3").Value
				thisAppointment.ApplicantId       = p_RS.fields("ApplicantID").Value
				thisAppointment.LastnameFirst     = p_RS.fields("LastnameFirst").Value
				thisAppointment.ApptDate          = p_RS.fields("AppDate").Value
				thisAppointment.ApptType          = p_RS.fields("ApptType").Value
				thisAppointment.ApptTypeCode      = p_RS.fields("ApptTypeCode").Value
				thisAppointment.Disposition       = p_RS.fields("Disposition").Value
				thisAppointment.DispTypeCode      = p_RS.fields("DispTypeCode").Value
				thisAppointment.EnteredBy         = p_RS.fields("EnteredBy").Value
				thisAppointment.AssignedTo        = p_RS.fields("AssignedTo").Value
				thisAppointment.CustomerCode      = p_RS.fields("Customer").Value
				thisAppointment.CustomerName      = p_RS.fields("CustomerName").Value
				thisAppointment.CustomerContact   = p_RS.fields("Contact").Value
				thisAppointment.JobSupervisor     = p_RS.fields("JobSupervisor").Value
				thisAppointment.ReferenceId       = p_RS.fields("Reference").Value
				thisAppointment.JobDescription    = p_RS.fields("JobDescription").Value
				m_Appointments.Add thisAppointment.id, thisAppointment
				
				p_RS.movenext
			loop
		End Function

		Private Function LoadPlacementData(p_strSQL)
			dim rs
			set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getTempsDSN(whichCompany)))
			FillPlacementsFromRS(rs)
			LoadPlacementData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class


class cReminders

	'Private, class member variable
	private m_Appointments
	private m_NumberOfPages
	private m_ItemsPerPage
	private m_PageCount
	private m_Page

	Sub Class_Initialize()
		set m_Appointments = Server.CreateObject ("Scripting.Dictionary")
	End Sub
	Sub Class_Terminate()
		set m_Appointments = Nothing
	End Sub

	'Read the current Placements
	Public Property Get Appointments()
		Set Appointments = m_Appointments
	End Property

	'Read the current Placements
	Public Property Get PageCount()
		PageCount = m_PageCount
	End Property

	'set page size
	Public Property Let ItemsPerPage(p_ItemsPerPage)
		m_ItemsPerPage = p_ItemsPerPage
	end property

	public property let Page(p_Page)
		m_Page = p_Page
	end property


	'#############  Public Functions ##############

		public function GetAllAppointments()
			
			if appointment_id = 0 then
				dim strWhere
				if onlyactive then
					strWhere = "(ApptTypes.ApptTypeCode >= 0 AND Appointments.DispTypeCode=0)"
				else
					strWhere = "(ApptTypes.ApptTypeCode >= 0)"
				end if
				
				
				if len(foruser) > 0 then
					strWhere = "((AssignedTo='" & foruser & "' OR (AssignedTo='{anyone}' AND EnteredBy='" & foruser &"')) AND " & strWhere & ") "
				end if
				
				if is_service  and instr(callingApp, "/job_orders/") = 0 then
					strWhere = "(" & strWhere & "AND AppDate <= '" & DateAdd("n",15,now()) & "') "
				elseif 	instr(callingApp, "/job_orders/") > 0 then
					strWhere = "(" & strWhere & "AND AppDate <= '" & now() & "' "
				end if
				strWhere = "WHERE " & strWhere
			else
				strWhere = "WHERE Appointments.ID=" & appointment_id & " "
			end if

				dim strSQL
				strSQL  = "" &_
						"SELECT Appointments.Id, Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
						"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
						"Orders.JobNumber, Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.EnteredBy, " &_
						"Dispositions.Disposition, Dispositions.DispTypeCode, ApptTypes.ApptType, ApptTypes.ApptTypeCode, Appointments.AssignedTo " &_
						"FROM Dispositions RIGHT JOIN (ApptTypes  " &_
						"RIGHT JOIN (((Appointments LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID)  " &_
						"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer)  " &_
						"LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode)  " &_
						"ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
						strWhere &_
						"ORDER BY Appointments.AppDate DESC;"




			GetAllAppointments = LoadPlacementData (strSQL)
		end function

		public function GetJobOrderActivities()
			if appointment_id = 0 then
			
				dim strWhere
				if onlyactive then
					strWhere = "(ApptTypes.ApptTypeCode >= 0 AND Appointments.DispTypeCode=0)"
				else
					strWhere = "(ApptTypes.ApptTypeCode >= 0)"
				end if
				
				strWhere = "((Appointments.Reference=" & jobref & " AND Orders.JobNumber=" & dept & ") AND " & strWhere & ")"
				
				REM if len(foruser) > 0 then
					REM strWhere = "((AssignedTo='" & foruser & "' OR (AssignedTo='{anyone}' AND EnteredBy='" & foruser &"')) AND " & strWhere & ") "
				REM end if
				
				if is_service then
					strWhere = "(" & strWhere & "AND AppDate <= '" & DateAdd("n",15,now()) & "') "
				end if
				
				strWhere = "WHERE " & strWhere
			
			else
				strWhere = "WHERE Appointments.ID=" & appointment_id & " "
			
			end if
				
				
			dim strSQL
			strSQL  = "" &_
					"SELECT Appointments.Id, Appointments.AppDate, Appointments.Reference, Appointments.Customer, Appointments.Comment, " &_
					"Customers.Contact, Customers.Phone, Applicants.LastnameFirst, Applicants.Telephone, Orders.WorkSite3, Orders.JobSupervisor, " &_
					"Orders.JobNumber, Customers.CustomerName, Orders.JobDescription, Applicants.ApplicantID, Appointments.EnteredBy, " &_
					"Dispositions.Disposition, Dispositions.DispTypeCode, ApptTypes.ApptType, ApptTypes.ApptTypeCode, Appointments.AssignedTo " &_
					"FROM Dispositions RIGHT JOIN (ApptTypes  " &_
					"RIGHT JOIN (((Appointments LEFT JOIN Applicants ON Appointments.ApplicantId = Applicants.ApplicantID)  " &_
					"LEFT JOIN Customers ON Appointments.Customer = Customers.Customer)  " &_
					"LEFT JOIN Orders ON Appointments.Reference = Orders.Reference) ON ApptTypes.ApptTypeCode = Appointments.ApptTypeCode)  " &_
					"ON Dispositions.DispTypeCode = Appointments.DispTypeCode " &_
					strWhere &_
					"ORDER BY Appointments.AppDate DESC;"
					
			GetJobOrderActivities = LoadPlacementData (strSQL)
		end function

		
		public function GetPageSelection()
	
			const StartSlide = 32 ' when to start sliding
			const StopSlide = 112 'when to stop sliding and show the smallests amount
			const SlideRange = 8 'the most pages to show minus this = smallest number to show aka the slide
			const TopPages = 25 'the most records to show
			
			if m_PageCount > 1 then	
				dim maxPages, slidePages

				if m_Page <= StartSlide then
					maxPages = TopPages
				elseif m_Page > StartSlide and m_Page < StopSlide then
					maxPages = TopPages - (SlideRange - Cint(SlideRange * ((StopSlide - m_Page)/(StopSlide - StartSlide))))
				else
					maxPages = TopPages - SlideRange
				end if
				slidePages = cint((maxPages/2)+0.5)

				dim startPage, stopPage
				if m_PageCount > maxPages then
					startPage = nPage - slidePages
					stopPage = nPage + slidePages
					
					'check if startPages is less than 1
					if startPage < 1 then
						startPage = 1
						stopPage = maxPages
					end if
					'check if stopPages is greater than total pages
					if stopPage > m_PageCount then
						stopPage = m_PageCount
						startPage = m_PageCount - slidePages
					end if
				else
					startPage = 1
					stopPage = m_PageCount
				end if

				
				rsQuery = request.serverVariables("QUERY_STRING")
				queryPageNumber = Request.QueryString("Page")
				if queryPageNumber then
					rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
				end if
				
				dim p_strPageSelection
				p_strPageSelection = "<div id=""topPageRecords"" class=""navPageRecords"">" &_
					"<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & whichCompany & """>First</A>"
					For i = startPage to stopPage
						p_strPageSelection = p_strPageSelection &_
							"<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & """>&nbsp;"
						if i = nPage then
							p_strPageSelection = p_strPageSelection &_
								"<span style=""color:red"">" & i & "</span>"
						Else
							p_strPageSelection = p_strPageSelection & i
						end if
						p_strPageSelection = p_strPageSelection &"&nbsp;</A>"
					Next
				p_strPageSelection = p_strPageSelection &_
					"<A HREF=""" & aspPageName & "?Page=" & m_PageCount & "&whichCompany=" & whichCompany & """>Last</A>" &_
					"</div>"
			else
				p_strPageSelection = ""
			end if
			
			GetPageSelection = p_strPageSelection
		end function

	'#############  Private Functions ##############

		'Takes a recordset
		'Fills the object's properties using the recordset
		private function FillPlacementsFromRS(p_RS)
			p_RS.PageSize = m_ItemsPerPage
			m_PageCount = p_RS.PageCount
					
			if m_Page < 1 Or m_Page > m_PageCount then
				m_Page = 1
			end if

			if not p_RS.eof then p_RS.AbsolutePage = m_Page
			
			dim thisAppointment
			do while not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page )
				set thisAppointment = New cAppointment
				thisAppointment.id                = p_RS.fields("Id").Value
				thisAppointment.Comment           = p_RS.fields("Comment").Value
				thisAppointment.ApplicantPhone    = p_RS.fields("TelePhone").Value
				thisAppointment.CustomerPhone     = p_RS.fields("Phone").Value
				thisAppointment.WorkSitePhone     = p_RS.fields("WorkSite3").Value
				thisAppointment.ApplicantId       = p_RS.fields("ApplicantID").Value
				thisAppointment.LastnameFirst     = p_RS.fields("LastnameFirst").Value
				thisAppointment.ApptDate          = p_RS.fields("AppDate").Value
				thisAppointment.ApptType          = p_RS.fields("ApptType").Value
				thisAppointment.ApptTypeCode      = p_RS.fields("ApptTypeCode").Value
				thisAppointment.Disposition       = p_RS.fields("Disposition").Value
				thisAppointment.DispTypeCode      = p_RS.fields("DispTypeCode").Value
				thisAppointment.EnteredBy         = p_RS.fields("EnteredBy").Value
				thisAppointment.AssignedTo        = p_RS.fields("AssignedTo").Value
				thisAppointment.CustomerCode      = p_RS.fields("Customer").Value
				thisAppointment.CustomerName      = p_RS.fields("CustomerName").Value
				thisAppointment.CustomerContact   = p_RS.fields("Contact").Value
				thisAppointment.JobSupervisor     = p_RS.fields("JobSupervisor").Value
				thisAppointment.ReferenceId       = p_RS.fields("Reference").Value
				thisAppointment.JobDescription    = p_RS.fields("JobDescription").Value
				m_Appointments.Add thisAppointment.id, thisAppointment
				
				p_RS.movenext
			loop
		End Function

		Private Function LoadPlacementData(p_strSQL)
			dim rs
			set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getTempsDSN(whichCompany)))
			FillPlacementsFromRS(rs)
			LoadPlacementData = rs.recordcount
			rs. close
			set rs = nothing
		End Function

end class
%>
