<%Option Explicit%>
<%
session("add_css") = "tinyForms.asp.css"
session("required_user_level") = 3 'userLevelRegistered

dim formAction
formAction = request.form("formAction")
if formAction = "submit" then session("no_header") = true

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->
<%



select case formAction
case "save"
	Database.Open MySql
	SaveApplication (True)
	Database.Close
case "submit"
	SubmitApplication
end select

%>

<form class="skillstest" name="skillstest" id="skillstest" action="" method="post">
  <%=decorateTop("", "marLR10", "General Skills Evaluation Questions")%>
  <fieldset id="mathematics">
  <legend>Math A. Solve each problem</legend>
  <ol>
    <li>
      <ul>
        <li>27</li>
        <li>x9</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>813</li>
        <li>+509</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>1326</li>
        <li>-851</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>551</li>
        <li>x.03</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>431</li>
        <li>x16</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>213.01</li>
        <li>-17.85</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>&nbsp;</li>
        <li>5/1455</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
   </ol>
   <ol>
	
	<li>
      <ul>
        <li>&nbsp;</li>
        <li>&nbsp;</li>
        <li>14.02</li>
        <li>4.86</li>
        <li>97.32</li>
        <li>+165.01</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>16</li>
        <li>97</li>
        <li>75</li>
        <li>58</li>
        <li>78</li>
        <li>+84</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>29</li>
        <li>47</li>
        <li>89</li>
        <li>60</li>
        <li>76</li>
        <li>+56</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>39</li>
        <li>78</li>
        <li>77</li>
        <li>94</li>
        <li>85</li>
        <li>+39</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>49</li>
        <li>83</li>
        <li>95</li>
        <li>57</li>
        <li>68</li>
        <li>+48</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>16</li>
        <li>97</li>
        <li>75</li>
        <li>58</li>
        <li>78</li>
        <li>+84</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>29</li>
        <li>47</li>
        <li>89</li>
        <li>60</li>
        <li>76</li>
        <li>+56</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>39</li>
        <li>78</li>
        <li>77</li>
        <li>94</li>
        <li>85</li>
        <li>+39</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>49</li>
        <li>83</li>
        <li>95</li>
        <li>57</li>
        <li>68</li>
        <li>+48</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>16</li>
        <li>97</li>
        <li>75</li>
        <li>58</li>
        <li>78</li>
        <li>+84</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
    <li>
      <ul>
        <li>29</li>
        <li>47</li>
        <li>89</li>
        <li>60</li>
        <li>76</li>
        <li>+56</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
    </li>
  </ol>
  </fieldset>
  <fieldset>
  <legend>Math B. Solve the following problems.</legend>
  <div>
    <ol>
      <li>Add 4 feet 8 inches, + 5 feet 4 inches, + 7 inchs, + 2 feet 8 inches.
        <input type="text" name="name" id="name"class="styled"/>
      <li>Add 9 minutes 14 seconds, + 37 minutes 10 seconds, + 45 seconds.
        <input type="text" name="name" id="name"class="styled"/>
      <li>If you had to load 490 boxes into crates, and each create holds 7 boxes,
        how many crates would you need?
        <input type="text" name="name" id="name" class="styled"/>
      <li>If you only lived one mile from the grocery store and you decided to walk, 
        how long would it take you to get there if you walked for miles per hour?
        <input type="text" name="name" id="name"class="styled"/>
      <li>At Albertson's, chicken costs $1.15 per pound. If you bought 2 pounds and paid for it with a $20 bill, 
        how much change will you get?
        <input type="text" name="name" id="name"class="styled"/>
    </ol>
    <p style="margin-left:-45px">Filing. In the field provided, type the alphabetical section where each company should be filed.</p>
    <br>
    <strong>Alphabetical Sections</strong>
    <table style="width:100%;margin-left:25px;">
      <tr>
        <td width="33%">Aa-Bb</td>
        <td width="33%">Ga-Hz</td>
        <td width="33%">Na-Oz</td>
        <td></td>
      </tr>
      <tr>
        <td>Aa-Bb</td>
        <td>Ga-Hz</td>
        <td>Na-Oz</td>
        <td></td>
      </tr>
      <tr>
        <td>Bc-Cf</td>
        <td>Ia-Kz</td>
        <td>Pa-Rz</td>
        <td></td>
      </tr>
      <tr>
        <td>Cg-Dz</td>
        <td>La-Md</td>
        <td>Sa-Uz</td>
        <td></td>
      </tr>
      <tr>
        <td>Ea-Fz</td>
        <td>Me-Mz</td>
        <td>Va-Zz</td>
        <td></td>
      </tr>
    </table>
    <br>
    <p style="text-align:left">Example: Sa-Uz  Smith & Baker</p>
    <br>
    <table width="100%">
      <tr>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Personnel Plus</td>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Beacon Bakery</td>
      </tr>
      <tr>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Personnel Plus</td>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Beacon Bakery</td>
      </tr>
      <tr>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Holiday Paradise</td>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Landscape Pro's</td>
      </tr>
      <tr>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Smith and Company</td>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Kaiser Medical Center</td>
      </tr>
      <tr>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Morris Fertilizer</td>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Nomads Trucks Stop</td>
      </tr>
      <tr>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Eaton Testing Laboratory</td>
        <td></td>
        <td><input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/>
          Valley Shopping Center</td>
      </tr>
    </table>
    <br>
  </div>
  </fieldset>
  <br>
  <br>
  <fieldset style="margin-top:10;margin-bottom:10;">
  <legend>Ruler A. Find the following measurements of locations A, B, and C in inches.</legend>
  <div class="sideMargin skills">
    <table width="50%">
      <tr>
        <td>A =
          <input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/></td>
        <td>B =
          <input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/></td>
        <td>C =
          <input style="border: 1px solid #C7D2E0" type="text" name="name" id="name"class="styled"/></td>
      </tr>
    </table>
    <br>
    <img src="/include/style/images/ruler.gif" style="border:none"> </div>
  </fieldset>
  <br>
  <br>
  <fieldset style="margin-top:10;margin-bottom:10;">
  <legend>Comparison A. Put a check next to each list that is <strong>NOT</strong> the same.</legend>
  <div class="sideMargin skills">
    <table width="100%">
      <tr>
        <td><br></td>
        <td></td>
        <td width="75"></td>
        <td></td>
        <td width="75"></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" value="" class="styled"></td>
        <td>1. Ethan Jacobson</td>
        <td></td>
        <td>Ethan Jacobsen</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison1" type="checkbox" class="styled" value=""></td>
        <td>2.Larry Smith</td>
        <td></td>
        <td>Larrie Smith</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison2" type="checkbox" class="styled" value=""></td>
        <td>3. Troy Cooper</td>
        <td></td>
        <td>Troy Cooper</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison3" type="checkbox" class="styled" value=""></td>
        <td>4. Hank Williams</td>
        <td></td>
        <td>Hank Wiliams</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>5. Pat Paterson</td>
        <td></td>
        <td>Pat Peterson</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>6. Paul O'rion</td>
        <td></td>
        <td>Paul O'Rion</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>7. Edward D. English</td>
        <td></td>
        <td>Edward B. English</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>8. Angie Walker</td>
        <td></td>
        <td>Angy Walker</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>9. Sean W. Baker</td>
        <td></td>
        <td>Sean W. Baker</td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>10. Mary Ann Gold</td>
        <td></td>
        <td>Mary Ann Gold</td>
        <td></td>
      </tr>
      <tr>
        <td><br></td>
        <td></td>
        <td></td>
        <td></td>
        <td width="75"></td>
      </tr>
    </table>
  </div>
  </fieldset>
  <br>
  <br>
  <fieldset style="margin-top:10;margin-bottom:10;">
  <legend>Comparison B. Put a check next to each set if they are <strong>NOT</strong> the same.</legend>
  <div class="sideMargin skills">
    <table width="100%">
      <tr>
        <td><br></td>
        <td></td>
        <td width="25"></td>
        <td></td>
        <td width="75"></td>
        <td></td>
        <td width="50"></td>
        <td width="25"></td>
        <td></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>1.  2481</td>
        <td></td>
        <td>2481</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>11. 6966536</td>
        <td></td>
        <td>3996653</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>2.  1096</td>
        <td></td>
        <td>1051</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>12. 84728476</td>
        <td></td>
        <td>84725476</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>3.  1157</td>
        <td></td>
        <td>1175</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>13. 6524867</td>
        <td></td>
        <td>6524867</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>4.  13569</td>
        <td></td>
        <td>13569</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>14. 142568</td>
        <td></td>
        <td>14256</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>5.  19765</td>
        <td></td>
        <td>19765</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>15. 654987</td>
        <td></td>
        <td>654987</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>6.  G11560</td>
        <td></td>
        <td>G11560</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>16. J568894</td>
        <td></td>
        <td>J56894</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>7.  365877</td>
        <td></td>
        <td>366587</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>17. X156T9</td>
        <td></td>
        <td>X156T9</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>8.  79562K</td>
        <td></td>
        <td>79562K</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>18. 56847</td>
        <td></td>
        <td>56847</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>9.  17715563</td>
        <td></td>
        <td>17715563</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>19. 872315</td>
        <td></td>
        <td>8723315</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>10. 5683</td>
        <td></td>
        <td>5683</td>
        <td></td>
        <td><input name="comparison" type="checkbox" class="styled" value=""></td>
        <td>20. 1568797</td>
        <td></td>
        <td>1568779</td>
      </tr>
      <tr>
        <td><br></td>
        <td></td>
        <td width="50"></td>
        <td></td>
        <td width="50"></td>
        <td></td>
        <td width="75"></td>
        <td></td>
        <td width="75"></td>
      </tr>
    </table>
  </div>
  </fieldset>
  <br>
  <br>
  <fieldset style="margin-top:10;margin-bottom:10;">
  <legend>Spelling. Put a check next to each <strong>MISSPELLED</strong>word.</legend>
  <div class="sideMargin skills">
    <table width="100%">
      <tr>
        <td width="25%"><br></td>
        <td width="25%"></td>
        <td width="25%"></td>
        <td width="25%"></td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          >attentian</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          argument</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          cordially</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          difinitely</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          repition</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          occurrence</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          priviledge</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          separate</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          comparative</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          beginning</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          extraordinry</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          favorite</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          dispair</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          alltogether</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          hazardus</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          representative</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          availability</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          conscience</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          assistance</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          miscelaneous</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          absense</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          similar</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          occasion</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          conferred</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          description</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          suggestion</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          numberical</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          accommodate</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          misspell</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          maintenance</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          responsible</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          embarass</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          ready</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          garantee</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          sincerely</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          gracious</td>
      </tr>
      <tr>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          suitable</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          incidental</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          analyze</td>
        <td><input name="comparison" type="checkbox" class="styled" value="">
          unneccesary</td>
      </tr>
    </table>
  </div>
  </fieldset>
  </div>
  <div class="bb">
    <div>
      <div></div>
    </div>
  </div>
  </div>
