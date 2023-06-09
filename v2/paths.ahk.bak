#NoEnv
SendMode Input
EnvGet, pandora, Pandora
SetWorkingDir % pandora . "\ahk"
#Include utils.ahk

class PathClass {
	PL := {}
	sys := {}
	scripts := {}
	cache := {}
	computer := {}
	computers := {"CHRONOS6": 1, "ZEUS2": 2, "PHYAROM2": 3}
	locations := {}

	__New() {
		local AppData, OneDrive, ProgramData, UserDir
		EnvGet, AppData, appdata
		StringTrimRight, AppData, AppData, 8
		EnvGet, OneDrive, OneDrive
		EnvGet, ProgramData, ProgramData
		EnvGet, UserDir, USERPROFILE

		this.computer := {A_ComputerName: this.computers[A_ComputerName]}
		this.locations := {"document": {}, "picture": {}, "program": {}, "archive": {}}
		this.sys := {"appdata": APPDATA, "onedrive": ONEDRIVE, "programData": programData, "user": UserDir, "ProgramFiles": ProgramFiles}
	}

	__Get(path) {
		if this.sys[path]
			return this.sys[path]
		else if this.PL[path]
			return this.PL[path]
		else if this.scripts[path]
			return this.scripts[path]
		else if (path="comp") or (path="computer")
			return this.computer
	}

	__Set(field, pair) {
		PathClass[field][pair[1]] := pair[2]
	}

	append(name, path) {
		this.PL[name] := path
	}

