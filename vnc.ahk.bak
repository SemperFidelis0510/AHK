#NoEnv
#Warn

store_hotstring() {
	local key, text0
	InputBox, key, Key Name, Please enter key name
	if !ErrorLevel {
		text0 := GetSelectedText()
		msgbox % text
		run_cmd(paths, "save_vnc_hotstring", [text0, "memory/vnc_htostrings.json", key], 2,,, 1)
	}
	return
}

stamp(name:="", type:="") {
	local txt, non_normal

	non_normal := (name or type)

	if non_normal
		FormatTime, txt,, dd/MM/yy
	else
		FormatTime, txt,, dd_MM_yy_hh_mm

	if name
		txt := "by " . name . " at " . txt
	if type
		txt := "// " . type . " " . txt
	if non_normal
		txt := txt . ":"

	SendInput % txt
	return
}

;~ stamp(type, name) {
	;~ FormatTime, CurrentDateTime,, dd/MM/yy
	;~ SendInput % "// " . type . " by " . name . " at " . CurrentDateTime . ": "
	;~ return
;~ }

;~ alt_tab() {
	;~ GetKeyState("alt", "p")
;~ }

#IfWinActive ahk_exe vncviewer.exe

;~ !Tab::Send, ^+l
;~ !Tab::

;~ ^WheelRight::+^k
;~ ^WheelLeft::+^l

$XButton1::
{
    Click 2
    Sleep 100
    Click Middle
}


;~ ^+h::store_hotstring()

;~ ::secbr:://--------------------------------------------------------

;~ :X:comment::stamp("COMMENT", "btavor")
;~ :X:todo::stamp("TODO", "btavor")
;~ :X:question::stamp("QUESTION", "btavor")

::fog_flag::-inc_comp 0
:X:datetime_::stamp()

#IF
