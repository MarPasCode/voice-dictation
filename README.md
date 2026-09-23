# VoiceDictation

**[English](#english)** | **[Polski](#polski)**

---

## English

A tiny local voice-dictation tool for the browser. Speak in Chrome, get a live transcript, and have it copied to your clipboard automatically when you stop — no accounts, no cloud dashboard, no cost.

It's a single-page app served by a minimal Node.js static file server, with an OS-level installer that registers it to start silently on login.

### How it works

- Speech-to-text runs on Chrome's built-in **Web Speech API**. This means your voice recording is sent to **Google's servers** to be converted to text — an internet connection is required, and audio does leave your machine at that step.
- Everything else — the local web server and copying the result to your clipboard — runs entirely on your computer.
- Requires **Google Chrome** specifically; other browsers don't support the Web Speech API (or only partially).

### Quick start

Not a developer? Follow the full, no-assumptions installation guide instead:

- [INSTRUCTIONS_EN.md](INSTRUCTIONS_EN.md) — English

For a manual/developer setup:

```bash
node server.js
```

Then open `http://localhost:7778` in Chrome. The port can be overridden with the `DICT_PORT` environment variable or by editing `config.json`.

To install as a silent autostart service:

```powershell
# Windows (PowerShell)
.\install.ps1            # optional: -Port 8081
```

```bash
# macOS
bash install.sh          # optional: --port 8081
```

### Files

| File | Purpose |
|---|---|
| `index.html` | The dictation UI — start/stop, language picker, transcript box, copy/clear. |
| `server.js` | Minimal static file server that hosts `index.html` and its assets. |
| `config.json` | Stores the port the server listens on. |
| `favicon.svg` | Browser tab icon. |
| `install.ps1` | Windows installer — sets the port, registers silent autostart, launches the server. |
| `start-hidden.vbs` | Launches `server.js` with no visible console window (used by the Windows autostart shortcut). |
| `install.sh` | macOS installer — sets the port, registers a LaunchAgent for silent autostart, launches the server. |
| `INSTRUCTIONS_EN.md` / `INSTRUCTIONS_PL.md` | Full installation guide for non-technical users, in English and Polish. |

### Requirements

- [Node.js](https://nodejs.org) (LTS)
- Google Chrome
- Windows or macOS

---

## Polski

Małe, lokalne narzędzie do dyktowania w przeglądarce. Mów w Chrome, zobacz transkrypcję na żywo, a po zatrzymaniu tekst zostanie automatycznie skopiowany do schowka — bez kont, bez panelu w chmurze, bez kosztów.

To aplikacja jednostronicowa serwowana przez minimalny serwer plików statycznych w Node.js, z instalatorem, który rejestruje ją do cichego uruchamiania po zalogowaniu.

### Jak to działa

- Rozpoznawanie mowy korzysta z wbudowanego w Chrome **Web Speech API**. Oznacza to, że nagranie Twojego głosu jest wysyłane na **serwery Google** w celu zamiany na tekst — wymaga to połączenia z internetem, a audio faktycznie opuszcza Twój komputer na tym etapie.
- Wszystko inne — lokalny serwer i kopiowanie wyniku do schowka — działa w pełni na Twoim komputerze.
- Wymaga konkretnie **Google Chrome**; inne przeglądarki nie obsługują Web Speech API (albo tylko częściowo).

### Szybki start

Nie jesteś programistą? Skorzystaj z pełnej instrukcji instalacji, która niczego nie zakłada:

- [INSTRUCTIONS_PL.md](INSTRUCTIONS_PL.md) — Polski

Do ręcznej konfiguracji (dla programistów):

```bash
node server.js
```

Następnie otwórz `http://localhost:7778` w Chrome. Port można nadpisać zmienną środowiskową `DICT_PORT` albo edytując `config.json`.

Aby zainstalować jako usługę z cichym autostartem:

```powershell
# Windows (PowerShell)
.\install.ps1            # opcjonalnie: -Port 8081
```

```bash
# macOS
bash install.sh          # opcjonalnie: --port 8081
```

### Pliki

| Plik | Przeznaczenie |
|---|---|
| `index.html` | Interfejs dyktowania — start/stop, wybór języka, pole transkrypcji, kopiuj/wyczyść. |
| `server.js` | Minimalny serwer plików statycznych obsługujący `index.html` i jego zasoby. |
| `config.json` | Przechowuje port, na którym słucha serwer. |
| `favicon.svg` | Ikona karty w przeglądarce. |
| `install.ps1` | Instalator dla Windows — ustawia port, rejestruje cichy autostart, uruchamia serwer. |
| `start-hidden.vbs` | Uruchamia `server.js` bez widocznego okna konsoli (używany przez skrót autostartu Windows). |
| `install.sh` | Instalator dla macOS — ustawia port, rejestruje LaunchAgent dla cichego autostartu, uruchamia serwer. |
| `INSTRUCTIONS_EN.md` / `INSTRUCTIONS_PL.md` | Pełna instrukcja instalacji dla użytkowników nietechnicznych, po angielsku i po polsku. |

### Wymagania

- [Node.js](https://nodejs.org) (LTS)
- Google Chrome
- Windows lub macOS
