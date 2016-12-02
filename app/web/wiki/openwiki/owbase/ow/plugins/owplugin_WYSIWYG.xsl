<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" xmlns="http://www.w3.org/1999/xhtml" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
	<xsl:template name="ow:wysiwyg">
		<script language="javascript" type="text/javascript" charset="{@encoding}">
			<xsl:text disable-output-escaping="yes">

&lt;!--
							
// Useful references
//
		


// Global Variables -- please declare all variables!!!
var sel, str, count, fArr, W3CDOM;
		
//
// **********************************************************************************
//
// Utility functions
//
// ***********************************************************************************
//

//
// Function trim(s)
// takes string and returns it with leading and trailing spaces removed
// from http://www.faqts.com/knowledge_base/view.phtml/aid/1678/fid/1
// usage: s = s.trim();

function trimString (str) 
{
	str = this != window? this : str;
  	return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
}

String.prototype.trim = trimString;

//
// function SetEditFocus()
// returns focus to textarea
//
// IE only

function SetEditFocus()
{
        document.frmEdit.text.focus();
}

//
//	 Function setCaretAtEndOfField(field)
// Function to move claret to end of form / textarea
// Added to page load along with SetEditFocus
//
// IE only, need to add code for other browsers
//
// We  need to add code for other browsers so that we have something to pass to pass to this function 
// as the selected range, ie insertAtCursor() returns sel as the selection for IE, how to get the selected area for 
// mozilla?
//

function setCaretAtEndOfField(field) 
{
	// IE code
	if (field.createTextRange) { 
    		var r = field.createTextRange();
	 	r.moveEnd('character', field.value.length);    
	 	r.collapse();
    		r.select();
  	}
}

//
// function setCaretAtEndOfRange(range)
// sets claret at end of textrange, ie after formatting selected text
//
//
// IE only, need to add code for other browsers

function setCaretAtEndOfRange(range)
{
	// IE code
  	if (document.selection) {
   		var r = range;
    		r.collapse(false);
    		r.select();
  	}
}

//
// cross-browser function to insert text into textrange
// see http://www.alexking.org/index.php?content=software/javascript/content.php
// 

function insertAtCursor(myValue) 
{ 
	var myField=document.frmEdit.text;
  	//IE support
   	if (document.selection) {
    		myField.focus();
    		sel = document.selection.createRange();
    		sel.text = myValue;
  	}

	//MOZILLA/NETSCAPE support
  	else if (myField.selectionStart || myField.selectionStart == '0') {
    		var startPos = myField.selectionStart;
    		var endPos = myField.selectionEnd;
		myField.value = myField.value.substring(0, startPos)
        		          + myValue 
	         + myField.value.substring(endPos, myField.value.length);
		sel = '';
		sel.text = myValue;
  	} 
	else {
    		myField.value += myValue;
  	}
}

//  
//   function getSel()
//  Based on code from http://www.quirksmode.org/js/selected.html
//  Cross browser code to get a copy of selected text that it returns as str
//

function getSel()
{
	var ref;
	str = '';
	if (window.getSelection) {
		// Mozilla
		ref = document.getElementById('text');
		str = ref.value.substr(ref.selectionStart, ref.selectionEnd - ref.selectionStart);
	}
	else if (document.selection) {
		// IE
		str = document.selection.createRange().text; 
	}		
	else if (document.getSelection) {
		// older versions of Netscape 
		str  = document.getSelection();
	}
	
	//if (window.getSelection){
	 // Safari - untested
	//str = window.getSelection().text;
	//return str; }
	//else {return;}
	
	//alert("The text you selected is \n'" + str + "'");
	return str;
}



//
// 	Cross browser function to find object that triggered the event
// 	by Danny Goodman 
// 	http://www.oreillynet.com/pub/a/javascript/synd/2001/09/25/event_models.html?page=3
// 

function getTargetElement(evt) 
{
	var elem;
  	if (evt.target) {
		elem = (evt.target.nodeType == 3) ? evt.target.parentNode : evt.target;
  	} else {
    		elem = evt.srcElement;
  	}
	return elem;
}

//
// *****************************************************************
//
// functions to insert wiki markup.
//
// *****************************************************************

//   Gets selection using browser neutral code and returns it as the array v, then pastes the markup around the selection.

