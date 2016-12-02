<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->
	<% if session("employerAuth") <> "true" then response.redirect("/lweb/index2.asp") end if%>
	<%
		dim sqlLocation,rsLocation,rsTotalListings,rsTotalApps,rsJobListings
		' get states and provinces
		sqlLocation = "SELECT locCode, locName, display FROM tbl_locations WHERE display ='Y' ORDER BY locCode"
		set rsLocation = Connect.Execute(sqlLocation)
		' count job listings
		Set rsTotalListings = Connect.Execute("SELECT count(companyUserName) AS listingsCount FROM tbl_listings WHERE companyUserName = '" & session("companyUserName") & "'")
		' count job applications
		Set rsTotalApps = Connect.Execute("SELECT count(companyUserName) AS appsCount FROM tbl_applications WHERE companyUserName = '" & session("companyUserName") & "'")
		' get employer job listings
		set rsJobListings = Server.CreateObject("ADODB.RecordSet")
		rsJobListings.Open "SELECT jobID, empID, jobTitle, jobStatus, viewCount, dateCreated FROM tbl_listings WHERE companyUserName = '" & session("companyUserName") & "' ORDER BY dateCreated DESC",Connect,3,3
		' get employer profile
		set rsEmployerProfile = Server.CreateObject("ADODB.RecordSet")
		rsEmployerProfile.Open "SELECT * FROM tbl_employers WHERE empID = '" & session("empID") & "'",Connect,3,3
		
		response.cookies("timecards")("time") = now
	 %>
