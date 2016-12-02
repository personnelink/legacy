<%
session("add_css") = "./build_class.asp.css"
session("page_title") = "Build Class"
session("no-auth") = false
session("window_page_title") = "Build Class"

dim vbClassTemplate
	vbClassTemplate = "" &_
		
	"public property get %att%()" & vbCrLf &_
	"	%att% = m_%att%" & vbCrLf &_
	"end property" & vbCrLf &_
	"public property let %att%(p_%att%)" & vbCrLf &_
	"	m_%att% = p_%att%" & vbCrLf &_
	"end property" & vbCrLf &_
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
		"		'#############  Public Functions ##############" & vbCrLf & vbCrLf &_
		"		public function LoadSomething()" & vbCrLf & vbCrLf &_
		"				LoadSomething = LoadData (strSQL)" & vbCrLf &_
		"		end function" & vbCrLf &_
		"			'#############  Private Functions ##############" & vbCrLf &_
		"		'Takes a recordset" & vbCrLf &_
		"		'Fills the object's properties using the recordset" & vbCrLf &_
		"		private function FillFromRS(p_RS)" & vbCrLf &_
		"			'p_RS.PageSize = m_ItemsPerPage" & vbCrLf &_
		"			p_RS.PageSize = 1" & vbCrLf &_
		"			dim m_PageCount" & vbCrLf &_
		"			m_PageCount = p_RS.PageCount" & vbCrLf & vbCrLf &_
		"			dim m_Page" & vbCrLf &_
		"			if m_Page < 1 Or m_Page > m_PageCount then" & vbCrLf &_
		"				m_Page = 1" & vbCrLf &_
		"			end if" & vbCrLf & vbCrLf &_
		"			if not p_RS.eof then p_RS.AbsolutePage = m_Page" & vbCrLf & vbCrLf &_
		"			dim thisOrderTab, id" & vbCrLf &_
		"			if not ( p_RS.eof Or p_RS.AbsolutePage <> m_Page ) then" & vbCrLf &_
		"				with me" & vbCrLf & vbCrLf &_
							loadline & vbCrLf &_
		"				end with" & vbCrLf &_
		"			end if" & vbCrLf &_
		"		End Function" & vbCrLf & vbCrLf &_
		"		Private Function LoadData(p_strSQL)" & vbCrLf &_
		"			dim rs" & vbCrLf &_
		"			if isnumeric(me.Site) then" & vbCrLf &_
		"				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(me.Site))" & vbCrLf &_
		"			else" & vbCrLf &_
		"				set rs = GetRSfromDB(p_strSQL, dsnLessTemps(getCompanyNumber(me.Site)))" & vbCrLf &_
		"			end if" & vbCrLf &_
		"			FillFromRS(rs)" & vbCrLf &_
		"			LoadData = rs.recordcount" & vbCrLf &_
		"			rs. close" & vbCrLf &_
		"			set rs = nothing" & vbCrLf &_
		"		End Function" & vbCrLf & vbCrLf & vbCrLf & vbCrLf &_
		"		end class"
	
		
		
		
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