<%
session("add_css") = "./entryPage.css"
session("no_cache") = true
session("required_user_level") = 4096 'userLevelPPlusStaff
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="entryPage.js"></script>

<!-- #include file='entryPage.doStuff.asp' -->

<form id="frmPaperTimeEntry" name="frmPaperTimeEntry" action="#" method="get" />

<%=UnreviewedTimecards%>

<%=decorateTop("", "marLRB10", "Active Timecard")%>
<div id="activetimecard">
<img src="/pdfServer/pdfApplication/generated/p1.jpg" alt="Active Timecard" height="296px"/>
</div>
<%=decorateBottom()%>

<%=decorateTop("", "marLRB10", "Hours and Timecards")%>

<div id="TimeCardImage" class="pad10">
<table id="formOptions"><tr><td>
      <label for="fromDate">From </label>
      <input  name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
</td><td>
	<label for="toDate">To </label>
	<input name="toDate" id="toDate" type="text" value="<%=toDate%>">
</td><td>
	
<div class="changeView">

 <a class="squarebutton" href="#" style="float:none" onclick="avascript:document.viewActivityForm.submit();"><span style="text-align:center"> Search </span></a>
</div></td></tr>
<tr><td colspan=3>
      <label for="likeName">Search</label>
      <input name="likeName" id="likeName" type="text" value="<%=likeName%>">
</td></tr>
</table>


<%=navRecordsByPage(Timecards)%>

<% showInputTables %>

<%=navRecordsByPage(Timecards)%>

</div>
<%=decorateBottom() %>

<%=decorateTop("", "marLRB10", "What we're currently working on")%>
<%=decorateBottom() %>
</form>
<%
Timecards.Close
Database.Close
Set Timecards = nothing
'Set getApplications_cmd = Nothing
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
