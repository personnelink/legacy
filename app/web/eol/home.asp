<!-- #INCLUDE VIRTUAL='include/master/html_header.asp' --> <%
Session("additionalStyling") = "home.asp.css" %>
<!-- #INCLUDE VIRTUAL='include/master/html_styles.asp' -->

<!-- Revision Date: 11.14.2008 -->
<script type="text/javascript">
//here you place the ids of every element you want.
var ids=new Array('employeePane','employerPane','orientationPane');

function switchid(id){	
	hideallids();
	showdiv(id);
}

function hideallids(){
	//loop through the array and hide each element by id
	for (var i=0;i<ids.length;i++){
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
</script>
<style type="text/css">
#employeePane {background:url(/include/images/appProcess.jpg) no-repeat top left; height:288px}
#employeePane p {text-align:right;margin:.5em 10em .5em 12em}
#employeePane ul {text-align:right;margin:0 1em 1em 13em;padding-bottom:2em}
#employerPane {display: none;}
#orientationPane {display: none;}
#homeBulletin {margin:0 0 1em}
</style>
<!-- #INCLUDE VIRTUAL='/include/master/navi_top_menu.asp' -->
 
<%
Session("homeBulletin") = ""
	
  If Len(Session("homeBulletin")) > 0 Then
  	Response.Write(decorateTop("homeBulletin", "", "Making things a little easier..."))
	Response.Write(Session("homeBulletin"))
	Response.Write(decorateBottom())
	End If
	
Dim possibleError
	Do
		possibleError = trapError
		If Len(possibleError) <> 0 Then
	  	Response.Write(decorateTop("homeBulletin", "", "Uh - Ohh..."))
		Response.Write(possibleError)
		Response.Write(decorateBottom())
		End If
	Loop Until Len(possibleError) = 0
   %>
  
   <%=decorateTop("employees", "", "What Personnel Plus can Offer")%>
    <div class="tabsWrap">
      <ul class='tabs clearfix' style="padding:0; margin:-1px">
        <li id='employeeTab'  class='selected' ><a href="javascript:switchid('employeePane');" onClick="document.getElementById('employeeTab').className='selected';document.getElementById('orientationTab').className='notselected';document.getElementById('employerTab').className='notselected'">Employees</a></li>
        <li id='employerTab' class='notselected'><a href="javascript:switchid('employerPane');" onClick="document.getElementById('employeeTab').className='notselected';document.getElementById('orientationTab').className='notselected';document.getElementById('employerTab').className='selected'">Employers</a></li>
        <li id='orientationTab' class='notselected'><a href="javascript:switchid('orientationPane');" onClick="document.getElementById('employeeTab').className='notselected';document.getElementById('orientationTab').className='selected';document.getElementById('employerTab').className='notselected'">Orientation</a></li>
      </ul>
    </div>
    <div id="employeePane" class="clearfix selected">
          <p class="bigger txtBlue"><b>For the Employee!</b>
		    <ul>
              <li>* One Stop Shop for Jobs VS. Dropping off <strong>Many</strong> Resumes</li>
              <li>* Variety of Jobs and Work Environments</li>
              <li>* Your Choice of the Job and the Hours</li>
              <li>* Try the Employer First! </li>
              <li>* <em>Full / Part-Time Work</em></li>
            </ul></p>
            <p class="smaller" style="margin:15.5em 0 1em">Three Convenient Ways to Receive Pay</p>
      </div>
   <div id="employerPane" class="clearfix">
        <div class="valignT left w40 pad5">
          <p class="pad5"><b>For the Employer!</b></p>
          <p><img src="/include/content/images/mainsite/employers.png"></p>
        </div>
        <div class="valignM">
          <ul>
            <li><span class="maroon"><strong>Employees are Screened and Ready to Work!</strong></span></li>
            <li>* General Labor * Manufacturing * Construction * Warehouse *</li>
            <li>* Call Center * Office / Clerical * Bookkeeping * Janitorial *</li>
          </ul>
          <ul>
            <li><em>Temporary or Permanent * Full / Part-Time</em></li>
            <li>* <em>Full / Part-Time Work</em></li>
          </ul>
          <ul>
            <li>Workers Comp.   Coverage Bonded &amp; Insured</li>
          </ul>
        </div>
      </div> 
    <div id="orientationPane" class="clearfix">
        <div class="valignM left w40 pad5">
          <p class="pad5"><b>Orientation!</b></p>
          <p><img src="/include/content/images/mainsite/orientation.png"></p>
        </div>
        <div class="valignM">
          <ul>
            <li><a href="/include/content/legacy/orientation/rules.asp">Rules to Remember</a></li>
            <li><a href="/include/content/legacy/orientation/rights.asp">Your Right to Know</a></li>
            <li><a href="/include/content/legacy/orientation/company/OSHA/OSHA.asp">OSHA</a></li>
          </ul>
        </div>
      </div>
    
    <%=decorateBottom()%>
	<%=decorateTop("newToPersonnelPlus", "", "New To Personnel Plus?")%>
    <div class="valignT left w40 pad5">
      <p class="pad5"><b>Get Started With Personnel Plus!</b></p>
      <p class="pad5">Join for free, and view opportunities, connect with employers, submit your resume, and much more!</p>
    </div>
    <div class="valignT">
      <ul>
        <li><img src="/include/content/images/mainsite/ico_bullhorn.png">Become part of the Personnel Plus Family</li>
        <li><img src="/include/content/images/mainsite/ico_tellus.png">Upload and post your application and resume</li>
        <li><img src="/include/content/images/mainsite/ico_bluesmile.png">View opportunities and network with employers</li>
        <li><img src="/include/content/images/mainsite/ico_light.png">Discover new skills, trades and employers</li>
      </ul>
    </div>
 	</div>
  <div style="border-left:1px solid #A8A8A8;border-right:1px solid #A8A8A8;padding:1px 0px 0">
    <div style="background-color: #FFF8D1; border-top: 1px solid #FDE9AE;padding:1px 0px 0">
      <div class="buttonwrapper" style="padding:1em .5em 1em 0;"> <a class="squarebutton" href="/include/user/create/" style="margin:.25em 1em .25em"><span>Apply Now!</span></a></div>
   </div>
    <%=decorateBottom()%>
	
	 <%=decorateTop("ourMission", "", "Our Mission")%>
    <div class="valignT left w40 pad5">
      <p class="pad5"><img src="/include/content/images/mainsite/shake.jpg"></p>
    </div>
    <div class="valignT">
      <ul>
        <li>Our Mission is to provide the best quality human resource solutions through a network that profits our associates, customers, and communities.</li>
      </ul>
	 </div>
     <%=decorateBottom()%>
<div id="pageWrapper">
      <!-- End of Site content -->
      <!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
