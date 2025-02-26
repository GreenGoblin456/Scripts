set DATE=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2% 
robocopy "Source Slozka" "Cilova Složka" *.* /MIR /Z /NP /R:1 /W:1 /IS /IT /LOG:Slozka Pro Logy\backup-%DATE%.log