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
<B>Fill out the following form</B>
<BR><BR>
<form name="testform" action="show_post.asp" method="post">
You submitted the following information:<BR>
<label for="product">Product Name: </label>
<input type="text" name="product" value="product test" />



<label for="partnumber">Part Number: </label>
<input type="text" name="partnumber" value="pn test" />

<label for="workordernumber">Product Name: </label>
<input type="text" name="workordernumber" value="product test" />

<label for="day">Product Name: </label>
<input type="text" name="day" value="day test" />

<input type="submit" name="submit" value="test form" />


<I><%=Form_product%></I><BR>
Part No.: <I><%=Form_partnumber%></I><BR>
Work Order No.: <I><%=Form_workordernumber%></I><BR>
Date: <I><%=Form_day%>/<%=Form_month%>/<%=Form_year%></I><BR>
Serial No.: <I><%=Form_serialnumber%></I><BR>
Quantity Received: <I><%=Form_quantityreceived%></I><BR>
Quantity Defective: <I><%=Form_quantitydefective%></I><BR>
Non Conformance Description: <I><%=Form_nconformancedescp%></I><BR>
Name: <I><%=Form_name%></I> Department: <I><%=Form_department%></I><BR>
</form>
</HTML>
</BODY>