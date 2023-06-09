#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#include utils.ahk

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

;~ create_submenus(){
	;~ for i, item in list
	;~ return
;~ }

context_menu(submenu:="context", item:=false){
	static text, title
	context_sensitive := {"SumatraPDF.exe": "Sumatra", "LyX.exe": "LyX"}
	switch submenu {
		case "show":
			focus.get("mouse")
			WinActivate % "ahk_id " . focus.aWin["id"]

			if context_sensitive[focus.aWin["name"]] {
				menu, context, add, % context_sensitive[focus.aWin["name"]], % ":" . context_sensitive[focus.aWin["name"]]
				;~ Menu, context, Disable, % context_sensitive[focus.aWin["name"]]
			}
			Menu, context, Show
			if context_sensitive[focus.aWin["name"]]
				menu, context, delete, % context_sensitive[focus.aWin["name"]]

		;~ case "context":
			;~ switch item	{
			;~ }
		case "search":
			if not focus.text {
				InputBox, text, Search Query, What whould you like to search?
				focus.text := text
			}
			if not focus.text
				return

			search_web(focus.text, item)
		case "analytics":
			switch item {
				case "winspy":
					Run % "autohotkey.exe " . quote(paths["windowspy"])
				case "UIAViewer":
					Run % "autohotkey.exe " . quote(paths["UIAViewer"])
				case "path":
					Clipboard := focus.path
			}
		case "runWith":
			switch item	{
				case "cmd":
					browser("cmd")
					print_text(focus.text)
				case "regedit":
					open_regedit(focus.text)
				case "explorer":
					run_cmd("explorer.exe",, 0, focus.text)
			}
		case "sumatra":
			switch item {
				case "save_page":
					sumatra_save_page()
				case "annotate":
					InputBox, text, Add Annotation, Enter Annotation
					sumatra_annotate(text, focus.mouse)
				case "save_ref":
					sumatra_save_ref(focus.text)
				case "show_ref":
					sumatra_show_ref(focus.mouse)
			}
		case "lyx":
			switch item {
				case "store_formula":
					lyx_store_formula(focus.text)
					refresh_prog(focus.aWin["id"], True)
				case "save_macro":
					lyx_save_macro(focus.text)
				case "append_uranus":
					lyx_file := paths["onedrive"] . "\Documents\My Documents\Thoughts\Uranus\Olympus\Important Formulas.lyx"
					Inputbox, title, Choose Title, Choose title for formula:
					lyx_append_uranus(lyx_file, focus.text, title)
			}
	}
	return
}

menu_list := {}
menu_list["context"] := [["Use Text for...", ":search"]
						,["Open With...", ":runwith"]
						,["Analytics...", ":analytics"]]
menu_list["context_lyx"] := [["Text...", ":search"]
							,["Open With...", ":runwith"]
							,["Analytics...", ":analytics"]
							,["LyX", ":lyx"]]

menu_list["context_sumatra"] := [["Text...", ":search"]
								,["Open With...", ":runwith"]
								,["Analytics...", ":analytics"]
								,["Sumatra", ":sumatra"]]

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
create_menu("Sumatra")
create_menu("LyX")

create_menu("context")
create_menu("context_lyx")
create_menu("context_sumatra")


global context, context_lyx, context_sumatra
Menu, context, UseErrorLevel, On
Menu, context_lyx, UseErrorLevel, On
Menu, context_sumatra, UseErrorLevel, On












