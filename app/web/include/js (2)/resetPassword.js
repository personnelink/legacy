document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "190";

document.write('<style type="text/css">input.styled { display: none; } select.styled { position: relative; width: ' + selectWidth + 'px; opacity: 0; filter: alpha(opacity=0); z-index: 5; }</style>');

var Custom = {
	init: function() {
		var inputs = document.getElementsByTagName("input"), span = Array(), textnode, option, active;
		for(a = 0; a < inputs.length; a++) {
			if((inputs[a].type == "checkbox" || inputs[a].type == "radio") && inputs[a].className == "styled") {
				span[a] = document.createElement("span");
				span[a].className = inputs[a].type;

				if(inputs[a].checked == true) {
					if(inputs[a].type == "checkbox") {
						position = "0 -" + (checkboxHeight*2) + "px";
						span[a].style.backgroundPosition = position;
					} else {
						position = "0 -" + (radioHeight*2) + "px";
						span[a].style.backgroundPosition = position;
					}
				}
				inputs[a].parentNode.insertBefore(span[a], inputs[a]);
				inputs[a].onchange = Custom.clear;
				span[a].onmousedown = Custom.pushed;
				span[a].onmouseup = Custom.check;
				document.onmouseup = Custom.clear;
			}
		}
		inputs = document.getElementsByTagName("select");
		for(a = 0; a < inputs.length; a++) {
			if(inputs[a].className == "styled") {
				option = inputs[a].getElementsByTagName("option");
				active = option[0].childNodes[0].nodeValue;
				textnode = document.createTextNode(active);
				for(b = 0; b < option.length; b++) {
					if(option[b].selected == true) {
						textnode = document.createTextNode(option[b].childNodes[0].nodeValue);
					}
				}
				span[a] = document.createElement("span");
				span[a].className = "select";
				span[a].id = "select" + inputs[a].name;
				span[a].appendChild(textnode);
				inputs[a].parentNode.insertBefore(span[a], inputs[a]);
				inputs[a].onchange = Custom.choose;
			}
		}
	},
	pushed: function() {
		element = this.nextSibling;
		if(element.checked == true && element.type == "checkbox") {
			this.style.backgroundPosition = "0 -" + checkboxHeight*3 + "px";
		} else if(element.checked == true && element.type == "radio") {
			this.style.backgroundPosition = "0 -" + radioHeight*3 + "px";
		} else if(element.checked != true && element.type == "checkbox") {
			this.style.backgroundPosition = "0 -" + checkboxHeight + "px";
		} else {
			this.style.backgroundPosition = "0 -" + radioHeight + "px";
		}
	},
	check: function() {
		element = this.nextSibling;
		if(element.checked == true && element.type == "checkbox") {
			this.style.backgroundPosition = "0 0";
			element.checked = false;
		} else {
			if(element.type == "checkbox") {
				this.style.backgroundPosition = "0 -" + checkboxHeight*2 + "px";
			} else {
				this.style.backgroundPosition = "0 -" + radioHeight*2 + "px";
				group = this.nextSibling.name;
				inputs = document.getElementsByTagName("input");
				for(a = 0; a < inputs.length; a++) {
					if(inputs[a].name == group && inputs[a] != this.nextSibling) {
						inputs[a].previousSibling.style.backgroundPosition = "0 0";
					}
				}
			}
			element.checked = true;
		}
	},
	clear: function() {
		inputs = document.getElementsByTagName("input");
		for(var b = 0; b < inputs.length; b++) {
			if(inputs[b].type == "checkbox" && inputs[b].checked == true && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 -" + checkboxHeight*2 + "px";
			} else if(inputs[b].type == "checkbox" && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 0";
			} else if(inputs[b].type == "radio" && inputs[b].checked == true && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 -" + radioHeight*2 + "px";
			} else if(inputs[b].type == "radio" && inputs[b].className == "styled") {
				inputs[b].previousSibling.style.backgroundPosition = "0 0";
			}
		}
	},
	choose: function() {
		option = this.getElementsByTagName("option");
		for(d = 0; d < option.length; d++) {
			if(option[d].selected == true) {
				document.getElementById("select" + this.name).childNodes[0].nodeValue = option[d].childNodes[0].nodeValue;
			}
		}
	}
}


