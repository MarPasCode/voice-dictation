# Dyktowanie głosowe — instrukcja instalacji

To małe narzędzie "VoiceDictation", które pozwala dyktować tekst na głos w Chrome, otrzymać transkrypcję i automatycznie skopiować treść do schowka.

VoiceDictation:
- korzysta z wbudowanej funkcji Chrome, która wysyła nagranie głosu na serwery Google w celu zamiany na tekst — wymaga to połączenia z internetem
- jest całkowicie darmowe.

Nie potrzebujesz żadnej wiedzy programistycznej, żeby to zainstalować. Wystarczy wykonać poniższe kroki po kolei.

Instrukcja obejmuje **Windows** i **Mac** — w krokach 2-4 wybierz sekcję dla swojego systemu.

## Krok 1 — Rozpakuj folder

**Windows:**
1. Znajdź plik `.zip`, który pobrałeś/aś (np. na Pulpicie albo w Pobranych).
2. Kliknij go prawym przyciskiem myszy i wybierz **"Wyodrębnij wszystko..."** (lub "Extract All...").
3. Wybierz lokalizację, którą łatwo zapamiętasz (Pulpit jest ok) i kliknij **Wyodrębnij**.

**Mac:**
1. Znajdź plik `.zip`, który pobrałeś/aś (np. na Pulpicie albo w Pobranych).
2. Kliknij go dwukrotnie — macOS rozpakuje go automatycznie do folderu o tej samej nazwie, w tym samym miejscu.

Po rozpakowaniu otwórz nowy folder — powinieneś/aś zobaczyć pliki takie jak `index.html`, `server.js`, `install.ps1` (Windows) / `install.sh` (Mac).

### Ważne
Zostaw ten folder tam, gdzie jest — nie przenoś go po instalacji, ponieważ skrót/autostart utworzony w kolejnym kroku wskazuje dokładnie na tę lokalizację.

Jeśli mimo to przeniesiesz folder, automatyczne uruchamianie po zalogowaniu przestanie działać (stary wpis będzie wskazywał na nieistniejącą już ścieżkę) — samo narzędzie da się jednak nadal uruchomić ręcznie. Aby naprawić autostart, po prostu powtórz Krok 4 z nowej lokalizacji folderu — nadpisze to wpis autostartu na aktualną ścieżkę.

## Krok 2 — Zainstaluj Node.js (jednorazowo)

To narzędzie potrzebuje programu o nazwie Node.js, żeby działać. Jeśli już go masz, przejdź od razu do Kroku 3.

