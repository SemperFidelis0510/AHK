#NoEnv
SendMode, input
SetWorkingDir %A_ScriptDir%
#include constants.ahk
#include utils.ahk
#Include analytic.ahk
#Include gui_menus.ahk

; ### Init
generateMenus() {
	global menu_list := {}
	menu_list["context"] := [["Use Text for...", ":search"]
							,["Open With...", ":runwith"]
							,["Analytics...", ":analytics"]]
	menu_list["context_lyx"] := [["Text...", ":search"]
								,["Open With...", ":runwith"]
								,["Analytics...", ":analytics"]
								,["LyX", ":lyx"]]

	;~ menu_list["context_sumatra"] := [["Text...", ":search"]
									;~ ,["Open With...", ":runwith"]
									;~ ,["Analytics...", ":analytics"]
									;~ ,["Sumatra", ":sumatra"]]

	menu_list["search"] := [["Search Google", "google"]
							,["Search Wikipedia", "wikipedia"]
							,["Search Books", "books"]
							,["Search Torrent", "torrent"]
							,["Search arXiv", "arxiv"]
							,["Translate", "translate"]]
	menu_list["runwith"] := [["cmd", "cmd"]
							,["Regedit", "regedit"]
							,["Explorer", "explorer"]]
	menu_list["analytics"] := [["Get Path", "path"]
							   ,["Window Spy", "winspy"]
							   ,["UIA Viewer", "UIAViewer"]]

	menu_list["LyX"] := [["Store Equation", "store_formula"]
						,["Save Macro", "save_macro"]
						,["Add Equation to Uranus", "append_uranus"]]
	menu_list["Sumatra"] := [["Save Page", "save_page"]
							,["Annotate", "annotate"]
							,["Save Reference", "save_ref"]
							,["Show Reference", "show_ref"]]

	create_menu("search")
	create_menu("runwith")
	create_menu("analytics")
	;~ create_menu("Sumatra")
	create_menu("LyX")

	create_menu("context")
	create_menu("context_lyx")

	global context, context_lyx, context_sumatra
	Menu, context, UseErrorLevel, On
	Menu, context_lyx, UseErrorLevel, On

	return
}


my_func() {
	local
	msgbox, % paths["ahk"]
	return
	}

; ideas
voice_to_chatgpt() {
	WinActivate, ahk_exe ChatGPT.exe
	MClick(-1139, 881)
	Send {LAlt down}{Shift down}{b}{LAlt up}{Shift up}
	return
}

class LyxConsole {
	NPHwnd := 0
	__New {
	}
}

Text2CMD() {
	return
}

Search(text:="") {
	local
	win := WinActive("A")
	WinGetTitle, win, ahk_id %win%

	if not text
		text := GetSelectedText()
	;~ if not text
		;~ double click cursor
	if not text
		InputBox, text, Search Query, What whould you like to search?

	switch win {
		case "programming":
			return
		case "pdf":
			return
		default:
			SearchWeb(, "google", 1)
	}
	return
}

class display {
	__New {
	}
}
;~ add text to rainmeter

LoadHotstrings(file) {
	local type, hotstrings
	type := check_file_type(file)

	switch type
	{
		case "ini":
			section := "general_hotstrings"
			hotstrings := parse_ini(file, section)
		;~ case "json":

	}
	return hotstrings
}


;### Sensors
listen(paths) {
	local cmd, args
	local prefix := "cmd"
	local boxsize := [800, 400]

	local commands := {"run": "Runs command or script via cmd."
					,"find": "Look for a program's location."
					,"search|:google/books/wikipedia/torrent/arxiv/translate": "Search site for text."
					,"open/get|new": "Opens/Gets newest file in folder."
					,"open/get|path": "Opens/Gets path of program or folder by name."
					;~ by folder
					,"add|path/hotstring": "Adds path or hotstring to AHK cache."}
	local msg := "Enter command:`n`n"
	For key, val in commands
		msg .= key . ":`n`t`t" . val . "`n`n"


	InputBox, args, Command Hub, %msg%,, % boxsize[1], % boxsize[2]
	If ErrorLevel
		return

	args := StrSplit(args, [" | ", " : ", "| ", ": ", " |", " :", "|", ":"])



	If (args.Length()=1)
		cmd := args.RemoveAt(1)
	Else {
		prefix := args.RemoveAt(1)
		cmd := args.RemoveAt(1)
	}

	Loop, args.Length()
	{
		if (args[%A_Index%]="clip")
			args[%A_Index%] := Clipboard
	}


	Switch prefix {
		Case "find":
			GetProgLocation(cmd)
		Case "search":
			SearchWeb(args[1], cmd)
		Case "get":
			Switch cmd {
				Case "new" | "newest":
					local OP := get_newest_file(args[1])
					Clipboard := OP["file"]
				Case "path":
					Clipboard := paths[args[1]]
			}
		Case "open":
			Switch cmd {
				Case "new" | "newest":
					local OP := get_newest_file(args[1])
					run % OP["file"]
				Case "path":
					if (args[1]="libraries")
						args[1] := "CabinetWClass"

					run % paths[args[1]]
			}
		Case "add":
			Switch cmd {
				Case "path":
					if InStr(args[2], ",")
					{
						local tmp := StrSplit(args[2], ",")
						args[2] := "paths[" . quote(tmp[1]) . "] . " . quote(tmp[2])
					}
					Else
						args[2] := quote(args[2])

					local line :=  "paths[" . quote(args[1]) . "] := " . args[2] . "`n"

					append_to_file(paths["ahk"] . "\path.ahk", line)
				Case "hotstring":
					local line :=  "::" . args[1] . "::" . args[2] . "`n"
					append_to_file(paths["ahk"] . "\hotstrings.ahk", line)
			}
		Case "run":
			run_cmd(paths, cmd, args)
		Default:
			browser(paths, "cmd")
	}

	return
}

