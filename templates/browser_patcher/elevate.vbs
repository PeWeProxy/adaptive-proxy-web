Set sSA = CreateObject("Shell.Application")

Set Args = WScript.Arguments

SSA.ShellExecute "java", "-jar " & Args(0), "", "runas", 0