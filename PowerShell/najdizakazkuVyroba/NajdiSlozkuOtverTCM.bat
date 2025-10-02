@echo off
setlocal enabledelayedexpansion

:: === CONFIGURATION ===
set "startDir=S:\Vyroba"
set "totalCmdPath=C:\Program Files\totalcmd\TOTALCMD64.EXE"
set "tempList=%TEMP%\numbered_folders.txt"

:: === USER INPUT ===
set /p subfolderName=Zadej cislo zakazky: 

:: === CLEANUP TEMP ===
if exist "%tempList%" del "%tempList%"

:: === GENERATE SORTABLE LIST USING POWERSHELL ===
powershell -NoLogo -NoProfile -Command ^
    "Get-ChildItem -Path '%startDir%' -Directory | Where-Object { $_.Name -match '^\d+' } | ForEach-Object { [PSCustomObject]@{ Num = [int]($_.Name -replace '[^\d].*',''); Path = $_.FullName } } | Sort-Object Num -Descending | ForEach-Object { $_.Path }" > "%tempList%"

:: === CHECK FOR RESULTS ===
if not exist "%tempList%" (
    echo No numbered folders found in %startDir%.
    pause
    exit /b
)

:: === SEARCH FOR SUBFOLDER IN ORDER ===
set "foundPath="
for /f "usebackq delims=" %%F in ("%tempList%") do (
    if exist "%%F\%subfolderName%" (
        set "foundPath=%%F\%subfolderName%"
        goto :found
    )
)

:found
if defined foundPath (
    echo Opening "!foundPath!" in Total Commander...
    call "%totalCmdPath%" /O /L="!foundPath!"
    exit
) else (
    echo Subfolder "%subfolderName%" not found in any numbered folder.
)

:: === CLEANUP ===
if exist "%tempList%" del "%tempList%"
endlocal
pause
