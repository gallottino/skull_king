# [E06] Chiusura del round e calcolo dei punteggi

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** M
**Labels:** `epic:gameplay` `type:feat` `size:M`

## Obiettivo

Il nodo "Proprietario della stanza dichiara fine round": l'host chiude il
round, i punteggi vengono calcolati e congelati, e la partita avanza al round
successivo o alla classifica finale.

## Valore

È la transizione che rende i punti definitivi. È anche l'unico momento in cui
il motore di `B02` viene davvero usato in produzione.

## Criteri di accettazione

- [ ] Il comando di chiusura è visibile solo all'host ed è imposto dalle RLS
- [ ] La chiusura è bloccata (con motivo esplicito) se mancano dati o se i controlli di coerenza falliscono
- [ ] Alla chiusura: punti calcolati per tutti, `rounds.status` a chiuso, `current_round` incrementato — **in una sola transazione**
- [ ] Le entry di un round chiuso diventano immutabili (correzioni solo via `F02`)
- [ ] Il controllo "era l'ultimo round?" decide fra nuovo round e classifica finale (`E09`)
- [ ] Tutti i device avanzano insieme, senza refresh
- [ ] Test: chiudere due volte lo stesso round non raddoppia i punti (idempotenza)

## ⚠️ Domande critiche

1. **I punti si scrivono o si calcolano in lettura?** (→ `C01`, domanda 3).
   Scriverli li rende ispezionabili e stabili anche se cambi le regole;
   calcolarli sempre elimina ogni possibilità di divergenza. Con `F02` in
   programma, calcolarli è più semplice — ma allora il motore di punteggio
   deve esistere anche lato server, oppure fidarsi del client.
2. **L'host può chiudere il round se qualcuno non ha inserito nulla?**
   Se sì, quel giocatore prende quanti punti — zero, o la penalità piena da
   puntata sbagliata? Non è una domanda tecnica: è una regola della casa.
3. **Serve una conferma prima di chiudere?** La chiusura fa avanzare la
   partita per tutti ed è difficile da annullare. Consiglio: conferma con un
   riepilogo di quello che si sta per congelare.
4. **E se l'host se ne va prima di chiudere?** (→ `F03`) La partita resta
   appesa per sempre. Serve almeno un meccanismo di trasferimento dell'host.
