<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
session("no_header") = true
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<%

select case request.querystring("proc")
case "update"
	doUpdate
end select

sub doUpdate ()
	dim tmpInt
	dim custid
	tmpInt = request.querystring("id")
	if isnumeric(tmpInt) then	custid = cint(tmpInt)

	dim site
	site = request.querystring("site")
	if not isnumeric(site) then
		response.write site & " site not numeric"
		response.end
	end if

	dim weekends
	weekends = request.querystring("weekends")
	if not isnumeric(weekends) then
		response.write weekends & " not numeric"
		response.end
	end if

	dim custcode
	custcode = replace(replace(request.querystring("cust"), "'", "''"), """", """""")

	dim rsUpdateCust, doUpdateCustomer
	set rsUpdateCust = server.CreateObject("ADODB.Command")
	with rsUpdateCust
		.ActiveConnection = MySql
		.CommandText = "update tbl_companies set " &_
			"Customer='" & ucase(custcode) & "', " &_
			"weekends=" & weekends & ", " &_
			"site=" & site & " " &_
			"where companyid='" & custid & "'"
	end with
	doUpdateCustomer = rsUpdateCust.Execute()

	set doUpdateCustomer = nothing
	set rsUpdateCust = nothing

	response.write custid
end sub

 %>