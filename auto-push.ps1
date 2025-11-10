# Script PowerShell pour pousser automatiquement les changements vers GitHub
# Usage: .\auto-push.ps1 [message de commit]

param(
    [string]$CommitMessage = "Mise à jour automatique - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
)

Write-Host "🔄 Vérification des changements..." -ForegroundColor Cyan

# Vérifier s'il y a des changements
$status = git status --porcelain

if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "✅ Aucun changement à commiter" -ForegroundColor Green
    exit 0
}

Write-Host "📦 Ajout des fichiers modifiés..." -ForegroundColor Cyan
git add .

Write-Host "💾 Création du commit..." -ForegroundColor Cyan
git commit -m $CommitMessage

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erreur lors du commit" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Poussage vers GitHub..." -ForegroundColor Cyan
git pull origin main --rebase

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Conflit détecté. Résolution manuelle nécessaire." -ForegroundColor Yellow
    exit 1
}

git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Changements poussés avec succès vers GitHub!" -ForegroundColor Green
    Write-Host "📍 Dépôt: https://github.com/Endsi3g/CampBnb-QC" -ForegroundColor Cyan
} else {
    Write-Host "❌ Erreur lors du push vers GitHub" -ForegroundColor Red
    exit 1
}

