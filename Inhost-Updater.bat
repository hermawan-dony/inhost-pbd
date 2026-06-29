@echo off
color 0B
title Inhost Auto Updater

echo.
echo  ======================================================
echo    ___ _   _ _   _  ___  ____ _____ 
echo   ^|_ _^| \ ^| ^| ^| ^| ^|/ _ \/ ___^|_   _^|
echo    ^| ^|^|  \^| ^| ^|_^| ^| ^| ^| \___ \ ^| ^|  
echo    ^| ^|^| ^|\  ^|  _  ^| ^|_^| ^|___) ^|^| ^|  
echo   ^|___^|_^| \_^|_^| ^|_^|\___/^|____/ ^|_^|  
echo.
echo     [ Client Auto-Updater System ]
echo  ======================================================
echo.

echo  --^> Menutup aplikasi yang berjalan agar update aman...
for %%F in ("%~dp0*.exe") do (
    taskkill /IM "%%~nxF" /F >nul 2>&1
)
echo.

set GITHUB_RAW=https://raw.githubusercontent.com/hermawan-dony/inhost-pbd/main

call :DownloadFile "bcapp.pbd"
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

set HTTP_STATUS=
if exist "%FILENAME%.etag" (
    for /f "tokens=2" %%A in ('curl.exe -s -I --etag-compare "%FILENAME%.etag" -L "%GITHUB_RAW%/%FILENAME%" ^| findstr "HTTP/"') do set HTTP_STATUS=%%A
)

if "%HTTP_STATUS%"=="304" (
    echo      -^> Sudah Up to Date
) else (
    curl.exe -# --etag-save "%FILENAME%.etag" -L -O "%GITHUB_RAW%/%FILENAME%" ^|^| echo      [x] Gagal mendownload %FILENAME%. Silakan cek koneksi internet!
)
exit /b
