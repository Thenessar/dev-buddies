# Raport Przeglądu Kodu (Pre-PR Sanity Check)

## Status Przygotowania do PR: ZALECANE DROBNE POPRAWKI

## Szybkie Podsumowanie
- Blokery: 0
- Sugestie: 1
- Drobne uwagi (Nitpicks): 1

---

## Zgłoszenia i Rekomendacje (Conventional Comments)

### 🟡 [SUGGESTION] Potencjalny Full Table Scan przy braku filtra partycji
- **Plik**: [`src/pipelines/gold_analytics/dim_customer.py`](file:///...#L62-L71)
- **Problem**: Odczyt z tabeli `silver.cleaned_telemetry_events` nie zawiera filtra po dacie partycji `event_date`, co przy 500 GB danych spowoduje pełny skan tabeli i wysoki koszt klastra.
- **Propozycja Rozwiązania**:
```python
# ZAMIAST:
events_df = spark.read.table("lakehouse_prod.silver.cleaned_telemetry_events")

# ZASTOSUJ (Odczyt tylko z okna 30 dni):
from datetime import datetime, timedelta
cutoff_date = (datetime.now() - timedelta(days=30)).strftime("%Y-%m-%d")

events_df = (
    spark.read.table("lakehouse_prod.silver.cleaned_telemetry_events")
    .filter(f"event_date >= '{cutoff_date}'")
)
```

---

### 🟢 [NITPICK] Nieużywana zmienna w definicji zadania DABs
- **Plik**: [`databricks.yml`](file:///...#L44)
- **Uwaga**: Parametr `max_concurrent_runs: 1` jest zduplikowany w bloku zadania `gold_aggregation_job`.

---

## Checklista Przed Wystawieniem PR
- [x] Wszystkie testy jednostkowe przechodzą pomyślnie (`pytest tests/unit/`)
- [x] Linter `ruff` nie zwraca ostrzeżeń
- [x] Wiązka DABs pomyślnie przeszła walidację (`databricks bundle validate`)
- [ ] Zastosowano filtrowanie partycji w `dim_customer.py`
