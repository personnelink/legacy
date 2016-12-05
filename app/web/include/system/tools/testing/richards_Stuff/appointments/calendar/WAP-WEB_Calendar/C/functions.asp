<%
'==================================================
'Title         Functions.asp
'Purpose:	   Holds common Declarations and functions
'Author:	   Chris Harrison (Information Echo Inc.)
'Last Updated: June 5, 2001
'==================================================

'*** Common Constants from adovbs.inc ***

'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

'---- LockTypeEnum Values ----
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4

'---- CursorLocationEnum Values ----
Const adUseServer = 2
Const adUseClient = 3

'---- CommandTypeEnum Values ----
Const adCmdUnknown = &H0008
Const adCmdText = &H0001
Const adCmdTable = &H0002
Const adCmdStoredProc = &H0004



'*** DECLARATIONS ***
Dim objConn, objRS
set objConn = server.CreateObject("ADODB.Connection")
set objRS   = server.CreateObject("ADODB.Recordset")
sConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & server.MapPath("../Calendar/Cal.mdb") & ";Persist Security Info=False"



'*** COMMON FUNCTIONS ***

'==================================================
'Function: OpenDB()
'		   Opens a DB connetion	
'==================================================
function OpenDB()
	objConn.Open sConnection
end function


'===================================================
'Function: CloseDB()
'		   Closes and kills the DB Connection obj
'===================================================
function CloseDB()
	objConn.Close
	set objConn = nothing
end function

'===================================================
'Function:   OpenRS()
'Parameters: sSQL (Select statement)
'			 Opens a Dynamic, Optimistic RS from sSQL				   
'===================================================
function OpenRS(sSQL)
	objRS.Open sSQL, objConn, adOpenDynamic, adLockOptimistic, adCmdText
end function

'===================================================
'Function:   OpenRORS(sSQL)
'Parameters: sSQL (Select statement)
'			 Opens a Forward, Read-only RS from sSQL				   
'===================================================
function OpenRORS(sSQL)
	objRS.Open sSQL, objConn, adOpenForwardOnly, adLockReadOnly, adCmdText
end function

'===================================================
'Function: CloseRS()
'		   Closes and kills the RS obj
'===================================================
function CloseRS()
	objRS.Close
	set objRS = nothing
end function

%>
