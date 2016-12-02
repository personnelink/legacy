<% If strMode="new" and Ublogtype="open" Then %>
<!--#include file="include/ubb_code.inc" -->
<% Else %>
<!--#include file="include/html_code.inc" -->
<% End If %>
<script  language="JavaScript">
<!-- 
function CheckForm(){
if (document.formblog.blog_autore.value==""){
alert("<% = strLangCheckAuthor %>");
return false;
}
if (document.formblog.email.value!=""){
		if (document.formblog.email.value.indexOf("@")==-1){
			alert("<% = strLangCheckEmail %>");
			return false;
		}	
	    if (document.formblog.email.value.indexOf(".")==-1){
			alert("<% = strLangCheckEmail %>");
			return false;
		}	
	}
if (document.formblog.blog_titolo.value==""){
alert("<% = strLangCheckTitle %>");
return false;
}
if (document.formblog.blog_testo.value==""){
alert("<% = strLangCheckText %>");
return false;
}
return true;
}

// preview blog
function OpenPreviewWindow(){

	Autore = escape(document.formblog.blog_autore.value);
	Titolo = escape(document.formblog.blog_titolo.value);
	Testo = escape(document.formblog.blog_testo.value);
	Modo = escape(document.formblog.strMode.value);
	Data = escape(document.formblog.data.value);
	Ora = escape(document.formblog.ora.value);
	document.cookie = "Blog_Autore=" + Autore
	document.cookie = "Blog_Titolo=" + Titolo
   	document.cookie = "Blog_Testo=" + Testo
   	document.cookie = "Blog_Modo=" + Modo
   	document.cookie = "Blog_Data=" + Data
   	document.cookie = "Blog_Ora=" + Ora
	
   	openWin('blog_preview.asp','preview','toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=300')
}

function openWin(theURL,winName,features) {
  	window.open(theURL,winName,features);
}

// rollover	
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}


