<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:ow="http://openwiki.com/2001/OW/Wiki"
                extension-element-prefixes="msxsl ow"
                exclude-result-prefixes=""
                version="1.0">

<msxsl:script language="JScript" implements-prefix="ow"><![CDATA[

    var longMonths = new Array("January", "February", "March", "April", "May", "June",
                               "July", "August", "September", "October", "November", "December");
    var shortMonths = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");

    function urlencode(pData) {
        return escape(pData);
    }

    function formatLongDate(pData) {
        var year  = pData.substring(0, 4);
        var month = pData.substring(5, 7);
        var day   = pData.substring(8, 10);
        if (day.charAt(0) == '0') {
            day = day.charAt(1);
        }

        // euro-style:
        // return day + "-" + longMonths[month-1] + "-" + year;

        // us-style:
        return longMonths[month-1] + " " + day + ", " + year;
    }

    function formatShortDate(pData) {
        var year  = pData.substring(0, 4);
        var month = pData.substring(5, 7);
        var day   = pData.substring(8, 10);
        if (day.charAt(0) == '0') {
            day = day.charAt(1);
        }

        // euro-style:
        // return day + "-" + shortMonths[month-1] + "-" + year;

        // us-style:
        // return shortMonths[month-1] + " " + day + ", " + year;
        return shortMonths[month-1] + " " + day;
    }

    function formatTime(pData) {
        // euro-style
        return pData.substring(11, 16);

        // us-style
        // return 3:15 PM
    }

    function formatShortDateTime2(pData) {
        var year  = pData.substring(0, 4);
        var month = pData.substring(5, 7);
        var day   = pData.substring(8, 10);
        return formatShortDate(pData) + ", " + year + " " + formatTime(pData);
        //return day + "/" + month + "/" + year + " " + formatTime(pData);
    }


    function formatLongDateTime(pData) {
        return formatLongDate(pData) + " " + formatTime(pData);
    }

    function formatShortDateTime(pData) {
        return formatShortDate(pData) + ", " + formatTime(pData);
    }
    
    function StripHtml(pData) {    
		reg=/<[^>]+>/g; 
		pData = pData.replace(reg," ");		
		reg=/\&[\S]*;/g	// &nbsp; and others.
		pData = pData.replace(reg," ");		
		return pData;
    }
    
    function pop(url, w, h) {
      id = Math.floor(Math.random() * 10000);
      eval("page" + id + " = window.open(url, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=' + w + ',height=' + h);");
    } // pop
    
]]>
 
    
</msxsl:script>

</xsl:stylesheet>