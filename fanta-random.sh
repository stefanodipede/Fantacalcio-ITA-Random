#!/bin/bash -e
#TODO Crediti
LISTA="calciatori.csv";
LISTAORIG="calciatori-orig.csv";
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
DISPONIBILI=$(cat $LISTA | cut -d ";" -f 5 |grep 0 |wc -l);
OPTION="$1"
DIRBACKUP="backup"
DATA=$(date +%Y-%m-%d-%H:%M);
DIRSQUADRE="squadre"
PLAYER1="Alfredo";
PLAYER2="Francesco";
PLAYER3="Lorenzo";
PLAYER4="Patrizio";
PLAYER5="StefanoDP";
PLAYER6="StefanoDezi";

#TODO Istruzioni
function option {
if [[ -v OPTION ]]; then

	case $OPTION in
	    -P|--portieri)
	    echo "Asta Portieri";
	    portieri
	    ;;
	    -D|--difensori)
	    echo "Asta Difensori"
	    difensori
	    ;;
	    -C|--centrocampisti)
	    echo "Asta Centrocampisti"
	    centrocampisti
	    ;;
	    -A|--attaccanti)
	    echo "Asta Attaccanti"
	    attaccanti
	    ;;
	    -Q|--qualsiasi)
	    echo "Asta Random"
	    qualsiasi
	    ;;
	    -h|--help)
	    echo "Stampa HELP"
	    ;;
	    -R|--RESET)
	    echo "Azzero le squadre e le chiamate"
	    azzera_chiamate
	    ;;
	    *)    # unknown option
	    echo "Opzione non valida. Stampa HELP"
	    ;;
	esac
else
	echo "Opzione Mancante. Stampa HELP"
	exit 1
fi
}



function inizio {
	if [ ! -d "$DIRBACKUP" ]; then
		mkdir $DIRBACKUP
	fi
	if [ ! -d "$DIRSQUADRE" ]; then
		mkdir $DIRSQUADRE
	fi
	cp $LISTA $DIRBACKUP/$LISTA-backup-$DATA
	sed -i -e "s/ \*//g" $LISTA
	sed -i -e "s/'//g" $LISTA
	if [ ! -f $DIRSQUADRE/$PLAYER1.csv ]; then
		touch $DIRSQUADRE/$PLAYER1.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/$PLAYER1.csv
	fi
	if [ ! -f $DIRSQUADRE/$PLAYER1.csv ]; then
		touch $DIRSQUADRE/$PLAYER2.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/$PLAYER2.csv
	fi
	if [ ! -f $DIRSQUADRE/$PLAYER1.csv ]; then
		touch $DIRSQUADRE/$PLAYER3.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/$PLAYER3.csv
	fi
	if [ ! -f $DIRSQUADRE/$PLAYER1.csv ]; then
		touch $DIRSQUADRE/$PLAYER4.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/$PLAYER4.csv
	fi
	if [ ! -f $DIRSQUADRE/$PLAYER1.csv ]; then
		touch $DIRSQUADRE/$PLAYER5.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/$PLAYER5.csv
	fi
	if [ ! -f $DIRSQUADRE/$PLAYER1.csv ]; then
		touch $DIRSQUADRE/$PLAYER6.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/$PLAYER6.csv
	fi
}

#Portieri
function portieri {
while [ $DISPONIBILI -gt 1 ]
do
	CASUAL=$(shuf -n 1 $LISTA);
	if [[ "$CASUAL" == P* ]] && [[ "$CASUAL" == *0 ]]; then 
		PORDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "P;0" |wc -l);
		echo -e "Portieri da chiamare: $YELLOW$PORDISPONIBILI$NC"
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC"
		venduto
	fi
done
}

#Difensori
function difensori {
while [ $DISPONIBILI -gt 1 ]
do
	CASUAL=$(shuf -n 1 $LISTA);
	if [[ "$CASUAL" == D* ]] && [[ "$CASUAL" == *0 ]]; then 
		DIFDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "D;0" |wc -l);
		echo -e "Difensori da chiamare: $YELLOW$DIFDISPONIBILI$NC"
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC"
		venduto
	fi
done
}

#Centrocampisti
function centrocampisti {
while [ $DISPONIBILI -gt 1 ]
do
	CASUAL=$(shuf -n 1 $LISTA);
	if [[ "$CASUAL" == C* ]] && [[ "$CASUAL" == *0 ]]; then 
                CENDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "C;0" |wc -l);
                echo -e "Centrocampisti da chiamare: $YELLOW$CENDISPONIBILI$NC"
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC"
		venduto
	fi
