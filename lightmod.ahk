#NoEnv
#Warn
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
SetCapsLockState, alwaysoff
SetNumLockState, alwayson
#InstallKeybdHook
;~ if not A_IsAdmin
	;~ Run, *RunAs autohotkey.exe "%A_ScriptFullPath%"
#include context_menu.ahk
#include utils.ahk

#Include hotstrings.ahk

Insert::return

; program browsers
#q:: browser("Chrome", "window") ; chrome browser
#w:: browser("SumatraPDF", "tab") ; PDF browser
#e:: browser("LyX", "tab") ; LyX browser
#f:: browser("CabinetWClass", "folder") ; folder browser
#s:: browser("programming", "group") ; programming softwares
#a:: browser("communication", "group", screens["comm"])  ; communication programs
#n:: browser("ONENOTE",, 2) ; onenote
#NumLock:: browser("calc", "setting") ; calculator

; system settigns
*CapsLock:: browser("cmd") ; cmd
#F1:: browser("ms-settings:apps-volume", "setting") ; sound settings


; window shape and location
#Numpad1::  place_window(1) ; move to TV
#Numpad2::  place_window(2) ; move to Wacom
#Numpad3::  place_window(3) ; move to main screen
#Numpad5::  place_window("max")
#Numpad0:: place_window("unmax")
#NumpadSub::  place_window("min")
#NumpadAdd::  place_window("unmin")


; spotify control
#Ins::Spotify("run")

#If
#`:: hub()

#If (comp = 2)
AppsKey & Insert:: Media_Play_Pause
AppsKey & Delete:: Media_Stop
AppsKey & Home:: Media_Next
AppsKey & End:: Media_Prev
AppsKey & PgUp:: Volume_Up
AppsKey & PgDn:: Volume_Down
AppsKey & WheelUp:: Volume_Up
AppsKey & WheelDown:: Volume_Down

#If (get_lang()="HE")
~+::SetCapsLockState, on
~+ UP::SetCapsLockState, AlwaysOff

