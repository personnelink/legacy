	<!-- 'Welcome User' Summary on User's Home -->
	
	<div class="pageNavigation">
	  <div id="generalmenu">
		<div class="tb">
		  <div>
			<div></div>
		  </div>
		</div>
		<div class="mb clearfix">
		  <div class="marB10 bordered">
		  <h4> Account Tools </h4>
			<ul class="pad10">
			  <li><a href="/userHome.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_menuHome.gif" alt="Home"/>Account Home</a></li>
			  <li><a href="/include/content/help.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_firsttimeusers.gif" alt="First Time">First-Time Users</a></li>
			  <li><a href="/eol/blog_add.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_concern.gif" alt="Add Blog">Post a Blog</a></li>
			</ul>
		  </div>
		  <%
	If Session("userLevel") >=userLevelAssigned Then %>
		  <div class="marB10 bordered">
			<h4> Job Tools </h4>
			<ul class="pad10">
			  <%
				If Session("userLevel") >=userLevelSupervisor then %>
			  <li><a href="/include/tools/requisitioncenter.asp?Action=0"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_jobrequisition.gif" alt="Job Requisition"/>Job Requisitions</a></li>
			  <%
				End If %>
			  <li><a href="/include/tools/manageTimecards.asp"> <img style='border:none;padding-right:5px' src='/include/style/images/ico_msgTime.gif' alt="Time"/>Timecards</a></li>
			  <%
				If Session("userLevel") >=userLevelSupervisor then %>
			  <li><a href="#"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_interviews.gif" alt="interviews"/>Interviews</a></li>
			  <%
				End If %>
			</ul>
		  </div>
		  <%
	End If 
	
	If Session("userLevel") >=userLevelPPlusStaff then %>
		  <div class="marB10 bordered">
			<h4> Placement </h4>
			<ul class="pad10">
			  <li><a href="/include/tools/applicantCenter.asp?Action=0"> <img style='border:none;' src='/include/style/images/ico_applicantCenter.gif' alt="Applicant Center">Applicant Center</a></li>
			  <li><a href="/include/tools/addApplicant.asp?Action=0"> <img style='border:none;' src='/include/style/images/ico_addApplicant.gif' alt="Add New Applicant">Add New Applicant</a></li>
			</ul>
		  </div>
		  <%
	End If 
	
	If Session("userLevel") =< userLevelEngaged  then %>
		  <div class="marB10 bordered">
			<h4> Skills Evaluation </h4>
			<ul class="pad10">
			  <li><a href="/eol/testing/general.asp"> <img style='border:none;' src='/include/style/images/ico_prePlacement.gif' alt="General Competency"/>General Competency</a></li>
			</ul>
		  </div>
		  <%
	End If %>
		  <!-- User Specific Tasks Summary on User's Home -->
		  <div class="marB5 bordered">
			<h4> Job Tools </h4>
			<ul class="pad10">
			  <% If Session("userLevel") < userLevelResume Then %>
			  <li><a href="/include/tools/emailResume.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_menuResume.gif" alt="Resume"/>Send My Resume</a></li>
			  <% ElseIf Session("userLevel") <= userLevelEngaged Then %>
			  <li><a href="/include/tools/emailResume.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_menuResume.gif" alt="Resume"/>Upload New Resume</a></li>
			  <% ElseIf Session("userLevel") => userLevelPPlusStaff Then %>
			  <li><a href="/seekers/new/emailresume/upload2.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_menuResume.gif" alt="Resume"/>Resume Digests</a></li>
			  <% End If %>
			  <% If Session("userLevel") =< userLevelApplicant Then %>
			  <li><a href="/include/tools/submitapplication.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_menuApplication.gif" alt="Application"/>My Application</a></li>
			  <% End If %>
			  <li><a href="/include/user/manageProfile.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_profile.gif" alt="Profile"/>Change My Profile</a></li>
			  <li><a href="/include/user/changePassword.asp"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_changepassword.gif" alt="Change Password"/>Change Password</a></li>
			</ul>
		  </div>
		  <%
	
	If Session("userLevel") >= userLevelAdministrator Then %>
		  <div class="marB5 bordered">
			<h4> Administrative </h4>
			<ul class="pad10">
			  <li><a href="/include/tools/manageUsers.asp?Action=0"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_user.gif" alt="Mange Users"/>Manage Users</a></li>
			  <li><a href="/include/tools/manageLocations.asp?Action=0"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_location.gif" alt="Locations"/>Manage Locations</a></li>
			  <li><a href="/include/tools/manageDepartments.asp?Action=0"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_department.gif" alt="Departments"/>Manage Departments</a></li>
			  <li><a href="#"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_companyprofile.gif" alt="Company Profile"/>Edit Company Profile</a></li>
			  <li><a href="#"> <img style="border:none;padding-right:5px" src="/include/style/images/ico_reports.gif" alt="Reports"/>VMS Reports</a></li>
			</ul>
		  </div>
		  <%
	End If %>
		</div>
		<div class="bb">
		  <div>
			<div></div>
		  </div>
		</div>
	  </div>
	</div>
