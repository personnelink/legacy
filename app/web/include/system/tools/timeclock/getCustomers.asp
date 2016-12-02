<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<%
dim thisConnection, getCustomers_cmd, Customers, selectedID, customerID

Select Case Replace(Trim(Request.QueryString("companyid")), "'", "")
Case "PER"
	thisConnection = tempsPER
Case "BUR"
	thisConnection = tempsBUR
Case "BOI"
	thisConnection = tempsBOI
Case Else
	Response.End()
End Select

Set getCustomers_cmd = Server.CreateObject ("ADODB.Command")
With getCustomers_cmd
	.ActiveConnection = thisConnection
	.CommandText = "SELECT Customer, CustomerName FROM Customers ORDER By CustomerName Asc"
	.Prepared = true
End With
Set Customers = getCustomers_cmd.Execute
	
selectedID = Replace(Trim(Request.QueryString("selected")), "'", "")
do while not Customers.eof
	customerID = Customers("Customer")
	Response.write "<option value=" & Chr(34) & customerID & Chr(34) & " "
	if customerID = selectedID then Response.write "selected"
	Response.write ">" & Customers("CustomerName") & "</option>"
	Customers.Movenext
loop

Customers.Close
Set getCustomers_cmd = Nothing
Set Customers = Nothing
%>