done
}


#Attaccanti
function attaccanti {
while [ $DISPONIBILI -gt 1 ]
do
	CASUAL=$(shuf -n 1 $LISTA);
	if [[ "$CASUAL" == A* ]] && [[ "$CASUAL" == *0 ]]; then 
		ATTDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "A;0" |wc -l);
		echo -e "Attaccanti da chiamare: $YELLOW$ATTDISPONIBILI$NC"
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC"
		venduto
	fi
done
}

#Tutti i ruoli
function qualsiasi {
while [ $DISPONIBILI -gt 1 ]
do
        CASUAL=$(shuf -n 1 $LISTA);
        if [[ "$CASUAL" == *0 ]]; then
		DISPONIBILI=$(cat $LISTA | cut -d ";" -f 5 |grep 0 |wc -l);
                echo -e "Giocatori da chiamare: $YELLOW$DISPONIBILI$NC"
                POS=$(echo $CASUAL | cut -d ";" -f 1)
                NOME=$(echo $CASUAL | cut -d ";" -f 2)
                SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
                VAL=$(echo $CASUAL | cut -d ";" -f 4)
                echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC"
                venduto
	fi
done
}


function azzera_chiamate {
	echo -e "Sto per resettare le chiamate, le squadre e la lista dei giocatori. Sei sicuro? (S)ì/(N)o"
	read  -${BASH_VERSION+e}r AZZERA
	        case $AZZER in
			y|Y|Yes|yes|YES|Si|Sì|si|sì|s|S|SI)
				sed -i -e 's/.$/0/g' $LISTA
				rm -f $DIRSQUADRE/$PLAYER1.csv
				rm -f $DIRSQUADRE/$PLAYER2.csv
				rm -f $DIRSQUADRE/$PLAYER3.csv
				rm -f $DIRSQUADRE/$PLAYER4.csv
				rm -f $DIRSQUADRE/$PLAYER5.csv
				rm -f $DIRSQUADRE/$PLAYER6.csv
				cp $LISTAORIG $LISTA
				;;
			No|NO|N|n)
				echo -e "Ok. Esco."
				exit 1
				;;
		esac
}

function venduto {
echo -e "Il giocatore è stato venduto?"

read -${BASH_VERSION+e}r VENDUTO

case $VENDUTO in
    Si|Sì|S|s|Y|y|Yes|yes)
        echo 'Sì. è stato venduto'

	echo -e "Chi ha acquistato il giocatore?"
	echo -e "(A)lfredo, (F)rancesco, (L)orenzo, (P)atrizio, (S)tefanoDP, StefanoDe(Z)i"
	read  -${BASH_VERSION+e}r PLAYER
	case $PLAYER in
		A|a)
			echo -e "Per quanti Fantamilioni?"
			read -${BASH_VERSION+e}r FM
			echo -e "$GREEN$NOME$NC venduto a: $RED$PLAYER1$NC per $CYAN$FM$NC fantamilioni"
			echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/$PLAYER1.csv
 			sed -i "/$CASUAL/d" $LISTA
        		;;
		F|f)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED$PLAYER2$NC per $CYAN$FM$NC fantamilioni"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/$PLAYER2.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		L|l)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED$PLAYER3$NC per $CYAN$FM$NC fantamilioni"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/$PLAYER3.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		P|p)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED$PLAYER4$NC per $CYAN$FM$NC fantamilioni"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/$PLAYER4.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		S|s)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED$PLAYER6$NC per $CYAN$FM$NC fantamilioni"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/$PLAYER5.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		Z|z)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED$PLAYER5$NC per $CYAN$FM$NC fantamilioni"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/$PLAYER6.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		*)
                        echo -e "Scelta non valida. Rimetto $NOME sul mercato."
        		;;
	esac
        ;;
    No|no|N|n)
        sed -i -e "s/$CASUAL/$POS\;$NOME\;$SQUADRA\;$VAL\;1/g" $LISTA
        echo -e 'No, vado avanti'
        ;;
    *)
        sed -i -e "s/$CASUAL/$POS\;$NOME\;$SQUADRA\;$VAL\;1/g" $LISTA
        echo -e "Scelta non valida. Vado avanti"
esac
}

#function asta {
#until [ "$DISPONIBILI" -lt 1 ]; do
#	echo $DISPONIBILI
#	portieri
#done
#}


inizio
option
