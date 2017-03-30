counter=0
N=10
gecenler=0
ortalama_toplami=0
kalanlar=0

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

if test $# -gt 1
then
echo "fazla arguman girildi"
exit 1;
fi

cat  $dosya | { while read p1 p2 p3
do
##echo $p1   $p2   $p3
ortalama=$((p2+p3))
ortalama=$(echo "var=$ortalama;scale=2;var/2" | bc  )
##echo $ortalama
if [ $(echo "var=$ortalama;scale=2;var>=35" | bc  ) -eq 1 ]
then
gecenler=$((gecenler+1))
ortalama_toplami=$(echo "var=$ortalama;scale=2;var+($ortalama_toplami)" | bc  )
else
kalanlar=$((kalanlar+1))
fi
##echo gecenler $gecenler
##echo kalanlar $kalanlar
##echo ortalamaların toplamı $ortalama_toplami
done
##echo $gecenler $kalanlar $ortalama_toplami
gecenlerin_ortalamasi=$(echo "var=$ortalama_toplami;scale=2;var/($gecenler)" | bc )
##echo gecenlerin ortalamasi :  $gecenlerin_ortalamasi
##echo --------------------------------------------------------
	sapma=0
	sapma2_toplami=0
	cat $dosya |{ while read p1 p2 p3
	do
	ortalama2=$((p2+p3))
	ortalama2=$(echo "var=$ortalama2;scale=2;var/2" | bc  )
	if [ $(echo "var=$ortalama;scale=2;var>=35" | bc  ) -eq 1 ]
	then
	##echo ogrenci ortalmasi $ortalama2
	sapma=$(echo "scale=2;($ortalama2)-($gecenlerin_ortalamasi)" | bc )
	##echo  sapma $sapma
	sapma=$(echo "scale=2;($sapma)*($sapma)" | bc )
	sapma2_toplami=$(echo "scale=2;($sapma2_toplami)+($sapma)" | bc )
	##echo sapma*sapma $sapma
	##echo sapmaların toplamı $sapma2_toplami
	fi
	done
	##echo sapmaların toplamı $sapma2_toplami
	gecenler_eksi_1=$((gecenler-1))
	islem=$(echo "scale=2;($sapma2_toplami)/($gecenler_eksi_1)" | bc )
	##echo bolu n-1 sonucu $islem
	
	islem=$(echo "var=$islem;scale=2;sqrt(var)" | bc  )

	##echo karekok sonucu $islem
	##echo standart sapma bulundu :  $islem
	standart_sapma=$islem
	islem=$(echo "var=$islem;scale=2;var*1.645" | bc  )
	##echo carpılımıs  standart sapma $islem
	baraj=$(echo "var1=$islem;var2=$gecenlerin_ortalamasi;scale=2;var2-var1" | bc  )
	
	##echo baraj bulundu $baraj
	
	if [ $gecenler -lt 10 ]
	then
	baraj=45
	elif [ $(echo "var=$standart_sapma;scale=2;var<8" | bc  ) -eq 1 ]
	then
	baraj=45
	fi
	gecenOgrenciSayisi=0
	kalanOgrenciSayisi=0
	##echo baraj ayarlandı : $baraj

		ortalma3=0;
		cat $dosya |{ while read p1 p2 p3
		do
		ortalama3=$((p2+p3))
		ortalama3=$(echo "var=$ortalama3;scale=2;var/2" | bc  )
		if [ $(echo "var=$ortalama3;scale=2;var>=($baraj)" | bc ) -eq 1 ]
		then
			if [ $p3 -gt 45 ]
			then
			##echo $p1 adliogrenci dersi gecti
			gecenOgrenciSayisi=$((gecenOgrenciSayisi+1))
			elif [ $p3 -eq 45 ]
			then
			##echo $p1 adliogrenci dersi gecti
			gecenOgrenciSayisi=$((gecenOgrenciSayisi+1))
			else
			##echo $p1 adliogrenci bu dersten kaldi
			kalanOgrenciSayisi=$((kalanOgrenciSayisi+1))
			fi
		else
		##echo $p1 adliogrenci bu dersten kaldi
		kalanOgrenciSayisi=$((kalanOgrenciSayisi+1))
		fi
		done
		echo gecen ogrenci sayisi : $gecenOgrenciSayisi
		echo kalan ogrenci sayisi : $kalanOgrenciSayisi
		}
	}
}
