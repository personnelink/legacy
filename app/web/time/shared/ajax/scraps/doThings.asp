<%Option Explicit%>
<%
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_service.asp' -->
<%

select case request.querystring("get")
	case "customers"
		server.transer("getCustomers.asp")
	case "orders"
		server.transfer("getOrders.asp")
	case "placements"
		server.transfer("getPlacements.asp")
	case "timecards"
		server.transfer("doTimecards.asp")
end select

%>