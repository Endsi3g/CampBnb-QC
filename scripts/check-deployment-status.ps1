# Script pour vérifier le statut du déploiement
param(
    [string]$WorkflowName = "deploy-testing.yml"
)

$REPO_OWNER = "Endsi3g"
$REPO_NAME = "CampBnb-QC"

Write-Host "🔍 Vérification du statut du déploiement..." -ForegroundColor Cyan
Write-Host ""

# URL de l'API GitHub
$apiUrl = "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/workflows/$WorkflowName/runs?per_page=1"

try {
    $headers = @{
        "Accept" = "application/vnd.github.v3+json"
        "User-Agent" = "Campbnb-Status-Check"
    }
    
    # Si un token est disponible, l'utiliser
    if ($env:GITHUB_TOKEN) {
        $headers["Authorization"] = "token $env:GITHUB_TOKEN"
    }
    
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers
    
    if ($response.workflow_runs.Count -gt 0) {
        $run = $response.workflow_runs[0]
        
        $status = $run.status
        $conclusion = $run.conclusion
        $runNumber = $run.run_number
        $createdAt = $run.created_at
        $htmlUrl = $run.html_url
        
        Write-Host "📊 Dernier déploiement:" -ForegroundColor Cyan
        Write-Host "   Numéro: #$runNumber" -ForegroundColor Gray
        Write-Host "   Statut: $status" -ForegroundColor $(if ($status -eq "completed") { "Green" } else { "Yellow" })
        
        if ($conclusion) {
            $color = switch ($conclusion) {
                "success" { "Green" }
                "failure" { "Red" }
                "cancelled" { "Yellow" }
                default { "Gray" }
            }
            $emoji = switch ($conclusion) {
                "success" { "✅" }
                "failure" { "❌" }
                "cancelled" { "⚠️" }
                default { "⏳" }
            }
            Write-Host "   Conclusion: $emoji $conclusion" -ForegroundColor $color
        } else {
            Write-Host "   Conclusion: ⏳ En cours..." -ForegroundColor Yellow
        }
        
        Write-Host "   Créé: $createdAt" -ForegroundColor Gray
        Write-Host ""
        Write-Host "🔗 Lien: $htmlUrl" -ForegroundColor Blue
        Write-Host ""
        
        # Ouvrir dans le navigateur
        Start-Process $htmlUrl
        
        # Afficher les jobs
        if ($run.jobs_url) {
            Write-Host "📋 Jobs du workflow:" -ForegroundColor Cyan
            try {
                $jobsResponse = Invoke-RestMethod -Uri $run.jobs_url -Method Get -Headers $headers
                foreach ($job in $jobsResponse.jobs) {
                    $jobStatus = $job.status
                    $jobConclusion = $job.conclusion
                    $jobName = $job.name
                    
                    $jobColor = if ($jobStatus -eq "completed") {
                        if ($jobConclusion -eq "success") { "Green" } else { "Red" }
                    } else { "Yellow" }
                    
                    $jobEmoji = if ($jobStatus -eq "completed") {
                        if ($jobConclusion -eq "success") { "✅" } else { "❌" }
                    } else { "⏳" }
                    
                    Write-Host "   $jobEmoji $jobName - $jobStatus" -ForegroundColor $jobColor
                }
            } catch {
                Write-Host "   ⚠️ Impossible de récupérer les détails des jobs" -ForegroundColor Yellow
            }
        }
        
    } else {
        Write-Host "⚠️ Aucun déploiement trouvé" -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "❌ Erreur lors de la vérification:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Ouvrez manuellement:" -ForegroundColor Cyan
    Write-Host "   https://github.com/$REPO_OWNER/$REPO_NAME/actions" -ForegroundColor Blue
    Start-Process "https://github.com/$REPO_OWNER/$REPO_NAME/actions"
}

