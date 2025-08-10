import subprocess
import os
import mine

path = mine.Path('pandora', 'ahk')
os.chdir(path)

p = subprocess.Popen([r'C:\program files\AutoHotkey\AutoHotkey.exe', path + '\\python.ahk', 'xxx'], stdout=subprocess.PIPE,
                     stdin=subprocess.PIPE)
y = p.communicate(b'xxx')

print(y)
