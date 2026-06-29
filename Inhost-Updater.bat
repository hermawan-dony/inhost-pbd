@echo off
color 0B
echo ==========================================
echo  Inhost Client Updater 
echo ==========================================
echo.

set GITHUB_RAW=https://raw.githubusercontent.com/hermawan-dony/inhost-pbd/main

echo [Mendownload] bcapp.pbd ...
curl -L -O -# %GITHUB_RAW%/bcapp.pbd

echo.
echo [Mendownload] custom.pbd ...
curl -L -O -# %GITHUB_RAW%/custom.pbd

echo.
echo [Mendownload] ceisa.pbd ...
curl -L -O -# %GITHUB_RAW%/ceisa.pbd

echo.
echo ==========================================
echo Semua file PBD telah berhasil diperbarui!
echo ==========================================
 
