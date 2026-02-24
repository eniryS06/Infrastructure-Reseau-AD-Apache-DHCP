# Script PowerShell pour créer la structure Active Directory
# À exécuter sur le contrôleur de domaine

# Variables
$domain = "syrine.lan"
$ouPath = "OU=Utilisateurs,DC=syrine,DC=lan"

# 1. Créer l'UO Utilisateurs si elle n'existe pas
try {
    Get-ADOrganizationalUnit -Identity $ouPath
    Write-Host "L'UO Utilisateurs existe déjà." -ForegroundColor Yellow
}
catch {
    New-ADOrganizationalUnit -Name "Utilisateurs" -Path "DC=syrine,DC=lan"
    Write-Host "UO Utilisateurs créée avec succès." -ForegroundColor Green
}

# 2. Créer les groupes
$groups = @("developpeurs", "webmasters", "designers")
foreach ($group in $groups) {
    try {
        Get-ADGroup -Identity $group
        Write-Host "Le groupe $group existe déjà." -ForegroundColor Yellow
    }
    catch {
        New-ADGroup -Name $group -GroupScope Global -GroupCategory Security -Path $ouPath
        Write-Host "Groupe $group créé avec succès." -ForegroundColor Green
    }
}

# 3. Fonction pour créer un utilisateur
function Create-ADUser {
    param($username, $group)
    
    $userPath = "CN=$username,$ouPath"
    
    try {
        Get-ADUser -Identity $username
        Write-Host "L'utilisateur $username existe déjà." -ForegroundColor Yellow
    }
    catch {
        # Créer l'utilisateur
        New-ADUser -Name $username `
                   -SamAccountName $username `
                   -UserPrincipalName "$username@$domain" `
                   -GivenName $username `
                   -Surname $username `
                   -Path $ouPath `
                   -AccountPassword (ConvertTo-SecureString "Azerty123!" -AsPlainText -Force) `
                   -Enabled $true `
                   -PassThru
        
        # Ajouter au groupe
        Add-ADGroupMember -Identity $group -Members $username
        
        Write-Host "Utilisateur $username créé et ajouté au groupe $group." -ForegroundColor Green
    }
}

# 4. Créer les utilisateurs
Create-ADUser -username "dev1" -group "developpeurs"
Create-ADUser -username "dev2" -group "developpeurs"
Create-ADUser -username "web1" -group "webmasters"
Create-ADUser -username "web2" -group "webmasters"
Create-ADUser -username "des1" -group "designers"
Create-ADUser -username "des2" -group "designers"

Write-Host "`nCréation des utilisateurs terminée !" -ForegroundColor Cyan