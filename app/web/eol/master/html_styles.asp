<!-- Revised: 02.11.2009 -->
<link href="/include/style/master.css" rel="stylesheet" type="text/css">
<link href="/include/style/global.css" rel="stylesheet" type="text/css">

<!--[if IE]><link href="/include/style/IEglobal.css" rel="stylesheet" type="text/css"><![endif]-->

<%

If len(Session("additionalStyling")) > 0 Then %>
<link href="/include/style/unique/<%=Session("additionalStyling")%>" rel="stylesheet" type="text/css"><%
End If %>

<!-- #INCLUDE VIRTUAL='include/style/ieCSSifs.asp' -->
