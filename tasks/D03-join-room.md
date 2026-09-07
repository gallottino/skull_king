# [D03] Unirsi a una stanza tramite codice

**Epic:** Onboarding · **Milestone:** M3 · **Stima:** M
**Labels:** `epic:onboarding` `type:feat` `size:M`

## Obiettivo

Inserendo il codice, un giocatore entra nella stanza di qualcun altro e appare
nella sua lobby in tempo reale.

## Valore

È il momento in cui l'app diventa multi-device. Il primo "wow" verificabile:
scrivi un codice su un telefono e comparí sullo schermo di un altro.

## Criteri di accettazione

- [ ] Input del codice case-insensitive, che ignora spazi e trattini
- [ ] Feedback distinti per: codice inesistente, stanza piena, partita già iniziata, stanza chiusa
- [ ] Il codice viene validato **prima** di chiedere di creare il personaggio (non far compilare un form per poi dire "stanza inesistente")
- [ ] All'ingresso, gli altri device vedono comparire il nuovo giocatore senza refresh
- [ ] Rientrare con la stessa identità non crea un duplicato (→ `C02`)
- [ ] Su mobile la tastiera si apre già in modalità adatta al codice, senza autocorrezione

## ⚠️ Domande critiche

1. **Si può entrare a partita iniziata?** (→ `B01`, domanda 3) Se la risposta è
   no, serve comunque un messaggio dignitoso: la gente arriva in ritardo.
   Se è sì, servono le regole sul punteggio di partenza.
2. **Rientro dopo disconnessione = join?** Sono due flussi diversi che passano
   dallo stesso input. Chi rientra non deve rifare il personaggio.
   Come li distingui: identità locale (→ `C02`) o nickname già presente?
3. **Nickname duplicati.** Due "Davide" al tavolo sono un incubo di
   leggibilità. Blocchi il duplicato, o li distingui con l'avatar?
   Il vincolo `unique(room_id, nickname)` di `C01` implica bloccarli — è la
   scelta giusta ma va comunicata bene nell'errore.
4. **Numero massimo di giocatori**: quando la stanza è piena, cosa vede chi
   arriva? E il limite viene dalle regole del gioco o dal layout del tavolo?
