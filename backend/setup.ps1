# Script d'installation du backend API pour Windows
# Usage: .\setup.ps1

Write-Host "🚀 Installation du backend API Campbnb" -ForegroundColor Cyan

# Vérifier si Python est installé
Write-Host "`n📦 Vérification de Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✅ Python trouvé: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Python n'est pas installé!" -ForegroundColor Red
    Write-Host "   Installez Python depuis https://www.python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

# Créer l'environnement virtuel
Write-Host "`n📦 Création de l'environnement virtuel..." -ForegroundColor Yellow
if (Test-Path "venv") {
    Write-Host "⚠️  L'environnement virtuel existe déjà" -ForegroundColor Yellow
    $response = Read-Host "Voulez-vous le recréer? (o/N)"
    if ($response -eq "o" -or $response -eq "O") {
        Remove-Item -Recurse -Force venv
        python -m venv venv
        Write-Host "✅ Environnement virtuel créé" -ForegroundColor Green
    }
} else {
    python -m venv venv
    Write-Host "✅ Environnement virtuel créé" -ForegroundColor Green
}

# Activer l'environnement virtuel et installer les dépendances
Write-Host "`n📦 Installation des dépendances..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r requirements.txt

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Dépendances installées avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de l'installation des dépendances" -ForegroundColor Red
    exit 1
}

Write-Host "`n✅ Installation terminée!" -ForegroundColor Green
Write-Host "`nPour démarrer le serveur:" -ForegroundColor Cyan
Write-Host "  .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "  python api_server.py" -ForegroundColor White

