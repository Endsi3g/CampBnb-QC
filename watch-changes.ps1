# Script PowerShell pour surveiller et pousser automatiquement les changements
# Ce script surveille le dossier et pousse automatiquement les changements toutes les X minutes

param(
    [int]$IntervalMinutes = 5,
    [string]$CommitMessage = "Mise à jour automatique"
)

Write-Host "👀 Surveillance des changements activée..." -ForegroundColor Cyan
Write-Host "⏱️  Intervalle: $IntervalMinutes minutes" -ForegroundColor Cyan
Write-Host "🛑 Appuyez sur Ctrl+C pour arrêter" -ForegroundColor Yellow
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$autoPushScript = Join-Path $scriptPath "auto-push.ps1"

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] Vérification des changements..." -ForegroundColor Gray
    
    # Vérifier s'il y a des changements
    $status = git status --porcelain
    
    if (-not [string]::IsNullOrWhiteSpace($status)) {
        Write-Host "📝 Changements détectés! Poussage automatique..." -ForegroundColor Yellow
        
        # Exécuter le script auto-push
        & $autoPushScript -CommitMessage "$CommitMessage - $timestamp"
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Mise à jour réussie!" -ForegroundColor Green
        }
    } else {
        Write-Host "✅ Aucun changement" -ForegroundColor DarkGray
    }
    
    Write-Host ""
    Start-Sleep -Seconds ($IntervalMinutes * 60)
}

