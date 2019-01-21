
# Canzoniere Fontanellato [![Build Status](https://travis-ci.com/dariomangoni/CanzoniereFontanellato.svg?branch=master)](https://travis-ci.com/dariomangoni/CanzoniereFontanellato)


Scarica il nostro canzoniere: [CanzoniereFontanellato](https://github.com/dariomangoni/CanzoniereFontanellato/releases/latest)

Il repository contiene inoltre i file sorgente per la generazioni del canzoniere del gruppo AGESCI Fontanellato 1 con LaTeX + [songs](http://songs.sourceforge.net/) in locale.  

Il canzoniere è diviso in tre sezioni:
* Canzoniere Liturgico
* Canzoniere Scout&Folk
* Canzoniere Vario

per ciascuna di queste sezioni vi è un file *.tex* apposito, che riporta la lista di canzoni, in ordine alfabetico, afferenti a tale canzoniere.

## Aggiunta di canzoni

Supponiamo di voler aggiungere la canzone dal titolo *MySong* al *CanzoniereLiturgico*.  
Sarà necessario:
* creare un file *.tex* nella cartella [**songs**](https://github.com/dariomangoni/CanzoniereFontanellato/tree/master/songs) con il nome della canzone  
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

Per utenti TexLive fare riferimoento al sito https://www.tug.org/fonts/fontinstall.html, del quale si riporta un estratto:
1. individuare la cartella **texmf-local** con il seguente comando:
	```winbatch
	kpsewhich --var-value TEXMFLOCAL
	```
2. estrarre l'archivio [emerald.zip](https://github.com/dariomangoni/CanzoniereFontanellato/tree/master/resources/emerald.zip)
3. copiare le cartelle **fonts** e **tex** così ottenute nella cartella **texmf-local** dell'installazione TexLive
4. eseguire da command prompt:
	```winbatch
	mktexlsr
	updmap-sys --force --enable Map=emerald.map
	```


## Compilazione
Nella cartella **tools** il batch file *CompileCanzoniereFontanellato.cmd* riporta tutte le operazioni da eseguirsi per compilare il codice LaTeX con relativo indice. La generazione di quest'ultimo si basa sullo script Lua *songidx.lua* reperibile nel codice sorgente dello stesso pacchetto [songs](http://songs.sourceforge.net/). Per il suo utilizzo è richiesto *texlua*.

## Compilazione automatica con Travis CI
Il file [CanzoniereFontanellato](https://github.com/dariomangoni/CanzoniereFontanellato/releases/latest) è mantenuto costantemente aggiornato da Travis CI ad ogni push del repository.