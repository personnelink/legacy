<%
'--------------------------------------------------------------------
' Microsoft ADO
'
' (c) 1996 Microsoft Corporation.  All Rights Reserved.
'
'
'
' ADO constants include file for VBScript
'
'--------------------------------------------------------------------

'---- CursorTypeEnum Values ----
const adOpenForwardOnly = 0
const adOpenKeyset = 1
const adOpenDynamic = 2
const adOpenStatic = 3

'---- CursorOptionEnum Values ----
const adHoldRecords = &H00000100
const adMovePrevious = &H00000200
const adAddNew = &H01000400
const adDelete = &H01000800
const adUpdate = &H01008000
const adBookmark = &H00002000
const adApproxPosition = &H00004000
const adUpdateBatch = &H00010000
const adResync = &H00020000
const adNotify = &H00040000

'---- LockTypeEnum Values ----
const adLockReadOnly = 1
const adLockPessimistic = 2
const adLockOptimistic = 3
const adLockBatchOptimistic = 4

'---- ExecuteOptionEnum Values ----
const adRunAsync = &H00000010

'---- ObjectStateEnum Values ----
const adStateClosed = &H00000000
const adStateOpen = &H00000001
const adStateConnecting = &H00000002
const adStateExecuting = &H00000004

'---- CursorLocationEnum Values ----
const adUseServer = 2
const adUseClient = 3

'---- DataTypeEnum Values ----
const adEmpty = 0
const adTinyInt = 16
const adSmallInt = 2
const adInteger = 3
const adBigInt = 20
const adUnsignedTinyInt = 17
const adUnsignedSmallInt = 18
const adUnsignedInt = 19
const adUnsignedBigInt = 21
const adSingle = 4
const adDouble = 5
const adCurrency = 6
const adDecimal = 14
const adNumeric = 131
const adBoolean = 11
const adError = 10
const adUserDefined = 132
const adVariant = 12
const adIDispatch = 9
const adIUnknown = 13
const adGUID = 72
const adDate = 7
const adDBDate = 133
const adDBTime = 134
const adDBTimeStamp = 135
const adBSTR = 8
const adChar = 129
const adVarChar = 200
const adLongVarChar = 201
const adWChar = 130
const adVarWChar = 202
const adLongVarWChar = 203
const adBinary = 128
const adVarBinary = 204
const adLongVarBinary = 205

'---- FieldAttributeEnum Values ----
const adFldMayDefer = &H00000002
const adFldUpdatable = &H00000004
const adFldUnknownUpdatable = &H00000008
const adFldFixed = &H00000010
const adFldIsNullable = &H00000020
const adFldMayBeNull = &H00000040
const adFldLong = &H00000080
const adFldRowID = &H00000100
const adFldRowVersion = &H00000200
const adFldCacheDeferred = &H00001000

'---- EditModeEnum Values ----
const adEditNone = &H0000
const adEditInProgress = &H0001
const adEditAdd = &H0002
const adEditDelete = &H0004

'---- RecordStatusEnum Values ----
const adRecOK = &H0000000
const adRecNew = &H0000001
const adRecModified = &H0000002
const adRecDeleted = &H0000004
const adRecUnmodified = &H0000008
const adRecInvalid = &H0000010
const adRecMultipleChanges = &H0000040
const adRecPendingChanges = &H0000080
const adRecCanceled = &H0000100
const adRecCantRelease = &H0000400
const adRecConcurrencyViolation = &H0000800
const adRecIntegrityViolation = &H0001000
const adRecMaxChangesExceeded = &H0002000
const adRecObjectOpen = &H0004000
const adRecOutOfMemory = &H0008000
const adRecPermissionDenied = &H0010000
const adRecSchemaViolation = &H0020000
const adRecDBDeleted = &H0040000

'---- GetRowsOptionEnum Values ----
const adGetRowsRest = -1

'---- PositionEnum Values ----
const adPosUnknown = -1
const adPosBOF = -2
const adPosEOF = -3

'---- enum Values ----
const adBookmarkCurrent = 0
const adBookmarkFirst = 1
const adBookmarkLast = 2

'---- MarshalOptionsEnum Values ----
const adMarshalAll = 0
const adMarshalModifiedOnly = 1

