Local $sFile = "C:\Program Files\Another Dir\AutoIt3\dsu-blockchain (2021-08-02).csv"

; Drive letter -                                     Example returns     "C"
Local $sDrive = StringRegExpReplace($sFile, ":.*$", "")

; Full Path with backslash -                         Example returns     "C:\Program Files\Another Dir\AutoIt3\"
Local $sPath = StringRegExpReplace($sFile, "(^.*\\)(.*)", "\1")

; Full Path without backslash -                     Example returns     "C:\Program Files\Another Dir\AutoIt3"
Local $sPathExDr = StringRegExpReplace($sFile, "(^.:)(\\.*\\)(.*$)", "\2")

; Full Path w/0 backslashes, nor drive letter -     Example returns     "\Program Files\Another Dir\AutoIt3\"
Local $sPathExDrBSs = StringRegExpReplace($sFile, "(^.:\\)(.*)(\\.*$)", "\2")

; Path w/o backslash, not drive letter: -             Example returns     "Program Files\Another Dir\AutoIt3"
Local $sPathExBS = StringRegExpReplace($sFile, "(^.*)\\(.*)", "\1")

; File name with ext -                                 Example returns     "dsu-blockchain (2021-08-02).csv"
Local $sFilName = StringRegExpReplace($sFile, "^.*\\", "")
$date = StringRegExpReplace($sFilName, '(dsu-blockchain )*[\(]*(\).csv)*', '')
ConsoleWrite($date & @CRLF)

; File name w/0 ext -                                 Example returns     "AutoIt3"
Local $sFilenameExExt = StringRegExpReplace($sFile, "^.*\\|\..*$", "")

; Dot Extenstion -                                     Example returns     ".chm"
Local $sDotExt = StringRegExpReplace($sFile, "^.*\.", ".$1")

; Extenstion -                                         Example returns     "chm"
Local $sExt = StringRegExpReplace($sFile, "^.*\.", "")

MsgBox(0, "Path File Name Parts", _
        "Drive             " & @TAB & $sDrive & @CRLF & _
        "Path              " & @TAB & $sPath & @CRLF & _
        "Path w/o backslash" & @TAB & $sPathExBS & @CRLF & _
        "Path w/o Drv:     " & @TAB & $sPathExDr & @CRLF & _
        "Path w/o Drv or \'s" & @TAB & $sPathExDrBSs & @CRLF & _
        "File Name         " & @TAB & $sFilName & @CRLF & _
        "File Name w/o Ext " & @TAB & $sFilenameExExt & @CRLF & _
        "Dot Extension     " & @TAB & $sDotExt & @CRLF & _
        "Extension         " & @TAB & $sExt & @CRLF)