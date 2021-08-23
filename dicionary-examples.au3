; Author Mhz
; Forum https://www.autoitscript.com/forum/topic/182334-scripting-dictionary-modified/
Global $vKey, $sItem, $sMsg, $oDictionary

; Create dictionary object
$oDictionary = ObjCreate("Scripting.Dictionary")

If @error Then
    MsgBox(0, '', 'Error creating the dictionary object')
Else
    ; Add keys with items
    $oDictionary.Add ("One",    "Same"  )
    $oDictionary.Add ("Two",    "Car"   )
    $oDictionary.Add ("Three",  "House" )
    $oDictionary.Add ("Four",   "Boat"  )

    If $oDictionary.Exists('One') Then
        ; Display item
        MsgBox(0x0, 'Item One', $oDictionary.Item('One'), 2)
        ; Set an item
        $oDictionary.Item('One') = 'Changed'
        ; Display item
        MsgBox(0x20, 'Did Item One Change?', $oDictionary.Item('One'), 3)
        ; Remove key
        $oDictionary.Remove('One')
        ;
        $oDictionary.Key ('Two') = 'Bike'
    EndIf

    Sleep(1000)

    ; Store items into a variable
    For $vKey In $oDictionary
       $sItem &= $oDictionary.Item($vKey) & @CRLF
    Next

    ; Display items
    MsgBox(0x0, 'Items Count: ' & $oDictionary.Count, $sItem, 3)

    ; Add items into an array
    $aItems = $oDictionary.Items

    ; Display items in the array
    For $i = 0 To $oDictionary.Count -1
        MsgBox(0x0, 'Items [ ' & $i & ' ]', $aItems[$i], 2)
    Next

    Sleep(1000)

    ; Add keys into an array
    $aKeys = $oDictionary.Keys

    ; Display keys in the array
    For $i = 0 To $oDictionary.Count -1
        MsgBox(0x0, 'Keys [ ' & $i & ' ]', $aKeys[$i], 2)
    Next
EndIf