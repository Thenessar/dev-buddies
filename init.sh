#!/usr/bin/env bash
# init.sh - Dociąga paczkę dev-buddies do dowolnego projektu

REPO_URL="https://github.com/TWOJ_GITHUB/dev-buddies.git"
TARGET_DIR=".agents"

echo "🤖 Inicjalizacja zespołu Dev Buddies..."

if [ -d "$TARGET_DIR" ]; then
    echo "🔄 Aktualizacja Dev Buddies w obecnym projekcie..."
    cd "$TARGET_DIR" && git pull && cd ..
else
    echo "📦 Pobieranie najnowszej wersji Dev Buddies..."
    git clone --depth 1 "$REPO_URL" "$TARGET_DIR"
    rm -rf "$TARGET_DIR/.git"
fi

# Zabezpieczenie przed przypadkowym skomitowaniem docs/ w obcym repo (opcjonalnie)
if [ -f ".gitignore" ]; then
    if ! grep -q ".agents/docs" .gitignore; then
        echo -e "\n# Dev Buddies Output Docs\n.agents/docs/" >> .gitignore
    fi
fi

echo "✅ Dev Buddies są gotowi do pracy w \`.agents/agents/\`!"
