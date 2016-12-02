<!-- #INCLUDE VIRTUAL='/include/core/init_secure_session.asp' -->
<!-- Revised: 2011.03.02 -->
<!-- #include file='profile_procedures.asp' -->


    <form name="profileInfo" method="post" action="<%=FormPostTo%>">
      <input type="hidden" name="formAction" >
      <%=decorateTop("accountForm", "marLR10", "Account Profile Information")%>
      <div class="divided">
        <p class="v h"><img src="/include/style/images/createUser.jpg" style="padding-left:10"></p>
      </div>
      <div class="divided">
        <p>
          <label for="title" class="createUser">Title</label>
          <input type="text" name="title" size="30" value="<%=Title%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("title")%>&nbsp;</p>
        <p>
          <label for="nameF" class="createUser">First Name</label>
          <input type="text" name="nameF" size="30" value="<%=FirstName%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("nameF")%>&nbsp;</p>
        <p>
          <label for="Pphone" class="createUser">Phone</label>
          <input type="text" name="Pphone" size="30" value="<%=PrimaryPhone%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="Sphone" class="createUser">Alt. Phone</label>
          <input type="text" name="Sphone" size="30" value="<%=SecondaryPhone%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;">&nbsp;</p>
        <p>
          <label for="email" class="createUser">eMail</label>
          <input type="text" name="email" size="30" value="<%=eMail%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="reemail" class="createUser">Second eMail</label>
          <input type="text" name="reemail" size="30" value="<%=AlternateeMail%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
      </div>
      <div class="divided">
        <p>
          <label for="department" class="createUser">Department</label>
          <select name="department" style="width:170;">
            <option value="000">Not Assigned to a Department</option>
            <%=PopulateList("tbl_departments Where companyID=" & companyId, "departmentID", "name", "Order By name", Department)%>
          </select>
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="nameL" class="createUser">Last Name</label>
          <input type="text" name="nameL" size="30" value="<%=LastName%>">
        </p>
        <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("nameL")%>&nbsp;</p>
        <p>
          <label for="addOne" class="createUser">Address</label>
          <input type="text" name="addOne" size="30" value="<%=AddressOne%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="addTwo" class="createUser">Address Two</label>
          <input type="text" name="addTwo" size="30" value="<%=AddressTwo%>">
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="City" class="createUser">City/State</label>
          <input type="text" name="City" size="20" value="<%=City%>">
          <select name="state" class="createUser">
            <option value="ID">ID</option>
            <%=PopulateList("list_locations", "locCode", "locCode", "locCode", UserState)%>
          </select>
        </p>
        <p class="formErrMsg">&nbsp;</p>
        <p>
          <label for="zipcode" class="createUser">Zip Code</label>
          <input type="text" name="zipcode" size="19" value="<%=ZipCode%>">
          <select name="country" value="<%=Country%>">
            <option value="USA">USA</option>
            <option value="CA">CA</option>
          </select>
        </p>
        <p class="formErrMsg">&nbsp;</p>
      </div>
      <%=decorateBottom()%> <%=decorateTop("accountSecurityForm", "marLR10", "Security Information")%>
      <div class="sideMargin">
        <div class="normalTitle" style="margin-bottom:10;">
          <p style="text-align:center"></p>
        </div>
        <div class="divided">
          <p>
            <label for="userName" class="createUser">User Name</label>
            <input type="text" name="username" size="30" ReadOnly value="<%=UserName%>">
          </p>
          <p class="formErrMsg" style="padding-left:85px;"><%=CheckField("username")%></p>
        </div>
        <div class="divided">
          <p>
            <label for="password" class="createUser">Password</label>
            <input type="password" name="password" size="30" value="<%=Password%>">
          </p>
          <p>
            <label for="retypedpassword" class="createUser">Retype Password</label>
            <input type="password" name="retypedpassword" size="30" value="<%=ConfirmPassword%>">
          </p>
          <p class="formErrMsg"><%=CheckField("password")%>&nbsp;</p>
        </div>
      </div>
      <%=decorateBottom()%>
      <div class="buttonwrapper" style="padding:10px 0 10px 0;">
      	<a class="squarebutton" href="javascript:document.profileInfo.formAction.value='true';document.createNewUser.submit();" style="margin-left: 6px" onclick="document.profileInfo.formAction.value='true';document.profileInfo.submit();"><span>Update</span></a> <a class="squarebutton" href="/userHome.asp" onclick="history.back();"><span>Go Back</span></a></div>
    </form>

<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->
