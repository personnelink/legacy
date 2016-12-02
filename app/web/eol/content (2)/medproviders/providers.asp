<%
session("add_css") = "./providers.asp.css" %>

<!-- #INCLUDE VIRTUAL='/include/core/init_unsecure_session.asp' -->

<%
thisUsersID = user_id
thisUsersSecurityLevel = user_level	

Database.Open MySql

dim sqlGetProviders
sqlGetProviders = "SELECT tbl_locations.description, med_providers.name, med_providers.address, med_providers.phone, " &_
	"med_providers.fax, med_providers.cityandstate, med_providers.openhours " &_
	"FROM med_providers INNER JOIN tbl_locations ON med_providers.bindtolocationi = tbl_locations.locationID " &_
	"ORDER BY tbl_locations.description DESC , med_providers.name DESC;"

dim providers
Set providers = Database.Execute(sqlGetProviders)

dim branch 'tbl_locations.description
dim provider_name 'med_providers.name
dim provider_address 'med_providers.address
dim provider_phone 'med_providers.phone
dim provider_fax 'med_providers.fax
dim provider_cityline 'med_providers.cityandstate
dim provider_hours 'med_providers.openhours

dim id, link, imglink, heading, description, story_id
	dim branch_location, previous_branch

do while not providers.eof 
	
	branch = providers("description")
	provider_name = providers("name")
	provider_address = providers("address")
	provider_phone = providers("phone")
	provider_fax = providers("fax")
	provider_cityline = providers("cityandstate")
	provider_hours = providers("openhours")
		
	if thisUsersSecurityLevel => userLevelPPlusSupervisor then
		manageThisBlog = true
		contentTasks = "<a style='float:right; clear: none;' href=" & Chr(34) & "/include/user/post/?blogid=" & id & Chr(34) &_
			" title='Edit Message'><img src='" & imglink & "/include/style/images/blogEdit.png' alt=''></a>"
	end if
%>
	  <div class="providers">
		<h4 class="branch_location"><%=branch_location%></h4>
		<ul>
			<li>
				<span class="provider_name">%provider_name%</span>
				<span class="provider_address">%provider_address%</span>
				<span class="provider_cityline">%provider_cityline%</span>
				<span class="provider_phone">%provider_phone%</span>
				<span class="provider_hours">%provider_hours%</span>
			</li>
	  </ul>
	  </div> 
<%
	manageThisBlog = false
	blogTasks = ""
	providers.Movenext
loop
Set providers = Nothing
Database.Close 

%>
  
<!-- End of content -->
<!-- #INCLUDE VIRTUAL='/include/core/pageFooter.asp' -->



























