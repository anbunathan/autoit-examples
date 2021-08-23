#include <Math.au3>
#include <Array.au3> ; Required for _ArrayDisplay() only.
#include <WinAPI.au3>
#include <File.au3>

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
 ;_ArrayDisplay($aFileList, "$aFileList")
 Global $fileIndex=0
 For $fileIndex = 1 to $aFileList[0]
	Global $hFileOut = FileOpen('D:\Webapp\dayananda\BTech\Blockchain\consolidated\attendance.csv', 128)
	Global $statusDict, $nameDictionary, $status, $filenameWext, $date
   ; Create dictionary object
   $statusDict = ObjCreate("Scripting.Dictionary")
   $nameDictionary = ObjCreate("Scripting.Dictionary")
   If @error Then
	   MsgBox(0, '', 'Error creating the dictionary object')
   EndIf
	ConsoleWrite("filename: " & $aFileList[$fileIndex] & @CRLF)
	$filename = 'D:\Webapp\dayananda\BTech\Blockchain\Attendance\' & $aFileList[$fileIndex]
   ; read the CSV file and create a new one
   ;$filename = 'D:\Webapp\dayananda\BTech\Blockchain\Attendance\dsu-blockchain (2021-08-02).csv'
   If Not FileExists($filename) Then Exit
   ; File name with ext -                                 Example returns     "AutoIt3.chm"
   $filenameWext = StringRegExpReplace($filename, "^.*\\", "")
   $date = StringRegExpReplace($filenameWext, '(dsu-blockchain )*[\(]*(\).csv)*', '')
   ConsoleWrite($date & @CRLF)
   Global $hFileIn  = FileOpen($filename,128)
   Global $nameArray[1]
   Global $value1, $value2, $value3, $value4, $sFormattedName
   While 1
		 Global $opLine = FileReadLine($hFileOut)
		 If @error = -1 Then ExitLoop
		 $output = StringSplit($opLine, ",", 1)
		 $outvalue1 = $output[1]
		 $outvalue2 = $output[2]
		 $outvalue3 = $output[3]
		 ;ConsoleWrite($outvalue1 & @CRLF)
		 ;ConsoleWrite($outvalue2 & @CRLF)
		 _ArrayAdd($nameArray, $outvalue3)
		 ;ConsoleWrite($outvalue3 & @CRLF)
   WEnd
   For $i = 0 To UBound($nameArray)-1
	   ;ConsoleWrite($aArray[$i] & @CRLF)
   Next
   $start = False
   While 1
	   Global $sLine = FileReadLine($hFileIn)
	   If @error = -1 Then ExitLoop
	   ;ConsoleWrite($sLine & @CRLF)
	   $input = StringSplit($sLine, ",", 1)
	   $value1 = $input[1]
	   $value2 = $input[2]
	   $value3 = $input[3]
	   $value4 = $input[4]
	   If StringCompare($value1, "Names")==0 Then
		 $start = True
		 ContinueLoop
	   EndIf
	   If $start == False Then
		  ContinueLoop
	   EndIf
	   If StringCompare($value1, '')==0 Then
		 ContinueLoop
	   EndIf
	   If StringCompare($value1, "Help/more info:")==0 Then
		 ExitLoop
	   EndIf
	   $sFormattedName = StringRegExpReplace($value1, '(E[Nn][Gg]1[6789][Cc][Ss]\d{4}\s{0,1})(-)*\s{0,1}', '')
	   ;ConsoleWrite($sFormattedName & @CRLF)
	   ; Display the array to see that it contains the ASCII values for each character in the string.
	   Local $aArray = StringToASCIIArray($value2)
	   Local $iIndex = _ArraySearch($aArray, "10004", 0, 0, 0, 0, 1, 2)
	   if $iIndex>0 Then
		 ;ConsoleWrite("P" & @CRLF)
		 $status = "P"
	   Else
		 $status = "A"
	   EndIf
	   ;_ArrayDisplay($aArray)
	   ;Local $utfStr = Execute("'" & StringRegExpReplace($value2, "(\\u([[:xdigit:]]{4}))","' & ChrW(0x$2) & '") & "'")
	   ;Local $ansiStr = _WinAPI_WideCharToMultiByte($utfStr)
	   ;MsgBox(64,"Unicode2Ansi", $utfStr & @CRLF & $ansiStr)
	   ;ConsoleWrite("$value1: " & $value1 & @CRLF)
	   ;ConsoleWrite("$value2: " & $value2 & @CRLF)
	   ;ConsoleWrite("$value3: " & $value3 & @CRLF)
	   ;ConsoleWrite("$value4: " & $value4 & @CRLF)
	   Global $maxpercent = 0
	   Global $matchname = Null
	   For $i = 0 To UBound($nameArray)-1
		 ;ConsoleWrite("S1: " & $sFormattedName & @CRLF)
		 ;ConsoleWrite("S2: " & $nameArray[$i] & @CRLF)
		 Local $s1 = $sFormattedName
		 Local $s2 = $nameArray[$i]
		 Local $aArr = _EditDistance($s1, $s2)
		 Local $percentage = 0
		 If(StringLen($s1)>StringLen($s2)) Then
			$difference = StringLen($s1) - StringLen($s2)
			;ConsoleWrite($difference & @CRLF)
			$ldist  = $aArr[StringLen($s1)][StringLen($s2)]
			;ConsoleWrite($ldist & @CRLF)
			$actdiff = $ldist - $difference
			$percentage = (StringLen($s2) - $actdiff)/StringLen($s2)*100
			;ConsoleWrite($percentage & @CRLF)
		 Else
			$difference = StringLen($s2) - StringLen($s1)
			$ldist  = $aArr[StringLen($s1)][StringLen($s2)]
			$actdiff = $ldist - $difference
			$percentage = (StringLen($s1) - $actdiff)/StringLen($s1)*100
			;ConsoleWrite($percentage & @CRLF)
		 EndIf
		 if $percentage>=$maxpercent Then
			$maxpercent=$percentage
			$matchname = $s2
		 EndIf
	  Next
	  if StringCompare($sFormattedName, "Nisha")==0 Then
		 $matchname = "NISHA V SHETTY"
	  EndIf
	  ;ConsoleWrite("$maxpercent: " & $maxpercent & @CRLF)
	  ;ConsoleWrite("$matchname: " & $matchname & @CRLF)
	  ;ConsoleWrite("$sFormattedName: " & $sFormattedName & @CRLF)
	  ConsoleWrite($sFormattedName & " == " & $matchname & @CRLF)
	  if $sFormattedName <> "" Then
		 ;ConsoleWrite($sFormattedName & @CRLF)
		 ;$nameDictionary.Add ($sFormattedName, $matchname)
		 If $statusDict.Exists($matchname) Then
			ConsoleWrite("Repeated Key: " & $matchname & @CRLF)
			ConsoleWrite("$sFormattedName: " & $sFormattedName & @CRLF)
			ConsoleWrite("$value: " & $statusDict.Item($matchname) & @CRLF)
			if StringCompare($status, "P")==0 Then
			   $statusDict.Item($matchname) = "P"
			EndIf
		 Else
			$statusDict.Add ($matchname, $status)
		 EndIf
	  EndIf

   WEnd
   Local $vKey
   For $vKey In $nameDictionary
		  ConsoleWrite($nameDictionary.Item($vKey) & @CRLF)
		  ConsoleWrite($statusDict.Item($vKey) & @CRLF)
   Next
   Local  $aRetArray
   Local $fileName = 'D:\Webapp\dayananda\BTech\Blockchain\consolidated\attendance.csv'
   _FileReadToArray($fileName, $aRetArray,0)
   For $i = 0 to UBound($aRetArray) -1
	  $input = StringSplit($aRetArray[$i], ",", 1)
	  $value1 = $input[1]
	  $value2 = $input[2]
	  $value3 = $input[3]
	  ;ConsoleWrite("$value1: " & $value1 & @CRLF)
	  ;ConsoleWrite("$value2: " & $value2 & @CRLF)
	  ;ConsoleWrite("$value3: " & $value3 & @CRLF)
	  If StringCompare($value1, "SNo")==0 Then
		 $aRetArray[$i] &= "," & $date
		 ContinueLoop
	  EndIf
	  Local $status = $statusDict.Item($value3)
	  If StringCompare($status, "")==0 Then
		 $aRetArray[$i] &= "," & "A"
	  Else
		 $aRetArray[$i] &= "," & $status
	  EndIf

	   _FileWriteFromArray($fileName, $aRetArray, Default, Default, @CRLF)
	  ;FileWriteFromArray($sFilePath, $aArray, Default, Default, ",")
	  ;ConsoleWrite($aRetArray[$i] & @CRLF)
   Next
   ;_ArrayDisplay($aRetArray, "1D display")
   FileClose($hFileIn)
   FileClose($hFileOut)
