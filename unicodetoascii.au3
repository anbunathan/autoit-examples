#include <WinAPI.au3>

Local $str = "My name is \u0393\u03A1\u0397"
Local $utfStr = Execute("'" & StringRegExpReplace($str, "(\\u([[:xdigit:]]{4}))","' & ChrW(0x$2) & '") & "'")
Local $ansiStr = _WinAPI_WideCharToMultiByte($utfStr)
MsgBox(64,"Unicode2Ansi", $utfStr & @CRLF & $ansiStr)

Exit