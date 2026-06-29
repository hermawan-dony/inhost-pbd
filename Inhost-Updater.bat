@echo off
color 0A
title Inhost Auto Updater

echo ==========================================
echo  Inhost Client Updater
echo ==========================================
echo.

set GITHUB_RAW=https://raw.githubusercontent.com/hermawan-dony/inhost-pbd/main

call :DownloadFile bcapp.pbd
echo.
call :DownloadFile custom.pbd
echo.
call :DownloadFile ceisa.pbd
echo.

echo ==========================================
echo Update Selesai! Semua file siap digunakan.
echo ==========================================
pause
exit /b

:DownloadFile
set FILENAME=%1
echo [Cek Update] %FILENAME% ...

rem Mengecek apakah file etag lokal ada, lalu download secara kondisional
if exist "%FILENAME%.etag" (
    curl.exe -# --etag-compare "%FILENAME%.etag" --etag-save "%FILENAME%.etag" -L -O "%GITHUB_RAW%/%FILENAME%"
) else (
    curl.exe -# --etag-save "%FILENAME%.etag" -L -O "%GITHUB_RAW%/%FILENAME%"
)

if %errorlevel% neq 0 (
    echo [Gagal] Terjadi kesalahan saat memeriksa/mendownload %FILENAME%.
)
exit /b