//here you place the ids of every element you want.
var ids=new Array('skillsSoftwarePane','skillsClericalPane','skillsCustomerSvcPane','skillsConstructionPane','skillsGeneralLaborPane','skillsIndustrialPane','skillsSkilledLaborPane','skillsBookkeepingPane','skillsSalesPane','skillsManagementPane','skillsFoodServicePane');
var tabids=new Array('skillsSoftwareTab','skillsClericalTab','skillsCustomerSvcTab','skillsConstructionTab','skillsGeneralLaborTab','skillsIndustrialTab','skillsSkilledLaborTab','skillsBookkeepingTab','skillsSalesTab','skillsManagementTab','skillsFoodServiceTab');

function switchid(id, tabid){	
	hideallids();
	clearalltabs();
	showdiv(id);
	showtab(tabid);
}

function hideallids(){
	//loop through the array and hide each element by id
	for (var i=0;i<ids.length;i++){
		hidediv(ids[i]);
	}		  
}

function notselected(id) {
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).className='notselected';
	}
}
function clearalltabs(){
	//loop through the array and hide each element by id
	for (var i=0;i<tabids.length;i++){
		notselected(tabids[i]);
	}		  
}

function hidediv(id) {
	//safe function to hide an element with a specified id
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'none';
	}
}

function showtab(id) {
	//safe function to show an element with a specified id
		  
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).className='selected';
	}
}

function showdiv(id) {
	//safe function to show an element with a specified id
		  
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'block';
	}
}



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
	// if character is not in bag, append to returnString.
	for (i = 0; i < s.length; i++)
	{   
		// Check that current character isn't whitespace.
		var c = s.charAt(i);
		if (bag.indexOf(c) == -1) returnString += c;
	}
	return returnString;
}

function formatphone(id) {
//	phone_number = document.getElementById(id).value.replace(;

//	matcher    = new RegExp(phone_number, /\(?([0-9]{3})\)?-?([0-9]{3})-?([0-9]{4})/);
//	matched    = matcher.exec();
//	new_number = matched[0] + "-" + matched[1] + "-" + matched[2];

//	document.getElementById(id).value = new_number;
}