'---- AffectEnum Values ----
const adAffectCurrent = 1
const adAffectGroup = 2
const adAffectAll = 3

'---- FilterGroupEnum Values ----
const adFilterNone = 0
const adFilterPendingRecords = 1
const adFilterAffectedRecords = 2
const adFilterFetchedRecords = 3
const adFilterPredicate = 4

'---- SearchDirection Values ----
const adSearchForward = 1
const adSearchBackward = -1

'---- ConnectPromptEnum Values ----
const adPromptAlways = 1
const adPromptComplete = 2
const adPromptCompleteRequired = 3
const adPromptNever = 4

'---- ConnectModeEnum Values ----
const adModeUnknown = 0
const adModeRead = 1
const adModeWrite = 2
const adModeReadWrite = 3
const adModeShareDenyRead = 4
const adModeShareDenyWrite = 8
const adModeShareExclusive = &Hc
const adModeShareDenyNone = &H10

'---- IsolationLevelEnum Values ----
const adXactUnspecified = &Hffffffff
const adXactChaos = &H00000010
const adXactReadUncommitted = &H00000100
const adXactBrowse = &H00000100
const adXactCursorStability = &H00001000
const adXactReadCommitted = &H00001000
const adXactRepeatableRead = &H00010000
const adXactSerializable = &H00100000
const adXactIsolated = &H00100000

'---- XactAttributeEnum Values ----
const adXactCommitRetaining = &H00020000
const adXactAbortRetaining = &H00040000

'---- PropertyAttributesEnum Values ----
const adPropNotSupported = &H0000
const adPropRequired = &H0001
const adPropOptional = &H0002
const adPropRead = &H0200
const adPropWrite = &H0400

'---- ErrorValueEnum Values ----
const adErrInvalidArgument = &Hbb9
const adErrNoCurrentRecord = &Hbcd
const adErrIllegalOperation = &Hc93
const adErrInTransaction = &Hcae
const adErrFeatureNotAvailable = &Hcb3
const adErrItemNotFound = &Hcc1
const adErrObjectInCollection = &Hd27
const adErrObjectNotSet = &Hd5c
const adErrDataConversion = &Hd5d
const adErrObjectClosed = &He78
const adErrObjectOpen = &He79
const adErrProviderNotFound = &He7a
const adErrBoundToCommand = &He7b
const adErrInvalidParamInfo = &He7c
const adErrInvalidConnection = &He7d
const adErrStillExecuting = &He7f
const adErrStillConnecting = &He81

'---- ParameterAttributesEnum Values ----
const adParamSigned = &H0010
const adParamNullable = &H0040
const adParamLong = &H0080

'---- ParameterDirectionEnum Values ----
const adParamUnknown = &H0000
const adParamInput = &H0001
const adParamOutput = &H0002
const adParamInputOutput = &H0003
const adParamReturnValue = &H0004

'---- CommandTypeEnum Values ----
const adCmdUnknown = &H0008
const adCmdText = &H0001
const adCmdTable = &H0002
const adCmdStoredProc = &H0004

'---- SchemaEnum Values ----
const adSchemaProviderSpecific = -1
const adSchemaAsserts = 0
const adSchemaCatalogs = 1
const adSchemaCharacterSets = 2
const adSchemaCollations = 3
const adSchemaColumns = 4
const adSchemaCheckConstraints = 5
const adSchemaConstraintColumnUsage = 6
const adSchemaConstraintTableUsage = 7
const adSchemaKeyColumnUsage = 8
const adSchemaReferentialContraints = 9
const adSchemaTableConstraints = 10
const adSchemaColumnsDomainUsage = 11
const adSchemaIndexes = 12
const adSchemaColumnPrivileges = 13
const adSchemaTablePrivileges = 14
const adSchemaUsagePrivileges = 15
const adSchemaProcedures = 16
const adSchemaSchemata = 17
const adSchemaSQLLanguages = 18
const adSchemaStatistics = 19
const adSchemaTables = 20
const adSchemaTranslations = 21
const adSchemaProviderTypes = 22
const adSchemaViews = 23
const adSchemaViewColumnUsage = 24
const adSchemaViewTableUsage = 25
const adSchemaProcedureParameters = 26
const adSchemaForeignKeys = 27
const adSchemaPrimaryKeys = 28
const adSchemaProcedureColumns = 29
%>