function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<form method=post name="formblog" action="add_blog.asp" onSubmit="return CheckForm();" onReset="return confirm('<% = strLangCheckResetForm %>');">
        <table width="85%" border="0" cellspacing="1" cellpadding="4" align="center" class="tablemenu">
          <tr> 
                        
            <td colspan="2" align="center"><font class="green"><b>
			<% if strMode = "new" then %>
        <% = UCase(strLangFormAddBlog) %> 
			<% else %>
         <% = UCase(strLangNavEditBlog) %> </b></font> 
			<% end if %>
			
			</td>
                      </tr>
					    <tr> 
                        <td colspan="2"><div class="hrarancio"><img src="immagini/spacer.gif"></div></td>
                      </tr>
                      <tr align="left"> 
      <td colspan="2"><% = strLangFormRequiredFields %></td>
                      </tr>
                <tr> 
      <td align="right" width="20%"  height="31"><% = strLangFormAuthor %> (*) :</td>
                  <td width="80%"  height="31"> 
                    <input type="text" name="blog_autore" size="25" maxlength="50" class="form" value="<% = blog_autore %>">
                  </td>
                </tr>
                <tr> 
      <td align="right" width="20%"  height="31"><% = strLangFormEmail %> :</td>
                  <td width="80%" height="31"> 
                    <input type="text" name="email" size="25" maxlength="50" class="form" value="<% = email %>">
                  </td>
                </tr>
                <tr> 
      <td align="right" width="20%"><% = strLangFormTitle %> (*) :</td>
                  <td width="80%"> 
                    <input type="text" name="blog_titolo" size="25" maxlength="80" class="form" value="<% = blog_titolo %>">
                  </td>
                </tr>
    <tr> 
      <td align="right"><% = strLangFormFormat %> :</td>
      <td width="80%"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td>
	  	<select	name="selectFont" onChange="FontCode(selectFont.options[selectFont.selectedIndex].value);document.formblog.selectFont.options[0].selected = true;" class="form">
		 <option selected>-- <% = strLangFormatChar %> --</option>
		 <option value="FONT FACE=Arial">Arial</option>
		 <option value="FONT FACE=Courier">Courier New</option>
		 <option value="FONT FACE=Times">Times New Roman</option>
		 <option value="FONT FACE=Verdana">Verdana</option>
		</select>
	   <select name="selectColour" onChange="FontCode(selectColour.options[selectColour.selectedIndex].value);document.formblog.selectColour.options[0].selected = true;" class="form">
         <option value="0" selected>-- <% = strLangFormatColor %> --</option>
         <option value="FONT COLOR=BLACK"><% = strLangFormatBLACK %></option>
         <option value="FONT COLOR=WHITE"><% = strLangFormatWHITE %></option>
         <option value="FONT COLOR=BLUE"><% = strLangFormatBLUE %></option>
         <option value="FONT COLOR=RED"><% = strLangFormatRED %></option>
         <option value="FONT COLOR=ORANGE"><% = strLangFormatORANGE %></option>
         <option value="FONT COLOR=GREEN"><% = strLangFormatGREEN %></option>
         <option value="FONT COLOR=YELLOW"><% = strLangFormatYELLOW %></option>
         <option value="FONT COLOR=GRAY"><% = strLangFormatGRAY %></option>
        </select> 
		<select	name="selectSize" onChange="FontCode(selectSize.options[selectSize.selectedIndex].value);document.formblog.selectSize.options[0].selected = true;" class="form" >
		 <option selected>-- <% = strLangFormatSize %> --</option>
		 <option value="FONT SIZE=1">1</option>
		 <option value="FONT SIZE=2">2</option>
		 <option value="FONT SIZE=3">3</option>
		 <option value="FONT SIZE=4">4</option>
		 <option value="FONT SIZE=5">5</option>
		 <option value="FONT SIZE=6">6</option>
		</select>
             </td>
          </tr>
        </table>	  
	  </td>
    </tr>
                <tr> 
                  <td  align="right"  width="20%">&nbsp;</td>
                  <td width="80%" > 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
            <td width="80%"> <a href="JavaScript:AddMessageCode('B','<% = strLangAddCodeB %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','immagini/bolddown.gif',1)"><img name="Image1" border="0" src="immagini/boldup.gif" alt="<% = strLangAltAddCodeB %>" align="absmiddle"></a> 
              <a href="JavaScript:AddMessageCode('I','<% = strLangAddCodeI %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','immagini/italicdown.gif',1)"><img name="Image2" border="0" src="immagini/italicup.gif" alt="<% = strLangAltAddCodeI %>" align="absmiddle"></a> 
              <a href="JavaScript:AddMessageCode('U','<% = strLangAddCodeU %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','immagini/underdown.gif',1)"><img name="Image3" border="0" src="immagini/underup.gif" alt="<% = strLangAltAddCodeU %>" align="absmiddle"></a> 
              <a href="JavaScript:AddCode('URL')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','immagini/linkdown.gif',1)"><img name="Image5" border="0" src="immagini/linkup.gif" alt="<% = strLangAltAddCodeURL %>" align="absmiddle"></a> 
              <a href="JavaScript:AddCode('EMAIL')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','immagini/emaildown.gif',1)"><img name="Image9" border="0" src="immagini/emailup.gif" alt="<% = strLangAltAddCodeEMAIL %>" align="absmiddle"></a> 
              <a href="JavaScript:AddMessageCode('CENTER','<% = strLangAddCodeC %>', '')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','immagini/centradown.gif',1)"><img name="Image6" border="0" src="immagini/centraup.gif" alt="<% = strLangAltAddCodeC %>" align="absmiddle"></a> 
              <a href="JavaScript:AddCode('LIST')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','immagini/elencoordinatodown.gif',1)"><img name="Image8" border="0" src="immagini/elencoordinatoup.gif" alt="<% = strLangAltAddCodeLIST %>" align="absmiddle"></a> 
              <a href="JavaScript:AddCode('IMG')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','immagini/Imagedown.gif',1)"><img name="Image7" border="0" src="immagini/Imageup.gif" alt="<% = strLangAltAddCodeIMG %>" align="absmiddle"></a> 
              <a href="javascript:openWin('upload_image.asp?strMode=<%=strMode%>','images','toolbar=0,location=0,status=0,menubar=0,scrollbars=0,resizable=0,width=400,height=330')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','immagini/Imageuploaddown.gif',1)"><img src="immagini/Imageuploadup.gif" alt="<% = strLangAltAddCodeUploadIMG %>" name="Image12" border="0" align="absmiddle"></a> 
             </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
      <td valign="top" align="right"  width="20%"><% = strLangFormText %> (*) : <br> <br> <br> 
        <% If strMode="new" and Ublogtype="open" Then %>
        <font class="arancio"><strike>html code</strike></font><br> <br>
		 <font class="green">ubb code</font>
		 <% Else %>
        <font class="green">html code</font><br> <br> 
        <font class="arancio"><strike>ubb code</strike></font> 
        <% End if %>
        <br> <br> </td>
                  <td  width="80%" valign="top"> 
                    <textarea name="blog_testo" cols="55" rows="10" class="form"><% = blog_testo %></textarea>
                  </td>
                </tr>
                <tr> 
                  <td valign="top" align="right">&nbsp;</td>
                  <td height="2" align="left"><input name="comments" type="checkbox" value="True"<% If blnComments = True Then Response.Write(" checked") %>>
       <% = strLangFormLeave %></td>
                </tr>
                <tr> 
                  <td valign="top" align="right" >&nbsp;</td>
                  <td align="left">&nbsp; </td>
                </tr>
                <tr> 
                  <td valign="top" align="right" width="20%" >
                    <input type="hidden" name="strMode" value="<% = strMode %>">
                    <input type="hidden" name="blog_id" value="<% = blog_id %>">
				    <input type="hidden" name="data" value="<% = data %>">
					<input type="hidden" name="ora" value="<% = ora %>">
				    <input type="hidden" name="giorno" value="<% = giorno %>">
					<input type="hidden" name="mese" value="<% = mese %>">
					<input type="hidden" name="anno" value="<% = anno %>">
                    &nbsp; </td>
                  <td width="80%" align="left"> 
        <input type="button" name="Preview" value="<% = strLangFormPreviewBlog %>" onClick="OpenPreviewWindow()" class="form" > 
				    <% If strMode="edit" Then %>
        <input type="submit" name="Submit" value="<% = LCase(strLangNavEditBlog) %>" class="form"> 
                    <% Else %>
        <input type="submit" name="Submit" value="<% = strLangFormAddBlog %>" class="form"> 
        <input type="reset" name="Reset" value="<% = strLangFormReset %>" class="form"> </td>
                    <% End If %>
                  </td>
                </tr>
              </table>
</form>