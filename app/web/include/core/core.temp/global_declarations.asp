<%
'---- Database Connection Information ----
'
' (32-bit drive) dim MySql : MySql    = "DRIVER={MySQL ODBC 5.1 Driver};Server=192.168.0.6;port=6612;Option=67108899;Database=pplusvms;User ID=online;Password=.SystemUser"
dim MySql : MySql    = "DRIVER={MySQL ODBC 5.3 ANSI Driver};Server=192.168.0.6;port=6612;Option=67108899;Database=pplusvms;User ID=online;Password=.SystemUser"
'dim MSSql : MSSql    = "ODBC;DRIVER=SQL Server;SERVER=dev-sql;UID=sa;PWD=onlyme;APP=dbRepair;WSID=f;DATABASE="
'dim MSSql : MSSql    = "DRIVER={SQL Server};SERVER=192.168.0.7;UID=sa;PWD=onlyme;DATABASE="
'dim MSSql : MSSql    = "DRIVER={SQL Server};SERVER=TWIN-MSSQL\TEMPS;UID=sa;PWD=onlyme;APP=dbRepair;WSID=WEB-2012;DATABASE="
dim MSSql : MSSql    = "Provider=SQLNCLI11;Server=192.168.0.7\TEMPS;Pwd=onlyme;UID=sa;Database="
'dim MySql : MySql    = "DRIVER={MySQL ODBC 5.1 Driver};Server=67.42.167.209;port=6612;Option=67108899;Database=pplusvms;User ID=online;Password=.SystemUser"

' MS deprecated JET, old string: const jetProvider    = "Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password=onlyme;Data Source="

const jetProvider    = "Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ="
'const msSqlProvider  = "Server=192.168.0.199;User Id=sqlmmartin;Password=!~`K0r7m5;Database="
dim dsBasePath : dsBasePath = "\\personnelplus.net.\tplus\web.services\"
dim dsSQLConnPath : dsSQLConnPath = "\\personnelplus.net.\tplus\"
'dim dsLocalPath : dsLocalPath = "C:\inetpub\wwwroot\vms.dev\temps\web.services\"
dim dsLocalPath : dsLocalPath = dsBasePath
const dsnLessReports = "Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password=onlyme;Data Source=\\personnelplus.net.\web\reports\vms.mdb"
const qtrly_path     = "\\personnelplus.net.\tplus\qtrly\"

'---- Temps Plus Company Codes
const PER = 0, BUR = 1, BOI = 2, IDA = 3, TWI = 4, PPI = 5, POC = 6, BLY = 7, BSE = 8, ALL = 9, ORE = 10, WYO = 11 'same numbering is used in database schema, for example: tbl_companies.sites

'---- VMS Location Codes
const g_TwinFalls = 9
const g_Boise     = 15
const g_Nampa     = 16
const g_Burley    = 13
const g_Jerome    = 18
const g_Pocatello = 20

'---- VMS Guest user id
const guest_account = 367

%>

<!-- #INCLUDE VIRTUAL='/include/core/global_personalities.asp' -->

<%

dim Database
Set Database = Server.CreateObject("ADODB.Connection") 'Global Database Object

dim SystemDatabase
Set SystemDatabase = Server.CreateObject("ADODB.Connection") 'Global Database Object

dim dbQuery

'----- Global Constants -----
const ForReading = 1, ForWriting = 2, ForAppending = 8

'---- Database CursorOptionEnum Values ----
const adHoldRecords      = &H00000100
const adMovePrevious     = &H00000200
const adAddNew           = &H01000400
const adDelete           = &H01000800
const adUpdate           = &H01008000
const adBookmark         = &H00002000
const adApproxPosition   = &H00004000
const adUpdateBatch      = &H00010000
const adResync           = &H00020000
const adNotify           = &H00040000

' -- ADO command types
Const adCmdUnspecified   = -1
Const adCmdText          = 1
Const adCmdTable         = 2
Const adCmdStoredProc    = 4
Const adCmdUnknown       = 8
Const adCmdFile          = 256
Const adCmdTableDirect   = 512

' -- ADO cursor types
Const adOpenForwardOnly  = 0
Const adOpenKeyset       = 1
Const adOpenDynamic      = 2
Const adOpenStatic       = 3
Const adOpenUnspecified  = -1

' -- ADO cursor locations
const adUseServer        = 2 '(Default)
const adUseClient        = 3

