@echo off
set "SRC=%~1"
set "DEST=%~2"
for %%F in ("%SRC%") do set "FolderName=%%~nxF"
set "DEST=%DEST%\%FolderName%"
if "%SRC%"=="" (
    echo Error: Source directory not provided.
    exit /b 1
)
if "%DEST%"=="" (
    echo Error: Destination directory not provided.
    exit /b 1
)
robocopy "%SRC%" "%DEST%" /E /MT:16 /R:1 /W:1
echo Copy operation completed.