</form>
<%

Function SaveApplication (saveNotice)

	dim firstName, lastName, email, userID, sql, agree2pandp, agree2unemployment

	firstName = Pcase(user_firstname)
	lastName = Pcase(user_lastname)
	ssn = ssnRE.Replace(request.form("ssn"), "")
	dob = request.form("dob")
	if isDate(dob) then	dob = FormatDateTime(dob, 2)
	email = user_email
	emailupdates = request.form("emailupdates")
	mainPhone = ssnRE.Replace(user_phone, "")
	altPhone = ssnRE.Replace(user_sphone, "")
	addressOne = request.form("addressOne")
	addressTwo = request.form("addressTwo")
	city = request.form("city")
	appState = request.form("appState")
	zipcode = ssnRE.Replace(request.form("zipcode"), "")
	desiredWageAmount = request.form("desiredWageAmount")
	minWageAmount = request.form("minWageAmount")
	sex = request.form("sex")
	maritalStatus = request.form("maritalStatus")
	smoker = request.form("smoker")
	currentlyEmployed = request.form("currentlyEmployed")
	workTypeDesired = request.form("workTypeDesired")
	citizen = request.form("citizen")
	alienType = request.form("alienType") : if len(alienType & "") = 0 then alienType = "p"
	alienNumber = request.form("alienNumber")
	citizen = request.form("citizen")
	workAuthProof = request.form("workAuthProof")
	workAge = request.form("workAge")
	workValidLicense = request.form("workValidLicense")
	workLicenseType = request.form("workLicenseType")
	workRelocate = request.form("workRelocate")
	workConviction = request.form("workConviction")
	workConvictionExplain = request.form("workConvictionExplain")
	w4a = request.form("w4a")
	w4b = request.form("w4b")
	w4c = request.form("w4c")
	w4d = request.form("w4d")
	w4e = request.form("w4e")
	w4f = request.form("w4f")
	w4g = request.form("w4g")
	w4h = request.form("w4h")
	w4more = request.form("w4more")
	w4filing = request.form("w4filing")
	w4signed = request.form("w4signed")
	currentlyEmployed = request.form("currentlyEmployed")
	availableWhen = request.form("availableWhen")
	workCommuteHow = request.form("workCommuteHow")
	workCommuteDistance = request.form("workCommuteDistance")
	workLicenseState = request.form("workLicenseState")
	workLicenseExpire = request.form("workLicenseExpire")
	autoInsurance = request.form("autoInsurance")
	eduLevel = request.form("eduLevel")
	additionalInfo = request.form("additionalInfo")
	referenceNameOne = request.form("referenceNameOne")
	referencePhoneOne = ssnRE.Replace(request.form("referencePhoneOne"), "")
	referenceNameTwo = request.form("referenceNameTwo")
	referencePhoneTwo = ssnRE.Replace(request.form("referencePhoneTwo"), "")
	referenceNameThree = request.form("referenceNameThree")
	referencePhoneThree = ssnRE.Replace(request.form("referencePhoneThree"), "")
	skillsSet = CollectSkills
	employerNameHistOne = request.form("employerNameHistOne")
	jobHistAddOne = request.form("jobHistAddOne")
	jobHistPhoneOne = ssnRE.Replace(request.form("jobHistPhoneOne"), "")
	jobHistCityOne = request.form("jobHistCityOne")
	jobHistStateOne = request.form("jobHistStateOne")
	jobHistZipOne = ssnRE.Replace(request.form("jobHistZipOne"), "")
	jobHistPayOne = request.form("jobHistPayOne")
	jobHistSupervisorOne = request.form("jobHistSupervisorOne")
	jobDutiesOne = request.form("jobDutiesOne")
	jobHistFromDateOne = request.form("jobHistFromDateOne")
	JobHistToDateOne = request.form("JobHistToDateOne")
	jobReasonOne = request.form("jobReasonOne")
	employerNameHistTwo = request.form("employerNameHistTwo")
	jobHistAddTwo = request.form("jobHistAddTwo")
	jobHistPhoneTwo = ssnRE.Replace(request.form("jobHistPhoneTwo"), "")
	jobHistCityTwo = request.form("jobHistCityTwo")
	jobHistStateTwo = request.form("jobHistStateTwo")
	jobHistZipTwo = ssnRE.Replace(request.form("jobHistZipTwo"), "")
	jobHistPayTwo = request.form("jobHistPayTwo")
	jobHistSupervisorTwo = request.form("jobHistSupervisorTwo")
	jobDutiesTwo = request.form("jobDutiesTwo")
	jobHistFromDateTwo = request.form("jobHistFromDateTwo")
	JobHistToDateTwo = request.form("JobHistToDateTwo")
	jobReasonTwo = request.form("jobReasonTwo")
	employerNameHistThree = request.form("employerNameHistThree")
	jobHistAddThree = request.form("jobHistAddThree")
	jobHistPhoneThree = ssnRE.Replace(request.form("jobHistPhoneThree"), "")
	jobHistCityThree = request.form("jobHistCityThree")
	jobHistStateThree = request.form("jobHistStateThree")
	jobHistZipThree = request.form("jobHistZipThree")
	jobHistPayThree = request.form("jobHistPayThree")
	jobHistSupervisorThree = request.form("jobHistSupervisorThree")
	jobDutiesThree = request.form("jobDutiesThree")
	jobHistFromDateThree = request.form("jobHistFromDateThree")
	JobHistToDateThree = request.form("JobHistToDateThree")
	jobReasonThree = request.form("jobReasonThree")

	dim agrees
	if request.form("agree2pandp") = "agree" then
		agrees = "pandpAgree=Now(), "
	end if
	
	if request.form("agree2unemployment") = "agree" then
		agrees = agrees & "unempAgree=Now(), "
	end if

	if request.form("agree2applicant") = "agree" then
		agrees = agrees & "applicantAgree=Now(), "
	end if

	dim signw4
	if w4signed = "Sign" then
		signw4 = "signed=now(), "
	end if
	
	if instr(lcase(email), "none") > 0 and instr(email, "@") = 0 then email = ""
	
	sql = "UPDATE tbl_applications SET " &_
		"email=" & insert_string(lcase(email)) & ", " &_
		"firstName=" & insert_string(pcase(firstName)) & ", " &_
		"lastName=" & insert_string(pcase(lastName)) & ", " &_
		"ssn=" & insert_string(ssn) & ", " &_
		"dob=" & insert_string(dob) & ", " &_
		"mainPhone=" & insert_string(formatPhone(mainPhone)) & ", " &_
		"altPhone=" & insert_string(formatPhone(altPhone)) & ", " &_
		"addressOne=" & insert_string(pcase(addressOne)) & ", " &_
		"addressTwo=" & insert_string(pcase(addressTwo)) & ", " &_
		"city=" & insert_string(pcase(city)) & ", " &_
		"appState=" & insert_string(ucase(appState)) & ", " &_
		"zipcode=" & insert_string(zipcode) & ", " &_
		"emailupdates=" & insert_string(emailupdates) & ", " &_
		"desiredWageAmount=" & insert_string(desiredWageAmount) & ", " &_
		"minWageAmount=" & insert_string(minWageAmount) & ", " &_
		"sex=" & insert_string(sex) & ", " &_
		"maritalStatus=" & insert_string(maritalStatus) & ", " &_
		"smoker=" & insert_string(smoker) & ", " &_
		"currentlyEmployed=" & insert_string(currentlyEmployed) & ", " &_
		"workTypeDesired=" & insert_string(workTypeDesired) & ", " &_
		"citizen=" & insert_string(citizen) & ", " &_
		"alienType=" & insert_string(alienType) & ", " &_
		"alienNumber=" & insert_string(alienNumber) & ", " &_
		"workAuthProof=" & insert_string(workAuthProof) & ", " &_
		"workAge=" & insert_string(workAge) & ", " &_
		"workValidLicense=" & insert_string(workValidLicense) & ", " &_
		"workLicenseType=" & insert_string(workLicenseType) & ", " &_
		"autoInsurance=" & insert_string(autoInsurance) & ", " &_
		"workRelocate=" & insert_string(workRelocate) & ", " &_
		"workConviction=" & insert_string(workConviction) & ", " &_
		"workConvictionExplain=" & insert_string(workConvictionExplain) & ", " &_
		"eduLevel=" & insert_string(eduLevel) & ", " &_
		"referenceNameOne=" & insert_string(pcase(referenceNameOne)) & ", " &_
		"referencePhoneOne=" & insert_string(formatPhone(referencePhoneOne)) & ", " & _
		"referenceNameTwo=" & insert_string(pcase(referenceNameTwo)) & ", " &_
		"referencePhoneTwo=" & insert_string(formatPhone(referencePhoneTwo)) & ", " &_
		"referenceNameThree=" & insert_string(pcase(referenceNameThree)) & ", " &_
		"referencePhoneThree=" & insert_string(formatPhone(referencePhoneThree)) & ", " &_
		"additionalInfo=" & insert_string(additionalInfo) & ", " &_
		"skillsSet=" & insert_string(skillsSet) & ", " &_
		"employerNameHistOne=" & insert_string(pcase(employerNameHistOne)) & ", " &_
		"jobHistAddOne=" & insert_string(pcase(jobHistAddOne)) & ", " & _
		"jobHistCityOne=" & insert_string(pcase(jobHistCityOne)) & ", " &_
		"jobHistStateOne=" & insert_string(ucase(jobHistStateOne)) & ", " &_
		"jobHistZipOne=" & insert_string(jobHistZipOne) & ", " &_
		"jobHistPayOne=" & insert_string(jobHistPayOne) & ", " &_
		"jobHistSupervisorOne=" & insert_string(pcase(jobHistSupervisorOne)) & ", " &_
		"jobHistPhoneOne=" & insert_string(formatPhone(jobHistPhoneOne)) & ", " &_
		"jobHistFromDateOne=" & insert_string(jobHistFromDateOne) & ", " & _
		"jobHistToDateOne=" & insert_string(jobHistToDateOne) & ", " &_
		"jobDutiesOne=" & insert_string(jobDutiesOne) & ", " &_
		"jobReasonOne=" & insert_string(jobReasonOne) & ", " &_
		"employerNameHistTwo=" & insert_string(pcase(employerNameHistTwo)) & ", " &_
		"jobHistAddTwo=" & insert_string(pcase(jobHistAddTwo)) & ", " &_
		"jobHistCityTwo=" & insert_string(pcase(jobHistCityTwo)) & ", " &_
		"jobHistStateTwo=" & insert_string(ucase(jobHistStateTwo)) & ", " & _
		"jobHistZipTwo=" & insert_string(jobHistZipTwo) & ", " &_
		"jobHistPayTwo=" & insert_string(jobHistPayTwo) & ", " &_
		"jobHistSupervisorTwo=" & insert_string(pcase(jobHistSupervisorTwo)) & ", " &_
		"jobHistPhoneTwo=" & insert_string(formatPhone(jobHistPhoneTwo)) & ", " &_
		"jobHistFromDateTwo=" & insert_string(jobHistFromDateTwo) & ", " &_
		"jobHistToDateTwo=" & insert_string(JobHistToDateTwo) & ", " &_
		"jobDutiesTwo=" & insert_string(jobDutiesTwo) & ", " &_
		"jobReasonTwo=" & insert_string(jobReasonTwo) & ", " & _
		"employerNameHistThree=" & insert_string(pcase(employerNameHistThree)) & ", " &_
		"jobHistAddThree=" & insert_string(pcase(jobHistAddThree)) & ", " &_
		"jobHistPhoneThree=" & insert_string(formatPhone(jobHistPhoneThree)) & ", " &_
		"jobHistCityThree=" & insert_string(pcase(jobHistCityThree)) & ", " &_
		"jobHistStateThree=" & insert_string(ucase(jobHistStateThree)) & ", " &_
		"jobHistZipThree=" & insert_string(jobHistZipThree) & ", " &_
		"jobHistPayThree=" & insert_string(jobHistPayThree) & ", " & _
		"jobHistSupervisorThree=" & insert_string(pcase(jobHistSupervisorThree)) & ", " &_
		"jobDutiesThree=" & insert_string(jobDutiesThree) & ", " &_
		"jobHistFromDateThree=" & insert_string(jobHistFromDateThree) & ", " &_
		"JobHistToDateThree=" & insert_string(JobHistToDateThree) & ", " &_
		"jobReasonThree=" & insert_string(jobReasonThree) & ", " &_
		agrees &_
		"modifiedDate=Now() " &_
		"WHERE applicationId=" & applicationId &_
			";" &_
		"UPDATE tbl_w4 SET " &_
		"a=" & insert_number(w4a) & ", " &_
		"b=" & insert_number(w4b) & ", " &_
		"c=" & insert_number(w4c) & ", " &_
		"d=" & insert_number(w4d) & ", " &_
		"e=" & insert_number(w4e) & ", " &_
		"f=" & insert_number(w4f) & ", " &_
		"g=" & insert_number(w4g) & ", " &_
		"more=" & insert_number(w4more) & ", " &_
		signw4 &_
		"filing=" & insert_number(w4filing) & " " &_
		"WHERE userid=" & user_id
		
	Database.Execute(sql)
	
	if saveNotice = true then
		session("applicationSaved") = "<div id=" & chr(34) & "applicationSaved" & chr(34) & "><p><span>Your application was successfully saved.</span></p><br>" &_
		"<p>Don't forget your application is not completed and you are not elgible for work until you fill in all the information and submit it online." &_
		" Please remember to return at your convenience to finish and submit your application!</p></div>"
		'break session("applicationSaved")
	end if

