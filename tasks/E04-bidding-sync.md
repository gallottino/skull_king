# [E04] Attesa sincronizzata delle puntate

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** S
**Labels:** `epic:gameplay` `type:feat` `size:S`

## Obiettivo

Il nodo decisionale del flow: finché non hanno puntato tutti si resta in
attesa; quando l'ultimo punta, tutti i device avanzano insieme alla fase di
gioco del round.

## Valore

È la sincronizzazione che giustifica l'uso di Supabase realtime. Senza,
l'app è solo una calcolatrice condivisa male.

## Criteri di accettazione

- [ ] La schermata di attesa mostra **chi** manca, non solo un conteggio
- [ ] La transizione avviene automaticamente quando l'ultima puntata arriva, su tutti i device
- [ ] Le puntate vengono rivelate tutte insieme, con un momento di reveal riconoscibile
- [ ] La condizione "hanno puntato tutti" è valutata dal database, non da ciascun client separatamente
- [ ] Un client che si riconnette in questo momento vede lo stato corretto, non quello precedente
- [ ] Test: con N giocatori, la transizione scatta esattamente all'N-esima puntata, mai prima

## Note tecniche

Far valutare la condizione a ogni client ("ho ricevuto N entry, avanzo") è
fragile: chi ha perso un evento realtime resta indietro. Meglio un trigger o
una RPC che, all'arrivo dell'ultima puntata, aggiorna `rounds.status` — e i
client reagiscono a **quello**.

## ⚠️ Domande critiche

1. **Chi fa avanzare lo stato?** Trigger sul database (robusto, logica in SQL),
   l'host come "arbitro" (semplice, ma se l'host è offline la partita si
   blocca), o ogni client (fragile). La scelta si ripete identica in `E06`:
   fai una scelta sola e applicala a entrambi.
2. **Timeout sull'attesa?** Dopo 2 minuti che manca uno, si mostra all'host
   un'opzione per procedere? Vedi `E03`, domanda 3.
3. **Il reveal è un'animazione o un cambio secco?** È il momento più
   emozionante del round: vale un po' di lavoro di UI. Ma attenzione a
   rispettare "riduci movimento" (→ `A03`).
4. **Se un giocatore entra/esce fra la prima e l'ultima puntata**, il totale
   atteso cambia sotto i piedi. Il numero di giocatori del round va
   "congelato" all'inizio del round?
