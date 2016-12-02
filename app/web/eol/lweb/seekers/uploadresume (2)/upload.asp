<!-- #INCLUDE VIRTUAL='/lweb/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/checkCookies.asp' -->

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<!-- #INCLUDE VIRTUAL='/lweb/inc/head.asp' -->
<title><%=session("lastName")%>, <%=session("firstName")%>  - Upload an Existing 
Resume - Personnel Plus, Inc.</title>


<script language="javaScript">

function ValidateResume() {
	var Path=document.resume.resumepath
	if ((Path.value==null)||(Path.value="")) {
		alert("Please browse or instert the path to your resume before continuing.")
		return false
	}
	return true
}

function checkResumePath() {
  var okSoFar=true 
document.resume.submit_btn.disabled = true;

//-- ResumePath
	
	if ((document.resume.resumepath.value==null)||(document.resume.resumepath.value=="")){
		alert("Please browse or insert the path to your resume.")
		document.resume.resumepath.focus();
		document.resume.submit_btn.disabled=false;
		return false
	}
	return true
 }

</script>

</head>

<body>
<noscript>Your internet browser does not support scripting on this page. Please be sure you have the most current browser version installed</noscript>
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_top.asp' -->
<div align="center">
	&nbsp;<table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="1" align="center">Upload your resume now...</td>
		</tr>
		<tr>
			<td>
				<br><br><br>
			</td>
		</tr>
		<tr>
			<td colspan="1" align="center">
<!--				<FORM NAME="resume" METHOD="POST" ACTION="upload2.asp"> 
					File 1:<INPUT TYPE=FILE NAME="resumepath" onBlur="return ValidateResume()">&nbsp;&nbsp;<strong>Resume</strong><BR>
					File 2:<INPUT TYPE=FILE NAME="coverpath">&nbsp;&nbsp;<strong>Cover Letter</strong><BR><BR><BR> 
					<INPUT TYPE="SUBMIT" name="submit_btn" style="background:#003399; border:1 #C7D2E0 solid; font-size:9px; font-weight:bold; color:#FFFFFF;" VALUE="Send Now!" onClick="checkResumePath()">&nbsp;&nbsp;&nbsp;<INPUT TYPE="button" name="reset_btn" style="background:#ff0000; border:1 #C7D2E0 solid; font-size:9px; font-weight:bold; color:#FFFFFF;" VALUE="Start Over" onClick="javascript:document.resume.reset();">				
				</FORM>
-->
<FORM METHOD="POST" ENCTYPE="multipart/form-data" ACTION="upload2.asp">
 <TABLE BORDER=0>
 <tr><td><b>Enter your fullname:</b><br><INPUT TYPE=TEXT SIZE=40 NAME="FULLNAME" value="<%=session("lastName")%>, <%=session("firstName")%>"></td></tr>
 <tr><td><b>Select a file to upload:</b><br><INPUT TYPE=FILE SIZE=50 NAME="FILE1"></td></tr>
 <tr><td><b>Save To:</b>&nbsp;&nbsp;
  Disk&nbsp;<INPUT TYPE=RADIO NAME="saveto" value="disk" checked>&nbsp;&nbsp;
  Database&nbsp;<INPUT TYPE=RADIO NAME="saveto" value="database">
 </td></tr>
 <tr><td align="center"><INPUT TYPE=SUBMIT VALUE="Upload!"></td></tr>
 </TABLE>
</FORM>
				<br><br><br>
		</tr>
	</table>
</div>

<!-- NAVI BTM START CLSP10 -->
<!-- #INCLUDE VIRTUAL='/lweb/inc/navi_btm.asp' -->
</body>
</html>