End Function

Sub SubmitApplication
	Database.Open MySql
	SaveApplication (false)
	Database.Execute("UPDATE tbl_applications SET submitted='y' WHERE applicationId=" & applicationId)

	dim appLink, msgBody, msgSubject, city, appState, zipcode, deliveryLocation

	appLink = "<a href='/include/system/tools/activity/applications/view/'>View Online Applications</a>" 
	msgBody = user_firstname & " " & user_lastname & "'s application has been updated. "
	msgSubject = "Employment Application:  " & user_lastname & ", " & user_firstname 

	'Determine destination
	Set dbQuery = Database.Execute("Select email From list_zips Where zip='" & zipcode & "'")
	if Not dbQuery.eof then
		deliveryLocation = dbQuery("email")
	else
		deliveryLocation = "twin@personnel.com"
	end if
	
	'Call SendEmail (deliveryLocation, system_email, msgSubject, msgBody, "")

	Set dbQuery = Nothing
	Database.Close()

	session("no_header") = false
	response.redirect("/userHome.asp?AST=ao")
End Sub

Function CollectSkills
	dim i, Skills, SkillItem
	
	Skills = "."
	For i = 1 to CInt(request.form("totalSkills"))
		SkillItem = Trim(request.form("Ck_" & i))
		if len(SkillItem) > 0 then Skills = Skills + SkillItem + "."
	Next
	CollectSkills = Skills
