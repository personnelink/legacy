<script language = "Javascript">
/**
 * DHTML phone number validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */

// Declaring required variables
var digits = "0123456789";
// non-digit characters which are allowed in phone numbers
var phoneNumberDelimiters = "()- ";
// characters which are allowed in international phone numbers
// (a leading + is OK)
var validWorldPhoneChars = phoneNumberDelimiters + "+";
// Minimum no of digits in an international phone no.
var minDigitsInIPhoneNumber = 10;

function isInteger(s)
{   var i;
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag)
{   var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function checkInternationalPhone(strPhone)
{	s=stripCharsInBag(strPhone,validWorldPhoneChars);
	return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
}

function ValidateForm(){
	var Phone=document.applyDirect.contactPhone
	
	if ((Phone.value==null)||(Phone.value=="")){
		alert("Please enter the best phone number to contact you at.")

		return false
	}
	if (checkInternationalPhone(Phone.value)==false){
		alert("Please enter a valid 10 digit phone number. Be sure to include your area code.")
		Phone.value=""

		return false
	}
	return true
 }
</script>
<script language="javaScript">
function checkApplyDirect() {
  var okSoFar=true 
document.applyDirect.submit_btn.disabled = true;	  

  //-- officeSelector
  if (document.applyDirect.officeSelector.value == "")	{
	okSoFar=false
	alert("Please select the nearest office location before continuing.")
	document.applyDirect.officeSelector.focus();
	document.applyDirect.submit_btn.disabled = false;		
	return false
  }	

  //-- officeSelector part 2
  if (document.applyDirect.officeSelector.value == "other")  {
  	if (document.applyDirect.other_location.value == "")  {
	  	okSoFar=false
	  	alert("Please tell us where you are located.")
	  	document.applyDirect.other_location.focus();
	  	document.applyDirect.submit_btn.disabled = false;
	  	return false
  	}
	 var officeSelector = "twin@personnel.com";
  }
 
   //-- firstName
  if (document.applyDirect.firstName.value == "") {
    okSoFar=false
    alert("Please enter your first name")
    document.applyDirect.firstName.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
 
   //-- lastName
  if (document.applyDirect.lastName.value == "") {
    okSoFar=false
    alert("Please enter your last name")
    document.applyDirect.lastName.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
 
   //-- addressOne
  if (document.applyDirect.addressOne.value == "") {
    okSoFar=false
    alert("Please enter a mailing or street address")
    document.applyDirect.addressOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
   //-- city
  if (document.applyDirect.city.value == "") {
    okSoFar=false
    alert("Please enter your city")
    document.applyDirect.city.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
 
   //-- zipCode
  if (document.applyDirect.zipCode.value == "") {
    okSoFar=false
    alert("Please enter your zipcode")
    document.applyDirect.zipCode.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }
 
   //-- contactPhone or emailAddress
  if (document.applyDirect.contactPhone.value == "" && document.applyDirect.emailAddress.value == "") {
    okSoFar=false
    alert("So we may contact you, please enter either your contact phone number or email address")
    document.applyDirect.contactPhone.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
  
   //-- desiredWageAmount
  if (document.applyDirect.desiredWageAmount.value == "") {
    okSoFar=false
    alert("Please enter your desired wage or salary amount")
    document.applyDirect.desiredWageAmount.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }   
  
   //-- minWageAmount
  if (document.applyDirect.minWageAmount.value == "") {
    okSoFar=false
    alert("Please enter your minimum wage or salary amount")
    document.applyDirect.minWageAmount.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }    
 
   //-- workTypeDesired
  if (document.applyDirect.workTypeDesired.value == "") {
    okSoFar=false
    alert("Please select the type of work you are seeking")
    document.applyDirect.workTypeDesired.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
 
  //-- workAuth
  if (document.applyDirect.workAuth.value == "") {
    okSoFar=false
    alert("Please indicate your authorization to work in the U.S.")
    document.applyDirect.workAuth.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  } 
  //-- workAuthProof
  if (document.applyDirect.workAuthProof.value == "") {
    okSoFar=false
    alert("Please indicate whether or not you have proof of US citizenship.\nSome common types of proof are:\n\n-Social Security Card\n-Drivers License\n-Passports\n-Military ID\n-State-issued ID cards.")
    document.applyDirect.workAuthProof.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }   

  //-- workAge
  if (document.applyDirect.workAge.value == "") {
    okSoFar=false
    alert("Please indicate if you are 18 years of age or older.")
    document.applyDirect.workAge.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  } 
  //-- workValidLicense
  if (document.applyDirect.workValidLicense.value == "") {
    okSoFar=false
    alert("Please indicate whether or not you have a valid drivers license.")
    document.applyDirect.workValidLicense.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  } 

  //-- workRelocate
  if (document.applyDirect.workRelocate.value == "") {
    okSoFar=false
    alert("Please indicate whether or not you are planning to relocate for work.")
    document.applyDirect.workRelocate.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
      
  //-- workConviction
  if (document.applyDirect.workConviction.value == "") {
    okSoFar=false
    alert("Please indicate if you've been convicted of a crime or have been released from jail as a result of a prior conviction.")
    document.applyDirect.workConviction.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false	
  } 
  
  //-- workConviction  workConvictionExplain
  if (document.applyDirect.workConviction.value == "Yes" && document.applyDirect.workConvictionExplain.value == "") {
    okSoFar=false
    alert("You answered 'Yes' to a felony conviction; please explain the circumstances in the box provided.")
    document.applyDirect.workConvictionExplain.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false	
  }  
  
      
    //-- jobHistTitleOne
  if (document.applyDirect.jobHistTitleOne.value == "") {
    okSoFar=false
    alert("Please enter your most recent job title.")
    document.applyDirect.jobHistTitleOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  } 
  //-- jobHistCpnyOne
  if (document.applyDirect.jobHistCpnyOne.value == "") {
    okSoFar=false
    alert("Please enter the name of the last company you worked for.")
    document.applyDirect.jobHistCpnyOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  } 
  //-- jobHistPhoneOne
  if (document.applyDirect.jobHistPhoneOne.value == "") {
    okSoFar=false
    alert("Please enter the phone number of the last company you worked for.")
    document.applyDirect.jobHistPhoneOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  } 
  //-- jobDutiesOne
  if (document.applyDirect.jobDutiesOne.value == "") {
    okSoFar=false
    alert("Please provide a brief summary of your most recent job duties and functions.")
    document.applyDirect.jobDutiesOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }   
  
  //--  jobHistSMonthOne, jobHistSYearOne
  if (document.applyDirect.jobHistSMonthOne.value == "" || document.applyDirect.jobHistSYearOne.value == "") {
    okSoFar=false
    alert("Please enter a complete starting date of your most recent job.")
    document.applyDirect.jobHistSMonthOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  } 
  //--  jobHistEMonthOne, jobHistEYearOne
  if (document.applyDirect.jobHistEMonthOne.value == "" || document.applyDirect.jobHistEYearOne.value == "") {
    okSoFar=false
    alert("Please enter a complete ending date of your most recent job.")
    document.applyDirect.jobHistEMonthOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }   

  //-- jobReasonOne
  if (document.applyDirect.jobReasonOne.value == "") {
    okSoFar=false
    alert("Please select a reason for leaving your last job. Select 'Other Reason' from the list if needed and use the provided space to enter your specific reason(s).")
    document.applyDirect.jobReasonOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }     
  
  //-- jobReasonOne jobOtherReasonOne
  if (document.applyDirect.jobReasonOne.value == "Other" && document.applyDirect.jobOtherReasonOne.value == "") {
    okSoFar=false
    alert("Please enter your reason(s) for leaving your last job in the space provided.")
    document.applyDirect.jobReasonOne.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }    
 
  //-- eduLevel
  if (document.applyDirect.eduLevel.value == "") {
    okSoFar=false
    alert("Please select the highest level of education completed.")
    document.applyDirect.eduLevel.focus();
	document.applyDirect.submit_btn.disabled = false;
	return false
  }  
  
  //-- emailAddress
  var foundAt = document.applyDirect.emailAddress.value.indexOf("@",0)
  var foundDot = document.applyDirect.emailAddress.value.indexOf(".",0)
  if (foundAt+foundDot < 2 && okSoFar) {
    okSoFar = false
    alert ("Your E-mail address was incomplete.")
	document.applyDirect.submit_btn.disabled = false;
    document.applyDirect.emailAddress.focus();
  }
   
  //-- workRelocate
  if (document.applyDirect.workRelocate.value == "No") {
    okSoFar=false
{var agree2=confirm("If you currently reside outside of Idaho but wish to find work in your area, you may take advantage of this website by creating a free account now. Your account will allow you to search and apply for jobs throughout the U.S.\nWould you like to create your free account now?");
		if (agree2)
window.location="/seekers/new/newAcct1.asp"
//else
//    document.applyDirect.submit_btn.disabled = false;	
//	return false ;
	} 
  }  
  
   if (okSoFar != false) 
  
{var agree=confirm("Ready to send your application?");
		if (agree)
			{
//			document.applyDirect.submit_btn.disabled = false;
			document.applyDirect.action = "/seekers/new/applyDirect2.asp";
			document.applyDirect.submit();
			}
else
    document.applyDirect.submit_btn.disabled = false;	
	return false ;
	}   
}

function ValidateForm(){
	var Phone=document.applyDirect.contactPhone
	
	if ((Phone.value==null)||(Phone.value=="")){
		alert("Please enter the best phone number to contact you at.")

		return false
	}
	if (checkInternationalPhone(Phone.value)==false){
		alert("Please enter a valid 10 digit phone number. Be sure to include your area code.")
		Phone.value=""

		return false
	}
	return true
 }
</script>

<script language="javaScript">
function checkApplyDirect2() {
  var okSoFar=true 
document.applyDirect.email_resume.disabled = true;	  

  //-- officeSelector
  if (document.applyDirect.officeSelector.value == "")	{
	okSoFar=false
	alert("Please select the nearest office location before continuing.")
	document.applyDirect.officeSelector.focus();
	document.applyDirect.email_resume.disabled = false;		
	return false
  }	
  
  //-- officeSelector part 2
  if (document.applyDirect.officeSelector.value == "other")  {
  	if (document.applyDirect.other_location.value == "")  {
	  	okSoFar=false
	  	alert("Please tell us where you are located.")
	  	document.applyDirect.other_location.focus();
	  	document.applyDirect.email_resume.disabled = false;
	  	return false
  	}
	 var officeSelector = "twin@personnel.com";
  }
	  	
   //-- firstName
  if (document.applyDirect.firstName.value == "") {
    okSoFar=false
    alert("Please enter your first name")
    document.applyDirect.firstName.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
 
   //-- lastName
  if (document.applyDirect.lastName.value == "") {
    okSoFar=false
    alert("Please enter your last name")
    document.applyDirect.lastName.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
 
   //-- addressOne
  if (document.applyDirect.addressOne.value == "") {
    okSoFar=false
    alert("Please enter a mailing or street address")
    document.applyDirect.addressOne.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
   //-- city
  if (document.applyDirect.city.value == "") {
    okSoFar=false
    alert("Please enter your city")
    document.applyDirect.city.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
 
   //-- zipCode
  if (document.applyDirect.zipCode.value == "") {
    okSoFar=false
    alert("Please enter your zipcode")
    document.applyDirect.zipCode.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }
 
   //-- contactPhone or emailAddress
  if (document.applyDirect.contactPhone.value == "" && document.applyDirect.emailAddress.value == "") {
    okSoFar=false
    alert("So we may contact you, please enter either your contact phone number or email address")
    document.applyDirect.contactPhone.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
  
   //-- desiredWageAmount
  if (document.applyDirect.desiredWageAmount.value == "") {
    okSoFar=false
    alert("Please enter your desired wage or salary amount")
    document.applyDirect.desiredWageAmount.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }   
  
   //-- minWageAmount
  if (document.applyDirect.minWageAmount.value == "") {
    okSoFar=false
    alert("Please enter your minimum wage or salary amount")
    document.applyDirect.minWageAmount.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }    
 
   //-- workTypeDesired
  if (document.applyDirect.workTypeDesired.value == "") {
    okSoFar=false
    alert("Please select the type of work you are seeking")
    document.applyDirect.workTypeDesired.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
 
  //-- workAuth
  if (document.applyDirect.workAuth.value == "") {
    okSoFar=false
    alert("Please indicate your authorization to work in the U.S.")
    document.applyDirect.workAuth.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  } 
  //-- workAuthProof
  if (document.applyDirect.workAuthProof.value == "") {
    okSoFar=false
    alert("Please indicate whether or not you have proof of US citizenship.\nSome common types of proof are:\n\n-Social Security Card\n-Drivers License\n-Passports\n-Military ID\n-State-issued ID cards.")
    document.applyDirect.workAuthProof.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }   

  //-- workAge
  if (document.applyDirect.workAge.value == "") {
    okSoFar=false
    alert("Please indicate if you are 18 years of age or older.")
    document.applyDirect.workAge.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  } 
  //-- workValidLicense
  if (document.applyDirect.workValidLicense.value == "") {
    okSoFar=false
    alert("Please indicate whether or not you have a valid drivers license.")
    document.applyDirect.workValidLicense.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  } 

  //-- workRelocate
  if (document.applyDirect.workRelocate.value == "") {
    okSoFar=false
    alert("Please indicate whether or not you are planning to relocate for work.")
    document.applyDirect.workRelocate.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
      
  //-- workConviction
  if (document.applyDirect.workConviction.value == "") {
    okSoFar=false
    alert("Please indicate if you've been convicted of a crime or have been released from jail as a result of a prior conviction.")
    document.applyDirect.workConviction.focus();
	document.applyDirect.email_resume.disabled = false;
	return false	
  } 
  
  //-- workConviction  workConvictionExplain
  if (document.applyDirect.workConviction.value == "Yes" && document.applyDirect.workConvictionExplain.value == "") {
    okSoFar=false
    alert("You answered 'Yes' to a felony conviction; please explain the circumstances in the box provided.")
    document.applyDirect.workConvictionExplain.focus();
	document.applyDirect.email_resume.disabled = false;
	return false	
  }  
   
  //-- eduLevel
  if (document.applyDirect.eduLevel.value == "") {
    okSoFar=false
    alert("Please select the highest level of education completed.")
    document.applyDirect.eduLevel.focus();
	document.applyDirect.email_resume.disabled = false;
	return false
  }  
  
  //-- emailAddress
  var foundAt = document.applyDirect.emailAddress.value.indexOf("@",0)
  var foundDot = document.applyDirect.emailAddress.value.indexOf(".",0)
  if (foundAt+foundDot < 2 && okSoFar) {
    okSoFar = false
    alert ("Your E-mail address was incomplete.")
	document.applyDirect.email_resume.disabled = false;
    document.applyDirect.emailAddress.focus();
  }
    
  //-- workRelocate
  if (document.applyDirect.workRelocate.value == "No") {
    okSoFar=false
{var agree2=confirm("If you currently reside outside of Idaho but wish to find work in your area, you may take advantage of this website by creating a free account now. Your account will allow you to search and apply for jobs throughout the U.S.\nWould you like to create your free account now?");
		if (agree2)
window.location="/seekers/new/newAcct1.asp"
else
    document.applyDirect.email_resume.disabled = false;	
	return false ;
	} 
  }  
  
	  if (okSoFar != false)
	  
		{var agree=confirm("Continue?");
			if (agree)
				{ 
//				  document.applyDirect.email_resume.disabled = false;
				  document.applyDirect.action = "/seekers/new/emailresume/upload.asp";
				  document.applyDirect.submit();
				}
	  else
		document.applyDirect.email_resume.disabled = false;
		return false ;
		}
	}

</script>