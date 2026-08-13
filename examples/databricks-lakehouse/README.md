# Example: Enterprise Databricks Lakehouse & MLOps Platform

Ten katalog zawiera przykładową, w pełni wygenerowaną dokumentację onboardingową (`.agents/docs/`) dla zaawansowanej platformy danych klasy Enterprise.

---

## Profil Przykładowego Projektu

- **Architektura Danych**: Medallion Architecture (Bronze -> Silver -> Gold w standardzie Delta Lake / Unity Catalog).
- **Orkiestracja & Deployment**: Databricks Asset Bundles (DABs) (`databricks.yml`).
- **MLOps**: Modele predykcyjne Customer Churn w Unity Catalog & MLflow, Batch Inference Pipelines.
- **Warstwa Raportowa / BI**: Power BI Semantic Models z automatycznym odświeżaniem przez Databricks SQL Warehouse & REST API.
- **Infrastruktura & CI/CD**: Terraform (Azure Databricks, ADLS Gen2, Key Vault) + Azure DevOps Multi-Stage Pipelines (`azure-pipelines.yml`).

---

## Wygenerowane Pliki Dokumentacji

Zapoznaj się z plikami w katalogu [`.agents/docs/`](.agents/docs/):
1. [`ONBOARDING_PORTAL.md`](.agents/docs/ONBOARDING_PORTAL.md) – Główny pulpit nawigacyjny dla nowego inżyniera danych / MLOps.
2. [`ARCHITECTURE.md`](.agents/docs/ARCHITECTURE.md) – Architektura Medallion, Databricks Workflows, integracja z Power BI i MLflow.
3. [`DOMAIN_AND_LOGIC.md`](.agents/docs/DOMAIN_AND_LOGIC.md) – Słownik pojęć, reguły agregacji i inwarianty jakości danych (Expectations).
4. [`DATA_MODEL.md`](.agents/docs/DATA_MODEL.md) – Schemat Unity Catalog, relacje ERD tabel Gold/Silver oraz Data Lineage.
5. [`INFRA_SETUP.md`](.agents/docs/INFRA_SETUP.md) – Runbook lokalnego dewelopmentu z Databricks CLI v2, DABs i Azure CLI.
6. [`SECURITY_MODEL.md`](.agents/docs/SECURITY_MODEL.md) – Uprawnienia Unity Catalog (RBAC), Row/Column level security, Secret Scopes.
7. [`TEST_STRATEGY.md`](.agents/docs/TEST_STRATEGY.md) – Testowanie transformacji PySpark z `chispa` i `pytest`, walidacja paczek DABs.
8. [`TASK_IMPACT.md`](.agents/docs/TASK_IMPACT.md) – Przykładowy wektor zmian dla zadania: *"Dodanie wskaźnika Customer Sentiment Score do tabeli Gold i odświeżenie raportu Power BI"*.
9. [`PRE_PR_REPORT.md`](.agents/docs/PRE_PR_REPORT.md) – Raport pre-PR weryfikujący zapytania Spark pod kątem partition pruning i wycieków danych.
