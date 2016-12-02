

<%' scripts that need to be used all together %>
<%
Response.CacheControl = "no-cache"
Response.AddHeader "Pragma", "no-cache"
Response.Expires = -1
%>
<!-- #include file="owpreamble.asp"       //-->
<!-- #include file="owClsErrorStack.asp" //-->
<!-- #include file="owconfig_default.asp" //-->
<!-- #include file="owdebug.asp"	 //-->
<!-- #include file="owskinning.asp"		  //-->
<!-- #include file="owplugins.asp"        //-->
<!-- #include file="owprocessor.asp"      //-->
<!-- #include file="owpatterns.asp"       //-->
<!-- #include file="owwikify.asp"         //-->
<!-- #include file="owmacros.asp"         //-->
<!-- #include file="owactions.asp"        //-->
<!-- #include file="owtoc.asp"            //-->
 <!-- #INCLUDE FILE="owuploadfield.asp"-->
<!-- #include file="owupload.asp" -->
<!-- #include file="owattach.asp"         //-->
<!-- #include file="owuploadimage.asp"    //-->
<!-- #include file="owpage.asp"           //-->
<!-- #include file="owindex.asp"          //-->
<!-- #include file="owdb.asp"             //-->
<!-- #include file="owrss.asp"            //-->
<!-- #include file="owauth.asp"           //-->
<!-- #include file="owtransformer.asp"    //-->
<!-- #include file="owtag.asp"    //--> <%'//=======added by 1mmm %>


<%' scripts that each can be used on their own %>
<!-- #include file="owregexp.asp"         //-->
<!-- #include file="owvector.asp"         //-->
<!-- #include file="owdiff.asp"           //-->
<!-- #include file="owado.asp"            //-->


<%' scripts containing your custom build code %>
<!-- #include file="my/mywikify.asp"      //-->
<!-- #include file="my/myactions.asp"     //-->
<!-- #include file="my/mymacros.asp"      //-->
<!-- #include file="my/myauth.asp"      //-->

