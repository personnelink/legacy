<%
' // $Log: owplugin_referers.asp,v $
' // Revision 1.6  2004/10/13 12:20:07  gbamber
' // Forced updates to make sure CVS reflects current work
' //
' // Revision 1.5  2004/07/08 09:44:41  gbamber
' // Fixed syntax errors that stopped the plugins from working
' //
' // Revision 1.4  2004/07/04 02:35:23  oddible
' // Central override for plugin activation in owplugins.asp
' //
' // Revision 1.3  2004/07/04 00:53:57  gbamber
' // Log added
' //
' **** ACTIVATION CODE ***
plugins.Add "Site Referers",0
' plugins.Add "Site Referers",1
' ************************

Sub UpdateReferer(pPagename)
	If plugins.Item("Site Referers") = 1 Then
		A_UpdateReferer(pPagename)
	End If  
End Sub


Function GetRefererList
	If plugins.Item("Site Referers") = "1" Then
		GetRefererList = A_GetRefererList
	Else
		GetRefererList="Referer plugin not installed"
	End If  	
End Function


'        // ACTIVE CODE
Sub A_UpdateReferer(pPagename)
'        // USES VARS gsz_lastPage and gsz_lastreferer
'        // USES table openwiki_referers
'                rfr_name varchar(255)
'                rfr_date datetime DEFAULT GETDATE()

    Dim sz_refererURL,sz_pageURL,b_NewRecord,oConn,oRs,vQuery

    If (pPagename = gsz_lastPage) then Exit Sub '        // No multiple calls //
        gsz_lastPage=pPagename

        sz_refererURL=Request.ServerVariables("HTTP_REFERER") '        // Fetch the referer URL

         if (sz_refererURL= gsz_lastreferer) then Exit Sub  ' // No multiple updates //
         gsz_lastreferer=sz_refererURL

        sz_pageURL=Request.ServerVariables("SERVER_NAME")'        // Fetch our URL

'        // Is the Referer URL in Our URL?
        If (Instr(sz_refererURL,sz_pageURL) > 0) then Exit Sub '        // not a referer
'        // Chuck out Google searches
        If (Instr(sz_refererURL,"google") > 0) then Exit Sub '        // not a valid referer
'        // Chuck out invalid addresses
        If (Instr(sz_refererURL,"http://") = 0) then Exit Sub '        // not a valid referer


'        // We have a foreign referer in sz_refererURL
        b_NewRecord = false
        Set oConn = Server.CreateObject("ADODB.Connection")
        oConn.Open OPENWIKI_DB
        Set oRS = Server.CreateObject("ADODB.Recordset")

        vQuery = "SELECT * FROM openwiki_referers WHERE rfr_name LIKE '" & sz_refererURL & "';"
		oRS.Open vQuery, oConn, adOpenForwardOnly
		b_NewRecord = oRS.EOF
		oRS.Close
		On Error Resume Next
		If (b_NewRecord=True) then
						vQuery = "INSERT INTO openwiki_referers (rfr_name,rfr_date) VALUES ('" & sz_refererURL & "',GETDATE() );"
		else
						vQuery = "UPDATE openwiki_referers SET rfr_date = GETDATE() WHERE rfr_name LIKE '" & sz_refererURL & "';"
		end if
						oConn.Execute(vQuery)
		'                  Response.Write("<h4>" & vQuery & "</h4>")
		oConn.Close
		Set oConn = Nothing
		Set oRS = Nothing
End Sub

Function A_GetRefererList
        Dim sz,sz_URL,sz_Date,i,oConn,oRs,vQuery
        Set oConn = Server.CreateObject("ADODB.Connection")
        oConn.Open OPENWIKI_DB
        Set oRS = Server.CreateObject("ADODB.Recordset")

	On Error Resume Next
        sz="<ol>"
        vQuery = "SELECT * FROM openwiki_referers ORDER BY rfr_date DESC;"
oRS.Open vQuery, oConn, adOpenForwardOnly
Do While Not oRS.EOF
                sz_URL="" & oRs.Fields("rfr_name")
                sz_Date="" & oRs.Fields("rfr_date")
                sz = sz & "<li>"
                sz = sz & "<ow:link name='referer' href='" & CDATAEncode(sz_URL) & "' date='" & FormatDateISO8601(Now()) &"'>" & PCDATAEncode(sz_URL) & "</ow:link><br />"

                sz = sz & sz_Date & "</li>"
                oRS.MoveNext
        Loop
        oRS.Close
        sz = sz & "</ol>"
	A_GetRefererList = sz
	oConn.Close
	Set oConn = Nothing
	Set oRS = Nothing
End Function

%>
