<script>

function showIDmsg()	{
	alert("You are REQUIRED to have a Social Security Number for\nall the partners -=OR=- a Tax ID Number, but not both.")
	}
	

function showSignmsg()	{
	alert("By electronically signing this form with your first, middle,\nand last name you are agreeing to allow Personnel\nPlus, Inc. to call the references, and pull a credit report.")
	}
	

function checkCredit()  {

var isGood = true
var COselection = ""
var POselection = ""
document.creditApp.submit_btn.disabled = true



// Billing information //

if (document.creditApp.billname.value == '')
	{	isGood = false;
		alert("Please enter the name for billing.");
	document.creditApp.billname.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.billadd1.value == '')
	{	isGood = false;
		alert("Please enter the billing address.");
	document.creditApp.billadd1.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}
	
if (document.creditApp.billcity.value == '')
	{	isGood = false;
		alert("Please enter the billing city.");
	document.creditApp.billcity.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.billstate.value == '')
	{	isGood = false;
		alert("Please select the billing state.");
	document.creditApp.billstate.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.billzip.value == '')
	{	isGood = false;
		alert("Please enter the billing zip code.");
	document.creditApp.billzip.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}
	
if (document.creditApp.billpayablecont.value == '')
	{	isGood = false;
		alert("Please enter the contact for accounts payable.");
	document.creditApp.billpayablecont.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.billcontemail.value == '')
	{	isGood = false;
		alert("Please enter the accounts payable contact's email address.");
	document.creditApp.billcontemail.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}
	
if (document.creditApp.billcontemail.value != '') {
	var okSoFar = true
	var foundAt = document.creditApp.billcontemail.value.indexOf("@",0)
	var foundDot = document.creditApp.billcontemail.value.indexOf(".",0)
		if (foundAt+foundDot < 2 && okSoFar) {
			isGood = false;
		alert("The accounts payable contact's email address is incomplete.")
		document.creditApp.billcontemail.value = "";
		document.creditApp.billcontemail.focus();
		document.creditApp.submit_btn.disabled = false;
			return false;
		}
	}



// Physical Address //

if (document.creditApp.physname.value == '')
	{	isGood = false;
		alert("Please enter the name for the physical address.")
	document.creditApp.physname.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.physadd1.value == '')
	{	isGood = false;
		alert("Please enter the physical address.")
	document.creditApp.physadd1.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}
	
if (document.creditApp.physcity.value == '')
	{	isGood = false;
		alert("Please enter the physical city.")
	document.creditApp.physcity.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.physstate.value == '')
	{	isGood = false;
		alert("Please select the physical state.")
	document.creditApp.physstate.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.physzip.value == '')
	{	isGood = false;
		alert("Please enter the physical zip code.")
	document.creditApp.physzip.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.physcounty.value == '')
	{	isGood = false;
		alert("Please enter the physical county.")
	document.creditApp.physcounty.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.physcontemail.value == '')
	{	isGood = false;
		alert("Please enter the physical location contact's email address.")
	document.creditApp.physcontemail.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.physcontemail.value != '') {
	var foundAt = document.creditApp.physcontemail.value.indexOf("@",0)
	var foundDot = document.creditApp.physcontemail.value.indexOf(".",0)
		if (foundAt+foundDot < 2 && okSoFar) {
			isGood = false;
		alert("The physical location contact's email address is incomplete.")
		document.creditApp.physcontemail.value = "";
		document.creditApp.physcontemail.focus();
		document.creditApp.submit_btn.disabled = false;
			return false;
		}
	}



// Company Information //

if (document.creditApp.coInfo[0].checked)
	{	COselection = document.creditApp.coInfo[0].value;
	}
	else if (document.creditApp.coInfo[1].checked)
		{	COselection = document.creditApp.coInfo[1].value;
		}
		else if (document.creditApp.coInfo[2].checked)
			{	COselection = document.creditApp.coInfo[2].value;	
			}
			else
			{	isGood = false;
				alert("Please select what type of business you are.")
			document.creditApp.coInfo[0].focus();
			document.creditApp.submit_btn.disabled = false;
				return false;
			}
			
if (document.creditApp.cobuyername.value == '')
	{	isGood = false;
		alert("Please enter the buyer's name of the business.")
	document.creditApp.cobuyername.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.timebusiness.value == '')
	{	isGood = false;
		alert("How long have you been in business?")
	document.creditApp.timebusiness.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.comonthlyvolume.value == '')
	{	isGood = false;
		alert("What is your average monthley volume?")
	document.creditApp.comonthlyvolume.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.typebusiness.value == '')
	{	isGood = false;
		alert("What type of business is this?")
	document.creditApp.typebusiness.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.po[0].checked)
	{	POselection = document.creditApp.po[0].value;
	}
	else if (document.creditApp.po[1].checked)
		{	POselection = document.creditApp.po[1].value;
		}
		else
		{	isGood = false;
			alert("Do you require a Purchase Order?")
		document.creditApp.po[0].focus();
		document.creditApp.submit_btn.disabled = false;
			return false;
		}

//if (document.creditApp.po.value == '')
//	{	isGood = false;
//		alert("Do you require a Purchase Order?")
//	document.creditApp.po.focus();
//	document.creditApp.submit_btn.disabled = false;
//		return false;
//	}

if (document.creditApp.taxID.value == '')
	{	if (document.creditApp.keysocseca.value == '')
		{	if (document.creditApp.keysocsecb.value == '')
			{	if (document.creditApp.keysocsecc.value == '')
				{	if (document.creditApp.keysocsecd.value == '')
					{	if (document.creditApp.keysocsece.value == '')
							isGood = false;
						{	alert("Please enter your Tax ID or a Social Security Number.")
						document.creditApp.taxID.focus();
						document.creditApp.submit_btn.disabled = false
							return false;
						}
					}
				}
			}
		}
	}

if (document.creditApp.issubsidiary.checked)
	{	if (document.creditApp.subsidiary.value == '')
		{	isGood = false;
			alert("Please enter the information for the parent company.")
		document.creditApp.subsidiary.focus();
		document.creditApp.submit_btn.disabled = false;
			return false;
		}
	}


// Key Principals or Partners //

if (document.creditApp.keynamea.value == '')
	{	isGood = false;
		alert("Please enter atleast one Key Principal or Partner.")
	document.creditApp.keynamea.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.keyadd1a.value == '')
	{	isGood = false;
		alert("Please enter the address for the Key Principal or Partner.")
	document.creditApp.keyadd1a.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.keycitya.value == '')
	{	isGood = false;
		alert("Please enter the city for the Key Principal or Partner.")
	document.creditApp.keycitya.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.keystatea.value == '')
	{	isGood = false;
		alert("Please select the state for the Key Principal or Partner.")
	document.creditApp.keystatea.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.keyzipa.value == '')
	{	isGood = false;
		alert("Please enter the zip code for the Key Principal or Partner.")
	document.creditApp.keyzipa.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.keyownershipa.value == '')
	{	isGood = false;
		alert("Please specify what the % of ownership is.")
	document.creditApp.keyownershipa.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}



// Trade References //

if (document.creditApp.tradename.value == '')
	{	isGood = false;
		alert("We require at least three Trade References.")
	document.creditApp.tradename.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradeaddress.value == '')
	{	isGood = false;
		alert("Please enter the address for the first Trade Reference.")
	document.creditApp.tradeaddress.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradecontact.value == '')
	{	isGood = false;
		alert("Please enter the first Trade Reference's Name.")
	document.creditApp.tradecontact.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradephone.value == '')
	{	isGood = false;
		alert("Please provide the phone number for the first Trade Reference.")
	document.creditApp.tradephone.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradename0.value == '')
	{	isGood = false;
		alert("We require at least three Trade References.")
	document.creditApp.tradename0.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradeaddress0.value == '')
	{	isGood = false;
		alert("Please enter the address for the second Trade Reference.")
	document.creditApp.tradeaddress0.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradecontact0.value == '')
	{	isGood = false;
		alert("Please enter the second Trade Reference's Name.")
	document.creditApp.tradecontact0.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradephone0.value == '')
	{	isGood = false;
		alert("Please provide the phone number for the second Trade Reference.")
	document.creditApp.tradephone0.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradename1.value == '')
	{	isGood = false;
		alert("We require at least three Trade References.")
	document.creditApp.tradename1.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradeaddress1.value == '')
	{	isGood = false;
		alert("Please enter the address for the third Trade Reference.")
	document.creditApp.tradeaddress1.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradecontact1.value == '')
	{	isGood = false;
		alert("Please enter the third Trade Reference's Name.")
	document.creditApp.tradecontact1.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.tradephone1.value == '')
	{	isGood = false;
		alert("Please provide the phone number for the third Trade Reference.")
	document.creditApp.tradephone1.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}



// Electronic Signature //

if (document.creditApp.signname.value == '')
	{	isGood = false;
		alert("Please electronically sign this document with your First name, Middle name, Last name, and Title.")
	document.creditApp.signname.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.signtitle.value == '')
	{	isGood = false;
		alert("Please electronically sign this document with your First name, Middle name, Last name, and Title.")
	document.creditApp.signtitle.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}
	
if (document.creditApp.youremail.value == '')
	{	isGood = false;
		alert("Please enter YOUR email address.")
	document.creditApp.youremail.focus();
	document.creditApp.submit_btn.disabled = false;
		return false;
	}

if (document.creditApp.youremail.value != '') {
	var foundAt = document.creditApp.youremail.value.indexOf("@",0)
	var foundDot = document.creditApp.youremail.value.indexOf(".",0)
		if (foundAt+foundDot < 2 && okSoFar) {
			isGood = false;
		alert("Your email address is incomplete.")
		document.creditApp.youremail.value = "";
		document.creditApp.youremail.focus();
		document.creditApp.submit_btn.disabled = false;
			return false;
		}
	}


if (isGood==true) {
	document.creditApp.submit()
	}
}

</script>