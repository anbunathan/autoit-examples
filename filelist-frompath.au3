#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
    ; List all the files and folders in the desktop directory using the default parameters.
    Global $aFileList = _FileListToArray("D:\Webapp\dayananda\BTech\Blockchain\Attendance", "*csv")
    If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf
    ; Display the results returned by _FileListToArray.
    _ArrayDisplay($aFileList, "$aFileList")
	For $i = 1 to $aFileList[0]
	   ConsoleWrite("filename: " & $aFileList[$i] & @CRLF)
    Next
EndFunc   ;==>Example