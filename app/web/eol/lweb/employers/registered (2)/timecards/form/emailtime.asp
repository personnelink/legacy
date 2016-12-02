<%

' // CDO Email the resume to Personnel Inc.

dim cdoConfig,cdoMessage,msgBody
sch = "http://schemas.microsoft.com/cdo/configuration/"
Set cdoConfig = Server.CreateObject("CDO.Configuration")

With cdoConfig.Fields 
      .Item(sch & "sendusing") = 2 ' cdoSendUsingPort 
      .Item(sch & "smtpserver") = "127.0.0.1" 
      .update 
End With 

Set cdoMessage = Server.CreateObject("CDO.Message") 

'Set the Body

msgBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">" & vbCrLf _
		& "<html>" & vbCrLf _
		& "<head>" & vbCrLf _
		& "<title>Time Sheet from" & request("companyName") & "</title>" & vbCrLf _
		& "<meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& "<h2>Time Sheet from" & request("CompanyName") & "</h2>" & vbCrLf _
		& "<p>" & vbCrLf _
		& "<table border=""0"" width=""84%"" cellspacing=""0"" cellpadding=""0"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td rowspan=""2"" width=""16%"" nowrap>" & vbCrLf _
		& "<p align=""center"">&nbsp;</td>" & vbCrLf _
		& "<td colspan=""3"">" & vbCrLf _
		& "<p align=""center"">Company:&nbsp;" & request("company") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""28%"">" & vbCrLf _
		& "<p align=""center"">Location: &nbsp;" & request("location") & "</td>" & vbCrLf _
		& "<td width=""32%"">" & vbCrLf _
		& "<p align=""center"">Week Ending:&nbsp;" & request("weekEnding") & "</td>" & vbCrLf _
		& "<td width=""9%"">" & vbCrLf _
		& "			&nbsp;</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "<table border=""0"" width=""77%"" cellspacing=""1"" height=""161"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td align=""center"" height=""21"" colspan=""12"">" & vbCrLf _
		& "		***********************************************************************************************</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Employee Name</td>" & vbCrLf _
		& "<td align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Notes  <font size=""1"">(optional)</font></td>" & vbCrLf _
		& "<td width=""6%"" align=""center"" height=""21"">&nbsp;</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">MON</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">TUE</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">WED</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">THUR</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">FRI</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SAT</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SUN</td>" & vbCrLf _
		& "<td width=""10%"" colspan=""2"" align=""center"" nowrap height=""21"">TOTAL HOURS</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td rowspan=""4"" width=""13%"" align=""center"">" & request("empName1") & "</td>" & vbCrLf _
		& "<td rowspan=""6"" align=""center""><p align=""center"">" & request("description0") & "</td>" & vbCrLf _
		& "<td width=""6%"" align=""right"" height=""24"">Dates:</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("mon0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("tue0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("wed0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("thur0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("fri0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sat0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sun0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">Reg</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">OT</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""6%"" align=""right"" nowrap height=""18""><font size=""1"">Total Hours</font></td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Monday0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Tuesday0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Wednesday0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Thursday0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Friday0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Saturday0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Sunday0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("regTime0") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("otTime0") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap height=""18"" colspan=""10"">" & vbCrLf _
		& "<p align=""center"">" & request("approve0") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" rowspan=""2"" bgcolor=""#FF0000"">" & vbCrLf _
		& "<p align=""center""><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"">" & vbCrLf _
		& "<p align=""center"">Soc Sec#</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""24"">" & request("SocSec0") & "</td>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" height=""24"">" & vbCrLf _
		& "<p align=""center"">&nbsp;&nbsp;</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "<table border=""0"" width=""77%"" cellspacing=""1"" height=""161"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td align=""center"" height=""21"" colspan=""12"">" & vbCrLf _
		& "		***********************************************************************************************</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Employee Name</td>" & vbCrLf _
		& "<td align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Notes  <font size=""1"">(optional)</font></td>" & vbCrLf _
		& "<td width=""6%"" align=""center"" height=""21"">&nbsp;</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">MON</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">TUE</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">WED</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">THUR</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">FRI</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SAT</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SUN</td>" & vbCrLf _
		& "<td width=""10%"" colspan=""2"" align=""center"" nowrap height=""21"">TOTAL HOURS</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td rowspan=""4"" width=""13%"" align=""center"">" & request("empName2") & "</td>" & vbCrLf _
		& "<td rowspan=""6"" align=""center""><p align=""center"">" & request("description1") & "</td>" & vbCrLf _
		& "<td width=""6%"" align=""right"" height=""24"">Dates:</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("mon1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("tue1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("wed1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("thur1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("fri1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sat1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sun1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">Reg</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">OT</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _  
		& "<td width=""6%"" align=""right"" nowrap height=""18""><font size=""1"">Total Hours</font></td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Monday1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Tuesday1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Wednesday1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Thursday1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Friday1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Saturday1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Sunday1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("regTime1") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("otTime1") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap height=""18"" colspan=""10"">" & vbCrLf _
		& "<p align=""center"">" & request("approve1") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" rowspan=""2"" bgcolor=""#FF0000"">" & vbCrLf _
		& "<p align=""center""><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"">" & vbCrLf _
		& "<p align=""center"">Soc Sec#</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""24"">" & request("SocSec1") & "</td>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" height=""24"">" & vbCrLf _
		& "<p align=""center"">&nbsp;</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "<table border=""0"" width=""77%"" cellspacing=""1"" height=""161"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td align=""center"" height=""21"" colspan=""12"">" & vbCrLf _
		& "		***********************************************************************************************</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Employee Name</td>" & vbCrLf _
		& "<td align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Notes  <font size=""1"">(optional)</font></td>" & vbCrLf _
		& "<td width=""6%"" align=""center"" height=""21"">&nbsp;</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">MON</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">TUE</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">WED</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">THUR</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">FRI</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SAT</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SUN</td>" & vbCrLf _
		& "<td width=""10%"" colspan=""2"" align=""center"" nowrap height=""21"">TOTAL HOURS</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td rowspan=""4"" width=""13%"" align=""center"">" & request("empName3") & "</td>" & vbCrLf _
		& "<td rowspan=""6"" align=""center""><p align=""center"">" & request("description2") & "</td>" & vbCrLf _
		& "<td width=""6%"" align=""right"" height=""24"">Dates:</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("mon2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("tue2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("wed2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("thur2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("fri2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sat2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sun2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">Reg</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">OT</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""6%"" align=""right"" nowrap height=""18""><font size=""1"">Total Hours</font></td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Monday2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Tuesday2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Wednesday2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Thursday2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Friday2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Saturday2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Sunday2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("regTime2") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("otTime2") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap height=""18"" colspan=""10"">" & vbCrLf _
		& "<p align=""center"">" & request("approve2") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" rowspan=""2"" bgcolor=""#FF0000"">" & vbCrLf _
		& "<p align=""center""><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"">" & vbCrLf _
		& "<p align=""center"">Soc Sec#</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""24"">" & request("SocSec2") & "</td>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" height=""24"">" & vbCrLf _
		& "<p align=""center"">&nbsp;</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "<table border=""0"" width=""77%"" cellspacing=""1"" height=""161"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td align=""center"" height=""21"" colspan=""12"">" & vbCrLf _
		& "		***********************************************************************************************</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Employee Name</td>" & vbCrLf _
		& "<td align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Notes  <font size=""1"">(optional)</font></td>" & vbCrLf _
		& "<td width=""6%"" align=""center"" height=""21"">&nbsp;</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">MON</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">TUE</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">WED</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">THUR</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">FRI</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SAT</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SUN</td>" & vbCrLf _
		& "<td width=""10%"" colspan=""2"" align=""center"" nowrap height=""21"">TOTAL HOURS</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td rowspan=""4"" width=""13%"" align=""center"">" & request("empName4") & "</td>" & vbCrLf _
		& "<td rowspan=""6"" align=""center""><p align=""center"">" & request("description3") & "</td>" & vbCrLf _
		& "<td width=""6%"" align=""right"" height=""24"">Dates:</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("mon3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("tue3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("wed3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("thur3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("fri3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sat3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sun3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">Reg</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">OT</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""6%"" align=""right"" nowrap height=""18""><font size=""1"">Total Hours</font></td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Monday3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Tuesday3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Wednesday3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Thursday3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Friday3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Saturday3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Sunday3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("regTime3") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("otTime3") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap height=""18"" colspan=""10"">" & vbCrLf _
		& "<p align=""center"">" & request("approve3") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" rowspan=""2"" bgcolor=""#FF0000"">" & vbCrLf _
		& "<p align=""center""><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"">" & vbCrLf _
		& "<p align=""center"">Soc Sec#</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""24"">" & request("SocSec3") & "</td>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" height=""24"">" & vbCrLf _
		& "<p align=""center"">&nbsp;</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "<table border=""0"" width=""77%"" cellspacing=""1"" height=""161"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td align=""center"" height=""21"" colspan=""12"">" & vbCrLf _
		& "		***********************************************************************************************</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Employee Name</td>" & vbCrLf _
		& "<td align=""center"" height=""21"">" & vbCrLf _
		& "<p align=""center"">Notes  <font size=""1"">(optional)</font></td>" & vbCrLf _
		& "<td width=""6%"" align=""center"" height=""21"">&nbsp;</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">MON</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">TUE</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">WED</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">THUR</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">FRI</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SAT</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""21"">SUN</td>" & vbCrLf _
		& "<td width=""10%"" colspan=""2"" align=""center"" nowrap height=""21"">TOTAL HOURS</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td rowspan=""4"" width=""13%"" align=""center"">" & request("empName5") & "</td>" & vbCrLf _
		& "<td rowspan=""6"" align=""center""><p align=""center"">" & request("description4") & "</td>" & vbCrLf _
		& "<td width=""6%"" align=""right"" height=""24"">Dates:</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("mon4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("tue4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("wed4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("thur4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("fri4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sat4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">" & request("sun4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">Reg</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""24"">OT</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""6%"" align=""right"" nowrap height=""18""><font size=""1"">Total Hours</font></td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Monday4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Tuesday4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Wednesday4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Thursday4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Friday4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Saturday4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("Sunday4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("regTime4") & "</td>" & vbCrLf _
		& "<td width=""5%"" align=""center"" height=""18"">" & request("otTime4") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap height=""18"" colspan=""10"">" & vbCrLf _
		& "<p align=""center"">" & request("approve4") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" rowspan=""2"" bgcolor=""#FF0000"">" & vbCrLf _
		& "<p align=""center""><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"">" & vbCrLf _
		& "<p align=""center"">Soc Sec#</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""13%"" align=""center"" height=""24"">" & request("SocSec4") & "</td>" & vbCrLf _
		& "<td width=""51%"" align=""right"" nowrap colspan=""10"" height=""24"">" & vbCrLf _
		& "<p align=""center"">&nbsp;</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "<table border=""0"" width=""39%"" cellspacing=""1"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""288"">" & vbCrLf _
		& "<p align=""right"">Total Hours to be Billed:</td>" & vbCrLf _
		& "<td width=""43"" align=""center"">Reg</td>" & vbCrLf _
		& "<td colspan=""2"" align=""center"">OT</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""288"">&nbsp;</td>" & vbCrLf _
		& "<td width=""43"" align=""center"">" & vbCrLf _
		& "" & request("TotalregTime") & "</td>" & vbCrLf _
		& "<td colspan=""2"" align=""center"">" & vbCrLf _
		& "" & request("TotalOTTime") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "<table border=""0"" width=""100%"" cellspacing=""1"">" & vbCrLf _
		& "<tr><td align=""center""><font color=""ff0000"">" & request("TotalApproved") & "</font></td></tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td colspan=""4""><font size=""1"">CLIENT NOTICE AND VERIFICATION:  The undersigned, as agent for the client company, certifies that the Personnel Plus associate named<br>herein worked acceptably during the period noted on this time sheet.&nbsp;&nbsp;The undersigned also acknowledges and accepts the terms and conditions listed <a href=""/employers/registered/timecards/form/terms.asp"" target=""_blank"">here</a> whereby this associate has been supplied by Personel Plus.  Please read the" & vbCrLf _
		& "</font> <a href=""/employers/registered/timecards/form/terms.asp"" target=""_blank"">" & vbCrLf _
		& "<font size=""1"">terms and conditions.</font></a></td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td align=""center"">" & request("signHere") & "</td>" & vbCrLf _
		& "<td width=""15%"" align=""center"" colspan=""2"">" & request("title") & "</td>" & vbCrLf _
		& "<td width=""36%"">" & request.cookies("timecards")("time") & "</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""48%"" align=""center"">" & vbCrLf _
		& "		________________________________________</td>" & vbCrLf _
		& "<td width=""15%"" align=""center"" colspan=""2"">______________</td>" & vbCrLf _
		& "<td width=""36%"">&nbsp;</td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td width=""99%"" colspan=""4"" height=""37""><font size=""1"">By electronically signing " & vbCrLf _
		& "	your first, middle, last name, and your title, you agree to the hours " & vbCrLf _
		& "	listed above in the &quot;Total Hours&quot; section.</font></td>" & vbCrLf _
		& "</tr>" & vbCrLf _
		& "</table>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf

With cdoMessage 
  Set .Configuration = cdoConfig
      .From = session("emailAddress")
'	  .To = "saguilar@personnel.com"
      .To = request.cookies("emailTo")
	  .Cc = session("emailAddress")
	  .Bcc = "saguilar@personnel.com"
      .HtmlBody = msgBody
'	  .AddAttachment ThisFile
      .Subject = "Personnel Plus - Time Card Submittal From: " & session("companyName")
      .Send 
End With 
%>
<!--
response.write "From: " & cdoMessage.From
response.write "<BR>"
response.write "To: " & cdoMessage.To
response.write "<BR>"
response.write "Cc: " & cdoMessage.Cc
response.write "<BR>"
response.write "Bcc: " & cdoMessage.Bcc
response.write "<BR>"
response.write "Subject: " & cdoMessage.Subject
response.write "<BR>"
response.write "HtmlBody: " & cdoMessage.HtmlBody
-->
<%
Set cdoMessage = Nothing 
Set cdoConfig = Nothing 

response.write "<BR><BR><BR><center>Your timecard form has been submitted.</center><BR><BR><BR><center><input type='button' value='Click here to Continue' onclick='window.close();'></center>"
%>