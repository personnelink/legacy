<%
class cUsageDetail

	private m_Id
	private m_DepartmentId
	private m_JobDescription
	private m_ApplicantId
	private m_Billrate
	private m_Quantity
	private m_Billed
	private m_SumOfQuantity
	private m_TotalBilled
	private m_Invoice
	private m_CostCenter
	private m_CCDescription
	private m_LastnameFirst
	private m_InvoiceDate

	public property get UsageDetail()
		set UsageDetail = m_UsageDetail
	end property
	
	'read the current deparment
	public property get Id()
		Id = m_Id
	end property
	public property let Id(p_Id)
		m_Id = p_Id
	end property

	public property get DepartmentId()
		DepartmentId = m_DepartmentId
	end property
	public property let DepartmentId(p_DepartmentId)
		m_DepartmentId = p_DepartmentId
	end property

	public property get JobDescription()
		JobDescription = m_JobDescription
	end property
	public property let JobDescription(p_JobDescription)
		m_JobDescription = p_JobDescription
	end property

	public property get ApplicantId()
		ApplicantId = m_ApplicantId
	end property
	public property let ApplicantId(p_ApplicantId)
		m_ApplicantId = p_ApplicantId
	end property

	public property get Billrate()
		Billrate = m_Billrate
	end property
	public property let Billrate(p_Billrate)
		m_Billrate = p_Billrate
	end property

	public property get Billed()
		Billed = m_Billed
	end property
	public property let Billed(p_Billed)
		m_Billed = p_Billed
	end property

	public property get Quantity()
		Quantity = m_Quantity
	end property
	public property let Quantity(p_Quantity)
		m_Quantity = p_Quantity
	end property

	public property get SumOfQuantity()
		SumOfQuantity = m_SumOfQuantity
	end property
	public property let SumOfQuantity(p_SumOfQuantity)
		m_SumOfQuantity = p_SumOfQuantity
	end property

	public property get TotalBilled()
		TotalBilled = m_TotalBilled
	end property
	public property let TotalBilled(p_TotalBilled)
		m_TotalBilled = p_TotalBilled
	end property

	public property get Invoice()
		Invoice = m_Invoice
	end property
	public property let Invoice(p_Invoice)
		m_Invoice = p_Invoice
	end property

	public property get CostCenter()
		CostCenter = m_CostCenter
	end property
	public property let CostCenter(p_CostCenter)
		m_CostCenter = p_CostCenter
	end property

	public property get CCDescription()
		CCDescription = m_CCDescription
	end property
	public property let CCDescription(p_CCDescription)
		m_CCDescription = p_CCDescription
	end property

	public property get LastnameFirst()
		LastnameFirst = m_LastnameFirst
	end property
	public property let LastnameFirst(p_LastnameFirst)
		m_LastnameFirst = p_LastnameFirst
	end property

	public property get InvoiceDate()
		InvoiceDate = m_InvoiceDate
	end property
	public property let InvoiceDate(p_InvoiceDate)
		m_InvoiceDate = p_InvoiceDate
	end property

end class
%>
