<!-- Revised: 2009.07.26 -->
<!-- Revised: 1.7.2008 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><meta http-equiv="X-UA-Compatible" content="IE=8" /><script type="text/javascript" src="/include/javascript.js"></script><meta name="url" content="http://www.personnelplus.net"><meta name="description" content="Personnel Plus is 'Your Total Staffing Solution'. We specialize in providing quality employees for every job."><meta name="robots" content="index,follow"><link rel="shortcut icon" type="image/x-icon" href="/include/style/images/navigation/pplusicon.gif"><title>Personnel Plus, Inc. Your Total Staffing Solution!</title><!-- Revised: 02.11.2009 --><link href="/include/style/master.css" rel="stylesheet" type="text/css"><link href="/include/style/global.css" rel="stylesheet" type="text/css"><!--[if IE]><link href="/include/style/IEglobal.css" rel="stylesheet" type="text/css"><![endif]--><link href="/include/style/unique/emailResume.asp.css" rel="stylesheet" type="text/css"><!--[if IE 7]>
<style>
.clearfix { display: inline-block; }
				div.leftLgn { padding: 0; }
				div#newToPersonnelPlus, div#userAccountHome, div#enrollmentComplete, div#welcomeMessage,
				div#homeBulletin, div#homeMessageArea, div#homeBlogSpot { display: inline-block; }
				div#homeBulletin, div#newToPersonnelPlus div.tb, div#userAccountHome div.tb, div#enrollmentComplete div.tb, 
				div#welcomeMessage div.tb, div#homeMessageArea div.tb, div#homeBlogSpot div.tb { display: inline-block; }
				</style>
<![endif]-->
<!--[if IE 6]>
<style>

				.clearfix { display: inline-block; }

				/* =================== */
				/* = ROUNDED CORNERS = */
				/* =================== */
				div.b div div,
				div.tb div div, 
				div.bb div div{ height: 6px; margin: 0; font-size: 0; line-height: 0; border-left: solid 1px #A8A8A8; border-right: solid 1px #A8A8A8; }
				div.mb { padding:0.1em 0.5em; }
				div.tb { margin-bottom: -2px; }
				div.tb,
				div.tb div,
				div.bb,
				div.bb div,
				div.b, 
				div.b div { background: none;}
				div#account ul#loginTabs li a { display: block; padding: 0.5em 2em; margin: 0; }

				div.tb div div { margin: 0; }
				div.b div div { border: none; }

				</style>
<![endif]-->

</head>
<body onLoad="grayOut(true)">

<div id="sessionStatus">
	
	  <div id="loginStatus">
		<ul>
		  <li> <a href="/userHome.asp" title='Account Home'>Guest User [logged in]&nbsp;<img src='/include/style/images/mnuUserHome.png' alt=''></a> </li>

		</ul>
	  </div>
	
 </div>
<div id="pageBanner">
  <div id="account" style="float:right;clear:both">
    <ul id="loginTabs" class="clearfix">
      <li id="logInTab" class="selected">
        
        <h2><a href="/include/user/signOut.asp" title="Log Out">Log Out</a></h2>
        
      </li>

      <li id="signUpTab" class="hide">
		<h2> <a title="Apply Now!" href="/include/system/tools/submitapplication.asp" onClick="">Apply Now!</a></h2>
      </li>
    </ul>
  </div>
</div>
<div id="pageNavigation"> 
<ul id="nav" class="dropdown dropdown-horizontal">
	<li><a href="http://www.personnelplus-inc.com/include/content/home.asp">Home</a></li>

	<li><a href="http://www.personnelplus-inc.com/include/content/resources.asp">Resources</a></li>
	<li><a href="http://www.personnelplus-inc.com/include/content/contact.asp">Contact Us</a></li>
	<li><a href="http://www.personnelplus-inc.com/include/content/about.asp">About Us</a></li>
	<li><a href="http://www.personnelplus-inc.com/include/content/help.asp">Help</a></li>
	<li id="navGap">&nbsp;</li>
	<li class="dir rtl"><a href="../../tools/.">Tools</a>

		<ul>


  <li><a href="/include/system/tools/searchJobs.asp" title='Open and Unfilled Jobs'><img src='/include/style/images/mnuJobSearch.png' alt=''>&nbsp;View Job Postings</a></li><li><a href="/include/system/tools/emailResume.asp" title='Send Resume'><img src='/include/style/images/mnuResume.png' alt=''>&nbsp;Send Resume</a></li><li><a href="/include/system/tools/submitapplication.asp" title='Manage Employment Application'><img src='/include/style/images/mnuOnlineApps.png' alt=''>&nbsp;Manage Employment App</a></li><li><a href="/include/user/password/change/" title='Change Password'><img src='/include/style/images/mnuChangePassword.png' alt='Change Password'>&nbsp;Change Password</a></li>
		</ul>
	</li>
</ul>
</div>
<div id="pageWrapper">




<script type="text/javascript" src="/include/js/global.js"></script>

<!-- Revised: 2010.1.1 -->
<!-- Revised: 12.17.2008 -->

    <div id="uploadResumeForm" class="clearfix">
      <div class="tb">
        <div>
          <div></div>

        </div>
      </div>
      <div class="mb clearfix">
        <h4> Upload My Current Resume </h4>
        
        <form enctype="multipart/form-data" method=post id="form1" name="form1" action="/include/system/tools/emailResume.asp?func=2">
          <fieldset id="resumeupload">
          <ul>
            <li>

              <label for="File1">Select your resume to upload</label>
              <input name="File1" size="35" type=file>
            </li>
			</ul>
			<ul>
            <li>
              <label for="zipcode">In what zip code region are you looking for work?</label>
              <input name="zipcode" type="text" style="width:15em;height:1.5em;" value"83301">

            </li>
          </ul>
          <input type="hidden" value="Submit Resume">
          &nbsp;
          </fieldset>
        </form>
      </div>
      <div class="bb">
        <div>

          <div></div>
        </div>
      </div>
      <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:grayOut(true);document.form1.submit();" style="margin-left: 6px" onclick="grayOut(true);document.form1.submit();"><span>Upload Resume</span></a> <a class="squarebutton" href="/userHome.asp" onclick="history.back();"><span>Return</span></a> </div>
      <!-- End of Site content -->
    </div>

    <!-- Revised: 2009.11.21 -->
</div>
<div id="pageFooter">
  <div>
    <div style="text-align:center"> <a href="http://www.personnelplus-inc.com/include/content/privacy.asp">Privacy Policy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.personnelplus-inc.com/include/content/privacy.asp#terms">Terms of Use</a> &nbsp;&nbsp;|&nbsp;&nbsp;<a href="mailto:webmaster@personnelplus-inc.com?Subject=Webmaster Notification"><img src="/include/style/images/pic_mail.gif" alt="" width="13" height="9">&nbsp; Feedback / Notify Webmaster</a> </div>

    <p>&copy;
      <script type="text/javascript">
							<!--
							tday=new Date();
							yr0=tday.getFullYear();
							// end hiding -->
						</script>
      <script type="text/javascript">
							<!-- Hide from old browsers
						    document.write(yr0);
							// end hiding -->
						</script>
      Personnel Plus, Inc. All Rights Reserved. </p>
  </div>
</div>
</body></html>
