<%
session("add_css") = "./maintainAssociations.css"
session("no_cache") = true
session("required_user_level") = 4096 'userLevelPPlusStaff
session("window_page_title") = "Customer Associations - Personnel Plus"
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="maintainAssociations.js"></script>

<!-- #include file='maintainAssociations.doStuff.asp' -->

<%=decorateTop("", "marLRB10", "Manage Customer Associations")%>
<div id="accountActivityDetail" class="pad10">
    <form id="viewActivityForm" name="viewActivityForm" action="#" method="post" />
    <table id="formOptions">
        <tr>
            <td>
                <label for="fromDate">From </label>
                <input name="fromDate" id="fromDate" type="text" value="<%=fromDate%>">
            </td>
            <td>
                <label for="toDate">To </label>
                <input name="toDate" id="toDate" type="text" value="<%=toDate%>">
            </td>
            <td>

                <div class="changeView">

                    <a class="squarebutton" href="#" style="float: none" onclick="avascript:document.viewActivityForm.submit();"><span style="text-align: center">Search </span></a>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <label for="likeName">Search</label>
                <input name="likeName" id="likeName" type="text" value="<%=likeName%>">
            </td>
        </tr>
    </table>

    <%=navRecordsByPage(Timecards)%>

    <% showInputTables %>

    <%=navRecordsByPage(Timecards)%>
    </form>
</div>
<%=decorateBottom() %>

<%
Timecards.Close
Database.Close
Set Timecards = nothing
'Set getApplications_cmd = Nothing
%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->