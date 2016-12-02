<%

class cTimeSummary
	private m_id
	private m_WeekEnding
	private m_DayName(6)
	private m_Day(7)
	private m_WorkDay
	private m_TotalHours

	public property get  DayName(p_weekday)
		DayName = m_DayName(p_weekday - 1)
	end property
	
	public property get  Day(p_workday)
		Day = m_Day(p_workday)
	end property
	public property let  Day(p_workday, p_hours)
				m_Day(p_workday) = p_hours
	end property

	public property get id()
		id = m_id
	end property
	public property let id(p_id)
		m_id = p_id
	end property

	public property get WeekEnding()
		WeekEnding = m_WeekEnding
	end property
	public property let WeekEnding(p_WeekEnding)
		m_WeekEnding = p_WeekEnding
		
		dim i, current_day
		for i = 0 to 6
			current_day = company_weekends - i
			if current_day < 1  then current_day = current_day + 7
			m_DayName(6 - i) = Left(WeekDayName(current_day), 3)
		next
	end property

	public property get WorkDay()
		WorkDay = m_WorkDay
	end property
	public property let WorkDay(p_WorkDay)
		m_WorkDay = p_WorkDay
	end property
	
	public property get TotalHours()
		dim x, t
		for x = lbound(m_Day) to ubound(m_Day)
			t = t + m_Day(x)
		next
		TotalHours = t
	end property
	public property let TotalHours(p_TotalHours)
		m_TotalHours = p_TotalHours
	end property
end class

class cTimeDetail
	private m_PlacementId
	private m_SummaryId
	private m_DetailId
	private m_TimeTypeId
	private m_TimeType
	private m_WeekEnding
	private m_Site
	private m_Workday
	private m_TimeIn
	private m_TimeOut
	private m_TotalTime
	private m_Hours
	private m_EnteredBy
	private m_Created
	private m_Modified

	public property get PlacementId()
		PlacementId = m_PlacementId
	end property
	public property let PlacementId(p_PlacementId)
		m_PlacementId = p_PlacementId
	end property

	public property get SummaryId()
		SummaryId = m_SummaryId
	end property
	public property let SummaryId(p_SummaryId)
		m_SummaryId = p_SummaryId
	end property
	
	public property get DetailId()
		DetailId = m_DetailId
	end property
	public property let DetailId(p_DetailId)
		m_DetailId = p_DetailId
	end property

	public property get TimeTypeId()
		TimeTypeId = m_TimeTypeId
	end property
	public property let TimeTypeId(p_TimeTypeId)
		m_TimeTypeId = p_TimeTypeId
	end property

	public property get TimeType()
		TimeType = m_TimeType
	end property
	public property let TimeType(p_TimeType)
		m_TimeType = p_TimeType
	end property

	public property get WeekEnding()
		WeekEnding = m_WeekEnding
	end property
	public property let WeekEnding(p_WeekEnding)
		m_WeekEnding = p_WeekEnding
	end property

	public property get Site()
		Site = m_Site
	end property
	public property let Site(p_Site)
		m_Site = p_Site
	end property

	public property get Workday()
		Workday = m_Workday
	end property
	public property let Workday(p_Workday)
		m_WorkDay = p_Workday
	end property

	public property get TimeIn()
		TimeIn = m_TimeIn
	end property
	public property let TimeIn(p_TimeIn)
		p_TimeIn = m_TimeIn
	end property

	public property get TimeOut()
		TimeOut = m_TimeOut
	end property
	public property let TimeOut(p_TimeOut)
		m_TimeOut = p_TimeOut
	end property

	public property get TotalTime()
		TotalTime = m_TotalTime
	end property
	public property let TotalTime(p_TotalTime)
		m_TotalTime = p_TotalTime
	end property

	public property get Hours()
		Hours = m_Hours
	end property
	public property let Hours(p_Hours)
		m_Hours = p_Hours
	end property

	public property get EnteredBy()
		EnteredBy = m_EnteredBy
	end property
	public property let EnteredBy(p_EnteredBy)
		m_EnteredBy = p_EnteredBy
	end property

	public property get Created()
	end property
	public property let Created(p_Created)
	end property

	public property get Modified()
		Modified = m_Modified
	end property
	public property let Modified(p_Modified)
		m_Modified = p_Modified
	end property

end class
%>