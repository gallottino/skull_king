# [C04] Livello repository e stream realtime

**Epic:** Backend · **Milestone:** M2 · **Stima:** M
**Labels:** `epic:backend` `type:feat` `size:M`

## Obiettivo

Un'API Dart tipizzata sopra Supabase: la UI chiede `roomStream(roomId)` e
riceve oggetti di dominio aggiornati, senza mai vedere una `Map<String, dynamic>`
né un errore di Postgrest.

## Valore

Isola l'app dal backend. È ciò che permette di testare tutte le schermate
dell'Epic D/E con un repository finto, senza database.

## Criteri di accettazione

- [ ] Interfacce di dominio (`RoomRepository`, `RoundRepository`) con implementazione Supabase e implementazione **fake** in memoria
- [ ] `Stream<RoomState>` che emette lo stato completo della stanza a ogni cambiamento (giocatori, round, entry)
- [ ] Gli errori di rete/DB sono tradotti in eccezioni di dominio con messaggi mostrabili all'utente
- [ ] Le sottoscrizioni realtime vengono chiuse quando la schermata viene smontata (nessun leak)
- [ ] Riconnessione automatica dopo perdita di rete, con re-fetch dello stato (base per `F01`)
- [ ] Test del layer con il fake, più almeno un test di integrazione contro lo stack locale

## Note tecniche

- Supabase offre tre meccanismi diversi: **Postgres Changes** (eventi sulle
  righe), **Broadcast** (messaggi effimeri), **Presence** (chi è online).
  Servono probabilmente tutti e tre, per cose diverse.
- Un `RoomState` unico che aggrega tutto è più semplice da consumare di quattro
  stream separati che la UI deve ricombinare.

## ⚠️ Domande critiche

1. **Postgres Changes o Broadcast?** Postgres Changes è più semplice ma
   **rispetta le RLS ed è più costoso in termini di risorse**; con molte
   stanze concorrenti il tetto arriva prima. Broadcast è leggero ma non è la
   verità del database: rischi di mostrare uno stato che il DB non ha.
   Consiglio: Postgres Changes come sorgente di verità, Broadcast solo per
   segnali effimeri ("sta scrivendo…").
2. **Presence per capire chi è connesso davvero?** Il flow ha uno stato di
   attesa ("non ci sono ancora tutti i giocatori"). Con la sola tabella
   `room_players` non distingui *iscritto* da *presente ora*. Se un giocatore
   chiude l'app, l'host aspetta all'infinito senza sapere perché.
3. **Stato ottimistico o attesa della conferma?** Su rete mobile, aspettare il
   round-trip prima di mostrare la propria puntata è un secondo di attesa
   percepita. Con l'ottimismo devi gestire il rollback su errore. Decidilo una
   volta e applicalo uniformemente.
4. **Cosa fai con gli eventi arrivati fuori ordine o duplicati?** Il realtime
   non garantisce l'ordine in tutte le condizioni. Se lo stato è sempre
   ricostruito da un `select` completo dopo l'evento, il problema sparisce al
   costo di una query in più.
5. **Quanti stream tiene aperti un device?** Uno per stanza è ragionevole. Uno
   per tabella × per widget porta a esaurire le connessioni.
