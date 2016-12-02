<%
session("add_css") = "home.asp.css,./include/system/tools/applicant/job_postings/searchJobs.css" %>
<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<script type="text/javascript">

    var ids = new Array('employeePane', 'employerPane', 'orientationPane');

    function switchid(id) {
        hideallids();
        showdiv(id);
    }

    function hideallids() {
        //loop through the array and hide each element by id
        for (var i = 0; i < ids.length; i++) {
            hidediv(ids[i]);
        }
    }

    function hidediv(id) {
        //safe function to hide an element with a specified id
        if (document.getElementById) { // DOM3 = IE5, NS6
            document.getElementById(id).style.display = 'none';
        }
        else {
            if (document.layers) { // Netscape 4
                document.id.display = 'none';
            }
            else { // IE 4
                document.all.id.style.display = 'none';
            }
        }
    }

    function showdiv(id) {
        //safe function to show an element with a specified id

        if (document.getElementById) { // DOM3 = IE5, NS6
            document.getElementById(id).style.display = 'block';
        }
        else {
            if (document.layers) { // Netscape 4
                document.id.display = 'block';
            }
            else { // IE 4
                document.all.id.style.display = 'block';
            }
        }
    }

    var tabIds = new Array('employeeTab', 'employerTab', 'orientationTab');
    function changeSelection(id) {
        //loop through the array and hide each element by id
        for (var i = 0; i < ids.length; i++) {
            document.getElementById(tabIds[i]).className = 'notcurrent';
        }
        document.getElementById(id).className = 'current'
    }

</script>


<%
	dim ifAppliedOnline, ifLocateCandidate
	ifAppliedOnline = "hide"
	ifLocateCandidate = "hide"
	
	dim strAppliedOnline, strLocateCandidate
		strAppliedOnline = "<div id='appCompletedBlog'><p>Your online application has been successfully submitted!<br><br>If you are completing your registration from outside our " &_
		"offices, you will need to stop in to finalize your application. " &_
		"The best time for this, and to have an interview, is Mon-Fri 9am-2pm. " &_
		"Be sure to bring appropriate identification to complete your Employment Eligibility Verification Form I-9 [such as a Drivers License and Social Security Card]. " &_
		"Please don't hesitate to contact one of our <a href='/include/content/contact.asp'><b>offices</b></a> if you have any questions.</p>" &_
		"<p>&nbsp;</p><p><strong>Again thanks for submitting your employment application with "  &_
		"us!</strong> We look forward to meeting and working with you to find opportunities!</p></div>"

	strLocateCandidate = "<div id='locateCandidateBlog'><p>Your request for an employment Candidate has been successfully sent! The time frame for successfully " &_
		"finding an employee for you is going to vary based on our current employee base and your specific needs. We are committed to sending the most " &_
		"qualified applicants. You may decide to do a personal interview of the top candidates or we can fill a position based on the qualifications you " &_
		"provide at the time you place the order.</p>" &_
		"<p>&nbsp;</p><p><strong>Thank you again for giving us this opportunity to help our Candidates find and help you!</strong> We look forward to " &_
		"working with you!</p></div>"
select case Request.QueryString("AST")
case "ao"
	ifAppliedOnline = "show"

case "lc"
	ifLocateCandidate = "show"
end select
	response.write(decorateTop("applicationCompleted", "marLR10 " & ifAppliedOnline, "Online Application Completed!"))
	response.write(strAppliedOnline)
	response.write(decorateBottom())
	
	response.write(decorateTop("locateCandidate", "marLR10 " & ifLocateCandidate, "Thank you for the opportunity!"))
	response.write(strLocateCandidate)
	response.write(decorateBottom())

session("homeBulletin") = ""
	
  if len(session("homeBulletin")) > 0 then
  	response.write(decorateTop("homeBulletin", "marLR10", "Making things a little easier..."))
	response.write(session("homeBulletin"))
	response.write(decorateBottom())
	end if
	
dim possibleError
	Do
		possibleError = trapError
		if len(possibleError) <> 0 then
	  	response.write(decorateTop("homeBulletin", "marLR10", "Uh - Ohh..."))
		response.write(possibleError)
		response.write(decorateBottom())
		end if
	loop Until len(possibleError) = 0
	
