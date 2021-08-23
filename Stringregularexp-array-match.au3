#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Local $aResult = StringRegExp("This is a test example", '(test)', $STR_REGEXPARRAYMATCH)
If Not @error Then
    MsgBox($MB_OK, "SRE Example 4 Result", $aResult[0])
EndIf
$aResult = StringRegExp("This is a test example", '(te)(st)', $STR_REGEXPARRAYMATCH)
If Not @error Then
    MsgBox($MB_OK, "SRE Example 4 Result", $aResult[0] & "," & $aResult[1])
EndIf