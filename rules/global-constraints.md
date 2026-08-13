# Globalne Reguły i Standardy Inżynieryjne dla Dev Buddies

Wytyczne jakościowe dla subagentów z rodziny **Dev Buddies** pracujących w środowiskach Google Antigravity oraz asystentów zintegrowanych z GitHub Copilot.

---

## 1. Zero-Noise & Context Budget Control (Ekonomia Kontekstu)
- **Nie wklejaj surowego kodu do głównego okna czatu.** Wszystkie szczegółowe analizy, schematy i opisy zapisuj do plików w katalogu `.agents/docs/`.
- Podsumowania prezentowane użytkownikowi w oknie rozmowy mają być zwięzłe, punktowe i nastawione na natychmiastowe działanie (czas czytania < 2 minuty).
- Zamiast ścian tekstu stosuj tabele Markdown, listy kontrolne oraz diagramy Mermaid.js.
- Linkuj pliki i symbole źródłowe za pomocą klikalnych odnośników Markdown: `[`ścieżka/do/pliku.ts`](file:///absolute/path/to/file.ts#L10-L25)`.

---

## 2. Katalog Wynikowy & Architektura Informacji (`.agents/docs/`)
- Wszystkie wygenerowane artefakty wiedzy muszą trafiać do dedykowanego katalogu: `.agents/docs/`.
- Standardowy zestaw dokumentacji onboardingowej:
  - `.agents/docs/ONBOARDING_PORTAL.md` – Główny portal wiedzy (Dashboard nawigacyjny)
  - `.agents/docs/ARCHITECTURE.md` – Architektura systemu (C4 Container/Component) & Routing API
  - `.agents/docs/DOMAIN_AND_LOGIC.md` – Słownik pojęć (Ubiquitous Language) & Reguły biznesowe
  - `.agents/docs/DATA_MODEL.md` – Model danych, relacje ERD, ORM i migracje
  - `.agents/docs/INFRA_SETUP.md` – Instrukcja lokalnego uruchomienia, zmienne środowiskowe, Docker
  - `.agents/docs/SECURITY_MODEL.md` – Model uwierzytelniania, uprawnienia i wektory bezpieczeństwa
  - `.agents/docs/TEST_STRATEGY.md` – Piramida testów, komendy uruchomieniowe i luki w testach

---

## 3. Standardy Diagramów Mermaid.js
Każdy diagram generowany przez agentów musi spełniać poniższe kryteria czytelności:
1. **Kierunek Layoutu**: Zawsze wymuszaj `graph LR` (od lewej do prawej) dla architektury, potoków danych i przepływów żądań. Unikaj `graph TD`.
2. **Spłaszczona Struktura Subgraphów**: Maksymalny poziom zagnieżdżenia `subgraph` wynosi **1**. Nigdy nie zagnieżdżaj subgraphów wewnątrz innych subgraphów.
3. **Izolacja Wyzwalaczy (Orchestrators/Triggers)**: Elementy wyzwalające (Cron, Event Schedulers, Webhooki zewnętrzne) umieszczaj po lewej stronie jako wyizolowane węzły kierunkowe (`Trigger .-> Service`), a nie jako kontenery otaczające.
4. **Semantyczne Kształty Węzłów (Bez dekoracyjnych emoji w etykietach)**:
   - Pamięć masowa i bazy danych: `[( Nazwa Bazy / Tabeli )]`
   - Serwisy / Kontrolery: `[ Nazwa Komponentu ]`
   - Kolejki i magistrale zdarzeń: `>{{ Nazwa Kolejki / Tematu }}`
   - Bramki decyzyjne: `{ Decyzja / Warunek }`
5. **Weryfikacja Końcowa**: Przed zakończeniem pracy orkiestrator może wywołać `diagram-reviewer`, aby upewnić się, że diagramy są syntaktycznie i wizualnie czyste.

---

## 4. Graceful Exit & Radzenie Sobie z Niepewnością
- Jeśli w repozytorium brakuje pewnych elementów (np. brak plików Docker, brak testów E2E, brak migracji SQL):
  - **Nigdy nie zgaduj ani nie halucynuj.**
  - Odnotuj fakt w sekcji **Brakujące Dane / Założenia** wygenerowanego dokumentu.
  - Sformułuj krótką, profesjonalną rekomendację inżynieryjną, jak zespół może ten brak uzupełnić.

---

## 5. Standardy Oceny Kodu (Pre-PR Buddy)
- W analizach zmian i przeglądzie kodu stosuj format **Conventional Comments**:
  - `🔴 [BLOCKER]` – Krytyczne luki bezpieczeństwa, naruszenia inwariantów biznesowych, ewidentne wycieki zasobów.
  - `🟡 [SUGGESTION]` – Optymalizacje wydajnościowe, czytelność, spójność z wzorcami architektonicznymi.
  - `🟢 [NITPICK]` – Drobne uwagi dotyczące nazewnictwa lub formatowania.
  - `💡 [QUESTION]` – Pytania o intencję lub nieoczywiste decyzje projektowe.
