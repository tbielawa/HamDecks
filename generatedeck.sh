#!/bin/bash

mkdir tmp
for DECK in Technician General Extra; do
  IN=input/$DECK.txt
  TMP=tmp/$DECK.txt
  OUT=decks/$DECK.xml
  rm -f $TMP $OUT
  scripts/stripchars.sh < $IN > $TMP
  echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>" >> $OUT
  echo "<mnemosyne core_version=\"1\">" >> $OUT
  awk -f scripts/parse-categorys.awk $TMP >> $OUT
  awk -f scripts/parse-question-pool.awk $TMP >> $OUT
  echo "</mnemosyne>" >> $OUT
  rm -f $TMP
done
rmdir tmp