function formatsocial(id) {
//	phone_number = document.getElementById(id).value.replace(;

//	matcher    = new RegExp(phone_number, /\(?([0-9]{3})\)?-?([0-9]{3})-?([0-9]{4})/);
//	matched    = matcher.exec();
//	new_number = matched[0] + "-" + matched[1] + "-" + matched[2];

//	document.getElementById(id).value = new_number;
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

function goodfield(id) {
	document.getElementById(id).className='fieldIsGood';
}

function badfield(id) {
	document.getElementById(id).className = 'fieldIsBad';
}

function checkApplication() {
  var okSoFar=true 

  if (document.application.email.value == "")	{
		okSoFar=false;
		badfield('emailLabel');}
	else {
		goodfield('emailLabel');
  }
	
  if (document.application.firstName.value == "")	{
		okSoFar=false;
		badfield('firstNameLabel');}
	else {
		goodfield('firstNameLabel');
	}
		
	if (document.application.lastName.value == "")	{
		okSoFar=false;
		badfield('lastNameLabel');}
	else {
		goodfield('lastNameLabel');
  }

  if (document.application.mainPhone.value == "")	{
		okSoFar=false;
		badfield('mainPhoneLabel');}
	else {
		goodfield('mainPhoneLabel');
  }	
  if (document.application.addressOne.value == "")	{
		okSoFar=false;
		badfield('addressOneLabel');}
	else {
		goodfield('addressOneLabel');
  }	
	if (document.application.city.value == "")	{
		okSoFar=false;
		badfield('cityLabel');}
	else {
		goodfield('cityLabel');
  }	
  if (document.application.zipcode.value == "")	{
		okSoFar=false;
		badfield('zipcodeLabel');}
	else {
		goodfield('zipcodeLabel');
  }	
  if (document.application.ssn.value == "")	{
		okSoFar=false;
		badfield('ssnLabel');}
	else {
		goodfield('ssnLabel');
  }	
  if (document.application.dob.value == "")	{
		okSoFar=false;
		badfield('dobLabel');}
	else {
		goodfield('dobLabel');
  }	
  if (document.application.desiredWageAmount.value == "")	{
		okSoFar=false;
		badfield('desiredWageAmountLabel');}
	else {
		goodfield('desiredWageAmountLabel');
  }	
  if (document.application.minWageAmount.value == "")	{
		okSoFar=false;
		badfield('minWageAmountLabel');}
	else {
		goodfield('minWageAmountLabel');
  }
  if (document.application.workTypeDesired.value == "")	{
		okSoFar=false;
		badfield('workTypeDesiredLabel');}
	else {
		goodfield('workTypeDesiredLabel');	
	
  }	
  if (document.application.citizen.value == "")	{
		okSoFar=false;
		badfield('citizenLabel');}
	else {
		goodfield('citizenLabel');
  }	
  if (document.application.workAuthProof.value == "")	{
		okSoFar=false;
		badfield('workAuthProofLabel');}
	else {
		goodfield('workAuthProofLabel');
  }	

  if (document.application.workRelocate.value == "")	{
		okSoFar=false;
		badfield('workRelocateLabel');}
	else {
		goodfield('workRelocateLabel');
	}
  
	if (document.application.referenceNameOne.value == "")	{
		okSoFar=false;
		badfield('referenceNameOneLabel');}
	else {
		goodfield('referenceNameOneLabel');
  }	
	if (document.application.referencePhoneOne.value == "")	{
		okSoFar=false;
		badfield('referencePhoneOneLabel');}
	else {
		goodfield('referencePhoneOneLabel');
  }	
	if (document.application.referenceNameTwo.value == "")	{
		okSoFar=false;
		badfield('referenceNameTwoLabel');}
	else {
		goodfield('referenceNameTwoLabel');
  }	
	if (document.application.referencePhoneTwo.value == "")	{
		okSoFar=false;
		badfield('referencePhoneTwoLabel');}
	else {
		goodfield('referencePhoneTwoLabel');
  }	
	if (document.application.referenceNameThree.value == "")	{
		okSoFar=false;
		badfield('referenceNameThreeLabel');}
	else {
		goodfield('referenceNameThreeLabel');
  }	
	if (document.application.referencePhoneThree.value == "")	{
		okSoFar=false;
		badfield('referencePhoneThreeLabel');}
	else {
		goodfield('referencePhoneThreeLabel');
  }	

  if (document.application.employerNameHistOne.value == "")	{
		okSoFar=false;
		badfield('employerNameHistOneLabel');}
	else {
		goodfield('employerNameHistOneLabel');
  }	

  if (document.application.jobHistAddOne.value == "")	{
		okSoFar=false;
		badfield('jobHistAddOneLabel');}
	else {
		goodfield('jobHistAddOneLabel');
  }	

  if (document.application.jobHistCityOne.value == "")	{
		okSoFar=false;
		badfield('jobHistCityOneLabel');}
	else {
		goodfield('jobHistCityOneLabel');
  }	

  if (document.application.jobHistStateOne.value == "")	{
		okSoFar=false;
		badfield('jobHistStateOneLabel');}
	else {
		goodfield('jobHistStateOneLabel');
  }	

  if (document.application.jobHistZipOne.value == "")	{
		okSoFar=false;
		badfield('jobHistZipOneLabel');}
	else {
		goodfield('jobHistZipOneLabel');
  }	

  if (document.application.jobHistSupervisorOne.value == "")	{
		okSoFar=false;
		badfield('jobHistSupervisorOneLabel');}
	else {
		goodfield('jobHistSupervisorOneLabel');
  }	

  if (document.application.jobHistPhoneOne.value == "")	{
		okSoFar=false;
		badfield('jobHistPhoneOneLabel');}
	else {
		goodfield('jobHistPhoneOneLabel');
  }	

  if (document.application.jobHistFromDateOne.value == "")	{
		okSoFar=false;
		badfield('jobHistFromDateOneLabel');}
	else {
		goodfield('jobHistFromDateOneLabel');
  }	

  if (document.application.JobHistToDateOne.value == "")	{
		okSoFar=false;
		badfield('JobHistToDateOneLabel');}
	else {
		goodfield('JobHistToDateOneLabel');
  }	

  if (document.application.employerNameHistTwo.value == "")	{
		okSoFar=false;
		badfield('employerNameHistTwoLabel');}
	else {
		goodfield('employerNameHistTwoLabel');
  }	

  if (document.application.jobHistAddTwo.value == "")	{
		okSoFar=false;
		badfield('jobHistAddTwoLabel');}
	else {
		goodfield('jobHistAddTwoLabel');
  }	

  if (document.application.jobHistCityTwo.value == "")	{
		okSoFar=false;
		badfield('jobHistCityTwoLabel');}
	else {
		goodfield('jobHistCityTwoLabel');
  }	

  if (document.application.jobHistStateTwo.value == "")	{
		okSoFar=false;
		badfield('jobHistStateTwoLabel');}
	else {
		goodfield('jobHistStateTwoLabel');
  }	

  if (document.application.jobHistZipTwo.value == "")	{
		okSoFar=false;
		badfield('jobHistZipTwoLabel');}
	else {
		goodfield('jobHistZipTwoLabel');
  }	

  if (document.application.jobHistSupervisorTwo.value == "")	{
		okSoFar=false;
		badfield('jobHistSupervisorTwoLabel');}
	else {
		goodfield('jobHistSupervisorTwoLabel');
  }	

  if (document.application.jobHistPhoneTwo.value == "")	{
		okSoFar=false;
		badfield('jobHistPhoneTwoLabel');}
	else {
		goodfield('jobHistPhoneTwoLabel');
  }	

  if (document.application.jobHistFromDateTwo.value == "")	{
		okSoFar=false;
		badfield('jobHistFromDateTwoLabel');}
	else {
		goodfield('jobHistFromDateTwoLabel');
  }	

  if (document.application.JobHistToDateTwo.value == "")	{
		okSoFar=false;
		badfield('JobHistToDateTwoLabel');}
	else {
		goodfield('JobHistToDateTwoLabel');
  }	

  if (document.application.employerNameHistThree.value == "")	{
		okSoFar=false;
		badfield('employerNameHistThreeLabel');}
	else {
		goodfield('employerNameHistThreeLabel');
  }	

  if (document.application.jobHistAddThree.value == "")	{
		okSoFar=false;
		badfield('jobHistAddThreeLabel');}
	else {
		goodfield('jobHistAddThreeLabel');
  }	

  if (document.application.jobHistCityThree.value == "")	{
		okSoFar=false;
		badfield('jobHistCityThreeLabel');}
	else {
		goodfield('jobHistCityThreeLabel');
  }	

  if (document.application.jobHistStateThree.value == "")	{
		okSoFar=false;
		badfield('jobHistStateThreeLabel');}
	else {
		goodfield('jobHistStateThreeLabel');
  }	

  if (document.application.jobHistZipThree.value == "")	{
		okSoFar=false;
		badfield('jobHistZipThreeLabel');}
	else {
		goodfield('jobHistZipThreeLabel');
  }	

  if (document.application.jobHistSupervisorThree.value == "")	{
		okSoFar=false;
		badfield('jobHistSupervisorThreeLabel');}
	else {
		goodfield('jobHistSupervisorThreeLabel');
  }	

  if (document.application.jobHistPhoneThree.value == "")	{
		okSoFar=false;
		badfield('jobHistPhoneThreeLabel');}
	else {
		goodfield('jobHistPhoneThreeLabel');
  }	

  if (document.application.jobHistFromDateThree.value == "")	{
		okSoFar=false;
		badfield('jobHistFromDateThreeLabel');}
	else {
		goodfield('jobHistFromDateThreeLabel');
  }	

  if (document.application.JobHistToDateThree.value == "")	{
		okSoFar=false;
		badfield('JobHistToDateThreeLabel');}
	else {
		goodfield('JobHistToDateThreeLabel');
  }	
	
	if (okSoFar != false){ 
	 var agree=confirm("Ready to send your application?");
			if (agree)
				{
				document.application.formAction.value='submit';
				document.application.submit();
				}
		}
	else {
		document.getElementById('problemsInApp').className = 'show';
		return false;
	} 
}

function saveapplication(){	
	document.application.formAction.value='save';
	document.application.submit();
}

function viewPrintApplication(){	
	document.application.formAction.value='viewprint';
	document.application.submit();
}

window.onload = Custom.init;
