#!/bin/bash

# Cílový adresář, kde jsou složky, které se mají kontrolovat
ZAKLADNI_ADRESAR="/cesta/k/slozce"

# Najdi všechny složky starší než 3 dny v základním adresáři
find "$ZAKLADNI_ADRESAR" -mindepth 1 -maxdepth 1 -type d -mtime +3 | while read -r SLOZKA
  do
    # Kontrola existence souboru cesta.txt uvnitř složky
    SOUBOR_CESTA="$SLOZKA/cesta.txt"
    if [ -f "$SOUBOR_CESTA" ]; then
      # Načti cílovou cestu ze souboru cesta.txt
      CILOVA_CESTA=$(head -n 1 "$SOUBOR_CESTA")

      # Odstraň poslední část cesty (poslední složku nebo název)
      CILOVA_CESTA_BEZ_POSLEDNI="${CILOVA_CESTA%/*}/"

      # Vytvoř cílovou cestu pokud neexistuje
      mkdir -p "$CILOVA_CESTA_BEZ_POSLEDNI"

      # Zkopíruj složku do cílové cesty (rekurzivně a zachování atributů)
      cp -a "$SLOZKA" "$CILOVA_CESTA_BEZ_POSLEDNI"

      echo "Složka $SLOZKA zkopírována do $CILOVA_CESTA_BEZ_POSLEDNI"
    else
      echo "Soubor cesta.txt nenalezen ve složce $SLOZKA"
    fi
  done
