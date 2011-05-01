#!/bin/bash
IN=input/TechnicanExtraPool.txt
OUT=decks/TechnicanExtraPool.xml
rm -f $OUT
echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>" >> $OUT
echo "<mnemosyne core_version=\"1\">" >> $OUT
awk -f scripts/parse-categorys.awk $IN >> $OUT
awk -f scripts/parse-question-pool.awk $IN >> $OUT
echo "</mnemosyne>" >> $OUT

