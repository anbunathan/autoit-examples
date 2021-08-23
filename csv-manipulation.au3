; write the data to the CSV file
Global $hFile = FileOpen('test.csv', 10)
If $hFile = -1 Then Exit
FileWrite($hFile, '1' & @TAB & '502 ' & @TAB & 'shop' & @TAB & '25.00' & @CRLF & _
              '2' & @TAB & '106 ' & @TAB & 'house' & @TAB & '50.00' & @CRLF & _
              '3' & @TAB & '307' & @TAB & 'boat' & @TAB & '15.00')

FileClose($hFile)

; read the CSV file and create a new one
If Not FileExists('test.csv') Then Exit
Global $hFileIn  = FileOpen('test.csv')
Global $hFileOut = FileOpen('test_new.csv', 10)

While 1
    Global $sLine = FileReadLine($hFileIn)
    If @error = -1 Then ExitLoop

    If StringInStr($sLine, '106') Then
        $sLine = _ReplacePrices($sLine)
        ConsoleWrite('New price: ' & $sLine & @CRLF)
    EndIf
    FileWriteLine($hFileOut, $sLine)
WEnd
FileClose($hFileIn)
FileClose($hFileOut)
Exit

; search for "106" find that and the corresponding value in
; column 4 (50.00) and change the column 4 value to "22.00"
Func _ReplacePrices($sLineFromCSVFile)
    Local $array = StringSplit($sLineFromCSVFile, @TAB)

    If StringStripWS($array[2], 8) = '106' And _
       StringStripWS($array[4], 8) = '50.00' Then
        Return $array[1] & @TAB & $array[2] & @TAB & _
                   $array[3] & @TAB & '22.00'
    EndIf
EndFunc