@echo off

rem Autor:        LetsBash.de
rem Date:         28.12.2021

rem Warranty:     This script comes without any warranty and in the state as it is.

rem Installation: You basicly need the vanilla Stardew Valley in your "steamcommon" folder named as 
rem               "Stardew Valley" (this is the default) and additionally your modded version also 
rem               in the "steamcommon" common directory 2 times named "Stardew Valley Mod" and
rem               "Stardew Valley Mod Backup".
rem               After you have to define your steamcommon directory below.

rem How to use:   1. Launch this scriptfile and leave the window open. (Window should say run game by steam)
rem               2. Launch the game by steam with the known startup option 
rem                  (eg. "D:\SteamLibrary\steamapps\common\Stardew Valley\StardewModdingAPI.exe" %command%)
rem               3. Play with your modded version of Stardew Valley
rem               4. Exit Stardew Valley as usual and let the window of this script still open
rem               5. The script detects automaticly that you closed the window and will cleanup any folder renamings

rem ** Edit this line and set the path to your steamapps\common directory **
set "steamcommon=D:\SteamLibrary\steamapps\common"

:main
echo.
echo Bashys Stardew Valley Switcher by LetsBash.de
echo ---------------------------------------------
echo.
if exist "%steamcommon%\Stardew Valley\Mods" goto isMod
goto isVanilla

:isMod
if not exist "%steamcommon%\Stardew Valley Vanilla" goto noVanilla
ren "%steamcommon%\Stardew Valley" "Stardew Valley Mod"
ren "%steamcommon%\Stardew Valley Vanilla" "Stardew Valley"
echo DE Aktion: Stardew Valley wurde in den Urspungszustand ohne mods zurueck versetzt
echo EN Action: Stardew Valley was set back into the original state without any mods
echo.
goto end

:noVanilla
ren "%steamcommon%\Stardew Valley" "Stardew Valley Mod"
echo DE Fehler: Mods sind installiert, aber es gibt kein Vanilla Stardew Valley.
echo EN Error:  Mods are installed but there is no vanilla Stardew Valley folder present.
echo.
echo DE Empfehlung:     Steam neustarten und neu runterladen
echo EN Recommendation: Restart steam and download a vanilla copy of the game
echo.
goto end

:isVanilla
if not exist "%steamcommon%\Stardew Valley Mod" goto noMod
ren "%steamcommon%\Stardew Valley" "Stardew Valley Vanilla"
ren "%steamcommon%\Stardew Valley Mod" "Stardew Valley"
echo DE Aktion: Mods aktiviert
echo EN Action: Mods activated
echo.
echo DE Wichtig:   Starte jetzt das Spiel ueber Steam und lass dieses Fenster offen
echo EN Important: Run the game by steam and leave this window open
echo.
goto wait

:wait
timeout /t 5 1> nul 2>nul
tasklist /FI "IMAGENAME eq StardewModdingAPI.exe" | find /i "StardewModdingAPI.exe" 1>nul 2>nul
if %ERRORLEVEL% GEQ 1 goto wait
echo DE Aktion: Spiel gefunden
echo EN Action: Game found
echo.
goto scan

:scan
timeout /t 10 1> nul 2>nul
tasklist /FI "IMAGENAME eq StardewModdingAPI.exe" | find /i "StardewModdingAPI.exe" 1>nul 2>nul
if %ERRORLEVEL% LSS 1 goto scan
goto isMod

:noMod
echo DE Fehler: Es sind keine Mods vorhanden...
echo EN Error:  There are no mods present...
echo.
echo DE Aktion: Backup wird geladen...
echo EN Action: Try to recover by backup...
echo.
if not exist "%steamcommon%\Stardew Valley Mod Backup" goto end
robocopy "%steamcommon%\Stardew Valley Mod Backup" "%steamcommon%\Stardew Valley Mod" /e /copy:dat /r:1 /w:1
goto end

:end
echo.
timeout /t 15
