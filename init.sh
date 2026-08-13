#!/usr/bin/env bash
# init.sh - Inicjalizuje i aktualizuje pakiet Dev Buddies w dowolnym repozytorium (Linux / macOS)

REPO_URL="https://github.com/thenessar/dev-buddies.git"
TARGET_DIR=".agents"
ENABLE_COPILOT=false

for arg in "$@"; do
    case $arg in
        --copilot)
        ENABLE_COPILOT=true
        shift
        ;;
    esac
done

echo -e "\n\033[1;36m[INFO] Inicjalizacja pakietu Dev Buddies...\033[0m"

# 1. Pobieranie / Aktualizacja pakietu agentów
if [ -d "$TARGET_DIR/.git" ]; then
    echo -e "\033[1;33m[INFO] Aktualizacja Dev Buddies z repozytorium...\033[0m"
    (cd "$TARGET_DIR" && git pull --quiet)
    echo -e "\033[1;32m[OK] Pomyślnie zaktualizowano Dev Buddies.\033[0m"
elif [ -d "$TARGET_DIR" ]; then
    echo -e "\033[1;33m[INFO] Katalog $TARGET_DIR już istnieje. Odświeżanie plików źródłowych...\033[0m"
    TEMP_DIR=$(mktemp -d)
    git clone --depth 1 --quiet "$REPO_URL" "$TEMP_DIR"
    cp -r "$TEMP_DIR/agents" "$TARGET_DIR/"
    cp -r "$TEMP_DIR/rules" "$TARGET_DIR/"
    [ -d "$TEMP_DIR/templates" ] && cp -r "$TEMP_DIR/templates" "$TARGET_DIR/"
    [ -d "$TEMP_DIR/.github" ] && cp -r "$TEMP_DIR/.github" "$TARGET_DIR/"
    rm -rf "$TEMP_DIR"
    echo -e "\033[1;32m[OK] Pomyślnie odświeżono definicje agentów i reguł.\033[0m"
else
    echo -e "\033[1;32m[INFO] Klonowanie najnowszej wersji Dev Buddies do $TARGET_DIR...\033[0m"
    git clone --depth 1 --quiet "$REPO_URL" "$TARGET_DIR"
    echo -e "\033[1;32m[OK] Pomyślnie zainstalowano Dev Buddies.\033[0m"
fi

# 2. Tworzenie katalogu na dokumentację
mkdir -p "$TARGET_DIR/docs"

# 3. Zabezpieczenie .gitignore
if [ -f ".gitignore" ]; then
    if ! grep -q "\.agents/docs" .gitignore; then
        echo -e "\n# Dev Buddies Generated Knowledge Base\n.agents/docs/" >> .gitignore
        echo -e "\033[0;90m[CONFIG] Dodano .agents/docs/ do pliku .gitignore\033[0m"
    fi
else
    echo -e "# Dev Buddies Generated Knowledge Base\n.agents/docs/" > .gitignore
    echo -e "\033[0;90m[CONFIG] Utworzono plik .gitignore z regułą .agents/docs/\033[0m"
fi

# 4. Integracja z GitHub Copilot (VS Code Agent Mode)
if [ "$ENABLE_COPILOT" = true ] || [ -d ".github" ]; then
    mkdir -p ".github/agents"
    COPILOT_SRC="$TARGET_DIR/.github/copilot-instructions.md"
    if [ -f "$COPILOT_SRC" ]; then
        cp "$COPILOT_SRC" ".github/copilot-instructions.md"
    fi
    AGENTS_SRC_DIR="$TARGET_DIR/.github/agents"
    if [ -d "$AGENTS_SRC_DIR" ]; then
        cp "$AGENTS_SRC_DIR"/*.agent.md ".github/agents/"
    fi
    echo -e "\033[1;35m[CONFIG] Zainstalowano agentów GitHub Copilot w .github/agents/*.agent.md\033[0m"
fi

cat << "EOF"

[READY] Dev Buddies są gotowi do pracy.

Szybki Start:
  1. Google Antigravity: Uruchom agenta @lead-orchestrator
  2. GitHub Copilot:     Uruchom agenta @lead-orchestrator w Copilot Agent Mode (lub użyj promptów z .github/prompt-templates.md)
  3. Pierwszy Task:      Uruchom agenta @task-navigator z opisem zadania
  4. Pre-PR Review:      Uruchom agenta @pre-pr-reviewer przed wystawieniem PR

Katalog wyjściowy dokumentacji: .agents/docs/
EOF
