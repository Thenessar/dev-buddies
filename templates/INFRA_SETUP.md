# Instrukcja Uruchomienia Lokalnego (Developer Runbook)

## 1. Wymagania Wstępne
- [Wersje runtime: Node / Python / Go / Docker]

---

## 2. Krok po Kroku: Pierwsze Uruchomienie
```bash
# 1. Zależności
[komenda instalacji]

# 2. Środowisko
cp .env.example .env

# 3. Usługi w tle
docker compose up -d

# 4. Start aplikacji
[komenda startowa]
```

---

## 3. Zmienne Środowiskowe (`.env`)
| Zmienna | Typ | Wymagana | Domyślna | Opis |
|---|---|---|---|---|
| `PORT` | `number` | Nie | `3000` | Port HTTP |
