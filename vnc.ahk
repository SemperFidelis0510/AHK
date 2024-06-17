#NoEnv
#Warn

#IfWinActive ahk_exe vncviewer.exe
!1::MClick(200, 15, "client")
!2::MClick(400, 15, "client")
!3::MClick(600, 15, "client")
!4::MClick(800, 15, "client")
!5::MClick(1000, 15, "client")
!6::MClick(1200, 15, "client")
!7::MClick(1400, 15, "client")

#IF
