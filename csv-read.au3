#include <Array.au3> ; Required for _ArrayDisplay() only.
#include <WinAPI.au3>
; read the CSV file and create a new one
$filename = 'D:\Webapp\dayananda\BTech\Blockchain\Attendance\dsu-blockchain (2021-08-02).csv'
If Not FileExists($filename) Then Exit
Global $hFileIn  = FileOpen($filename,128)
Global $hFileOut = FileOpen('test_new.csv', 10)

While 1
    Global $sLine = FileReadLine($hFileIn)
    If @error = -1 Then ExitLoop
    ;ConsoleWrite($sLine & @CRLF)
    $input = StringSplit($sLine, ",", 1)
    $value1 = $input[1]
    $value2 = $input[2]
    $value3 = $input[3]
    $value4 = $input[4]
	$sFormattedName = StringRegExpReplace($value1, '(Eng1[6789]cs\d{4}\s{0,1})(-)*\s{0,1}', '')
	ConsoleWrite($sFormattedName & @CRLF)
    ; Display the array to see that it contains the ASCII values for each character in the string.
	Local $aArray = StringToASCIIArray($value2)
	Local $iIndex = _ArraySearch($aArray, "10004", 0, 0, 0, 0, 1, 2)
	if $iIndex>0 Then
	  ConsoleWrite("P" & @CRLF)
    EndIf
    ;_ArrayDisplay($aArray)
    ;Local $utfStr = Execute("'" & StringRegExpReplace($value2, "(\\u([[:xdigit:]]{4}))","' & ChrW(0x$2) & '") & "'")
    ;Local $ansiStr = _WinAPI_WideCharToMultiByte($utfStr)
    ;MsgBox(64,"Unicode2Ansi", $utfStr & @CRLF & $ansiStr)
	ConsoleWrite($value1 & @CRLF)
	ConsoleWrite($value2 & @CRLF)
	ConsoleWrite($value3 & @CRLF)
	ConsoleWrite($value4 & @CRLF)
    FileWriteLine($hFileOut, $sLine)
WEnd
FileClose($hFileIn)
FileClose($hFileOut)
Exit