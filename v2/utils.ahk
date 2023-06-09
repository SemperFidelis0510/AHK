SetWorkingDir %A_ScriptDir%


inlist(o, l) {
	local x, i
	for i, x in l
		if (o=x)
			return true
	return false
}

quote(txt) {
	txt := "%txt%"
	return txt
	;~ return """" . txt . """"
}

join(sep:=" ", params*){
	local i
	str := ""
    for i, param in params
        str .= param . sep
	StringTrimRight str, str, strlen(sep)
	return str
}

append_to_file(file_path, list_of_lines, line:=0){
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

EncodeDecodeURI(str, encode:=true, component:=true){
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

in_rect(coo, rect) {
	local LTcorner := rect[1]
	local RBcorner := rect[2]
	local dx := [Abs(RBcorner[1] - LTcorner[1]), Abs(RBcorner[2] - LTcorner[2])]
	return ((Abs(RBcorner[1]+LTcorner[1]-2*coo[1])<dx[1]) and (Abs(RBcorner[2]+LTcorner[2]-2*coo[2])<dx[2]))
}

TimeStamp(date:=True, time:=True) {
	local td := ""
	local tt := ""
	if date
		FormatTime td,, yyyyMMdd
	if time {
		FormatTime tt,, HHmmss
		td .= tt
	}
	return td
}

make_file_name(name) {
	local
	chars := [%A_Space%, `!, `@, `#, `$, `%, `^, `&, `*, `|, `\, `/, `?, `,, `:, `;]
	For each, key in chars
		StringReplace name, name, %key%, `_
	return name
}

format_cmd(cmd) {
	local flag := False
	IfInString, cmd, %A_Space%
		flag := True
	IfInString, cmd, `&
		flag := True
	IfInString, cmd, `\
		flag := True
	IfInString, cmd,  `/
		flag := True
	IfInString, cmd, `~
		flag := True

	If flag
		cmd := quote(cmd)
	return cmd
}

render_hotstrings(list, prefix:=":*:") {
	local key, val
	For key, val in list
		Hotstring(prefix . key, val, "on")
	return
}

get_screens_data(scr, debug:=0){
	local
	SysGet, moncount, Monitorcount
	scr["count"] := moncount
	Loop % moncount {
		SysGet, mon, Monitor, %A_Index%
		sysget, monName, MonitorName, %A_Index%
		scr["enum"][monName] := A_Index
		if (debug="screen")
			msgbox % "screen name: " . monName . "`nscreen index: " . A_Index . "`nscreen number: " . scr["enum"][monName]

		scr["Xrange"].push([monLeft, monRight])
		scr["Yrange"].push([monTop, monBottom])
		;~ dimX :=
		;~ dimY :=
		scr["dim"].push([abs(monRight-monLeft), abs(monBottom-monTop)])
		;~ COMX :=
		;~ COMY :=
		scr["COM"].push([(monRight+monLeft)/2, (monBottom+monTop)/2])
	}
	return scr
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

AnyWinActive(param*) {
	local
	for Each, win in param {
		if WinActive(WinID(win))
			return True
	}
	return False
}

WinID(name) {
	if (SubStr(name, 1, 4)="ahk_")
		return name
	else
		return "ahk_exe " . name
}