End Function

Function CheckField (formField)
	if request.form("formAction") = "true" then
	
	dim TempValue
	Select Case	formField
		Case "email"
			TempValue = request.form("email")
			Database.Open MySql
			Set dbQuery = Database.Execute("Select email From tbl_users Where email = '" & TempValue & "'")
			
			if TempValue = "" then
				CheckField = errImage & " User name is required"
			elseif len(TempValue) < 5 then
				CheckField = errImage & " User name must be longer<br>than 5 characters, letters<br>and/or numbers."
			elseif Not dbQuery.eof then 
					CheckField = errImage & "Email address already registered. <br>Please use a different one or contact our offices."
			elseif Instr(TempValue,"@") = 0 then
				CheckField = errImage & " Invalid eMail Address"
			Else
				CheckField = ""
			end if
			Set dbQuery = Nothing
			Database.Close
		Case "password"
			TempValue = request.form("password")
			if TempValue = "" then
				CheckField = errImage & " Password is required"
			elseif TempValue <> request.form("retypedpassword") then
				CheckField = errImage & " Passwords do not match"
			Else
				CheckField = ""
			end if
		Case "nameF"
			if request.form("nameF") = "" then
				CheckField = errImage & " First name is required"
			Else
				CheckField = ""
			end if
		Case "nameL"
			if request.form("nameL") = "" then
				CheckField = errImage & " Last name is required"
			Else
				CheckField = ""
			end if
		Case "addOne"
			if request.form("addOne") = "" then
				CheckField = errImage & " Address is required"
			Else
				CheckField = ""
			end if
		Case "city"
			if request.form("city") = "" then
				CheckField = errImage & " City Required"
			Else
				CheckField = ""
			end if
		Case "zipcode"
			if request.form("zipcode") = "" then
				CheckField = errImage & " Zip Code Required"
			Else
				CheckField = ""
			end if
		End Select	
		Else
			CheckField = ""
		end if
