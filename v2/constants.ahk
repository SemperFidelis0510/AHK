SetWorkingDir %A_ScriptDir%
#Include utils.ahk

global debug := 0
global AsAdmin := 0
global math_activation := "3209-0499-VQYQQU"
global watchlist := []
global hotstrings := {}
global focus := new BB()
global layout = 0
global equ := []
global bm := []
global ref_cache := {}

global programming
GroupAdd, programming, ahk_exe SciTE.exe
GroupAdd, programming, ahk_exe pycharm64.exe
GroupAdd, programming, ahk_exe Mathematica.exe
GroupAdd, programming, ahk_exe hh.exe
GroupAdd, programming, ahk_exe EXCEL.EXE
GroupAdd, programming, ahk_exe notepad++.exe

global communication
GroupAdd, communication, WhatsApp
GroupAdd, communication, ahk_exe OUTLOOK.exe
GroupAdd, communication, ahk_exe Discord.exe


global screens := {"Xrange": [], "Yrange": [], "dim": [], "COM": []
					,"names": ["left", "right", "right"]
					,"order": ["\\.\DISPLAY1", "\\.\DISPLAY2", "\\.\DISPLAY2"]
					, "enum": [], "comm": 2}

get_screens_data(screens, debug)

Switch A_ComputerName{
	;~ Case "PHYAROM2":
	;~ Case "ZEUS2":
	Case "CHRONOS6":
		screens["names"] := ["wacom", "main", "secondary"]
		screens["comm"] := 1
		SysGet, scr, MonitorPrimary
		sysget, scr, MonitorName, scr
		If (scr="\\.\DISPLAY9")
			screens["order"] := ["\\.\DISPLAY9", "\\.\DISPLAY1", "\\.\DISPLAY8"]
		Else
			screens["order"] := ["\\.\DISPLAY5", "\\.\DISPLAY1", "\\.\DISPLAY4"]
}
scr :=


global HS := {}
HS["mgmail"] := "mtavor556@gmail.com"
HS["mtech"] := "btavor@campus.technion.ac.il"
HS["zipcode"] := "3670041"
HS["lastcc"] := "359297"
HS["myid"] := "204882203"
HS["lizid"] := "206151219"
HS["myphone"] := "0526603463"
HS["lizphone"] := "0526512327"





