# Instrukcja Uruchomienia Lokalnego (Developer Runbook)

## 1. Wymagania Wstępne (Prerequisites)
- **Python**: `>= 3.11` (zalecany menedżer środowisk `uv` lub `venv`)
- **Databricks CLI**: Wersja `0.220.0+` (Databricks CLI v2 ze wsparciem dla DABs)
- **Azure CLI**: `az login` (do autoryzacji z subskrypcją Azure)
- **Terraform**: Wersja `>= 1.8.x` (dla zmian w infrastrukturze)
- **Docker**: Opcjonalnie (do uruchamiania kontenerów testowych i lokalnego lintera)

---

## 2. Krok po Kroku: Konfiguracja Środowiska Deweloperskiego

```bash
# Krok 1: Klonowanie repozytorium i instalacja zależności Pythona
python -m venv .venv
source .venv/bin/activate  # lub .venv\Scripts\Activate.ps1 na Windows
pip install -r requirements-dev.txt

# Krok 2: Logowanie do Azure i Databricks CLI
az login
databricks auth login --host https://adb-1234567890.azuredatabricks.net

# Krok 3: Walidacja konfiguracji Databricks Asset Bundle (DABs)
databricks bundle validate --target dev

# Krok 4: Wdrożenie osobistego środowiska deweloperskiego (Sandbox)
databricks bundle deploy --target dev

# Krok 5: Uruchomienie pojedynczego zadania testowego w chmurze
databricks bundle run gold_aggregation_job --target dev
```

---

## 3. Zmienne Środowiskowe & Konfiguracja (`databricks.yml`)

| Zmienna / Klucz | Typ | Domyślna Wartość (Dev) | Opis / Zastosowanie |
|---|---|---|---|
| `DATABRICKS_HOST` | `string` | `https://adb-dev.azuredatabricks.net` | Adres URL workspace Databricks |
| `TARGET_CATALOG` | `string` | `lakehouse_dev` | Nazwa katalogu Unity Catalog dla dev |
| `POWERBI_WORKSPACE_ID` | `string` | `00000000-0000-0000-0000-000000000000` | ID testowego Workspace w Power BI Service |
| `POWERBI_DATASET_ID` | `string` | `00000000-0000-0000-0000-000000000000` | ID testowego Datasetu w Power BI |

---

## 4. Pipeline CI/CD w Azure DevOps (`azure-pipelines.yml`)

- **Stage 1: Build & Quality Check**:
  - `pytest tests/unit/` (Testy jednostkowe transformacji PySpark)
  - `ruff check .` (Linter kodu Python)
  - `databricks bundle validate --target staging`
- **Stage 2: Deploy to Staging**:
  - `databricks bundle deploy --target staging`
  - Uruchomienie testów integracyjnych w Databricks.
- **Stage 3: Manual Approval & Production Release**:
  - `databricks bundle deploy --target prod`
```bash
# Ręczne wywołanie walidacji paczki lokalnie przed commitem:
databricks bundle validate
```
