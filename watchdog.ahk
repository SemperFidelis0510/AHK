#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#Include WatchFolder.ahk
#include functions.ahk

actions := ["added", "removed", "modified", "renamed"]

watchlist.push(paths["downloads"])

for key, val in watchlist {
	WatchFolder(val, "watchdog")
}

watchdog(folder, events) {
	local
	global paths, FileClass

	switch folder {
		case % paths["downloads"]:
			for i, event in events {
				Switch actions[event.action] {
					Case "added":
						file := new FileClass(event.name)
						;~ msgbox % file.name
						file.sort(paths)
				}
			}
	}
	return
}
