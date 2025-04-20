#NoEnv
SendMode, input
SetWorkingDir, %A_ScriptDir%


; basic computer actions
GetSelectedText(copy:=1) {
	static focus := {}
	focus["aWin"] := WinActive("A")
	focus["clipboard"] := 0

	if (copy) {
		tmp := Clipboard
		Clipboard =
		Send, ^c
		ClipWait, 1
	}
	if Clipboard
		focus["clipboard"] := Clipboard
	else
		MsgBox % "Error: Clipboard is empty."

	if (copy) {
		Clipboard := tmp
		ClipWait, 1
	}

	return focus["clipboard"]
}

render_hotstrings(list, prefix:=":*:", context_type="none", context="none") {
	local key, val
	If (context_type!="none") {
		switch context_type {
		Case "win", "window":
			HotKey, IfWinActive, %context%
		Case "general":
			HotKey, IF, %context%
		Default:
			HotKey, IfWinActive, %context%
		}
	}

	For key, val in list
		Hotstring(prefix . key, val, "on")

	If (context_type!="none")
		HotKey, IF
	return
}

min_all_wins() {
	WinGet, WindowList, List,,, Program Manager
	Loop, %WindowList%
	{
		WinGetClass, Class, % "ahk_id " . WindowList%A_Index%
		IF (Class <> "Shell_SecondaryTrayWnd" And Class <> "Shell_TrayWnd")
			WinMinimize, % "ahk_id " . WindowList%A_Index%
	}
	return
}


; list handling
inlist(o, l) {
	local x, i
	for i, x in l
		if (o=x)
			return true
	return false
}

join(sep:=" ", params*) {
	local i
	str := ""
    for i, param in params
        str .= param . sep
	StringTrimRight, str, str, strlen(sep)
	return str
}

range(start, stop:="", delta:=1) {
	local
	global debug
	if not stop {
		stop := start
		start := 1
	}

	range_list := []
	range_list.push(start)

	steps := (stop-start) // delta
	Loop % steps {
		new_val := range_list[A_Index] + delta
		;~ if (debug >= 2) {
			;~ msgbox % "index: " . A_Index . " | value: " . new_val
		;~ }
		range_list.push(new_val)
	}

	return range_list
}

Any(sentence*) {
	local
	for Each, statement in sentence {
		if statement
			return True
	}
	return False
}

All(sentence*) {
	local
	for Each, statement in sentence {
		if not statement
			return False
	}
	return True
}


;string handling
quote(txt) {
	txt = "%txt%"
	return txt
}

EncodeDecodeURI(str, encode:=true, component:=true) {
	static Doc, JS, txt
	Doc := ComObjCreate("htmlfile")
	Doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
	JS := Doc.parentWindow
	( Doc.documentMode < 9 && JS.execScript() )
	txt := JS[ (encode ? "en" : "de") . "codeURI" . (component ? "Component" : "") ](str)
	StringReplace txt, txt, ., `%2E
	StringReplace txt, txt, !, `%21
	return txt
}

TimeStamp(date:=True, time:=True, format:="machine") {
	local
	stamp := ""
	if date {
		switch format {
			case "machine":
				stamp .= "yyyyMMdd"
			case "long":
				stamp .= "yyyyMMMMdd"
			case "full":
				stamp .= "yyyyMMMMdddd"
			case "short":
				stamp .= "yyMd"
		}
	}
	if time {
		switch format {
			case "machine","long","full":
				stamp .= "HHmmss"
			case "short":
				stamp .= "Hms"
		}
	}
	FormatTime, stamp,, %stamp%
	return stamp
}

format_cmd(cmd) {
	local
	chars := [A_Space, "-", "!", "@", "#", "$", "%", "^", "&", "*", "|", "?"
				,",", ";", ")", "("]
	for each, char in chars
		If InStr(cmd, char)
			return quote(cmd)
	return cmd
}

