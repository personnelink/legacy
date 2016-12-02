<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/tools/activity/reports/orders/classes/customers.class.asp' -->

<%

'-----------------------------------------------------------------
' parameters:
'	do     = view
'	id     = customer code
'	site   = temps site id
'	status = job order status
'
'-----------------------------------------------------------------

'retrieve site id and make sure it's numeric
dim g_strSite : g_strSite = request.querystring("site")

select case request.querystring("do")
	case "view"
		doView

end select

public function doView ()
	'what job order status?
	dim intJobStatus
	Select Case request.querystring("status")
		Case "0"
			intJobStatus = "0"

		Case "1"
			intJobStatus = "1"

		Case "2"
			intJobStatus = "2"

		Case "3"
			intJobStatus = "3"

		Case "4"
			intJobStatus = "4"

		Case Else
			exit function

	End Select

	dim Customers
	set Customers = new cCustomers
	' Customers.ItemsPerPage = 20
	' Customers.Page = CInt(Request.QueryString("Page"))
	Customers.GetAllCustomers(intJobStatus)

	dim LightOrDark : LightOrDark = "light" 'toggle light or dark row shadding

	for each Customer in Customers.Customer.Items

	select case EvenOrOdd
		case "dark"
			LightOrDark = "light"
		case else
			LightOrDark = "dark"
	end select
	%>

	<div class="customer <%=LightOrDark%>" onclick="orders.get('<)>
		<span class="custcode"><%=Customer.Customer%></span>
		<span class="custname"><%=Customer.CustomerName%></span>
		<div id="<%=Customer.Customer & intJobStatus%>" class="orders hide"></div>
	</div>
	
	<%

	next
	
	response.write "[:]ordertype" & intJobStatus
end function

%>