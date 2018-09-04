Chiamata Random per asta Fantacalcio con opzioni
 Ver. 1.0 - Stefano Di Pede -  2018-09-03i




ISTRUZIONI:

1) Download il file aggiornato dei calciotori dal sito di rifertimento.

Nel nostro caso: Fantagazzetta.



2) Salvare il file in un CSV con il sequente formato:



RUOLO*;NOME;SQUADRA;QUOTAZIONE;CHIAMATO**



Es: P;PERIN;JUVENTUS;13;0



\* RUOLO = Il ruolo deve essere codificato da una lettera tra: P,D,C,A.

P = Portiere
 
D = Difensore

C = Centrocampista

A = Attaccante

** CHIAMATO = Colonna di controllo per lo script. 0 = non chiamato, 1 = chiamato. Da impostare inizialmente tutti a 0.



N.B. Se il file viene manipolato da Windows, è probabile che alla fine di ogni riga venga inserito automaticamente il valore "CR". 
Se presente sul file CSV, questo impedice al programma di funzionare correttamente. 
Per eliminare questo campo nascosto da Windows, aprire il file CSV con Notepad++, abilitare la visione dei caratteri nascosti, e sostituire tutte le occorrenze di "\r\n" con "\n".



3) Una volta formattato il file correttamente, salvarne una copia chiamata "calciatori.csv" e "calciatori-orig.csv" (servirà in caso di reset dell'asta), nella stessa cartella dove è salvato il file fanta-random.sh.

4) Eseguire il file ./fanta-random.sh --help per le opzioni


Il programma visualizzerà i dettagli di un giocatore random, simulando la chiamata dell'asta, e da la possibilità di assegnare eventualmente il giocatore ad una squadra in maniera interattiva, indicando il giocatore e il costo.


Tale giocatore verrà inserito nel file csv relativo al giocatore che lo ha acquistato.



Per modificare il nome dei giocatori e dei file, è possibile modificare le variabili iniziali dello script.


In aggiunta al progetto, è stato inserito un file Excel: fantacalcio.xlsx, con i riferimenti ai csv delle squadre, con aggiornamento automatico dei dati da CSV, e calcolo automatico dei crediti rimanenti, con formattazione automatica in base ai ruoli.


Buona Asta!
