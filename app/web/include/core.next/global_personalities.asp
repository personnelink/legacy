<%
'---- Web Services Host Configurations ----
'
'---- Forked out main 'global_declarations' into a 'personnalities' module to allow determining and altering system_email
' state based on web server / cloud that is calling and executing thread
' ----
'
dim aspPageName, script_name
script_name = Request.ServerVariables("SCRIPT_NAME")
if instr(script_name,"/") >0 then 
	aspPageName = right(script_name, len(script_name) - instrRev(script_name,"/")) 
end if 

const secureURL     = "https://www.personnelinc.com"
const devURL        = "http://dev.personnelplus.net"
const nextURL       = "http://next.personnelinc.com"
const sandboxURL    = "http://sandbox.personnelinc.com"
const mobile_devURL = "https://localhost"
const remote_devURL = "http://192.168.1.99"

const internalHost  = "192.168.0.3"
const dev_hosts     = "192.168.1.64,localhost"

dim imageURL : imageURL = ""
dim http_host : http_host = request.serverVariables("HTTP_HOST")


if instr(http_host, right(mobile_devURL, len(mobile_devURL)-9)) > 0 then 'mobile dev expression
	host_sys_persona = "Const mobile_devURL: " & mobile_devURL & ", http_host: " & http_host
	dim mobile_dev
	mobile_dev = true
	
'	dsBasePath = replace(dsBasePath, "\\personnelplus.net.\tplus\web.services\", server.mappath("/temps/") & "\")
	dsLocalPath = dsBasePath
	
	MySql = Replace(MySql, "192.168.0.6", "localhost")
	'MySql = Replace(MySql, "67.42.167.209", "192.168.1.3")
'	MySql = Replace(MySql, "192.168.0.6", "70.56.159.58")
	'MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.2a")
	MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.3 ANSI")
	'MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.2a") '64 bit driver
	
