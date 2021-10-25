#include <Array.au3>
#include <Excel.au3>

; Create application object
Local $oExcel = _Excel_Open()
Local $bReadOnly = False
Local $bVisible = True
Local $var = 1
Local $R = "D" & $var & ":" & "E" & $var
; ****************************************************************************
; Open an existing workbook and return its object identifier.
; *****************************************************************************
Local $sWorkbook = "C:\temp\test.xlsx"
Local $oWorkbook = _Excel_BookOpen($oExcel, $sWorkbook, $bReadOnly, $bVisible)
Local $aResult = _Excel_RangeRead($oWorkbook, Default, $oWorkbook.ActiveSheet.Usedrange.Columns("D"), 1)
_ArrayDisplay($aResult)
For $i = 1 To UBound($aResult) - 1
    ConsoleWrite($aResult[$i] & @CRLF)
Next