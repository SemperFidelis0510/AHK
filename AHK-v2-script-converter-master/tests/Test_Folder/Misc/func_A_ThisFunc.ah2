MyFunc() {
	fn := %A_ThisFunc%
	MsgBox(fn.Name "() is " (fn.IsBuiltIn ? "built-in." : "user-defined."))
}

MyFunc()