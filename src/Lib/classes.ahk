#include Lib/utils.ahk

class PathClass {
	PL := {}
	sys := {}
	scripts := {}
	cache := {}
	groups_def := {}
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
		EnvGet, pandora, Pandora

		this.computer := {A_ComputerName: this.computers[A_ComputerName]}
		this.locations := {"document": {}, "picture": {}, "program": {}, "archive": {}}
		this.sys := {"appdata": APPDATA, "onedrive": ONEDRIVE, "programData": programData, "user": UserDir, "ProgramFiles": ProgramFiles, "pandora": Pandora}
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

	append(name, intPath, newPath) {
		if SubStr(newPath, 1, 1) not in "\","/"
			newPath := "\" . newPath
		this.PL[name] := this.PL[intPath] . newPath
	}

	load(ini_file:=0) {
		local
		if not ini_file
			ini_file := this["pandora"] . "\ahk\memory\paths.ini"

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

	extractINI(ini_path) {
		local
		global comp_names
		path_ini := parse_ini(ini_path)
		for sect in path_ini
		{
			for key, val in sect
			{
				if (InStr(val, "%"))
					val := replace_Substrings(val, this.PL)

				switch sect
				{
					Case "scripts":
						this.scripts[key] := val
					Case "group_def":
						this.group_def[key] := val
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
