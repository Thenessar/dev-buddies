# Global Constraints & Execution Rules for Dev Buddies

Niezmienne reguły i wytyczne dla wszystkich subagentów z rodziny **Dev Buddies** pracujących w środowisku Google Antigravity.

---

## 1. Zero-Noise & Budget Control (Zarządzanie Kontekstem)
- **Nie wklejaj surowego kodu do konwersacji głównej.** Wszystkie wyniki analizy, schematy i opis architektury zapisuj do plików w katalogu `.agents/docs/`.
- Podsumowania prezentowane użytkownikowi w czacie mają być zwięzłe, rzeczowe i skondensowane (czas czytania < 3 minuty).
- Korzystaj z hierarchicznych plików Markdown i diagramów Mermaid.js zamiast długich ścieżek tekstu.

---

## 2. Katalog Wynikowy & Izolacja (`.agents/docs/`)
- Wszystkie wygenerowane artefakty wiedzy MUSZĄ trafiać do katalogu `.agents/docs/`.
- Domyślny zestaw wygenerowanej dokumentacji:
  - `.agents/docs/ONBOARDING_GUIDE.md` (Główny portal wiedzy łączący wszystkie raporty)
  - `.agents/docs/ARCHITECTURE.md` (Mapa architektury i routingu HTTP)
  - `.agents/docs/BUSINESS_DICTIONARY.md` & `BUSINESS_LOGIC.md` (Słownik i logika biznesowa)
  - `.agents/docs/DATA_MODEL.md` (Model danych, relacje, schematy ER)
  - `.agents/docs/INFRA_SETUP.md` (Instrukcja uruchomienia, env variables, Docker)

## 3. 🎨 MERMAID DIAGRAM STANDARDS

When generating architectural or data flow diagrams:
1. **Layout Direction**: Always use `graph LR` (Left to Right) for architecture, pipelines, and data lineage.
2. **No Orchestrator Enclosure**: Workflows, Cron jobs, or Schedulers MUST NOT wrap other components in a `subgraph`. Place them on the far left as trigger nodes (`Trigger .-> Target`).
3. **Flat Subgraphs**: Do NOT nest subgraphs inside other subgraphs. Keep all subgraphs on a single horizontal level.
4. **Final Pass**: Always invoke `diagram-reviewer` after generating documentation to perform a final visual lint on all `.agents/docs/*.md` files.

---

## 4. Strategia Graceful Exit & Niepewność
- Jeśli baza kodu nie zawiera pewnych informacji (np. brak plików Docker, brak schematu DB):
  - Wyraźnie zaznacz to w raporcie pod sekcją **Brakujące Dane / Założenia**.
  - Nie zgaduj i nie halucynuj nieistniejących konfiguracji.
  - Przedstaw proponowane rekomendacje uzupełnienia braków.

---

## 5. DAG Execution & Zrównoleglenie
- Subagenci pracują jako niezależne lub połączone w DAG (Directed Acyclic Graph) jednostki.
- Subagent niższego szczebla (np. `impact-navigator`) może odwoływać się do wygenerowanej wcześniej dokumentacji w `.agents/docs/` bez potrzeby ponownej pełnej analizy kodu.
