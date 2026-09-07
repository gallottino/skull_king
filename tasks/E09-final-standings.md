# [E09] Classifica finale e chiusura della partita

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** M
**Labels:** `epic:gameplay` `type:feat` `size:M`

## Obiettivo

Il nodo terminale del flow: finito l'ultimo round, la partita si chiude e tutti
vedono la classifica definitiva.

## Valore

È il finale. Chiude il cerchio narrativo dell'app e produce l'unico artefatto
che le persone vogliono condividere: chi ha vinto.

## Criteri di accettazione

- [ ] Alla chiusura dell'ultimo round tutti i device passano automaticamente alla classifica finale
- [ ] Podio evidente, con distinzione chiara del vincitore
- [ ] Riepilogo per giocatore: totale, round indovinati, miglior round
- [ ] Il pareggio è risolto secondo la regola di `B02` ed è spiegato all'utente
- [ ] La partita è marcata come chiusa: nessuna scrittura ulteriore è possibile
- [ ] Da qui: "nuova partita con la stessa ciurma" e "torna al menu"
- [ ] La classifica finale è condivisibile (immagine o testo)

## ⚠️ Domande critiche

1. **"Rigioca con la stessa ciurma": nuova stanza o stessa stanza resettata?**
   Riusare la stanza mantiene il codice (comodo: nessuno deve ricondividere)
   ma cancella o archivia la partita precedente. Nuova stanza è più pulito ma
   costringe tutti a rientrare. Consiglio: **stessa stanza, nuova partita** —
   il che implica che `rooms` e "partita" siano entità separate nello schema
   (→ `C01`: potrebbe servire una tabella `games`).
2. **La partita finita resta consultabile?** Se sì per quanto, e da chi?
   È il presupposto di ogni statistica futura (→ `C01`, domanda 4).
3. **La condivisione: immagine renderizzata o testo?** L'immagine è quello che
   la gente manda nel gruppo, ma generarla in Flutter web e passarla alla Web
   Share API ha i suoi attriti. Il testo formattato è l'80% del valore all'1%
   del costo — parti da lì.
4. **Cosa succede se qualcuno abbandona prima della fine?** Compare in
   classifica finale come "ritirato", o sparisce? Deciderlo qui evita
   classifiche con buchi.