Jeżeli nie masz to:
1. Wejdź na [nodejs.org](https://nodejs.org) i kliknij duży zielony przycisk, żeby pobrać wersję **LTS** (strona sama rozpozna, czy jesteś na Windows czy Mac).
2. Otwórz pobrany instalator i klikaj **Dalej**/**Continue** przez wszystkie kroki, zostawiając domyślne opcje, a następnie **Zainstaluj**/**Install** i **Zakończ**/**Close**.
3. **Windows:** uruchom ponownie komputer. To ważne — bez tego Windows nie będzie jeszcze wiedział, gdzie znaleźć Node.js.
   **Mac:** restart nie jest potrzebny — wystarczy zamknąć i otworzyć nowe okno Terminala, jeśli było już otwarte.

## Krok 3 — Otwórz terminal w folderze

**Windows (PowerShell):**
1. Otwórz folder z Kroku 1 w Eksploratorze plików.
2. Przytrzymaj **Shift** i kliknij prawym przyciskiem myszy na pustym miejscu wewnątrz folderu (nie na pliku).
3. Wybierz **"Otwórz tutaj okno PowerShell"** (lub "Open PowerShell window here"). (Na Windows 11, jeśli nie widzisz tej opcji od razu, kliknij najpierw **"Pokaż więcej opcji"**.)

Jeśli w ogóle nie widzisz tej opcji:
1. Kliknij menu **Start** Windows, wpisz `PowerShell` i otwórz go.
2. Wpisz `cd "`, następnie przeciągnij folder z Kroku 1 do okna PowerShell (to wklei jego ścieżkę), wpisz `"` i naciśnij **Enter**.

**Mac (Terminal):**
1. Otwórz folder z Kroku 1 w Finderze.
2. Kliknij prawym przyciskiem myszy (lub Ctrl+klik) na pustym miejscu wewnątrz folderu i wybierz **"Nowy Terminal w Folderze"** (New Terminal at Folder).

Jeśli nie widzisz tej opcji:
1. Otwórz aplikację **Terminal** (Launchpad → wpisz "Terminal").
2. Wpisz `cd ` (ze spacją na końcu), przeciągnij folder z Kroku 1 do okna Terminala (to wklei jego ścieżkę), naciśnij **Enter**.

## Krok 4 — Uruchom instalator

**Windows:** w oknie PowerShell wpisz poniższe polecenie i naciśnij **Enter**:

```powershell
.\install.ps1
```

**Jeśli zobaczysz czerwony błąd wspominający "running scripts is disabled on this system"** — to normalne i spodziewane przy pierwszym uruchomieniu; Windows domyślnie blokuje skrypty. Po prostu uruchom zamiast tego:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

**Mac:** w oknie Terminala wpisz poniższe polecenie i naciśnij **Enter**:

```bash
bash install.sh
```

**Jeśli zobaczysz "Permission denied"** — to normalne przy pierwszym uruchomieniu, plik nie ma jeszcze uprawnień do wykonywania. Wpisz:

```bash
chmod +x install.sh
```

a potem ponownie `bash install.sh`.

Tak czy inaczej (Windows i Mac), jeśli się udało, zobaczysz kilka linijek tekstu kończących się mniej więcej tak:

```
Server started now. To remove autostart, ...
```

To oznacza, że narzędzie jest zainstalowane i już działa. Możesz teraz zamknąć okno terminala — narzędzie działa dalej w tle.

Domyślnie używa portu **7778**. Musisz się tym przejmować tylko wtedy, gdy pojawi się błąd "port already in use" (patrz Rozwiązywanie problemów poniżej) — w takim wypadku uruchom ponownie instalator z innym portem:
- Windows: `.\install.ps1 -Port 8081`
- Mac: `bash install.sh --port 8081`

(dowolny wolny numer portu zadziała).

## Krok 5 — Użyj VoiceDictation

1. Otwórz **Google Chrome** i wejdź na: `http://localhost:7778`
2. Za pierwszym razem Chrome zapyta o dostęp do mikrofonu — kliknij **Zezwól**.
3. Wybierz swój język z listy rozwijanej na górze (domyślnie polski).
4. Kliknij **"Start dictation"** (lub naciśnij spację) i zacznij mówić.
5. Kliknij **"Stop"** (lub naciśnij spację ponownie) — Twój tekst zostanie automatycznie skopiowany do schowka, gotowy do wklejenia gdziekolwiek skrótem **Ctrl+V** (Mac: **Cmd+V**).
6. **"Copy"** kopiuje tekst ponownie ręcznie w dowolnym momencie, **"Clear"** czyści pole tekstowe.

To wszystko — od teraz narzędzie uruchamia się automatycznie za każdym razem, gdy włączysz komputer i się zalogujesz. Wystarczy otworzyć `http://localhost:7778` w Chrome, kiedy chcesz podyktować tekst.

## Rozwiązywanie problemów

**"node is not recognized as the name of a command..." (Windows) / "command not found: node" (Mac)**
Node.js nie jest jeszcze zainstalowany albo (na Windows) pominięto restart komputera w Kroku 2. Zrestartuj komputer (Windows) lub otwórz nowe okno Terminala (Mac) i spróbuj ponownie Krok 4.

**Windows pokazuje niebieski ekran "Windows protected your PC" przy otwieraniu pliku**
Kliknij **"More info"**, a potem **"Run anyway"**. Dzieje się tak, ponieważ pliki zostały pobrane z internetu, a nie dlatego, że coś jest nie tak.

**Mac pokazuje "Permission denied" przy `bash install.sh`**
Zobacz Krok 4 — uruchom `chmod +x install.sh`, a potem ponownie `bash install.sh`.

**Chrome pokazuje "This site can't be reached"**
Serwer nie działa. Powtórz Krok 4 i upewnij się, że wyświetlił komunikat "Server started now" bez błędów.

**Błąd "port already in use" / "address already in use"**
Coś innego na Twoim komputerze korzysta już z portu 7778. Uruchom ponownie instalator z innym portem, np.:
- Windows: `.\install.ps1 -Port 8081`
- Mac: `bash install.sh --port 8081`

Następnie użyj `http://localhost:8081` w Chrome zamiast domyślnego adresu.

**Dyktowanie nic nie wpisuje**
Upewnij się, że kliknięto **Zezwól** przy pytaniu o dostęp do mikrofonu. Jeśli to pominięto, kliknij ikonę 🔒/ⓘ po lewej stronie paska adresu Chrome i zezwól tam na mikrofon.

Na Macu dodatkowo sprawdź: **Ustawienia systemowe → Prywatność i bezpieczeństwo → Mikrofon** i upewnij się, że Chrome jest tam włączony — samo zezwolenie w Chrome może nie wystarczyć, jeśli system blokuje dostęp na poziomie macOS.

## Usuwanie (odinstalowanie)

**Windows:**
1. Usuń plik skrótu:
   ```
   %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\VoiceDictation.lnk
   ```
   (Wklej tę ścieżkę w pasek adresu Eksploratora plików i naciśnij Enter — przejdzie od razu do właściwego pliku.)
2. Usuń folder rozpakowany w Kroku 1.

**Mac:**
1. W Terminalu wpisz:
   ```bash
   launchctl unload ~/Library/LaunchAgents/com.voicedictation.server.plist
   rm ~/Library/LaunchAgents/com.voicedictation.server.plist
   ```
2. Usuń folder rozpakowany w Kroku 1.

To w pełni usuwa narzędzie; nic innego nie zostało zainstalowane w systemie poza Node.js, które możesz zachować albo usunąć osobno, jeśli nie jest już potrzebne.
