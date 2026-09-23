# Voice Dictation — installation instructions

This is a small tool called "VoiceDictation" that lets you dictate text out loud in Chrome and have it copied to your clipboard automatically.

VoiceDictation:
- uses Chrome's built-in speech recognition, which sends your voice recording to Google's servers to convert it to text — this requires an internet connection,
- is completely free.

You don't need any programming knowledge to install it. Just follow the steps below in order.

These instructions cover both **Windows** and **Mac** — in Steps 2-4, follow the section for your system.

## Step 1 — Unzip the folder

**Windows:**
1. Find the `.zip` file you downloaded (e.g. on your Desktop or in Downloads).
2. Right-click it and choose **"Extract All..."**.
3. Choose a location you'll remember (Desktop is fine) and click **Extract**.

**Mac:**
1. Find the `.zip` file you downloaded (e.g. on your Desktop or in Downloads).
2. Double-click it — macOS unzips it automatically into a folder with the same name, right next to it.

Once unzipped, open the new folder — you should see files like `index.html`, `server.js`, `install.ps1` (Windows) / `install.sh` (Mac).

### Important
Keep this folder where it is — don't move it after installing, since the shortcut/autostart entry created in the next step points to this exact location.

If you do move the folder anyway, automatic startup on login will stop working (the old entry will point to a location that no longer exists) — the tool itself can still be started manually though. To fix autostart, just repeat Step 4 from the folder's new location — it will overwrite the autostart entry with the current path.

## Step 2 — Install Node.js (one-time)

This tool needs a program called Node.js to run. If you already have it, skip to Step 3.

If you don't:
1. Go to [nodejs.org](https://nodejs.org) and click the big green button to download the **LTS** version (the site detects whether you're on Windows or Mac automatically).
2. Open the downloaded installer and click **Next**/**Continue** through all the steps, keeping the default options, then **Install** and **Finish**/**Close**.
3. **Windows:** restart your computer. This is important — without it, Windows won't know where to find Node.js yet.
   **Mac:** no restart needed — just close and reopen your Terminal window if it was already open.

## Step 3 — Open a terminal in the folder

**Windows (PowerShell):**
1. Open the folder from Step 1 in File Explorer.
2. Hold **Shift** and right-click on an empty area inside the folder (not on a file).
3. Choose **"Open PowerShell window here"**. (On Windows 11, if you don't see it right away, click **"Show more options"** first.)

If you can't find that option at all:
1. Click the Windows **Start** menu, type `PowerShell`, and open it.
2. Type `cd "` then drag the folder from Step 1 into the PowerShell window (this pastes its path), then type `"` and press **Enter**.

**Mac (Terminal):**
1. Open the folder from Step 1 in Finder.
2. Right-click (or Ctrl+click) on an empty area inside the folder and choose **"New Terminal at Folder"**.

If you don't see that option:
1. Open the **Terminal** app (Launchpad → type "Terminal").
2. Type `cd ` (with a trailing space), drag the folder from Step 1 into the Terminal window (this pastes its path), then press **Enter**.

## Step 4 — Run the installer

**Windows:** in the PowerShell window, type this and press **Enter**:

```powershell
.\install.ps1
```

**If you see a red error mentioning "running scripts is disabled on this system"** — this is normal and expected the first time; Windows blocks scripts by default. Just run this instead:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

**Mac:** in the Terminal window, type this and press **Enter**:

```bash
bash install.sh
```

**If you see "Permission denied"** — this is normal the first time, the file doesn't have execute permission yet. Run:

```bash
chmod +x install.sh
```

then `bash install.sh` again.

Either way (Windows and Mac), if it worked you'll see a few lines of text ending with something like:

```
Server started now. To remove autostart, ...
```

That means it's installed and already running. You can close the terminal window now — the tool keeps running in the background.

By default it uses port **7778**. You'll only need to care about this if you get a "port already in use" error (see Troubleshooting below) — in that case, re-run the installer with a different port:
- Windows: `.\install.ps1 -Port 8081`
- Mac: `bash install.sh --port 8081`

(any free port number works).

## Step 5 — Use it

1. Open **Google Chrome** and go to: `http://localhost:7778`
2. The first time, Chrome will ask for microphone access — click **Allow**.
3. Pick your language from the dropdown at the top (default is Polish).
4. Click **"Start dictation"** (or press the **Space** bar) and start talking.
5. Click **"Stop"** (or press Space again) — your text is copied to the clipboard automatically, ready to paste anywhere with **Ctrl+V** (Mac: **Cmd+V**).
6. **"Copy"** copies again manually at any time; **"Clear"** empties the text box.

That's it — from now on, the tool starts automatically every time you turn on your computer and log in. You just open `http://localhost:7778` in Chrome whenever you want to dictate.

## Troubleshooting

**"node is not recognized as the name of a command..." (Windows) / "command not found: node" (Mac)**
Node.js isn't installed yet, or (Windows) you skipped the restart in Step 2. Restart your computer (Windows) or open a new Terminal window (Mac), then try Step 4 again.

**Windows shows a blue "Windows protected your PC" screen when opening a file**
Click **"More info"**, then **"Run anyway"**. This happens because the files were downloaded from the internet, not because anything is wrong.

**Mac shows "Permission denied" on `bash install.sh`**
See Step 4 — run `chmod +x install.sh`, then `bash install.sh` again.

**Chrome shows "This site can't be reached"**
The server isn't running. Redo Step 4, and make sure it printed the "Server started now" message without errors.

**"port already in use" / "address already in use" error**
Something else on your computer is already using port 7778. Re-run the installer with a different port:
- Windows: `.\install.ps1 -Port 8081`
- Mac: `bash install.sh --port 8081`

Then use `http://localhost:8081` in Chrome instead.

**Dictation doesn't type anything**
Make sure you clicked **Allow** on the microphone permission prompt. If you missed it, click the 🔒/ⓘ icon at the left of Chrome's address bar and allow the microphone there.

On Mac, also check **System Settings → Privacy & Security → Microphone** and make sure Chrome is enabled there — allowing it inside Chrome alone may not be enough if macOS is blocking access at the system level.

## Removing it (uninstall)

**Windows:**
1. Delete this shortcut file:
   ```
   %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\VoiceDictation.lnk
   ```
   (Paste that path into File Explorer's address bar and press Enter — it'll go straight to the right file.)
2. Delete the folder you extracted in Step 1.

**Mac:**
1. In Terminal, type:
   ```bash
   launchctl unload ~/Library/LaunchAgents/com.voicedictation.server.plist
   rm ~/Library/LaunchAgents/com.voicedictation.server.plist
   ```
2. Delete the folder you extracted in Step 1.

That fully removes the tool; nothing else was installed on your system except Node.js, which you can keep or remove separately if you no longer need it.
