# Script PowerShell pour configurer les GPO

# 1. GPO pour restreindre l'accès au CMD pour les designers
$gpoName = "Restriction CMD - Designers"
$gpo = New-GPO -Name $gpoName -Comment "Bloque l'accès à l'invite de commandes pour les designers"

# Configurer la GPO pour désactiver CMD
Set-GPRegistryValue -Name $gpoName -Key "HKCU\Software\Policies\Microsoft\Windows\System" -ValueName "DisableCMD" -Type DWord -Value 1

# Lier la GPO à l'UO
$ouPath = "OU=Utilisateurs,DC=syrine,DC=lan"
New-GPLink -Name $gpoName -Target $ouPath

# Filtrer par groupe Designers
Set-GPPermission -Name $gpoName -TargetName "designers" -TargetType Group -PermissionLevel GpoApply

Write-Host "GPO '$gpoName' configurée." -ForegroundColor Green

# 2. GPO pour restrictions horaires pour des1
# À faire manuellement dans l'interface

# 3. GPO pour mappage du lecteur W:
$gpoDriveName = "Mappage Lecteur W: Commun"
$gpoDrive = New-GPO -Name $gpoDriveName -Comment "Mappe le lecteur W: pour tous les utilisateurs"

# Configuration du mappage de lecteur
$drivePath = "\\SYRINEAD\commun"
$driveLetter = "W:"

# Commande pour créer le dossier partagé
New-Item -Path "C:\Commun" -ItemType Directory -Force
New-SmbShare -Name "commun" -Path "C:\Commun" -FullAccess "Everyone"

Write-Host "Partage 'commun' créé." -ForegroundColor Green