function insertWikiMarkup(w)
{
	// alert ("what is w " + typeof(w));
	getSel();

	//   Checks if there any spaces before or after the selection and saves them for later - thank you Gordon.

        var sPre = "", sPost = "";
        if (str.charAt(0) == " ") {
        	sPre = " ";
        }
        if (str.charAt(str.length - 1) == " ") {
                sPost = " ";
        }
               
        //   Removes white space at start or end
        str = str.trim();
     
	// Takes value of drop down, button etc and returns array with either 1 or 2 scraps of wiki markup code
	// with v(0) being the first one and v(1) the second.
	//  
	var v = w.split('+');
	        
	//  Inserts the scraps of wiki markup code around the selection, if one scrap, uses the same scrap on 
	//  both sides, if 2 scraps, uses one either side.
 
	switch (v.length) {
	case 1 :
	  	var txt = sPre + unescape(v[0])  + sPost;
 		insertAtCursor(txt);  	  	  	   	
        	break;

	case 2 :
		var txt = sPre + unescape(v[0]) + str +  unescape(v[1]) + sPost;
        	insertAtCursor(txt);           
        	break;
	default:
	}
}

//
// Function dd_insertcode()
// Inserts code from drop down.
//

function dd_insertcode(w) 
{
	insertWikiMarkup(w);
    	if(sel) setCaretAtEndOfRange(sel);	// sel not defined for non-IE
}
        
//
// Function insert_rss ()
// Inserts RSS feed as entered in a prompt
//

function insert_rss () 
{
	getSel();
        var my_link = prompt("Enter URL:","http://");
        if (my_link != null)    {
        	var v =  '&lt;Syndicate(\"';
                v+= my_link;
                v+= '\",120) /&gt; '
                insertAtCursor(unescape(v));
                // what is sel now?
                setCaretAtEndOfRange(sel);
        }
	return;
}

//
// function insert_link ()
// Inserts url link as entered in a prompt
//

function insert_link () 
{
          getSel();
          var my_link = prompt("Enter URL:","http://");
          if (my_link != null) {
          	var v = "%5B" +  my_link + " " + str + "%5D";
                insertAtCursor(unescape(v));
                setCaretAtEndOfRange(sel);
          }
}
                        
//
// For debugging to generate escaped strings
//
                        
function escape_value() 
{
	getSel();
        var my_link = prompt("Enter string to be escaped:","");
        if (my_link != null)    {
        	insertAtCursor(escape( my_link));
           	setCaretAtEndOfRange(sel);
        }
}
             
// **********************************************************************
//      Capitalise etc
// 
//
// Completed with help from the good people at Experts Exchange, see 
//  http://www.experts-exchange.com/Web/Web_Languages/JavaScript/Q_21189215.html
// 
// **********************************************************************

fArr=new Array('capitalise()','lowercase()','uppercase()');
count=0;
sel = '';

//
// Function capitalise() 
// from various places, function to turn selected text into leading capitals.
//

function capitalise() 
{
  	getSel();
	if (!str.length) {return;}
	str=str.toLowerCase();
	str=str.replace(/\b\w+\b/g, function(word) {
		return word.substring(0,1).toUpperCase()+ word.substring(1);
	});
 	insertAtCursor(str);
}

//
// Function lowercase() 
// function to turn selected text into lowercase.
//

function lowercase() 
{
  	getSel();
	str=str.toLowerCase();
 	insertAtCursor(str);
}

//
// Function uppercase() 
// function to turn selected text into lowercase.
//

function uppercase() 
{
	getSel();
	str=str.toUpperCase();	
 	insertAtCursor(str);
}

//
// This  function cycles through the above functions
//

function doFunctions(obj)
{
	eval(fArr[count%fArr.length]);
	count++;
	obj.value='Function '+fArr[count%fArr.length];
}

//
//  By Michael Meyers
//

function indent_line( s)
{
	var new_s="";
  	if ( s.match(/^\s+$/) ) return s;
  	if ( s.match(/^\s*:|^\s*\*\s|^\s*[0-9]+\.|^\s*[a-z]+\.|^\s*;/) ){
     		new_s = "  " + s;
  	} else{
     		new_s = "  : " + s;
  	}
  	return new_s;
}


function unindent_line( s)
{
	var new_s="";
  	if ( s.match(/^(\s+)/)  ) {
		var len = RegExp.$1.length;

     		if ( len == 1 ) {
       			if( s.match(/^ |^\t/) ) {
         			new_s = new_s = s.substring( 1, s.length );
       			} else {
         			new_s = s;
       			}

     		} 
		else if ( len == 2 ) {
        		new_s = s.substring( 1, s.length );
        	} else {
        		new_s = s.substring( 2, s.length );
     		}
  	} 
	else {
     		new_s = s;
  	}

	return new_s;
}

