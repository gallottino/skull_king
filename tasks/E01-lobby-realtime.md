# [E01] Lobby realtime

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** M
**Labels:** `epic:gameplay` `type:feat` `size:M`

## Obiettivo

La schermata "Lobby" del flow: il codice stanza, i giocatori seduti attorno al
tavolo che compaiono e spariscono in tempo reale, e lo stato di attesa.

## Valore

È l'hub visivo di tutta l'app: ci si torna dopo ogni round. Farla bene qui
significa non rifarla cinque volte.

## Criteri di accettazione

- [ ] Il codice stanza è sempre visibile, leggibile a un metro di distanza
- [ ] I giocatori appaiono/scompaiono senza refresh, con una transizione non brusca
- [ ] Ogni posto mostra: avatar, nickname, stato ("in attesa", "pronto"), e chi è l'host
- [ ] Il tavolo si adatta al numero di giocatori (da 2 al massimo previsto) senza sovrapposizioni
- [ ] Chi è disconnesso è visivamente distinto da chi è presente (→ `C04`, domanda 2)
- [ ] Da qui è raggiungibile la condivisione (`D05`) e, per l'host, l'avvio partita (`E02`)

## ⚠️ Domande critiche

1. **La lobby e il tavolo di gioco sono la stessa schermata o due?** Nel flow
   "Lobby" è il nodo centrale a cui si torna dopo ogni round. Se è la stessa
   schermata che cambia stato, ottieni continuità visiva e meno codice; se
   sono due, ognuna è più semplice ma perdi il senso di "stesso tavolo".
   Consiglio: **una sola schermata, stati diversi**.
2. **Come rappresenti "sta pensando" vs "ha finito"?** Serve un vocabolario
   di stati per giocatore, coerente in tutte le fasi (lobby, puntata,
   inserimento punti). Definiscilo una volta qui.
3. **Cosa vede un giocatore non-host mentre aspetta?** Se non ha nessun
   pulsante da premere, deve almeno capire *cosa* sta aspettando e *chi*
   manca. L'attesa senza spiegazione è la principale fonte di "si è bloccata".
4. **Ordine dei posti al tavolo**: deve essere identico su tutti i device
   (→ `C01`, domanda 5), oppure ognuno vede se stesso in basso? La seconda è
   più naturale da giocare ma rende difficile dirsi "tocca a quello alla tua
   sinistra".
