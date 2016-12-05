var PosInfinity = Number.POSITIVE_INFINITY;
var NegInfinity = Number.NEGATIVE_INFINITY;
var str_error = "";		//	stores error messages for use accross functions.
var int_errorcount = 0;
var obj_element_cache = null;
var tmr_menu_cache = null;
var msg_error_repeat = "\n\nYou seem to be having trouble with this field.\nDelete the content of the field and try your entry again.",
	msg_error_cancel = "There were problems verifying your entry.  Your entry has been deleted.\n\nPlease try again.",
	msg_text = "This field only accepts text entry.  Please do not use numbers, or special characters.",
	msg_number = "This field requires a number. Please enter a number.",
	msg_integer = "This field requires an integer (no decimals).  Please enter digits only.",
	msg_phone = "This field requires a 10-digit phone number with area code.",
	msg_phone_areacode = "\n\nThe first digit of the area code cannot be a 1 or 0.",
	msg_phone_firstdigit = "\n\nThe first digit of the phone number cannot be a 1 or 0.",
	msg_phone_11 = "\n\n(###) #11-#### is an illegal phone format.  The second and third digits of phone number can not be '11'.",
	msg_phone_555 = "\n\nThis is an illegal phone format.  The first three digits of phone number cannot be 555.",
	msg_zip = "Invalid Zip Code.\nFormat must be:\n\n#####  or  #####-####.",
	msg_zip_foreign = "\n\nif you want to enter a foreign postal code, delete \nthis entry and check the foreign postal code box.",
	msg_date = "This field requires a valid date entry.",
	msg_date_fullyear = "Please specify a 4 digit year for clarification.",
	msg_date_past = "This field requires that the date is from the past.  Please re-enter a valid date.",
	msg_email = "This field requires a valid email address (yourname@yourwork.com).  Please try again.",
	msg_url = "This field requires a valid web site url (like http://www.yoursite.com). Please correct your entry",
	msg_SSN = "This field requires a valid social security number.",
	msg_creditcard = "This field requires a valid credit card number.\nFormat must be:\n\n####-####-####-####\n\nPlease try again.",
	msg_confirmpassword = "The password and confirm password fields must contain the same values.\n\nPlease try again.";
var msg_numeric = "\n\n@@field_name@@ contain only numerical digits.",
	msg_req_text = "@@field_name@@ is a required field.  Please make an entry.",
	msg_req_list = "Selecting a @@field_name@@ is required.  Please make a selection.";
var ary_StateCodes = [ "AK","AL","AS","AZ","AR","CA","CO","CT","DE","DC","FM","FL","GA","GU","HI","ID","IL","IN","IA","KS","KY","LA","ME","MH","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","MP","OH","OK","OR","PW","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY" ];
function Debug_ArrayItems(array) { 
	var str_items = "";
	if (array) { 
		for (i=0; i < array.length; i++) { 
			str_items += array[i] + "\n";
		}
		alert (str_items);
	}
	else { alert ("Array does not exist.");	}
}
/*	========================	GENERAL FUNCTIONS	  ========================= */
function func_StateOptions() {
	str_output = "";
	for ( cnt_s = 0; cnt_s < ary_StateCodes.length; cnt_s++ ) {
		str_output += "<OPTION VALUE=\"" + ary_StateCodes[cnt_s] + "\">" + ary_StateCodes[cnt_s] + "</OPTION>";
	}
	document.write(str_output);
}

function func_KillWhitey(element) {
	element.value = element.value.replace(/^\s+/, "");
	element.value = element.value.replace(/\s+$/, "");
}
function Uppercase(element) { element.value = element.value.toUpperCase(); }
function Lowercase(element) { element.value = element.value.toLowerCase(); }
function ResetList(element) {
	clearTimeout(tmr_menu_cache);
	obj_element_cache = element;
	if (element.options[element.selectedIndex].value == "resetme" ) { 
		tmr_menu_cache = setTimeout("MoveToDefault()", 400);
		return false;
	}
	else return true;
}

function MoveToDefault() {
}