// Amalgamated functionality here
function dd_formatString(func_ptr)
{
         getSel();
         if ( !str.length ) return;
         if ( str.indexOf( "\n" ) == -1 ){
         	insertAtCursor(func_ptr( str ) + "\n");
         	return;
       	 }

         var new_str = "";
         str += "\n";
         var pos = str.indexOf( "\n" );

         do {
           	new_str += func_ptr(str.substring( 0, ++pos));
           	str = str.substring( pos, str.length );
           	pos = str.indexOf( "\n" );

         } while( pos != -1 );

         // process remainder
         if ( str.length != 0 ) {
         	new_str += func_ptr( str );
         } else {
         	new_str += "\n";
         }

         insertAtCursor(new_str);

	return;
}

function dd_bulletlist()
{
	var func_ptr = bullet_list; 
	dd_formatString(func_ptr);
}

function dd_numberlist()
{
	var func_ptr = number_list; 
	dd_formatString(func_ptr);
}

function dd_indent()
{
	var func_ptr = indent_line; 
	dd_formatString(func_ptr);
}

function dd_unindent()
{
	var func_ptr = unindent_line;
	dd_formatString(func_ptr);
}

// re-clicking button cycles through styles 1. -> a. ->  1.  ect...
function number_list( s) 
{
	var new_s="", len;
  	if ( s.match(/^(\s+):/) ){
  		len = RegExp.$1.length;
     		new_s = RegExp.$1 + "1." + s.substring( len + 1 , s.length );
  	} else if( s.match(/^(\s+)\*\s/) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "1." + s.substring( len + 1 , s.length );
  	} else if( s.match(/^(\s+)([0-9]+)\./) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "a" + s.substring( len + RegExp.$2.length , s.length );
  	} else if( s.match(/^(\s+)([a-z]+)\./) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "1" + s.substring( len + RegExp.$2.length , s.length );
  	} else if( s.match(/^(\s+);/) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "1." + s.substring( len + 1 , s.length );
  	} else{
     		new_s = "  1. " + s;
  	}

  	return new_s;
}

