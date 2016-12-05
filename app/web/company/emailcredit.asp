<%
' SPAM TRAP - Blank Hidden Input
dim strSpamKill
strSpamKill = trim(request.form("Account_Number"))
if strSpamKill <> "" then
response.redirect "http://www.microsoft.com"
end if 

'check the email field - count the number of words and characters in the email field.

' Read in the input from the text area.
'strInputText = request("email")

'set the error page
'strErrorPage= "error.asp"

' Deal with tabs and carriage returns
' by replacing them with spaces.
'strTemp = Replace(strInputText, vbTab, " ")
'strTemp = Replace(strTemp, vbCr, " ")
'strTemp = Replace(strTemp, vbLf, " ")

'Remove leading and trailing spaces
'strTemp = Trim(strTemp)

' Combine multiple spaces down to single ones
'do while InStr(1, strTemp, " ", 1) <> 0
'strTemp = Replace(strTemp, " ", " ")
'loop

' Get a count by splitting the string into an array
' and retreiving the number of elements in it.
' I add one to deal with the 0 lower bound.
'GetWordCount = UBound(Split(strTemp, " ", -1, 1)) + 1
'GetCharCount = len(strInputText)

' if GetCharCount > 50 then response.redirect strErrorPage end if
' if GetWordCount > 1 then response.redirect strErrorPage end if

'check the other fields for stop words


'strInputText = request("email")
'strSearchText="levitra"
'if Instr(1, strInputText, strSearchText, 1) > 0 then response.redirect strErrorPage end if



' SPAM TRAP - End





dim subsidinfo
if request("issubsidiary") = "Yes" then 
subsidinfo = "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""5"" height=""19"">" & vbCrLf _
		& "					<p align=""center"">" & vbCrLf _
		& "					This company is a subsidiary.&nbsp;&nbsp;Here's the info:" & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""5"" height=""165"">" & vbCrLf _
		& "					<p align=""center"">" & vbCrLf _
		& "					" & request("subsidiary") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf
end if

dim cookietime
cookietime = request.cookies("creditapp")("time")

