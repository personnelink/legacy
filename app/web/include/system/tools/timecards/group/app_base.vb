<%
const jsver = "006"
const mobile_cssver = "001"
const cssver = "008"

const app_base = "/include/system/tools/timecards/group/approval/employee/"

session("add_css") = "./" & app_base & "timecards." & cssver & ".css"
session("mobile_css") = "./" & app_base & "timecards.mobile." & mobile_cssver & ".css"

%>

<!-- #include virtual='/include/core/init_secure_session.asp' -->
<script type="text/javascript" src="/include/functions/calendar/calendar.js"></script>
<script type="text/javascript" src="/include/functions/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="/include/functions/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="<%=app_base%>timecards.<%=jsver%>.js"></script>
<style type="text/css"> @import url("/include/functions/calendar/calendar-blue.css"); </style>
<!-- #include virtual='/include/system/tools/timecards/group/timecard.classes.asp' -->