function ValueIsBetween(value,minval,maxval) {
	value = Number(value); minval = Number(minval); maxval = Number(maxval); 
	alert(typeof(value) + "\n" + typeof(minval) + "\n" + typeof(maxval)); 
	alert(value + "\n" + minval + "\n" + maxval); 
	if ( !minval && minval!=0 ) xmin = false;	else xmin = true;
	if ( !maxval && maxval!=0 ) xmax = false;	else xmax = true;
	if ( ( xmin && xmax ) && ( value < minval || value > maxval ) ) return 1;
	else if ( xmin && !xmax && ( value < minval ) ) return 2;
	else if ( !xmin && xmax && ( value > maxval ) ) return 3;
	else return true;
}

function TextOnly(str) { 
	if ( str.search(/[^A-Za-z\s\-]/) != -1 ) { return false; }
	return true;
}

function DigitsOnly(str) { 
	if ( str.search(/[^\d]/) != -1 ) { return false; }
	return true;
}
function Error(element) { 
	if ( obj_element_cache == element ) int_errorcount++;
	else {
		int_errorcount = 0;
		obj_element_cache = element;
	}
	if ( int_errorcount >= 3 ) { 
		str_error += msg_error_repeat;
	}
	if ( int_errorcount > 5 ) { 
		element.value = "";
		int_errorcount = 0;
		str_error = msg_error_cancel;
	}
	alert(str_error);
	element.focus();
	element.select();
	return false;
}
function RequirementRule( element, caption, type, rules ) {
	this.element = element;
	this.caption = caption;
	this.type = ( type ) ? type : "t" ;
	this.rules = ( rules ) ? rules : false ;
}

var obj_form = null;
function checkRequiredFields( form, ary_rules ) {
	obj_form = form
	error_message = false;
	ary_rules = ( ary_rules ) ? ary_rules : ary_req_fields ;
	if ( !checkALL(ary_rules, true) ) return false
	function checkALL ( ary_rules, message ) {
		for ( cnt_a=0; cnt_a < ary_rules.length; cnt_a++ ) {
			var rule = ary_rules[cnt_a];
			if ( ( rule.type == "t" || rule.type == "l" ) && notEntered(rule, message) ) return false;
			else if ( rule.type == "ANY" ) {
				if ( checkANY( rule.element ) ) { 
					if (!error_message) { 
						alert(rule.caption); 
						error_message=true;
						formElement(rule.element[0].element).focus();
					}
					return false;
				}
			}
			else if ( rule.type == "ALL" ) {
				if ( !checkALL2( rule.element, true ) ) return false;
			}
		}
		return true;
	}

	function checkANY (ary_rules_b) {	
		for ( cnt_b=0; cnt_b < ary_rules_b.length; cnt_b++ ) {
			var rule_b = ary_rules_b[cnt_b];
			if ( ( rule_b.type == "t" || rule_b.type == "l" ) && !notEntered(rule_b, false) ) return false;
			else if ( rule_b.type == "ANY" ) {
				if ( checkANY( rule_b.element ) ) return false;
			}
			else if ( rule_b.type == "ALL" ) {
				all_attempt = false;
				first_miss = false;
				if ( checkALL2( rule_b.element, false ) ) return false;
				else if (all_attempt && !error_message) { 
					alert(rule_b.caption);
					error_message=true;
					if (first_miss) formElement(first_miss).focus();
					else formElement(rule_b.element[0].element).focus();
				}
			}
		}
		return true;
	}
	function checkALL2 ( ary_rules_c, message ) { 
		out = true;
		for ( cnt_c=0; cnt_c < ary_rules_c.length; cnt_c++ ) { 
			rule_c = ary_rules_c[cnt_c];
			if ( notEntered(rule_c, message) ) {
				out = false; 
				if (!first_miss) first_miss = rule_c.element;
			}
			else { all_attempt = true; }
		} 
		return out;
	}
	function notEntered( field_rule, message ) {
		obj_element = formElement(field_rule.element);
		var str_field_value = ( field_rule.type == "l" ) ? obj_element.options[obj_element.selectedIndex].value : obj_element.value ;
		if ( str_field_value == "" ) {
			if ( message ) {
				if (field_rule.type == "t") alert ( msg_req_text.replace( /@@field_name@@/, field_rule.caption ) );
				else if (field_rule.type == "l") alert ( msg_req_list.replace( /@@field_name@@/, field_rule.caption ) );
				obj_element.focus(); 
			}
			return true;
		}
		else if ( field_rule.rules ) {
			ary_req_rules = field_rule.rules.split("|");
			for ( cnt_r=0; cnt_r<ary_req_rules.length; cnt_r++ ) {
				rule_name = ary_req_rules[cnt_r].split("=")[0];
				rule_value = ary_req_rules[cnt_r].split("=")[1];
				if (rule_name == "maxchrs" && str_field_value.length > parseInt(rule_value) ) {
					alert ( field_rule.caption + " can not have more than " + rule_value + " characters.\nYou have entered " + str_field_value.length + ".  Please reduce your entry." );
					obj_element.focus(); return true;
				}
				if (rule_name == "minchrs" && str_field_value.length < parseInt(rule_value) ) {
					alert ( field_rule.caption + " can not have less than " + rule_value + " characters.\nYou have entered " + str_field_value.length + ".  Please supply a more substantial entry." );
					obj_element.focus(); return true;
				}
				if ( rule_name == "confirmpass" && str_field_value != formElement(rule_value).value ) {
					alert ( str_field_value + "\n" + formElement(rule_value).value )
					obj_element.value = ""; formElement(rule_value).value = "";
					alert ( msg_confirmpassword );
					formElement(rule_value).focus(); return true;
				}
			}
		}
		else return false;
	}
	function formElement(element) { 
		if ( !ns4 ) return obj_form[element];
		else return eval( "document." + obj_form.name + "['" + element + "']" );
	}
}

