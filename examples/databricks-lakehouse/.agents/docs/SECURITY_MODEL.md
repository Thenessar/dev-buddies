# Model Bezpieczeństwa & Autoryzacji (Unity Catalog AppSec)

## 1. Architektura Tożsamości & Uwierzytelniania
- **Zarządzanie Tożsamością**: Microsoft Entra ID (dawniej Azure AD) zsynchronizowane z Unity Catalog.
- **Dostęp CI/CD i Zadań Wsadowych**: Dedykowany Service Principal (`sp-databricks-automation`) z przypisanym certyfikatem OIDC (federated credentials bez haseł).
- **Zarządzanie Sekretami**: Azure Key Vault powiązany z Databricks Secret Scope (`scope: akv-data-platform`).

---

## 2. Matryca Uprawnień Unity Catalog (RBAC Matrix)

| Grupa / Rola w Entra ID | Zakres Uprawnień w Unity Catalog | Zastosowanie |
|---|---|---|
| `AAD_DataEngineers_Dev` | `USE CATALOG`, `CREATE SCHEMA`, `ALL PRIVILEGES` na `lakehouse_dev` | Praca deweloperska i testy w DABs |
| `AAD_DataEngineers_Prod` | `SELECT`, `EXECUTE` na `lakehouse_prod` (brak uprawnień DROP/ALTER) | Utrzymanie produkcji i monitoring |
| `AAD_BI_PowerBI_Service` | `SELECT` wyłącznie na schemacie `lakehouse_prod.gold` | Odczyt danych przez SQL Warehouse dla raportów |
| `AAD_DataScientists` | `SELECT` na `silver` i `gold`, `CREATE TABLE` w `lakehouse_prod.features` | Trening modeli ML i eksperymenty MLflow |

---

## 3. Bezpieczeństwo Poziomu Wierszy i Kolumn (Row & Column Level Security)

- **Maskowanie Danych Osobowych (Column Masking)**:
  - Tabela `silver.cleaned_customers`: Kolumny `email`, `phone_number` oraz `tax_id` są objęte funkcją maskującą `mask_pii_string()`. Użytkownicy spoza grupy Compliance widzą format: `j***@domain.com`.
- **Filtrowanie Wierszy (Row-Level Security)**:
  - Tabela `gold.fact_monthly_financials`: Widok zabezpieczony funkcją `filter_by_region(country_code)` ograniczającą dostęp analityków tylko do ich macierzystego regionu geograficznego.
