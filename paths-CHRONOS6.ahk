#NoEnv
SendMode Input
EnvGet, pandora, Pandora
SetWorkingDir % pandora . "\ahk"
#Include utils.ahk



loadPaths(pathObj) {

	;win folders
	pathObj["CabinetWClass"] :=  pathObj["appdata"] . "\Roaming\Microsoft\Windows\Libraries"
	pathObj["winapps"] :=        pathObj["ProgramFiles"] . "\WindowsApps"
	pathObj["startmenu"] :=      pathObj["programdata"] . "\Microsoft\Windows\Start Menu"
	pathObj["startmenuLocal"] := pathObj["appdata"] . "Roaming\Microsoft\Windows\Start Menu"
	pathObj["startup"] :=        pathObj["startmenu"] . "\Programs\StartUp"
	pathObj["startupLocal"] :=   pathObj["startmenu2"] . "\Programs\StartUp"
	;~ pathObj[""] := pathObj[""] . "\"


	;libraries
	pathObj["documents"] := pathObj["onedrive"] . "\Documents"
	pathObj["downloads"] := pathObj["user"] . "\downloads"
	;~ pathObj[""] := pathObj[""] . "\"


	;coding folders
	pathObj["pandora"] := pathObj["onedrive"] . "\pandora"
	pathObj["ahk"] := pathObj["pandora"] . "\ahk"
	pathObj["memory"] := pathObj["ahk"] . "\memory"
	;~ pathObj["rainmeter"] := pathObj["onedrive"]


	;my folders
	pathObj["mydocs"] := pathObj["onedrive"] . "\Documents\My Documents"
	pathObj["uranus"] := pathObj["onedrive"] . "\My Documents\Thoughts\Uranus"
	pathObj["courses"] := pathObj["onedrive"] . "\Documents\School\Courses"
	pathObj["research"] := pathObj["onedrive"] . "\Documents\School\Projects\PhD"
	pathObj["recs"] := pathObj["onedrive"] . "\Documents\School\Tutorials"
	;~ pathObj[""] := pathObj[""] . "\"


	;coding programs
	pathObj["cmd"] := "*RunAs cmd"
	pathObj["MathematicaFold"] := pathObj["ProgramFiles"] . "\Wolfram Research\Mathematica\13.0"
	pathObj["Mathematica"] := pathObj["MathematicaFold"] . "\Mathematica.exe"
	pathObj["windowspy"] := pathObj["ProgramFiles"] . "\AutoHotkey\windowspy.ahk"
	pathObj["UIAViewer"] := pathObj["ahk"] . "\UIAutomation-main\UIAViewer.ahk"
	pathObj["lyx menus"] := pathObj["pandora"] . "\lyx\menu_list.txt"
	pathObj["regjump"] := pathObj["pandora"] . "\windows\sysinternals\regjump"
	pathObj["MathematicaKeys"] := pathObj["MathematicaFold"] . "\SystemFiles\FrontEnd\TextResources\Windows\KeyEventTranslations.tr"
	;~ pathObj[""] := pathObj[""] . "\"


	;other programs
	pathObj["SciTE"] := pathObj["ProgramFiles"] . "\AutoHotkey\SciTE\SciTE.exe"
	pathObj["Chrome"] := "chrome.exe"
	pathObj["SumatraPDF"] := pathObj["appdata"] . "\Local\SumatraPDF\SumatraPDF.exe"
	pathObj["PDFXEdit"] := pathObj["ProgramFiles"] . "\Tracker Software\PDF Editor\PDFXEdit.exe"
	pathObj["WhatsApp"]:= pathObj["winapps"] . "\5319275A.WhatsAppDesktop_2.2242.6.0_x64__cv1g1gvanyjgm\WhatsApp.exe"
	pathObj["Discord"] := pathObj["appdata"] . "\Local\Discord\Update.exe --processStart Discord.exe"
	pathObj["LyX"]  := pathObj["ProgramFiles"] . "\LyX 2.3\bin\LyX.exe"
	pathObj["OUTLOOK"] := pathObj["ProgramFiles"] . "\Microsoft Office\root\Office16\OUTLOOK.EXE"
	pathObj["ONENOTE"] := pathObj["ProgramFiles"] . "\Microsoft Office\root\Office16\ONENOTE.EXE"
	pathObj["Spotify"] := pathObj["appdata"] . "\Roaming\Spotify\Spotify.exe"
	pathObj["chatgpt"] := pathObj["ProgramFiles"] . "\ChatGPT\ChatGPT.exe"
	;~ pathObj[""] := pathObj[""] . "\"


	;scripts
	;~ pathObj.scripts["sync"] := pathObj["pandora"] . "\windows\sync.py"
	pathObj.scripts["add_lyx_item"] := pathObj["pandora"] . "\lyx\add_item.py"
	pathObj.scripts["themis"] := pathObj["pandora"] . "\windows\themis.py"
	pathObj.scripts["plutus"] := pathObj["pandora"] . "\main\plutus\main.py"
	pathObj.scripts["clip_img"] := pathObj["pandora"] . "\windows\clip_img.py"
	pathObj.scripts["voiceControl"] := pathObj["pandora"] . "\main\s2t.py"
	;~ pathObj[""] := pathObj[""] . "\"


	;cache
	pathObj.cache["explorer"] := pathObj["CabinetWClass"]
	pathObj.cache["recitations"] := pathObj["recitations"]
	pathObj.cache["pandora"] := pathObj["pandora"]
	pathObj.cache["school"] := pathObj["courses"]
	pathObj.cache["research"] := pathObj["research"]
	pathObj.cache["documents"] := pathObj["mydocs"]
	pathObj.cache["thoughts"] := pathObj["uranus"]

	pathObj["programming"] := pathObj["pandora"]
	pathObj["communication"] := pathObj["WhatsApp"]

	;~ locations
	;~ pathObj.locations["document"] := {"My documents": "mydocs", "PhD": "research"
									 ;~ ,"Recitations": "recs", "Courses": "courses"
									 ;~ ,"Uranus": "uranus"}
	pathObj.locations["document"] := []
	pathObj.locations["document"].push("My documents", "mydocs", 0)
	pathObj.locations["document"].push("PhD", "research", 0)
	pathObj.locations["document"].push("Recitations", "recs", 0)
	pathObj.locations["document"].push("Courses", "courses", 0)
	pathObj.locations["document"].push("Uranus", "uranus", 0)

	Switch A_ComputerName {
		;~ Case "CHRONOS6":
		Case "ZEUS2":
			pathObj["Spotify"] := pathObj["ProgramFiles"] . 			"\WindowsApps\SpotifyAB.SpotifyMusic_1.189.862.0_x86__zpdnekdrzrea0\Spotify.exe"
		Case "PHYAROM2":
			pathObj["LyX"] := pathObj["ProgramFiles"] . " (x86)\LyX 2.3\bin\LyX.exe"
			pathObj["WhatsApp"]:= pathObj["appdata"] . "\Local\WhatsApp\WhatsApp.exe"

	}

	return PathObj
}

