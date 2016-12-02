<SCRIPT type="text/javascript" language="javascript">

/*
Clear default form value script- By Ada Shimar (ada@chalktv.com)
Featured on JavaScript Kit (http://javascriptkit.com)
Visit javascriptkit.com for 400+ free scripts!
*/

function clearText(thefield){
if (thefield.defaultValue==thefield.value)
thefield.value = ""
} 

function checkInfo()	  
{
var isGood = true
if ((document.hpform.uN.value.length < 4) || (document.hpform.uN.value.length > 30))
  {
isGood=false
mesg2 = "You have entered " + document.hpform.uN.value.length + " character(s) for the user name.\n"
mesg2 = mesg2 + "Valid user names are 4 or more characters long.\n"
mesg2 = mesg2 + "Please verify your entry and try again."
alert(mesg2);
document.hpform.uN.value = "";
document.hpform.uN.focus();
return false;
  }
	
if ((document.hpform.uNer.value.length < 5) || (document.hpform.uNer.value.length > 30))
    {
isGood=false
mesg = "You have entered " + document.hpform.uNer.value.length + " character(s) for the password.\n"
mesg = mesg + "Valid passwords are 5 or more characters long.\n"
mesg = mesg + "Please verify your entry and try again."
alert(mesg);
document.hpform.uNer.value = "";
document.hpform.uNer.focus();
return false;
    }  


  
  if (isGood==true) {

    document.hpform.submit()
  }  
}

function checkInfo2()	  
{
var isGood = true
if ((document.empLogin.companyUserName.value.length < 4) || (document.empLogin.companyUserName.value.length > 30))
  {
isGood=false
mesg2 = "You have entered " + document.empLogin.companyUserName.value.length + " character(s) for the user name.\n"
mesg2 = mesg2 + "Valid user names are 4 or more characters long.\n"
mesg2 = mesg2 + "Please verify your entry and try again."
alert(mesg2);
document.empLogin.companyUserName.value = "";
document.empLogin.companyUserName.focus();
return false;
  }
	
if ((document.empLogin.password.value.length < 5) || (document.empLogin.password.value.length > 30))
    {
isGood=false
mesg = "You have entered " + document.empLogin.password.value.length + " character(s) for the password.\n"
mesg = mesg + "Valid passwords are 5 or more characters long.\n"
mesg = mesg + "Please verify your entry and try again."
alert(mesg);
document.empLogin.password.value = "";
document.empLogin.password.focus();
return false;
    }  


  
  if (isGood==true) {

    document.empLogin.submit()
  }  
}

function checkInfo3()	  
{
var isGood = true
	
if ((document.orLogin.password.value.length < 5) || (document.orLogin.password.value.length > 30))
    {
isGood=false
mesg = "You have entered " + document.orLogin.password.value.length + " character(s) for the password.\n"
mesg = mesg + "Valid passwords are 5 or more characters long.\n"
mesg = mesg + "Please verify your entry and try again."
alert(mesg);
document.orLogin.password.value = "";
document.orLogin.password.focus();
return false;
    }  


  
  if (isGood==true) {

    document.orLogin.submit()
  }  
}

</SCRIPT>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META http-equiv="description" NAME="DESCRIPTION" CONTENT="Personnel Plus is Southern Idaho's total staffing solution. Quality employees for quality employers.">
<META http-equiv="keywords" NAME="KEYWORDS" CONTENT="job, jobs, boise, work, employment, employers, staffing service, job training, utah, nampa, twin falls, burley, jerome,  personnel, personnel plus, personel, personel plus, part time jobs, full time jobs, temporary jobs, find a job, search jobs, search resumes, idaho jobs, twin falls jobs, potato state jobs, future jobs, short time jobs, career, career change, career opportunities, carer oportunities, high wage jobs, minimum wage jobs">
<META NAME="AUTHOR" CONTENT="personnelplus">
<META NAME="URL" CONTENT="HTTP://www.personnelplus-inc.com">
<link rel="stylesheet" href="/style/default.css">
