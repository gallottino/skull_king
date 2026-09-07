# [F03] Abbandono, espulsione e passaggio di host

**Epic:** Robustezza · **Milestone:** M5 · **Stima:** M
**Labels:** `epic:hardening` `type:feat` `size:M` `needs-decision`

## Obiettivo

Gestire in modo esplicito i modi in cui una partita si rompe: qualcuno esce,
qualcuno di troppo è entrato, l'host sparisce.

## Valore

Tutto il flow assume che l'host ci sia e che i giocatori restino. Nel mondo
reale nessuna delle due cose è garantita, e ogni eccezione non gestita è una
partita persa e un'app abbandonata.

## Criteri di accettazione

- [ ] Un giocatore può lasciare la stanza esplicitamente, con conferma
- [ ] L'host può espellere un giocatore dalla lobby
- [ ] Se l'host lascia, l'host passa a un altro giocatore secondo una regola deterministica
- [ ] Chi esce a partita iniziata resta in classifica con uno stato "ritirato" (o secondo la regola decisa)
- [ ] Le condizioni di attesa (`E04`, `E06`) tengono conto di chi è uscito: nessun blocco eterno
- [ ] L'host può chiudere/abbandonare la stanza, e chi resta lo capisce senza schermate bianche

## ⚠️ Domande critiche

1. **Chi diventa host se l'host sparisce?** Il più anziano in stanza è la
   regola più semplice e deterministica. L'alternativa (chiunque può reclamare
   l'host) è più flessibile ma può essere usata male. E se sparisce mentre
   è offline solo temporaneamente (→ `F01`, domanda 3), il passaggio va
   ritardato con un timeout: quanto?
2. **Un giocatore che esce a metà partita: i suoi punti restano o spariscono?**
   Toglierlo dalla classifica riscrive la storia; lasciarlo con punteggio
   congelato è più onesto ma richiede che non blocchi le attese.
3. **Espulsione: solo in lobby o anche in partita?** Espellere a metà partita è
   un potere pesante. Probabilmente va limitato alla lobby.
4. **Un giocatore espulso può rientrare con lo stesso link?** Se sì,
   l'espulsione è inutile. Serve una lista di esclusi, o accettiamo che sia
   solo un rimedio a errori, non a conflitti?
