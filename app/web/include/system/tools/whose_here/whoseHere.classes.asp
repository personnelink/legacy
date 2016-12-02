<!-- #include virtual='/pdfServer/pdfApplication/application.classes.vb' -->

<%
	dim Enrollment, dontInject
	dontInject = false

	for each Enrollment in CurrentApplication.Enrollments.Items
		if Enrollment.CompCode = qsCompany then dontInject = true 'suppress reupdating
		CurrentApplication.WhichCompany = Enrollment.CompCode
		Enrollment.LoadExistingEnrollment()
		InjectIntoTemps
	next

%>

