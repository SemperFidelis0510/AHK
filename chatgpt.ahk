#NoEnv

#IfWinActive ahk_exe ChatGPT.exe

Enter:: Send, +{Enter}
^Enter:: Send, {Enter}
^d::MClick(1135, 831, "window")
^q::MClick(54, 101, "window")

::yes_or_no:: Please give me a yes or no response to the question.
::check_online:: Before your response, please check online for any data required to answer my question.
::recheck_answer:: Please check again the last response you gave me, and the last prormpt I gave you, and tell me if you really fullfiled my request.
::memory_add:: Add this information I give you to your memory.
::expand::Continue any necessary work, and expand on what you suggested for a plan ahead.

#IfWinActive Gemini

Enter:: Send, +{Enter}
^Enter:: Send, {Enter}
^q::MClick(46, 45, "window")

::yes_or_no:: Please give me a yes or no response to the question.
::check_online:: Before your response, please check online for any data required to answer my question.
::recheck_answer:: Please check again the last response you gave me, and the last prormpt I gave you, and tell me if you really fullfiled my request.
::memory_add:: Add this information I give you to your memory.
::expand::Continue any necessary work, and expand on what you suggested for a plan ahead.

#If