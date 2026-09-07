# [B02] Motore di punteggio — regole classiche

**Epic:** Dominio e punteggio · **Milestone:** M1 · **Stima:** M
**Labels:** `epic:domain` `type:feat` `size:M` `needs-decision`

## Obiettivo

Una funzione pura che, dati puntata e prese di un giocatore in un round,
restituisce il punteggio di quel round. Zero dipendenze, zero I/O.

## Valore

**È il prodotto.** Tutto il resto — stanze, realtime, ritratti da pirata — è
l'astuccio attorno a questa funzione. Se sbaglia, l'app è peggio di un foglio
di carta, perché nessuno se ne accorge fino a fine partita.

## Regole da implementare (classica)

| Caso | Punti |
|---|---|
| Puntata > 0, indovinata | `20 × puntata` |
| Puntata > 0, sbagliata | `−10 × |prese − puntata|` |
| Puntata = 0, indovinata | `10 × numeroRound` |
| Puntata = 0, sbagliata | `−10 × numeroRound` |

Il punteggio di partita è la somma cumulativa dei round.

## Criteri di accettazione

- [ ] `int scoreFor({required int bid, required int tricksWon, required int roundNumber, ...})`, pura e deterministica
- [ ] Tabella di test con **tutti** i casi limite: puntata 0 indovinata/sbagliata, puntata piena, prese > puntata, prese < puntata, round 1 e round finale
- [ ] Test di proprietà: il punteggio è 0 solo dove le regole lo prevedono; puntata sbagliata ⇒ punteggio ≤ 0
- [ ] Il calcolo della classifica gestisce i **pareggi** con una regola dichiarata
- [ ] La funzione rifiuta input impossibili (puntata negativa, prese > carte del round) con un errore esplicito, non con un numero sbagliato
- [ ] Coverage 100% su questo file

## Note tecniche

Scrivi prima la tabella dei test, poi l'implementazione. Il costo è mezz'ora e
il ritorno è non dover mai più discutere se un punteggio è giusto.

## Fuori scope

Bonus dell'espansione (→ `B03`), UI (→ `E05`).

## ⚠️ Domande critiche

1. **Quale edizione delle regole?** Le edizioni di Skull King differiscono sul
   punteggio della puntata a zero (`10 × round` vs `10 × carte in mano`, che
   coincidono solo se si distribuisce una carta per round) e su alcuni bonus.
   Fissa **una** edizione, scrivila nel README e non guardare più altre fonti:
   è la causa numero uno di litigi a tavolino.
2. **Il numero di prese totali deve corrispondere al round?** In teoria sì: in
   un round da 5 carte si vincono esattamente 5 prese. Se l'app valida questa
   somma, intercetta la maggior parte degli errori di inserimento — ma il
   Kraken (in espansione) **annulla una presa**, quindi la somma può essere
   minore. Decidi: validazione stretta in classica, tollerante in espansione?
   Oppure solo un avviso non bloccante?
3. **Servono punteggi negativi cumulativi?** Sì nelle regole, ma vale la pena
   confermare che l'UI li mostri correttamente (il segno meno su un font
   decorativo è un classico bug di leggibilità → `A03`).
4. **Pareggio in classifica finale**: chi vince? Regola ufficiale spesso
   assente. Proposte: si condivide il primo posto; oppure vince chi ha
   indovinato più puntate. Va deciso **prima** di `E09`, non durante.
5. **Il motore deve poter ricalcolare una partita intera da zero?**
   Se sì (raccomandato), i punti nel DB sono una *cache* derivabile, e
   correggere un round passato (→ `F02`) diventa banale. Se no, ogni
   correzione è una migrazione di dati.