function bullet_list(s)
{
	var new_s="", len;
  	if ( s.match(/^(\s+):/) ){
        	len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "*" + s.substring( len + 1 , s.length );
  	} else if( s.match(/^(\s+)\*\s/) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "*" + s.substring( len + 1 , s.length );
  	} else if( s.match(/^(\s+)([0-9]+\.#?[0-9]*)/) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "*" + s.substring( len +  RegExp.$2.length, s.length );
  	} else if( s.match(/^(\s+)([a-z]+\.#?[0-9]*)/) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "*" + s.substring( len + RegExp.$2.length, s.length );
  	} else if( s.match(/^(\s+);/) ){
     		len = RegExp.$1.length ;
     		new_s = RegExp.$1 + "*" + s.substring( len + 1 , s.length );
  	} else {
     		new_s = "  * " + s;
  	}

	return (sel.text = new_s);
}


// **********************************************************************
//
// Adding  functions to animate the buttons and for selects
//
// **********************************************************************
function triggerEvent(evt)
{
	evt = (evt) ? evt : ((window.event) ? window.event : "");
  	if (evt) {
    		return getTargetElement(evt);
  	}
}

function mouseover(evt) 
{
	var elem = triggerEvent(evt);
	if(elem) elem.className = "raised";
}

function mouseout(evt) 
{
	var elem = triggerEvent(evt);
	if(elem) elem.className = "button";
}


function mousedown(evt) 
{
	var elem = triggerEvent(evt);
	if(elem) elem.className = "pressed";
}

function mouseup(evt) 
{
	var elem = triggerEvent(evt);
	if(elem) elem.className = "raised";
}

function select_click(evt) 
{
	var elem = triggerEvent(evt);
    	if (elem) {
    		dd_insertcode(elem.value);
    		elem.selectedIndex = 0;
    	}
}

function insertWikiMarkup_click(evt) 
{
	var elem = triggerEvent(evt);
	if (elem) {
		insertWikiMarkup(elem.attributes['value'].value);
  	}
}

//  **************************************************************************************
//
// 	Code to add functions etc to HTML
//
//
//
// 	Based on code at http://www.onlinetools.org/articles/unobtrusivejavascript/chapter2.html
// 	TODO: Add usability features back in, ie tab etc
//
//
// **************************************************************************************

//
//	Is the browser DOM compatible?
//
W3CDOM = (document.createElement &#38;&#38; document.getElementsByTagName);

//
//	Adding events the browser compatible way - see 
//	http://www.sitepoint.com/print/behaved-dhtml-case-study
//

function addEvent(objObject, strEventName, fnHandler) 
{ 
	// DOM compliant way to add an event listener 
 	if (objObject.addEventListener) 
   		objObject.addEventListener(strEventName, fnHandler, false); 
 	// IE windows way to add an event listener 
 	else if (objObject.attachEvent) 
   		objObject.attachEvent("on" + strEventName, fnHandler); 
}

//
//
//  DOM neutral way  to get reference to event object 
// 	http://www.sitepoint.com/print/behaved-dhtml-case-study
//  	Not used yet, see getTargetElement()  instead.
//

function getEventSrc(e) 
{ 
	// get a reference to the IE/windows event object 
 	if (!e) e = window.event; 
 	// DOM-compliant name of event source property 
 	if (e.target) 
   		return e. target; 
 	// IE windows name of event source property 
 	else if (e.srcElement) 
   		return e.srcElement; 
}

function addimgfunctions()
{
	if (!W3CDOM) return;
	var imgs,i;
	imgs=document.getElementsByTagName('img');
	for(i in imgs) {
		if(/button/.test(imgs[i].className)) { 
			// get all buttons with button class
			// add mouseover etc functions using add Event
			addEvent(imgs[ i], "mouseover", mouseover);
			addEvent(imgs[ i], "mouseout", mouseout);
			addEvent(imgs[ i], "mousedown", mousedown);
			addEvent(imgs[ i], "mouseup", mouseup);
		}
		if(/wikimarkup/.test(imgs[i].className)) {
			addEvent(imgs[ i], "mousedown", insertWikiMarkup_click);
			//imgs[ i].onclick = function(){insertWikiMarkup(this.value);};
			//var event = getTargetElement(evt);
			//imgs[ i].onclick = function(){insertWikiMarkup(event.value);};
		}
		if(/rss/.test(imgs[i].id)) {
			imgs[ i].onclick = function(){insert_rss();};
		}
		if(/link/.test(imgs[i].id)) {
			imgs[ i].onclick = function(){insert_link();};
		}
	}
}

function addselectfunctions()
{
	if (!W3CDOM) return;
	var selects, i;
	selects=document.getElementsByTagName('select');
 	for(i in selects){
		if(/select/.test(selects[i].className)){
			addEvent(selects[ i], "change", select_click);				 }
		}
	}
//
// 	addLoadEvent(func)
// 	By Simon Willson
// 	at http://simon.incutio.com/archive/2004/05/26/addLoadEvent
// 	to add more than one function to window.onload
// 	
//

function addLoadEvent(func) 
{
	var oldonload = window.onload;
	if (typeof window.onload != 'function') {
    		window.onload = func;
  	} else {
    		window.onload = function() {
      			oldonload();
      			func();
   		}
  	}
}

/*
function fixseltext()
{
	var x=document.getElementsByTagName('textarea');
	var y=window.getSelection();
	var z=x.length;
	for (var i in z){
		x[i].childNodes[0].nodeValue=x[i].value;
		x[i].onselect=function(){
			var temp=document.createRange();
			temp.setStart(this.childNodes[0],this.selectionStart);
			temp.setEnd(this.childNodes[0],this.selectionEnd);
			y.addRange(temp);
		}
	}
	return;
}
*/

// 	end fixseltext
//	this is to fix the fact that if you select something in a textarea, this not added to the window.getSelection() collection
//	also, there is no 'connection' between .selectionStart .selectionEnd .setSelectionRange() for textarea's and the
// 	window.getSelection() collection
//	See comments at: http://bugzilla.mozilla.org/show_bug.cgi?id=85686#c18 

addLoadEvent(addimgfunctions);
addLoadEvent(addselectfunctions);
addLoadEvent(SetEditFocus);

/*
if (window.getSelection)
{
	addLoadEvent(fixseltext);
}
*/
//alert(typeof(theRange));
//setCaretAtEndOfField(document.frmEdit.text);
//alert(typeof(theRange));


//--&gt;</xsl:text>
		</script>
		<div id="toolbar">
			<div id="interwikicolour" class="toolbarWrapper">
				<div class="toolbarBody">
					<span class="handle">
						<xsl:text> </xsl:text>
					</span>
					<select class="select" name="interwikis" id="interwikis" tabindex="1">
						<option value="">InterWiki</option>
						<option value="Acronym:">Acronym</option>
						<option value="Artist:">Artist</option>
						<option value="TechTerms:">TechTerms</option>
						<option value="Google:">Google</option>
						<option value="Whois:">Whois</option>
					</select>
					<span class="separator">
						<xsl:text> </xsl:text>
					</span>
					<select class="select" name="fcolor" id="fcolor">
						<option value="0">Colour</option>
						<option value="%7BR%7D+%7B/R%7D" class="redtext">Red</option>
						<option value="%7BDR%7D+%7B/DR%7D" class="darkredtext">DarkRed</option>
						<option value="%7BG%7D+%7B/G%7D" class="greentext">Green</option>
						<option value="%7BDG%7D+%7B/DG%7D" class="darkgreentext">DarkGreen</option>
						<option value="%7BB%7D+%7B/B%7D" class="bluetext">Blue</option>
						<option value="%7BDB%7D+%7B/DB%7D" class="darkbluetext">DarkBlue</option>
						<option value="%7BMP%7D+%7B/MP%7D" class="markerpentext">MarkerPen</option>
					</select>
					<span class="handle">
						<xsl:text> </xsl:text>
					</span>
				</div>
			</div>
			<div class="toolbarWrapper" id="macrosformat">
				<div class="toolbarBody">
					<span class="handle">
						<xsl:text> </xsl:text>
					</span>
					<select class="select" name="macros" id="macros" tabindex="1">
						<option value="">Macro's etc</option>
						<optgroup label="Common" class="contrast1">
							<option value="%7BR%7DComment added #NOW by #USER:%7B/R%7D ">Comment added (datetime) by (user):</option>
							<option value="%3CAnchor(+)/%3E">Anchor</option>
							<option value="%3CInclude(+)/%3E">Include page</option>
							<option value="%3CTableOfContents(1)/%3E">Table of contents</option>
							<option value="@this ">@this</option>
						</optgroup>
						<optgroup label="Search" class="contrast2">
							<option value="%3CTitleSearch(+)/%3E">Search - page title</option>
              <option value="%3CFullSearch(&quot;+&quot;)/%3E">Search - full text</option>
              <option value="%3CTextSearch(+)/%3E">Search - text in pages only</option>
							<option value="%3CSummarySearch(+)/%3E">Search - page summary</option>
              <option value="%3CTagSearch(+)/%3E">Search - tag</option>
              <option value="%3CTitleSearch/%3E">Search - page title (userinput)</option>
              <option value="%3CFullSearch/%3E">Search - full text (userinput)</option>
              <option value="%3CSummarySearch/%3E">Search - page summary (userinput)</option>
              <option value="%3CCategorySearch/%3E">Search - categories (userinput)</option>
              <option value="%3CTagSearch/%3E">Search - tag (userinput)</option>
              <option value="%3CTitleIndex/%3E">List index of page titles</option>
							<option value="%3CCategoryIndex/%3E">List categories</option>
              <option value="%3CGlossary(+)/%3E">Glossary of pages with this words</option>
						</optgroup>
						<optgroup label="Navigation" class="contrast1">
							<option value="%3CAddBookmarks(FirstWikiPage SecondWikiPage,My bookmarks)/%3E">Create bookmarks</option>
							<option value="%3CGoto/%3E">Goto or create new page (userinput)</option>
							<option value="%3CTableOfContents(1)/%3E">Table of contents</option>
							<option value="%3CRandomPage(10)/%3E">Random pages</option>
						</optgroup>
						<optgroup label="Changes/popular" class="contrast2">
							<option value="%3CMostPopularPage/%3E">Most popular page</option>
							<option value="%3CTitleHitIndex(10)/%3E">List  popular pages</option>
							<option value="%3CPageCount/%3E">Page count</option>
							<option value="%3CPageChanged/%3E">Page changed - this page</option>
							<option value="%3CPageChanged(+)/%3E">Page changed - pagename</option>
							<option value="%3CPageHits/%3E">Page hits - this page</option>
							<option value="%3CPageHits(+)/%3E">Page hits - pagename</option>
							<option value="%3CAllPageHits/%3E">All page hits</option>
							<option value="%3CRecentChanges(1)/%3E">Recent changes over last day</option>
							<option value="%3CRecentChangesLong/%3E">Recent changes verbous</option>
							<option value="%3CRecentChangesSearch(+)/%3E">Search  - recent changes</option>
						</optgroup>
						<optgroup label="Date / time" class="contrast1">
							<option value="%3CDate/%3E %3CTime/%3E %3CDateTime/%3E ">Date, Time, Date &#38; Time</option>
							<option value="%3CMonth/%3E">Calender - this month</option>
							<option value="%3CMonth(-1)/%3E">Calender - relative month</option>
							<option value="%3CMonth(1955,11)/%3E">Calender - specific month</option>
						</optgroup>
						<optgroup label="Include other page" class="contrast2">
							<option value="%3CInclude(+)/%3E">Include page from here</option>
							<option value="%3CIncludeOpenWikiPage(http://address of wiki, WikiPageName)/%3E">Include other Wiki page</option>
							<option value="%3CWebFrame(http://+)/%3E">Include a Web page</option>
						</optgroup>
						<optgroup label="RSS" class="contrast1">
							<option value='%3CSyndicate("+",3)%3E'>Syndicate this RSS feed</option>
							<option value="%3CAggregate(PutNewsPageHere)/%3E">Aggragate of RSS feeds</option>
						</optgroup>
						<optgroup label="Links etc" class="contrast2">
							<option value="%3CAnchor(+)/%3E">Anchor</option>
							<option value="%3CReferer/%3E">Last page visited</option>
							<option value="%3CBackLink(+)/%3E">Link to last page visited </option>
							<option value="%3CImage(+)/%3E">Insert image</option>
							<option value="%3CImageList/%3E">List images</option>
							<option value="%3CIcon(+)/%3E">Insert Icon</option>
							<option value="%3CIconList/%3E">List icons</option>
							<option value="%3CInterWiki /%3E">List all interwiki</option>
						</optgroup>
						<optgroup label="Shared Images" class="contrast1">
							<xsl:if test="$AllowImageLibrary = 1">
								<option value="%3CShowSharedImages/%3E">Show list of Shared Images</option>
								<option value="%3CUploadImage/%3E">Upload a Shared Image</option>
							</xsl:if>
						</optgroup>
						<optgroup label="Other" class="contrast2">
							<option value="%3CAbbr(+,Expanded text)/%3E">Abbreviation</option>
							<option value="%3CAcronym(+,Expanded text)/%3E">Acronym</option>
							<option value="%3CCreatePage(HomePageTemplate)/%3E">Create new homepage for user</option>
							<option value="%3CMacroHelp(+)/%3E">Macro help</option>
							<option value="%3CShowMacroList()/%3E">Macro list</option>
							<option value="%3CProgressBar(200,30)/%3E">Progress bar</option>
							<xsl:if test="$InlineXml = 1">
								<option value="%3CInlineXml(+)/%3E">Show file as XML</option>
							</xsl:if>
							<xsl:if test="$AllowShowFile = 1">
								<option value="%3CShowFile(+)/%3E">Show serverfile (relative)</option>
							</xsl:if>
						</optgroup>
						<optgroup label="The @ shortcuts" class="contrast1">
							<option value="@this ">@this</option>
							<option value="@parent ">@parent</option>
							<option value="@grandparent ">@grandparent</option>
							<option value="@username ">@username</option>
							<option value="@date ">@date</option>
							<option value="@time ">@time</option>
							<option value="@editthis ">@editthis</option>
							<option value="@printthis ">@printthis</option>
							<option value="@historythis ">@historythis</option>
							<option value="@attachmentthis ">@attachmentthis</option>
							<option value="@xmlthis ">@xmlthis</option>
						</optgroup>
						<optgroup label="Processing Instructions" class="contrast2">
							<option value="#DEPRECATED  ">Depecated</option>
							<option value="#INCLUDE_AS_TEMPLATE ">Include as template </option>
							<option value="#MINOREDIT  ">Minoredit</option>
							<option value="#NOW ">NOW  LongDate (Shorttime)</option>
							<option value="#NOWD ">NOW  LongDate</option>
							<option value="#NOWT ">NOW Shorttime</option>
							<option value="#REDIRECT ">Redirect</option>
							<option value="#USER  ">User</option>
						</optgroup>
						<optgroup label="Admin" class="contrast1">
							<option value="%3CExecute(OpenWiki_TITLE=&#34;&#34;AnotherWiki&#34;&#34;,adminpw)%3E">Execute ASP command</option>
							<option value="%3CBuildNumber/%3E">List bad links </option>
							<option value="%3CBadLinkList/%3E">List bad links </option>
							<option value="%3CDeprecatedPages/%3E">List deprecated pages</option>
							<option value="%3CListEmoticons/%3E">List emoticons</option>
							<option value="%3CShowPlugins%3E">List plugins</option>
							<option value="%3CRefererList/%3E">List referrers</option>
							<option value="%3CResetPageHits(+)/%3E">Reset this page hits</option>
							<option value="%3CResetAllPageHits/%3E">Reset all page hits</option>
							<option value="%3CActiveSkin(+)/%3E">Show ActiveSkin</option>
							<option value="%3CSystemInfo/%3E">Show system information</option>
							<option value="%3CSystemInfo(buildnumber)/%3E">Show wiki version</option>
							<option value="%3CUserPreferences/%3E">User preferences</option>
							<option value="%3CUserName/%3E %3CIP/%3E">Show userName &#38; IP</option>
						</optgroup>
						<xsl:if test="$AllowBadges = 1">
							<optgroup label="Badges" class="contrast2">
								<option value="%3CBadge(,badges)/%3E">Show Badges list</option>
								<option value="%3CBadge(label=+)/%3E">(label)</option>
								<option value="%3CBadge(label=MyLabel|linkpage=+|target)/%3E">(page)</option>
								<option value="%3CBadge(label=MyLabel|link=+)/%3E">(url)</option>
							</optgroup>
							<xsl:if test="ow:badgeslist/badgeslist">
								<optgroup label="Installed Badges" class="contrast1">
									<xsl:for-each select="ow:badgeslist/badgeslist/name">
										<option>
											<xsl:attribute name="value">%3CBadge(badge=<xsl:value-of select="text()"/>)/%3E</xsl:attribute>
											<xsl:value-of select="text()"/>
										</option>
									</xsl:for-each>
								</optgroup>
							</xsl:if>
						</xsl:if>
					</select>
					<span class="separator">
						<xsl:text> </xsl:text>
					</span>
					<select class="select" name="headings" id="format">
						<option value=" ">Format</option>
						<option value="= + =" class="contrast1">Heading 1</option>
						<option value="== +  ==" class="contrast1">Heading 2</option>
						<option value="=== +  ===" class="contrast1">Heading 3</option>
						<option value="==== +  ====" class="contrast1">Heading 4</option>
						<option value="===== + =====" class="contrast1">Heading 5</option>
						<option value="vv+vv" class="contrast2">Subscript </option>
						<option value="^^+^^" class="contrast2">Superscript</option>
						<option value="--+--" class="contrast2">Strikethru</option>
						<option value="!!+!!" class="contrast2">Big &amp; bold</option>
						<option value="%0D%0A---R-%0D%0A" class="redtext">Red HR </option>
						<option value="%0D%0A---G-%0D%0A" class="darkgreentext">Green HR</option>
						<option value="%0D%0A---B-%0D%0A" class="bluetext">Blue HR</option>
						<option value="%0D%0A---#c0c0c0-%0D%0A">Grey HR</option>
						<option value="&lt;class(box)&gt;+&lt;/class&gt;" class="contrast1">Box (span)</option>
						<option value="&lt;class[box]&gt;+&lt;/class&gt;" class="contrast1">Box (div)</option>
						<option value="&lt;quote&gt;+&lt;/quote&gt;" class="contrast1">Quote</option>
						<option value="&lt;style(Insert style name here)&gt;+&lt;/style&gt;" class="contrast2">style</option>
						<option value="&lt;position(top%&#44;left%)&gt;+&lt;/position&gt;" class="contrast2">Position-absolute</option>
						<option value="&lt;position[top%&#44;left%]&gt;+&lt;/position&gt;" class="contrast2">Position-relative</option>
						<option value="&lt;position(top,left[,width][,height][,z-order])&gt;+&lt;/position&gt;" class="contrast2">Position-absolute</option>
						<option value="&lt;position[top,left[,width][,height][,z-order]]&gt;+&lt;/position&gt;" class="contrast2">Position-relative</option>
						<option value="&lt;comment&gt;+&lt;/comment&gt;" class="contrast1">Invisible comment</option>
						<option value="%3CNowiki%3E+%3C/Nowiki%3E" class="contrast1">No wiki</option>
					</select>
					<span class="handle">
						<xsl:text> </xsl:text>
					</span>
				</div>
			</div>
			<div class="toolbarWrapper" id="editbuttons">
				<div class="toolbarBody">
					<span class="handle">
						<xsl:text> </xsl:text>
					</span>
					<img class="button wikimarkup" align="middle" value="%0D%0A%3CBR%3E%0D%0A" src="./ow/plugins/wysiwygicons/UI_code.gif" width="20" height="21" tabindex="1" title="Insert new line" ACCESSKEY="T">
</img>
					<img class="button wikimarkup" align="middle" value="**+**" src="./ow/plugins/wysiwygicons/UI_bold.gif" ACCESSKEY="B" tabindex="1" title="Make selection bold">
</img>
					<img class="button wikimarkup" align="middle" value="//+//" src="./ow/plugins/wysiwygicons/UI_italic.gif" ACCESSKEY="I" tabindex="1" title="Make selection italic">
</img>
					<img class="button wikimarkup" value="__+__" src="./ow/plugins/wysiwygicons/UI_underline.gif" align="middle" ACCESSKEY="U" tabindex="1" title="Underline selection">
</img>
					<span class="separator">
						<xsl:text> </xsl:text>
					</span>
					<img class="button wikimarkup" value="%3C=+%3C=" src="./ow/plugins/wysiwygicons/UI_leftalign.gif" align="middle" ACCESSKEY="L" tabindex="1" title="Align Left">
 </img>
					<img class="button wikimarkup" value="=%3E+=%3E" src="./ow/plugins/wysiwygicons/UI_rightalign.gif" align="middle" ACCESSKEY="R" tabindex="1" title="Align right">
</img>
					<img class="button wikimarkup" value="%3E%3D%3C+%3E%3D%3C" src="./ow/plugins/wysiwygicons/UI_centeralign.gif" align="middle" ACCESSKEY="E" tabindex="1" title="Centre selection">
</img>
					<img class="button wikimarkup" value="%3C%3E%28+/%29" src="./ow/plugins/wysiwygicons/UI_justify.gif" align="middle" ACCESSKEY="J" tabindex="1" title="Justify selection">
</img>
					<span class="separator">
						<xsl:text> </xsl:text>
					</span>
					<img class="button wikimarkup" value="%7B%7B%7B%0D%0A+%0D%0A%7D%7D%7D" src="./ow/plugins/wysiwygicons/UI_pre.gif" align="middle" tabindex="1" title="Format selected text as code">
</img>
					<img class="button wikimarkup" value="%0D%0A----%0D%0A" src="./ow/plugins/wysiwygicons/UI_line.gif" align="middle" tabindex="1" title="Insert a horizontal rule">
</img>
					<span class="separator">
						<xsl:text> </xsl:text>
					</span>
					<img class="button" onclick="dd_numberlist();" src="./ow/plugins/wysiwygicons/UI_numberlist.gif" width="24" height="25" align="middle" tabindex="1" title="Numbering">
</img>
					<img class="button" onclick="dd_bulletlist();" src="./ow/plugins/wysiwygicons/UI_bulletlist.gif" width="24" height="25" align="middle" tabindex="1" title="Bullets">
</img>
					<img class="button" onclick="dd_unindent();" src="./ow/plugins/wysiwygicons/UI_outdent.gif" width="24" height="25" align="middle" tabindex="1" title="Decrease indent">
</img>
					<img class="button" onclick="dd_indent();" src="./ow/plugins/wysiwygicons/UI_indent.gif" width="24" height="25" align="middle" tabindex="1" title="Increase indent">
 </img>
					<img class="button" onclick="doFunctions(this);" src="./ow/plugins/wysiwygicons/UI_font_size.gif" width="40" height="22" align="middle" tabindex="1" title="Capitalise, lowercase etc">
</img>
					<span class="separator">
						<xsl:text> </xsl:text>
					</span>
					<img class="button wikimarkup" value="%3CFootnote(+)%3E" src="./ow/plugins/wysiwygicons/UI_footnote.gif" width="16" height="20" align="middle" tabindex="1" title="click on highlighted text to insert as a footnote">
</img>
					<img class="button" id="link" src="./ow/plugins/wysiwygicons/UI_link.gif" width="24" height="25" align="middle" title="click to add a link">
</img>
					<img class="button" onclick="escape_value();" src="./ow/plugins/wysiwygicons/UI_link.gif" width="24" height="25" align="middle" title="click to get escaped value">
</img>
					<img class="button" id="rss" src="./ow/plugins/wysiwygicons/UI_xml.gif" width="30" height="14" align="middle" tabindex="1" title="Add a RSS feed">
</img>
					<span class="handle">
						<xsl:text> </xsl:text>
					</span>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
