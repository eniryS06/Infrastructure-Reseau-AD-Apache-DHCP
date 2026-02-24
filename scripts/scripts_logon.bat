@echo off
REM Script de connexion utilisateur
REM Mappage des lecteurs réseau

REM Lecteur X: pour les webmasters (si membre du groupe)
net use X: \\SYRINEAD\partage-web /persistent:yes

REM Lecteur W: pour tous les utilisateurs
net use W: \\SYRINEAD\commun /persistent:yes

REM Afficher un message
echo Lecteurs réseau configurés avec succès !