<%
' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
' %%% Error stack class for OWNG    %%%
' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
' %%% created: 20060310 Gordon Bamber  %%%
' %%% version: see VERSIONSTRING constant
' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
' %%% This ASP contains general functions for   %%%
' %%% error handling. %%% 
' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
' TO DO:
'	Add parameter checks to the Set property routines
' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'  USAGE:
'	Set the class.DebugLevel property
'	1.  class.ErrorLevel = 0 -> 4
'	2.  class.ErrorParam1 = Any String (empty string is OK)
'	3.  class.ErrorParam2 = Any String (empty string is OK)
'	4.  class.ErrorParam3 = Any String (empty string is OK)
'	5.  class.PushError
'
'	Retrieve the current error status with class.IsError
'	Retrive the errors as a list with class.Errorlist property
'	Remove the last PUSHed error with class.PopError
'	Clear the error stack with class.ClearErrors
'	Retrieve the number of error on the stack with class.TotalErrors
'	Retrieve the worst error on the stack with class.MaxErrorLevel
'	..and as a string with class.MaxErrorLevelString
'	Display the versionnumber of this class with class.Version
' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CONST VERSIONSTRING = "20060311.2"
CONST HEADING_START = "<br>"
CONST HEADING_END = ""
CONST NEWLINE = "<br>"
CONST NEWPARAGRAPH = "<br><br>"

CONST BEFORE_PREFIX = "===== "
CONST AFTER_PREFIX = " ====="
CONST BEFORE_ERRORITEM = ": **"
CONST AFTER_ERRORITEM = "**"

CONST ERRORMESSAGE_PREFIX1 = "An Error has occurred which is not your fault"
CONST ERRORMESSAGE_PREFIX2 = "Errors have occurred that were not your fault"

CONST ERRORHANDLER_ERRORLEVEL0 = "No Error"
CONST ERRORHANDLER_ERRORLEVEL1 = "Minor Error"
CONST ERRORHANDLER_ERRORLEVEL2 = "Serious Error"
CONST ERRORHANDLER_ERRORLEVEL3 = "Major Error"
CONST ERRORHANDLER_ERRORLEVEL4 = "Fatal Error"
CONST ERRORHANDLER_ERRORLEVEL_UNKNOWN = "Unknown Error level"

CONST ERRORARRAY_ITEM_SEPARATOR = "|"

CONST ERRORLEVEL_STRING = "Error Level"
CONST PARAMSTRING1 = "Error Source"
CONST PARAMSTRING2 = "Error Message"
CONST PARAMSTRING3 = "More Information"

Class clsErrorStack
' #####################################################
'	// PRIVATE DATA (Note: no data is public in this class)
' #####################################################
	Private bIsError
	Private iDebugLevel
	Private iErrorLevel
	Private iMaxErrorLevel
	Private strErrorParam1
	Private strErrorParam2
	Private strErrorParam3
	Private ErrorArray()
	Private iErrorArraySize
	Private strErrorList
	Private bShowPrefix
	Private strVersionString
	
' #####################################################
'	 // CONSTRUCTOR/DESTRUCTOR
' #####################################################
	Private Sub Class_Initialize()
	'-- this code runs when class is instantiated.
		iDebugLevel=0
		iErrorLevel=0
		iMaxErrorLevel=0
		strErrorParam1=""
		strErrorParam2=""
		strErrorParam3=""
		bIsError=FALSE
		iErrorArraySize=0
		strErrorList=""
		bShowPrefix=TRUE
		strVersionString=VERSIONSTRING
	End Sub

	Private Sub Class_Terminate()
	'-- this code runs when class is dereferenced.
	End Sub

' #####################################################
'	// PUBLIC PROPERTIES
' #####################################################

'	// GET VersionString property (readonly)
	public property Get Version ' STRING
		Version = strVersionString
	end Property

'	// GET MaxErrorLevelString property (readonly)
	public property Get MaxErrorLevelString ' STRING
		MaxErrorLevelString = ErrorLevelToString(iMaxErrorLevel)
	end Property

