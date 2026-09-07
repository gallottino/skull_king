# [E05] Inserimento dei risultati del round

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** L
**Labels:** `epic:gameplay` `type:feat` `size:L` `needs-decision`

## Obiettivo

Il "Form per inserire i punti durante il round" del flow: a fine mano si
registrano le prese effettivamente vinte (ed eventuali bonus).

## Valore

È il dato che, insieme alla puntata, produce il punteggio. È anche la
schermata più usata dell'app: dieci volte a partita, da tutti.

## Criteri di accettazione

- [ ] Inserimento delle prese vinte, con range valido (0 → carte del round)
- [ ] La puntata dichiarata è visibile accanto, per capire subito se si è dentro o fuori
- [ ] Feedback immediato dei punti che il round produrrà, prima della conferma
- [ ] Campo bonus presente **solo** in modalità espansione (→ `B03`)
- [ ] Validazione della somma delle prese sul totale del round, secondo la regola decisa in `B02`
- [ ] Un valore inserito e poi corretto prima della chiusura del round non lascia tracce sbagliate
- [ ] Il form è utilizzabile con una mano sola, senza scroll, sul telefono più piccolo supportato

## ⚠️ Domande critiche

1. **⚠️ LA DOMANDA CENTRALE DEL PROGETTO: chi inserisce i risultati?**
   - **(a) Ogni giocatore i propri.** Distribuito, veloce, ma nessuno controlla
     la coerenza e serve aspettare che tutti abbiano compilato (un altro punto
     di blocco come `E03`, domanda 3).
   - **(b) Solo l'host, per tutti.** Un unico responsabile, coerenza garantita,
     nessuna attesa — ma l'host diventa un data entry e gli altri device
     servono solo a guardare. A quel punto, serve davvero il multi-device?
   - **(c) Ibrido:** ognuno inserisce i propri, l'host vede il totale e
     conferma (è quello che suggerisce il flow, con "il proprietario dichiara
     fine round").
   Questa risposta cambia UI, RLS, realtime e il senso stesso dell'app.
   **Va decisa prima di scrivere una riga di questo ticket.**
2. **Che fai se la somma delle prese non torna?** Blocchi, avverti, o accetti?
   (→ `B02`, domanda 2). Ricorda il Kraken in espansione.
3. **Bonus: campo unico o dettagliato?** (→ `B03`, domanda 1). Il costo si
   paga tutto qui, in tocchi per round moltiplicati per dieci round.
4. **Si inserisce durante il round o alla fine?** Il flow dice "durante".
   Inserire man mano è più fedele al gioco ma richiede salvataggi parziali
   continui; alla fine è una scrittura sola. Cosa fanno le persone davvero?
5. **Cosa vede chi ha già finito di inserire?** Aspetta gli altri, o vede la
   classifica aggiornarsi in diretta? Mostrare punteggi parziali di un round
   non ancora chiuso può confondere.