End Function

Sub createNewApp
		'Execute the INSERT statement and the SELECT @@IDENTITY
		Set addressInfo = Database.execute("SELECT address, addressTwo, city, state, zip " &_
			"FROM tbl_addresses " &_
			"WHERE addressID=" & addressId)
			
		dim qryTxt
		qryTxt = "INSERT INTO tbl_applications (creationDate, modifiedDate, lastName, firstName, addressOne, addressTwo, city, appState, zipcode, userID) " & _
							 "VALUES (now(), " &_
							 "now(), '" &_
							 user_lastname & "', '" &_
							 user_firstname & "', '" &_
							 addressInfo("address") & "', '" &_
							 addressInfo("addressTwo") & "', '" &_
							 addressInfo("city") & "', '" &_
							 addressInfo("state") & "', '" &_
							 addressInfo("zip") & "', '" &_
							 user_id & "'); " & _
							 "SELECT last_insert_id()"
		'response.write qryTxt
		'Response.End()
		Set dbQuery = Database.execute(qryTxt).nextrecordset
		applicationId = CInt(dbQuery(0))
		Database.Execute("Update tbl_users SET applicationId=" & applicationId & " WHERE userID=" & user_id)
		
		'create w4 record
		qryTxt = "INSERT INTO tbl_w4 (userid, created) VALUES ('" & user_id & "', now())"
		Database.Execute(qryTxt)
		Set dbQuery = Nothing
End Sub


%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
