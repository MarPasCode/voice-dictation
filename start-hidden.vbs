' Launches the Node server (server.js) with no visible console window.
Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
' Folder this script lives in, so the server starts from the right working directory.
strPath = fso.GetParentFolderName(WScript.ScriptFullName)
objShell.CurrentDirectory = strPath
objShell.Run "node server.js", 0, False
