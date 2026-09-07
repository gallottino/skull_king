# [E07] Classifica del round precedente

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** M
**Labels:** `epic:gameplay` `type:feat` `size:M`

## Obiettivo

La metà sinistra del pannello nel flow: dopo ogni round, chi è in testa,
quanto ha fatto ciascuno nell'ultimo round e come si è arrivati a quel numero.

## Valore

È la ragione per cui si tiene il punteggio. Il momento della classifica è il
momento sociale del gioco: se è bella e leggibile, l'app viene adottata.

## Criteri di accettazione

- [ ] Classifica ordinata per punteggio totale, con posizione, nickname, avatar
- [ ] Per ogni giocatore: punti del round appena chiuso (con segno) e totale cumulato
- [ ] La variazione di posizione rispetto al round precedente è visibile
- [ ] Toccando un giocatore si vede il dettaglio del calcolo (puntata, prese, bonus, punti)
- [ ] I punteggi negativi sono inequivocabili nel segno
- [ ] Il pareggio è mostrato secondo la regola decisa in `B02`
- [ ] Leggibile con il numero massimo di giocatori senza scroll orizzontale

## ⚠️ Domande critiche

1. **Quanto storico serve?** Solo l'ultimo round (come dice il flow), o una
   tabella completa round × giocatore consultabile? La seconda è quello che la
   gente chiede sempre dopo la prima partita ("ma al terzo round che avevo
   fatto?"). Vale la pena prevederla come vista separata.
2. **Mostrare il dettaglio del calcolo o solo il risultato?** Mostrarlo
   costruisce fiducia nel tracker e chiude le discussioni. È probabilmente la
   feature con il miglior rapporto valore/costo dell'intero progetto.
3. **Classifica e form di inserimento sullo stesso schermo** (come nel disegno):
   su un telefono in portrait ci stanno? Potrebbe servire un layout a due
   pannelli in landscape e a tab in portrait.
4. **Animare i cambi di posizione?** Molto d'effetto, ma è la cosa più facile
   da rimandare. Non bloccare il ticket su questo.
