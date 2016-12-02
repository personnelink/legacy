<%@ Page language="c#" Codebehind="Default.aspx.cs" AutoEventWireup="false" Inherits="CaptchaImage._Default" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>CaptchaImage Test</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<style type="text/css">
			BODY { FONT-SIZE: 10pt; FONT-FAMILY: sans-serif }
			TD { FONT-SIZE: 10pt; FONT-FAMILY: sans-serif }
			TH { FONT-SIZE: 10pt; FONT-FAMILY: sans-serif }
			.notice { FONT-SIZE: 90% }
			.info { FONT-WEIGHT: bold; COLOR: #008000 }
			.error { FONT-WEIGHT: bold; COLOR: #800000 }
		</style>
		<script>
		
		function createCode(){
		var random;
		var temp="";
		for(var i=0;i<5;i++)
		{
		temp+= Math.round(Math.random() * 8 );
		}
		document.all.theImg.src="JpegImage.aspx?code=" +temp;
		document.all.Hidden1.value=temp;
		}
		</script>
	</HEAD>
	<body onload="createCode();">
		<h2>CaptchaImage Form Test</h2>
		<p>&nbsp; <img id="theImg" src=""><br>
		</p>
		<form id="Default" method="post" runat="server">
			<p>
				<strong>Enter the code shown above:</strong><br>
				<asp:TextBox id="CodeNumberTextBox" runat="server"></asp:TextBox>
				<asp:Button id="SubmitButton" runat="server" Text="Submit"></asp:Button><INPUT id="Hidden1" type="hidden" name="Hidden1" runat="server"><br>
			</p>
			<p>
				<em class="notice">&nbsp;</em>
			</p>
			<p><asp:Label id="MessageLabel" runat="server"></asp:Label></p>
		</form>
	</body>
</HTML>
