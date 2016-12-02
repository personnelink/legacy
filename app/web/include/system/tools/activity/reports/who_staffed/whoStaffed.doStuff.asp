<!-- #include file='whoStaffed.classes.asp' -->

<%

dim ApplicantSources
set ApplicantSources = new cApplicantSources
ApplicantSources.ItemsPerPage = 8000
ApplicantSources.Page = CInt(Request.QueryString("Page"))


ApplicantSources.FromDate = request.QueryString("fromDate")
ApplicantSources.ToDate = request.QueryString("toDate")


ApplicantSources.LoadSources

dim PageNavigation
PageNavigation = ApplicantSources.GetPageSelection()


dim row_number : row_number = 0
dim row_shade

%>
