@echo off
REM Automaticke urceni smeru kopirovani podle vybrane slozky v Total Commanderu
REM Kopiruje slozku do opacneho panelu a ulozi soubor cesta.txt s informaci o puvodu

SET "src=%~1"
SET "dst=%~2"

REM Overeni, zda zdrojova slozka existuje
IF NOT EXIST "%src%" (
    ECHO Zdrojova slozka neexistuje: %src%
    PAUSE
    EXIT /B 1
)

REM Zjisti jmeno slozky bez cele cesty
FOR %%I IN ("%src%") DO SET "foldername=%%~nxI"

REM Spoj cilovou cestu s nazvem slozky
SET "dstfull=%dst%\%foldername%"

REM Vytvori cilovou slozku, pokud neexistuje
IF NOT EXIST "%dstfull%" (
    MKDIR "%dstfull%"
)

REM Kopirovani slozky
robocopy "%src%" "%dstfull%" /E /XC /XN /XO

REM Ulozeni zdrojove cesty do cesta.txt
ECHO %src% > "%dstfull%\cesta.txt"

ECHO Slozka "%foldername%" zkopirovana z:
ECHO %src%
do
ECHO %dstfull%
PAUSE
