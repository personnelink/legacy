<%Option Explicit%>
<!-- Revised: 2009.07.05 -->
<% Session("additionalStyling") = "submitapplication.asp.css"
If Request.QueryString("action") = "review" Then Session("noHeaders") = true %>

<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
    <!-- Revised: 3.13.2009 -->
    <!-- Revised: 2.9.2009 -->
	

<link href="css/dropdown/dropdown.css" media="all" rel="stylesheet" type="text/css" />
<link href="css/dropdown/themes/default/default.css" media="all" rel="stylesheet" type="text/css" />

<!--[if lt IE 7]>
<script type="text/javascript" src="js/jquery/jquery.js"></script>
<script type="text/javascript" src="js/jquery/jquery.dropdown.js"></script>
<![endif]-->

<ul id="nav" class="dropdown dropdown-horizontal">
	<li><a href="./">Home</a></li>
	<li><a href="./">Resources</a></li>
	<li><a href="./">Contact Us</a></li>
	<li><a href="./">About Us</a></li>
	<li><a href="./">Help</a></li>
	<li id="navGap">&nbsp;</li>
	<li class="dir rtl"><a href="./">Tools</a>
		<ul>
			<li><a href="./">Enquiry Form</a></li>
			<li><a href="./">Enquiry Form</a></li>
			<li><a href="./">Your Feedback</a></li>
		</ul>
	</li>
</ul>

</body>
</html>

<%

'Response.Write(decorateTop("PDFdone", "", "Success!"))


'ApplicationID = Request.Form("appID")
'If ApplicationID = "" Then
'	ApplicationID = Request.QueryString("appID")
'End If

'Set ssnRE = New RegExp
'ssnRE.Pattern = "[()-.<>'$\s]"
'ssnRE.Global = True

'MySql = "Driver={MySQL ODBC 5.1 Driver};Server=x.personnelplus.net;Port=6612;Option=35;Database=pplusvms;User ID=online;Password=.SystemUse"

'Set Database = Server.CreateObject("ADODB.Connection")
'Database.Open MySql

'Dim uaID
'Server.ScriptTimeout=24000
'Set dbQuery = Database.Execute("SELECT id, user_agent FROM tbl_siteaccess WHERE uaID<1")
'Do Until dbQuery.EOF
'	Set uaID = Database.Execute("SELECT id FROM lst_useragents where user_agent='" & dbQuery("user_agent") & "'")
'	If uaID.EOF Then
'		Database.Execute("insert into lst_useragents (user_agent) " &_
'		"VALUES ('" & dbQuery("user_agent") & "');")
'		Set uaID = Database.Execute("SELECT last_insert_id()")
'	End If
'	Database.Execute("Update tbl_siteaccess Set uaID=" & uaID(0) & " Where 	id=" & dbQuery("id"))
'	dbQuery.Movenext
'Loop
'Database.Close
	
%>