;### Initialization
;~ #Requires AutoHotkey v2.0
#NoEnv
#Warn
#SingleInstance Force

#Include init.ahk

;~ ### TODOs
;~ change paths to global variable in functions
;~ sort functions and utils


;~ #o:: my_func()

;### General
Insert::return
CapsLock::return
#CapsLock::~CapsLock
#Escape::close_win()


^#Numpad1:: change_env_mode(paths, "std")
^#Numpad2:: change_env_mode(paths, "work")
^#Numpad3:: change_env_mode(paths, "game")
^#Numpad4:: change_env_mode(paths, "organize")
^#Numpad5:: change_env_mode(paths, "debug")
^#Numpad6:: change_env_mode(paths, "studies")


;### Script Control
#Pause::Pause
+#Pause::ExitApp
#ScrollLock::Edit_SciTe(paths)
ScrollLock:: Reload_SciTE(paths)



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

; program browsers
#1:: browser(paths, "cmd", "window")
^#1:: Run % paths["cmd"]
#2:: browser(paths, "documents", "group")
#3:: browser(paths, "programming", "group") ; programming softwares
#4:: browser(paths, "communication", "group")


#q:: browser(paths, "internet", "group") ; internet browsers
#a:: browser(paths, "WhatsApp", "winname",, 2)  ; communication programs ~ fix path
#f:: browser(paths, "CabinetWClass", "folder") ; TODO: fix path. make path env_mode specific. go between tabs

#NumLock:: browser(paths, "Calculator", "winname")

;~ #y:: browser(paths, "youtube", "site") ; TODO: fix

#If (env_mode="std")
	#d:: browser(paths, "Discord") ; discord
	#m:: browser(paths, "olk")  ; mail
	#n:: browser(paths, "ONENOTE") ; onenote
	#s:: browser(paths, "programming", "group") ; programming softwares

#If (env_mode="work")
	#w:: browser(paths, "vncviewer") ; vncviewer
	#e:: browser(paths, "ms-teams")
	#t:: browser(paths, "Microsoft To Do", "winname",, 2)
	#d:: browser(paths, "documents", "group")
	#n:: browser(paths, "ONENOTE")
	;~ #m:: browser(paths, "olk")
	#m:: browser(paths, "OUTLOOK")
	#s:: browser(paths, "programming", "group") ; programming softwares
	#v:: browser(paths, "vpnui")
	;~ #`:: browser(paths, "copilot", "site",0 , 1)
	#`:: browser(paths, "copilot", "window",0 , 1)
#If (env_mode!="work")
	#`:: browser(paths, "copilot", "window",0 , 1)

#If (env_mode="game")
	#d:: browser(paths, "Discord")
	#s:: browser(paths, "SC2_x64")
	#b:: browser(paths, "Battle.net")
	#h:: browser(paths, "HeroesOfTheStorm_x64")
	#m:: browser(paths, "MTGA")
#If (env_mode!="game")
	$XButton2::SearchWeb(,,1)
	#XButton2::SearchWeb(,,1,0)

#If (env_mode="organize")
	#m:: browser(paths, "olk")

#If (env_mode="debug")
	#1::  get_pressed_key()
	^#1:: get_pressed_key(1)
	#2::  get_activeWin_hwnd()
	#3::  enum_screens()
	#4::  get_mouse_pos()
	#5::  name_computer()

	#s:: browser(paths, "programming", "group") ; programming softwares

	; system settigns
	#F2::  browser(paths, "ms-settings:apps-volume", "setting") ; sound settings
	#^F2:: browser(paths, "mmsys.cpl", "setting")
	#F3::  browser(paths, "ms-settings:appsfeatures-app", "setting")
	#^F3:: browser(paths, "ms-settings:about", "setting")
	#F4::  browser(paths, "ms-settings:display", "setting")
	#F5::  browser(paths, "ms-settings:windowsupdate", "setting")

#If (env_mode="studies")
	#e:: browser(paths, "LyX", "tab") ; LyX browser
	#w:: browser(paths, "PDFXEdit", "tab") ; PDF browser
	#s:: browser(paths, "programming", "group") ; programming softwares


#If


; window shape and location
#Numpad1::   place_window(1) ; move to TV
#Numpad2::   place_window(2) ; move to Wacom
#Numpad3::   place_window(3) ; move to main screen
#Numpad5::   place_window("max")
#NumpadSub::   place_window("unmax")
#NumpadDot::   min_all_wins()
#Numpad0:: place_window("min")
#NumpadAdd:: place_window("unmin")


; Media control
#Ins::      Spotify(paths, "run")
#Home::     Spotify(paths, "like_song")
#End::      Spotify(paths, "shuffle")
#WheelUp::  Volume_Up
#WheelDown::Volume_Down
#MButton::  Media_Play_Pause


; contextual
;~ #IfWinActive ahk_exe WhatsApp.exe
;~ #`::send_love_emojis()
#Include chatgpt.ahk
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



#If (paths.computer[1] != "CHRONOS7")
AppsKey & Insert::    Media_Play_Pause
AppsKey & Delete::    Media_Stop
AppsKey & Home::      Media_Next
AppsKey & End::       Media_Prev
AppsKey & PgUp::      Volume_Up
AppsKey & PgDn::      Volume_Down
AppsKey & WheelUp::   Volume_Up
AppsKey & WheelDown:: Volume_Down
#IF

#IF (DetectLang()="HE")
~+::   SetCapsLockState, on
~+ UP::SetCapsLockState, AlwaysOff
#IF



;~ ideas and draft
;~ #IfWinActive ahk_exe WhatsApp.exe
;~ #`::send_love_emojis()

;~ >#End::     Spotify(paths, "like song")
;~ >#PgUp::    Spotify(paths, "save to playlist")
;~ >#PgDn::    Spotify(paths, "play playlist")

;~ #F2::RunScript("voiceControl")
;~ #F3::ChatGPT()


;~ UI
;~ XButton1::Browser_Back
;~ XButton2::Browser_Forward

;~ NumLock::rainmeter()

;~ $XButton1::voice_to_chatgpt()
;~ $XButton2::send, {Alt}{Shift}{b}

;~ WheelRight::+^Tab
;~ WheelLeft::^Tab


;~ #RButton UP::context_menu("show") ; TODO: fix
;~ XButton2::clip_to_mouse(paths)