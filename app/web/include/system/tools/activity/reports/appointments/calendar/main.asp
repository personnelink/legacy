<!--#include file="clsCalendar.vb"-->

<html>
<head>
   <title>Calendar Control</title>
</head>

<body>
<div align="right">
<%

Set myCal = New Calendar
mycal.border=false 'Display Border around Calendar
mycal.value = Now 'Sets Current Date
mycal.calMonth = 4 'Sets Current Month
mycal.calYear = 2002 'Sets Current Year
mycal.fonts = "Tahoma" 'Sets Font
mycal.fontSize=2 'Sets Font Size
mycal.showDate = True 'Not yet implemented
mycal.showNav =True 'Show prev and next Navigation Links
mycal.showForm = True 'Show Month and Year form
mycal.display 'Display Calendar

Set myCal = Nothing

%>

</div>
</body>
</html> 