function IsBlank(tVal){
 for (var i = 0; i < tVal.length; i++){
  var c = tVal.charAt(i);
  if((c != ' ') && (c != '\n') && (c != '\t'))
   return false;
 } return true;
}

function noReturn() {
   if (document.forms) {
      // Do Nothing...
   }
}

function IsText(element) { 
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( !TextOnly(orig_str) && orig_str != "") { 
		str_error = msg_text;
		return Error(element);
	}
	return;
}

function IsNumber(element,minval,maxval) { 
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( orig_str != "" ) { 
		str_error = msg_number;
		if ( orig_str != parseFloat(orig_str) ) { Error(element); }
		else if ( minval || maxval ) {
			alert(ValueIsBetween(orig_str,minval,maxval));
			switch (ValueIsBetween(orig_str,minval,maxval)) {
				case 1:
					str_error += "This number must be between " + minval + " & " + maxval + ".";
					return Error(element); break;
				case 2:
					str_error += "This number must be greater than " + minval + ".";
					return Error(element); break;
				case 3:
					str_error += "This number must be less than " + maxval + ".";
					return Error(element); break;
			}
		}
	}
	return;
}

function IsInteger(element,minval,maxval) { 
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( orig_str != "" ) { 
		str_error = msg_integer;
		if ( orig_str != parseInt(orig_str) ) { 
			return Error(element);
		}
	}
	return;
}

function IsPhone(element) { 
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( orig_str != "" ) { 
		var regexp_USPhone = /^1?\s?\(?([\d]{3})\)?[\s-\/\.]?([\d]{3})[\s-\/\.]?([\d]{4})$/;
		var ary_element_seg = regexp_USPhone.exec(orig_str);
		str_error = msg_phone;
		if ( !ary_element_seg ) { 
			if ( orig_str.search(/[a-zA-Z]/) != -1) str_error += msg_numeric.replace( /@@field_name@@/, "Phone numbers" );
			return Error(element);
		}
		//	reformat string to standardized format for easy acceptance into database.
		else { 
			element.value = "(" + ary_element_seg[1] + ") " + ary_element_seg[2] + "-" + ary_element_seg[3];
		}
		//	begin checking for more specific rules for different segments of phone number.
		if ( /^[01]/.test( ary_element_seg[1] ) ) { 
			str_error += msg_phone_areacode;
			return Error(element);
		}
		else if ( /^[01]/.test( ary_element_seg[2] ) ) { 
			str_error += msg_phone_firstdigit;
			return Error(element);
		}
		else if ( /11$/.test( ary_element_seg[2] ) ) { 
			str_error += msg_phone_11;
			return Error(element);
		}
		else if ( /^555$/.test( ary_element_seg[2] ) ) { 
			str_error += msg_phone_555;
			return Error(element);
		}
	}
	return;
}

