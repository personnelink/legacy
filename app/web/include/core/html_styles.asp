<%
dim add_css
add_css = session("add_css")

dim mobile_css : mobile_css = session("mobile_css")

if is_mobile then
	'load master and global mobile stylesheet
	header_response = header_response &_
		"<link href=""/include/style/master.mobile.css"" rel=""stylesheet"" type=""text/css"">" &_
		"<link href=""/include/style/global.mobile.css"" rel=""stylesheet"" type=""text/css"">" &_
		"<link href=""/include/core/smoke.js-master/smoke.css"" rel=""stylesheet"" type=""text/css"">"

	if instr(mobile_css, ",") > 0 then
		
		dim arr_mobile_css
		arr_mobile_css = split(add_css, ",")
		for each item in arr_mobile_css
			header_response = header_response & add_css_to_header(trim(item))
		next
	else
		header_response = header_response & add_css_to_header(mobile_css)
	end if

else
	'load regular computer style sheet and regular style sheet to store "alternate" definitions
	'that don't play nice on both devices and that were moved here from master.css and global.css
	header_response = header_response &_
		"<link href=""/include/style/master.css"" rel=""stylesheet"" type=""text/css"">" &_
		"<link href=""/include/style/global.css"" rel=""stylesheet"" type=""text/css"">" &_
		"<link href=""/include/core/smoke.js-master/smoke.css"" rel=""stylesheet"" type=""text/css"">" &_
		"<!--[if IE]><link href=""/include/style/IEglobal.css"" rel=""stylesheet"" type=""text/css""><![endif]-->"	
end if

if len(add_css) > 0 or css_page_exception(request.ServerVariables("path_info")) then 
	if instr(add_css, ",") > 0 then
		dim arr_add_css
		arr_add_css = split(add_css, ",")
		for each item in arr_add_css
		header_response = header_response & add_css_to_header(trim(item))
		next
	else
		header_response = header_response & add_css_to_header(add_css)
	end if
end if

function add_css_to_header(this_css_file)
	if instr(this_css_file, "./") then
		add_css_to_header = "<link href=""" & replace(this_css_file, "./", "") & """ rel=""stylesheet"" type=""text/css"">"
	else		
		add_css_to_header = "<link href=""/include/style/unique/" & this_css_file &""" rel=""stylesheet"" type=""text/css"">"
	end if 
end function


dim ie_ifs
ie_ifs = "<!--[if IE 7]>" &_
		"<style>" &_
		".clearfix { display: inline-block; }" &_
				"div.leftLgn { padding: 0; }" &_
				"div#newToPersonnelPlus, div#userAccountHome, div#enrollmentComplete, div#welcomeMessage," &_
				"div#homeBulletin, div#homeMessageArea, div#homeBlogSpot { display: inline-block; }" &_
				"div#homeBulletin, div#newToPersonnelPlus div.tb, div#userAccountHome div.tb, div#enrollmentComplete div.tb, " &_
				"div#welcomeMessage div.tb, div#homeMessageArea div.tb, div#homeBlogSpot div.tb { display: inline-block; }" &_
				"</style>" &_
		"<![endif]-->" &_
		"<!--[if IE 6]>" &_
		"<style>" &_
	
				".clearfix { display: inline-block; }" &_
	
				"/* =================== */" &_
				"/* = ROUNDED CORNERS = */" &_
				"/* =================== */" &_
				"div.b div div," &_
				"div.tb div div, " &_
				"div.bb div div{ height: 6px; margin: 0; font-size: 0; line-height: 0; border-left: solid 1px #A8A8A8; border-right: solid 1px #A8A8A8; }" &_
				"div.mb { padding:0.1em 0.5em; }" &_
				"div.tb { margin-bottom: -2px; }" &_
				"div.tb," &_
				"div.tb div," &_
				"div.bb," &_
				"div.bb div," &_
				"div.b, " &_
				"div.b div { background: none;}" &_
				"div#account ul#loginTabs li a { display: block; padding: 0.5em 2em; margin: 0; }" &_
	
				"div.tb div div { margin: 0; }" &_
				"div.b div div { border: none; }" &_
	
				"</style>" &_
		"<![endif]-->"

		
function css_page_exception (p_Page)
	select case replace(p_Page, "main.asp", "")
		case "/include/user/create/"
			css_page_exception = true
	
		case "/include/user/password/change/"
			css_page_exception = true
			
		case "/include/user/password/reset/"
			css_page_exception = true
			
		case else
			css_page_exception = false
	end select
end function
%>
