Dim o
Set o = CreateObject("MSXML2.XMLHTTP")
o.open "GET", "https://www.personnelinc.com/shell/scheduled.tasks/", False
o.send
' o.responseText now holds the response as a string.

WScript.Echo o.responseText