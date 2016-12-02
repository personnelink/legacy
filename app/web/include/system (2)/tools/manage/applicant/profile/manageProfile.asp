<%Option Explicit%>
<%Response.Buffer = False%>
<%
session("required_user_level") = 1 'userLevelRegistered
session("window_page_title") = "Manage My Profile - Personnel Plus"
session("noGuestHead") = "Are you registered?"
session("noGuestBody") = "<p><em>Are you registered?</em></p><br><p>The Guest account password cannot be changed. " &_
	"You can create an account by pressing ""Sign Up"" below and registering or " &_
	"if you have already registered you can use that account to sign in and continue.</p><br><br>"
session("add_css") = "./manageProfile.css"

dim page_title
page_title = "Manage Profile"

dim formAction
formAction = request.form("formAction")
if formAction = "update" then session("no_header") = true %>

<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->

<script type="text/javascript" src="manageProfile.js"></script>

<!-- #include file='manageProfile.doStuff.asp' -->

<%=decorateTop("manageProfile", "marLR10 notToShort", "Profile and Account Information")%>


<form id="manageProfileForm" name="manageProfileForm" action="<%=FormPostTo%>" method="post">
<input id="page_title" name="page_title" type="hidden" class="hidden" value="<%=page_title%>">


	<div id="UserDetails">

    <div id="ProfileForm">
      <p>
        <label for="nameF">First Name</label>
        <input type="text" id="nameF" name="nameF" size="30" value="<%=FirstName%>">
      </p>
      <p>
        <label for="nameL">Last Name</label>
        <input type="text" id="nameL" name="nameL" size="30" value="<%=LastName%>">
      </p>
		<p>
        <label for="email">Email</label>
        <input type="text" id="email" name="email" size="30" value="<%=eMail%>">
      </p>
      <p>
        <label for="Pphone">Phone</label>
        <input type="text" id="Pphone" name="Pphone" size="30" value="<%=PrimaryPhone%>">
      </p>
      <p>
        <label for="Sphone">Other Phone</label>
        <input type="text" id="Sphone" name="Sphone" size="30" value="<%=SecondaryPhone%>">
      </p>
      <p>
        <label for="addOne">Address</label>
        <input type="text" id="addOne" name="addOne" size="30" value="<%=AddressOne%>">
      </p>
      <p>
        <label for="addTwo">Address Two</label>
        <input type="text" id="addTwo" name="addTwo" size="30" value="<%=AddressTwo%>">
      </p>
      <p>
        <label for="City">City</label>
        <input type="text" id="City" name="City" size="20" value="<%=City%>">
     </p>      <p>
        <label for="Notify"><input style="width:1.6em;float:left;clear:none;" type="checkbox" id="Notify" name="Notify" value="-1" <%if cbool(Notify) then response.write "checked=""checked"""%>>
		Please send me available job and other information notifications.
        </label>
     </p>
     <table><tr><td>
        <label for="state">State</label></td></tr><tr><td>
        <select id="state" name="state" class="styled">
          <option value="ID">ID</option>
          <%=PopulateList("list_locations", "locCode", "locName", "locCode", UserState)%>
        </select></td></tr></table>
    <p>
        <label for="zipcode">Zip Code</label>
        <input type="text" id="zipcode" name="zipcode" autocomplete="off" size="19" value="<%=ZipCode%>">
      </p>
    <table><tr><td>
        <label for="country">Country</label></td></tr><tr><td>
        <select id="country" name="country" class="styled">
          <option value="USA">USA</option>
          <option value="CA">CA</option>
        </select>
      </td></tr></table>
      <hr>
    <table><tr><td>
        <label for="security">Security Level</label></td></tr><tr><td>
        <select id="security" name="security" class="styled">
          <%=PopulateList("list_security Where userlevel >= " & SecurityLowScope & " and userlevel <= " & SecurityHighScope, "userlevel", "displayname", "Order By userlevel", UserLevel)%>
        </select>
      </td></tr></table>
      <p>
        <label for="userName">User Name</label>
        <input type="text" id="userName" name="userName" autocomplete="off" size="60" value="<%=userName%>" readonly>
      </p>      <p>
        <label for="password">Password</label>
        <input type="password" id="password" name="password" autocomplete="off" size="30" value="<%=Password%>">
      </p>
      <p>
        <label for="retypedpassword">Retype Password</label>
        <input type="password" id="retypedpassword" name="retypedpassword" size="30" value="<%=ConfirmPassword%>">
      </p>
      <%if CantChangeUserName <> "" then response.write("<input name='UserNameReadOnly' type='hidden' value='true'>")	%>
	<input type="hidden" name="formAction" value="">
</div>

<%
	leftSideMenu = "<div class=""notes"">" &_
    "<h4>User Details</h4>" &_
    "<p>Use this tool to change and update your user profile information and reset their login password. Verify your user name, address and other contact information.</p>" &_
  "</div>" &_
  "<div class=""notes"">" &_
    "<h4>Update Profile</h4>" &_
    "<p class=""last"">Select 'Update Profile' button at the bottom to update your user account information.</p>" &_
  "</div>"
%>
  <table><tr><td>
  <a class="squarebutton" style="margin: 0 2em 1em 14em;"href="/userHome.asp"><span>Cancel</span></a></td><td>
  <a id="updateuserbtn" class="squarebutton" href="javascript:;" onclick="user.update();" style="margin: 0 2em 1em 8em;"><span>Update</span></a></td></tr></table>
</div>
</form>

<%=decorateBottom()%>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
