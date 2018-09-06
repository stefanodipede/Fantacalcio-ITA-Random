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
DATA=$(date +%Y-%m-%d--%H-%M);
DIRSQUADRE="squadre"
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
	cp $LISTA $DIRBACKUP/Backup-Lista-$DATA-$LISTA
	sed -i -e "s/ \*//g" $LISTA
	sed -i -e "s/'//g" $LISTA

	for i in "${PLAYER[@]}"
	do
		if [ ! -f $DIRSQUADRE/$i.csv ]; then
			touch $DIRSQUADRE/$i.csv
			echo -e "Ruolo;Nome;Squadra;costo" > $DIRSQUADRE/$i.csv
		else
			cp $DIRSQUADRE/$i.csv $DIRBACKUP/Backup-Squadra-$DATA-$i.csv
		fi
	done
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
echo -e "I Portieri sono stati tutti chiamati."
echo -e "Rileggo i (P)ortieri non venduti o vado avanti con i (D)ifensori?"
read -${BASH_VERSION+e}r FINITI
case $FINITI in
    P|p)
        echo -e "Ricomincio con i portieri:"
	cat $LISTA |cut -d ";" -f 1,5 |grep "P;1" |sed -i -e "s/.$/0/g" $LISTA
	PORDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "P;0" |wc -l);
	portieri 
	;;
    D|d)
        echo -e "Vado avanti con i Difensori."
	difensori
	;;
      *)
	echo -e "Scelta non valida. Esco"
	exit 1
	;;
esac
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
echo -e "I Difensori sono stati tutti chiamati."
echo -e "Rileggo i (D)ifensori non venduti o vado avanti con i (C)entrocampisti?"
read -${BASH_VERSION+e}r FINITI
case $FINITI in
    D|d)
        echo -e "Ricomincio con i difensori:"
        cat $LISTA |cut -d ";" -f 1,5 |grep "D;1" |sed -i -e "s/.$/0/g" $LISTA
        DIFDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "D;0" |wc -l);
        difensori
        ;;
    C|c)
        echo -e "Vado avanti con i Centrocampisti."
        centrocampisti
        ;;
      *)
        echo -e "Scelta non valida. Esco"
        exit 1
	;;
esac
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
echo -e "I Centrocampisti sono stati tutti chiamati."
echo -e "Rileggo i (C)centrocampisti non venduti o vado avanti con gli (A)ttaccanti?"
read -${BASH_VERSION+e}r FINITI
case $FINITI in
    C|c)
        echo -e "Ricomincio con i centrocampisti:"
        cat $LISTA |cut -d ";" -f 1,5 |grep "C;1" |sed -i -e "s/.$/0/g" $LISTA
        CENDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "C;0" |wc -l);
        centrocampisti
        ;;
    C|c)
        echo -e "Vado avanti con gli attaccanti."
        attaccanti
        ;;
      *)
        echo -e "Scelta non valida. Esco"
        exit 1
	;;
esac
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
echo -e "Gli Attaccanti sono stati tutti chiamati."
echo -e "Rileggo gli (A)ttaccanti non venduti, oppure ricomincio dai (P)ortieri oppure (E)sco?"
read -${BASH_VERSION+e}r FINITI
case $FINITI in
    A|a)
        echo -e "Ricomincio con gli Attaccanti:"
        cat $LISTA |cut -d ";" -f 1,5 |grep "A;1" |sed -i -e "s/.$/0/g" $LISTA
        ATTDISPONIBILI=$(cat $LISTA |cut -d ";" -f 1,5 |grep "A;0" |wc -l);
        attaccanti
        ;;
    P|c)
        echo -e "Vado avanti con i Portieri."
        portieri
        ;;
    E|e)
	echo -e "Asta finita. Buon divertimento!"
	exit 1
	;;
      *)
        echo -e "Scelta non valida. Esco"
        exit 1
	;;
