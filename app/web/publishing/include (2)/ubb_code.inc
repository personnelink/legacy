<script  language="JavaScript">
<!-- 
//funzione per  aggiungere i tag grassetto, sottolineato e corsivo
function AddMessageCode(code, promptText, InsertText) {

	if (code != "") {
			insertCode = prompt(promptText + "\n[" + code + "]xxx[/" + code + "]", InsertText);
				if ((insertCode != null) && (insertCode != "")){
					document.formblog.blog_testo.value += "[" + code + "]" + insertCode + "[/" + code + "]";
				}
	}
				
	document.formblog.blog_testo.focus();
}

// Funzione per modificare carattere, colore e dimensione del testo
function FontCode(code) {

	if (code != "") {
			insertCode = prompt("<% = strLangAddCodeFont %>" + code + "\n[" + code + "]xxx[/FONT]", '');
				if ((insertCode != null) && (insertCode != "")){
					document.formblog.blog_testo.value += "[" + code + "]" + insertCode + "[/FONT]";
				}
	}	
	document.formblog.blog_testo.focus();
}


//Funzione per aggiungere url, email, immagine ed elenco
function AddCode(code) {

	//per url
	if ((code != "") && (code == "URL")) {
		insertText = prompt("<% = strLangAddCodeURL1 %>", "");
			
			if ((insertText != null) && (insertText != "") && (code == "URL")){
				insertCode = prompt("<% = strLangAddCodeURL2 %>", "http://");
					
					if ((insertCode != null) && (insertCode != "") && (insertCode != "http://")){					
						document.formblog.blog_testo.value += "[" + code + "=" + insertCode + "]" + insertText + "[/" + code + "]";
					}
			}
	}
	
	
	//per email
	if ((code != "") && (code == "EMAIL")) {
		insertText = prompt("<% = strLangAddCodeEMAIL1 %>", "");
			
			if ((insertText != null) && (insertText != "")){
				insertCode = prompt("<% = strLangAddCodeEMAIL2 %>", "");
					
					if ((insertCode != null) && (insertCode != "")){					
					document.formblog.blog_testo.value += "[" + code + "=" + insertCode + "]" + insertText + "[/" + code + "]";
				}
			}
	}
	
	//per immagine
	if ((code != "") && (code == "IMG")) {	
		insertCode = prompt("<% = strLangAddCodeIMG %>", "http://");
					
			if ((insertCode != null) && (insertCode != "") && (insertCode != "http://")){					
			document.formblog.blog_testo.value += "[" + code + "]" + insertCode + "[/" + code + "]";
		}			
	}
	
	//per elenco
	if ((code != "") && (code == "LIST")) {
			listType = prompt("<% = strLangAddCodeLIST1 %>", "");
			
			while ((listType != null) && (listType != "") && (listType != "1")) {
				listType = prompt("<% = strLangAddCodeLIST2 %>","");               
			}
			
			if (listType != null) {			
				var listItem = "1";
				var insertCode = "";
				
				while ((listItem != "") && (listItem != null)) {
					listItem = prompt("<% = strLangAddCodeLIST3 %>",""); 
					if (listItem != "") {             
						insertCode += "[LI]" + listItem + "[/LI]"; 
					}                   
				} 
				
				if (listType == "") {
					document.formblog.blog_testo.value += "[" + code + "]" + insertCode + "[/" + code + "]";
				} else {
					document.formblog.blog_testo.value += "[" + code + "=" + listType + "]" + insertCode + "[/" + code + "=" + listType + "]";
				} 
				
			}
	}

	document.formblog.blog_testo.focus();
}
//-->
</script>
