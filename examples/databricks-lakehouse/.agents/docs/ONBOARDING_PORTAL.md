# Developer Onboarding Portal

> **Repozytorium**: `enterprise-data-platform`  
> **Data wygenerowania**: 2026-08-14  
> **Stos Technologiczny**: Azure Databricks / Unity Catalog / PySpark / MLflow / Power BI / Terraform / Azure DevOps / DABs

---

## 1. Executive Summary
- **Cel Platformy**: Centralna platforma Lakehouse przetwarzająca surowe dane telemetryczne, transakcje e-commerce oraz modele predykcyjne Customer Churn, serwująca zagregowane dane analityczne do raportów Power BI dla kadry zarządzającej.
- **Styl Architektoniczny**: **Medallion Architecture (Bronze -> Silver -> Gold)** na bazie Delta Lake i Unity Catalog, wdrażana deklaratywnie za pomocą Databricks Asset Bundles (DABs).
- **Kluczowy Przepływ Danych**: Ingestion (Event Hubs & CDC) -> Bronze (Raw Append) -> Silver (Deduplication & Cleanse) -> Gold (Star Schema & Feature Store) -> ML Inference (Churn Model) -> Power BI Automated Refresh.

---

## 2. Mapa Portalu Wiedzy

| Obszar | Dokument | Opis Zawartości |
|---|---|---|
| Architektura | [`ARCHITECTURE.md`](file:///e:/repos/dev-buddies/examples/databricks-lakehouse/.agents/docs/ARCHITECTURE.md) | Diagram Medallion Lakehouse, Databricks Workflows, MLflow, integracja Power BI |
| Domena & Biznes | [`DOMAIN_AND_LOGIC.md`](file:///e:/repos/dev-buddies/examples/databricks-lakehouse/.agents/docs/DOMAIN_AND_LOGIC.md) | Słownik pojęć, reguły agregacji MRR/Churn, reguły walidacji (Delta Expectations) |
| Baza Danych & Tabele | [`DATA_MODEL.md`](file:///e:/repos/dev-buddies/examples/databricks-lakehouse/.agents/docs/DATA_MODEL.md) | Struktura Unity Catalog (`lakehouse_prod.*`), diagram ERD tabel Gold/Silver, Data Lineage |
| Setup & Infra | [`INFRA_SETUP.md`](file:///e:/repos/dev-buddies/examples/databricks-lakehouse/.agents/docs/INFRA_SETUP.md) | Developer Runbook z Databricks CLI v2, wdrożenia deweloperskie DABs, zmienne `.env` |
| Bezpieczeństwo | [`SECURITY_MODEL.md`](file:///e:/repos/dev-buddies/examples/databricks-lakehouse/.agents/docs/SECURITY_MODEL.md) | Unity Catalog RBAC, Row/Column level security, Azure Key Vault Secret Scopes |
| Testy & QA | [`TEST_STRATEGY.md`](file:///e:/repos/dev-buddies/examples/databricks-lakehouse/.agents/docs/TEST_STRATEGY.md) | Testy jednostkowe PySpark (`chispa`), testy integralności DABs, mocki pipeline'ów |

---

## 3. Szybki Start Nowego Inżyniera Danych (Pierwsze 15 Minut)
1. **Lokalny setup**: Skonfiguruj autoryzację `databricks auth login --host ...` oraz Azure CLI (instrukcja w [`INFRA_SETUP.md`](file:///e:/repos/dev-buddies/examples/databricks-lakehouse/.agents/docs/INFRA_SETUP.md)).
2. **Główny punkt wejścia konfiguracji**: Zapoznaj się z plikiem [`databricks.yml`](file:///...) definiującym pipeline'y DABs i zadania orkiestracji.
3. **Twój pierwszy task?**: Uruchom agenta `task-navigator` z opisem swojego zadania (np. dodanie nowej miary do warstwy Gold), aby otrzymać dokładny plan zmian.

---

## 4. Zgłoszone Ograniczenia i Założenia (Graceful Exit)
- [INFO] Schematy raportów Power BI (`.pbip`) trzymane są w podkatalogu `powerbi/`; odświeżanie raportów na środowiskach dev wymaga dedykowanego Service Principala z uprawnieniami Power BI Workspace Contributor.
