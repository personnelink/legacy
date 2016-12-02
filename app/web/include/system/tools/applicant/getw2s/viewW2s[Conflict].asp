<%Option Explicit%>
<%
session("add_css") = "./viewW2s.asp.css"
session("required_user_level") = 4 'userLevelRegistered
session("window_page_title") = "My W2's - Personnel Plus"
session("noGuestHead") = "Are you registered?"
session("noGuestBody") = "<p><em>Are you registered?</em></p><br><p>The Guest account doesn't have access to the W2 tool. " &_
	"You can create an account by pressing ""Sign Up"" below and registering or " &_
	"if you have already registed you can use that account to sign in and continue.</p><br><br>"

dim frmAction
frmAction = request.form("frmAction")
if frmAction = "completed" then session("no_header") = true

dim disclaimer_text : disclaimer_text = "Please note that this is a beta version of the W2 download tool which is still undergoing final " &_
	"testing before official release. The W2 download tool, it's software and all related content are provided on an “as is” and “as available” basis. " &_
	"Personnel Plus, Inc. does not give any warranties, whether express or implied, as to the suitability or usability of the resulting W2 or " &_
	"any of its content. Personnel Plus, Inc. will not be liable for any loss, whether such loss is direct, indirect, special or consequential, suffered " &_ 
	"by any party as a result of their use of the Personnel Plus, Inc. website [VMS], its software or content. Any downloading of material from the " &_
	"website is done at the user’s own risk and the user will be solely responsible for any damage to any computer system or loss of data that results" &_
	"from such activities." &_
	"<br><br>" &_
	"Should you encounter any bugs, glitches, lack of functionality or other problems on the website, or with the downloaded W2, please let us know " &_
	"immediately so we can rectify these accordingly. Your help in this regard is greatly appreciated."
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->

<script type="text/javascript" src="viewW2s.js"></script>

<!-- #include file='viewW2s.doStuff.asp' -->



<%=decorateTop("getw2s", "marLR10", "Available W2's")%>
    <div class="available_w2s">
	<p id="betadisclaimer"><%=disclaimer_text%></p>
	
	<%=show_available_w2s%>
	

	
</div>
<%=decorateBottom()%>


<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