'dim upgradesInProgress
'	upgradesInProgress = "<div id='upgradesInProgress'><p style='font-size:1.4em'>System Upgrades in Progress</p>" &_
'		"<p>Starting at 7:00pm October 23, 2009 (Friday) we will be upgrading the network servers. The services, like job postings and the online application, may be unavailable " &_
'		" at the moment. We'll be back up and running again before long, so please try again soon. Thanks for your patience!</p></div>"
'	response.write(decorateTop("upgrading", "", "Upgrades in Progress"))
'	response.write(upgradesInProgress)
'	response.write(decorateBottom())
%><!-- for employer <%=decorateTop("employers", "marLR10", "Some of what Personnel Plus offers Employers")%>
  <div id="employeePane" class="clearfix selected">
    <table>
  <tr>
  <td><a href="/include/system/tools/applicant/job_postings/"><div>
  <img src="/include/content/images/searchJobs.png" alt="Search Jobs"></div></a></td>
  <td><a href="/include/system/tools/applicant/job_postings/">
  <span class="optionHeading">Browse Our Jobs</span><br><strong>Job Postings</strong>
  <br>Browse through our current job openings and submit your application on-line</p></a></td>
  </td>
  <td><a href="/include/system/tools/applicant/resume/">
  <img src="/include/content/images/sendResume.png" alt="Send Resume"></a></td>
  <td><a href="/include/system/tools/applicant/resume/">
  <span class="optionHeading">Have a Resume?</span><br><strong>Upload & Go</strong>
  <br>Upload your resume and let our system put it into our employment database automatically.</p></a></td></tr>
  <tr>
  <td><a href="/userHome.asp">
  <img src="/include/content/images/logIn.png" alt="Log In"></a></td>
  <td><a href="/userHome.asp">
  <span class="optionHeading">Already Registered?</span><br><strong>Sign in to your account</strong>
  <br>Keep your application current, express your interest in posted jobs, and keep us updated via uploading your current resumes.</p></a></td>
  
  <td><a href="/include/system/tools/applicant/application/">
  <img src="/include/content/images/employmentApp.png" alt="Employment Application"></a></td>
  <td><a href="/include/system/tools/applicant/application/">
  <span class="optionHeading">Apply Now!</span><br><strong>Don't have a Resume?</strong>
  <br>Save time and get going today by sending and completing your employment application on-line!</p></a>
  </td></tr>
  </table>
  </div>
  <%=decorateBottom()%> -->
<%=decorateTop("employees", "marLR10", "What Personnel Plus Offers Employees")%>
<div id="employeePane" class="clearfix selected">
    <table>
        <tr>
            <td><a href="/include/system/tools/applicant/job_postings/">
                <div>
                    <img src="/include/content/images/searchJobs.png" alt="Search Jobs">
                </div>
            </a></td>
            <td><a href="/include/system/tools/applicant/job_postings/">
                <span class="optionHeading">Browse Our Jobs</span><br>
                <strong>Job Postings</strong>
                <br>
                Browse through our current job openings and submit your application online</a>
            </td>

            <td><a href="/include/system/tools/applicant/resume/">
                <img src="/include/content/images/sendResume.png" alt="Send Resume"></a></td>
            <td><a href="/include/system/tools/applicant/resume/">
                <span class="optionHeading">Have a Resume?</span><br>
                <strong>Upload & Go</strong>
                <br>
                Upload your resume and let our system put it into our employment database automatically.</a></td>
        </tr>
        <tr>
            <td><a href="/userHome.asp">
                <img src="/include/content/images/logIn.png" alt="Log In"></a></td>
            <td><a href="/userHome.asp">
                <span class="optionHeading">Already Registered?</span><br>
                <strong>Sign in to your account</strong>
                <br>
                Keep your application current, express your interest in posted jobs, and keep us updated via uploading your current resumes.</a></td>

            <td><a href="/include/system/tools/applicant/application/">
                <img src="/include/content/images/employmentApp.png" alt="Employment Application"></a></td>
            <td><a href="/include/system/tools/applicant/application/">
                <span class="optionHeading">Apply Now!</span><br>
                <strong>Don't have a Resume?</strong>
                <br>
                Save time and get going today by sending and completing your employment application online!</a>
            </td>
        </tr>
    </table>
