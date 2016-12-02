<!-- #include file="functions.asp" -->
<% 
Response.ContentType = "text/vnd.wap.wml"
Response.Buffer = True
%>

<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
	<head>
		<meta forua="true" http-equiv="pragma"
						   content="no-cache"/>
		<meta forua="true" http-equiv="Cache-Control"
						   content="no-cache, must-revalidate"/>
	</head>
	<card id="start">
		<p align="center" mode="nowrap">Enter Date:</p>
		<p align="center">(MM/DD/YYYY)</p>
		<p>
			<input name="D" format="NN/NN/NNNN" />
		</p>
		<do type="accept" label="Go">
			<go href="day.asp?D=$(D)" />
		</do>
	</card>
</wml>
