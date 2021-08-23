While 1
   Global $updateLine = FileReadLine($hFileOut)
   If @error = -1 Then ExitLoop
   $input = StringSplit($updateLine, ",", 1)
   $value1 = $input[1]
   $value2 = $input[2]
   $value3 = $input[3]
   ;$value4 = $input[4]
   Global $index = 4
   If StringCompare($value1, "SNo")==0 Then
	  ContinueLoop
   EndIf
   $status = $statusDict.Item($value3)
WEnd

Local  $aRetArray
$aRetArray = FileReadToArray('D:\Webapp\dayananda\BTech\Blockchain\consolidated\attendance.csv')
ConsoleWrite($aRetArray[0] & @CRLF)
;_ArrayDisplay($aRetArray, "1D display")


	  ElseIf StringCompare($sFormattedName, "PRINCE")==0 Then
		 $matchname = "PRINCE PRASHANT"
	  ElseIf StringCompare($sFormattedName, "CREFLO")==0 Then
		 $matchname = "I CREFLO ASIR JOEL"
	  ElseIf StringCompare($sFormattedName, "Satish MH")==0 Then
		 $matchname = "SATISH HERAKAL"
	  ElseIf StringCompare($sFormattedName, "Subhramanya NS")==0 Then
		 $matchname = "SUBHRAMANYA N SADHWANI"
	  ElseIf StringCompare($sFormattedName, "VARUN")==0 Then
		 $matchname = "VARUN V RAO"
	  ElseIf StringCompare($sFormattedName, "HAASINI.T.S")==0 Then
		 $matchname = "HAASINI THUMBAVANAM SRIDHARAN"