	load(ini_file:=0) {
		local
		if not ini_file
			ini_file := this["onedrive"] . "\Pandora\ahk\memory\paths.ini"

		IniRead, sections, %ini_file%
		For Each, section in sections {
			IniRead, dict, %ini_file%
			For key, val in dict {
				this[section][key] := val
			}
		}
		this.PL["pathList"] := ini_file
		return
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

	revise(path, relative_path:="", enclose:=1){

		If this.PL[path]
			path := this.PL[path]

		If relative_path
			path := path . "\" . relative_path

		If enclose
			path := """" . path . """"

		return path
	}

	split(pth) {
		return new fileClass(pth)
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

	sort(action:="run") {
		local flist := ""
		;~ global foldernamegui, filenamegui
		;~ global path
		switch action {
			case "run":
				this.sort("create")
				this.sort("show")
			case "create":
				For key, val in pathclass.locations[this.type]
					flist .= key . "|"
				flist := SubStr(flist, 1, StrLen(flist)-1)

				Gui, filemanager:New, +Border +AlwaysOnTop +Delimiter|, % "File Manager for " . this.name

				Gui, Add, Text, x22 y9 w100 h20, Save file to:
				Gui, Add, ListBox, x22 y39 w100 h140 vfoldernamegui, %flist%
				;~ problem with gfoldernamegui

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



global paths := new PathClass


;win folders
paths["CabinetWClass"] :=  paths["appdata"] . "\Roaming\Microsoft\Windows\Libraries"
paths["winapps"] :=        paths["ProgramFiles"] . "\WindowsApps"
paths["startmenu"] :=      paths["programdata"] . "\Microsoft\Windows\Start Menu"
paths["startmenuLocal"] := paths["appdata"] . "Roaming\Microsoft\Windows\Start Menu"
paths["startup"] :=        paths["startmenu"] . "\Programs\StartUp"
paths["startupLocal"] :=   paths["startmenu2"] . "\Programs\StartUp"

;libraries
paths["documents"] := paths["onedrive"] . "\Documents"
paths["downloads"] := paths["user"] . "\downloads"

;coding folders
paths["pandora"] := paths["onedrive"] . "\pandora"
paths["ahk"] := paths["pandora"] . "\ahk"
paths["memory"] := paths["ahk"] . "\memory"
;~ paths["rainmeter"] := paths["onedrive"]

;my folders
paths["mydocs"] := paths["onedrive"] . "\Documents\My Documents"
paths["uranus"] := paths["onedrive"] . "\My Documents\Thoughts\Uranus"
paths["courses"] := paths["onedrive"] . "\Documents\School\Courses"
paths["research"] := paths["onedrive"] . "\Documents\School\Projects\PhD"
paths["recs"] := paths["onedrive"] . "\Documents\School\Tutorials"

;coding programs
paths["cmd"] := "*RunAs cmd"
paths["Mathematica"] := paths["ProgramFiles"] . "\Wolfram Research\Mathematica\13.0\Mathematica.exe"
paths["windowspy"] := paths["ProgramFiles"] . "\AutoHotkey\windowspy.ahk"
paths["UIAViewer"] := paths["ahk"] . "\UIAutomation-main\UIAViewer.ahk"
paths["lyx menus"] := paths["pandora"] . "\lyx\menu_list.txt"
paths["regjump"] := paths["pandora"] . "\windows\sysinternals\regjump"

;other programs
paths["Chrome"] := "chrome.exe"
paths["SumatraPDF"] := paths["appdata"] . "\Local\SumatraPDF\SumatraPDF.exe"
paths["PDFXEdit"] := paths["ProgramFiles"] . "\Tracker Software\PDF Editor\PDFXEdit.exe"
paths["WhatsApp"]:= paths["winapps"] . "\5319275A.WhatsAppDesktop_2.2242.6.0_x64__cv1g1gvanyjgm\WhatsApp.exe"
paths["Discord"] := paths["appdata"] . "\Local\Discord\Update.exe --processStart Discord.exe"
paths["LyX"]  := paths["ProgramFiles"] . "\LyX 2.3\bin\LyX.exe"
paths["OUTLOOK"] := paths["ProgramFiles"] . "\Microsoft Office\root\Office16\OUTLOOK.EXE"
paths["ONENOTE"] := paths["ProgramFiles"] . "\Microsoft Office\root\Office16\ONENOTE.EXE"
paths["Spotify"] := paths["appdata"] . "\Roaming\Spotify\Spotify.exe"

;scripts
paths.scripts["sync"] := paths["pandora"] . "\windows\sync.py"
paths.scripts["add_lyx_item"] := paths["pandora"] . "\lyx\add_item.py"
paths.scripts["themis"] := paths["pandora"] . "\windows\themis.py"
paths.scripts["plutus"] := paths["pandora"] . "\plutus\main.py"
paths.scripts["clip_img"] := paths["pandora"] . "\windows\clip_img.py"

;cache
paths.cache["explorer"] := paths["CabinetWClass"]
paths.cache["recitations"] := paths["recitations"]
paths.cache["pandora"] := paths["pandora"]
paths.cache["school"] := paths["courses"]
paths.cache["research"] := paths["research"]
paths.cache["documents"] := paths["mydocs"]
paths.cache["thoughts"] := paths["uranus"]

paths["programming"] := paths["pandora"]
paths["communication"] := paths["WhatsApp"]

;~ locations
paths.locations["document"] := {"My documents": "mydocs", "PhD": "research", "Recitations": "recs", "Courses": "courses", "Uranus": "uranus"}

Switch A_ComputerName {
	;~ Case "CHRONOS6":
	Case "ZEUS2":
		paths["Spotify"] := paths["ProgramFiles"] . "\WindowsApps\SpotifyAB.SpotifyMusic_1.189.862.0_x86__zpdnekdrzrea0\Spotify.exe"
	Case "PHYAROM2":
		paths["LyX"] := paths["ProgramFiles"] . " (x86)\LyX 2.3\bin\LyX.exe"
		paths["WhatsApp"]:= paths["appdata"] . "\Local\WhatsApp\WhatsApp.exe"

}


;~ APPDATA:=
;~ ONEDRIVE:=
;~ programdata:=
;~ userDir:=