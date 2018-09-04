#!/bin/bash -e
#Crediti: README.md

LISTA="calciatori.csv";
LISTAORIG="calciatori-orig.csv";
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
DISPONIBILI=$(cat $LISTA | cut -d ";" -f 5 |grep 0 |wc -l);
PORDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "P;0" |wc -l);
OPTION="$1"
DIRBACKUP="backup"
DATA=$(date +%Y-%m-%d-%H:%M);
DIRSQUADRE="squadre"
NPLAYER=6
PLAYER[0]="Alfredo";
PLAYER[1]="Francesco";
PLAYER[2]="Lorenzo";
PLAYER[3]="Patrizio";
PLAYER[4]="StefanoDP";
PLAYER[5]="StefanoDezi";


function option {
if [[ -v OPTION ]]; then

	case $OPTION in
	    -P|--portieri)
	    echo -e "$RED""Asta Portieri$NC";
	    portieri
	    ;;
	    -D|--difensori)
	    echo -e "$RED""Asta Difensori$NC"
	    difensori
	    ;;
	    -C|--centrocampisti)
	    echo -e "$RED""Asta Centrocampisti$NC"
	    centrocampisti
	    ;;
	    -A|--attaccanti)
	    echo -e "$RED""Asta Attaccanti$NC"
	    attaccanti
	    ;;
	    -Q|--qualsiasi)
	    echo -e "$RED""Asta Random tutti i ruoli$NC"
	    qualsiasi
	    ;;
	    -h|--help)
	    echo -e "Stampa HELP:\n"
	    echo -e "Utilizzo:\t fanta-random.sh [opzione]\n"
	    echo -e "Opzioni:\n"
	    echo -e "-P o --portieri\t\t\t Asta portieri"
	    echo -e "-D o --difensori\t\t Asta difensori"
	    echo -e "-C o --centrocampisti\t\t Asta centrocampisti"
	    echo -e "-A o --attaccanti\t\t Asta attaccanti"
	    echo -e "-Q o --qualsiasi\t\t Asta Random tutti i ruoli"
	    echo -e "-h o --help\t\t\t Stampa questo aiuto"
	    echo -e "-i o --info\t\t\t Apre il file delle istruzioni"
	    echo -e "-R o --RESET\t\t\t Azzera tutte le squadre e le chiamate"
	    ;;
	    -i|--info)
	    echo "Apro il file delle istruzioni"
	    notepad.exe README.md
	    ;;
	    -R|--RESET)
	    echo -e "$RED""Azzera le squadre e le chiamate$NC"
	    azzera_chiamate
	    ;;
	    *)    # unknown option
	    echo "Opzione non valida. Digita: fanta-random.sh --help per le opzioni"
	    exit 1
	    ;;
	esac
else
	echo "Opzione Mancante. Digita: fanta-random.sh --help per le opzioni"
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
	if [ ! -f $DIRSQUADRE/${PLAYER[0]}.csv ]; then
		touch $DIRSQUADRE/${PLAYER[0]}.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/${PLAYER[0]}.csv
	fi
	if [ ! -f $DIRSQUADRE/${PLAYER[1]}.csv ]; then
		touch $DIRSQUADRE/${PLAYER[1]}.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/${PLAYER[1]}.csv
	fi
	if [ ! -f $DIRSQUADRE/${PLAYER[2]}.csv ]; then
		touch $DIRSQUADRE/${PLAYER[2]}.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/${PLAYER[2]}.csv
	fi
	if [ ! -f $DIRSQUADRE/${PLAYER[3]}.csv ]; then
		touch $DIRSQUADRE/${PLAYER[3]}.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/${PLAYER[3]}.csv
	fi
	if [ ! -f $DIRSQUADRE/${PLAYER[4]}.csv ]; then
		touch $DIRSQUADRE/${PLAYER[4]}.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/${PLAYER[4]}.csv
	fi
	if [ ! -f $DIRSQUADRE/${PLAYER[5]}.csv ]; then
		touch $DIRSQUADRE/${PLAYER[5]}.csv
		echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/${PLAYER[5]}.csv
	fi
}