Next
Exit

Func _EditDistance($s1, $s2)
    Local $m[StringLen($s1) + 1][StringLen($s2) + 1], $i, $j
    $m[0][0] = 0;   boundary conditions
    For $j = 1 To StringLen($s2)
        $m[0][$j] = $m[0][$j - 1] + 1;   boundary conditions
    Next
    For $i = 1 To StringLen($s1)
        $m[$i][0] = $m[$i - 1][0] + 1;   boundary conditions
    Next
    For $j = 1 To StringLen($s2);                      outer loop
        For $i = 1 To StringLen($s1) ;                      inner loop
            If (StringMid($s1, $i, 1) = StringMid($s2, $j, 1)) Then
                $diag = 0;
            Else
                $diag = 1
            EndIf
            $m[$i][$j] = _Min($m[$i - 1][$j] + 1, _ ;  insertion
                    (_Min($m[$i][$j - 1] + 1, _  ;      deletion
                    $m[$i - 1][$j - 1] + $diag))) ;   substitution
        Next
    Next
    ;_TraceBack('', '', '', $m, StringLen($s1), StringLen($s2), $s1, $s2, $Dis);
    ;_ArrayDisplay($m)
    Return $m ; $m[StringLen($s1)][StringLen($s2)]
EndFunc   ;==>_EditDistance