fullscreen(fs:=1, win:="A") {
	local state
	win := WinExist(win)
	WinGet, prog, ProcessName, ahk_id %win%

	if (prog = "ONENOTE.EXE") {
		ControlGetPos,,, W,, OneNote::DocumentCanvas1, ahk_exe ONENOTE.exe
		if (W = 1921)
			state := 1
		else
			state := 0
	}
	else {
		wingetpos,,,, h, ahk_id %win%
		if (h = 1080)
			state := 1
		else
			state := 0
	}

	if (fs = "return")
		return state
	if (fs != state)
		ControlSend,, {F11}, ahk_id %win%

	return state
}

det_screen(Xcoo, Ycoo){
	local scr, Xin, Yin
	Loop % screens["count"]{
		Xin := 2*abs(Xcoo-screens["COM"][A_index][1])<screens["dim"][A_index][1]
		Yin := 2*abs(Ycoo-screens["COM"][A_index][2])<screens["dim"][A_index][2]
		if (Xin and Yin)
			return A_index
	}

}

get_clip_img(paths, path, name:=0) {
	local time := A_NowUTC
	local deb := 0
	run_cmd(paths, "themis", ["--saveclip", path, "--name", name], deb)
	path := get_newest_file(path, time)
	return path["file"]
}

capture_img(paths, path:=False, name:=0) {
	local
	if not path
		path := paths["memory"]
	else if (SubStr(path, 1, 1) = "\")
		path := paths["memory"] . path

	Send, +#{s}
	ClipWait, 20, 1
	Sleep, 4000

	file := get_clip_img(paths, path, name)
	return file
}

find_prog(paths, name) {
	local path1 := paths["startmenu"] . "\*.lnk"
	local path2 := paths["startmenuLocal"] . "\*.lnk"
	local targetPath, targetDir

	Loop, Files, %path1%, R
	{
		IfInString, A_LoopFileName, %name%
		{
			FileGetShortcut, %A_LoopFileFullPath%, targetPath, targetDir
			return {"dir": targetDir, "path": targetPath}
		}

	}

	Loop, Files, %path2%, R
	{
		IfInString, A_LoopFileName, %name%
		{
			FileGetShortcut, %A_LoopFileFullPath%, targetPath, targetDir
			return {"dir": targetDir, "path": targetPath}
		}

	}
	return
}

GetText(x:="",y:="") {
	local

	return text
}

SetGroup(win:="") {
	local
	if not win {
		win := WinActive("A")
		win := "ahk_id " . win
	}

	if (SubStr(win, 1, 3)!="ahk")
		win := "ahk_exe " . win

	for each, group in group_names {
		WinGet, tempID, ID, %win% ahk_group %group%
		if tempID
			return group
	}
	return False
}


;### Motors
run_cmd(paths, cmd, raw_args:=0, apperent:=0, admin:=0, work_dir:="", script:=0) {
	local key, val, x
	local args := []
	if not raw_args
		raw_args := []

	if (debug="cmd")
		apperent := 1

	if paths.scripts[cmd] {
		cmd := paths.scripts[cmd]
		script := true
	}
	else if (cmd = "")
		InputBox, cmd, "Command", "Enter command:"
	if (cmd = "")
		return

	cmd := format_cmd(cmd)
	if raw_args {
	For key, val in raw_args
			args[key] := format_cmd(val)
		cmd := join(,cmd, args*)
	}

	if script {
		if apperent
			cmd := "python " . cmd
		else
			cmd := "pythonw " . cmd

	}

	;~ if work_dir
		;~ cmd := "cd /d " . work_dir . "`n" . cmd

	if apperent
		cmd := " /k " . cmd
	else
		cmd := " /c " . cmd


	if apperent {
		msgbox, 6, Command to cmd, %cmd%
		Clipboard := cmd
	}

	if admin
		Run, *RunAs %comspec%%cmd%
	else
		Run, %comspec%%cmd%

	return
}

place_window(state:=1, Win:="A", resize:=0) {
	local aWin, s, i, j, scale, scr, windows
	Scale := 0.8
	aWin := WinActive(Win)
	if (not aWin)
	    return

	switch state {
		case "max":
			WinGet, min_max, MinMax, ahk_id %aWin%
			if (min_max=1)
				WinRestore, ahk_id %aWin%
			else
				WinMaximize, ahk_id %aWin%
			return
		case "min":
			WinGet, min_max, MinMax, ahk_id %aWin%
			if (min_max=-1)
				WinRestore, ahk_id %aWin%
			else
				WinMinimize, ahk_id %aWin%
			return
		case "unmax":
			WinGetPos, xpos, ypos, wid, hit, ahk_id %aWin%
			scr := det_screen(xpos+(wid/2), ypos+(hit/2))
			WinGet, min_max, MinMax, ahk_id %aWin%
			if (min_max = 1)
				WinRestore, ahk_id %aWin%
			WinMove, ahk_id %aWin%,,% screens["Xrange"][scr][1], % screens["Yrange"][scr][1]
									, % Scale*screens["dim"][scr][1], % Scale*screens["dim"][scr][2]
			return
		case "unmin":
			WinGet, windows, List
			Loop, %Windows% {
				i := Windows - A_Index + 1
				WinGet, min_max, MinMax, % "ahk_id" windows%i%
				if (min_max = -1) {
					WinActivate % "ahk_id" windows%i%
					WinWaitActive % "ahk_id" windows%i%
					return
				}
			}
			return
		case 1, 2, 3, 4:
			if (debug="screen") {
				msgbox % "screen number sent: " . state
				msgbox % "system screen name: " . screens["order"][state]
				msgbox % screens["enum"][screens["order"][state]]
			}


			scr := screens["order"][state]
			; get windows original state and dimensions
			WinGetPos, xpos, ypos, wid, hig, ahk_id %aWin%
			WinGet, min_max, MinMax, ahk_id %aWin%
			if (scr = det_screen(xpos+(wid/2), ypos+(hig/2)))
				return
			if (min_max = 1)
				WinRestore, ahk_id %aWin%

			if resize {
				wid := 0.5*screens["dim"][scr][1]
				hig := 0.5*screens["dim"][scr][2]
			}

			; move the window
			WinMove, ahk_id %aWin%,, % screens["Xrange"][scr][1], % screens["Yrange"][scr][1], % wid, % hig

			;~ WinMove, ahk_id %aWin%,, % screens["Xrange"][scr][1], % screens["Yrange"][scr][1]
									;~ , % 0.5*screens["dim"][scr][1], % 0.5*screens["dim"][scr][2]

			if (debug="screen") {
				msgbox % screens["Xrange"][scr][1]
				msgbox % screens["Yrange"][scr][1]
			}
			if (min_max = 1)
				place_window("max", Win)
			else
				if resize
					place_window("unmax", Win)

			; added for hephaestus for vnc. move to different function
			;~ if (WinActive("ahk_exe vncviewer.exe") & (A_ComputerName="HEPHAESTUS")) {
				;~ if (state=1)
					;~ send ^{Numpad8}
				;~ if (state=2 or state=3)
					;~ send ^{Numpad7}
			;~ }
	}
	if (Win = "A") {
		WinActivate ahk_id %aWin%
		WinWaitActive ahk_id %aWin%
	}
	return
}

browser(paths, name, browse:="window", screen:=0, fs:=false, force_new:=0){
    local
    global debug
	If (debug=="browser")
        msgbox % "browsing program: " . name

	if paths[name]
		path := paths[name]
	else
		msgbox, Error: No such path

    switch browse {
        case "window", "tab":
			name := "ahk_exe " . name . ".exe"
		case "winname":

        case "folder":
            name := "ahk_class " . name
            path := "explorer " . path
        case "group":
			path := paths.groups_def[name]
            name := "ahk_group " . name
        case "setting":
            path := name
            name := "ahk_exe " . name . ".exe"
        case "site":
            path := paths[name]
            name := "ahk_exe edge.exe"
        case "app":
            path := name
    }

	If (debug=="browser")
        msgbox % "path to browser: " . path

    if WinExist(name) {
        if WinActive(name) {
            switch browse {
                case "tab":
                    Send, ^{TAB}
                default:
                    WinActivateBottom, %name%
            }
        }
        else
            WinActivate, %name%
    }
    else {
        try {
			if (debug=="browser")
				msgbox % "tyring to open path: " . path . " | for program named: " . name
            Run %path%
            WinWait %name%
            WinActivate, %name%
            WinWaitActive, %name%
        }
    }
    if screen != 0
        place_window(screen)
    WinWaitActive, %name%
    if fs
        fullscreen(1)
    return
}

SearchWeb(text:="", site:="google", fromClip:=0, by_context:=1, show_gui:=0) {
; possible sites are: "google", "books", "translate", "wikipedia", "arxiv", "torrent", "ahk", "confluence"
	local prefix := ""
	local raw_query := ""
	if ((not text) and fromClip)
		text := GetSelectedText(!WinActive("ahk_exe vncviewer.exe"))


	if not text
		text := Input(title:="Search Query", question:="What whould you like to search?")
	if not text
		return


	;~ if (show_gui) {
		;~ Gui, choose_search:New, +Border +AlwaysOnTop, Search Where to Search
		;~ Gui, choose_search:add, Radio, vSearchRadio, Option 1
		;~ Gui, choose_search:add, Radio, vSearchRadio, Option 2
		;~ Gui, choose_search:add, Button, gSubmit, OK
		;~ Gui, choose_search:show

	;~ }

	if by_context {
		if WinActive("ahk_exe SciTE.exe") {
			prefix := "ahk "
			site := "google"
		}
		else if WinActive("ahk_exe vncviewer.exe") {
			site := "confluence"
		}
	}


	If (site="translate") {
		if (DetectLang(text)="EN")
			site .= "En>He"
		else
			site .= "He>En"
	}

	if (prefix)
		text := prefix . text

	encoded_text := EncodeDecodeURI(text)


	switch site
	{
		case "confluence":
			raw_query := """" . encoded_text . """&queryString=" . encoded_text
		default:
			raw_query := encoded_text
	}
	query := SearchEngines[site] . raw_query

	if (site="ahk")
		query .= ".htm"

	Run, %query%

	return query
}

ChatGPT() {
	CoordMode, Mouse, Screen
	MouseGetPos, Xorg, Yorg
	switch A_ComputerName
	{
		case "CHRONOS6":
			MouseClick,, 1400, 1050
		case "ZEUS2":
			MouseClick,, 1295, 1048
	}

	MouseMove, Xorg, Yorg
	return
}

RunScript(scriptName) {
	global paths
    ; Use the Process command to check if the script is running
	scriptPath := paths.scripts[scriptName]
    Process, Exist, %scriptName%
    pid := ErrorLevel  ; Save the PID (will be 0 if the process doesn't exist)

    ; If the script isn't running (i.e., PID is 0), run it
    if (pid = 0) {
        ; Use the Run command to start the Python script
        Run, pythonw %scriptPath%
    }
}

clip_to_mouse(paths) {
	local file
	Send, +#{s}
	ClipWait, 20, 1
	Sleep, 4000

	file := get_clip_img(paths["memory"] . "\clips", "clip_image_" . timestamp())
	tooltip_img(file)

	return
}

close_win() {
	;~ #If not (WinActive("Minecraft") or WinActive("ahk_exe lyx.exe") or WinActive("ahk_exe PDFXEdit.exe") or WinActive("ahk_exe Mathematica.exe"))
	id := WinActive("A")
	Send, {Escape}
	sleep 200

	if (id=WinActive("A")) {
		msgbox, 1, Quit, Are you sure you want to exit the program?, 10
		IfMsgBox, OK
			Send !{F4}
	}
	return
}

open_regedit(registry:=""){
	if not registry
		registry := "HKEY_CURRENT_USER"
	run_cmd(pathclass["regjump"], [registry], 0, 1)
	return
}

tooltip_img(img, rect:="dynamic", box_size:="default", fps:=50, halt:=false, coo_Ref:="screen", box_color:="44FF44") {
	local
	rate := Ceil(1000/fps)
	shf := 15

	if not halt {
		if (rect="dynamic")
			halt := "LButton"
		else
			halt := "Escape"
	}

	if img is not integer
		img := LoadPicture(img)

	if (rect!="dynamic") {
		if (box_size="default")
			box_size:=[110, 60]
		if rect[1] is integer
			rect := [rect, [rect[1]+box_size[1], rect[2]+box_size[2]]]
	}
	else
		rect := False

	Gui, ClipImg:new, -Caption +ToolWindow +alwaysontop
	Gui, Margin, 1, 1
	Gui, Color, %box_color%
	Gui, add, Picture, +HwndPicGUI, HBITMAP:*%img%
	Gui, show, AutoSize

	coordmode, mouse, %coo_ref%
	Loop {
		mousegetpos, x, y
		x+=shf
		y+=shf

		If rect and not in_rect([x,y], rect) {
			if (debug=3) {
				msgbox, % x . ":" . rect[1][1]
				msgbox, % y . ":" . rect[1][2]
			}
			Break
		}
		else
			Gui, ClipImg:show, X%x% Y%y%


		sleep, rate
	} until (GetKeyState(halt, "P") or GetKeyState("escape", "P"))
	return
}

refresh_prog(id:="A", save:=False) {
	local exe
	id := "ahk_id " . id
	WinGet, exe, ProcessPath, %id%

	if save
		ControlSend,, ^{s}, %id%

	WinClose, %id%
	WinWaitClose, %id%
	RunWait, ahk_exe %exe%
	return
}

GetProgLocation(paths, name:=False) {
	local path
	if not name
		InputBox, name, Open Program Location, What is the name of the program you would like to look for?

	path := find_prog(paths, name)
	msgbox % path["dir"]
	Run % path["dir"]
	return
}

get_pic(paths) {
	CoordMode, Mouse, Screen
	Send, +#{s}
	ClipWait, 20
	run_cmd(paths, "themis", ["--clipimg"], 0)
	browser(paths, "ONENOTE",, 2)
	MouseClick,, -1800, 1300
	Send, ^{v}
	return
}

remember(item) {
	return
}

recall(path) {
	return
}

change_env_mode(paths, mode, silent:=0) {
	local
	global env_mode, debug


	if (paths.computer[1] = "HEPHAESTUS") {
		if mode in game
			return
	}

	if (mode = "analytic")
		debug = 1
	else
		debug = 0

	env_mode := mode

	if not silent {
		StringUpper, env_name, mode
		MsgBox,, Environment Mode Changed, Enviromment mode: %env_name%, 2
	}

	return
}


;### Programs

; LyX
lyx_print_macro() {
	local f_ind
	f_ind := LTrim(A_ThisHotkey, "^Numpad")
	print_text(equ[f_ind])
	return
}

lyx_store_formula(formula) {
	local handle
	guiFormula := formula
	lyx_gui("create")
	if (formula = "")
		GuiControl, Choose, % TypeList, 2
	else
		GuiControl, Choose, % TypeList, 1

	Gui, Add, Button, x100 y100 w100 h30 gOK, OK
	Gui, Add, Button, x200 y100 w100 h30 gCan, Cancel
	Gui, Add, Button, x300 y100 w100 h30 gDel, Delete
	Gui, Show, w500 h150, Store Formula
	return

	OK:
		Gui, Submit
		lyx_gui("ok", guiType, guiName, guiParent, guiFormula)
		return
	Can:
		Gui, Destroy
		return
	Del:
		Gui, Submit
		if (guiType = "menu")
			lyx_gui("delete", guiType, guiParent)
		else
			lyx_gui("delete", guiType, guiName, guiParent)
		return
}

lyx_save_macro(formula) {
	equ.Push(formula)
	i := equ.length()
	Hotkey, IfWinActive, ahk_exe LyX.exe
	Hotkey, ^Numpad%i%, lyx_print_formula
	return
}

lyx_append_uranus(file, formula, title="") {
	local lines
	lines := []

	if title
	{
		lines.push("\begin_layout Subsection")
		lines.push(title)
		lines.push("\end_layout")
	}

	lines.push("\begin_layout Standard")
	lines.push("\begin_inset Formula")
	lines.push("\[")
	lines.push(formula)
	lines.push("\]")
	lines.push(" ")
	lines.push("\end_inset")
	lines.push(" ")
	lines.push("\end_layout")
	lines.push(" ")

	append_to_file(file, lines, -4)
	return
}


; rainmeter
RM_layout(paths, name){
	local path := paths["pandora"] . "\rainmeter\" . name
	msgbox % path
	Run % path
	return
}

rainmeter(paths){
	Switch layout
	{
		Case 0:
			RM_layout(paths, "top")
			layout = 1
		Case 1:
			RM_layout(paths, "empty")
			layout = 0
		Default:
			RM_layout(paths, "empty")
			layout = 0
	}
	return
}

ShowKeyboardLayout() {
	local
	path := "E:\OneDrive - Technion\Documents\Rainmeter\Skins\MacroMap\@Resources\KeyStorage.inc"
	return
}

; chrome
AddWikiURL2NP() {
	WinActivate, ahk_exe chrome.exe
	CoordMode, mouse, client
	ControlClick, X335 Y85, ahk_exe chrome.exe
	return
}

; spotify
Spotify(paths, cmd) {
	browser(paths, "Spotify")
	switch cmd
	{
		case "run":
			;~ Send, +!{h}
			;~ Send, ^{l}
		case "like_song":
			;~ run_cmd(paths, "spt playback --like")
			Send, +!{b}
			place_window("min")
		case "shuffle":
			Send, ^{s}
			place_window("min")
		;~ case "save_to_playlist":
			;~ InputBox, playlist, Save to Playlist, Choose playlist
			;~ run_cmd(paths, paths.revise("pandora", "Spotify\spotify_control.py"), ["add", playlist], 0,,, 1)
		;~ case "play_playlist":
			;~ InputBox, playlist, Play to Playlist, Choose playlist
			;~ run_cmd(paths, paths.revise("pandora", "Spotify\spotify_control.py"), ["play", playlist],0,,, 1)
	}
	return
}

; whatsapp
send_love_emojis() {
	local i
	l_smilies := ["💓", "💓💓💓", "🥰", "🥰🥰🥰", "😍", "😍😍😍", "💛", "💗", "💝️", "♥️", "♥♥♥️"]
	InputBox, n, "Number of Emojis", "Enter number of emojis"
	Loop, %n%{
		Random, i, 1, l_smilies.length()
		v := l_smilies[i]
		Send {Text}%v%
	}
	return
}

SendMassage(txt) {
	local
	CoordMode, Mouse, Client
	WinActivate, WhatsApp
	ControlClick, X880 Y1060, WhatsApp
	return
}

; SciTE
Reload_SciTE(paths) {
	local
	;~ script := WinExist("ahk_exe SciTE.exe")
	;~ WinGetTitle, script, ahk_id %script%
	;~ script := SubStr(script, 1, InStr(script, ".")-1)
	;~ if script in functions,constants,utils
		;~ script := "Keyboard_bindings"

	;~ Run % "autohotkey.exe " . quote(paths["ahk"] . "\" . script . ".ahk") . " /restart"
	Reload
	return
}

Edit_SciTE(paths) {
	local
	scripts := ["console.ahk", "functions.ahk", "utils.ahk", "constants.ahk", "init.ahk", "memory/paths.ini", "Keyboard_bindings.ahk"]
	cmd := ""
	for each, script in scripts
		cmd .= script . " "
		;~ cmd .= script . ".ahk "
	path := paths["SciTE"] . " -open:" . cmd

	Run % path
	return
}

Help_SciTE() {
	local
	version := "v1"
	txt := GetSelectedText()
	if txt {
		txt := cleanStr(txt, ["^","#","+","!","~","$"])
		Run, https://www.autohotkey.com/docs/%version%/%txt%.htm
	}
	else
		Run, https://www.autohotkey.com/docs/%version%/KeyList.htm
	return
}


;### classes

class PathClass {
	PL := {}
	sys := {}
	scripts := {}
	cache := {}
	groups_def := {}
	computer := {}
	computers := {"CHRONOS6": 1, "ZEUS2": 2, "PHYAROM2": 3, "HEPAESTUS": 4}
	locations := {}

	__New() {
		local AppData, OneDrive, ProgramData, UserDir
		EnvGet, AppData, appdata
		StringTrimRight, AppData, AppData, 8
		EnvGet, OneDrive, OneDrive
		EnvGet, ProgramData, ProgramData
		EnvGet, UserDir, USERPROFILE
		EnvGet, pandora, Pandora

		this.computer := {A_ComputerName: this.computers[A_ComputerName]}
		this.locations := {"document": {}, "picture": {}, "program": {}, "archive": {}}
		this.sys := {"appdata": APPDATA, "onedrive": ONEDRIVE, "programData": programData, "user": UserDir, "ProgramFiles": ProgramFiles, "pandora": Pandora}
	}

	__Get(path) {
		if (debug=="pathobj_call") {
			msgbox % "asked for path: " . path
		}
		if this.sys[path] {
			if (debug=="pathobj_call")
				msgbox % "got path: " . this.sys[path]
			return this.sys[path]
		}
		else if this.PL[path] {
			if (debug=="pathobj_call")
				msgbox % "got path: " . this.PL[path]
			return this.PL[path]
		}
		else if this.scripts[path] {
			if (debug=="pathobj_call")
				msgbox % "got path: " . this.scripts[path]
			return this.scripts[path]
		}
		else if this.groups_def[path] {
			if (debug=="pathobj_call")
				msgbox % "got path: " . this.groups_def[path]
			return this.groups_def[path]
		}
		else if this.cache[path] {
			if (debug=="pathobj_call")
				msgbox % "got path: " . this.cache[path]
			return this.cache[path]
		}
		else if (path="comp") or (path="computer") {
			if (debug=="pathobj_call")
				msgbox % "got path: " . this.computer
			return this.computer
		}
	}

	__Set(field, pair) {
		PathClass[field][pair[1]] := pair[2]
	}

	append(name, intPath, newPath) {
		if SubStr(newPath, 1, 1) not in "\","/"
			newPath := "\" . newPath
		this.PL[name] := this.PL[intPath] . newPath
	}

	load(ini_path:="") {
		local
		global comp_names, debug
		if not ini_path
			ini_path := A_ScriptDir . "\memory\paths.ini"

		this.PL["pathList"] := ini_path

		parsed_ini := parse_ini(ini_path)
		sections := ["paths", "scripts", "groups_def", "chache", "ZEUS2"]
		for i, sect_name in sections
		{
			sect := parsed_ini[sect_name]
			for key, val in sect
			{
				if (InStr(val, "%")) {
					val := replace_Substrings(val, this)
				}

				;~ if (debug=="pathobj")
						;~ msgbox % "section: " . sect . " | key: " . key . " | val: " . val

				switch sect_name
				{
					Case "scripts":
						this.scripts[key] := val
					Case "groups_def":
						if (debug=="pathobj")
							msgbox % "section: " . sect . " | key: " . key . " | val: " . val
						this.groups_def[key] := val
					Case "cache":
						this.cache[key] := val
					Case "locations":
						this.locations[key] := val
					Default:
						if sect in comp_names
						{
							if (sect=A_ComputerName)
								this.PL[key] := val
						}
						else
							this.PL[key] := val
				}
			}
		}
	}

	save(path:=False) {
		local
		sections := ["PL", "scripts", "locations"]
		if not path
			path := this["pathList"]
		For Each, section in sections
			IniWrite, % this[section], %path%, %section%
		return
	}

	revise(path, relative_path:="", enclose:=1) {
		If this.PL[path]
			path := this.PL[path]

		If relative_path
			path := path . "\" . relative_path

		If enclose
			path := """" . path . """"

		return path
	}

	sort(path) {
		local
		file := new fileClass(path)
		file.sort(this.locations)

	}

	selected() {
		local pth, Selection
		hwnd := WinActive("A")
		for Window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd) {
				Selection := Window.Document.SelectedItems
				for Items in Selection
					pth := Items.path
			}
		return pth
	}

	explorer(folder:="first") {
		local pth := []
		local hwnd := []
		local hlist, i, x
		local folders := {}

		if (folder="first")
			folder := "ahk_class CabinetWClass"

		if (folder="all") {
			folder := "ahk_class CabinetWClass"
			winget, hlist, list, %folder%
			Loop % hlist
				hwnd.push(hlist%A_Index%)
			pth := []
		}
		else
			hwnd := [WinExist(folder)]

		for Window in ComObjCreate("Shell.Application").Windows
			folders[window.hwnd] := window.Document.Folder.Self.Path


		for i, x in folders
		{
			if (inlist(i, hwnd))
				pth.push(x)
		}

		if (pth.length()=1)
			return pth[1]
		else
			return pth
	}


}

class FileClass {
	static name := ""
	static pure_name := ""
	static path := ""
	static disk := ""
	static folder := ""
	static ext := ""
	static type := ""
	static size := ""
	static icon := ""
	static encoding := ""
	static types_dict := {"folder": "folder"
						,".pdf": "document"
						,".jpg": "picture"}

	__New(path) {
		local flnm, dr, ext, nm, drv
		SplitPath, path, flnm, dr, ext, nm, drv
		FileGetSize, sz, %path%

		this.path := path
		this.size := sz
		this.name := flnm
		this.pure_name := nm
		this.disk := drv
		this.folder := dr

		If not ext
			this.ext := "folder"
		Else
			this.ext := "." . ext

		this.type := this.types_dict[this.ext]

	}

	__Get(prop) {
		return % "FileClass." . prop
	}

	move(pth, ow:=0) {
		If not FileExist(pth)
			FileCreateDir, pth

		If (this.type="folder")
			FileMoveDir, % this.path, %pth%, %ow%
		Else
			FileMove, % this.path, %pth%, ow

		this.folder := pth
		this.path := pth . "\" . this.name
		return
	}

	rename(name) {
		local ext := ""
		If InStr(name, ".")
			SplitPath, name,,, ext, name

		If ext
			this.ext := "." . ext
		this.pure_name := name

		if (this.ext!="folder")
			name .= this.ext
		this.name := name

		name := this.folder . "\" . name
		FileMove, % this.path, %name%, 1
		this.path := name
		return
	}

	copy(pth) {
		If not FileExist(pth)
			FileCreateDir, pth

		If (this.type="folder")
			FileCopyDir, % this.path, %pth%, overwrite
		Else
			FileCopy, % this.path, %pth%, overwrite
		return
	}

	delete(destroy:=0) {
		If destroy
			FileDelete, % this.path
		Else
			FileRecycle, % this.path
		return
	}

	read(flags:="rw") {
		local data
		data := FileOpen(this.path, flags, this.encoding)

		if !IsObject(data)	{
			MsgBox Can't open "%FileName%" with the flags "%flags%".
			return 0
		}
		else
			return data
	}

	run() {
		RunWait, % this.path
		return
	}

	exists() {
		If FileExist(this.path)
			return True
		Else
			return False
	}

	shortcut(pth:="startup", args:="", runstate:="normal") {
		switch runstate {
			case "normal", 0:
				runstate := 1
			case "max", "maximized", 1:
				runstate := 3
			case "mix", "minimized", -1:
				runstate := 7
		}

		pth := pathClass.revise(pth)
		FileCreateShortcut, %pth%, % this.name, % this.folder, %args%,, % this.icon,,, runstate
	}

	sort(locations, action:="run") {
		local
		flist := ""
		;~ global foldernamegui, filenamegui
		switch action {
			case "run":
				this.sort(locations, "create")
				this.sort(locations, "show")

			case "create":
				folders := locations[this.type]
				For key, val in folders
					flist .= "|" . key
				flist := SubStr(flist, 2)

				Gui, filemanager:New, +Border +AlwaysOnTop +Delimiter|, % "File Manager for " . this.name

				Gui, Add, Text, x22 y9 w100 h20, Save file to:
				Gui, Add, ListBox, x22 y39 w100 h140 vfoldernamegui, %flist%

				Gui, Add, GroupBox, x142 y9 w250 h190, File Data
				Gui, Add, Text, x152 y29 w50 h20, File Name:
				Gui, Add, Edit, x152 y49 w220 h40 +Wrap vfilenamegui, % this.name
				Gui, Add, Text, x152 y109 w170 h20, % "File Type: " . this.type
				Gui, Add, Text, x152 y139 w170 h20, % "File Size: " . this.size
				Gui, Add, Text, x152 y169 w170 h20, % "Source Folder: " . this.folder

			case "show":
				Gui, filemanager:Default

				Gui, Add, Button, x22 y189 w100 h20 vaddfolder, Add Folder
				Gui, Add, Button, x30 y239 w100 h30 vopen, Open
				Gui, Add, Button, x150 y239 w100 h30 vsave, Save
				Gui, Add, Button, x270 y239 w100 h30 vdelete, Delete
				Gui, Add, Button, x390 y239 w100 h30 vcancel, Cancel
				Gui, Add, Button, x402 y49 w100 h30 +Disabled vunzip Hwndunziphwnd , Unzip
				If ((this.type=".zip") or (this.type=".rar"))
					GuiControl, Enable, unziphwnd

				Gui, Show, w525 h300
				return

				open:
					this.rename(filenamegui)
					this.move(pathclass.locations[this.type][foldernamegui])
					this.run()
					Gui, Destroy
					return

				save:
					this.rename(filenamegui)
					this.move(pathclass.locations[this.type][foldernamegui])
					Gui, Destroy
					return

				delete:
					this.delete()
					Gui, Destroy
					return

				cancel:
					Gui, Destroy
					return

				addfolder:
					return

				unzip:
					return
		}
		return

	}
}

class BB {
	get(mode:="win") {
		if (mode = "win")
			win := WinActive("A")
		else if (mode = "mouse")
			MouseGetPos,,, win
		this.active := win
		this.get_clip()
		this.get_mouse()
		this.screen := det_screen(this.mouse[1], this.mouse[2])
	}

	text[when:="before"] {
		get {
			if (when = "now") {
				this.get()
			}
			return this.clip
		}
	}

	path[when:="before"] {
		get {
			if (when = "now")
				this.get()
			return this.clip
		}
	}

	active {
		set {
			this.aWin["id"] := value
			WinGet, pname, ProcessName, % "ahk_id" . value
			this.aWin["name"] := pname
		}
	}

	get_mouse(mode:="screen") {
		local X, Y
		CoordMode, TargetType, % mode
		MouseGetPos, X, Y,, cont
		this.mouse := [X, Y]
		this.focus_control := cont
	}

	get_clip() {
		tmp := Clipboard
		Clipboard :=
		Send, ^c
		ClipWait, 0.5
		if Clipboard
			this.clip := Clipboard
		Clipboard := tmp
		ClipWait, 0.5
	}

	gather() {
		return
	}
}

class ControlPoint {
	x := 0
	y := 0
	win := "A"
	hwnd := ""
	__New {
	}
}

class Debuger {
	state := 0
	__New() {
	}
}

class ScheduleClass {
	schedule_table := {"sunday": [], "Monday": [], "tuesday": [], "wednesday": [], "thursday": [], "friday": [], "saturday": []}
	weekend := ["friday", "saturday"]
	work_hours := [[8, 0], [21, 0]]
	active_dates := []
	current_time := {"year": A_YYYY, "month": A_MM, "day": A_DD, "WD": A_DDDD, "WW": SubStr(A_YWeek, -1), "hour": A_Hour, "minute": A_Min, "current": [A_Hour, A_Min]}

	__New(){
		table := {"sunday": [[8, 0], [21, 0]], "Monday": [[8, 0], [21, 0]], "tuesday": [[8, 0], [21, 0]], "wednesday": [[8, 0], [21, 0]], "thursday": [[8, 0], [21, 0]], "friday": [[0, 0], [0, 0]], "saturday": [[0, 0], [0, 0]]}
		this.schedule_table := table
		}

	;~ save() {
	;~ }

	check_working() {
		working := between(this.schedule_table[this.current_time["WD"]][1], this.schedule_table[this.current_time["WD"]][2], this.current_time["current"], "time")
		return working
	}
}
;### Context Menu

create_menu(submenu:="context"){
	local i, list
	list := menu_list[submenu]
	ctx_func := Func("context_menu")
	for i, item in list
	{
		key := item[2]
		if (SubStr(key, 1, 1) != ":")
			handle := ctx_func.Bind(submenu, key)
		else
			handle := key
		menu, %submenu%, add, % item[1], % handle
	}
	return
}

context_menu(paths, submenu:="context", item:=false){
	static text, title
	global path
	context_sensitive := {"LyX.exe": "context_LyX"}
	switch submenu {
		case "show":
			focus.get("mouse")
			WinActivate % "ahk_id " . focus.aWin["id"]

			if context_sensitive[focus.aWin["name"]]
				Menu, % context_sensitive[focus.aWin["name"]], Show
			else
				Menu, context, Show

		case "search":
			if not focus.text {
				InputBox, text, Search Query, What whould you like to search?
				focus.text := text
			}
			if not focus.text
				return

			SearchWeb(focus.text, item)
		case "analytics":
			switch item {
				case "winspy":
					Run % "autohotkey.exe " . quote(path["windowspy"])
				case "UIAViewer":
					Run % "autohotkey.exe " . quote(path["UIAViewer"])
				case "path":
					Clipboard := focus.pth
			}
		case "runWith":
			switch item	{
				case "cmd":
					browser(paths, "cmd")
					print_text(focus.text)
				case "regedit":
					open_regedit(focus.text)
				case "explorer":
					run_cmd(paths, "explorer.exe", [focus.text], 0)
			}
		;~ case "sumatra":
			;~ switch item {
				;~ case "save_page":
					;~ sumatra_save_page()
				;~ case "annotate":
					;~ InputBox, text, Add Annotation, Enter Annotation
					;~ sumatra_annotate(text, focus.mouse)
				;~ case "save_ref":
					;~ sumatra_save_ref(focus.text)
				;~ case "show_ref":
					;~ sumatra_show_ref(focus.mouse)
			;~ }
		case "lyx":
			switch item {
				case "store_formula":
					lyx_store_formula(focus.text)
					refresh_prog(focus.aWin["id"], True)
				case "save_macro":
					lyx_save_macro(focus.text)
				case "append_uranus":
					lyx_file := path["onedrive"] . "\Documents\My Documents\Thoughts\Uranus\Olympus\Important Formulas.lyx"
					Inputbox, title, Choose Title, Choose title for formula:
					lyx_append_uranus(lyx_file, focus.text, title)
			}
	}
	return
}




