#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#include utils.ahk
#include constants.ahk


lyx_gui(button, type:="", name:="", parent:="", formula:="") {
	local menus
	switch button {
		case "create":
			Gui, lyxgui:New, +Border +AlwaysOnTop +Delimiter`n, Store Formula
			Gui, lyxgui:Add, Text, x12 y29 w110 h20, Item name:
			Gui, lyxgui:Add, Text, x12 y59 w110 h20, Parent menu:
			Gui, lyxgui:Add, Edit, x132 y29 w210 h20 vguiName
			FileRead, menus, % paths["lyx menus"]
			Gui, lyxgui:Add, DropDownList, x132 y59 w210 vguiParent HwndMenuList, %menus%
			GuiControl, Choose, % MenuList, 1
			Gui, lyxgui:Add, DropDownList, x362 y29 w90 vguiType HwndTypeList, Formula`nMenu
			Gui, lyxgui:Default
		case "ok":
			file_args := ["--add", type, "--name", name]
			if (parent != "")
				file_args.push("--parent", parent)
			if (type != "Menu") and (formula != "")
				file_args.push("--latex", formula)

			run_cmd("add_lyx_item", 1, 2,, file_args*)
			Gui, Submit
			Gui, Destroy
		case "cancel":
			Gui, Destroy
		case "delete":
			file_args := ["--delete", type, "--name", name]
			if (Parent != "")
				file_args.push("--parent", parent)

			run_cmd("add_lyx_item", 1,,, file_args*)
			Gui, Submit
			Gui, Destroy
	}
	return
}


global guiName := ""
global guiType := ""
global guiParent:= ""
global guiFormula := ""
global OkButton, CanButton, DelButton, MenuList, TypeList



;~ file_manager_gui(action, file:=0) {
	;~ local type := ""
	;~ switch action {
		;~ case "create":
			;~ If (file["type"]="folder")
				;~ type := "Folder"
			;~ Else If (file["type"]="file")
				;~ type := file["ext"]

			;~ Gui, fmgrgui:New, +Border +AlwaysOnTop +Delimiter`n, File Manager
			;~ Gui, fmgrgui:Add, Button, x30 y239 w100 h30, Open
			;~ Gui, fmgrgui:Add, Button, x150 y239 w100 h30, Save
			;~ Gui, fmgrgui:Add, Button, x270 y239 w100 h30, Delete
			;~ Gui, fmgrgui:Add, Button, x390 y239 w100 h30, Cancel

			;~ Gui, fmgrgui:Add, Text, x22 y9 w100 h20, Save file to:
			;~ Gui, fmgrgui:Add, ListBox, x22 y39 w100 h140, Save to Folder
			;~ Gui, fmgrgui:Add, Button, x22 y189 w100 h20, Add Folder

			;~ Gui, fmgrgui:Add, GroupBox, x142 y9 w250 h190, File Data
			;~ Gui, fmgrgui:Add, Text, x152 y29 w50 h20 , File Name:
			;~ Gui, fmgrgui:Add, Edit, x152 y49 w220 h40 +Wrap +Left, % file["name"]
			;~ Gui, fmgrgui:Add, Text, x152 y109 w170 h20, % "File Type: " . type
			;~ Gui, fmgrgui:Add, Text, x152 y139 w170 h20, File Size:
			;~ Gui, fmgrgui:Add, Text, x152 y169 w170 h20, Source Folder:

			;~ Gui, fmgrgui:Add, Button, x402 y49 w100 h30 +Disabled, Unzip

			;~ Gui, Show, w524 h296, fmgrgui
	;~ }
	;~ return
	;~ GuiClose:
	;~ ExitApp
;~ }

