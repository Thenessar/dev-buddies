# Strategia Testów & Przewodnik QA (Data & ML Testing)

## 1. Zestawienie Środowiska Testowego
- **Framework Testów Jednostkowych**: `pytest` (wersja 8.x) + biblioteka `chispa` (do szybkiego porównywania DataFrames PySpark bez uruchamiania ciężkich klastrów).
- **Walidacja Danych**: Delta Live Tables Expectations + biblioteka `great_expectations` dla walidacji schematów w locie.
- **Testy Infrastruktury & DABs**: `databricks bundle validate` w potoku CI Azure DevOps.

---

## 2. Ściąga Komend Testowych (Developer Cheat Sheet)

```bash
# 1. Uruchomienie wszystkich testów jednostkowych (szybkie testy transformacji PySpark)
pytest tests/unit/ -v

# 2. Uruchomienie pojedynczego testu z logowaniem szczegółowym
pytest tests/unit/test_gold_customer_aggregations.py -k "test_mrr_calculation"

# 3. Sprawdzenie pokrycia kodu testami
pytest --cov=src/pipelines --cov-report=term-missing

# 4. Sprawdzenie poprawności schematu wiązki DABs
databricks bundle validate --target dev
```

---

## 3. Konwencja Pisania Testu Transformacji PySpark (Przykład)

```python
from chispa import assert_df_equality
from src.pipelines.silver_transform.customers import clean_customer_records

def test_clean_customer_records_drops_null_ids(spark_session):
    # Arrange
    source_data = [("C1", "Jan Kowalski"), (None, "Błędny Rekord")]
    source_df = spark_session.createDataFrame(source_data, ["customer_id", "name"])

    # Act
    result_df = clean_customer_records(source_df)

    # Assert
    expected_data = [("C1", "Jan Kowalski")]
    expected_df = spark_session.createDataFrame(expected_data, ["customer_id", "name"])
    assert_df_equality(result_df, expected_df)
```

---

## 4. Zidentyfikowane Luki w Testach (Obszary Podwyższonego Ryzyka)
- **Moduł `src/bi/powerbi_refresh/`**: Brak testu sprawdzającego zachowanie skryptu przy przekroczeniu limitu zapytań (HTTP 429) do API Power BI.
- **Drift Danych Modelu ML**: Brak zautomatyzowanego testu sprawdzającego przesunięcie rozkładu cech (Data Drift) przed uruchomieniem predykcji.