'	// GET MaxErrorLevel property (readonly)
	public property Get MaxErrorLevel ' INTEGER
		MaxErrorLevel = iMaxErrorLevel
	end Property

'	// GET TotalErrors property (readonly)
	public property Get TotalErrors ' INTEGER
		TotalErrors = iErrorArraySize
	end Property

'	// GET ErrorList property (readonly)
	public property Get ErrorList ' STRING
		ErrorList = strErrorList
	end Property

'	// GET-SET IsError property
'	// Note: Setting this to FALSE could be used to supress the error display
	public property Get IsError ' BOOLEAN
		IsError = bIsError
	end Property
	public property Let IsError(pIsError)
		If (bIsError <> pIsError) then
			bIsError = pIsError
		End If
	end Property

'	// GET-SET ShowPrefix property
	public property Get ShowPrefix ' BOOLEAN
		ShowPrefix = bShowPrefix
	end Property
	public property Let ShowPrefix(pShowPrefix)
		If (bShowPrefix <> pShowPrefix) then
			bShowPrefix = pShowPrefix
		End If
	end Property
	
'	// GET-SET ErrorLevel property
'	// This is the only mandatory property that should be set
	public property Get ErrorLevel ' INTEGER
		ErrorLevel = iErrorLevel
	end Property
	public property Let ErrorLevel(pErrorLevel)
		If NOT IsNumeric(pErrorLevel) then pErrorLevel=0
		If (iErrorLevel <> pErrorLevel) then
			iErrorLevel = pErrorLevel
		End If
	end Property
	
'	// GET-SET DebugLevel property
	public property Get DebugLevel ' INTEGER
		DebugLevel = iDebugLevel
	end Property
	public property Let DebugLevel(pDebugLevel)
		If (iDebugLevel <> pDebugLevel) then
			iDebugLevel = pDebugLevel
		End If
	end Property

'	// GET-SET ErrorParam1 property
	public property Get ErrorParam1 ' STRING
		ErrorParam1 = strErrorParam1
	end Property
	public property Let ErrorParam1(pErrorParam1)
		If (strErrorParam1 <> pErrorParam1) then
			strErrorParam1 = pErrorParam1
		End If
	end Property

'	// GET-SET ErrorParam2 property
	public property Get ErrorParam2 ' STRING
		ErrorParam2 = strErrorParam2
	end Property
	public property Let ErrorParam2(pErrorParam2)
		If (strErrorParam2 <> pErrorParam2) then
			strErrorParam2 = pErrorParam2
		End If
	end Property

'	// GET-SET ErrorParam3 property
	public property Get ErrorParam3 ' STRING
		ErrorParam3 = strErrorParam3
	end Property
	public property Let ErrorParam3(pErrorParam3)
		If (strErrorParam3 <> pErrorParam3) then
			strErrorParam3 = pErrorParam3
		End If
	end Property

' #####################################################
'	// PUBLIC METHODS
' #####################################################

	Public Sub ClearErrors
	'	// Resets the error stack, but preserves DebugLevel
		iErrorLevel=0
		iMaxErrorLevel=0
		strErrorParam1=""
		strErrorParam2=""
		strErrorParam3=""
		bIsError=FALSE
		iErrorArraySize=0
		strErrorList=""
	End Sub
	
	Public Sub PopError
	'	// Clears the last pushed error from the stack
	'	// Resets MaxErrorLevel
		Dim ct
		iMaxErrorLevel=0 '	// Note: this is an unsolved bug.  iMaxErrorLevel needs to be reset to the cvorrect value
		If iErrorArraySize > 0 then
			iErrorArraySize=iErrorArraySize-1
		End If
		REDIM PRESERVE ErrorArray(iErrorArraySize)
		If iErrorArraySize=0 then
			bIsError=FALSE
		End if
		ErrorArrayToString '	// Repopulate ErrorList
	End Sub

	Public Sub PushError
