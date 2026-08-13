# Model Bezpieczeństwa & Autoryzacji (AppSec Overview)

## 1. Architektura Uwierzytelniania
- **Typ Auth**: [np. JWT Bearer Tokens / Session Cookies / OAuth2]
- **Punkt Wejścia**: [`src/...`](file:///...)

---

## 2. Matryca Ról i Uprawnień (RBAC)
| Rola | Uprawnienia | Strażnik w Kodzie |
|---|---|---|
| `USER` | Podstawowy dostęp | `@Guard(...)` |

---

## 3. Zabezpieczenia i Middleware
- **CORS / Throttler / Sanityzacja / Headers**

---

## 4. Punkty Wrażliwe i Wskazówki
- [Ostrzeżenia i uwagi dotyczące bezpieczeństwa danych]