#Portieri
function portieri {

while [ $PORDISPONIBILI -gt 1 ]
do
	CASUAL=$(shuf -n 1 $LISTA);
	if [[ "$CASUAL" == P* ]] && [[ "$CASUAL" == *0 ]]; then 
		PORDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "P;0" |wc -l);
		echo -e "-------------------------------------- \n"
		echo -e "$CYAN""Portieri da chiamare:$NC $YELLOW$PORDISPONIBILI$NC"
		for i in "${PLAYER[@]}" 
		do
			BUYPLAYER=$(cat $DIRSQUADRE/$i.csv |cut -d ";" -f 1 |grep "P" |wc -l);
			echo -e "$CYAN$i$NC: $YELLOW$BUYPLAYER$NC"
		done
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC \n"
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
                echo -e "-------------------------------------- \n"
                echo -e "$CYAN""Difensori da chiamare:$NC $YELLOW$DIFDISPONIBILI$NC"
                for i in "${PLAYER[@]}"
                do
                        BUYPLAYER=$(cat $DIRSQUADRE/$i.csv |cut -d ";" -f 1 |grep "D" |wc -l);
                        echo -e "$CYAN$i$NC: $YELLOW$BUYPLAYER$NC"
                done
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC \n"
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
                echo -e "-------------------------------------- \n"
                echo -e "$CYAN""Centrocampisti da chiamare:$NC $YELLOW$CENDISPONIBILI$NC"
                for i in "${PLAYER[@]}"
                do
                        BUYPLAYER=$(cat $DIRSQUADRE/$i.csv |cut -d ";" -f 1 |grep "C" |wc -l);
                        echo -e "$CYAN$i$NC: $YELLOW$BUYPLAYER$NC"
                done
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC \n"
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
		echo -e "-------------------------------------- \n"
                echo -e "$CYAN""Attaccanti da chiamare:$NC $YELLOW$ATTDISPONIBILI$NC"
                for i in "${PLAYER[@]}"
                do
                        BUYPLAYER=$(cat $DIRSQUADRE/$i.csv |cut -d ";" -f 1 |grep "A" |wc -l);
                        echo -e "$CYAN$i$NC: $YELLOW$BUYPLAYER$NC"
                done
		POS=$(echo $CASUAL | cut -d ";" -f 1)
		NOME=$(echo $CASUAL | cut -d ";" -f 2)
		SQUADRA=$(echo $CASUAL | cut -d ";" -f 3)
		VAL=$(echo $CASUAL | cut -d ";" -f 4)
		echo -e "Nome: $GREEN$NOME$NC, Ruolo: $CYAN$POS$NC, Squadra: $CYAN$SQUADRA$NC, Valutazione: $CYAN$VAL$NC \n"
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
		echo -e "-------------------------------------- \n"
                echo -e "$CYAN""Giocatore da chiamare:$NC $YELLOW$DISPONIBILI$NC"
                for i in "${PLAYER[@]}"
                do
                        BUYPLAYER=$(cat $DIRSQUADRE/$i.csv |cut -d ";" -f 1 |grep -E "P|D|C|A" |wc -l);
                        echo -e "$CYAN$i$NC: $YELLOW$BUYPLAYER$NC"
                done
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
	        case $AZZERA in
			y|Y|Yes|yes|YES|Si|Sì|si|sì|s|S|SI)
				sed -i -e "s/.$/0/g" $LISTA
				rm -f $DIRSQUADRE/${PLAYER[0]}.csv
				rm -f $DIRSQUADRE/${PLAYER[1]}.csv
				rm -f $DIRSQUADRE/${PLAYER[2]}.csv
				rm -f $DIRSQUADRE/${PLAYER[3]}.csv
				rm -f $DIRSQUADRE/${PLAYER[4]}.csv
				rm -f $DIRSQUADRE/${PLAYER[5]}.csv
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
	read  -${BASH_VERSION+e}r ACQUISTO
	case $ACQUISTO in
		A|a)
			echo -e "Per quanti Fantamilioni?"
			read -${BASH_VERSION+e}r FM
			echo -e "$GREEN$NOME$NC venduto a: $RED${PLAYER[0]}$NC per $CYAN$FM$NC fantamilioni \n"
			echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[0]}.csv
 			sed -i "/$CASUAL/d" $LISTA
        		;;
		F|f)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED${PLAYER[1]}$NC per $CYAN$FM$NC fantamilioni \n"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[1]}.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		L|l)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED${PLAYER[2]}$NC per $CYAN$FM$NC fantamilioni \n"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[2]}.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		P|p)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED${PLAYER[3]}$NC per $CYAN$FM$NC fantamilioni \n"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[3]}.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		S|s)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED${PLAYER[4]}$NC per $CYAN$FM$NC fantamilioni \n"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[4]}.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		Z|z)
                        echo -e "Per quanti Fantamilioni?"
                        read -${BASH_VERSION+e}r FM
                        echo -e "$GREEN$NOME$NC venduto a: $RED${PLAYER[5]}$NC per $CYAN$FM$NC fantamilioni \n"
        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[5]}.csv
 			sed -i "/$CASUAL/d" $LISTA
			;;
		*)
                        echo -e "Scelta non valida. Rimetto $NOME sul mercato. \n"
        		;;
	esac
        ;;
    No|no|N|n)
        sed -i -e "s/$CASUAL/$POS\;$NOME\;$SQUADRA\;$VAL\;1/g" $LISTA
        echo -e 'No, vado avanti \n'
        ;;
    *)
        sed -i -e "s/$CASUAL/$POS\;$NOME\;$SQUADRA\;$VAL\;1/g" $LISTA
        echo -e "Scelta non valida. Vado avanti \n"
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