'	// class.DebugLevel = 0 -> 5 Set this property before calling class.PushError
'	// Call this method to add an error to the stack
'	// class.ErrorLevel = 0 -> 4
'	// class.ErrorParam1 = Any String (empty string is OK)
'	// class.ErrorParam2 = Any String (empty string is OK)
'	// class.ErrorParam3 = Any String (empty string is OK)
'	// class.PushError
'	// Evry call to PushError resets the class.ErrorList property.
		If iErrorLevel >= iDebugLevel then
			iErrorArraySize=iErrorArraySize + 1 ' //The ErrorArray is a 1-based array
			bIsError=TRUE
			REDIM PRESERVE ErrorArray(iErrorArraySize)
			If iErrorLevel > iMaxErrorLevel then iMaxErrorLevel = iErrorLevel ' // The PopError does not reset this correctly
			' // The first parameter is always present (default=0)
			ErrorArray(iErrorArraySize) = 	ERRORLEVEL_STRING &_
			BEFORE_ERRORITEM & ErrorLevelToString(iErrorLevel) & AFTER_ERRORITEM & ERRORARRAY_ITEM_SEPARATOR
			' // The three string parameters are optional
			If strErrorParam1 <> "" then
				ErrorArray(iErrorArraySize) = 	ErrorArray(iErrorArraySize)  & PARAMSTRING1 &_
				BEFORE_ERRORITEM & strErrorParam1 & AFTER_ERRORITEM & ERRORARRAY_ITEM_SEPARATOR
			End If
			If strErrorParam2 <> "" then
				ErrorArray(iErrorArraySize) = 	ErrorArray(iErrorArraySize)  & PARAMSTRING1 &_
				BEFORE_ERRORITEM & strErrorParam2 & AFTER_ERRORITEM & ERRORARRAY_ITEM_SEPARATOR
			End If
			If strErrorParam3 <> "" then
				ErrorArray(iErrorArraySize) = 	ErrorArray(iErrorArraySize)  & PARAMSTRING1 &_
				BEFORE_ERRORITEM & strErrorParam3 & AFTER_ERRORITEM & ERRORARRAY_ITEM_SEPARATOR
			End If
			ErrorArrayToString '	// Repopulate ErrorList
		End If
	End Sub

' #####################################################
'	// PRIVATE MEHODS
' #####################################################

	Private Sub ErrorArrayToString
	'	// Internal function to transform error stack to a human-readable string (strErrorList)
	'	// Called by class.PushError
	'	// List retrieved by class.ErrorList property
		Dim tString,tArrayItem
		Dim DetailArray
		Dim ct,ct1
		If bShowPrefix then
			If iErrorArraySize = 1 then
				tString=HEADING_START & BEFORE_PREFIX & ERRORMESSAGE_PREFIX1 & AFTER_PREFIX & HEADING_END
			Else
				tString=HEADING_START & BEFORE_PREFIX & ERRORMESSAGE_PREFIX2 & AFTER_PREFIX & HEADING_END
			End If
		else
			tString=""
		end if
		' Iterate through the ErrorArray (1-based)
		For ct = 1 to iErrorArraySize
			tString = tString & NEWPARAGRAPH
			tArrayItem = ErrorArray(ct)
			' // Split each error item into its components
			DetailArray=Split(tArrayItem,ERRORARRAY_ITEM_SEPARATOR)
			For ct1 = LBound(DetailArray) To UBound(DetailArray)
				tString = tString & DetailArray(ct1) & NEWLINE
			Next
		Next
		strErrorList=tString
	End Sub

	Private Function ErrorLevelToString(pErrorLevel)
'	// Called to translate the integer error level to a human-readable string
		Select Case pErrorLevel
			Case 4
				ErrorLevelToString=ERRORHANDLER_ERRORLEVEL4
			Case 3
				ErrorLevelToString=ERRORHANDLER_ERRORLEVEL3
			Case 2
				ErrorLevelToString=ERRORHANDLER_ERRORLEVEL2
			Case 1
				ErrorLevelToString=ERRORHANDLER_ERRORLEVEL1
			Case 0
				ErrorLevelToString=ERRORHANDLER_ERRORLEVEL0
			Case Else
				ErrorLevelToString=ERRORHANDLER_ERRORLEVEL_UNKNOWN
		End Select
	End Function

end class
%>