</div>
<%=decorateBottom()%>
<%=decorateTop("newToPersonnelPlus", "mar10", "New To Personnel Plus?")%>
<div class="valignT left w60 pad5 txtBlue">
    <p class="pad5"><b>Get Started With Personnel Plus!</b></p>
    <p class="pad5">Join for free, and view opportunities, connect with employers, submit your resume, and much more!</p>
</div>
<div class="valignT txtBlue">
    <ul>
        <li>
            <img src="/include/content/images/mainsite/ico_bullhorn.png" alt="">Become part of the Personnel Plus Family</li>
        <li>
            <img src="/include/content/images/mainsite/ico_tellus.png" alt="">Upload and post your application and resume</li>
        <li>
            <img src="/include/content/images/mainsite/ico_bluesmile.png" alt="">View opportunities and network with employers</li>
        <li>
            <img src="/include/content/images/mainsite/ico_light.png" alt="">Discover new skills, trades and employers</li>
    </ul>
</div>
<div style="clear: both; padding: 1px 0px 0">
    <div style="background-color: #FFF8D1; border-top: 1px solid #FDE9AE; padding: 1px 0px 0">
        <div class="buttonwrapper" style="padding: 1em .5em 1em 0;"><a class="squarebutton" href="/include/system/tools/submitapplication.asp" style="margin: .25em 1em .25em"><span>Apply Now!</span></a> <a class="squarebutton" href="/include/content/timecard.pdf" style="margin: .25em 1em .25em"><span>Need a time card?</span></a></div>
    </div>
</div>
<%=decorateBottom()%>
<%=decorateTop("employeeExtra", "marLR10", "For the Employee!")%>
<div id="employeeBlurb" class="clearfix selected">
    <div class="bigger txtBlue">
        <ul>
            <li>* One Stop Shop for Job Opportunites</li>
            <li>* Exposes your resume to <strong>Many</strong> opportunities</li>
            <li>* Variety of Jobs and Work Environments</li>
            <li>* Your Choice of the Job and the Hours</li>
            <li>* Try the Employer First! </li>
            <li>* <em>Full / Part-Time Work</em></li>
        </ul>
    </div>
    <div class="smaller txtBlue" style="margin: 8em 0 1em">
        <ul>
            <li><em>Three Convenient Ways to Receive Pay</em></li>
            <li>
                <img src="/include/images/threeWays4Pay.jpg"></li>
        </ul>
    </div>
</div>
<div id="our-mission-is" class="txtBlue">
    <ul>
        <li>Our Mission is to provide the best quality human resource solutions through a network that profits our associates, customers, and communities.</li>
    </ul>
</div>

<%=decorateBottom()%>

<%=decorateTop("", "marLR10", "Current Job Opportunities")%>
<div id="currentjoboppurtunities" class="" style="height: 24em; width: 98%; overflow: auto; overflow-x: hidden;">

    <%
	dim currentjobs
	Set currentjobs = Server.CreateObject("MSXML2.ServerXMLHTTP")

	currentjobs.Open "GET", "https://www.personnelinc.com/include/system/tools/applicant/job_postings/?isservice=true", false
	currentjobs.Send
	Response.write currentjobs.responseText
	Set currentjobs = Nothing
    %>
</div>
<%=decorateBottom()%>

<%=decorateTop("", "marLR10", "")%>
<div style="background: transparent url('https://www.chamberofcommerce.com/Portals/0/images/badges/badges01.jpg') no-repeat; width: 158px; height: 25px; *width: 165px; *height: 50px; line-height: 10px; text-align: left; padding: 25px 0px 0px 7px; margin: 0px 0 0 18px;"><a style="color: #000; font-size: 11px; font-weight: bold; font-family: arial; text-decoration: none;" href="http://www.chamberofcommerce.com/twin-falls-id/medical-diagnostic-laboratories/">Medical & Diagnostic Laboratories in Twin Falls</a></div>
<%=decorateBottom()%>

<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
