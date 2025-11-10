# Script de démarrage du backend API pour Windows
# Usage: .\start.ps1

Write-Host "🚀 Démarrage du backend API Campbnb" -ForegroundColor Cyan

# Vérifier si l'environnement virtuel existe
if (-not (Test-Path "venv")) {
    Write-Host "❌ L'environnement virtuel n'existe pas!" -ForegroundColor Red
    Write-Host "   Exécutez d'abord .\setup.ps1" -ForegroundColor Yellow
    exit 1
}

# Activer l'environnement virtuel
Write-Host "`n📦 Activation de l'environnement virtuel..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1

# Vérifier les dépendances
Write-Host "📦 Vérification des dépendances..." -ForegroundColor Yellow
$flaskInstalled = pip show flask 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Flask n'est pas installé!" -ForegroundColor Red
    Write-Host "   Installation des dépendances..." -ForegroundColor Yellow
    pip install -r requirements.txt
}

# Démarrer le serveur
Write-Host "`n🚀 Démarrage du serveur sur http://localhost:5000" -ForegroundColor Green
Write-Host "   Appuyez sur Ctrl+C pour arrêter" -ForegroundColor Yellow
Write-Host ""

python api_server.py

