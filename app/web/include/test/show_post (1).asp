<%
Form_product = Request.Form("product")
Form_partnumber = Request.Form("partnumber")
Form_workordernumber = Request.Form("workordernumber")
Form_day = Request.Form("day")
Form_month = Request.Form("month")
Form_year= Request.Form("year")
Form_serialnumber = Request.Form("serialnumber")
Form_quantityreceived = Request.Form("qtyreceived")
Form_quantitydefective = Request.Form("qtydefective")
Form_nconformancedescp = Request.Form("NCD")
Form_name = Request.Form("name")
Form_department = Request.Form("department")
%>

<HTML>
<BODY>
<B>Thank you for filling out the form<%=Form_Name%>!</B>
<BR><BR>
You submitted the following information:<BR>
Product Name: <I><%=Form_product%></I><BR>
Part No.: <I><%=Form_partnumber%></I><BR>
Work Order No.: <I><%=Form_workordernumber%></I><BR>
Date: <I><%=Form_day%>/<%=Form_month%>/<%=Form_year%></I><BR>
Serial No.: <I><%=Form_serialnumber%></I><BR>
Quantity Received: <I><%=Form_quantityreceived%></I><BR>
Quantity Defective: <I><%=Form_quantitydefective%></I><BR>
Non Conformance Description: <I><%=Form_nconformancedescp%></I><BR>
Name: <I><%=Form_name%></I> Department: <I><%=Form_department%></I><BR>
</HTML>
</BODY>