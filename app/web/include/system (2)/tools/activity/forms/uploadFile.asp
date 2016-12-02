<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>
<body>

<form enctype="multipart/form-data" method="post" id="uploadform" name="uploadform" action="uploadFile.asp">
  <p>
	<label for="File1">Select your resume to upload</label>
	<input id="filename" name="File1" size="45" type="file">
  </p>
  <input type="hidden" value="Submit Resume">
  <div class="buttonwrapper" style="padding:10px 0 10px 0;"> <a class="squarebutton" href="javascript:grayOut(true);document.form1.submit();" style="margin-left: 6px" onclick="grayOut(true);document.form1.submit();"><span>Upload Resume</span></a> </div>
</form>

</body>
</html>
