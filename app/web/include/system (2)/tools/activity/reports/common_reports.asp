<%

'which company selection
dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

'year selection
dim whichYear
whichYear = Request.QueryString("whichYear")
if len(whichYear) = 0 then
	whichYear = request.form("whichYear")
	if len(whichYear) = 0 then
		whichYear = datepart("yyyy", now())
	end if
end if

'record paging
dim nPage, nItemsPerPage, nPageCount
nPage = CInt(Request.QueryString("Page"))
nItemsPerPage = 50

rsQuery = request.serverVariables("QUERY_STRING")
queryPageNumber = Request.QueryString("Page")
if queryPageNumber then
	rsQuery = Replace(rsQuery, "Page=" & queryPageNumber & "&", "")
end if

function rs_navigation(thiscompany, thisquery, thisnofpages)
	dim i, sShortTmp, strThisBlob
	if thisnofpages > 0 then
		strThisBlob = "<div id=""topPageRecords"" class=""navPageRecords"">" &_
			"<A HREF=""" & aspPageName & "?Page=1&whichCompany=" & thiscompany & "&" & thisquery & """>First</A>"
		For i = 1 to thisnofpages
			sShortTmp = "<A HREF=""" & aspPageName & "?Page="& i & "&whichCompany=" & whichCompany & "&" & thisquery & """>&nbsp;"
			if i = nPage then
				strThisBlob = strThisBlob & sShortTmp & "<span style=""color:red"">" & i & "</span>" & "&nbsp;</A>"
			Else
				strThisBlob = strThisBlob & sShortTmp & i & "&nbsp;</A>"
			end if
		Next
		rs_navigation = strThisBlob & "<A HREF=""" & aspPageName & "?Page=" & thisnofpages & "&whichCompany=" & whichCompany & "&" &_
			thisquery & """>Last</A></div>"
	else
		rs_navigation = "<div id=""topPageRecords"" class=""navPageRecords"">" & "&nbsp" & "</div>"
	end if
end function

'manage applicant hooks/links
dim applicantid, sTelephone, maintain_link, resourcelink
resourcelink = "/include/system/tools/activity/forms/maintainApplicant.asp?"

function useThisCompany(thiscompany)
	Select Case thiscompany
	Case "BUR"
		useThisCompany = dsnLessTemps(BUR)
	Case "PER"
		useThisCompany = dsnLessTemps(PER)
	Case "BOI"
		useThisCompany = dsnLessTemps(BOI)
	Case "IDA"
		useThisCompany = dsnLessTemps(IDA)
	Case "PPI"
		useThisCompany = dsnLessTemps(PPI)
	End Select
end function

function useThisKeyId(thisdata, typeofdata)
	'set key retrieval aggregate pattern for Temps
	select case typeofdata
	case "year"
		select case thisdata
		case 2010
			useThisKeyId = ".3360."
		case 2011
			useThisKeyId = ".3362."
		case 2012
			useThisKeyId = ".3370."
		case 2013
			useThisKeyId = ".4000."	
		case 2014
			useThisKeyId = ".4001."
		case else
			useThisKeyId = "..."
		end select
	case else
	end select
end function

function mainQueryString()
end function

function addQueryString()
end function
%>