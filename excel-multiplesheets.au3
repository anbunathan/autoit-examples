#include <Excel.au3>
#include <Date.au3>
Local $joiningdate = "5-10-2021"
$oExcel = _Excel_Open(False)
$oWorkbook = _Excel_BookOpen($oExcel, "D:\Webapp\RPA-Examples\ML INTERNS dipanjan.xlsx")
$oWorkbook1 = _Excel_BookOpen($oExcel, "D:\Webapp\RPA-Examples\target.xlsx")
$aList = _Excel_SheetList($oWorkbook)
Local Const $xlUp = -4162
Local $rowcount = 2
Local $lastcount = $rowcount
Local $currentsheetname = "Sheet1"

For $a = 0 To UBound($aList) - 1
   ConsoleWrite($aList[$a][0] & @CRLF)
   $oWorkbook.Sheets($aList[$a][0]).Activate
   Local $iRows = $oExcel.ActiveSheet.UsedRange.Rows.Count
   Local $iColumns = $oExcel.ActiveSheet.UsedRange.Columns.Count
   ConsoleWrite($iRows & @CRLF)
   ConsoleWrite($iColumns & @CRLF)
   $currentsheetname = $aList[$a][0]
   Local $Result= _Excel_RangeRead($oWorkbook, $aList[$a][0], "A2:B"&$iRows)
   $rowcount = $rowcount+$iRows-1
    _Excel_RangeWrite($oWorkbook1, "Sheet1", $Result, "A" & $lastcount & ":B"&$rowcount)
	$lastcount = $rowcount
;~    For $i = 0 To $iRows-2
;~ 	  ConsoleWrite($Result[$i] & @CRLF)
;~    Next

Next
$oWorkbook1.ActiveSheet.Columns("A:A").SpecialCells($xlCellTypeBlanks).EntireRow.Delete
Local $iRowsNew = $oWorkbook1.ActiveSheet.UsedRange.Rows.Count
Local $aColumns[] = [1, 2]                              ;$aColumns = # of columns used in sheet - Dosent Vary
$oWorkbook1.ActiveSheet.Range("A2:B" & $iRowsNew).RemoveDuplicates($aColumns) ;Removes Duplicates
$iRowsNew = $oWorkbook1.ActiveSheet.UsedRange.Rows.Count
_Excel_RangeWrite($oWorkbook1, "Sheet1", "=RANDBETWEEN(10000000,99999999)", "XX2" & ":XX"&$iRowsNew)
Local $ResultRandom= _Excel_RangeRead($oWorkbook1, "Sheet1", "XX2" & ":XX"&$iRowsNew)
_Excel_RangeWrite($oWorkbook1, "Sheet1", $ResultRandom,  "C2" & ":C"&$iRowsNew)
_Excel_RangeDelete($oWorkbook1.ActiveSheet, "XX:XX", $xlShiftToLeft)
_Excel_RangeWrite($oWorkbook1, "Sheet1", "Software Engineer",  "D2" & ":D"&$iRowsNew)
_Excel_RangeWrite($oWorkbook1, "Sheet1", _NowDate(),  "E2" & ":E"&$iRowsNew)
_Excel_RangeWrite($oWorkbook1, "Sheet1", $joiningdate,  "F2" & ":F"&$iRowsNew)
$oWorkbook1.Activesheet.range("F2" & ":F"&$iRowsNew).NumberFormat = "dd-mm-yyyy"
_Excel_BookClose($oWorkbook)
_Excel_BookClose($oWorkbook1)
_Excel_Close($oExcel)