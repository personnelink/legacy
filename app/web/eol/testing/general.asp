<!-- #INCLUDE VIRTUAL='/include/master/masterPageTop.asp' -->
    <script type="text/JavaScript">
<!--
//here you place the ids of every element you want.

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
window.onload = Custom.init;

//-->
</script>
    <style type="text/css">
input
{
text-align:right
color: #003466;
border: 1px solid #C7D2E0;
padding: .2em .2em .1em;
margin-bottom:.5em;
height:1.5em;
background:url(../../include/style/images/normalTitleBackground.gif) repeat-x bottom;
}
fieldset
{
border: none;
margin: 0 .9em .9em;
width: auto;
}
fieldset legend {
color: #fff;
background: #ffa20c;
padding: 2px 6px
} 
   span.checkbox {
    width: 19px;
    height: 25px;
    padding: 0 5px 0 0;
	margin:-5px 0 0;
    background: url('/include/style/images/forms/checkbox.gif') no-repeat;
    display: block;
    clear: left;
    float: left;
  }
  span.radio {
   width: 19px;
     height: 25px;
    padding: 0 5px 0 0;
	margin:-5px 0 0;
    background: url('/include/style/images/forms/radio.gif') no-repeat;
     display: block;
    clear: left;
	float: right;
  }
   span.select {
     position: absolute;
     width: 158px; /* With the padding included, the width is 190 pixels: the actual width of the image. */
     height: 21px;
     padding: 0 24px 0 8px;
     color: #fff;
  font: 12px/21px arial,sans-serif;
   background: url(../../testing/select.gif) no-repeat;
  overflow: hidden;
 }

fieldset ul {
display:block;
float:left; 
clear:both;
margin:0 auto 1em;
}

fieldset li {display: block;clear: right;float:left;
}

label
{
float: left;
text-align: left;
margin-right: 0.5em;
display: block
}
p, label {color:#003466}

#generalTestExample ul li {width:26em; height:3em; display:block; vertical-align:middle;}
#generalTestExample label, #generalTestExample input {width:3em}

#mathmatics ul li {width:5em; height:2em; display:inline; vertical-align:middle;}
#mathmatics label, #mathmatics input {width:2em}





.hide {display: none;}
.show {display: block;}
div p {display: block;}

</style>
    <!-- Site content goes here, when done, make sure include for masterPageBottom is present -->
    <div id="generalTestExample">
    <div class="tb">
      <div>
        <div></div>
      </div>
    </div>
    <div class="mb clearfix">
    <h2> General Skills Evaluation Example Questions </h2>
    <form>
      <fieldset id="mathmatics">
      <legend>Math A. Solve each problem</legend>
      <ul>
        <li>27</li>
        <li>x9</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
      <ul>
        <li>813</li>
        <li>+509</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
      <ul>
        <li>1326</li>
        <li>-851</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
      <ul>
        <li>551</li>
        <li>x.03</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
      <ul>
        <li>431</li>
        <li>x16</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
      <ul>
        <li>213.01</li>
        <li>-17.85</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
      <ul>
        <li>14.02</li>
        <li>4.86</li>
        <li>97.32</li>
        <li>+165.01</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
      <ul>
        <li>5/1455</li>
        <li>
          <input type="text" name="name" id="name"class="styled"/>
        </li>
      </ul>
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
      <br>
      <br>
      </fieldset>
      <br>
      <br>
      <fieldset style="margin-top:10;margin-bottom:10;">
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
        <hr>
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
    <!-- End of Site content -->
    <!-- #INCLUDE VIRTUAL='/include/master/pageFooter.asp' -->
