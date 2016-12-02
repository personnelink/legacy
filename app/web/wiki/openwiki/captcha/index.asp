<%
DIM C_CAPCHA_PAGE,C_WIKI_PAGE,C_CAPCHA_ERROR_PAGE,C_PAGE,C_ACTION
C_CAPCHA_PAGE = "http://www.bamber.com/capcha/index.asp"
C_WIKI_PAGE = Request.Querystring("WikiReferrer")
C_PAGE = Request.Querystring("p")
C_ACTION = Request.Querystring("a")
C_CAPCHA_ERROR_PAGE = "CapchaError"

'	// Make up the return path to the Wiki Page
'	// The params should be p=[pagename]&a=edit
Params="p=" & C_PAGE & "&a=" & C_ACTION
ReturnURL=C_WIKI_PAGE & "?" & Params

%>
<HTML>
	<HEAD>
		<title>Captcha anti-spam page</title>
<link rel="stylesheet" type="text/css" href="css/ow.css" />
<% If C_WIKI_PAGE <> "" Then %>
		<script>
		function createCode(){
		 var temp="";
		 for(var i=0;i<5;i++)
			{
			temp+= Math.round(Math.random() * 8 );
			document.getElementById('theImg').src="http://www.bamber.com///capcha//JpegImage.aspx?code=" +temp;
			document.getElementById('Hidden1').value=temp;
			}
		}
		</script>
<% End If %>
	</HEAD>
<% If C_WIKI_PAGE <> "" Then %>
	<body onload="createCode();window.defaultStatus='CAPTCHA server at bamber.com'">
		<a href="http://www.openwiking.com" target="_blank"><img src="images/logo.gif" align="right" border="0" alt="OpenWikiNG" /></a>
		<h2>CaptchaImage Test hosted by bamber.com</h2>
		<h3>Referring Wiki: <%=C_WIKI_PAGE%></h3>
		<p>&nbsp; <img id="theImg" src=""><br>
		</p>
		<form id="Default" method="post" action="<%=ReturnURL%>">
			<p>
				<strong>Enter the code shown above:</strong><br>
				<input id="CodeNumberTextBox" name="CodeNumberTextBox" > 
				<input type=submit id="SubmitCapcha " name="SubmitCapcha"  Text="Submit">
				<INPUT id="Hidden1" type="hidden" name="Hidden1">
				<INPUT id="capcha" type="hidden" name="capcha" value="yes">
				<INPUT type="hidden" name="submitted" value="yes">
			</p>
		</form>
	<h4>This once-a-week test is to stop SpamBots from posting to this wiki</h4>
	Input the number as you see it on the image above, and click [Submit]
<% Else %>
<body onload="window.defaultStatus='CAPTCHA server at bamber.com'">
<a href="http://www.openwiking.com" target="_blank"><img src="images/logo.gif" align="right" border="0" alt="OpenWikiNG" /></a>
<p>&nbsp;</p>
<h2>CaptchaImage Test hosted by bamber.com</h2>
	<p>This page is not designed to be viewed on its own.</p>
	<hr/>
<% End If %>
	</body>
</HTML>
