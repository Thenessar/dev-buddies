# GitHub Copilot Chat - Szablony Zapytań (Dev Buddies Prompts)

Poniższe szablony można wklejać bezpośrednio do okna **GitHub Copilot Chat** (w VS Code lub JetBrains), aby wykorzystać kontekst wygenerowanej bazy wiedzy `.agents/docs/`.

---

## 1. Asystent Nowego Zadania (Task Impact Assistant)

```markdown
@workspace Działaj jako Task Navigator. Chcę zrealizować następujące zadanie:
"[TUTAJ WKLEJ TREŚĆ LUB OPIS ZADANIA Z JIRY]"

Na podstawie kodu oraz plików w #file:.agents/docs/ARCHITECTURE.md i #file:.agents/docs/DATA_MODEL.md:
1. Wskaż dokładną listę plików i metod do modyfikacji/utworzenia.
2. Przygotuj plan implementacji krok po kroku (zgodny z TDD).
3. Ostrzeż mnie przed potencjalnymi skutkami ubocznymi (side effects) i problemami ze wsteczną kompatybilnością.
```

---

## 2. Pre-PR Sanity Check (Przegląd Kodu Przed Oddaniem do Zespołu)

```markdown
@workspace Działaj jako Pre-PR Reviewer. Przeanalizuj moje ostatnie zmiany w kodzie (lub w plikach: [TUTAJ WYMIEŃ PLIKI]).
Sprawdź zmiany pod kątem:
1. Zgodności z architekturą opisaną w #file:.agents/docs/ARCHITECTURE.md
2. Naruszeń reguł biznesowych z #file:.agents/docs/DOMAIN_AND_LOGIC.md
3. Problemów wydajnościowych (N+1, indeksy, wycieki pamięci)
4. Luk bezpieczeństwa (OWASP) i brakującej obsługi błędów

Sformatuj odpowiedź w standardzie Conventional Comments (🔴 [BLOCKER], 🟡 [SUGGESTION], 🟢 [NITPICK]).
```

---

## 3. Generator Testów Zgodnych z Konwencją Projektu

```markdown
@workspace Działaj jako Test Strategist. Chcę napisać testy dla pliku [ŚCIEŻKA DO PLIKU].
Na podstawie wytycznych z #file:.agents/docs/TEST_STRATEGY.md:
1. Przygotuj strukturę testów jednostkowych/integracyjnych.
2. Użyj fabryk danych i mocków typowych dla tego repozytorium.
3. Uwzględnij przypadki brzegowe i scenariusze błędów.
```

---

## 4. Wyjaśnienie Modułu

```markdown
@workspace Wyjaśnij mi działanie modułu [NAZWA KATALOGU/MODUŁU]. 
Jak łączy się on z resztą architektury w #file:.agents/docs/ARCHITECTURE.md oraz jakie reguły biznesowe z #file:.agents/docs/DOMAIN_AND_LOGIC.md realizuje?
```