esac
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
echo -e "I Giocatori sono stati tutti chiamati."
echo -e "Rileggo da capo i (G)iocatori non venduti oppure (E)sco?"
read -${BASH_VERSION+e}r FINITI
case $FINITI in
    G|g)
        echo -e "Ricomincio con i giocatori:"
        cat $LISTA |cut -d ";" -f 5 |grep "1" |sed -i -e "s/.$/0/g" $LISTA
        DISPONIBILI=$(cat $LISTA |cut -d ";" -f 5 |grep "0" |wc -l);
        qualsiasi
        ;;
    E|e)
        echo -e "Asta finita. Buon divertimento."
        exit 1
        ;;
      *)
        echo -e "Scelta non valida. Esco"
        exit 1
	;;
esac
}


function azzera_chiamate {
	echo -e "Sto per resettare le chiamate, le squadre e la lista dei giocatori. Sei sicuro? (S)ì/(N)o"
	read  -${BASH_VERSION+e}r AZZERA
	        case $AZZERA in
			y|Y|Yes|yes|YES|Si|Sì|si|sì|s|S|SI)
				sed -i -e "s/.$/0/g" $LISTA
			        for i in "${PLAYER[@]}"
		        	do				
					rm -f $DIRSQUADRE/$i.csv
				done
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
			PORPLAYER=$(cat $DIRSQUADRE/${PLAYER[0]}.csv |cut -d ";" -f 1 |grep "P" |wc -l);
			DIFPLAYER=$(cat $DIRSQUADRE/${PLAYER[0]}.csv |cut -d ";" -f 1 |grep "D" |wc -l);
			CENPLAYER=$(cat $DIRSQUADRE/${PLAYER[0]}.csv |cut -d ";" -f 1 |grep "C" |wc -l);
			ATTPLAYER=$(cat $DIRSQUADRE/${PLAYER[0]}.csv |cut -d ";" -f 1 |grep "A" |wc -l);
			if ([[ "$POS" = "P" ]] && [[ "$PORPLAYER" -lt 3 ]]) || ([[ "$POS" = "D" ]] && [[ "$DIFPLAYER" -lt 8 ]]) || ([[ "$POS" = "C" ]] && [[ "$CENPLAYER" -lt 8 ]]) || ([[ "$POS" = "A" ]] && [[ "$ATTPLAYER" -lt 6 ]]); then
				echo -e "Per quanti Fantamilioni?"
				read -${BASH_VERSION+e}r FM
				echo -e "$GREEN$NOME$NC venduto a: $CYAN${PLAYER[0]}$NC per $CYAN$FM$NC fantamilioni \n"
				echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[0]}.csv
	 			sed -i "/$CASUAL/d" $LISTA
			else
				echo -e "$RED""ATTENZIONE:$NC $CYAN${PLAYER[0]}$NC $RED""ha raggiunto il limite massimo di acquisti per questo ruolo.$NC"
				echo -e "Il giocatore $GREEN$NOME$NC è stato reinserito in lista \n"
			fi
        		;;
		F|f)
			PORPLAYER=$(cat $DIRSQUADRE/${PLAYER[1]}.csv |cut -d ";" -f 1 |grep "P" |wc -l);
                        DIFPLAYER=$(cat $DIRSQUADRE/${PLAYER[1]}.csv |cut -d ";" -f 1 |grep "D" |wc -l);
                        CENPLAYER=$(cat $DIRSQUADRE/${PLAYER[1]}.csv |cut -d ";" -f 1 |grep "C" |wc -l);
                        ATTPLAYER=$(cat $DIRSQUADRE/${PLAYER[1]}.csv |cut -d ";" -f 1 |grep "A" |wc -l);
                        if ([[ "$POS" = "P" ]] && [[ "$PORPLAYER" -lt 3 ]]) || ([[ "$POS" = "D" ]] && [[ "$DIFPLAYER" -lt 8 ]]) || ([[ "$POS" = "C" ]] && [[ "$CENPLAYER" -lt 8 ]]) || ([[ "$POS" = "A" ]] && [[ "$ATTPLAYER" -lt 6 ]]); then
	                        echo -e "Per quanti Fantamilioni?"
        	                read -${BASH_VERSION+e}r FM
                	        echo -e "$GREEN$NOME$NC venduto a: $CYAN{PLAYER[1]}$NC per $CYAN$FM$NC fantamilioni \n"
        			echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[1]}.csv
	 			sed -i "/$CASUAL/d" $LISTA
                        else
                                echo -e "$RED""ATTENZIONE:$NC $CYAN${PLAYER[1]}$NC $RED""ha raggiunto il limite massimo di acquisti per questo ruolo.$NC"
                                echo -e "Il giocatore $GREEN$NOME$NC è stato reinserito in lista \n"
                        fi
			;;
		L|l)
			PORPLAYER=$(cat $DIRSQUADRE/${PLAYER[2]}.csv |cut -d ";" -f 1 |grep "P" |wc -l);
                        DIFPLAYER=$(cat $DIRSQUADRE/${PLAYER[2]}.csv |cut -d ";" -f 1 |grep "D" |wc -l);
                        CENPLAYER=$(cat $DIRSQUADRE/${PLAYER[2]}.csv |cut -d ";" -f 1 |grep "C" |wc -l);
                        ATTPLAYER=$(cat $DIRSQUADRE/${PLAYER[2]}.csv |cut -d ";" -f 1 |grep "A" |wc -l);
                        if ([[ "$POS" = "P" ]] && [[ "$PORPLAYER" -lt 3 ]]) || ([[ "$POS" = "D" ]] && [[ "$DIFPLAYER" -lt 8 ]]) || ([[ "$POS" = "C" ]] && [[ "$CENPLAYER" -lt 8 ]]) || ([[ "$POS" = "A" ]] && [[ "$ATTPLAYER" -lt 6 ]]); then
	                        echo -e "Per quanti Fantamilioni?"
        	                read -${BASH_VERSION+e}r FM
                	        echo -e "$GREEN$NOME$NC venduto a: $CYAN${PLAYER[2]}$NC per $CYAN$FM$NC fantamilioni \n"
        			echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[2]}.csv
	 			sed -i "/$CASUAL/d" $LISTA
                        else
                                echo -e "$RED""ATTENZIONE:$NC $CYAN${PLAYER[2]}$NC $RED""ha raggiunto il limite massimo di acquisti per questo ruolo.$NC"
                                echo -e "Il giocatore $GREEN$NOME$NC è stato reinserito in lista \n"
                        fi
			;;
		P|p)
			PORPLAYER=$(cat $DIRSQUADRE/${PLAYER[3]}.csv |cut -d ";" -f 1 |grep "P" |wc -l);
                        DIFPLAYER=$(cat $DIRSQUADRE/${PLAYER[3]}.csv |cut -d ";" -f 1 |grep "D" |wc -l);
                        CENPLAYER=$(cat $DIRSQUADRE/${PLAYER[3]}.csv |cut -d ";" -f 1 |grep "C" |wc -l);
                        ATTPLAYER=$(cat $DIRSQUADRE/${PLAYER[3]}.csv |cut -d ";" -f 1 |grep "A" |wc -l);
                        if ([[ "$POS" = "P" ]] && [[ "$PORPLAYER" -lt 3 ]]) || ([[ "$POS" = "D" ]] && [[ "$DIFPLAYER" -lt 8 ]]) || ([[ "$POS" = "C" ]] && [[ "$CENPLAYER" -lt 8 ]]) || ([[ "$POS" = "A" ]] && [[ "$ATTPLAYER" -lt 6 ]]); then
	                        echo -e "Per quanti Fantamilioni?"
        	                read -${BASH_VERSION+e}r FM
                	        echo -e "$GREEN$NOME$NC venduto a: $CYAN${PLAYER[3]}$NC per $CYAN$FM$NC fantamilioni \n"
	        		echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[3]}.csv
 				sed -i "/$CASUAL/d" $LISTA
                        else
                                echo -e "$RED""ATTENZIONE:$NC $CYAN${PLAYER[3]}$NC $RED""ha raggiunto il limite massimo di acquisti per questo ruolo.$NC"
                                echo -e "Il giocatore $GREEN$NOME$NC è stato reinserito in lista \n"
                        fi
			;;
		S|s)
                        PORPLAYER=$(cat $DIRSQUADRE/${PLAYER[4]}.csv |cut -d ";" -f 1 |grep "P" |wc -l);
                        DIFPLAYER=$(cat $DIRSQUADRE/${PLAYER[4]}.csv |cut -d ";" -f 1 |grep "D" |wc -l);
                        CENPLAYER=$(cat $DIRSQUADRE/${PLAYER[4]}.csv |cut -d ";" -f 1 |grep "C" |wc -l);
                        ATTPLAYER=$(cat $DIRSQUADRE/${PLAYER[4]}.csv |cut -d ";" -f 1 |grep "A" |wc -l);
                        if ([[ "$POS" = "P" ]] && [[ "$PORPLAYER" -lt 3 ]]) || ([[ "$POS" = "D" ]] && [[ "$DIFPLAYER" -lt 8 ]]) || ([[ "$POS" = "C" ]] && [[ "$CENPLAYER" -lt 8 ]]) || ([[ "$POS" = "A" ]] && [[ "$ATTPLAYER" -lt 6 ]]); then
	                        echo -e "Per quanti Fantamilioni?"
        	                read -${BASH_VERSION+e}r FM
                	        echo -e "$GREEN$NOME$NC venduto a: $CYAN${PLAYER[4]}$NC per $CYAN$FM$NC fantamilioni \n"
        			echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[4]}.csv
	 			sed -i "/$CASUAL/d" $LISTA
                        else
                                echo -e "$RED""ATTENZIONE:$NC $CYAN${PLAYER[4]}$NC $RED""ha raggiunto il limite massimo di acquisti per questo ruolo.$NC"
                                echo -e "Il giocatore $GREEN$NOME$NC è stato reinserito in lista \n"
                        fi
			;;
		Z|z)
                        PORPLAYER=$(cat $DIRSQUADRE/${PLAYER[5]}.csv |cut -d ";" -f 1 |grep "P" |wc -l);
                        DIFPLAYER=$(cat $DIRSQUADRE/${PLAYER[5]}.csv |cut -d ";" -f 1 |grep "D" |wc -l);
                        CENPLAYER=$(cat $DIRSQUADRE/${PLAYER[5]}.csv |cut -d ";" -f 1 |grep "C" |wc -l);
                        ATTPLAYER=$(cat $DIRSQUADRE/${PLAYER[5]}.csv |cut -d ";" -f 1 |grep "A" |wc -l);
                        if ([[ "$POS" = "P" ]] && [[ "$PORPLAYER" -lt 3 ]]) || ([[ "$POS" = "D" ]] && [[ "$DIFPLAYER" -lt 8 ]]) || ([[ "$POS" = "C" ]] && [[ "$CENPLAYER" -lt 8 ]]) || ([[ "$POS" = "A" ]] && [[ "$ATTPLAYER" -lt 6 ]]); then
                        	echo -e "Per quanti Fantamilioni?"
	                        read -${BASH_VERSION+e}r FM
        	                echo -e "$GREEN$NOME$NC venduto a: $CYAN${PLAYER[5]}$NC per $CYAN$FM$NC fantamilioni \n"
        			echo -e "$POS;$NOME;$SQUADRA;$FM" >> $DIRSQUADRE/${PLAYER[5]}.csv
 				sed -i "/$CASUAL/d" $LISTA
                        else
                                echo -e "$RED""ATTENZIONE:$NC $CYAN${PLAYER[5]}$NC $RED""ha raggiunto il limite massimo di acquisti per questo ruolo.$NC"
                                echo -e "Il giocatore $GREEN$NOME$NC è stato reinserito in lista \n"
                        fi
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


inizio
option
