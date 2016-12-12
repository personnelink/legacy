<%option explicit%>
<%
session("add_css") = "./searchForm.asp.css"
session("required_user_level") = 4096 'userLevelPPlusStaff


dim searchCatalog
searchCatalog = Request.QueryString("searchCatalog")
select case searchCatalog
	case "NetDocs"
		session("window_page_title")	= "Search Net_Docs - Personnel Plus"
	
	case "resumes"
		session("window_page_title")	= "Search Resumes - Personnel Plus"

	case "HowTos"
		session("window_page_title") = "Search How-To's - Personnel Plus"
	
	case else
		searchCatalog = "NetDocs"
		session("window_page_title")	= "Search Net_Doc - Personnel Pluss"
end select

%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->
<script type="text/javascript" src="searchForm.js"></script>
<% 

dim checkedText : checkedText = "checked=""checked"""

dim whichCompany
whichCompany = Request.QueryString("whichCompany")
if len(whichCompany) = 0 then
	whichCompany = request.form("whichCompany")
	if len(whichCompany) = 0 then
		whichCompany = session("location")
	end if
end if

dim boise, nampa, twin, burley, pocatello, california, received, other, resume_age
boise = Request.QueryString("boise")
	if len(boise) = 0 then boise = request.Form("boise")
nampa =  Request.QueryString("nampa")
	if len(nampa) = 0 then nampa = request.Form("nampa")
twin = Request.QueryString("twin")
	if len(twin) = 0 then twin = request.Form("twin")
burley = Request.QueryString("burley")
	if len(burley) = 0 then burley = request.Form("burley")
pocatello = Request.QueryString("pocatello")
	if len(pocatello) = 0 then pocatello = request.Form("pocatello")
california = Request.QueryString("california")
	if len(california) = 0 then california = request.Form("california")
received = Request.QueryString("received")
	if len(received) = 0 then received = request.Form("received")
	
	
	
	
other = Request.QueryString("other")
	if len(other) = 0 then other = request.Form("other")
resume_age = Request.QueryString("resume_age")
	if len(resume_age) = 0 then resume_age = request.Form("resume_age")
	
if len( boise & nampa & twin & burley & pocatello & california & received & other ) = 0 then 'init option if all are empty
	select case lcase(whichCompany)
	case "bur"
		if len(burley) = 0 then burley = "checked"
		'if len(pocatello) = 0 then pocatello = "checked"
		if len(received) = 0 then received = "checked"
	case "poc"
		if len(pocatello) = 0 then pocatello = "checked"
		if len(received) = 0 then received = "checked"
	case "boi"
		if len(boise) = 0 then boise = "checked"
		if len(nampa) = 0 then nampa = "checked"
		if len(received) = 0 then received = "checked"
	case "per"
		if len(twin) = 0 then twin = "checked"
		if len(received) = 0 then received = "checked"
	case else
		if len(other) = 0 then other = "checked"
		if len(california) = 0 then california = "checked"
	end select
	
	if len(resume_age) = 0 then resume_age = "week"
end if

dim the_query
the_query = Request.QueryString("query")

%>

<%=decorateTop("", "notToShort marLR10", "Search")%>
<form method="GET" action="" name="frmSearch" id="frmSearch">
<div id="searchGuide">
Include:
<ul class="guide">
<li class="label_checkbox_pair"><input type="checkbox" name="boise" value="checked" <%if boise = "checked" then Response.write(checkedText)%> />Boise</li>
<li class="label_checkbox_pair"><input type="checkbox" name="nampa" value="checked" <%if nampa = "checked" then Response.write(checkedText)%> />Nampa</li>
<li class="label_checkbox_pair"><input type="checkbox" name="twin" value="checked" <%if twin = "checked" then Response.write(checkedText)%> />Twin Falls</li>
<li class="label_checkbox_pair"><input type="checkbox" name="burley" value="checked" <%if burley = "checked" then Response.write(checkedText)%> />Burley</li>
<li class="label_checkbox_pair"><input type="checkbox" name="pocatello" value="checked" <%if pocatello = "checked" then Response.write(checkedText)%> />Pocatello</li>
<li class="label_checkbox_pair"><input type="checkbox" name="received" value="checked" <%if received = "checked" then Response.write(checkedText)%> />New Received</li>
<li class="label_checkbox_pair"><input type="checkbox" name="california" value="checked" <%if california = "checked" then Response.write(checkedText)%> />California</li>
<li class="label_checkbox_pair"><input type="checkbox" name="other" value="checked" <%if other = "checked" then Response.write(checkedText)%> />Other</li>
</ul>
Include past:
<ul class="guide">
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="week" <%if resume_age = "week" then Response.write(checkedText)%>/>1 week</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="twoweeks" <%if resume_age = "twoweeks" then Response.write(checkedText)%>/>2 weeks</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="month" <%if resume_age = "month" then Response.write(checkedText)%>/>1 month</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="threemonth" <%if resume_age = "threemonth" then Response.write(checkedText)%>/>3 months</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="sixmonth" <%if resume_age = "sixmonth" then Response.write(checkedText)%>/>6 months</li>
<li class="label_checkbox_pair"><input type="radio" name="resume_age" value="all" <%if resume_age = "all" then Response.write(checkedText)%>/>{all}</li>
</ul></div>
<div id="mainSearch">
<div id="sInput">
 <p style="margin:0; padding:0; text-align:left;">Search:</p>
  <div id="search_wrapper">
  <p>
    <input type="text" maxlength="255" name="query" id="query" size="35" value='<%=the_query%>'>
	<input type="submit" value="Search" name="B1" class="hide">
  </p>
  <div class="searchButton"><a class="squarebutton" href="#" style="float:none" onclick="javascript:document.frmSearch.submit();"><span style="text-align:center"> Search </span></a></div>
</div>

      <ul id="search_which">
      <li>
          <label for="netdocs"><input id="netdocs" name="searchCatalog" class="" type="radio" value="NetDocs" <%if searchCatalog = "NetDocs" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
          Documents</label></li>
      <li>
         <label for="howto"><input id="howto" name="searchCatalog" class="" type="radio" value="HowTos" <%if searchCatalog = "HowTos" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
          How-To's</label></li>
      <li>
         <label for="resumes"><input id="resumes" name="searchCatalog" class="" type="radio" value="Resumes" <%if searchCatalog = "resumes" then Response.write("checked=" & Chr(34) & "checked" & Chr(34)) %> >
          Resumes</label></li>
    </ul>
  <input name="action" type="hidden" value="" />
  </div>
  	
  
<script type="text/javascript"><!-- 
						document.frmSearch.query.focus()
							//--></script>
	<%
	
	dim search_results
	Set search_results = Server.CreateObject("MSXML2.ServerXMLHTTP")
	search_results.Open "GET", searchURL & "/include/system/tools/search/searchForm.do.asp?" & request.ServerVariables("QUERY_STRING"), false
	search_results.Send
	Response.write search_results.responseText
	Set search_results = Nothing

%>

</form>
<%=decorateBottom()%>
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
