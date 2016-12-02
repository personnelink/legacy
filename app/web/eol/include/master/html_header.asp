<!-- #INCLUDE VIRTUAL='/include/global_declarations.asp' -->
<%
'Revision Date: 2009.09.04
if session("noHeaders") <> true then
	response.write "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01//EN"" ""http://www.w3.org/TR/html4/strict.dtd"">" &_
		"<html lang=""en"">" &_
		"<head>" &_
		"<meta http-equiv=""Content-Type"" content=""text/html; charset=iso-8859-1"">" &_
		"<meta http-equiv=""X-UA-Compatible"" content=""IE=8"" />" &_
		"<script type=""text/javascript"" src=""/include/javascript.js""></script>" &_
		session("additionalScripting") &_
		"<meta name=""url"" content=""http://www.personnelplus.net"">" &_
		"<meta name=""description"" content=""Personnel Plus is 'Your Total Staffing Solution'. We specialize in providing quality employees for every job."">" &_
		"<meta name=""robots"" content=""index,follow"">"
		
	if len(session("additionalHeading")) > 0 then
		response.write session("additionalHeading") 
		response.write "<link rel=""shortcut icon"" type=""image/x-icon"" href=""/include/style/images/navigation/pplusicon.gif"">" &_
		"<title>Personnel Plus, Inc. Your Total Staffing Solution!</title>"
	end if
end if
%>
