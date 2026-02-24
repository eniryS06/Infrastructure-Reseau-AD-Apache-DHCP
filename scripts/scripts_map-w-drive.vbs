' Script de mappage automatique du lecteur W: pour tous les utilisateurs
' À placer dans le partage SYSVOL et appliqué via GPO

On Error Resume Next

' Définir la lettre de lecteur et le chemin
strDriveLetter = "W:"
strNetworkPath = "\\SYRINEAD\commun"

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