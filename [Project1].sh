if test $# -eq 0
then 
echo "hata dosya adi giriniz"
exit 1;
fi

dosya=$1;

if test ! -f $dosya
then
echo "boyle bir dosya yok"
exit 1;
fi

if test $# -gt 2
then
echo "fazla arguman girildi"
exit 1;
fi

if [ "$2" = "-h" ]
then
awk 'BEGIN{FS=""}{for(i=1;i<=NF;i++)c++}END{print "harf sayisi :"c}' "$dosya"
elif [ "$2" = "-k" ]
then
awk 'BEGIN{FS="[^a-zA-Z]+"}{for(i=1;i<=NF;i++){words[word]++}}END{for(w in words) printf("kelime sayisi :%s\n",words[w],w)}' "$dosya"
elif [ "$2" = "-s" ]
then
awk 'BEGIN{FS="\n"}{for(i=1;i<=NF;i++)c++}END{print "satir sayisi :"c}' "$dosya"
else
echo "hatalı arguman"
fi

