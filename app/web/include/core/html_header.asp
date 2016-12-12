<!-- #INCLUDE VIRTUAL='/include/core/global_declarations.asp' -->
<!-- #INCLUDE VIRTUAL='/include/core/navigation.asp' -->

<%
response.buffer = true

if request.servervariables("https") = "on" then
	dim isSecure
	isSecure = true
end if

'social media plug-ins
dim social_scripting : social_scripting = ""
if not isSecure then
	social_scripting = social_scripting &_
		"<script type=""text/javascript"">" &_
			"(function() {" &_
			"var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;" &_
			"po.src = '//apis.google.com/js/plusone.js';" &_
			"var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);" &_
			"})();" &_
		"</script>"
end if
			 
header_response = header_response & "<!DOCTYPE HTML>" &_
	"<html " & session("htmltag") & " lang=""en"">" &_
	"<head>" &_
	"<meta charset=""UTF-8"">" &_
	"<meta property=""fb:app_id"" content=""203654159645883"" />" &_
	"<meta property=""fb:admins"" content=""522456439, 100002164718425""/>" &_
	"<script type=""text/javascript"" src=""/include/js/jQuery-1.10.2.min.js""></script>" &_
	"<script type=""text/javascript"" src=""/include/core/smoke.js-master/smoke.min.js""></script>" &_
	social_scripting &_
	session("additionalScripting") &_
	"<meta name=""url"" content=""https://www.personnelinc.com"">" &_
	"<meta name=""description"" content=""Personnel Plus is Your Total Staffing Solution. We specialize in finding and providing quality employees for every job opportunity, Our History, Gem State History, careers," &_
	"employee," &_
	"employment," &_
	"employment agencies," &_
	"employment agencies retail," &_
	"employment agencies sales," &_
	"employment agency," &_
	"executive employment agencies," &_
	"job agencies," &_
	"job employment agencies," &_
	"job openings," &_
	"job opportunities," &_
	"job placement," &_
	"job placement agencies," &_
	"job recruitment," &_
	"job search," &_
	"job seekers," &_
	"jobs entry level," &_
	"part time employment," &_
	"part time job," &_
	"part time jobs," &_
	"part time work," &_
	"recruiting," &_
	"recruitment agency," &_
	"staffing," &_
	"staffing agencies," &_
	"staffing jobs," &_
	""">" &_
	"<meta name=""robots"" content=""index,follow"">" &_
	session("metatagging")
	
if is_mobile then
header_response = header_response &_
    "<meta name=""viewport""  content=""width=device-width,  minimum-scale=0.4"" />" &_
		"<meta name=""viewport"" content=""intial-scale=1.0 , user-scalable=yes"" />"
end if

if session("no_cache") = true then
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() -1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
end if

if len(session("additionalHeading")) > 0 then header_response = header_response & session("additionalHeading") 
	
dim window_page_title
if len(session("window_page_title")) > 0 then
	window_page_title = session("window_page_title")
	session("window_page_title") = ""
else
	window_page_title = "Personnel Plus - Your Total Staffing Solution!"
end if

header_response = header_response & "<link rel=""shortcut icon"" type=""image/x-icon"" href=""/include/style/images/navigation/pplusicon.gif"">" &_
	"<title>" & window_page_title & "</title>"
%>
