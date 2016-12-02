document.write('<script type="text/javascript" src="/include/js/global.js"></scr' + 'ipt>');

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "190";

document.write('<style type="text/css">input.styled { display: none; } select.styled { position: relative; width: ' + selectWidth + 'px; opacity: 0; filter: alpha(opacity=0); z-index: 5}</style>');

var Custom = {
    init: function () {
        title_this(document.getElementById('page_title').value);
        var inputs = document.getElementsByTagName("input"), span = Array(), textnode, option, active;
        for (a = 0; a < inputs.length; a++) {
            if ((inputs[a].type === "checkbox" || inputs[a].type === "radio") && inputs[a].className === "styled") {
                span[a] = document.createElement("span");
                span[a].className = inputs[a].type;

                if (inputs[a].checked === true) {
                    if (inputs[a].type === "checkbox") {
                        position = "0 -" + (checkboxHeight * 2) + "px";
                        span[a].style.backgroundPosition = position;
                    } else {
                        position = "0 -" + (radioHeight * 2) + "px";
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
        for (a = 0; a < inputs.length; a++) {
            if (inputs[a].className === "styled") {
                option = inputs[a].getElementsByTagName("option");
                active = option[0].childNodes[0].nodeValue;
                textnode = document.createTextNode(active);
                for (b = 0; b < option.length; b++) {
                    if (option[b].selected === true) {
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
    pushed: function () {
        element = this.nextSibling;
        if (element.checked === true && element.type === "checkbox") {
            this.style.backgroundPosition = "0 -" + checkboxHeight * 3 + "px";
        } else if (element.checked === true && element.type === "radio") {
            this.style.backgroundPosition = "0 -" + radioHeight * 3 + "px";
        } else if (element.checked !== true && element.type === "checkbox") {
            this.style.backgroundPosition = "0 -" + checkboxHeight + "px";
        } else {
            this.style.backgroundPosition = "0 -" + radioHeight + "px";
        }
    },
    check: function () {
        element = this.nextSibling;
        if (element.checked === true && element.type === "checkbox") {
            this.style.backgroundPosition = "0 0";
            element.checked = false;
        } else {
            if (element.type === "checkbox") {
                this.style.backgroundPosition = "0 -" + checkboxHeight * 2 + "px";
            } else {
                this.style.backgroundPosition = "0 -" + radioHeight * 2 + "px";
                group = this.nextSibling.name;
                inputs = document.getElementsByTagName("input");
                for (a = 0; a < inputs.length; a++) {
                    if (inputs[a].name === group && inputs[a] !== this.nextSibling) {
                        inputs[a].previousSibling.style.backgroundPosition = "0 0";
                    }
                }
            }
            element.checked = true;
        }
    },
    clear: function () {
        inputs = document.getElementsByTagName("input");
        for (var b = 0; b < inputs.length; b++) {
            if (inputs[b].type === "checkbox" && inputs[b].checked === true && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 -" + checkboxHeight * 2 + "px";
            } else if (inputs[b].type === "checkbox" && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 0";
            } else if (inputs[b].type === "radio" && inputs[b].checked === true && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 -" + radioHeight * 2 + "px";
            } else if (inputs[b].type === "radio" && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 0";
            }
        }
    },
    choose: function () {
        option = this.getElementsByTagName("option");
        for (d = 0; d < option.length; d++) {
            if (option[d].selected === true) {
                document.getElementById("select" + this.name).childNodes[0].nodeValue = option[d].childNodes[0].nodeValue;
            }
        }
    }
};

//here you place the ids of every element you want.
var ids = new Array('skillsSoftwarePane', 'skillsClericalPane', 'skillsCustomerSvcPane', 'skillsConstructionPane', 'skillsGeneralLaborPane', 'skillsIndustrialPane', 'skillsSkilledLaborPane', 'skillsBookkeepingPane', 'skillsSalesPane', 'skillsManagementPane', 'skillsFoodServicePane');
var tabids = new Array('skillsSoftwareTab', 'skillsClericalTab', 'skillsCustomerSvcTab', 'skillsConstructionTab', 'skillsGeneralLaborTab', 'skillsIndustrialTab', 'skillsSkilledLaborTab', 'skillsBookkeepingTab', 'skillsSalesTab', 'skillsManagementTab', 'skillsFoodServiceTab');

function switchid(id, tabid) {
    hideallids();
    clearalltabs();
    showdiv(id);
    showtab(tabid);
}

function hideallids() {
    //loop through the array and hide each element by id
    for (var i = 0; i < ids.length; i++) {
        hidediv(ids[i]);
    }
}

function notselected(id) {
    if (document.getElementById) { // DOM3 = IE5, NS6
        document.getElementById(id).className = 'notselected';
    }
}

function selected(id) {
    if (document.getElementById) { // DOM3 = IE5, NS6
        document.getElementById(id).className = 'selected';
    }
}
function clearalltabs() {
    //loop through the array and hide each element by id
    for (var i = 0; i < tabids.length; i++) {
        notselected(tabids[i]);
    }
}

function hidediv(id) {
    console.log('hidediv:' + id);
    //safe function to hide an element with a specified id
    if (document.getElementById) { // DOM3 = IE5, NS6
        document.getElementById(id).style.display = 'none';
    }
}

function showtab(id) {
    //safe function to show an element with a specified id

    if (document.getElementById) { // DOM3 = IE5, NS6
        document.getElementById(id).className = 'selected';
    }
}

function showdiv(id) {
    //safe function to show an element with a specified id

    if (document.getElementById) { // DOM3 = IE5, NS6
        document.getElementById(id).style.display = 'block';
    }
}

function showskills(skillgroup) {
    console.log(skillgroup);
    hidediv(skillgroup);
    showdiv(skillgroup + "_list");
}

function hideskills(skillgroup) {
    console.log(skillgroup);
    hidediv(skillgroup + "_list");
    showdiv(skillgroup);
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

function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // if character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) === -1) returnString += c;
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

function isDate(dateStr) {
    var datePat = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
    var matchArray = dateStr.match(datePat); // is the format ok?

    if (matchArray === null) {
        alert("Please enter date as either mm/dd/yyyy or mm-dd-yyyy.");
        return false;
    }

    month = matchArray[1]; // p@rse date into variables
    day = matchArray[3];
    year = matchArray[5];

    if (month < 1 || month > 12) { // check month range
        alert("Month must be between 1 and 12.");
        return false;
    }

    if (day < 1 || day > 31) {
        alert("Day must be between 1 and 31.");
        return false;
    }

    if ((month === 4 || month === 6 || month === 9 || month === 11) && day === 31) {
        alert("Month " + month + " doesn`t have 31 days!");
        return false;
    }

    if (month === 2) { // check for february 29th
        var isleap = (year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0));
        if (day > 29 || (day === 29 && !isleap)) {
            alert("February " + year + " doesn`t have " + day + " days!");
            return false;
        }
    }
    return true; // date is valid
}

function formatSSN() {
    var theCount = 0;
    var theString = document.application.ssn.value;
    var newString = "";
    var myString = theString;
    var theLen = myString.length;
    for (var i = 0 ; i < theLen ; i++) {
        // Character codes for ints 1 - 9 are 48 - 57
        if ((myString.charCodeAt(i) >= 48) && (myString.charCodeAt(i) <= 57))
            newString = newString + myString.charAt(i);
    }
    // Now the validation to determine that the remaining string is 9 characters.
    if (newString.length === 9) {
        // Now the string has been stripped of other chars it can be reformatted to ###-##-####
        var newLen = newString.length;
        var newSSN = "";
        for (i = 0 ; i < newLen ; i++) {
            if ((i === 2) || (i === 4)) {
                newSSN = newSSN + newString.charAt(i) + "-";
            } else {
                newSSN = newSSN + newString.charAt(i);
            }
        }
        document.application.ssn.value = newSSN;
        return true;
    } else {
        return false;
    }
}

function checkInternationalPhone(strPhone) {
    s = stripCharsInBag(strPhone, validWorldPhoneChars);
    return (isInteger(s) && s.length >= minDigitsInIPhoneNumber);
}

function ValidateForm() {
    var Phone = document.applyDirect.contactPhone;

    if ((Phone.value === null) || (Phone.value === "")) {
        alert("Please enter the best phone number to contact you at.");

        return false;
    }
    if (checkInternationalPhone(Phone.value) === false) {
        alert("Please enter a valid 10 digit phone number. Be sure to include your area code.");
        Phone.value = "";

        return false;
    }
    return true;
}

function goodfield(id) {
    document.getElementById(id + "Label").className = 'fieldIsGood';
}

function badfield(id) {
    document.getElementById(id + "Label").className = 'fieldIsBad';
}

function checkApplication() {
    var okSoFar = true;
    var jump_to;
    jump_to = "<a href=\"#\" style=\"margin-left: 6px\" onClick=\"focusthisform(\'\');\">";
    var jump_close;
    jump_close = "</a>";
    var problemWithThis;
    problemWithThis = "Please review the following:<br>";

    var isbad;
    formatSSN(isbad);
    if (formatSSN === false) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "Your social security number." + jump_close + "<br>";
        badfield('ssn');
    }
    else {
        goodfield('ssn');
    }

    if (document.application.desiredWageAmount.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "You need to specify a desired wage amount." + jump_close + "<br>";
        badfield('desiredWageAmount');
    }
    else {
        if (document.application.workTypeDesired.value === "") {
            okSoFar = false;
            problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "Your desired work type." + jump_close + "<br>";
            badfield('workTypeDesired');
        }
        else {
            goodfield('workTypeDesired');
        }

        goodfield('desiredWageAmount');
    }
    if (document.application.minWageAmount.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "You need to specify a minimum acceptable wage." + jump_close + "<br>";
        badfield('minWageAmount');
    }
    else {
        goodfield('minWageAmount');
    }

    if (document.application.workTypeDesired.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "Your desired work type." + jump_close + "<br>";
        badfield('workTypeDesired');
    }
    else {
        goodfield('workTypeDesired');
    }
    if (document.application.aliasNames.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "You need to enter your alias information." + jump_close + "<br>";
        badfield('aliasNames');
    }
    else {
        goodfield('aliasNames');
    }
    if (document.application.dob.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "You need to enter your date of birth." + jump_close + "<br>";
        badfield('dob');
    }
    else {
        if (isDate(document.application.dob.value) === true) {
            goodfield('dob');
        }
        else {
            okSoFar = false;
            problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "I don't recognize your date of birth, enter as mm/dd/yyyy." + jump_close + "<br>";
            badfield('dob');
        }
    }
    if (document.application.citizen.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "Your citizenship status." + jump_close + "<br>";
        badfield('citizen');
    }
    else {
        goodfield('citizen');
    }
    if (document.application.workAuthProof.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "Your proof of work authorization." + jump_close + "<br>";
        badfield('workAuthProof');
    }
    else {
        goodfield('workAuthProof');
    }

    if (document.application.workRelocate.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "Your willingness to relocate or not." + jump_close + "<br>";
        badfield('workRelocate');
    }
    else {
        goodfield('workRelocate');
    }

    if (document.application.eduLevel.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'employmentPreferences\')") + "You need to enter your education level." + jump_close + "<br>";
        badfield('eduLevel');
    }
    else {
        goodfield('eduLevel');
    }

    if (document.application.referenceNameOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'emergencyc\')") + "You didn't specify your first reference." + jump_close + "<br>";
        badfield('referenceNameOne');
    }
    else {
        goodfield('referenceNameOne');
    }
    if (document.application.referencePhoneOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'emergencyc\')") + "You didn't specify your first reference's phone number." + jump_close + "<br>";
        badfield('referencePhoneOne');
    }
    else {
        goodfield('referencePhoneOne');
    }
    if (document.application.referenceNameTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'emergencyc\')") + "You didn't specify your second reference." + jump_close + "<br>";
        badfield('referenceNameTwo');
    }
    else {
        goodfield('referenceNameTwo');
    }
    if (document.application.referencePhoneTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'emergencyc\')") + "You didn't specify your second reference's phone number." + jump_close + "<br>";
        badfield('referencePhoneTwo');
    }
    else {
        goodfield('referencePhoneTwo');
    }
    if (document.application.referenceNameThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'emergencyc\')") + "You didn't specify your third reference." + jump_close + "<br>";
        badfield('referenceNameThree');
    }
    else {
        goodfield('referenceNameThree');
    }
    if (document.application.referencePhoneThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'emergencyc\')") + "You didn't specify your third reference's phone number." + jump_close + "<br>";
        badfield('referencePhoneThree');
    }
    else {
        goodfield('referencePhoneThree');
    }

    if (document.application.employerNameHistOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first employers name." + jump_close + "<br>";
        badfield('employerNameHistOne');
    }
    else {
        goodfield('employerNameHistOne');
    }

    if (document.application.jobHistAddOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first job history address." + jump_close + "<br>";
        badfield('jobHistAddOne');
    }
    else {
        goodfield('jobHistAddOne');
    }

    if (document.application.jobHistCityOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first employer city." + jump_close + "<br>";
        badfield('jobHistCityOne');
    }
    else {
        goodfield('jobHistCityOne');
    }

    if (document.application.jobHistStateOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first employer state." + jump_close + "<br>";
        badfield('jobHistStateOne');
    }
    else {
        goodfield('jobHistStateOne');
    }

    if (document.application.jobHistZipOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first employer zip." + jump_close + "<br>";
        badfield('jobHistZipOne');
    }
    else {
        goodfield('jobHistZipOne');
    }

    if (document.application.jobHistSupervisorOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first supervisor." + jump_close + "<br>";
        badfield('jobHistSupervisorOne');
    }
    else {
        goodfield('jobHistSupervisorOne');
    }

    if (document.application.jobHistPhoneOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first employer phone." + jump_close + "<br>";
        badfield('jobHistPhoneOne');
    }
    else {
        goodfield('jobHistPhoneOne');
    }

    if (document.application.jobHistFromDateOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first employer start date." + jump_close + "<br>";
        badfield('jobHistFromDateOne');
    }
    else {
        goodfield('jobHistFromDateOne');
    }

    if (document.application.JobHistToDateOne.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your first employer end date." + jump_close + "<br>";
        badfield('JobHistToDateOne');
    }
    else {
        goodfield('JobHistToDateOne');
    }

    if (document.application.employerNameHistTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer city." + jump_close + "<br>";
        badfield('employerNameHistTwo');
    }
    else {
        goodfield('employerNameHistTwo');
    }

    if (document.application.jobHistAddTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer address." + jump_close + "<br>";
        badfield('jobHistAddTwo');
    }
    else {
        goodfield('jobHistAddTwo');
    }

    if (document.application.jobHistCityTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer city." + jump_close + "<br>";
        badfield('jobHistCityTwo');
    }
    else {
        goodfield('jobHistCityTwo');
    }

    if (document.application.jobHistStateTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer state." + jump_close + "<br>";
        badfield('jobHistStateTwo');
    }
    else {
        goodfield('jobHistStateTwo');
    }

    if (document.application.jobHistZipTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer zip." + jump_close + "<br>";
        badfield('jobHistZipTwo');
    }
    else {
        goodfield('jobHistZipTwo');
    }

    if (document.application.jobHistSupervisorTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer supervisor." + jump_close + "<br>";
        badfield('jobHistSupervisorTwo');
    }
    else {
        goodfield('jobHistSupervisorTwo');
    }

    if (document.application.jobHistPhoneTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer phone." + jump_close + "<br>";
        badfield('jobHistPhoneTwo');
    }
    else {
        goodfield('jobHistPhoneTwo');
    }

    if (document.application.jobHistFromDateTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer start date." + jump_close + "<br>";
        badfield('jobHistFromDateTwo');
    }
    else {
        goodfield('jobHistFromDateTwo');
    }

    if (document.application.JobHistToDateTwo.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your second employer end date." + jump_close + "<br>";
        badfield('JobHistToDateTwo');
    }
    else {
        goodfield('JobHistToDateTwo');
    }

    if (document.application.employerNameHistThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer name." + jump_close + "<br>";
        badfield('employerNameHistThree');
    }
    else {
        goodfield('employerNameHistThree');
    }

    if (document.application.jobHistAddThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer address." + jump_close + "<br>";
        badfield('jobHistAddThree');
    }
    else {
        goodfield('jobHistAddThree');
    }

    if (document.application.jobHistCityThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;*" + jump_to.replace("(\'\')", "(\'workhistory\')") + " You didn't specify your third employer city." + jump_close + "<br>";
        badfield('jobHistCityThree');
    }
    else {
        goodfield('jobHistCityThree');
    }

    if (document.application.jobHistStateThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer state." + jump_close + "<br>";
        badfield('jobHistStateThree');
    }
    else {
        goodfield('jobHistStateThree');
    }

    if (document.application.jobHistZipThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer zip." + jump_close + "<br>";
        badfield('jobHistZipThree');
    }
    else {
        goodfield('jobHistZipThree');
    }

    if (document.application.jobHistSupervisorThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer supervisor." + jump_close + "<br>";
        badfield('jobHistSupervisorThree');
    }
    else {
        goodfield('jobHistSupervisorThree');
    }

    if (document.application.jobHistPhoneThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer phone number." + jump_close + "<br>";
        badfield('jobHistPhoneThree');
    }
    else {
        goodfield('jobHistPhoneThree');
    }

    if (document.application.jobHistFromDateThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer start date." + jump_close + "<br>";
        badfield('jobHistFromDateThree');
    }
    else {
        goodfield('jobHistFromDateThree');
    }

    if (document.application.JobHistToDateThree.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'workhistory\')") + "You didn't specify your third employer end date." + jump_close + "<br>";
        badfield('JobHistToDateThree');
    }
    else {
        goodfield('JobHistToDateThree');
    }

    //filing status
    var this_box = document.application.w4filing;
    if (this_box[0].checked === false && this_box[1].checked === false && this_box[2].checked === false) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'w4Supplement\')") + "You need to select your filing status below for number 3" + jump_close + "<br>";
        badfield('w4filing');
    }
    else {
        goodfield('w4filing');
    }

    //w4 total exemptions
    if (document.application.w4total.value === "") {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;* " + jump_to.replace("(\'\')", "(\'w4Supplement\')") + "You didn't specify total number of allowances you are claiming on question number 5 below." + jump_close + "<br>";
        badfield('w4total');
    }
    else {
        goodfield('w4total');
    }

    //Signed Forms?

    if (!document.application.agree2unemployment.checked) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;<em>* You didn't agree to the Unemployment Law & Unemployment Policy.</em><br>";
        badfield('agree2unemployment');
    }
    else {
        goodfield('agree2unemployment');
    }

    if (!document.application.agree2pandp.checked) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;<em>* You didn't agree to Personnel Plus's Policies and Procedures.</em><br>";
        badfield('agree2pandp');
    }
    else {
        goodfield('agree2pandp');
    }

    if (!document.application.agree2noncompete.checked) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;<em>* You didn't agree to Personnel Plus's Non-Compete Agreement.</em><br>";
        badfield('agree2noncompete');
    }
    else {
        goodfield('agree2noncompete');
    }

    if (!document.application.agree2safety.checked) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;<em>* You didn't agree to Personnel Plus's Safety Policy Statement.</em><br>";
        badfield('agree2safety');
    }
    else {
        goodfield('agree2safety');
    }

    if (!document.application.agree2drug.checked) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;<em>* You didn't agree to Personnel Plus's Drug Free Workplace Policy.</em><br>";
        badfield('agree2drug');
    }
    else {
        goodfield('agree2drug');
    }

    if (!document.application.agree2sexual.checked) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;<em>* You didn't agree to Personnel Plus's Sexual Harassment Policy.</em><br>";
        badfield('agree2sexual');
    }
    else {
        goodfield('agree2sexual');
    }

    if (!document.application.agree2applicant.checked) {
        okSoFar = false;
        problemWithThis = problemWithThis + "&nbsp;<em>* You didn't agree to Personnel Plus's Applicant Agreement.</em><br>";
        badfield('agree2applicant');
    }
    else {
        goodfield('agree2applicant');
    }

    if (okSoFar !== false) {
        grayOut(true);
        var agree = confirm("Ready to send your application?");
        if (agree) {
            document.application.formAction.value = 'submit';
            document.application.submit();
        }
        else {
            grayOut(false);
        }
    }
    else {
        document.application.formAction.value = 'notSet';
        document.getElementById('problemsInApp').className = 'show';
        document.getElementById("thisproblem").innerHTML = problemWithThis;
        return false;
    }
}

function saveApplication(gohere) {
    grayOut(true);
    document.application.formAction.value = 'save';
    document.application.wheretogo.value = gohere;
    document.application.submit();
}

function viewPrintApplication() {
    grayOut(true);
    document.application.formAction.value = 'viewprint';
    document.application.submit();
}

function thisdoesntapply(this_doesnt) {
    if (document.getElementById('workhistNA' + this_doesnt).value === 'na') {
        document.getElementById('employerNameHist' + this_doesnt).value = 'na';
        document.getElementById('employerNameHist' + this_doesnt).value = 'na';
        document.getElementById('jobHistAdd' + this_doesnt).value = 'na';
        document.getElementById('jobHistCity' + this_doesnt).value = 'na';
        document.getElementById('jobHistState' + this_doesnt).value = 'na';
        document.getElementById('jobHistZip' + this_doesnt).value = 'na';
        document.getElementById('jobHistPay' + this_doesnt).value = 'na';
        document.getElementById('jobHistSupervisor' + this_doesnt).value = 'na';
        document.getElementById('jobHistPhone' + this_doesnt).value = 'na';
        document.getElementById('jobHistFromDate' + this_doesnt).value = 'na';
        document.getElementById('JobHistToDate' + this_doesnt).value = 'na';
    }
}

function addw4lines() {
    var w4a = parseFloat("0" + document.getElementById('w4a').value);
    var w4b = parseFloat("0" + document.getElementById('w4b').value);
    var w4c = parseFloat("0" + document.getElementById('w4c').value);
    var w4d = parseFloat("0" + document.getElementById('w4d').value);
    var w4e = parseFloat("0" + document.getElementById('w4e').value);
    var w4f = parseFloat("0" + document.getElementById('w4f').value);
    var w4g = parseFloat("0" + document.getElementById('w4g').value);

    var w4h = document.getElementById('w4h');
    var w4total = document.getElementById('w4total');

    w4h.value = w4a + w4b + w4c + w4d + w4e + w4f + w4g;
    w4total.value = w4h.value;
    //if (document.getElementById('w4exempt')
}

function w4really() {
    var this_box = document.getElementById('w4exempt');
    if (this_box.checked === true) {
        var areyousure = confirm("Are you sure you want to claim 'Exempt' from income withholding for " + yr0 + "?");
        if (areyousure !== true) {
            this_box.checked = false;
        }
    }
}

function isDate(dateStr) {
    var datePat = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
    var matchArray = dateStr.match(datePat); // is the format ok?

    if (matchArray === null) {
        return false;
    }

    month = matchArray[1]; // p@rse date into variables
    day = matchArray[3];
    year = matchArray[5];

    if (month < 1 || month > 12) { // check month range
        return false;
    }

    if (day < 1 || day > 31) {
        return false;
    }

    if ((month === 4 || month === 6 || month === 9 || month === 11) && day === 31) {
        return false;
    }

    if (month === 2) { // check for february 29th
        var isleap = (year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0));
        if (day > 29 || (day === 29 && !isleap)) {
            return false;
        }
    }
    return true; // date is valid
}

function check_field(fieldname) {
    // first check for not empty
    if (document.getElementById(fieldname).value === "") {
        badfield(fieldname);
    } else {
        // then evaluate conditionally by fieldname

        switch (fieldname) {
            case 'ssn':
                if (formatSSN() === false) {
                    badfield(fieldname);
                } else {
                    goodfield(fieldname);
                }
                break;
            case 'dob':
                if (isDate(document.getElementById('dob').value) === false) {
                    badfield(fieldname);
                } else {
                    goodfield(fieldname);
                }
                break;
            case 'aliasNames':
                if (isDate(document.getElementById('dob').value) === false) {
                    badfield(fieldname);
                } else {
                    goodfield(fieldname);
                }
                break;
            default:
                goodfield(fieldname);
                break;
        }
    }
}

function focusthisform(thisform) {
    console.log(thisform);
    if (thisform !== 'unemploymentLaw') {
        hidediv('unemploymentLaw');
        notselected('t_nav_legal');
    }
    if (thisform !== 'w4Supplement') {
        hidediv('w4Supplement');
        notselected('t_nav_w4form');
    }
    if (thisform !== 'workhistory') {
        hidediv('workhistory');
        hidediv('applicationWorkHistoryTwo');
        hidediv('applicationWorkHistoryThree');
        notselected('t_nav_workhist');
    }
    if (thisform !== 'skillsInformation') {
        hidediv('skillsInformation');
        notselected('t_nav_skills');
    }
    if (thisform !== 'emergencyc') {
        hidediv('emergencyc');
        hidediv('employmentReferences');
        notselected('t_nav_contacts');
    }
    if (thisform !== 'employmentPreferences') {
        hidediv('employmentPreferences');
        notselected('t_nav_general');
    }

    switch (thisform) {
        case 'employmentPreferences':
            showdiv('employmentPreferences');
            selected('t_nav_general');
            break;
        case 'emergencyc':
            showdiv('emergencyc');
            showdiv('employmentReferences');
            selected('t_nav_contacts');
            break;
        case 'skillsInformation':
            showdiv('skillsInformation');
            selected('t_nav_skills');
            break;
        case 'workhistory':
            showdiv('workhistory');
            showdiv('applicationWorkHistoryTwo');
            showdiv('applicationWorkHistoryThree');
            selected('t_nav_workhist');
            break;
        case 'w4Supplement':
            showdiv('w4Supplement');
            selected('t_nav_w4form');
            break;
        case 'unemploymentLaw':
            showdiv('unemploymentLaw');
            selected('t_nav_legal');
            break;
    }
}

window.onload = Custom.init;