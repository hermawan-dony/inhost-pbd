@echo off
color 0B
title Inhost Auto Updater

echo.
echo  ======================================================
echo     ___       _               _     
echo    ^|_ _^|____ ^| ^|__   ___  ___^| ^|_   
echo     ^| ^|/ _ \^| '_ \ / _ \/ __^| __^|  
echo     ^| ^|  __/^| ^| ^| ^| (_) \__ \ ^|_   
echo    ^|___\___^|_^| ^|_^|\___/^|___/\__^|  
echo.
echo     [ Client Auto-Updater System ]
echo  ======================================================
echo.

set GITHUB_RAW=https://raw.githubusercontent.com/hermawan-dony/inhost-pbd/main

call :DownloadFile "bcapp.pbd"
echo.
call :DownloadFile "custom.pbd"
echo.
call :DownloadFile "ceisa.pbd"
echo.

echo  ======================================================
echo   [!] Update Selesai! Semua file siap digunakan.
echo  ======================================================
echo.
pause
exit /b

:DownloadFile
set FILENAME=%~1
echo  --^> Memeriksa [ %FILENAME% ] ...

rem Mengecek apakah file etag lokal ada, lalu download secara kondisional
if exist "%FILENAME%.etag" (
    curl.exe -# --etag-compare "%FILENAME%.etag" --etag-save "%FILENAME%.etag" -L -O "%GITHUB_RAW%/%FILENAME%"
) else (
    curl.exe -# --etag-save "%FILENAME%.etag" -L -O "%GITHUB_RAW%/%FILENAME%"
)

if %errorlevel% neq 0 (
    echo      [x] Gagal mendownload %FILENAME%. Silakan cek koneksi internet!
)
exit /b
