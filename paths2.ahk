#NoEnv
SendMode Input
EnvGet, pandora, Pandora
;~ SetWorkingDir % pandora . "\ahk"
#Include utils.ahk



loadPaths(ByRef obj) {
    ; This function uses the paths defined in the ini file to construct pathObj
	local iniFile := "paths.ini"

    ; Read base paths from the ini file
    ReadIniSection(iniFile, "paths", obj)

    ; Read other sections and construct the nested pathObj structure
    ConstructNestedPaths(iniFile, "scripts", obj, "scripts")
    ConstructNestedPaths(iniFile, "groups_def", obj, "groups_def")
    ConstructNestedPaths(iniFile, "cache", obj, "cache")

    ; Adjust paths based on computer name
    ComputerNameAdjustments(obj, iniFile, A_ComputerName)
}

; Read a section from the ini file and store it in a nested object structure
ConstructNestedPaths(iniFile, section, ByRef obj, subObj) {
    tempObj := {}
    ReadIniSection(iniFile, section, tempObj)
    obj[subObj] := tempObj
}

; Adjust paths based on computer name
ComputerNameAdjustments(ByRef obj, iniFile, computerName) {
    if (computerName = "ZEUS2" or computerName = "PHYAROM2") {
        ReadIniSection(iniFile, computerName, obj)
    }
}

; Reads a section from the ini file into the provided object
ReadIniSection(iniFile, section, ByRef obj) {
	local key
    Loop, Read, %iniFile%
    {
        IniRead, value, %iniFile%, %section%, %A_LoopReadLine%
        if (ErrorLevel = 0) ; If the key exists
        {
            key := A_LoopReadLine
            value := ReplaceEnvVariables(value, obj)
            obj[key] := value
        }
    }
}

; Replace environment variables in the value with corresponding values from obj
ReplaceEnvVariables(value, obj) {
    while, RegExMatch(value, "%([^%]+)%", match)
    {
        envVar := match1
        if (obj.HasKey(envVar))
            value := StrReplace(value, "%" envVar "%", obj[envVar])
        else
            value := StrReplace(value, "%" envVar "%", envVar)
    }
    return value
}



