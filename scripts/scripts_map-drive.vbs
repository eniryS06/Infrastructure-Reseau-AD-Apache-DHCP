' Script de mappage automatique du lecteur X: pour les webmasters
' À placer dans le partage SYSVOL

On Error Resume Next

' Définir la lettre de lecteur et le chemin
strDriveLetter = "X:"
strNetworkPath = "\\SYRINEAD\partage-web"

' Vérifier si le lecteur est déjà mappé
Set objNetwork = CreateObject("WScript.Network")
Set colDrives = objNetwork.EnumNetworkDrives

bDriveExists = False
For i = 0 to colDrives.Count - 1 Step 2
    If colDrives.Item(i) = strDriveLetter Then
        bDriveExists = True
        Exit For
    End If
Next

' Si le lecteur n'existe pas, le mapper
If Not bDriveExists Then
    objNetwork.MapNetworkDrive strDriveLetter, strNetworkPath, True
End If

' Afficher un message de confirmation (optionnel)
' MsgBox "Lecteur " & strDriveLetter & " mappé avec succès vers " & strNetworkPath, vbInformation, "Mappage automatique"