make_file_name(name) {
	local
	chars := [A_Space, "!", "@", "#", "$", "%", "^", "&", "*", "|", "\", "/", "?", ",", ":", ";"]
	For each, char in chars
		StringReplace name, name, %char%, `
	return name
}

replace_Substrings(inputString, array, delim="%") {
    ; Use a regular expression to find substrings encapsulated by %
    if (pos := RegExMatch(inputString, delim . "(.*?)" . delim, match)) {
        ; Extract the encapsulated substring without %
        extracted := match1

        ; Replace the encapsulated substring with array value
        if (array[extracted]) {
            replacement := array[extracted]
            inputString := StrReplace(inputString, "%" extracted "%", replacement)
        }
        ; Move the position forward to find the next match
        pos += StrLen(match)
    }
    return inputString
}


; file handling
append_to_file(file_path, list_of_lines, line:=0) {
	;~ line = 0 is the last line
	local file := []
	local new_file, i
	Loop, Read, %file_path%
		file.push(A_LoopReadLine)
	If (line<=0)
		line := line + file.Length() + 1

	file.InsertAt(line, list_of_lines*)

	new_file := FileOpen(file_path, "w")
	For i, line in file
		new_file.WriteLine(line)
	new_file.close()
	return
}

seach_file(search_path, file_name, match_type:="complete") {
	search_path := search_path . "\*"
	Loop, Files, %search_path%, FDR
	{
		switch match_type
		{
			Case "complete":
				if (A_LoopFileName=file_name)
					return A_LoopFileLongPath
			Case "partial":
				if InStr(A_LoopFileName, file_name)
					return A_LoopFileLongPath
			Case "regex":
				if RegExMatch(A_LoopFileName, file_name)
					return A_LoopFileLongPath
		}
	}
	return ""
}

find_windowsapp_path(name) {
	return
}

; basic arithmatic
in_rect(coo, rect) {
	local LTcorner := rect[1]
	local RBcorner := rect[2]
	local dx := [Abs(RBcorner[1] - LTcorner[1]), Abs(RBcorner[2] - LTcorner[2])]
	return ((Abs(RBcorner[1]+LTcorner[1]-2*coo[1])<dx[1]) and (Abs(RBcorner[2]+LTcorner[2]-2*coo[2])<dx[2]))
}

between(a, b, x, type:="nums") {
	switch type
	{
		case "time":
			bigger_than_a := (a[1]<x[1]) | ((a[1]=x[1])&(a[2]<=x[2]))
			smaller_than_b := (x[1]<b[1]) | ((x[1]=b[1]) & (x[2]<=b[2]))
			return bigger_than_a & smaller_than_b
		defult:
			return (a<=x)&(x<=b)
	}
}

; displays
get_screens_data(scr) {
	local
	global debug
	SysGet, moncount, Monitorcount
	SysGet, prim_mon, MonitorPrimary
	scr["count"] := moncount
	scr["order"] := []
	scr["main"] := prim_mon
	ordering_list := []
	Loop % moncount {
		SysGet, mon, Monitor, %A_Index%
		sysget, monName, MonitorName, %A_Index%

		scr["enum"][monName] := A_Index
		scr["order"].push(A_Index)
		ordering_list.push(monLeft)

		scr["Xrange"].push([monLeft, monRight])
		scr["Yrange"].push([monTop, monBottom])

		scr["dim"].push([abs(monRight-monLeft), abs(monBottom-monTop)])

		scr["COM"].push([(monRight+monLeft)/2, (monBottom+monTop)/2])
		if (debug="screen")
			msgbox % "screen name: " . monName . "`nscreen index: " . A_Index . "`nscreen number: " . scr["enum"][monName]
	}
	if (moncount==4) {
		local min_y := -2000
		local min_idx
		scr["order"] := []
		ordering_list := []
		Loop 4 {
			if (scr["Yrange"][A_Index][1] > min_y) {
				min_y := scr["Yrange"][A_Index][1]
				min_idx := A_Index
			}
		}
		Loop 4 {
			if (A_Index != min_idx) {
				scr["order"].push(A_Index)
				ordering_list.push(scr["Xrange"][A_Index][1])
			}
		}
		scr["order"] := bubble_sort(scr["order"], ordering_list)
		scr["order"].push(min_idx)
	}
	if (moncount<=3) {
		scr["order"] := bubble_sort(scr["order"], ordering_list)
	}
	if (moncount=2) {
		scr["order"] := [scr["order"][1], scr["main"], scr["order"][2]]
	}
	if (debug="screen")
		msgbox % scr["order"][1] scr["order"][2] scr["order"][3]
	return scr
}

; probing
AnyWinActive(param*) {
	local
	for Each, win in param {
		if WinActive(win) {
			msgbox % win
			return win
		}
	}
	return False
}

WinID(name) {
	if (SubStr(name, 1, 4)="ahk_")
		return name
	else
		return "ahk_exe " . name
}



; to sort
IndexOf(list, var, delim:="") {
	local
	if delim {
		list := StrSplit(list, delim)
	}

	i := 0
	for each, obj in list {
		i += 1
		if (obj=var)
			return i
	}
	return 0
}

CleanStr(str, chars, from:="beginning") {
	local
	chars := join(",", chars*)

	Loop {
		switch from	{
			case "beginning":
				char := SubStr(str, 1, 1)
				if char in %chars%
				{
					str := SubStr(str, 2)
					continue
				}
			case "end":
				char := SubStr(str, str.length()-1, 1)
				if char in %chars%
				{
					str := SubStr(str, 1, str.length()-1)
					continue
				}
			case "any":
				return
		}
		break
	}

	return str
}

print(msg, type:="tooltip", timeout:=10) {
	switch type {
		case "tooltip":
			ToolTip, %msg%
		case "msgbox":
			MsgBox,,, %msg%, %timeout%
	}
	return
}

PopTrayTip(text, title, time:=7) {
	local
	state := 0
	state := OnMessage(0x404, Func("AHK_NOTIFYICON"))
	TrayTip, %title%, %text%, %time%
	while state {
		sleep, 200
	}
	WinWait, New notification
	print(1)
	;~ WinWaitClose, New notification ahk_exe ShellExperienceHost.exe
	;~ print(2)
	return state
}

AHK_NOTIFYICON(wParam, lParam, msg, hwnd) {
	global TTstate
	if (hwnd != A_ScriptHwnd)
		return 3
	if (lParam = 1029) { ; NIN_BALLOONUSERCLICK
		TTstate := "leftClick"
		;~ MsgBox, Notification was left-clicked.
		return 1
	}
	if (lParam = 1028) { ; NIN_BALLOONTIMEOUT
		TTstate := "timeOut"
		;~ MsgBox, Notification timed out or was closed or right-clicked.
		return 2
	}
}

print_text(string) {
	temp = %Clipboard%
	Clipboard := string
	ClipWait 2
	Send, ^{v}
	Sleep, 100
	Clipboard = %temp%
	return
}

get_newest_file(folder, time:=0, timeout:=10) {
	local newest := False
	local flag := False
	local ping := A_TickCount
	if (time = "now")
		time := A_NowUTC
	While not flag {
		Loop, %folder%\*.* {
			 If (A_LoopFileTimeModified >= time)
				time := A_LoopFileTimeModified, newest := A_LoopFileLongPath, flag := True
		}
		if (A_TickCount >= (ping + 1000*timeout))
			return 0
	}
	return {"file": newest, "time": time}
}

DetectLang(text:="", ByWin:=0) {
	local
	static lang := {67699721: "EN", -264436723: "HE"}
	if not text {
		text := "A"
		ByWin := 1
	}

	If ByWin {
		if (text="A")
			text := WinActive("A")
		aac:= % DllCall("GetKeyboardLayout", Int ,DllCall("GetWindowThreadProcessId", int ,text, Int ,0))
		return lang[aac]
	}
	Else {
		if RegExMatch(text, "[a-zA-Z]")
			return "EN"
		else
			return "HE"
	}
}

Input(title:="", question:="", hide:=0, width:=0, hight:="") {
	local
	if not title
		title := "User Input"

	if not question
		question := "Please enter you input:"

	query := "str, " . title . ", " . question

	If hide
		query .= ", HIDE"
	if not width
		Width := min(200, 7*StrLen(question))
	if not hight
		hight := 150

	InputBox, str, %title%, %question%, %hide%, %Width%, %hight%

	If ErrorLevel
		return 0

	return str
}

MClick(x, y, coord="screen") {
	local x0, y0
	CoordMode, Mouse, %coord%
	MouseGetPos, x0, y0
	Send {Click %x%, %y%}
	MouseMove, %x0%, %y0%
	return
}

make_group(name, winList, default) {
    global
    GroupAdd, %name%, %default%

    Loop, Parse, winList, `,
    {
        GroupAdd, %name%, %A_LoopField%
    }
}

group_activate(name, default) {
    GroupActivate, %name%
    IfWinNotActive, ahk_group %name%
    {
        Run, %default%
    }
}

parse_ini(ini_path, section="all") {
	local sections, temp, keys
	local section_list := {}
	if (section!="all") {
		key_val_list := {}
		IniRead, keys, %ini_path%, %section%
		Loop, Parse, keys, `n
		{
			if (ErrorLevel)
				break  ; No more keys/values to read

			temp := StrSplit(A_LoopField, "=")
			key_val_list[temp[1]] := temp[2]
		}
		return key_val_list
	}
	else {
		IniRead, sections, %ini_path%
		Loop, Parse, sections, `n
		{
			if (ErrorLevel)
				break
			section_list[A_LoopField] := {}
		}

		for sect in section_list {
			IniRead, keys, %ini_path%, %sect%
			Loop, Parse, keys, `n
			{
				if (ErrorLevel)
					break
				temp := StrSplit(A_LoopField, "=")
				section_list[sect][temp[1]] := temp[2]
			}
		}
		return section_list
	}
}

bubble_sort(list, order_cond:="") {
	local i, j, n, temp
	n := list.Length()
	if (order_cond="")
		order_cond := list
	for i, _ in range(n - 1) {
		for j, _ in range(n - i) {
			if (order_cond[j] > order_cond[j+1]) {
				temp := list[j]
				list[j] := list[j + 1]
				list[j + 1] := temp

				temp := order_cond[j]
				order_cond[j] := order_cond[j + 1]
				order_cond[j + 1] := temp
			}
		}
	}
	return list
}

check_file_type(filePath) {
    ; Extract the file extension
    SplitPath, filePath, , , fileExt

    ; Convert file extension to lower case
    fileExt := RegExReplace(fileExt, "\..*")

    ; Return the file extension
    return fileExt
}

ShellRun(prms*)
{
    shellWindows := ComObjCreate("{9BA05972-F6A8-11CF-A442-00A0C90A8F39}")

    desktop := shellWindows.Item(ComObj(19, 8)) ; VT_UI4, SCW_DESKTOP

    ; Retrieve top-level browser object.
    if ptlb := ComObjQuery(desktop
        , "{4C96BE40-915C-11CF-99D3-00AA004AE837}"  ; SID_STopLevelBrowser
        , "{000214E2-0000-0000-C000-000000000046}") ; IID_IShellBrowser
    {
        ; IShellBrowser.QueryActiveShellView -> IShellView
        if DllCall(NumGet(NumGet(ptlb+0)+15*A_PtrSize), "ptr", ptlb, "ptr*", psv:=0) = 0
        {
            ; Define IID_IDispatch.
            VarSetCapacity(IID_IDispatch, 16)
            NumPut(0x46000000000000C0, NumPut(0x20400, IID_IDispatch, "int64"), "int64")

            ; IShellView.GetItemObject -> IDispatch (object which implements IShellFolderViewDual)
            DllCall(NumGet(NumGet(psv+0)+15*A_PtrSize), "ptr", psv
                , "uint", 0, "ptr", &IID_IDispatch, "ptr*", pdisp:=0)

            ; Get Shell object.
            shell := ComObj(9,pdisp,1).Application

            ; IShellDispatch2.ShellExecute
            shell.ShellExecute(prms*)

            ObjRelease(psv)
        }
        ObjRelease(ptlb)
    }
}


;~ terminal_req (cmd, raw_args, as_admin, python, debug_mode) {
;~ local args := []
;~ if not raw_args
		;~ raw_args := []

	;~ cmd := format_cmd(cmd)
	;~ if raw_args {
	;~ For key, val in raw_args
			;~ args[key] := format_cmd(val)
		;~ cmd := join(,cmd, args*)
	;~ }

	;~ if python {
		;~ if apperent
			;~ cmd := "python " . cmd
		;~ else
			;~ cmd := "pythonw " . cmd

	;~ }

	;~ if apperent
		;~ cmd := " /k " . cmd
	;~ else
		;~ cmd := " /c " . cmd

	;~ if debug_mode {
		;~ msgbox, 6, Command to cmd, %cmd%
		;~ Clipboard := cmd
	;~ }

	;~ if admin
		;~ Run, *RunAs %comspec%%cmd%
	;~ else
		;~ Run, %comspec%%cmd%

	;~ return cmd
;~ }











;~ Stdout(output:="", sciteCheck := true){
;~ ;output to console	-	sciteCheck reduces Stdout/Stdin performance,so where performance is necessary disable it accordingly
	;~ Global ___console___
	;~ If (sciteCheck && ProcessExist("SciTE.exe") && GetScriptParentProcess() = "SciTE.exe"){
	;~ ;if script parent is scite,output to scite console & return
		;~ FileAppend, %output%`n, *
		;~ Return
	;~ }
	;~ ;CONOUT$ is a special file windows uses to expose attached console output
	;~ ( output ? ( !___console___? (DllCall("AttachConsole", "int", -1) || DllCall("AllocConsole")) & (___console___:= true) : "" ) & FileAppend(output . "`n","CONOUT$") : DllCall("FreeConsole") & (___console___:= false) & StdExit() )
;~ }

;~ Stdin(output:="", sciteCheck := true){
;~ ;output to console & wait for input & return input
	;~ Global ___console___
	;~ If (sciteCheck && ProcessExist("SciTE.exe") && GetScriptParentProcess() = "SciTE.exe"){
	;~ ;if script parent is scite,output to scite console & return
		;~ FileAppend, %output%`n, *
		;~ Return
	;~ }
	;~ ( output ? ( !___console___? (DllCall("AttachConsole", "int", -1) || DllCall("AllocConsole")) & (___console___:= true) : "" ) & FileAppend(output . "`n","CONOUT$") & (Stdin := FileReadLine("CONIN$",1)) : DllCall("FreeConsole") & (___console___:= false) & StdExit() )
	;~ Return Stdin
;~ }

;~ StdExit(){
	;~ If GetScriptParentProcess() = "cmd.exe"
	;~ ;couldn't get this: 'DllCall("GenerateConsoleCtrlEvent", CTRL_C_EVENT, 0)' to work so...
		;~ ControlSend, , {Enter}, % "ahk_pid " . GetParentProcess(GetCurrentProcess())
;~ }





