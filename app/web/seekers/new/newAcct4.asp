<!-- #INCLUDE VIRTUAL='/inc/dbconn.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/checkCookies.asp' -->
<!-- #INCLUDE VIRTUAL='/inc/loggedRedirect.asp' -->
<%
session("temp_firstName") = StripCharacters(PCase(TRIM(request("firstName"))))
session("temp_lastName") = StripCharacters(PCase(TRIM(request("lastName"))))
session("temp_addressOne") = StripCharacters(TRIM(request("addressOne")))
session("temp_addressTwo") = StripCharacters(TRIM(request("addressTwo")))
session("temp_city") = StripCharacters(PCase(TRIM(request("city"))))
session("temp_state") = request("state")
session("temp_zipCode") = StripCharacters(request("zipCode"))
session("temp_country") = request("country")
session("temp_emailAddress") = StripCharacters(TRIM(request("emailAddress")))
session("temp_contactPhone") = StripCharacters(TRIM(request("contactPhone")))


response.redirect("/seekers/new/newAcct5.asp?who=2")
%>

