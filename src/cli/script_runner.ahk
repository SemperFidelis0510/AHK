;~ #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;~ SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;~ #Include std.ahk
;~ #Persistent



#1::
	out := FileOpen("*", "w")
	text := "abc"
	out.write(text)
	out.close()
	;~ FileAppend, %text%, *
	return
	;~ ExitApp

#2::
	inp := FileOpen("*", "r")
	text := stdinp.read()
	inp.close()
	msgbox % stdinp
	return

#3::
	stdinp = %1%
	msgbox % stdinp
	return

#4::
	Shell := ComObjCreate("WScript.Shell")
	Exec := Shell.Exec(A_AhkPath " *") ; Passing * as the first parameter to AHK tells it to read from StdIn
	Exec.StdIn.Write("MsgBox, Hello")
	Exec.StdIn.Close()