Func _TraceBack($row1, $row2, $row3, $m, $i, $j, $s1, $s2, ByRef $sD)
    Local $diag, $diagCh
    If ($i > 0) And ($j > 0) Then
        $diag = $m[$i - 1][$j - 1]
        $diagCh = '|';
        If (StringMid($s1, $i, 1) <> StringMid($s2, $j, 1)) Then
            $diag += 1
            $diagCh = ' '; }
        EndIf
        If ($m[$i][$j] >= $diag) Then
            _TraceBack(StringMid($s1, $i, 1) & $row1, $diagCh & $row2, StringMid($s2, $j, 1) & $row3, $m, $i - 1, $j - 1, $s1, $s2, $sD);  change or match
        ElseIf $m[$i][$j] = ($m[$i - 1][$j] + 1) Then ;  delete
            _TraceBack(StringMid($s1, $i, 1) & $row1, $diagCh & $row2, '-' & $row3, $m, $i - 1, $j, $s1, $s2, $sD);
        Else
            _TraceBack("-" & $row1, $diagCh & $row2, StringMid($s2, $j, 1) & $row3, $m, $i, $j - 1, $s1, $s2, $sD);  insertion
        EndIf
    ElseIf ($i > 0) Then
        _TraceBack(StringMid($s1, $i, 1) & $row1, " " & $row2, '-' & $row3, $m, $i - 1, $j, $s1, $s2, $sD);
    ElseIf ($j > 0) Then
        _TraceBack("-" & $row1, " " & $row2, StringMid($s2, $j, 1) & $row3, $m, $i, $j - 1, $s1, $s2, $sD);
    Else ;   $i==0 and $j==0
        ;ConsoleWrite( @CRLF & $row1 & @CRLF & $row2 & @CRLF & $row3 & @CRLF)
        $sD = $row1 & @CRLF & $row2 & @CRLF & $row3 & @CRLF
    EndIf
EndFunc   ;==>_TraceBack