elseif instr(http_host, right(remote_devURL, len(remote_devURL)-9)) > 0  then 'remote dev expression
	host_sys_persona = "Const remote_devURL= " & remote_devURL & ", http_host: " & http_host
	'print "here"
	dsBasePath = replace(dsBasePath, "\\personnelplus.net.\tplus\web.services\", server.mappath("/temps/") & "\")
	dsLocalPath = dsBasePath
	
	MySql = Replace(MySql, "192.168.0.6", "192.168.1.8")
	'MySql = Replace(MySql, "192.168.0.6", "127.0.0.1")
'	MySql = Replace(MySql, "192.168.0.6", "70.56.159.58")
	'MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.2")
	'MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.2w")
	'MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.2a") '64 bit driver
	'print MySql
	
elseif instr(http_host, right(sandboxURL, len(sandboxURL)-9)) > 0  then 'sandbox.personnelinc.com expression
	host_sys_persona = "Const sandboxURL= " & sandboxURL & ", http_host: " & http_host
	'print "here"
	dsBasePath = replace(dsBasePath, "\\personnelplus.net.\tplus\web.services\", server.mappath("/temps/") & "\")
	dsLocalPath = dsBasePath
	
	MySql = Replace(MySql, "192.168.0.6", "localhost")
	'print MySql	

elseif instr(http_host, right(nextURL, len(nextURL)-9)) > 0  then 'next.personnelinc.com expression
	host_sys_persona = "Const nextURL= " & nextURL & ", http_host: " & http_host
	'print "here"
	dsBasePath = replace(dsBasePath, "\\personnelplus.net.\tplus\web.services\", server.mappath("/temps/") & "\")
	dsLocalPath = dsBasePath
	MySql = Replace(MySql, "192.168.0.6", "localhost")
	'print MySql
else
	host_sys_persona = "Const secureURL: " & secureURL & ", http_host: " & http_host
	mobile_dev = false
end if

'break mobile_dev

dim ifDev, isDev
if instr(devURL, http_host) > 0 then
	ifDev = devURL
	isDev = true
	'dsBasePath = "\\personnelplus.net.\tplus\web.services\"
	MySql = Replace(MySql, "192.168.0.6", "127.0.0.1")
else
	ifDev = secureURL
	isDev = false
end if

'check if script host is in allowed dev group
if instr(dev_hosts, http_host) > 0 then
	MSSql    = "Provider=SQLNCLI11;Server=DEV-SQL;Pwd=onlyme;UID=sa;Database="

	dim gus_vm
		gus_vm = "192.168.1.64"
	isDev = true
	
	'fix up dev database locations
	select case http_host
		case gus_vm
			MySql = Replace(MySql, "192.168.0.6", "192.168.1.64")
			MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.3 ANSI")
		case "localhost"
			MySql = Replace(MySql, "192.168.0.6", "localhost")
			MySql = Replace(MySql, "ODBC 5.1", "ODBC 5.3 ANSI")
	end select
	
end if

'if  not isDev then on error resume next

dim baseURL
' if request.serverVariables("HTTPS") = "on" then
	' imageURL = ""
	' if user_level >= userLevelPPlusSupervisor then
		' baseURL = "https://www.personnelinc.com"
	' Else
		' baseURL = "http://www.personnelinc.com"
	' end if
' elseif instr(http_host, "www.personnelinc.com") = 0 then
	' if instr(http_host, right(devURL, len(devURL)-8)) = 0 and instr(http_host, right(mobile_devURL, len(mobile_devURL)-8)) = 0 then
		' response.status="301 Moved Permanently"
		' response.Redirect("http://www.personnelinc.com" & script_name)
	' end if
' end if

 if  request.serverVariables("HTTPS") = "on" then
	' if user_level >= userLevelPPlusSupervisor then
		' 'baseURL = ""
	' else
	baseURL = "https://www.personnelinc.com"

elseif instr(http_host, "www.personnelinc.com") = 0 and instr(http_host, internalHost)  = 0   and instr(http_host, replace(mobile_devURL, "http://", "")) = 0 then

	' end if	
	if instr(http_host, right(devURL, len(devURL)-8)) = 0 and instr(http_host, right(mobile_devURL, len(mobile_devURL)-8)) = 0 then
		'response.status="301 Moved Permanently"
		'response.redirect("https://www.personnelinc.com" & script_name)
	end if
elseif not mobile_dev then
	
	response.status="301 Moved Permanently"
	response.redirect("https://www.personnelinc.com" & script_name)

end if


dim TempsPlus(6)
TempsPlus(BOI) = "dsn=BOI;pwd=onlyme;"
TempsPlus(PPI) = "dsn=PPI;pwd=onlyme;"
TempsPlus(BUR) = "dsn=BUR;pwd=onlyme;"
TempsPlus(IDA) = "dsn=IDA;pwd=onlyme;"
TempsPlus(PER) = "dsn=PER;pwd=onlyme;"

dim dsnLessTemps(11)
dim dsnLessTempsAR(11)

if not mobile_dev then
	dsnLessTemps(BOI) = MSSql & "TempsBOISQL"
	dsnLessTemps(BUR) =MSSql & "TempsBURSQL"
	dsnLessTemps(IDA) = MSSql & "TempsIDASQL"
	dsnLessTemps(PER) = MSSql & "TempsPERSQL"
	dsnLessTemps(PPI) =  MSSql & "TempsPPISQL"
	dsnLessTemps(POC) =  MSSql & "TempsPOCSQL"
	dsnLessTemps(TWI) = jetProvider & dsBasePath & "TempsTWI.mdb"
	dsnLessTemps(BLY) = jetProvider & dsBasePath & "TempsBLY.mdb"
	dsnLessTemps(BSE) = jetProvider & dsBasePath & "TempsBSE.mdb"
	dsnLessTemps(ORE) =  MSSql & "TempsORESQL"
	dsnLessTemps(WYO) = MSSql & "TempsWYOSQL"
	
	dsnLessTempsAR(BOI) = jetProvider & dsLocalPath & "Temps.AR.BOI.mdb"
	dsnLessTempsAR(BUR) = jetProvider & dsLocalPath & "Temps.AR.BUR.mdb"
	dsnLessTempsAR(IDA) = jetProvider & dsLocalPath & "Temps.AR.IDA.mdb"
	dsnLessTempsAR(PER) = jetProvider & dsLocalPath & "Temps.AR.PER.mdb"
	dsnLessTempsAR(PPI) = jetProvider & dsLocalPath & "Temps.AR.PPI.mdb"
	dsnLessTempsAR(POC) = jetProvider & dsLocalPath & "Temps.AR.POC.mdb"
	dsnLessTempsAR(TWI) = jetProvider & dsLocalPath & "Temps.AR.TWI.mdb"
	dsnLessTempsAR(BLY) = jetProvider & dsLocalPath & "Temps.AR.BLY.mdb"
	dsnLessTempsAR(BSE) = jetProvider & dsLocalPath & "Temps.AR.BSE.mdb"
	dsnLessTempsAR(ORE) = jetProvider & dsLocalPath & "Temps.AR.ORE.mdb"
	dsnLessTempsAR(WYO) = jetProvider & dsLocalPath & "Temps.AR.WYO.mdb"
	
else
	dsnLessTemps(BOI) = MSSql & "TempsBOISQL"
	dsnLessTemps(BUR) =MSSql & "TempsBURSQL"
	dsnLessTemps(IDA) = MSSql & "TempsIDASQL"
	dsnLessTemps(PER) = MSSql & "TempsPERSQL"
	dsnLessTemps(PPI) =  MSSql & "TempsPPISQL"
	dsnLessTemps(POC) =  MSSql & "TempsPOCSQL"
	dsnLessTemps(TWI) = jetProvider & dsLocalPath & "TempsTWI.mdb"
	dsnLessTemps(BLY) = jetProvider & dsLocalPath & "TempsBLY.mdb"
	dsnLessTemps(BSE) = jetProvider & dsLocalPath & "TempsBSE.mdb"
	dsnLessTemps(ORE) =  MSSql & "TempsORESQL"
	dsnLessTemps(WYO) = MSSql & "TempsWYOSQL"
	
	dsnLessTempsAR(BOI) = jetProvider & dsLocalPath & "Temps.AR.BOI.mdb"
	dsnLessTempsAR(BUR) = jetProvider & dsLocalPath & "Temps.AR.BUR.mdb"
	dsnLessTempsAR(IDA) = jetProvider & dsLocalPath & "Temps.AR.IDA.mdb"
	dsnLessTempsAR(PER) = jetProvider & dsLocalPath & "Temps.AR.PER.mdb"
	dsnLessTempsAR(PPI) = jetProvider & dsLocalPath & "Temps.AR.PPI.mdb"
	dsnLessTempsAR(POC) = jetProvider & dsLocalPath & "Temps.AR.POC.mdb"
	dsnLessTempsAR(TWI) = jetProvider & dsLocalPath & "Temps.AR.TWI.mdb"
	dsnLessTempsAR(BLY) = jetProvider & dsLocalPath & "Temps.AR.BLY.mdb"
	dsnLessTempsAR(BSE) = jetProvider & dsLocalPath & "Temps.AR.BSE.mdb"
	dsnLessTempsAR(ORE) = jetProvider & dsLocalPath & "Temps.AR.ORE.mdb"
	dsnLessTempsAR(WYO) = jetProvider & dsLocalPath & "Temps.AR.WYO.mdb"

end if

'---- cdo Mail Enum Values
const cdoBasic              = 1
const system_email          = "Personnel Plus<online@personnel.com>"
const timeclock_email       = "Placement follow-up<online@personnel.com>"
const time_summary_email    = "Time verification<online@personnel.com>"
const account_system_email  = "Personnelinc.com account services<online@personnel.com>"
const notify_managers_email = "Web Helper<online@personnel.com>"
const w2_system_email	    = "Personnelinc.com W2 Delivery<online@personnel.com>"

const managers_email = "Personnel Plus Managers<managers@personnel.com>"


%>