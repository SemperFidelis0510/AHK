#NoEnv
SendMode, input
SetWorkingDir %A_ScriptDir%
#Include utils.ahk

global debug := 0 ; 0, 1, 2, browser, cmd, pathobj, pathobj_call, screen
global AsAdmin := 1
global env_mode := "std" ; "std", "work", "game"
global math_activation := "3209-0499-VQYQQU"
global watchlist := []
global hotstrings := {}
global focus := new BB()
global layout = 0
global equ := []
global bm := []
global ref_cache := {}
global TTState := ""
global Null := False
global group_names := ["programming", "communication", "documents", "internet"]
global comp_names := ["CHRONOS7", "ZEUS2", "HEPHAESTUS", "PHYAROM2"]
;~ global groups := {"programming": programming, "communication": communication}
global HS := {}
global control_groups := {"programming": ["SciTE.exe", "pycharm64.exe", "Mathematica.exe", "hh.exe", "EXCEL.exe", "notepad++.exe", "notepad.exe"]
						, "communication": ["WhatsApp", "OUTLOOK.exe", "Discord.exe", "ms-teams.exe"]
						, "documents": ["notepad.exe", "EXCEL.exe", "WINWORD.exe", "PDFXEdit_NoPrintIsolation.exe", "AcroRd32.exe", "ONENOTE.exe"]
						, "internet": ["msedge.exe", "chrome.exe"]}


global programming
global communication
global documents
global internet
;~ for group, g_list in control_groups {
	;~ for _, program in g_list {
		;~ if InStr(program, "exe")
			;~ GroupAdd, %group%, ahk_exe %program%
		;~ else
			;~ GroupAdd, %group%, %program%
	;~ }
;~ }


;~ GroupAdd, programming, ahk_exe SciTE.exe
;~ GroupAdd, programming, ahk_exe pycharm64.exe
;~ GroupAdd, programming, ahk_exe Mathematica.exe
;~ GroupAdd, programming, ahk_exe hh.exe
;~ GroupAdd, programming, ahk_exe EXCEL.EXE
;~ GroupAdd, programming, ahk_exe notepad++.exe
;~ GroupAdd, programming, ahk_exe notepad.exe

;~ GroupAdd, communication, WhatsApp
;~ GroupAdd, communication, ahk_exe OUTLOOK.exe
;~ GroupAdd, communication, ahk_exe Discord.exe
;~ GroupAdd, communication, ahk_exe ms-teams.exe


;~ GroupAdd, documents, ahk_exe notepad.exe
;~ GroupAdd, documents, ahk_exe EXCEL.exe
;~ GroupAdd, documents, ahk_exe WINWORD.exe
;~ GroupAdd, documents, ahk_exe PDFXEdit_NoPrintIsolation.exe
;~ GroupAdd, documents, ahk_exe AcroRd32.exe
;~ GroupAdd, documents, ahk_exe ONENOTE.exe


;~ GroupAdd, internet, ahk_exe msedge.exe
;~ GroupAdd, internet, ahk_exe chrome.exe


;~ turn screen to class
global screens := {"Xrange": [], "Yrange": [], "dim": [], "COM": []
					,"names": ["left", "right", "right"]
					,"order": []
					, "enum": [], "comm": 2}



;~ Switch A_ComputerName{
	;~ Case "PHYAROM2":
	;~ Case "ZEUS2":

	;~ Case "HEPHAESTUS":
		;~ screens["order"] := ["\\.\DISPLAY3", "\\.\DISPLAY2", "\\.\DISPLAY1"]
		;~ screens["order"] := ["\\.\DISPLAY3", "\\.\DISPLAY2", "\\.\DISPLAY1"]
	;~ Case "CHRONOS7":
		;~ screens["names"] := ["wacom", "main", "secondary"]
		;~ screens["comm"] := 1
		;~ SysGet, scr, MonitorPrimary
		;~ sysget, scr, MonitorName, scr
		;~ If scr in \\.\DISPLAY9,\\.\DISPLAY1,\\.\DISPLAY8
			;~ screens["order"] := ["\\.\DISPLAY9", "\\.\DISPLAY1", "\\.\DISPLAY8"]
		;~ Else
			;~ screens["order"] := ["\\.\DISPLAY5", "\\.\DISPLAY1", "\\.\DISPLAY4"]
;~ }
;~ scr :=

;~ for scr_ind in screens["order"] {
	;~ msgbox % scr_ind
;~ }

global SearchEngines := {}
SearchEngines["google"] := "http://www.google.com/search?q="
SearchEngines["bing"] := "https://www.bing.com/search?q="
SearchEngines["books"] := "https://libgen.li/index.php?req="
SearchEngines["translateEn>He"] := "https://translate.google.com/?sl=en&tl=iw&op=translate&text="
SearchEngines["translateHe>En"] := "https://translate.google.com/?sl=iw&tl=en&op=translate&text="
SearchEngines["wikipedia"] := "https://en.wikipedia.org/w/index.php?title=Special%3ASearch&search="
SearchEngines["torrent"] := "https://rarbgtor.org/torrents.php?search="
SearchEngines["ahk"] := "https://www.autohotkey.com/docs/v1/lib/"
SearchEngines["youtube"] := "https://www.youtube.com/results?search_query="
SearchEngines["confluence"] := "https://confluence.nvidia.com/dosearchsite.action?cql=siteSearch+~+"



