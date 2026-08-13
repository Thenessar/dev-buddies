# GitHub Copilot Instructions (Dev Buddies Integration)

Ten plik instruuje **GitHub Copilot Chat** oraz asystenta inline w środowiskach VS Code / JetBrains, w jaki sposób korzystać z wygenerowanej bazy wiedzy `.agents/docs/` jako źródła prawdy o projekcie.

> **Jak użyć w dowolnym projekcie**:  
> Skopiuj ten plik do `.github/copilot-instructions.md` w głównym katalogu swojego repozytorium (lub uruchom `init.sh` / `init.ps1` z flagą `--copilot`).

---

## Źródło Prawdy o Architekturze i Domenie
Przed generowaniem kodu, refaktoryzacją lub odpowiadaniem na pytania dotyczące architektury, **ZAWSZE** bierz pod uwagę kontekst zgromadzony w katalogu `.agents/docs/`:

1. **Struktura i Punkty Wejścia**: Zapoznaj się z [`.agents/docs/ARCHITECTURE.md`](file:///.agents/docs/ARCHITECTURE.md). Nie twórz nowych warstw ani wzorców sprzecznych z istniejącą architekturą.
2. **Słownik Pojęć (Ubiquitous Language)**: Zawsze używaj nazewnictwa zdefiniowanego w [`.agents/docs/DOMAIN_AND_LOGIC.md`](file:///.agents/docs/DOMAIN_AND_LOGIC.md). Przestrzegaj inwariantów i maszyn stanów encji.
3. **Baza Danych i Relacje**: Przed generowaniem zapytań lub migracji sprawdź [`.agents/docs/DATA_MODEL.md`](file:///.agents/docs/DATA_MODEL.md). Zwracaj uwagę na klucze obce, unikalność indeksów i soft-delete.
4. **Bezpieczeństwo**: Przestrzegaj polityk uprawnień i filtrów tenantów opisanych w [`.agents/docs/SECURITY_MODEL.md`](file:///.agents/docs/SECURITY_MODEL.md).
5. **Konwencje Testowe**: Generując testy, stosuj narzędzia i strukturę z [`.agents/docs/TEST_STRATEGY.md`](file:///.agents/docs/TEST_STRATEGY.md).

---

## Zasady Generowania Kodu dla Copilota
- **Czysty Kod i Typowanie**: Zawsze stosuj ścisłe typowanie (TypeScript / Python type hints / Go structs).
- **Zero Hallucination na Błędach**: Jeśli nie znasz sygnatury wewnętrznej metody projektu, odwołaj się do odpowiedniego pliku w projekcie lub poproś użytkownika o wskazanie pliku.
- **Bezpieczeństwo Danych**: Zawsze filtruj zapytania bazodanowe pod kątem uprawnień i identyfikatora organizacji/użytkownika.
