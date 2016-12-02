#
# Script to create the installation program for openwiking software.
#

Name "openwiking"
BrandingText "openwiking"
ComponentText "This will install OpenWikiNG"
DirText "Setup has determined the optimal location to install. If you would like to change the directory, do so now."

LicenseText "openwiking is a free product. Please read the license terms below before installing."
LicenseData ..\LICENSE.txt

OutFile OpenWiking.exe

CRCCheck on

EnabledBitmap checked.bmp
DisabledBitmap unchecked.bmp
Icon "main.ico"
UninstallIcon uninst.ico
UninstallText "Uninstall openwiking Now!"

InstType Full

Section "Programs (required)"
    SectionIn 1

    SetOverwrite on
    SetOutPath $INSTDIR
    File ..\README.txt
    File ..\LICENSE.txt
    File ..\INSTALL.txt
    File ..\CHANGES.txt
    SetOutPath $INSTDIR\installer
    File ..\installer\build.bat
    File ..\installer\checked.bmp
    File ..\installer\unchecked.bmp
    File ..\installer\main.ico
    File ..\installer\uninst.ico
    File ..\installer\openwiking.nsi
    File ..\installer\virtdir.vbs
    File ..\installer\virtdir.html
    SetOutPath $INSTDIR\data
    File ..\data\*.sql
    File ..\data\OpenWiking.mdb
    SetOutPath $INSTDIR\owbase
    File ..\owbase\*.*
    SetOutPath $INSTDIR\owbase\ow
    File ..\owbase\ow\*.*
    SetOutPath $INSTDIR\owbase\ow\css
    File ..\owbase\ow\css\*.*
    SetOutPath $INSTDIR\owbase\ow\images
    File ..\owbase\ow\images\*.*
    SetOutPath $INSTDIR\owbase\ow\images\icons
    File ..\owbase\ow\images\icons\*.*
    SetOutPath $INSTDIR\owbase\ow\images\icons\doc
    File ..\owbase\ow\images\icons\doc\*.*
    SetOutPath $INSTDIR\owbase\ow\xsl
    File ..\owbase\ow\xsl\*.*

    SetOverwrite off
    SetOutPath $INSTDIR\owbase\ow\my
    File ..\owbase\ow\my\*.*

    SetOverwrite on
    SetOutPath $INSTDIR\web1
    File ..\web1\*.*
    CreateDirectory $INSTDIR\web1\attachments

#    SetOutPath $INSTDIR\web2
#    File ..\web2\*.*
#    CreateDirectory $INSTDIR\web2\attachments

    WriteRegStr HKEY_LOCAL_MACHINE "Software\openwiking" "InstallDir" $INSTDIR

    WriteUninstaller Uninstall.exe

    CreateShortCut "$SMPROGRAMS\openwiking\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "" 0
SectionEnd


Section "Sample Application"
    SectionIn 1
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking" "DBQ" $INSTDIR\data\OpenWiking.mdb
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking" "Description" "openwiking Distribution"
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking" "Driver" $SYSDIR\odbcjt32.dll
    WriteRegDWORD HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking" "DriverId" 25
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking" "FIL" "MS Access;"
    WriteRegDWORD HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking" "SafeTransactions" 0
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking" "UID" ""
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking\Engines\Jet" "ImplicitCommitSync" ""
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking\Engines\Jet" "UserCommitSync" "Yes"
    WriteRegDWORD HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking\Engines\Jet" "Threads" 3
    WriteRegStr HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\ODBC Data Sources" "OpenWiking" "Microsoft Access Driver (*.mdb)"

    ClearErrors
    ExecWait 'cscript //Nologo "$INSTDIR\installer\virtdir.vbs" -i'
    IfErrors VirtdirError VirtdirNoError
    VirtdirNoError:
        StrCpy $5 "1"
    VirtdirError:
SectionEnd


Section -PostInstall
    WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\openwiking" "DisplayName" "openwiking"
    WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\openwiking" "UninstallString" '"$INSTDIR\Uninstall.exe"'
SectionEnd


Section Uninstall
    DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\openwiking" "DisplayName"
    DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\openwiking" "UninstallString"
    DeleteRegKey HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\openwiking"

    DeleteRegValue HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\ODBC Data Sources" "OpenWiking"
    DeleteRegKey HKEY_LOCAL_MACHINE "Software\ODBC\ODBC.INI\OpenWiking"

    ExecWait 'cscript //Nologo "$INSTDIR\installer\virtdir.vbs" -uq'

    DeleteRegKey HKEY_LOCAL_MACHINE "Software\openwiking"

    RMDir  /r $INSTDIR
SectionEnd


Function .onInit
    StrCpy $1 $PROGRAMFILES 1 0
    StrCpy $INSTDIR $1:\openwiking
FunctionEnd


Function .onInstSuccess
    MessageBox MB_YESNO "View readme file?" IDNO NoReadme
    Exec 'notepad "$INSTDIR\README.txt"'
    NoReadme:
    StrCmp $5 "1" StartBrowser End
    StartBrowser:
    ExecShell "open" "$INSTDIR\installer\virtdir.html"
    End:
FunctionEnd


Function .onInstFailed
    Exec 'notepad "$INSTDIR\INSTALL.txt"'
FunctionEnd


#Function .onInit
#  StrCpy $9 0 ; we start on page 0
#FunctionEnd
#
#Function .onNextPage
#  StrCmp $9 1 "" noabort
#  MessageBox MB_YESNO "Before installing openwiking you must have the following components installed:$\n$\n        MS ADO.DB v2.5 or higher$\n        VBScript v5.5 or higher$\n        MSXML v3 SP2 or higher$\n        A Web Server (i.e. IIS)$\n$\nDo you want to continue?" IDYES noabort
#      Abort
#  noabort:
#    IntOp $9 $9 + 1
#FunctionEnd

