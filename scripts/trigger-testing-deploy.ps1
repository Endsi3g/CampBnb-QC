# Script pour déclencher le déploiement testing
# Utilise l'API GitHub pour déclencher le workflow

param(
    [string]$Branch = "main",
    [string]$Environment = "testing"
)

# Configuration
$REPO_OWNER = "YOUR_USERNAME"  # À remplacer par votre username GitHub
$REPO_NAME = "CampBnb-QC"      # Nom du repository
$WORKFLOW_FILE = "deploy-testing.yml"

# Vérifier si le token GitHub est disponible
$token = $env:GITHUB_TOKEN
if (-not $token) {
    Write-Host "⚠️  GITHUB_TOKEN non trouvé dans les variables d'environnement" -ForegroundColor Yellow
    Write-Host "💡 Vous pouvez:" -ForegroundColor Cyan
    Write-Host "   1. Créer un Personal Access Token sur: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host "   2. L'ajouter avec: `$env:GITHUB_TOKEN = 'votre-token'" -ForegroundColor Cyan
    Write-Host ""
    $token = Read-Host "Entrez votre GitHub Personal Access Token (ou appuyez sur Entrée pour utiliser l'interface web)"
    
    if (-not $token) {
        Write-Host ""
        Write-Host "🌐 Ouverture de l'interface GitHub Actions..." -ForegroundColor Cyan
        $url = "https://github.com/$REPO_OWNER/$REPO_NAME/actions/workflows/$WORKFLOW_FILE"
        Start-Process $url
        Write-Host "✅ Ouvrez le lien ci-dessus et cliquez sur 'Run workflow' manuellement" -ForegroundColor Green
        exit 0
    }
}

# Obtenir le nom du repository depuis le remote Git
try {
    $remoteUrl = git remote get-url origin 2>$null
    if ($remoteUrl) {
        if ($remoteUrl -match "github\.com[:/]([^/]+)/([^/]+?)(?:\.git)?$") {
            $REPO_OWNER = $matches[1]
            $REPO_NAME = $matches[2] -replace '\.git$', ''
            Write-Host "📦 Repository détecté: $REPO_OWNER/$REPO_NAME" -ForegroundColor Green
        }
    }
} catch {
    Write-Host "⚠️  Impossible de détecter le repository depuis Git" -ForegroundColor Yellow
}

# Obtenir la branche actuelle
try {
    $currentBranch = git rev-parse --abbrev-ref HEAD 2>$null
    if ($currentBranch) {
        $Branch = $currentBranch
        Write-Host "🌿 Branche détectée: $Branch" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️  Utilisation de la branche par défaut: $Branch" -ForegroundColor Yellow
}

# URL de l'API GitHub
$apiUrl = "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/workflows/$WORKFLOW_FILE/dispatches"

# Headers
$headers = @{
    "Accept" = "application/vnd.github.v3+json"
    "Authorization" = "token $token"
    "User-Agent" = "Campbnb-Deploy-Script"
}

# Body
$body = @{
    ref = $Branch
    inputs = @{
        environment = $Environment
    }
} | ConvertTo-Json

Write-Host ""
Write-Host "🚀 Déclenchement du déploiement testing..." -ForegroundColor Cyan
Write-Host "   Repository: $REPO_OWNER/$REPO_NAME" -ForegroundColor Gray
Write-Host "   Branche: $Branch" -ForegroundColor Gray
Write-Host "   Environnement: $Environment" -ForegroundColor Gray
Write-Host ""

try {
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $body -ContentType "application/json"
    
    Write-Host "✅ Déploiement déclenché avec succès!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 Suivez le déploiement sur:" -ForegroundColor Cyan
    Write-Host "   https://github.com/$REPO_OWNER/$REPO_NAME/actions" -ForegroundColor Blue
    Write-Host ""
    
    # Ouvrir le navigateur
    Start-Sleep -Seconds 2
    Start-Process "https://github.com/$REPO_OWNER/$REPO_NAME/actions"
    
} catch {
    Write-Host "❌ Erreur lors du déclenchement:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    
    if ($_.Exception.Response.StatusCode -eq 404) {
        Write-Host ""
        Write-Host "💡 Le workflow n'existe peut-être pas encore. Vérifiez:" -ForegroundColor Yellow
        Write-Host "   1. Le fichier .github/workflows/deploy-testing.yml existe" -ForegroundColor Yellow
        Write-Host "   2. Le repository et la branche sont corrects" -ForegroundColor Yellow
    } elseif ($_.Exception.Response.StatusCode -eq 401) {
        Write-Host ""
        Write-Host "💡 Token invalide. Vérifiez votre Personal Access Token:" -ForegroundColor Yellow
        Write-Host "   https://github.com/settings/tokens" -ForegroundColor Yellow
    }
    
    exit 1
}