<HTML>
<HEAD>
<script>
function checktimecard()
{
	isGood = true
	document.TimeSheet.btn_submit.disabled = true
	
	if (document.TimeSheet.company.value == '')
		{	alert("Please enter your Company Name")
		document.TimeSheet.company.focus();
		document.TimeSheet.btn_submit.disabled = false;
			isGood = false;
			return false
		}
	
	if (document.TimeSheet.location.value == '')
		{	alert("Please enter the location.")
		document.TimeSheet.location.focus();
		document.TimeSheet.btn_submit.disabled = false;
			isGood = false;
			return false
		}
	
	if (document.TimeSheet.weekEnding.value == '')
		{	alert("Please enter the Week Ending date.  (Sunday)")
		document.TimeSheet.weekEnding.focus();
		document.TimeSheet.btn_submit.disabled = false;
			isGood = false;
			return false
		}

	if (document.TimeSheet.empName1.value == '')
		{	if (document.TimeSheet.empName2.value == '')
				{	if (document.TimeSheet.empName3.value == '')
						{	if (document.TimeSheet.empName4.value == '')
								{	if (document.TimeSheet.empName5.value == '')
										{	alert("You must fill in one time card.")
										document.TimeSheet.empName1.focus();
										document.TimeSheet.btn_submit.disabled = false;
											isGood = false;
											return false
										}
								}
						}
				}
		}
	
	if (document.TimeSheet.empName1.value != '')
		{	if (document.TimeSheet.SocSec0.value == '')
				{	alert("You must have the Social Security Number entered for EACH employee.")
				document.TimeSheet.SocSec0.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}
	
	if (document.TimeSheet.empName2.value != '')
		{	if (document.TimeSheet.SocSec1.value == '')
				{	alert("You must have the Social Security Number entered for EACH employee.")
				document.TimeSheet.SocSec1.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}
	
	if (document.TimeSheet.empName3.value != '')
		{	if (document.TimeSheet.SocSec2.value == '')
				{	alert("You must have the Social Security Number entered for EACH employee.")
				document.TimeSheet.SocSec2.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}
	
	if (document.TimeSheet.empName4.value != '')
		{	if (document.TimeSheet.SocSec3.value == '')
				{	alert("You must have the Social Security Number entered for EACH employee.")
				document.TimeSheet.SocSec3.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}
	
	if (document.TimeSheet.empName5.value != '')
		{	if (document.TimeSheet.SocSec4.value == '')
				{	alert("You must have the Social Security Number entered for EACH employee.")
				document.TimeSheet.SocSec4.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}

	if (document.TimeSheet.empName1.value != '')
		{	if (document.TimeSheet.mon0.value =='')
				{	if (document.TimeSheet.tue0.value == '')
						{	if (document.TimeSheet.wed0.value == '')
								{	if (document.TimeSheet.thur0.value == '')
										{	if (document.TimeSheet.fri0.value == '')
												{	if (document.TimeSheet.sat0.value == '')
														{	if (document.TimeSheet.sun0.value == '')
																{	alert("You must have atleast one day filled in for each employee.")
																document.TimeSheet.mon0.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}		
				}
		}

	if (document.TimeSheet.empName2.value != '')
		{	if (document.TimeSheet.mon1.value =='')
				{	if (document.TimeSheet.tue1.value == '')
						{	if (document.TimeSheet.wed1.value == '')
								{	if (document.TimeSheet.thur1.value == '')
										{	if (document.TimeSheet.fri1.value == '')
												{	if (document.TimeSheet.sat1.value == '')
														{	if (document.TimeSheet.sun1.value == '')
																{	alert("You must have atleast one day filled in for each employee.")
																document.TimeSheet.mon1.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}		
				}
		}

	if (document.TimeSheet.empName3.value != '')
		{	if (document.TimeSheet.mon2.value =='')
				{	if (document.TimeSheet.tue2.value == '')
						{	if (document.TimeSheet.wed2.value == '')
								{	if (document.TimeSheet.thur2.value == '')
										{	if (document.TimeSheet.fri2.value == '')
												{	if (document.TimeSheet.sat2.value == '')
														{	if (document.TimeSheet.sun2.value == '')
																{	alert("You must have atleast one day filled in for each employee.")
																document.TimeSheet.mon2.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}		
				}
		}

	if (document.TimeSheet.empName4.value != '')
		{	if (document.TimeSheet.mon3.value =='')
				{	if (document.TimeSheet.tue3.value == '')
						{	if (document.TimeSheet.wed3.value == '')
								{	if (document.TimeSheet.thur3.value == '')
										{	if (document.TimeSheet.fri3.value == '')
												{	if (document.TimeSheet.sat3.value == '')
														{	if (document.TimeSheet.sun3.value == '')
																{	alert("You must have atleast one day filled in for each employee.")
																document.TimeSheet.mon3.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}		
				}
		}

	if (document.TimeSheet.empName5.value != '')
		{	if (document.TimeSheet.mon4.value =='')
				{	if (document.TimeSheet.tue4.value == '')
						{	if (document.TimeSheet.wed4.value == '')
								{	if (document.TimeSheet.thur4.value == '')
										{	if (document.TimeSheet.fri4.value == '')
												{	if (document.TimeSheet.sat4.value == '')
														{	if (document.TimeSheet.sun4.value == '')
																{	alert("You must have atleast one day filled in for each employee.")
																document.TimeSheet.mon4.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}		
				}
		}
	
	if (document.TimeSheet.empName1.value != '')
		{	if (document.TimeSheet.Monday0.value == '')
				{	if (document.TimeSheet.Tuesday0.value == '')
						{	if (document.TimeSheet.Wednesday0.value == '')
								{	if (document.TimeSheet.Thursday0.value == '')
										{	if (document.TimeSheet.Friday0.value == '')
												{	if (document.TimeSheet.Saturday0.value == '')
														{	if (document.TimeSheet.Sunday0.value == '')
																{	alert("You must fill in atleast one day of hours for each employee.")
																document.TimeSheet.Monday0.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}
				}
		}

	if (document.TimeSheet.empName2.value != '')
		{	if (document.TimeSheet.Monday1.value == '')
				{	if (document.TimeSheet.Tuesday1.value == '')
						{	if (document.TimeSheet.Wednesday1.value == '')
								{	if (document.TimeSheet.Thursday1.value == '')
										{	if (document.TimeSheet.Friday1.value == '')
												{	if (document.TimeSheet.Saturday1.value == '')
														{	if (document.TimeSheet.Sunday1.value == '')
																{	alert("You must fill in atleast one day of hours for each employee.")
																document.TimeSheet.Monday1.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}
				}
		}

	if (document.TimeSheet.empName3.value != '')
		{	if (document.TimeSheet.Monday2.value == '')
				{	if (document.TimeSheet.Tuesday2.value == '')
						{	if (document.TimeSheet.Wednesday2.value == '')
								{	if (document.TimeSheet.Thursday2.value == '')
										{	if (document.TimeSheet.Friday2.value == '')
												{	if (document.TimeSheet.Saturday2.value == '')
														{	if (document.TimeSheet.Sunday2.value == '')
																{	alert("You must fill in atleast one day of hours for each employee.")
																document.TimeSheet.Monday2.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}
				}
		}

	if (document.TimeSheet.empName4.value != '')
		{	if (document.TimeSheet.Monday3.value == '')
				{	if (document.TimeSheet.Tuesday3.value == '')
						{	if (document.TimeSheet.Wednesday3.value == '')
								{	if (document.TimeSheet.Thursday3.value == '')
										{	if (document.TimeSheet.Friday3.value == '')
												{	if (document.TimeSheet.Saturday3.value == '')
														{	if (document.TimeSheet.Sunday3.value == '')
																{	alert("You must fill in atleast one day of hours for each employee.")
																document.TimeSheet.Monday3.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}
				}
		}

	if (document.TimeSheet.empName5.value != '')
		{	if (document.TimeSheet.Monday4.value == '')
				{	if (document.TimeSheet.Tuesday4.value == '')
						{	if (document.TimeSheet.Wednesday4.value == '')
								{	if (document.TimeSheet.Thursday4.value == '')
										{	if (document.TimeSheet.Friday4.value == '')
												{	if (document.TimeSheet.Saturday4.value == '')
														{	if (document.TimeSheet.Sunday4.value == '')
																{	alert("You must fill in atleast one day of hours for each employee.")
																document.TimeSheet.Monday4.focus();
																document.TimeSheet.btn_submit.disabled = false;
																	isGood = false;
																	return false
																}
														}
												}
										}
								}
						}
				}
		}
	
	empcheckbox0 = false;
	empcheckbox1 = false;
	empcheckbox2 = false;
	empcheckbox3 = false;
	empcheckbox4 = false;

	if (document.TimeSheet.empName1.value != '')
		{	if (document.TimeSheet.approve0.checked)
				{	empcheckbox0 = true
				}
			else
				{	empcheckbox0 = false
				}
		}

	if (document.TimeSheet.empName2.value != '')
		{	if (document.TimeSheet.approve1.checked)
				{	empcheckbox1 = true
				}
			else
				{	empcheckbox1 = false
				}
		}

	if (document.TimeSheet.empName3.value != '')
		{	if (document.TimeSheet.approve2.checked)
				{	empcheckbox2 = true
				}
			else
				{	empcheckbox2 = false
				}
		}

	if (document.TimeSheet.empName4.value != '')
		{	if (document.TimeSheet.approve3.checked)
				{	empcheckbox3 = true
				}
			else
				{	empcheckbox3 = false
				}
		}

	if (document.TimeSheet.empName5.value != '')
		{	if (document.TimeSheet.approve4.checked)
				{	empcheckbox4 = true
				}
			else
				{	empcheckbox4 = false
				}
		}
	
	if (document.TimeSheet.empName1.value != '')
		{	if (empcheckbox0 == false)
				{	alert("You need to approve all time.")
				document.TimeSheet.approve0.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}

	if (document.TimeSheet.empName2.value != '')
		{	if (empcheckbox1 == false)
				{	alert("You need to approve all time.")
				document.TimeSheet.approve1.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}

	if (document.TimeSheet.empName3.value != '')
		{	if (empcheckbox2 == false)
				{	alert("You need to approve all time.")
				document.TimeSheet.approve2.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}

	if (document.TimeSheet.empName4.value != '')
		{	if (empcheckbox3 == false)
				{	alert("You need to approve all time.")
				document.TimeSheet.approve3.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}

	if (document.TimeSheet.empName5.value != '')
		{	if (empcheckbox4 == false)
				{	alert("You need to approve all time.")
				document.TimeSheet.approve4.focus();
				document.TimeSheet.btn_submit.disabled = false;
					isGood = false;
					return false;
				}
		}
	

	if (document.TimeSheet.TotalApproved.checked)
		{
		}
		else
		{	alert("You must approve all time.")
		document.TimeSheet.TotalApproved.focus();
		document.TimeSheet.btn_submit.disabled = false;
			isGood = false;
			return false
		}	

	if (document.TimeSheet.signHere.value == '')
		{	alert("You need to sign your First Name, Middle Name, Last Name, and your job title.")
		document.TimeSheet.signHere.focus();
		document.TimeSheet.btn_submit.disabled = false;
			isGood = false;
			return false
		}

	if (document.TimeSheet.title.value == '')
		{	alert("You need to sign your First Name, Middle Name, Last Name, and your job title.")
		document.TimeSheet.title.focus();
		document.TimeSheet.btn_submit.disabled = false;
			isGood = false;
			return false
		}
	
		if (isGood != false)
		{	document.TimeSheet.submit();
			return true;
		}
	
}
</script>
<meta http-equiv="Content-Language" content="en-us">
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/js/autototal.js' -->
<title>Email Time Cards</title>
</HEAD>
<BODY onLoad="ShowExample();">
<NOSCRIPT>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</NOSCRIPT>
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_top.asp' -->
<!-- NAVI TOP START CLSP8 -->
<form name="TimeSheet" action="/lweb/employers/registered/timecards/form/emailtime.asp" method="post">
<table border="0" width="84%" cellspacing="0" cellpadding="0">
	<tr>
		<td rowspan="2" width="16%" nowrap>
		<p align="center"><input type="reset" value="Reset Time Card"></td>
		<td colspan="3">
		<p align="center">Company:&nbsp;<input type="text" name="company" size="82" value="<%=session("companyName")%>" tabindex="1"></td>
	</tr>
	<tr>
		<td width="28%">
			<p align="center">Location: &nbsp;<input type="text" name="location" tabindex="2"></td>
		<td width="32%">
			<p align="center">Week Ending:&nbsp;<input type="text" name="weekEnding" tabindex="3"></td>
		<td width="9%">&nbsp;
			</td>
	</tr>
</table>
<table border="0" width="77%" cellspacing="1" height="161">
	<tr>
		<td align="center" height="21" colspan="12">
		***********************************************************************************************</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="21">
		<p align="center">Employee Name</td>
		<td align="center" height="21">
		<p align="center">Notes  <font size="1">(optional)</font></td>
		<td width="6%" align="center" height="21">&nbsp;</td>
		<td width="5%" align="center" height="21">MON</td>
		<td width="5%" align="center" height="21">TUE</td>
		<td width="5%" align="center" height="21">WED</td>
		<td width="5%" align="center" height="21">THUR</td>
		<td width="5%" align="center" height="21">FRI</td>
		<td width="5%" align="center" height="21">SAT</td>
		<td width="5%" align="center" height="21">SUN</td>
		<td width="10%" colspan="2" align="center" nowrap height="21">TOTAL HOURS</td>
	</tr>
	<tr>
		<td rowspan="4" width="13%" align="center">
		<textarea cols="11" rows="4" name="empName1" tabindex="4"></textarea></td>
		<td rowspan="6" align="center"><p align="center">
		<textarea cols="18" rows="7" name="description0" tabindex="6"></textarea></td>
		<td width="6%" align="right" height="24">Dates:</td>
		<td width="5%" align="center" height="24">
		<input type="text" name="mon0" size="5" value="" onFocus="startMatch();" onBlur="stopMatch();" tabindex="7"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="tue0" size="5" value="" onFocus="startMatch();" onBlur="stopMatch();" tabindex="9"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="wed0" size="5" value="" onFocus="startMatch();" onBlur="stopMatch();" tabindex="11"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="thur0" size="5" value="" onFocus="startMatch();" onBlur="stopMatch();" tabindex="13"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="fri0" size="5" value="" onFocus="startMatch();" onBlur="stopMatch();" tabindex="15"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sat0" size="5" value="" onFocus="startMatch();" onBlur="stopMatch();" tabindex="17"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sun0" size="5" value="" onFocus="startMatch();" onBlur="stopMatch();" tabindex="19"></td>
		<td width="5%" align="center" height="24">Reg</td>
		<td width="5%" align="center" height="24">OT</td>
	</tr>
	<tr>
		<td width="6%" align="right" nowrap height="18"><font size="1">Total Hours</font></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Monday0" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="8"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Tuesday0" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="10"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Wednesday0" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="12"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Thursday0" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="14"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Friday0" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="16"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Saturday0" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="18"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Sunday0" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="20"></td>
		<td width="5%" align="center" height="18"><input type="text" name="regTime0" size="5" readonly="true"></td>
		<td width="5%" align="center" height="18"><input type="text" name="otTime0" size="5" readonly="true"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap height="18" colspan="10">
		<p align="center">By checking the box, you are approving the above hours&nbsp;<input type="checkbox" value="Approved" name="approve0" tabindex="21"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap colspan="10" rowspan="2" bgcolor="#FF0000">
		<p align="center"><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>
	</tr>
	<tr>
		<td width="13%" align="center">
		<p align="center">Social Security #</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="24">
		<input type="text" name="SocSec0" size="9" tabindex="5"></td>
		<td width="51%" align="right" nowrap colspan="10" height="24">
		<p align="center">&nbsp;&nbsp;</td>
	</tr>
</table>
<table border="0" width="77%" cellspacing="1" height="161">
	<tr>
		<td align="center" height="21" colspan="12">
		***********************************************************************************************</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="21">
		<p align="center">Employee Name</td>
		<td align="center" height="21">
		<p align="center">Notes  <font size="1">(optional)</font></td>
		<td width="6%" align="center" height="21">&nbsp;</td>
		<td width="5%" align="center" height="21">MON</td>
		<td width="5%" align="center" height="21">TUE</td>
		<td width="5%" align="center" height="21">WED</td>
		<td width="5%" align="center" height="21">THUR</td>
		<td width="5%" align="center" height="21">FRI</td>
		<td width="5%" align="center" height="21">SAT</td>
		<td width="5%" align="center" height="21">SUN</td>
		<td width="10%" colspan="2" align="center" nowrap height="21">TOTAL HOURS</td>
	</tr>
	<tr>
		<td rowspan="4" width="13%" align="center">
		<textarea cols="11" rows="4" name="empName2" tabindex="22"></textarea></td>
		<td rowspan="6" align="center"><p align="center">
		<textarea cols="18" rows="7" name="description1" tabindex="24"></textarea></td>
		<td width="6%" align="right" height="24">Dates:</td>
		<td width="5%" align="center" height="24">
		<input type="text" name="mon1" size="5" tabindex="25"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="tue1" size="5" tabindex="27"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="wed1" size="5" tabindex="29"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="thur1" size="5" tabindex="31"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="fri1" size="5" tabindex="33"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sat1" size="5" tabindex="35"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sun1" size="5" tabindex="37"></td>
		<td width="5%" align="center" height="24">Reg</td>
		<td width="5%" align="center" height="24">OT</td>
	</tr>
	<tr>
		<td width="6%" align="right" nowrap height="18"><font size="1">Total Hours</font></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Monday1" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="26"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Tuesday1" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="28"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Wednesday1" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="30"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Thursday1" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="32"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Friday1" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="34"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Saturday1" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="36"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Sunday1" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="38"></td>
		<td width="5%" align="center" height="18"><input type="text" name="regTime1" size="5" readonly="true"></td>
		<td width="5%" align="center" height="18"><input type="text" name="otTime1" size="5" readonly="true"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap height="18" colspan="10">
		<p align="center">By checking the box, you are approving the above hours&nbsp;&nbsp;<input type="checkbox" value="Approved" name="approve1" tabindex="39"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap colspan="10" rowspan="2" bgcolor="#FF0000">
		<p align="center"><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>
	</tr>
	<tr>
		<td width="13%" align="center">
		<p align="center">Social Security #</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="24">
		<input type="text" name="SocSec1" size="9" tabindex="23"></td>
		<td width="51%" align="right" nowrap colspan="10" height="24">
		<p align="center"></td>
	</tr>
</table>
<table border="0" width="77%" cellspacing="1" height="161">
	<tr>
		<td align="center" height="21" colspan="12">
		***********************************************************************************************</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="21">
		<p align="center">Employee Name</td>
		<td align="center" height="21">
		<p align="center">Notes  <font size="1">(optional)</font></td>
		<td width="6%" align="center" height="21">&nbsp;</td>
		<td width="5%" align="center" height="21">MON</td>
		<td width="5%" align="center" height="21">TUE</td>
		<td width="5%" align="center" height="21">WED</td>
		<td width="5%" align="center" height="21">THUR</td>
		<td width="5%" align="center" height="21">FRI</td>
		<td width="5%" align="center" height="21">SAT</td>
		<td width="5%" align="center" height="21">SUN</td>
		<td width="10%" colspan="2" align="center" nowrap height="21">TOTAL HOURS</td>
	</tr>
	<tr>
		<td rowspan="4" width="13%" align="center">
		<textarea cols="11" rows="4" name="empName3" tabindex="40"></textarea></td>
		<td rowspan="6" align="center"><p align="center">
		<textarea cols="18" rows="7" name="description2" tabindex="42"></textarea></td>
		<td width="6%" align="right" height="24">Dates:</td>
		<td width="5%" align="center" height="24">
		<input type="text" name="mon2" size="5" tabindex="43"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="tue2" size="5" tabindex="45"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="wed2" size="5" tabindex="47"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="thur2" size="5" tabindex="49"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="fri2" size="5" tabindex="51"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sat2" size="5" tabindex="53"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sun2" size="5" tabindex="55"></td>
		<td width="5%" align="center" height="24">Reg</td>
		<td width="5%" align="center" height="24">OT</td>
	</tr>
	<tr>
		<td width="6%" align="right" nowrap height="18"><font size="1">Total Hours</font></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Monday2" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="44"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Tuesday2" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="46"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Wednesday2" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="48"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Thursday2" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="50"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Friday2" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="52"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Saturday2" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="54"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Sunday2" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="56"></td>
		<td width="5%" align="center" height="18"><input type="text" name="regTime2" size="5" readonly="true"></td>
		<td width="5%" align="center" height="18"><input type="text" name="otTime2" size="5" readonly="true"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap height="18" colspan="10">
		<p align="center">By checking the box, you are approving the above hours&nbsp;&nbsp;<input type="checkbox" value="Approved" name="approve2" tabindex="57"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap colspan="10" rowspan="2" bgcolor="#FF0000">
		<p align="center"><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>
	</tr>
	<tr>
		<td width="13%" align="center">
		<p align="center">Social Security #</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="24">
		<input type="text" name="SocSec2" size="9" tabindex="41"></td>
		<td width="51%" align="right" nowrap colspan="10" height="24">
		<p align="center"></td>
	</tr>
</table>
<table border="0" width="77%" cellspacing="1" height="161">
	<tr>
		<td align="center" height="21" colspan="12">
		***********************************************************************************************</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="21">
		<p align="center">Employee Name</td>
		<td align="center" height="21">
		<p align="center">Notes  <font size="1">(optional)</font></td>
		<td width="6%" align="center" height="21">&nbsp;</td>
		<td width="5%" align="center" height="21">MON</td>
		<td width="5%" align="center" height="21">TUE</td>
		<td width="5%" align="center" height="21">WED</td>
		<td width="5%" align="center" height="21">THUR</td>
		<td width="5%" align="center" height="21">FRI</td>
		<td width="5%" align="center" height="21">SAT</td>
		<td width="5%" align="center" height="21">SUN</td>
		<td width="10%" colspan="2" align="center" nowrap height="21">TOTAL HOURS</td>
	</tr>
	<tr>
		<td rowspan="4" width="13%" align="center">
		<textarea cols="11" rows="4" name="empName4" tabindex="58"></textarea></td>
		<td rowspan="6" align="center"><p align="center">
		<textarea cols="18" rows="7" name="description3" tabindex="60"></textarea></td>
		<td width="6%" align="right" height="24">Dates:</td>
		<td width="5%" align="center" height="24">
		<input type="text" name="mon3" size="5" tabindex="61"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="tue3" size="5" tabindex="63"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="wed3" size="5" tabindex="65"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="thur3" size="5" tabindex="67"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="fri3" size="5" tabindex="69"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sat3" size="5" tabindex="71"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sun3" size="5" tabindex="73"></td>
		<td width="5%" align="center" height="24">Reg</td>
		<td width="5%" align="center" height="24">OT</td>
	</tr>
	<tr>
		<td width="6%" align="right" nowrap height="18"><font size="1">Total Hours</font></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Monday3" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="62"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Tuesday3" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="64"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Wednesday3" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="66"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Thursday3" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="68"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Friday3" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="70"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Saturday3" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="72"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Sunday3" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="74"></td>
		<td width="5%" align="center" height="18"><input type="text" name="regTime3" size="5" readonly="true"></td>
		<td width="5%" align="center" height="18"><input type="text" name="otTime3" size="5" readonly="true"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap height="18" colspan="10">
		<p align="center">By checking the box, you are approving the above hours&nbsp;&nbsp;<input type="checkbox" value="Approved" name="approve3" tabindex="75"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap colspan="10" rowspan="2" bgcolor="#FF0000">
		<p align="center"><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>
	</tr>
	<tr>
		<td width="13%" align="center">
		<p align="center">Social Security #</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="24">
		<input type="text" name="SocSec3" size="9" tabindex="59"></td>
		<td width="51%" align="right" nowrap colspan="10" height="24">
		<p align="center"></td>
	</tr>
</table>
<table border="0" width="77%" cellspacing="1" height="161">
	<tr>
		<td align="center" height="21" colspan="12">
		***********************************************************************************************</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="21">
		<p align="center">Employee Name</td>
		<td align="center" height="21">
		<p align="center">Notes  <font size="1">(optional)</font></td>
		<td width="6%" align="center" height="21">&nbsp;</td>
		<td width="5%" align="center" height="21">MON</td>
		<td width="5%" align="center" height="21">TUE</td>
		<td width="5%" align="center" height="21">WED</td>
		<td width="5%" align="center" height="21">THUR</td>
		<td width="5%" align="center" height="21">FRI</td>
		<td width="5%" align="center" height="21">SAT</td>
		<td width="5%" align="center" height="21">SUN</td>
		<td width="10%" colspan="2" align="center" nowrap height="21">TOTAL HOURS</td>
	</tr>
	<tr>
		<td rowspan="4" width="13%" align="center">
		<textarea cols="11" rows="4" name="empName5" tabindex="76"></textarea></td>
		<td rowspan="6" align="center"><p align="center">
		<textarea cols="18" rows="7" name="description4" tabindex="78"></textarea></td>
		<td width="6%" align="right" height="24">Dates:</td>
		<td width="5%" align="center" height="24">
		<input type="text" name="mon4" size="5" tabindex="79"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="tue4" size="5" tabindex="81"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="wed4" size="5" tabindex="83"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="thur4" size="5" tabindex="85"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="fri4" size="5" tabindex="87"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sat4" size="5" tabindex="89"></td>
		<td width="5%" align="center" height="24">
		<input type="text" name="sun4" size="5" tabindex="91"></td>
		<td width="5%" align="center" height="24">Reg</td>
		<td width="5%" align="center" height="24">OT</td>
	</tr>
	<tr>
		<td width="6%" align="right" nowrap height="18"><font size="1">Total Hours</font></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Monday4" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="80"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Tuesday4" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="82"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Wednesday4" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="84"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Thursday4" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="86"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Friday4" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="88"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Saturday4" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="90"></td>
		<td width="5%" align="center" height="18">
		<input type="text" name="Sunday4" size="5" value="" onFocus="startCalc();" onBlur="stopCalc();" tabindex="92"></td>
		<td width="5%" align="center" height="18"><input type="text" name="regTime4" size="5" readonly="true"></td>
		<td width="5%" align="center" height="18"><input type="text" name="otTime4" size="5" readonly="true"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap height="18" colspan="10">
		<p align="center">By checking the box, you are approving the above hours&nbsp;&nbsp;<input type="checkbox" value="Approved" name="approve4" tabindex="93"></td>
	</tr>
	<tr>
		<td width="51%" align="right" nowrap colspan="10" rowspan="2" bgcolor="#FF0000">
		<p align="center"><em><strong>Round Hours to<br>nearest quarter hour</strong></em></td>
	</tr>
	<tr>
		<td width="13%" align="center">
		<p align="center">Social Security #</td>
	</tr>
	<tr>
		<td width="13%" align="center" height="24">
		<input type="text" name="SocSec4" size="9" tabindex="77"></td>
		<td width="51%" align="right" nowrap colspan="10" height="24">
		<p align="center"></td>
	</tr>
</table>
<table border="0" width="50%" cellspacing="1">
	<tr>
		<td width="397">
		<p align="right">Total Hours to be Billed:</td>
		<td width="43" align="center">Reg</td>
		<td colspan="2" align="center">OT</td>
	</tr>
	<tr>
		<td width="397">
		<p align="right"><b>Check this box to approve all time.</b>&nbsp; 
		<input type="checkbox" name="TotalApproved" value="All time Approved." tabindex="94">&nbsp;&nbsp;</td>
		<td width="43" align="center">
		<input type="text" name="TotalregTime" size="5" readonly="true"></td>
		<td colspan="2" align="center">
		<input type="text" name="TotalOTTime" size="5" readonly="true"></td>
	</tr>
</table>
<table border="0" width="100%" cellspacing="1">
	<tr>
		<td colspan="4"><font size="1">CLIENT NOTICE AND VERIFICATION:  The undersigned, as agent for the client company, certifies that the Personnel Plus associate named<br>herein worked acceptably during the period noted on this time sheet.&nbsp;&nbsp;The undersigned also acknowledges and accepts the terms and conditions listed <a href="/employers/registered/timecards/form/terms.asp" target="_blank">here</a> whereby this associate has been supplied by Personel Plus.  Please read the
		</font> <a href="/employers/registered/timecards/form/terms.asp" target="_blank">
		<font size="1">terms and conditions.</font></a></td>
	</tr>
	<tr>
		<td align="center">
		<input type="text" name="signHere" size="65" tabindex="95"></td>
		<td width="15%" align="center" colspan="2"><input type="text" name="title" tabindex="96"></td>
		<td width="36%"><% response.write request.cookies("timecards")("time") %></td>
	</tr>
	<tr>
		<td width="48%" align="center">
		________________________________________</td>
		<td width="15%" align="center" colspan="2">______________</td>
		<td width="36%">
		<input type="button" name="btn_submit" value="Send Card(s)" onClick="checktimecard();" tabindex="97"></td>
	</tr>
	<tr>
		<td width="99%" colspan="4" height="37"><font size="1">By electronically signing 
		your first, middle, last name, and your title, you agree to the hours 
		listed above in the &quot;Total Hours&quot; section.</font></td>
	</tr>
</table>
</form>
<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/advertise/inc/navi_btm.asp' -->
</BODY>
</HTML>