<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ow="http://openwiki.com/2001/OW/Wiki" extension-element-prefixes="msxsl ow" exclude-result-prefixes="" version="1.0">
	<msxsl:script language="JScript" implements-prefix="ow">
	<!-- 
 $Log: ow_JScripts.xsl,v $
 Revision 1.4  2005/11/07 23:51:56  sansei
 removed references to openwiki.info

 Revision 1.3  2005/01/16 22:18:23  sansei
 Changed syntax for 3rd parameter in complex syntax when truncating searches.
 OLD = 'levels from right to keep'
 NEW = 'levels to hide' (after parameter 1)

 Revision 1.2  2004/10/02 12:01:32  sansei
 Added Fullsearch truncate facillity (Fullsearch macro now accepts one parameter!)

-->
		<!--sEi'2004-->


function CleanSlash(what,howmany) {
	var temp = ""
	var titles = what.split("/")
	var count = titles.length
	titles = titles.reverse()
	if (count > howmany) {
		count = howmany
	}
	for (var i=(count-1);i>=0;i--){
		temp += "/"+titles[i]
	}
	return temp.substr(1)
}

function TruncateThis(pThetext,pSyntax){
	var runmode
	var sLeft
	var sMid
	var sRight
	var temp
	var temp2
	
	// make titles an array	
	var titles = pThetext.split("/")
	var count = titles.length
	// Digest syntax
	var syntaxes = pSyntax.split("|")
	var scount = syntaxes.length
	if (scount == 1){
		// is SIMPLE syntax
		if(count>pSyntax){
			return "../"+CleanSlash(pThetext,pSyntax)
		}else{
			return pThetext
		}
	}else{
		// is COMPLEX syntax
		// digest further
		if (scount==3){
			// syntax count ok
			// Check if first and last is positive numbers
			if((Math.round(syntaxes[0])&gt;0)&amp;(Math.round(syntaxes[2])&gt;0)){
				// is positive numbers!
			
				// check if long enough to be truncated at all
				temp = (Math.round(syntaxes[0])+Math.round(syntaxes[2]))+1
				if(temp &gt;= count){
					// to 'small' to be truncated
					return pThetext
				}else{
					// make sLeft
					sLeft=""
					for(var i=0;i&lt;syntaxes[0];i++){
						sLeft += titles[i]+"/"
					}
					// make sMid
					sMid = syntaxes[1]
					// make sRight
					temp2 = (Math.round(syntaxes[2])+Math.round(syntaxes[0]))
					temp = ""
					for (var ii=(temp2);ii&lt;titles.length;ii++){
						temp += "/"+titles[ii]
					}
					sRight = temp
					// return result of truncate
					return sLeft + sMid + sRight // + " | " + temp2 + " | " + pThetext
				}				
			}else{
				// is NOT positive numbers
				// Do nothing with text
				return pThetext
			}
		}else{
			// syntax-count NOT ok
			// Do nothing with text
			return pThetext
		}
	}
}
</msxsl:script>
</xsl:stylesheet>
