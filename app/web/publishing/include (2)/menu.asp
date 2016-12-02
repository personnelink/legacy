  <tr> 
    <td><% = strLangSelectLanguage %>&nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;
	   <a href="lang.asp?lang=italian"><img src="immagini/italian.gif"  border="0" alt="<% = strLangSelectLanguageIt %>" align="absmiddle"></a>&nbsp; 
       <a href="lang.asp?lang=english"><img src="immagini/english.gif" border="0" alt="<% = strLangSelectLanguageEn %>" align="absmiddle"></a> 
	   <font class="green"> | </font><a href="index.asp?archivio=OK"><% = strLangSelectArchives %></a> 
      <% if Ublogtype = "open" then %>
      <font class="green"> | </font><a href="newblog.asp"><% = strLangSelectNewBlog %></a> 
      <% end if %>
     </td>
    <td align="right"> 
      <% = strLangSelectAdminSection %>&nbsp;<img src="immagini/freccia.gif"><img src="immagini/freccia.gif">&nbsp;&nbsp;
	   <% If Ublogtype = "closed" then %>
	  <a href="newblog.asp"><% = strLangSelectNewBlog %></a><font class="green"> | </font> 
	  <% end if %>
	  <a href="editallblog.asp"><% = strLangSelectEditDeleteBlog %></a> <font class="green"> | </font> <a href="configura.asp"><% = strLangSelectConfigBlog %></a>&nbsp; 
      <% if Session("admin") = True then%>
      <font class="green"> | </font> <a href="logout.asp"><% = strLangSelectLogout %></a>&nbsp; 
      <% end if %>
    </td>
  </tr>
