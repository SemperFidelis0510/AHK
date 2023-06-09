#Warn
;~ #Requires AutoHotkey v2.0

SetCapsLockState alwaysoff
SetNumLockState alwayson
SetScrollLockState AlwaysOff
EnvGet pandora, Pandora
SetWorkingDir % pandora . "\ahk"%
#Include functions.ahk
If AsAdmin and not A_IsAdmin
	Run *RunAs autohotkey.exe "%A_ScriptFullPath%" /restart
If debug
	#Include analytic.ahk

;~ Run watchdog.ahk

; etc.
render_hotstrings(HS)
Insert::return
#RButton UP::context_menu("show")
XButton1::clip_to_mouse()
#Escape::close_win()
Pause::Pause
#Pause::ExitApp
ScrollLock::Edit

;~ #Numpad6::!Tab
;~ #Numpad4 Up::AltTab
;~ NumLock::rainmeter()

; program browsers
#q:: browser("Chrome", "window") ; chrome browser
#w:: browser("PDFXEdit", "tab") ; PDF browser
#e:: browser("LyX", "tab") ; LyX browser
#f:: browser("CabinetWClass", "folder") ; folder browser
#s:: browser("programming", "group") ; programming softwares
#a:: browser("communication", "group", screens["comm"])  ; communication programs
#d:: browser("Discord",, 1) ; discord
#m:: browser("OUTLOOK",, 1)  ; mail
#n:: browser("ONENOTE",, 2) ; onenote
#NumLock:: browser("calc", "setting") ; calculator

; system settigns
*CapsLock:: browser("cmd", "window")
#^F1:: browser("regedit", "setting") ; regedit
#F1::  browser("devmgmt.msc", "setting") ;device manager
#!F1:: browser("compmgmt.msc", "setting") ; computer manager
#F2::  browser("ms-settings:apps-volume", "setting") ; sound settings
#^F2:: browser("mmsys.cpl", "setting")
#F3::  browser("ms-settings:appsfeatures-app", "setting")
#^F3:: browser("ms-settings:about", "setting")
#F4::  browser("ms-settings:display", "setting")
#F5::  browser("ms-settings:windowsupdate", "setting")

; window shape and location
#Numpad1::   place_window(1) ; move to TV
#Numpad2::   place_window(2) ; move to Wacom
#Numpad3::   place_window(3) ; move to main screen
#Numpad5::   place_window("max")
#Numpad0::   place_window("unmax")
#NumpadSub:: place_window("min")
#NumpadAdd:: place_window("unmin")

; spotify control
#Ins::      Spotify("run")
>#End::     Spotify("like song")
>#PgUp::    Spotify("save to playlist")
>#PgDn::    Spotify("play playlist")
#WheelUp::  Volume_Up
#WheelDown::Volume_Down
#MButton::  Media_Play_Pause


#IfWinActive ahk_exe WhatsApp.exe
#`::send_love_emojis()
#IfWinActive ahk_exe SciTE.exe
^R:: Reload_SciTE()
F1::Run, https://www.autohotkey.com/docs/v1/KeyList.htm
#IfWinActive ahk_exe PDFXEdit.exe
F11::Send, ^{F11}{z}
#If
#`:: listen()

#If (comp != 1)
AppsKey & Insert::    Media_Play_Pause
AppsKey & Delete::    Media_Stop
AppsKey & Home::      Media_Next
AppsKey & End::       Media_Prev
AppsKey & PgUp::      Volume_Up
AppsKey & PgDn::      Volume_Down
AppsKey & WheelUp::   Volume_Up
AppsKey & WheelDown:: Volume_Down

#If (get_lang()="HE")
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