function IsZip( element, international_field ) { 
	func_KillWhitey(element);
	if (international_field) {
		inter_field = element.form[international_field];
		if ( inter_field.type == "checkbox" && inter_field.checked ) return;
		else if ( inter_field[0].type == "checkbox" && inter_field[0].checked ) return;
		else if ( inter_field[1].type == "checkbox" && inter_field[1].checked ) return;
	}
	var orig_str = element.value;
	if ( orig_str != "" ) { 
		var regexp_USZip = /^(\d{5})[-\s\/]?([\d]{4})?$/;
		var ary_element_segments = regexp_USZip.exec(orig_str);
		if ( !ary_element_segments ) { 
			if ( orig_str.search(/[a-zA-Z]/) != -1) var flag_text = true;
			str_error = msg_zip;
			if (flag_text) str_error += msg_numeric.replace( /@@field_name@@/, "Zip codes" );
			if (international_field) str_error += msg_zip_foreign;
			return Error(element);
		}
		else { 
			str_newstring = ary_element_segments[1];
			if ( orig_str.length > 6 ) str_newstring += "-" + ary_element_segments[2];
			element.value = str_newstring;
		}
	}
	return;
}
function isDate(element,past) { 
	func_KillWhitey(element);
	if (!past) past = false;
	if (element.value != "") { 
		obj_date = new Date(element.value);
		if (isNaN(obj_date)) { 
			str_error = msg_date;
			return Error(element);
		}
		else if (obj_date.getYear() < 20) { 
			str_error = msg_date_fullyear;
			return Error(element);
		}
		else if (past && obj_date > new Date()) { 
			str_error = msg_date_past;
			return Error(element);
		}
		else { 
			element.value = (obj_date.getMonth()+1) + "/" + obj_date.getDate() + "/" + obj_date.getFullYear();
		}
	}
	return;
}

