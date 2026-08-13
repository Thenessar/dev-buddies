# init.ps1 - Inicjalizuje i aktualizuje pakiet Dev Buddies w dowolnym repozytorium (PowerShell / Windows)
param (
    [switch]$Copilot,
    [switch]$Update
)

$RepoUrl = "https://github.com/thenessar/dev-buddies.git"
$TargetDir = ".agents"

Write-Host "`n[INFO] Inicjalizacja pakietu Dev Buddies..." -ForegroundColor Cyan

# 1. Pobieranie / Aktualizacja pakietu agentów
if (Test-Path -Path "$TargetDir\.git") {
    Write-Host "[INFO] Aktualizacja Dev Buddies z repozytorium..." -ForegroundColor Yellow
    Push-Location $TargetDir
    try {
        git pull --quiet
        Write-Host "[OK] Pomyślnie zaktualizowano Dev Buddies." -ForegroundColor Green
    } catch {
        Write-Warning "Nie udało się zaktualizować repozytorium. Sprawdź połączenie z siecią."
    }
    Pop-Location
} elseif (Test-Path -Path $TargetDir) {
    Write-Host "[INFO] Katalog $TargetDir już istnieje. Odświeżanie plików źródłowych..." -ForegroundColor Yellow
    $TempDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName())
    git clone --depth 1 --quiet $RepoUrl $TempDir
    if (Test-Path -Path $TempDir) {
        Copy-Item -Path "$TempDir\agents\*" -Destination "$TargetDir\agents" -Recurse -Force
        Copy-Item -Path "$TempDir\rules\*" -Destination "$TargetDir\rules" -Recurse -Force
        Copy-Item -Path "$TempDir\templates\*" -Destination "$TargetDir\templates" -Recurse -Force -ErrorAction SilentlyContinue
        Copy-Item -Path "$TempDir\.github\*" -Destination "$TargetDir\.github" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "[OK] Pomyślnie odświeżono definicje agentów i reguł." -ForegroundColor Green
    }
} else {
    Write-Host "[INFO] Klonowanie najnowszej wersji Dev Buddies do $TargetDir..." -ForegroundColor Green
    git clone --depth 1 --quiet $RepoUrl $TargetDir
    Write-Host "[OK] Pomyślnie zainstalowano Dev Buddies." -ForegroundColor Green
}

# 2. Tworzenie katalogu na dokumentację
if (-not (Test-Path -Path "$TargetDir\docs")) {
    New-Item -ItemType Directory -Path "$TargetDir\docs" -Force | Out-Null
}

# 3. Zabezpieczenie .gitignore w projekcie docelowym
if (Test-Path -Path ".gitignore") {
    $GitIgnoreContent = Get-Content ".gitignore" -Raw
    if ($GitIgnoreContent -notmatch "\.agents/docs") {
        Add-Content -Path ".gitignore" -Value "`n# Dev Buddies Generated Knowledge Base`n.agents/docs/"
        Write-Host "[CONFIG] Dodano .agents/docs/ do pliku .gitignore" -ForegroundColor DarkGray
    }
} else {
    Set-Content -Path ".gitignore" -Value "# Dev Buddies Generated Knowledge Base`n.agents/docs/"
    Write-Host "[CONFIG] Utworzono plik .gitignore z regułą .agents/docs/" -ForegroundColor DarkGray
}

# 4. Integracja z GitHub Copilot (VS Code Agent Mode)
if ($Copilot -or (Test-Path -Path ".github")) {
    if (-not (Test-Path -Path ".github\agents")) {
        New-Item -ItemType Directory -Path ".github\agents" -Force | Out-Null
    }
    $CopilotSrc = "$TargetDir\.github\copilot-instructions.md"
    $CopilotDst = ".github\copilot-instructions.md"
    if (Test-Path -Path $CopilotSrc) {
        Copy-Item -Path $CopilotSrc -Destination $CopilotDst -Force
    }
    $AgentsSrcDir = "$TargetDir\.github\agents"
    if (Test-Path -Path $AgentsSrcDir) {
        Copy-Item -Path "$AgentsSrcDir\*.agent.md" -Destination ".github\agents\" -Force
    }
    Write-Host "[CONFIG] Zainstalowano agentów GitHub Copilot w .github/agents/*.agent.md" -ForegroundColor Magenta
}

Write-Host @"

[READY] Dev Buddies są gotowi do pracy w Twoim edytorze!

Możesz teraz w oknie czatu AI (Google Antigravity lub GitHub Copilot):

1. Wygenerować pełną bazę wiedzy o projekcie (Onboarding):
   "@lead-orchestrator Zbuduj dla mnie pełny portal onboardingowy dla tego repozytorium."

2. Otrzymać plan i listę plików do modyfikacji dla nowego zadania:
   "@task-navigator Przeanalizuj poniższe zadanie i przygotuj dla mnie plan zmian: [treść zadania]"

3. Sprawdzić jakość kodu przed oddaniem do review zespołowi:
   "@pre-pr-reviewer Sprawdź moje lokalne zmiany przed wystawieniem PR."

Katalog wynikowy dokumentacji: .agents/docs/
"@ -ForegroundColor Cyan
