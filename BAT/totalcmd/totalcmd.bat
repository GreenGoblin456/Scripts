@echo off
set /p cesta=<file.txt
    setlocal
    set "totalc=C:\Program Files\totalcmd\TOTALCMD.EXE"
    set "folder=%cesta%"
    start "" "%totalc%" /T /R="%folder%"
exit