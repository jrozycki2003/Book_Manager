# 📚 Book Manager – Twoja Cyfrowa Biblioteczka i Czytelnicza Społeczność

To mój pierwszy projekt w Ruby on Rails. Powstał po to, żeby wygodnie zarządzać swoją kolekcją książek i dzielić się opiniami z innymi. Zamiast notatek w Wordzie czy arkuszach, mamy tu proste narzędzia do prowadzenia własnej biblioteki i tworzenia czytelniczej społeczności.

-----

## ✨ Co tu można robić? (Główne Funkcje)

### 🚀 Pełna kontrola nad książkami

Dodajesz, edytujesz i oznaczasz książki. Możesz przyznawać im gwiazdki (5-stopniowa skala), dodawać tagi do organizacji (np. `#FantasyKlasyka`, `#MustRead`) i eksportować całą swoją bibliotekę do pliku **CSV**.

### 💬 Dyskusje i społeczność

Tworzysz posty, komentujesz i „lajkujesz” dyskusje innych czytelników. To miejsce, gdzie książka staje się początkiem rozmowy\!

### 🛡️ Bezpieczne konta

Możesz założyć konto, zalogować się, uzupełnić swój profil i bezpiecznie zarządzać danymi. Dostępny jest też prosty panel administratora (`/admin`) do zarządzania użytkownikami i treściami.

### ⚡ Przyjemne korzystanie

Aplikacja działa szybko i wygodnie, a techniczne szczegóły są schowane — nie musisz ich znać, żeby swobodnie korzystać.

-----

## 💻 Serce Projektu (Tech Stack)

Projekt działa w oparciu o **nowoczesne Railsy (8.x)**, co gwarantuje szybkość i stabilność.

  * **Framework:** Ruby on Rails 8.1.1
  * **Frontend:** Hotwire (Turbo & Stimulus) – interaktywność bez chaosu JavaScript.
  * **Baza Danych:** PostgreSQL
  * **Wydajność:** Solid Queue i Solid Cache (dla zadań i buforowania).

-----

## 🛠️ Instalacja — W Skrócie (Uruchom to u Siebie\!)

Chcesz uruchomić projekt u siebie? Wystarczą trzy kroki.

### 1️⃣ Pobierz Projekt

```bash
git clone <repository-url>
cd Book_Manager
```

### 2️⃣ Zainstaluj Potrzebne Rzeczy

Użyj skryptu, który zajmie się wszystkimi zależnościami, bazą i startem danych:

#### Na macOS/Linux (Zalecane)

```bash
./setup.sh
```

#### Albo Ręcznie:

```bash
bundle install
rails db:setup # Tworzy bazę, migruje i dodaje dane startowe (seeds)
```

### 3️⃣ Uruchom Serwer Deweloperski

```bash
bin/dev
```

Strona będzie pod adresem:
**📍 http://localhost:3000**

-----

## 📖 Jak Korzystać? (Quick Guide)

### 👤 Konto Użytkownika

  * Rejestrujesz się lub logujesz poprzez wbudowane formularze (`/users/new`, `/sessions/new`).
  * Masz dostęp do własnego, spersonalizowanego panelu na **`/dashboard`**.

### 📚 Twoja Kolekcja Książek

1.  Dodajesz nowe tytuły jednym kliknięciem w sekcji Książki.
2.  Oznaczasz, czy książkę przeczytałeś/aś (status read/unread).
3.  Nadajesz oceny (gwiazdki) i tagi (np. \#kryminał).
4.  Całą listę możesz wyeksportować do pliku **CSV** w celu archiwizacji.

### 🗣️ Dyskusje

  * Tworzysz własne posty: o konkretnej książce, recenzji albo po prostu temat do rozmowy.
  * Możesz komentować i „polubić” (likować) posty innych czytelników.