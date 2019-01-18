
# Canzoniere Fontanellato [![Build Status](https://travis-ci.com/dariomangoni/CanzoniereFontanellato.svg?branch=master)](https://travis-ci.com/dariomangoni/CanzoniereFontanellato)

Il repository contiene i file sorgente per la generazioni del canzoniere del gruppo AGESCI Fontanellato 1 con LaTeX + [songs](http://songs.sourceforge.net/).  

Il canzoniere è diviso in tre sezioni:
* Canzoniere Liturgico
* Canzoniere Scout&Folk
* Canzoniere Vario

per ciascuna di queste sezioni vi è un file *.tex* apposito, che riporta la lista di canzoni, in ordine alfabetico, afferenti a tale canzoniere.

## Aggiunta di canzoni

Supponiamo di voler aggiungere la canzone dal titolo *MySong* al *CanzoniereLiturgico*.  
Sarà necessario:
* creare un file *.tex* nella cartella [**songs**](./songs) con il nome della canzone  
es. *MySong.tex*  
con l'accortezza di evitare caratteri accentati, punteggiature, apostrofi e altri simboli che potrebbero compromettere l'individuazione del file

* aggiungere la seguente dicitura al file *CanzoniereLiturgico.tex*
	```TeX
	\input{"songs/MySong"}
	```

## Aggiunta degli accordi ai testi della canzone

Dopo aver creato il file si copi il testo nel file *songs/MySong.tex*. L'aggiunta degli accordi avviene con il comando `\[<accordo>]` da *anteporsi* alla vocale sulla quale cade l'accordo.

>	Le bionde tr\\[Mi]ecce  


I bemolle sono sostituiti dalla E commerciale '&' e.g. `\[Mi&]`  
I diesis sono sostituiti dal cancelletto: # e.g. `\[Fa#]`

Per una più dettagliata descrizione fare riferimento al manuale del pacchetto [songs](http://songs.sourceforge.net/).


La canzone dovrà essere formattata con i comandi appositi.

```TeX
\beginsong{MySong}
	\beginverse
		This is a ve\[Re]rse
	\endverse
	\beginchorus
		This is the ch\[Sol]orus
	\endchorus
	\beginverse
		This is an\[La]other ve\[Re]rse
	\endverse
\endsong
```

-----------------
## Installazione Font (nel caso si volesse usare il font Emerald)

For TexLive users refer to the site https://www.tug.org/fonts/fontinstall.html. Here a summary:
1) find your local **texmf** folder prompting this in the command prompt:
	```winbatch
	kpsewhich --var-value TEXMFLOCAL
	```
2) copy the the **fonts** and **tex** folders of the font into your **texmf** folder
3) run from command prompt:
	```winbatch
	mktexlsr
	updmap-sys --force --enable Map=emerald.map
	```
4) done

## Compilazione
Nella cartella **tools** il batch file *CompileCanzoniereFontanellato.cmd* riporta tutte le operazioni da eseguirsi per compilare il codice LaTeX con relativo indice. La generazione di quest'ultimo si basa sullo script Lua *songidx.lua* reperibile nel codice sorgente dello stesso pacchetto [songs](http://songs.sourceforge.net/). Per il suo utilizzo è richiesto *texlua*.