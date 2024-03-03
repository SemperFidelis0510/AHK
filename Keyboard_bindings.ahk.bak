;### Initialization

;~ #Requires AutoHotkey v2.0
#NoEnv
#Warn
#SingleInstance Force
SendMode, input
SetCapsLockState, alwaysoff
SetNumLockState, alwayson
SetScrollLockState, AlwaysOff
SetTitleMatchMode, 1
CoordMode, Mouse, screen

EnvGet, pandora, Pandora
SetWorkingDir, %pandora%\ahk

#Include functions.ahk
If debug
	#Include analytic.ahk

If AsAdmin and not A_IsAdmin
	Run, *RunAs autohotkey.exe "%A_ScriptFullPath%" /restart

;~ Run watchdog.ahk


;### General
render_hotstrings(HS)
Insert::return
#RButton UP::context_menu("show")
;~ XButton2::clip_to_mouse(paths)
#Escape::close_win()

;~ $XButton1::voice_to_chatgpt()
;~ $XButton2::send, {Alt}{Shift}{b}


;### Script Control
#Pause::Pause
+#Pause::ExitApp
#ScrollLock::Edit_SciTe(paths)
+#ScrollLock:: Reload_SciTE(paths)



;~ Scripts
#F1::
	tick := A_TickCount
	return
#F1 Up::
	tock := A_TickCount - tick
	if (tock>30)
		SearchWeb(, "google", 1)
	else
		listen(paths)

	return
;~ #F2::RunScript("voiceControl")
;~ #F3::ChatGPT()


;~ UI
;~ XButton1::Browser_Back
;~ XButton2::Browser_Forward


;~ #Numpad6::!Tab
;~ #Numpad4 Up::AltTab
;~ NumLock::rainmeter()

; program browsers
#q:: browser(paths, "internet", "group") ; internet browsers ~ fix path
#w:: browser(paths, "PDFXEdit", "tab") ; PDF browser
#e:: browser(paths, "LyX", "tab") ; LyX browser
#f:: browser(paths, "CabinetWClass", "folder") ; folder browser ~ fix path
#s:: browser(paths, "programming", "group") ; programming softwares
#a:: browser(paths, "WhatsApp", "winname",, 2)  ; communication programs ~ fix path
#d:: browser(paths, "Discord") ; discord
#m:: browser(paths, "OUTLOOK")  ; mail ~ fix window
#n:: browser(paths, "ONENOTE",, 2) ; onenote
#1:: browser(paths, "cmd", "window")
#y:: browser(paths, "youtube", "site")
#`:: browser(paths, "chatgpt", "window",, 1)
*CapsLock:: Run, *RunAs cmd

; system settigns
#F2::  browser(paths, "ms-settings:apps-volume", "setting") ; sound settings
#^F2:: browser(paths, "mmsys.cpl", "setting")
;~ #F3::  browser(paths, "ms-settings:appsfeatures-app", "setting")
#^F3:: browser(paths, "ms-settings:about", "setting")
;~ #F4::  browser(paths, "ms-settings:display", "setting")
;~ #F5::  browser(paths, "ms-settings:windowsupdate", "setting")

; window shape and location
#Numpad1::   place_window(1) ; move to TV
#Numpad2::   place_window(2) ; move to Wacom
#Numpad3::   place_window(3) ; move to main screen
#Numpad5::   place_window("max")
#Numpad0::   place_window("unmax")
#NumpadSub:: place_window("min")
#NumpadAdd:: place_window("unmin")

; Media control
#Ins::      Spotify(paths, "run") ; ~ fix path
;~ >#End::     Spotify(paths, "like song")
;~ >#PgUp::    Spotify(paths, "save to playlist")
;~ >#PgDn::    Spotify(paths, "play playlist")
#WheelUp::  Volume_Up
#WheelDown::Volume_Down
#MButton::  Media_Play_Pause


; contextual
;~ #IfWinActive ahk_exe WhatsApp.exe
;~ #`::send_love_emojis()
#IfWinActive ahk_exe ChatGPT.exe
Enter:: Send, +{Enter}
^Enter:: Send, {Enter}
^D::MClick(-987, 827)
#IfWinActive ahk_exe SciTE.exe
F1::Help_SciTE()
^R::reload
#IfWinActive ahk_exe PDFXEdit.exe
NumLock::
	WinActivate, ahk_exe winword.exe
	Sleep, 100
	Send, {F12}
F11::
	ControlSend,, ^{F11}, ahk_exe PDFXEdit.exe
	if (paths.computer[1]!="ZEUS2")
		ControlSend,, {z}, ahk_exe PDFXEdit.exe
	return
#If
#NumLock:: browser(paths, "calc", "setting") ; calculator


#If (paths.computer[1] != "CHRONOS6")
AppsKey & Insert::    Media_Play_Pause
AppsKey & Delete::    Media_Stop
AppsKey & Home::      Media_Next
AppsKey & End::       Media_Prev
AppsKey & PgUp::      Volume_Up
AppsKey & PgDn::      Volume_Down
AppsKey & WheelUp::   Volume_Up
AppsKey & WheelDown:: Volume_Down

#If (DetectLang()="HE")
~+::   SetCapsLockState, on
~+ UP::SetCapsLockState, AlwaysOff

#If debug
#1::  get_pressed_key()
^#1:: get_pressed_key(1)
#2::  get_activeWin_hwnd()
#3::  enum_screens()
#4::  get_mouse_pos()
#5::  name_computer()

#If








