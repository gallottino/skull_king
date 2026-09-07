# [C01] Schema del database

**Epic:** Backend · **Milestone:** M2 · **Stima:** M
**Labels:** `epic:backend` `type:feat` `size:M`

## Obiettivo

Le tabelle che reggono una partita, con vincoli che rendono impossibili gli
stati incoerenti — non solo colonne, ma **regole** scritte in SQL.

## Valore

Il database è l'unico punto in cui la verità è condivisa fra tutti i device.
Se i vincoli non stanno qui, ogni client deve fidarsi degli altri.

## Schema proposto

```sql
rooms         id uuid pk, code text unique, mode text, host_id uuid,
              status text, current_round int, max_rounds int,
              created_at timestamptz, closed_at timestamptz

room_players  id uuid pk, room_id fk, player_id uuid, nickname text,
              avatar text, seat int, is_host bool, joined_at timestamptz
              unique(room_id, seat), unique(room_id, nickname)

rounds        id uuid pk, room_id fk, number int, status text,
              unique(room_id, number)

round_entries id uuid pk, round_id fk, room_player_id fk,
              bid int, tricks_won int, bonus int, points int,
              submitted_at timestamptz
              unique(round_id, room_player_id)
```

## Criteri di accettazione

- [ ] Migrazione versionata che crea tutto e gira su `supabase db reset` senza errori
- [ ] Vincoli di unicità su: codice stanza, posto al tavolo, nickname nella stanza, entry per giocatore/round
- [ ] `check` sui valori enumerati (`status`, `mode`) e sui range (`bid >= 0`)
- [ ] Cascata di cancellazione: eliminare una `room` elimina tutto il resto
- [ ] Indici su `room_players.room_id`, `rounds.room_id`, `round_entries.round_id`
- [ ] Il codice stanza è generato dal DB (funzione + default), non dal client
- [ ] Seed che crea una partita finita e una a metà, per sviluppare la UI senza giocare

## ⚠️ Domande critiche

1. **Il codice stanza: quanto lungo e con quale alfabeto?** 4 caratteri
   alfanumerici danno ~1.6M combinazioni, ma con collisioni gestite come?
   Retry sull'unique violation è la soluzione corretta. **Escludi i caratteri
   ambigui** (`0/O`, `1/I/L`): la gente detta il codice a voce a un tavolo
   rumoroso.
2. **Le stanze scadono?** Senza scadenza il DB si riempie di partite mai finite
   e i codici a 4 caratteri iniziano a collidere davvero. Serve una policy:
   una stanza è riutilizzabile dopo N ore? Un job di pulizia?
3. **`points` è calcolato dal client o dal database?** Se il client scrive i
   punti, un client vecchio o buggato scrive punteggi sbagliati per tutti.
   Alternativa: `points` come colonna generata / trigger che chiama la logica
   in SQL — ma allora la regola di punteggio esiste in **due** posti (Dart e
   SQL) e possono divergere. Terza via: il client scrive solo `bid`, `tricks`,
   `bonus` (fatti osservati) e i punti si calcolano sempre in lettura.
   👉 Consiglio la terza: i fatti sono immutabili, il punteggio è derivato.
4. **Serve una tabella `players` globale?** O l'identità esiste solo dentro una
   stanza? Se un giorno vuoi statistiche storiche ("quante partite ha vinto
   Davide"), ti serve un'identità persistente **ora** — aggiungerla dopo
   significa non avere storico. (collegato a `C02`)
5. **Il `seat` (posizione al tavolo) è persistito o calcolato?** Serve
   persistito se vuoi che l'ordine dei ritratti resti stabile fra i device: se
   ognuno ordina come gli pare, due giocatori vedono tavoli diversi.
