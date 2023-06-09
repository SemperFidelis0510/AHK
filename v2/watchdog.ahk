#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#Include WatchFolder.ahk
#include functions.ahk
#include paths.ahk


watchlist.push(paths["downloads"])
;~ msgbox % paths["downloads"]

for key, val in watchlist {
	;~ msgbox % watchlist[key]
	WatchFolder(val, "watchdog")
}

watchdog(folder, events) {
	local
	global paths, FileClass
	Static actions := ["added", "removed", "modified", "renamed"]

	switch folder {
		case % paths["downloads"]:
			for i, event in events {
				Switch actions[event.action] {
					Case "added":
						file := new FileClass(event.name)
						msgbox % file.name
						file.sort()
				}
			}
	}

	return
}
