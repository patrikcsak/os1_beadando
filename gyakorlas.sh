#!/bin/bash

file=beadandovegleges.json

help(){
cat << HELP
A program használata:
$0 [opciók]

Opciók:
 -g	Köszönés kiírása.
 -r	Random jelszógenerátor.
 -h	Ez az üzenet megjelenítése.
 -t	Kiszámolja a téglalap kerületét és területét.
 -i	Lekéri egy könyv adatát.
 -w	Kiírja a könyv adatát.
 -s	Megszűri a lekért adatot.
HELP
}

greeting(){
  echo "Hello World!"
  exit
}

randompw(){
  echo -n "Adja meg a hosszt: "
  read a
  echo -n "Adja meg a darabszámot: "
  read b
  pwgen -sy $a $b
  exit
}

konyv(){
 curl https://nameday.abalin.net/api/V1/today -H "Accept: application/json" -o $file -s
 echo "Adatok letöltve."
}

write(){
 cat $file | jq
}

szuro(){
 curl https://nameday.abilin.net/api/V1/today -H "Accept: application/json" | jq.nameday.hu | tr -d \"
}

terker(){
 echo -n "a olda:"
 read a
 echo -n "b oldal:"
 read b
 
 T=`expr $a \* $b`
 x=`expr $a + $b`
 K=`expr 2 \* $x`
 
 echo "A téglalap területe: $T"
 echo "A téglalap kerülete: $K"
}

while getopts :grhtwsi  PARAM
do
 case $PARAM in
  g)
   greeting
   ;;
  r)
   randompw
   ;;
  t)
   terker
   ;;
  h)
   help
   ;;
  i)
   konyv
   ;;
  w)
   write
   ;;
  s)
   szuro
   ;;
  :)
   echo "A(z) -$OPTARG vár értéket."
   echo "Használati útmutató kiírásához használja a következő parancsot:"
   echo "$0 -h"
   ;;
  *)
   echo "Érvénytelen argumentum."
   echo "Használati útmutató kiírásához használja a következő parancsot:"
   echo "$0 -h"
   ;;
 esac
done

if [  $# -eq 0 ]
then
 help
fi
