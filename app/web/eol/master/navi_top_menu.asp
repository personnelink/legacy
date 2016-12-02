<!-- Revised: 2.10.2009 -->
</head>
<body>
<%
	Response.Expires = -1000 'Makes the browser not cache this page
	Response.Buffer = True 'Buffers the content so our Response.Redirect will work %>
<div id="pageBanner">
  <div id="account" style="float:right">
    <ul id="loginTabs" class="clearfix">
      <li id="logInTab" class="selected">
      <%If Session("SignedIn") <> "true" Then %>
		  <h2><a href="/userHome.asp" title="Log In">Log In</a></h2>
	    <%ElseIf Session("SignedIn") = "true" Then %>
		  <h2><a href="/include/user/signOut.asp" title="Log Out">Log Out</a></h2>
	    <%End If%>
      </li>
      <li id="signUpTab">
        <h2> <a title="Sign Up" href="/include/user/createAccount.asp">Sign Up!</a></h2>
      </li>
    </ul>
  </div>
</div>


<div id="suckerFish">
  <ul>
    <a href="/include/content/home.asp">Home</a>
    <a href="/include/content/resources.asp">Resources</a>
	<a href="/include/content/contact.asp">Contact Us</a>
	<a href="/include/content/about.asp">About Us</a>
	<a href="/include/content/help.asp">Help</a>
	</ul>
	<ul id="applicationTools">
    <li><a href="">Apply Now!</a>
      <ul class="minow">
        <li><a href="">Application Tools</a></li>
        <li><a href="">Send My Resume</a></li>
      </ul>
    </li>
  </ul>
</div>

<div id="pageWrapper">
<div class="pageContent">
