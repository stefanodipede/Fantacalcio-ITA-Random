#################################################
 Chiamata Random per asta Fantacalcio con opzioni   		
 Ver. 1.0 - Stefano Di Pede -  2018-09-03
#################################################

Download il file aggiornato dei calciotori dal sito di rifertimento.
Nel nostro caso: Fantagazzetta.

Salvare il file in un CSV con il sequente formato:

RUOLO*;NOME;SQUADRA;QUOTAZIONE

* RUOLO = Il ruolo deve essere codificato da una lettera tra: P,D,C,A.
P = Portiere
D = Difensore
C = Centrocampista
A = Attaccante

N.B. Se il file viene manipolato da Windows, è probabile che alla fine di ogni riga venga inserito automaticamente il valore "CR". Se presente sul file CSV, questo impedice al programma di funzionare correttamente. Per eliminare questo campo nascosto da Windows, aprire il file CSV con Notepad++, abilitare la visione dei caratteri nascosti, e sostituire tutte le occorrenze di "\r\n" con "\n"

Una volta formattato il file correttamente, salvarne una copia chiamata "calciatori.csv" e "calciatori-orig.csv" (servirà in caso di reset dell'asta), nella stessa cartella dove è salvato il file fanta-random.sh

Eseguire il file ./fanta-random.sh --help per le opzioni

Il programma visualizzerà i dettagli di un giocatore random, simulando la chiamata dell'asta, e da la possibilità di assegnare eventualmente il giocatore ad una squadra in maniera interattiva, indicando il giocatore e il costo.

Tale giocatore verrà inserito nel file csv relativo al giocatore che lo ha acquistato.

Per modificare il nome dei giocatori e dei file, è possibile modificare le variabili iniziali dello script.

Buona Asta!
