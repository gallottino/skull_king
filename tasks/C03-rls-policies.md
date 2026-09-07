# [C03] Row Level Security e regole di accesso

**Epic:** Backend · **Milestone:** M2 · **Stima:** M
**Labels:** `epic:backend` `type:feat` `size:M`

## Obiettivo

Le policy che stabiliscono chi legge e chi scrive cosa. Con la chiave anon nel
client, **le RLS sono l'unica sicurezza esistente**.

## Valore

Senza RLS corrette, chiunque abbia l'URL dell'app può leggere tutte le stanze e
riscrivere qualsiasi punteggio. Con RLS troppo strette, l'app semplicemente non
funziona e passi ore a debuggare query che tornano array vuoti.

## Regole da esprimere

- Leggere una stanza: solo chi ne è membro (o chiunque conosca il codice esatto, per il join)
- Entrare in una stanza: consentito solo se la stanza è in `lobby` e non è piena
- Scrivere la propria puntata: solo il giocatore stesso, solo nel round corrente, solo prima della chiusura
- Cambiare lo stato della stanza / chiudere un round: solo l'host
- Nessuno può cancellare righe di partita (cancellazione logica, non fisica)

## Criteri di accettazione

- [ ] RLS abilitate su **tutte** le tabelle (una tabella senza RLS con chiave anon è pubblica in scrittura)
- [ ] Test automatici che verificano sia i permessi concessi sia quelli **negati**
- [ ] Un giocatore non può modificare l'entry di un altro giocatore
- [ ] Un giocatore non-host non può cambiare `rooms.status` né `current_round`
- [ ] Nessuna policy usa `using (true)` in scrittura
- [ ] Le entry di un round chiuso diventano immutabili per tutti tranne l'host (→ `F02`)

## Note tecniche

- Il join tramite codice richiede una lettura *prima* di essere membri: risolvi
  con una funzione `security definer` che accetta il codice e restituisce solo
  l'id e lo stato della stanza — non l'intera tabella in lettura pubblica.
- Le policy vanno versionate in migrazione come tutto il resto.

## ⚠️ Domande critiche

1. **Le puntate sono segrete fino a che tutti hanno puntato?** Il flow dice
   "Non tutti i giocatori hanno ancora scommesso" → attesa. Se le puntate
   fossero visibili in tempo reale, chi punta per ultimo avrebbe un vantaggio.
   **Se devono essere segrete, non basta nasconderle nella UI**: il client
   riceve comunque le righe via realtime e chiunque apra la console le vede.
   Serve una vista/funzione che mascheri le puntate altrui finché il round non
   è "tutti dentro". È una decisione con impatto architetturale reale.
2. **Chi conosce il codice può leggere la stanza: basta?** I codici corti sono
   enumerabili. Con 4 caratteri, uno script trova tutte le stanze attive in
   pochi minuti. Impatto reale: basso (sono punteggi), ma sappilo.
3. **Rate limiting?** Nulla impedisce a un client buggato di scrivere 100
   update al secondo e bruciare la quota del progetto. Vale la pena mettere un
   throttle lato client come minimo.
4. **Come testi le RLS?** Testarle a mano dalla dashboard non scala. Serve un
   test SQL (pgTAP) o un test di integrazione Dart con due client autenticati
   diversi. Consiglio il secondo: testa anche il layer repository di `C04`.
