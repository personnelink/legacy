<HTML>
<HEAD>

<SCRIPT type="text/javascript" LANGUAGE="JavaScript">
  function executeCommands(inputparms)
  {
  // Instantiate the Shell object and invoke its execute method.

    var oShell = new ActiveXObject("Shell.Application");

    var commandtoRun = "C:\\WINDOWS\\Notepad.exe";
    if (inputparms != "")
     {
      var commandParms = document.Form1.filename.value;
     }

 // Invoke the execute method.
     oShell.ShellExecute(commandtoRun, commandParms, "", "open", "1");
  }
</SCRIPT>

</HEAD>

<BODY>
        <FORM name="Form1">
        <CENTER>
        <BR><BR>
        <H1>Execute PC Commands From HTML </H1>
        <BR><BR>
        <File Name to Open:> <Input type="text" name="filename" size="20"/>
        <BR><BR>
        <input type="Button" name="Button1" value="Run Notepad.exe"
onClick="executeCommands()" />

        <BR><BR>
        <input type="Button" name="Button2" value="Run Notepad.exe with
Parameters" onClick="executeCommands(' + hasPARMS + ')" />
        </CENTER>
        </FORM>
</BODY>

</HTML> 