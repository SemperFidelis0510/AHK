; #NoEnv
; SendMode, input
#Include Lib/utils.ahk

global debug := 0 ; 0, 1, 2, browser, cmd, pathobj, pathobj_call, screen
global AsAdmin := 1
global env_mode := "std" ; "std", "work", "game", "organize", "debug", "studies" TODO: better keyboard interface
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
global HS := {}
global control_groups := {"programming": ["SciTE.exe", "cursor.exe", "pycharm64.exe", "Mathematica.exe", "hh.exe", "EXCEL.exe", "notepad++.exe", "notepad.exe"]
						, "communication": ["WhatsApp", "OUTLOOK.exe", "Discord.exe", "ms-teams.exe"]
						, "documents": ["notepad.exe", "EXCEL.exe", "WINWORD.exe", "PDFXEdit_NoPrintIsolation.exe", "PDFXEdit.exe", "AcroRd32.exe", "ONENOTE.exe"]
						, "internet": ["msedge.exe", "chrome.exe"]}


global programming
global communication
global documents
global internet


;~ turn screen to class
global screens := {"Xrange": [], "Yrange": [], "dim": [], "COM": []
					,"names": ["left", "right", "right"]
					,"order": []
					, "enum": [], "comm": 2, "main": 0}




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


global KeyMapDict := {"std": {"#d": ["Discord"], "#m": ["OUTLOOK"]}
					,"work": {}
					,"game": {}
					,"organize": {}
					,"debug": {}
					,"studies": {}}