function IsEmail(element) { 
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( orig_str != "" ) { 
		var regexp_Email = /^\w([\w\._\-\&']*)?@\w([\w\._\-]*)?\.\w{2}([\w\.]*)?$/
		if ( !regexp_Email.test( orig_str ) ) {
			str_error = msg_email;
			return Error(element);
		}
	}
	return true;
}

function IsURL(element) { 
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( ( orig_str != "" ) && ( orig_str != "http://" ) ) { 
		var regexp_URL = /^(https?:\/\/)*\w([\w\.-]*\w)?\.\w{2}/
		var ary_element_segments = regexp_URL.exec(orig_str);
		str_error = msg_url;
		if ( !ary_element_segments ) { 
			return Error(element);
		}
		element.value = orig_str.replace(/^(http(s)?:\/\/)*/, "http$2://");
	}
	return true;
}

function IsSSN(element) { 
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( orig_str != "" ) { 
		var regexp_SSN = /^(\d{3})[\s-\/\.]?(\d{2})[\s-\/\.]?(\d{4})$/;
		var ary_element_seg = regexp_SSN.exec(orig_str);
		if ( !ary_element_seg ) { 
			if ( orig_str.search(/[a-zA-Z]/) != -1 ) var flag_text = true;
			str_error = msg_SSN;
			if (flag_text) str_error += msg_numeric.replace( /@@field_name@@/, "Social security numbers" );
			return Error(element);
		}
		else { 
			element.value = ary_element_seg[1] + "-" + ary_element_seg[2] + "-" + ary_element_seg[3];
		}
	}
	return;
}

function IsCreditCard(element) {
	func_KillWhitey(element);
	var orig_str = element.value;
	if ( orig_str != "" ) {
		var regexp_CreditCard = /^(\d{4})[\s-\/\.]?(\d{4})[\s-\/\.]?(\d{4})[\s-\/\.]?(\d{4})$/;
		var ary_element_seg = regexp_CreditCard.exec(orig_str);
		if ( !ary_element_seg ) {
			if ( orig_str.search(/[a-zA-Z]/) != -1 ) var flag_text = true;
			str_error = msg_creditcard;
			if (flag_text) str_error += msg_numeric.replace( /@@field_name@@/, "Credit Card numbers" );
			return Error(element);
		}
		else {
			element.value = ary_element_seg[1] + " " + ary_element_seg[2] + " " + ary_element_seg[3] + " " + ary_element_seg[4];
		}
	}
	return;
}

function MakeParagraphs(element) {
	func_KillWhitey(element);
	var orig_str = element.value;
	var str_new = orig_str;
	if ( orig_str != "" ) { 
		for ( i=0; i<2; i++ ) { 
			str_new = str_new.replace(/(<\/DIV><\/DIV>)/gi,"</DIV>");
			str_new = str_new.replace(/(<DIV CLASS="p"><\/DIV>)/gi,"");
			str_new = str_new.replace(/<\/DIV>(\n\r|\r\n|\n|\r)<UL>/gi,"$1<UL>");
			str_new = str_new.replace(/(<BR>|<br>)?(\n\r|\r\n|\n|\r)/gi,"<BR>$2");
			str_new = str_new.replace(/(<BR>)(\n\r|\r\n|\n|\r)(<BR>)(\n\r|\r\n|\n|\r)/gi,"</DIV>$2<DIV CLASS=\"p\">");
			str_new = str_new.replace(/(<\/DIV><BR>)(\n\r|\r\n|\n|\r)(<DIV CLASS)/gi,"</DIV>$2<DIV CLASS");
			str_new = str_new.replace(/^(<IMG[^>]*>)?<DIV CLASS="p">/i,"$1");
			str_new = str_new.replace(/^(<IMG[^>]*>)?/i,"$1<DIV CLASS=\"p\">");
			str_new = str_new.replace(/<\/DIV>$/i,"");
			str_new = str_new.replace(/$/i,"</DIV>");
			str_new = str_new.replace(/<([^>]*)><BR>/i,"<$1>");
			str_new = str_new.replace(/<\/([^>]*)><BR>/i,"</$1>");
			str_new = str_new.replace(/<UL><BR>/,"<UL>");
		}
		if ( str_new.split("<DIV").length != str_new.split("</DIV>").length ) { 
			alert ( "I seem to be having trouble balancing the DIV tags in this field.\n\nPlease help by manually deleting the DIV tags and cleaning up the line breaks.\n\nThanks\n\nSee the Web Master if this problem continues." );
		}
		element.value = str_new;
	}
}

//	this function is in development.
function linkURLs(element) {
	var orig_str = element.value;
	if ( orig_str != "" ) { 
		var regexp_urlloc = /([^\s]+\.(com|org|net))/;
		var ary_element_seg = regexp_urlloc.exec(orig_str);
		if ( ary_element_seg ) {
			alert (ary_element_seg[1]);
			var str_new = orig_str.replace(/\s([^\s]+\.(com|org|net))/g," <A href=\"http://$1\">$1</A>");
			element.value = str_new;
		}
		else alert ("no match");
	}
}

function formatPhoneNumber(phoneField) {
  var phoneData=phoneField.value;
  if (! phoneData ) {
    return false;
  }
  if (phoneData.indexOf("+") != -1 ) {
    return false;
  }
  var phoneDataNumbers=phoneData.replace(/[^0-9]/g, "");
  if (phoneDataNumbers.length == 7 ) {
    var phoneDatafirst3=phoneDataNumbers.substr(0, 3);
    var phoneDatalast4=phoneDataNumbers.substr(3, 4);
    phoneField.value=phoneDatafirst3 + "-" + phoneDatalast4;
    return true;
  } else if (phoneDataNumbers.length == 10 ) {
    var phoneDataarea=phoneDataNumbers.substr(0, 3);
    var phoneDatafirst3=phoneDataNumbers.substr(3, 3);
    var phoneDatalast4=phoneDataNumbers.substr(6, 4);
    phoneField.value="(" + phoneDataarea + ")" + phoneDatafirst3 + "-" + phoneDatalast4;
    return true;
  } else {
    return false;
  }
}

function ValidatePayInfo(){
   f=document.siteCheckBoxForm;
   if((typeof f !='undefined') && (typeof f.UserFirstName !='undefined')){
       if(f.UserFirstName.value=='' || f.UserLastName.value=='' || f.UserAddress1.value=='' || f.UserEmail.value=='' || f.UserPhone.value=='' || f.UserCity.value=='' || f.UserZip.value==''){
           alert("please provide all required fields marked with an asterisk *");
           return false;
       }else{
           return true;
       }
   }
}