' -- DataTypeEnum Values
Const adArray            = &H2000
Const adBigInt           = 20
Const adBinary           = 128
Const adBoolean          = 11
Const adBSTR             = 8
Const adChapter          = 136
Const adChar             = 129
Const adCurrency         = 6
Const adDate             = 7
Const adDBDate           = 133
Const adDBTime           = 134
Const adDBTimeStamp      = 135
Const adDecimal          = 14
Const adDouble           = 5
Const adEmpty            = 0
Const adError            = 10
Const adFileTime         = 64
Const adGUID             = 72
Const adIDispatch        = 9
Const adInteger          = 3
Const adIUnknown         = 13
Const adLongVarBinary    = 205
Const adLongVarChar      = 201
Const adLongVarWChar     = 203
Const adNumeric          = 131
Const adPropVariant      = 138
Const adSingle           = 4
Const adSmallInt         = 2
Const adTinyInt          = 16
Const adUnsignedBigInt   = 21
Const adUnsignedInt      = 19
Const adUnsignedSmallInt = 18
Const adUnsignedTinyInt  = 17
Const adUserDefined      = 132
Const adVarBinary        = 204
Const adVarChar          = 200
Const adVariant          = 12
Const adVarNumeric       = 139
Const adVarWChar         = 202
Const adWChar            = 130 

' -- ParameterDirectionEnum Values
const adParamUnknown     = &H0000
const adParamInput       = &H0001
const adParamOutput      = &H0002
const adParamInputOutput = &H0003
const adParamReturnValue = &H0004

' -- ExecuteOptionEnum Values
Const adAsyncExecute     = 16
Const adAsyncFetch       = 32
Const adAsyncFetchNonBlocking = 64
Const adExecuteNoRecords = 128
Const adBookmarkCurrent  = 0

'---- Database LockTypeEnum Values ----
const adLockReadOnly        = 1
const adLockPessimistic     = 2
const adLockOptimistic      = 3
const adLockBatchOptimistic = 4

'---- Employee User Levels ----
const userLevelSuspended = 0, userLevelGuest = 1, userLevelResume = 2, userLevelRegistered = 3, userLevelApplicant = 4
const userLevelScreened = 8, userLevelUnassigned = 16, userLevelAssigned = 32, userLevelDisEngaged = 64
const userLevelEngaged = 128

'---- Employer User Levels ----
const userLevelSupervisor = 256, userLevelApprover = 512, userLevelManager = 1024, userLevelAdministrator = 2048

'---- Personnel Plus Staff ----
const userLevelPPlusStaff = 4096, userLevelPPlusSupervisor = 8192, userLevelPPlusAdministrator = 16384, userLevelPPlusDeveloper = 32768

'---- Navigation Menu ----
const seeking = 0, employee = 1, employer = 2, internal = 3, developer = 4

'---- Messaging Folders
const Inbox = "0", Drafts = "1", Sent = "2", Deleted = "3"

'---- Messaging Actions
const SendMailAll = -1, SendMailAllCompany = -2, SendMailAllTemps = -3

const msgNew = "0", msgForward = "1", msgDelete = "2", msgRead = "3", msgReply = "4", msgViewFolder = "5"

'---- Actions
const manage = "0", add = "1", view = "2", remove = "3"

'---- Inner Session System Messages
const security_level_too_low = 1

'---- Header Control
dim header_response
dim no_you_heading
dim no_you_body

'---- Side Menu Control
dim leftSideMenu

'---- Session Stuff
dim host_sys_persona
dim applicationId
dim addressId
dim companyId
dim departmentId
dim user_id
dim tUser_id
dim user_name
dim user_level
dim user_level_sim ' simulate user level, development / security
dim user_email
dim user_phone
dim user_sphone
dim user_firstname
dim user_lastname
dim user_created
dim user_empcode
dim user_zip
dim branch_address
dim branch_fax
dim company_addressId
dim company_name
dim company_phone
dim company_sphone
dim company_created
dim company_custcode 'deprecated via cCustomerCode class object 2013.02.25
dim g_company_custcode

	'initialize customer code class
	set g_company_custcode = new cCustomerCode


dim company_weekends
' dim company_paytype
' dim company_salarytype
dim company_dsn_site
dim g_Company_show_paid
dim company_location_description
dim change_sim

dim gResettingPassword : 'gResettingPassword = false
dim showLeftSideMenu   : showLeftSideMenu = true
dim noGuestHead        : noGuestHead = ""
dim noGuestBody        : noGuestBody = ""
dim noSocial
dim homeMessage        : homeMessage = ""
dim homeSubject        : homeSubject = ""

%>
<!-- #INCLUDE VIRTUAL='/include/core/global_functions.asp' -->
