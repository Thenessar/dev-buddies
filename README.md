# 🚀 Projekt `dev-buddies`

> **Lekki, przenośny zestaw wyspecjalizowanych subagentów AI dla środowiska Google Antigravity, zaprojektowany z myślą o natychmiastowym wdrożeniu dewelopera (*developer onboarding*) w nowe lub nieznane repozytorium kodu.**

---

## 🎯 Main Use Case (Główny Cel)

Projekt rozwiązuje problem braku aktualnej dokumentacji oraz długiego czasu potrzebnego na poznanie nowej bazy kodu. Zamiast spędzać godziny na ręcznym przekopywaniu plików i zgadywaniu logiki, zaciągasz zespół agentów do nowego repozytorium, a oni automatycznie budują dla Ciebie kompletną bazę wiedzy.

---

## 🤖 Zespół Subagentów (Dev Buddies)

Zamiast jednego przeciążonego agenta, **dev-buddies** dzieli pracę na wyspecjalizowane role o ograniczonym i czystym oknie kontekstowym:

| Subagent | Rola i Odpowiedzialność | Plik wynikowy |
|---|---|---|
| 💼 **business-interpreter** | Odtwarza logikę biznesową, procesy i słownik pojęć domenowych wprost z kodu (enumy, reguły walidacji, integracje API). | `.agents/docs/BUSINESS_DICTIONARY.md`<br>`.agents/docs/BUSINESS_LOGIC.md` |
| 🗺️ **app-guide** | Mapuje architekturę aplikacji, routing API, punkty wejścia i przepływ żądań HTTP. | `.agents/docs/ARCHITECTURE.md` |
| 🗄️ **data-docent** | Analizuje schematy baz danych, modele ORM, zapytania SQL oraz liniowość danych (*data lineage*). | `.agents/docs/DATA_MODEL.md` |
| 🐳 **infra-docent** | Wyciąga instrukcje lokalnego uruchomienia, zmienne środowiskowe, pliki Dockerfile oraz pipeline'y CI/CD. | `.agents/docs/INFRA_SETUP.md` |
| 🎯 **impact-navigator** | Działa jako asystent zadań. Gdy dostajesz taska z Jiry, wdrożony agent wskazuje dokładne pliki i funkcje, które musisz zmodyfikować. | `.agents/docs/TASK_IMPACT.md` |
| 🕵️ **code-reviewer** (*Alex*) | Persona surowego Staff Engineera, który robi audyt Twoich zmian w kodzie (PR) pod kątem zgodności z architekturą i regułami biznesowymi. | `.agents/docs/CODE_REVIEW_REPORT.md` |

---

## ⚙️ Architektura & Workflow ("Clean State")

1. **Centralne Repozytorium-Matka**: Kod i prompty agentów trzymasz w jednym miejscu (`dev-buddies`).
2. **Zero-Install (Jedna Komenda)**: Wchodzisz do dowolnego, nowego repozytorium i uruchamiasz krótki skrypt/alias (np. `init.sh` lub `init.ps1`), który pobiera najnowszą paczkę agentów do folderu `.agents/`.
3. **DAG & Isolation**: Agenci pracują w zrównoleglonym przepływie (DAG), używają sandboxa i nie zapychają głównego okna kontekstowego surowym kodem.
4. **Wynik**: W katalogu `.agents/docs/` powstaje kompletny portal wiedzy z plikiem `ONBOARDING_GUIDE.md` i diagramami Mermaid.js, gotowy do przeczytania w 3 minuty.

---

## 📁 Struktura Repozytorium

```text
dev-buddies/
├── agents/
│   ├── app-guide.md            # Buddy od architektury i API
│   ├── business-interpreter.md # Buddy od logiki biznesowej
│   ├── data-docent.md          # Buddy od baz danych i ETL
│   ├── infra-docent.md         # Buddy od Docker/CI/CD/Infry
│   ├── impact-navigator.md     # Buddy do wyznaczania zakresu tasków
│   └── code-reviewer.md        # Alex - Staff Engineer do CR
├── rules/
│   └── global-constraints.md   # Zasady budżetu kontekstu i Graceful Exit
├── init.sh                     # Skrypt Bash inicjalizujący paczkę
├── init.ps1                    # Skrypt PowerShell dla Windows
└── README.md
```

---

## 🚀 Szybki Start (Instrukcja Użycia)

### 1. Inicjalizacja w nowym repozytorium (Linux / macOS)

W środowisku zintegrowanym lub terminalu docelowego projektu wykonaj:

```bash
curl -sSL https://raw.githubusercontent.com/TWOJ_GITHUB/dev-buddies/main/init.sh | bash
```

lub pobierz i uruchom skrypt lokalnie:

```bash
./init.sh
```

### 2. Inicjalizacja w środowisku Windows (PowerShell)

```powershell
.\init.ps1
```

Skrypt automatycznie:
- Pobierze prompty agentów do katalogu `.agents/`
- Doda regułę `.agents/docs/` do pliku `.gitignore` w docelowym repozytorium

---

## 📄 Licencja

MIT License - gotowe do swobodnego użycia i dostosowania w dowolnym projekcie.