'Set the Body
msgBody = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">" & vbCrLf _
		& "<html>" & vbCrLf _
		& "<head>" & vbCrLf _
		& " <title>Credit Application</title>" & vbCrLf _
		& " <meta http-equiv=Content-Type content=""text/html; charset=iso-8859-1"">" & vbCrLf _
		& "</head>" & vbCrLf _
		& "<body bgcolor=""#FFFF99"">" & vbCrLf _
		& "		<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""775"">" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" colspan=""6"" height=""36"">" & vbCrLf _
		& "				<p align=""center""><strong>" & vbCrLf _
		& "					<font size=""6"">Credit Application</font></strong></td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" colspan=""6"" height=""19"">" & vbCrLf _
		& "					<p align=""center"">" & vbCrLf _
		& "						***********************************************************************************************</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" colspan=""6"" height=""19""><b>Billing Information:</b></td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">Name:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("billname") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">Phone #&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""137"">" & vbCrLf _
		& "					" & request("billphone") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""27"">&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""22"" width=""95"">&nbsp;</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">P. O. Box or Street Address:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("billadd1") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">Fax #&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""137"">" & vbCrLf _
		& "					" & request("billfax") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""27"">&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""19"" width=""95"">&nbsp;</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">&nbsp;<font size=""1"">(continued)&nbsp;&nbsp;</font></td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("billadd2") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td align=""right"" width=""96"">&nbsp;</td>" & vbCrLf _
		& "				<td align=""left"" width=""137"">&nbsp;</td>" & vbCrLf _
		& "				<td align=""right"" width=""27"">&nbsp;</td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp;</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">City:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("billcity") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">State:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""137"">" & vbCrLf _
		& "					" & request("billstate") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""27"">Zip:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""22"" width=""95"">" & vbCrLf _
		& "					" & request("billzip") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">Accounts Payable Contact:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("billpayablecont") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">Contact Email:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" colspan=""3"" height=""38"">" & vbCrLf _
		& "					" & request("billcontemail") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""6"" height=""19"">" & vbCrLf _
		& "					<p align=""center"">***********************************************************************************************</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""6"" height=""19"">" & vbCrLf _
		& "					<p align=""left""><b>Physical Address:</b></td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">Name:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("physname") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">Phone #&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""137"">" & vbCrLf _
		& "					" & request("physphone") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""27"">&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""22"" width=""95"">&nbsp;</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">Address:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("physadd1") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">Fax #&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""137"">" & vbCrLf _
		& "					" & request("physfax") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""27"">&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""22"" width=""95"">&nbsp;</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">&nbsp;<font size=""1"">(continued)&nbsp;&nbsp;</font></td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("physadd2") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td align=""right"" width=""96"">Hours:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td align=""left"" width=""137"">" & vbCrLf _
		& "					" & request("physhours") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td align=""right"" width=""27"">&nbsp;</td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp;</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">City:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("physcity") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">State:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""137"">" & vbCrLf _
		& "					" & request("physstate") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""27"">Zip:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""22"" width=""95"">" & vbCrLf _
		& "					" & request("physzip") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "			</tr>" & vbCrLf _
		& "			<tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""197"">County:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td align=""left"" width=""219"">" & vbCrLf _
		& "					" & request("physcounty") & vbCrLf _
		& "				</td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""96"">Contact Email:&nbsp;&nbsp;</td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" colspan=""3"">" & vbCrLf _
		& "					" & request("physcontemail") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""6"" height=""19"">" & vbCrLf _
		& "					<p align=""center"">*********************************************************************************************** </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "		</table>" & vbCrLf _
		& "		<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""775"">" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""5"" height=""19"">" & vbCrLf _
		& "					<p align=""left""><b>Company Information:</b> </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td align=""right"" width=""114"">" & vbCrLf _
		& "					<p align=""left"">" & vbCrLf _
		& "						" & request("coInfo") & vbCrLf _
		& "					 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""98"">Buyers Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""224"">" & vbCrLf _
		& "					" & request("cobuyername") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" width=""173"">" & vbCrLf _
		& "					<p align=""right"">Length of time in business:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" height=""11"" width=""171"">" & vbCrLf _
		& "					<p align=""left"">" & vbCrLf _
		& "						" & request("timebusiness") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""114"">" & vbCrLf _
		& "					<p align=""left"">" & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""2"">" & vbCrLf _
		& "					<p align=""right"">Approximate Monthly Volume:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" colspan=""2"">" & vbCrLf _
		& "					" & request("comonthlyvolume") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""114"">" & vbCrLf _
		& "					<p align=""left"">" & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""2"">" & vbCrLf _
		& "					<p align=""right"">Type of Business <font size=""1"">(<i>Attorney, " & vbCrLf _
		& "						Accounting, Manufacturing, etc.</i>):&nbsp;&nbsp;</font> </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" colspan=""2"" rowspan=""2"" width=""354"">" & vbCrLf _
		& "					" & request("typebusiness") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""3"">" & vbCrLf _
		& "					<p align=""left"">Purchase Order Required?&nbsp;&nbsp;" & request("po") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""5"" height=""19"">" & vbCrLf _
		& "					<p align=""center"">Tax ID #:&nbsp;&nbsp;" & vbCrLf _
		& "					" & request("taxID") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& subsidinfo & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""5"" height=""19"">" & vbCrLf _
		& "					<p align=""center"">*********************************************************************************************** </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "		</table>" & vbCrLf _
		& "		<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""775"">" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""6"" height=""19"">" & vbCrLf _
		& "					<p align=""left""><b>Key Principals or Partners:</b> </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keynamea") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Title:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keytitlea") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Residence Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd1a") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Residence Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keyphonea") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131""><font size=""1"">(continued)&nbsp;&nbsp;</font> </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd2a") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Social Security #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keysocseca") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">City:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keycitya") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">State:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keystatea") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">Zip:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">" & vbCrLf _
		& "					" & request("keyzipa") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">% of Ownership:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyownershipa") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keynameb") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Title:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keytitleb") & vbCrLf _ 
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Residence Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd1b") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Residence Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keyphoneb") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131""><font size=""1"">(continued)&nbsp;&nbsp;</font> </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd2b") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Social Security #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keysocsecb") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">City:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keycityb") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">State:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keystateb") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">Zip:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">" & vbCrLf _
		& "					" & request("keyzipb") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">% of Ownership:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyownershipb") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keynamec") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Title:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keytitlec") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Residence Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd1c") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Residence Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keyphonec") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131""><font size=""1"">(continued)&nbsp;&nbsp;</font> </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd2c") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Social Security #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keysocsecc") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">City:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keycityc") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">State:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keystatec") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">Zip:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">" & vbCrLf _
		& "					" & request("keyzipc") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">% of Ownership:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyownershipc") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keynamed") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Title:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keytitled") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Residence Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd1d") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Residence Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keyphoned") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131""><font size=""1"">(continued)&nbsp;&nbsp;</font> </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd2d") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Social Security #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keysocsecd") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">City:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keycityd") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">State:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keystated") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">Zip:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">" & vbCrLf _
		& "					" & request("keyzipd") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">% of Ownership:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyownershipd") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keynamee") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Title:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keytitlee") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Residence Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd1e") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Residence Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keyphonee") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131""><font size=""1"">(continued)&nbsp;&nbsp;</font> </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyadd2e") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Social Security #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keysocsece") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">City:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keycitye") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">State:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("keystatee") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">Zip:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">" & vbCrLf _
		& "					" & request("keyzipe") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">% of Ownership:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("keyownershipe") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""6"" height=""19"">" & vbCrLf _
		& "				<p align=""center"">*********************************************************************************************** </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" colspan=""6"" height=""19""><b>Trade " & vbCrLf _
		& "					References:</b> </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("tradename") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Contact:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradecontact") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" rowspan=""2"" width=""254"">" & vbCrLf _
		& "					" & request("tradeaddress") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradephone") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("tradename0") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Contact:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradecontact0") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" rowspan=""2"" width=""254"">" & vbCrLf _
		& "					" & request("tradeaddress0") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradephone0") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("tradename1") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Contact:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradecontact1") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" rowspan=""2"" width=""254"">" & vbCrLf _
		& "					" & request("tradeaddress1") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradephone1") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""19"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("tradename2") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Contact:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradecontact2") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" rowspan=""2"" width=""254"">" & vbCrLf _
		& "					" & request("tradeaddress2") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradephone2") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""22"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""20"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""20"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Name:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""254"">" & vbCrLf _
		& "					" & request("tradename3") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Contact:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradecontact3") & vbCrLf _ 
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""23"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">Address:&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" rowspan=""2"" width=""254"">" & vbCrLf _
		& "					" & request("tradeaddress3") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""133"">Phone #&nbsp;&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">" & vbCrLf _
		& "					" & request("tradephone3") & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""23"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" width=""133"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" width=""131"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""right"" width=""28"">&nbsp; </td>" & vbCrLf _
		& "				<td align=""left"" height=""20"" width=""95"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""6"" height=""20"">" & vbCrLf _
		& "				<p align=""center"">*********************************************************************************************** </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "		</table>" & vbCrLf _
		& "		<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""775"">" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""3"" height=""13"">" & vbCrLf _
		& "				<p align=""left""><font size=""1""><b>Terms of Sale and Agreement:</b></font> </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""3"" height=""85"">" & vbCrLf _
		& "					<p align=""left""><font size=""1"">Applicant(s) agrees to pay all " & vbCrLf _
		& "						monies within 30 days from date of sale.&nbsp; A finance charge " & vbCrLf _
		& "						of 1 1/2% per month, at an annual rate of 18%, will be charged " & vbCrLf _
		& "						on all delinquent accounts.  (Minimum service charge is " & vbCrLf _
		& "						$1.00)&nbsp; Should applicant default on terms and legal action " & vbCrLf _
		& "						become necessary, the Applicant(s) agrees to pay all collection " & vbCrLf _
		& "						expenses including administrative costs, court costs and " & vbCrLf _
		& "						attorney's fees.<br><br>Applicant(s) will inform Personnel Plus, Inc. " & vbCrLf _
		& "						(in writing) of any change in company name, address or phone " & vbCrLf _
		& "						number as soon as such<br>changes occur.  The information given " & vbCrLf _
		& "						is warranted to be true and Applicant(s) authorize the release " & vbCrLf _
		& "						of all pertinent information necessary<br>for processing the " & vbCrLf _
		& "						Applicant's request for credit, including bank records and other " & vbCrLf _
		& "						financial data.</font>" & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""20"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""center"">By </td>" & vbCrLf _
		& "				<td valign=""top"">" & vbCrLf _
		& "					<p align=""center"">Title </td>" & vbCrLf _
		& "				<td valign=""top"" align=""center"" height=""20"">Date </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"">&nbsp; </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""20"">&nbsp; </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"">" & vbCrLf _
		& "					<p align=""center"">" & vbCrLf _
		& "						" & request("signname") & vbCrLf _
		& "					 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""center"">" & vbCrLf _
		& "						" & request("signtitle") & vbCrLf _
		& "					 </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""23"">" & vbCrLf _
		& "					<p align=""center"">" & cookietime & vbCrLf _
		& "				</td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"">" & vbCrLf _
		& "					<p align=""center"">__________________________________________ </td>" & vbCrLf _
		& "				<td valign=""top"">" & vbCrLf _
		& "					<p align=""center"">___________________ </td>" & vbCrLf _
		& "				<td valign=""top"" align=""left"" height=""20"">" & vbCrLf _
		& "					<p align=""center"">___________________ </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "			 <tr>" & vbCrLf _
		& "				<td valign=""top"" align=""right"" colspan=""3"">" & vbCrLf _
		& "					<p align=""center""><font size=""1"">By filling out the above " & vbCrLf _
		& "						box with your first name, middle name, last name, and title, " & vbCrLf _
		& "						you agree to above terms and are legally electronically " & vbCrLf _
		& "						singing this document.</font>" & vbCrLf _
		& "				 </td>" & vbCrLf _
		& "			 </tr>" & vbCrLf _
		& "		</table>" & vbCrLf _
		& "</body>" & vbCrLf _
		& "</html>" & vbCrLf



