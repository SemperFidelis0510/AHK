#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#include functions.ahk

WinGet, abc, List, ahk_class CabinetWClass
loop, %abc%{
	id := abc%A_Index% %id%
	shellWindows := ComObjCreate("Shell.Application").Windows
	shellFolderView := shellWindows.Item( ComObject(VT_UI4 := 0x13, SWC_DESKTOP := 0x8) ).Document
	for window in shellWindows       ; ShellFolderView object: https://goo.gl/MhcinH
         if (hWnd = window.HWND) && (shellFolderView := window.Document)
            break

	ControlFocus, Edit1, ahk_id %id%
	ControlGet, path, Line ,1, Edit1, ahk_id %id%
	WinGetText, text, ahk_id %id%, Address:
	path :=

	msgbox % shellFolderView.Folder.Self.Path
}

Explorer_GetActiveFolderPath() {
   WinGetClass, winClass, % "ahk_id" . hWnd := WinExist("A")
   if !(winClass ~="Progman|WorkerW|(Cabinet|Explore)WClass")
      Return

   shellWindows := ComObjCreate("Shell.Application").Windows
   if (winClass ~= "Progman|WorkerW")  ; IShellWindows::Item:    https://goo.gl/ihW9Gm
                                       ; IShellFolderViewDual:   https://goo.gl/gnntq3
      shellFolderView := shellWindows.Item(ComObject(VT_UI4 := 0x13, SWC_DESKTOP := 0x8) ).Document
   else {
      for window in shellWindows       ; ShellFolderView object: https://goo.gl/MhcinH
         if (hWnd = window.HWND) && (shellFolderView := window.Document)
            break
   }
   Return shellFolderView.Folder.Self.Path
}

#1:: msgbox % Explorer_GetActiveFolderPath()

get_clip_img() {
	local img := False
	if DllCall("OpenClipboard", "ptr", 0) {
		if DllCall("IsClipboardFormatAvailable", "uint", 2) {
			img := DllCall("GetClipboardData", "uint", 2, "ptr")
		}
		DllCall("CloseClipboard")
	}
	return img ? img : False
}

get_clip_img2() {
	local
    ; Copy clipboard data to a variable
    ClipData := ClipboardAll

    ; Get Image Dimensions
    ; Width Bytes
    VarSetCapacity(BinWidth, 4, 0)
    DllCall("RtlMoveMemory", UInt, &BinWidth, UInt, &(ClipData) + 20, Int, 4)

    ; Calculate Decimal Width
    x1 := *(&(BinWidth)+1)
    x2 := *(&(BinWidth))
    Width := (x1 * 256) + x2

    ; Height Bytes
    VarSetCapacity(BinHeight, 4, 0)
    DllCall("RtlMoveMemory", UInt, &BinHeight, UInt, &(ClipData) + 24, Int, 4)

    ; Calculate Decimal Width
    y1 := *(&(BinHeight)+1)
    y2 := *(&(BinHeight))
    Height := (y1 * 256) + y2

    ; Variable initialization
    VarSetCapacity(ImageFile, (Width * Height * 4) + 54, 0)
    VarSetCapacity(BmpHeader, 54, 0)

    ; BMP Header Construction
    ; Find a bmp file to copy the header
    Loop, % A_WinDir "*.bmp", 0, 1
    {
        FileRead, BmpHeader, % A_LoopFileLongPath
        break
    }

    ; Copy the correct image size to valid BMP Header
    DllCall("RtlMoveMemory", UInt, &(BmpHeader) + 18, UInt, &BinWidth, Int, 4)
    DllCall("RtlMoveMemory", UInt, &(BmpHeader) + 22, UInt, &BinHeight, Int, 4)

    ; Copy the correct bit depth to valid BMP Header
    DllCall("RtlMoveMemory", UInt, &(BmpHeader) + 28, UInt, &(ClipData) + 30, Int, 2)

    ; Copy the BMP Header to new ImageFile variable
    DllCall( "RtlMoveMemory", UInt, &ImageFile, UInt, &BmpHeader, Int, 54)
    ; Copy the Image data to new ImageFile variable
    DllCall( "RtlMoveMemory", UInt, &(ImageFile) + 54, UInt, &(ClipData) + 68, Int, Width * Height * 4)

    ; Write data to file
    fh := OpenFileForWrite(filename)
    WriteInFile(fh, ImageFile, (Width * Height * 4) + 54)
    CloseFile(fh)
	return
}





