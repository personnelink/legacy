<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

dim QueryText, Location(3), queryCache_cmd, getCustomer_cmd
, getWebDescription_cmd, getWebDescription, Jobs, WebDescription

QueryText = "SELECT Orders.Reference, Orders.WorkSite2, Orders.JobDescription, Orders.JobChangedDate, Orders.WC1Pay, Orders.InvoiceFormat, " &_
	"OtherOrders.Def1, OtherOrders.Def2 " &_
	"FROM Orders LEFT JOIN OtherOrders ON Orders.Reference = OtherOrders.Reference " &_
	"WHERE (((Orders.JobStatus)<2) AND ((Orders.InvoiceFormat)<>'H') AND ((Orders.InvoiceFormat)<>'B')) " &_
	"ORDER BY Orders.JobChangedDate DESC;"

Set queryCache_cmd = Server.CreateObject("ADODB.Connection")
queryCache_cmd.Open MySql
		
ThisSession = Session.SessionID

dim whichCompany
whichCompany = Replace(Request.QueryString("company"))
'0) = "PER"
'1) = "BUR"
'2) = "BOI"
'3) = "IDA"

	Set getCustomer_cmd = Server.CreateObject("ADODB.Command")
	With getCustomer_cmd
		.ActiveConnection = dsnLessTemps(i)
		.CommandText = QueryText
	End With
	Set Customer = getCustomer_cmd.Execute
	if Not Customer.eof
	end if

Set Customer = Nothing
Set getCustomer_cmd = Nothing

%>
