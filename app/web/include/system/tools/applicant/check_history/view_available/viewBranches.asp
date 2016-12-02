<%Option Explicit%>
<%
session("add_css") = "./viewBranches.asp.css"
session("required_user_level") = 4 'userLevelRegistered
session("window_page_title") = "Currently Enrolled SItes - Personnel Plus"

session("noGuestHead") = "Are you registered?"
session("noGuestBody") = "<p><em>Are you registered?</em></p><br><p>The Guest account doesn't have access to the W2 tool. " &_
	"You can create an account by pressing ""Sign Up"" below and registering or " &_
	"if you have already registed you can use that account to sign in and continue.</p><br><br>"

dim frmAction
frmAction = request.form("frmAction")
if frmAction = "completed" then session("no_header") = true

dim disclaimer_text : disclaimer_text = "Note that this is a beta release of the check history feature and is still undergoing final " &_
	"testing before official release." &_
	"<br><br>" &_
	"If you encounter any bugs, glitches, lack of functionality or other problems on the website, or with the downloaded check history, please let us know " &_
	"immediately so we can rectify these accordingly. Your help in this regard is greatly appreciated."
%>
<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- #INCLUDE VIRTUAL='/include/system/functions/common.asp' -->

<script type="text/javascript" src="viewW2s.js"></script>

<!-- #include file='viewBranches.doStuff.asp' -->



<%=decorateTop("getw2s", "marLR10", "Currently enrolled sites")%>
    <div class="available_w2s">
	<p id="betadisclaimer"><%=disclaimer_text%></p>
	
	<%=show_available_branches%>
	

	
</div>
<%=decorateBottom()%>


<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
