Set sSA = CreateObject("Shell.Application")

Set Args = WScript.Arguments

SSA.ShellExecute "java", "-jar "& Chr(34) & Args(0) & Chr(34) & " uac", "", "runas", 0