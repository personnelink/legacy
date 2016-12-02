<%
session("add_css") = "timecardform.asp.css" %>
<!-- #include virtual='/include/core/init_secure_session.asp' -->

<script type="text/javascript">
function setDays(form)
{
  year = parseInt(form.year.options[form.year.selectedIndex].value);
  month = form.month.selectedIndex;
  day = form.day.selectedIndex;
  form.day.options.length = 0;
  var days = new Array(31, ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  for(i = 0; i < days[month]; i++)
  {
    form.day.options.length = form.day.options.length + 1;
    form.day.options[i].value = i + 1;
    form.day.options[i].text = i + 1;
  }
  form.day.selectedIndex = (day < form.day.options.length) ? day : form.day.options.length - 1;
}
</script>

<%=DecorateTop("timeEntryForm", "", "Time Entry Form...Scratchpad")%>	
<form id="form" name="form" method="post" action="">

	<p><span><select><option>Client Company</option></select></span><span><select><option>Location Info</option></select></span><span>Week Ending<input type="text" /></span></p>
	<p>&nbsp;</p>
	<p><span class="dayOfTheWeek"><label for="monday">Monday</label></span><span>
		<span>Time-In</span><span><input name="monday" type="text" /></span>
		<span>Lunch-Out</span><span><input type="text" /></span>
		<span>Lunch-In</span><span><input type="text" /></span>
		<span>Time-Out</span><span><input type="text" /></span>
		<span>Total</span><span>#####</span>
	</span></p>
	<p><span class="dayOfTheWeek">Tuesday</span><span>
		<span>Time-In</span><span><input type="text" /></span>
		<span>Lunch-Out</span><span><input type="text" /></span>
		<span>Lunch-In</span><span><input type="text" /></span>
		<span>Time-Out</span><span><input type="text" /></span>
		<span>Total</span><span>#####</span>
	</span></p>
	<p><span class="dayOfTheWeek">Wednesday</span><span>
		<span>Time-In</span><span><input type="text" /></span>
		<span>Lunch-Out</span><span><input type="text" /></span>
		<span>Lunch-In</span><span><input type="text" /></span>
		<span>Time-Out</span><span><input type="text" /></span>
		<span>Total</span><span>#####</span>
	</span></p>
	<p><span class="dayOfTheWeek"><label for="thursday">Thursday</label></span><span>
		<span>Time-In</span><span><input type="text" /></span>
		<span>Lunch-Out</span><span><input type="text" /></span>
		<span>Lunch-In</span><span><input type="text" /></span>
		<span>Time-Out</span><span><input type="text" /></span>
		<span>Total</span><span>#####</span>
	</span></p>
	<p><span class="dayOfTheWeek"><label for="friday">Friday</label></span><span>
		<span>Time-In</span><span><input type="text" /></span>
		<span>Lunch-Out</span><span><input type="text" /></span>
		<span>Lunch-In</span><span><input type="text" /></span>
		<span>Time-Out</span><span><input type="text" /></span>
		<span>Total</span><span>#####</span>
	</span></p>
	<p><span class="dayOfTheWeek"><label for="saturday">Saturday</label></span><span>
		<span>Time-In</span><span><input type="text" /></span>
		<span>Lunch-Out</span><span><input type="text" /></span>
		<span>Lunch-In</span><span><input type="text" /></span>
		<span>Time-Out</span><span><input type="text" /></span>
		<span>Total</span><span>#####</span>
	</span></p>
	<div class="dayOfTheWeek">
	<span>Sunday</span>
      <ul>
    <li><label for="SundayTimeIn">Time-In</label><input name="SundayTimeIn" type="text" /></li>
    <li><label for="SundayLunchOut">Lunch-Out</label><input name="SundayLunchOut" type="text" /></li>
    <li><label for="SundayLunchIn">Lunch-In</label><input name="SundayLunchIn" type="text" /></li>
    <li><label for="SundayTimeOut">Time-Out</label><input name="SundayTimeOut" type="text" /></li>
    <li><label for="SundayLunchOut">Total</label><input type="text" readonly="readonly" value="#####"></li>
  </ul></div>
  

<select name="month" id="month" onChange="setDays(this.form)">
		<option value="1">January</option>
		<option value="2">February</option>
		<option value="3">March</option>
		<option value="4">April</option>
		<option value="5">May</option>
		<option value="6">June</option>
		<option value="7">July</option>
		<option value="8">August</option>
		<option value="9">September</option>
		<option value="10">October</option>
		<option value="11">November</option>
		<option value="12">December</option>
	</select>

	<select name="day" id="day"><%
		For i = 1 to 30 %>
			<option value="<%=i%>"><%=i%></option><%
		Next %>
	</select>
  <select name="year" id="year" onChange="setDays(this.form)">
    <option value="1984">1984</option>
    <option value="1985">1985</option>
    <option value="1986">1986</option>
    <option value="1987">1987</option>
    <option value="1988">1988</option>
    <option value="1989">1989</option>
    <option value="1990">1990</option>
    <option value="1991">1991</option>
    <option value="1992">1992</option>
    <option value="1993">1993</option>
    <option value="1994">1994</option>
    <option value="1995">1995</option>
    <option value="1996">1996</option>
    <option value="1997">1997</option>
    <option value="1998">1998</option>
    <option value="1999">1999</option>
    <option value="2000">2000</option>
    <option value="2001">2001</option>
    <option value="2002">2002</option>
    <option value="2003">2003</option>
    <option value="2004">2004</option>
    <option value="2005">2005</option>
    <option value="2006">2006</option>
    <option value="2007">2007</option>
    <option value="2008">2008</option>
    <option value="2009">2009</option>
    <option value="2010">2010</option>
    <option value="2011">2011</option>
    <option value="2012">2012</option>
    <option value="2013">2013</option>
    <option value="2014">2014</option>
    <option value="2015">2015</option>
    <option value="2016">2016</option>
    <option value="2017">2017</option>
    <option value="2018">2018</option>
    <option value="2019">2019</option>
    <option value="2020">2020</option>
    <option value="2021">2021</option>
    <option value="2022">2022</option>
    <option value="2023">2023</option>
    <option value="2024">2024</option>
    <option value="2025">2025</option>
    <option value="2026">2026</option>
    <option value="2027">2027</option>
    <option value="2028">2028</option>
    <option value="2029">2029</option>
    <option value="2030">2030</option>
    <option value="2031">2031</option>
    <option value="2032">2032</option>
    <option value="2033">2033</option>
    <option value="2034">2034</option>
  </select>

	
</form>

<%=DecorateBottom()%>
<!-- End of Site content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
