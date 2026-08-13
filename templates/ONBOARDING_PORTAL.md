# Developer Onboarding Portal

> **Repozytorium**: [Nazwa Projektu]  
> **Data wygenerowania**: [RRRR-MM-DD]  
> **Główny Stos**: [np. TypeScript / Go / Python / Java / Rust]

---

## 1. Executive Summary
- **Cel Biznesowy**: [Zwięzły opis problemu rozwiązywanego przez aplikację]
- **Styl Architektoniczny**: [np. Modular Monolith / Microservices / Clean Architecture]
- **Kluczowy Przepływ Użytkownika**: [Główna akcja w systemie, np. Rejestracja -> Płatność -> Realizacja usługi]

---

## 2. Mapa Portalu Wiedzy

| Obszar | Dokument | Opis Zawartości |
|---|---|---|
| Architektura | [`ARCHITECTURE.md`](file:///.agents/docs/ARCHITECTURE.md) | Diagram C4 Container, punkty wejścia, routing API |
| Domena & Biznes | [`DOMAIN_AND_LOGIC.md`](file:///.agents/docs/DOMAIN_AND_LOGIC.md) | Słownik pojęć, maszyny stanów, inwarianty biznesowe |
| Baza Danych | [`DATA_MODEL.md`](file:///.agents/docs/DATA_MODEL.md) | Diagram ERD, modele ORM, indeksy i migracje |
| Setup & Infra | [`INFRA_SETUP.md`](file:///.agents/docs/INFRA_SETUP.md) | Runbook uruchomienia lokalnego, zmienne `.env`, Docker |
| Bezpieczeństwo | [`SECURITY_MODEL.md`](file:///.agents/docs/SECURITY_MODEL.md) | Model Auth (JWT/OAuth), RBAC, wrażliwe wektory |
| Testy & QA | [`TEST_STRATEGY.md`](file:///.agents/docs/TEST_STRATEGY.md) | Piramida testów, komendy uruchomieniowe, mocki |

---

## 3. Szybki Start Dewelopera (Pierwsze 15 Minut)
1. **Lokalne Środowisko**: Postępuj zgodnie z instrukcją w [`INFRA_SETUP.md`](file:///.agents/docs/INFRA_SETUP.md).
2. **Główny Punkt Wejścia**: Otwórz plik startowy w swoim edytorze.
3. **Pierwsze Zadanie**: Wykorzystaj agenta `task-navigator` do przeanalizowania swojego pierwszego taska.
