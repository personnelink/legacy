<%
session("add_css") = "./build_class.asp.css"
session("page_title") = "Build Class (Form)"
session("no-auth") = false
session("window_page_title") = "Build Class (Form)"

dim vbClassTemplate
	vbClassTemplate = "" &_
		
	"<label for=""%att%"" name=""%att%Lbl"" id=""%att%Lbl"">" & vbCrLf &_
	"<input name=""%att%"" id=""%att%"" value=""&lt%=getFieldValue(""%att%"")%&gt"" />" & vbCrLf &_
	"</label>" & vbCrLf &_
	vbCrLf

	dim attributes
		attributes = split(replace(replace(replace(request.form("attributes"), vbCrLf, ""), "	", ""), ".", "_"), ",")
	
	dim loadtemplate
	loadtemplate = "					'.%att%       = p_RS.fields(""%att%"").value '%att%" & vbCrLf

	dim attrib, properties, declarations, loadline 
	for attrib = 0 to ubound(attributes)

		properties = properties &_
			replace(vbClassTemplate, "%att%", trim(attributes(attrib)))
			
		declarations = declarations &_
			"private m_" & trim(attributes(attrib)) & vbCrLf
		
		loadline = loadline &_
			replace(loadtemplate, "%att%",  trim(attributes(attrib)))
	
	next
	
	dim functions
	functions = "" & vbCrLf & vbCrLf &_
		"'#############  Public Functions ##############" & vbCrLf & vbCrLf &_
		"public function getFieldValue(p_field)" & vbCrLf & vbCrLf &_
		"	dim p_value" & vbCrLf &_
		"	p_value = request.form(p_field)" & vbCrLf &_
		"	if vartype(p_value) = 0 then " & vbCrLf &_
		"		p_value = request.querystring(p_field)" & vbCrLf &_
		"	end if" & vbCrLf &_
		"" & vbCrLf &_
		"	getFieldValue = p_value" & vbCrLf &_
		"end function"
	
		
		
		
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<form method="post" id="builderFrm" name="builderFrm">
<label  style="width:95%; text-align:left;float:left;clear:both;" for="attributes">attributes (sperate with comma)</label>
<textarea style="width:95%;height:30em;margin:1em;clear:both;float:left;" id="attributes" name="attributes"><%=request.form("attributes")%></textarea>
	<span class="button left marLRB10" onclick="document.builderFrm.submit();" style="">
	<span>
	<a href="#" style="color:#fff">Build Class</a>
	</span></span>

<label  style="width:95%;text-align:left;clear:both;float:left;" for="declarations">declarations:</label>
<textarea  style="width:95%;height:30em;margin:1em;clear:both;float:left;" id="declarations" name="declarations"><%=declarations & properties & functions%></textarea>

	<span class="button left marLRB10" onclick="document.builderFrm.submit();" style="">
	<span>
	<a href="#" style="color:#fff">Build Class</a>
	</span></span>

</form>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->