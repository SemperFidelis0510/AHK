#NoEnv
#Warn
#SingleInstance Force
SendMode, input
SetWorkingDir %A_ScriptDir%


F6::reload



~Lbutton::f2()
~RButton::f2()


;~ ~LButton::
	;~ t1 := A_TickCount
	;~ MouseGetPos, X1, Y1, Win1, Cont1, Flag1
;~ return


;~ ~RButton::
	;~ t1 := A_TickCount
	;~ MouseGetPos, X1, Y1, Win1, Cont1, Flag1
;~ return

;~ ~LButton Up::f(x1,y1,t1)
;~ ~RButton Up::f(x1,y1,t1)


f2() {
	d := []
	n := 0
	t := A_TickCount
	MouseGetPos, X, Y, Win, Cont, Flag
	D.push([x,y,t])
	ToolTip, %txt% , %x%, %y%, 1

	loop {
		tooltip % n
		n += 1
		sleep 100
		t := A_TickCount - D[D.length()][3]
		MouseGetPos, X, Y, Win, Cont, Flag
		D.push([x,y,t])
		txt := x . "|" . y . "|" . t
		ToolTip, %txt% , %x%, %y%, mod(n, 20)+1

		;~ tooltip % GetKeyState(Lbutton)
		if not GetKeyState(Lbutton)
			return
	}
	return
}

f(x1,y1,t1) {
	t2 := A_TickCount - t1
	MouseGetPos, X2, Y2, Win2, Cont2, Flag2
	tooltip, %X1%`,%Y1%`,%t1% , %X1%, %Y1%, 1
	tooltip, %X2%`,%Y2%`,%t2% , %X2%, %Y2%, 2
	return
}

