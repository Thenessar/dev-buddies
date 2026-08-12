# init.ps1 - Dociąga paczkę dev-buddies do dowolnego projektu w środowisku Windows (PowerShell)

$RepoUrl = "https://github.com/TWOJ_GITHUB/dev-buddies.git"
$TargetDir = ".agents"

Write-Host "🤖 Inicjalizacja zespołu Dev Buddies..." -ForegroundColor Cyan

if (Test-Path -Path $TargetDir) {
    Write-Host "🔄 Aktualizacja Dev Buddies w obecnym projekcie..." -ForegroundColor Yellow
    Push-Location $TargetDir
    git pull
    Pop-Location
} else {
    Write-Host "📦 Pobieranie najnowszej wersji Dev Buddies..." -ForegroundColor Green
    git clone --depth 1 $RepoUrl $TargetDir
    Remove-Item -Path "$TargetDir\.git" -Recurse -Force -ErrorAction SilentlyContinue
}

if (Test-Path -Path ".gitignore") {
    $GitIgnoreContent = Get-Content ".gitignore" -Raw
    if ($GitIgnoreContent -notmatch "\.agents/docs") {
        Add-Content -Path ".gitignore" -Value "`n# Dev Buddies Output Docs`n.agents/docs/"
    }
}

Write-Host "✅ Dev Buddies są gotowi do pracy w `.agents/agents/`!" -ForegroundColor Green
