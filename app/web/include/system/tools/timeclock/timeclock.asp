<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html  lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><meta http-equiv="X-UA-Compatible" content="IE=8" /><script type="text/javascript" src="/include/js/jQuery-1.10.2.min.js"></script></script><meta name="url" content="https://www.personnelinc.com"><meta name="description" content="Personnel Plus is Your Total Staffing Solution. Time reporting"><meta name="robots" content="index,follow"><meta name="apple-mobile-web-app-capable" content="yes"><link rel="shortcut icon" type="image/x-icon" href="/include/style/images/navigation/pplusicon.gif"><title>Personnel Plus - Your Total Staffing Solution!</title><link href="timeclock.css" rel="stylesheet" type="text/css"></head>
<%

dim global_debug
select case request.querystring("debugging")
case "1"
	global_debug = true
case else
	global_debug = false
end select

if global_debug then
	dim  objFS, debug_log
	set objFS=Server.CreateObject("Scripting.FileSystemObject")
	const FilePath = "c:\vmsDebug\vms_debug.txt"
	if objFS.FileExists(FilePath) then
		set debug_log=objFS.OpenTextFile(FilePath, 8) '8 = Appending
	else
		set debug_log=objFS.CreateTextFile("c:\vmsDebug\vms_debug.txt",true)
	end if
		
	debug_log.WriteLine("--- Start Logging ---")
	debug_log.WriteLine(time())
end if

session("metatagging") = "<meta name=""apple-mobile-web-app-capable"" content=""yes"">"
session("window_page_title") = "Timeclock"
%>
<!-- #include virtual='/include/core/html_header.asp' -->


<script type="text/javascript" src="/include/js/jQuery-1.10.2.min.js"></script>
<script type="text/javascript" src="timeclock.js"></script>
<body>
<div id="topleftscrew"></div>
<div id="toprightscrew"></div>
	<div id="user_info_div">
		<!-- <img src="photo.jpg" style="float:right;"><div style="float:left;">
		' <div style="font-size:105%; width:10em;text-align:right;padding-right:0.2em;">FirstName<span style="display:block;font-size:60%;color:white;">Shipping and Receiving<br><i>Glanbia</i></span></span></span>
		' </div>
	' </div> -->
	</div>

	<div id="id_container">
	<div id="timeclock_label" style="">Timeclock</div>
			<div id="badge_id">
				<table>
				<tr>
					<th><span>Badge Id</span></th>
				</tr>
				<tr>
					<td><input name="siteid_applicantid" id="siteid_applicantid" type="text" value="" onchange="check_swipe;" /></td>
				</tr>
				</table>
			</div><br />
		<img src="pp_logo.png">
	</div>
<div id="innertube">	
	<div id="chose_action"></div>
	<div id="cost_center"></div>
	<div id="clock_action_results" class="hide"></div>

	<div id="readerror"><div style="border:1px solid #65539f;background-color:#65539f;float:left;clear:both;margin:0.8em 0 0;padding:0.2em 0.2em">
		<table style="width:25em;">
		<tr><td colspan="2"></td></tr>
		<tr>
			<td colspan="2"><span style="color:white; font-weight:bold;">Card swipe read error, please try again. <br><br></span></td>
		</tr>
		<tr><td colspan="2"></td></tr>
		<tr><td colspan="2"></td></tr>
		</table>
	</div></div>

</div>
<div id="bottomleftscrew"></div>
<div id="bottomrightscrew"></div>

<a href="javascript:;" onclick="javascript:(function(){var e=document.createElement('script');e.type='text/javascript';e.src='jKeyboard.js.php';document.getElementsByTagName('head')[0].appendChild(e);})();"><div id="personnelinc"><img src="personnelinc.png"></div>
<div id="clock"><span id="time_span">time</span><span id="date_span">date</span><span id="linkurl">www.personnelinc.com</span></div></a>


<!-- #include virtual='/include/core/dispose_service_session.asp' -->