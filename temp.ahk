#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleinstance force
#Include %A_ScriptDir%
;~ #include functions.ahk
;~ #include paths.ahk
CoordMode, Mouse, Client

*LButton::LButton


;~ #1::
;~ {
	;~ WinActivate, ahk_exe chrome.exe
	;~ ControlClick, X488 Y884, ahk_exe chrome.exe
	;~ sleep, 200
	;~ Send, {text}100
	;~ sleep, 200
	;~ ControlClick, X923 Y972, ahk_exe chrome.exe
	;~ return
;~ }


;~ NumpadEnter::
;~ {
	;~ Send, {-}{0}{Enter}{e}
	;~ return
;~ }
;~ NumpadEnter::
;~ {
	;~ SendRaw, +'s'
	;~ Send, {Enter}{e}{Enter}{e}{+}
	;~ return
;~ }
;~ NumpadDot::
;~ {
	;~ SendRaw, -'dn'
	;~ Send, {Enter}{e}
	;~ return
;~ }
;~ NumpadMult::
;~ {
	;~ SendRaw, -'dnr'
	;~ Send, {Enter}{e}
	;~ return
;~ }
;~ NumpadAdd::
;~ {
	;~ Send, {+}{0}{Enter}{e}{Enter}{e}{+}
	;~ return
;~ }
;~ NumpadSub::
;~ {
	;~ Send, {-}{0}{Enter}{e}
	;~ return
;~ }
;~ ^Numpad1:: SendRaw -'r1'
;~ ^Numpad2:: SendRaw -'r2'
;~ ^Numpad3:: SendRaw -'r3'
;~ ^Numpad4:: SendRaw -'r4'
;~ ^Numpad5:: SendRaw -'r5'
;~ ^Numpad6:: SendRaw -'r6'
;~ ^Numpad7:: SendRaw -'r7'
;~ ^Numpad8:: SendRaw -'r8'
;~ ^Numpad9:: SendRaw -'r9'

;~ NumpadEnter::
;~ {
	;~ Send, {Enter}
	;~ SendRaw, e*
	;~ return
;~ }





;~ MsgBox, % GetKeyName("LWin")
;~ Hotkey, #o, % Func("pdf_to_favorite")

;~ pdf_to_favorite(){
	;~ f_ind := LTrim(A_ThisHotkey, "^Numpad")
	;~ send, ^g
	;~ send, % bookmarks[%f_ind%]
	;~ send, {enter}
	;~ return
;~ }

;~ Numpad0:: Send {0}{Enter}
;~ Numpad2:: Send {2}{Enter}
;~ Numpad3:: Send {3}{Enter}
;~ Numpad4:: Send {4}{Enter}
;~ Numpad5:: Send {5}{Enter}
;~ Numpad6:: Send {6}{Enter}
;~ Numpad7:: Send {7}{Enter}
;~ Numpad8:: Send {8}{Enter}
;~ Numpad9:: Send {9}{Enter}
;~ NumpadAdd:: Send {a}{Enter}
;~ NumpadSub:: Send {n}{Enter}
;~ NumpadDiv:: Send {g}{Enter}