response.write(msgBody)

' ---- / aspSmartMail ----
'	On error resume next

	dim mySmartMail
	Set mySmartMail = Server.CreateObject("aspSmartMail.SmartMail")
'	-- Mail Server
	mySmartMail.Server = "127.0.0.1"
'	mySmartMail.ServerPort = 25
	mySmartMail.ServerTimeOut = 35
'	-- From
'	mySmartMail.SenderName = "Your Name"
	mySmartMail.SenderAddress = request("youremail")
'	-- To
	mySmartMail.Recipients.Add "twin@personnel.com", ""
	mySmartMail.Recipients.Add "tmayer@personnel.com", ""	
'	-- Carbon copy
'	mySmartMail.CCs.Add "abc@def.com", "abc's name"
'	-- Blind carbon copy
	mySmartMail.BCCs.Add "jwerrbach@personnel.com", "spTest0612"
'	-- Reply To
	mySmartMail.ReplyTos.Add request("youremail"), request("youremail")
'	-- Message
	mySmartMail.Subject = "Personnel Plus - Credit Application"
	mySmartMail.Body = msgBody
'	-- Optional Parameters
	mySmartMail.Organization = "Personnel Plus Inc"
'	mySmartMail.XMailer = "Your Web App Name"
	mySmartMail.Priority = 3
	mySmartMail.ReturnReceipt = false
	mySmartMail.ConfirmRead = false
'	mySmartMail.ContentType = "text/plain"
	mySmartMail.ContentType = "text/html"		
	mySmartMail.Charset = "us-ascii"
	mySmartMail.Encoding = "base64"
'	-- Attached file
'	mySmartMail.Attachments.Add Server.MapPath("\aspSmartMail\sample.txt"),, false
'	-- Send the message
	mySmartMail.SendMail

'	-- Error handling
	if err.number <> 0 then
		response.write("Error n° " &  err.number - vbobjecterror & " = " & err.description  & "<br>")
	else
'		response.write "aspSmartMail has sent your message with this file as attachment : <br>"
'		response.write mySmartMail.Attachments.Item(1).FilePathName
	end if

	set mySmartMail = nothing
' ---- aspSmartMail / ----

response.write("<p align=""center"">Your credit application has been sent.<br>You will hear from a Personnel Plus representative shortly (within 24 hours during a normal business week).<br>Thank you for your time!<br></p>")
response.write("<p align=""center""><INPUT STYLE=""background:#339900; border:1 #333333 solid; font-size:9px; color:#FFFFFF"" type=""button"" value=""Close"" onClick=""javascript:window.close()""></p>")

' \\ CDO
%>
