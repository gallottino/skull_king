# [F02] Correzione di un round già chiuso

**Epic:** Robustezza · **Milestone:** M5 · **Stima:** M
**Labels:** `epic:hardening` `type:feat` `size:M`

## Obiettivo

L'host può correggere puntata, prese o bonus di un round già chiuso; i
punteggi successivi si ricalcolano di conseguenza.

## Valore

Gli errori di inserimento capitano, e ci si accorge tre round dopo. Senza
questa funzione l'unica via è ricominciare la partita — che è esattamente il
momento in cui si torna al foglio di carta e l'app viene disinstallata.

## Criteri di accettazione

- [ ] Solo l'host può correggere (imposto dalle RLS)
- [ ] Correggendo un round passato, tutti i totali successivi si ricalcolano
- [ ] Tutti i device vedono la classifica aggiornata, con un avviso che una correzione è avvenuta
- [ ] Resta traccia della correzione (chi, quando, da cosa a cosa)
- [ ] Non è possibile correggere una partita chiusa (o lo è, ma con conferma esplicita)
- [ ] Test: correggere il round 2 di una partita di 10 produce gli stessi totali di una partita giocata correttamente da zero

## Note tecniche

Questo ticket è **quasi gratis** se i punti sono derivati dai fatti
(`bid`, `tricks`, `bonus`) invece che memorizzati — e **costoso** se sono
memorizzati. Vedi `C01` domanda 3 e `B02` domanda 5: la decisione presa lì
determina la dimensione di questo ticket.

## ⚠️ Domande critiche

1. **Serve un audit trail o basta sovrascrivere?** Fra amici, la trasparenza
   ("l'host ha corretto il round 3") vale più della pulizia: previene il
   sospetto di manipolazione, che è l'unico modo in cui un tracker perde
   autorità.
2. **Solo l'host, o il giocatore può correggere i propri dati con
   approvazione?** Coerente con la risposta a `E05`, domanda 1.
3. **Correggere durante il round in corso o solo in un momento dedicato?**
   Aprire una modalità "correzione" separata evita tocchi accidentali su dati
   congelati.
4. **Un annullamento completo dell'ultimo round ("undo") è più semplice e copre
   il 90% dei casi.** Vale la pena farlo prima e valutare se la correzione
   arbitraria serve davvero.
