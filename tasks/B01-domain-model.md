# [B01] Modello di dominio della partita

**Epic:** Dominio e punteggio · **Milestone:** M1 · **Stima:** S
**Labels:** `epic:domain` `type:feat` `size:S`

## Obiettivo

Definire in Dart puro le entità della partita e la macchina a stati che la
governa, senza alcuna dipendenza da Flutter o da Supabase.

## Valore

È il vocabolario condiviso fra UI, database e realtime. Definirlo prima evita
che lo schema SQL e i widget inventino due modelli diversi che poi vanno
riconciliati a mano a ogni feature.

## Entità

```
GameMode      classica | espansione  → regole attive, numero di round
Room          id, code, mode, hostPlayerId, status, currentRound, createdAt
RoomStatus    lobby → bidding → playing → roundReview → finished (+ abandoned)
RoomPlayer    id, roomId, nickname, avatar, seat, isHost, joinedAt
Round         roomId, number, status, cardsDealt
RoundEntry    roundId, playerId, bid, tricksWon, bonus, points
```

## Criteri di accettazione

- [ ] Nessun `import 'package:flutter/...'` in `lib/domain/`
- [ ] Le transizioni di stato illegali sono impossibili da rappresentare o sollevano errore (es. `lobby → finished`)
- [ ] Ogni entità è immutabile, con `copyWith` e uguaglianza per valore
- [ ] Serializzazione JSON con nomi colonna `snake_case` allineati a `C01`
- [ ] Test: le transizioni valide e almeno 5 invalide sono coperte
- [ ] `Room` sa dire da sola: quanti round mancano, se il round corrente è l'ultimo, chi non ha ancora puntato

## Fuori scope

Persistenza (→ `C01`), calcolo dei punti (→ `B02`).

## ⚠️ Domande critiche

1. **Quanti round dura una partita?** Il flow parla di "ultimo round" senza
   dirlo. Skull King distribuisce 1 carta al round 1, 2 al round 2, ecc. → il
   numero di round è limitato dalle carte del mazzo diviso i giocatori.
   Con molti giocatori, 10 round **non stanno nel mazzo**. Serve una decisione:
   (a) sempre 10 e chi se ne importa; (b) `min(10, carteMazzo ~/ giocatori)`;
   (c) l'host lo sceglie a mano quando crea la stanza. La (c) è la più
   semplice da spiegare e la più difficile da sbagliare.
2. **`roundReview` è uno stato separato o è `playing` con i dati completi?**
   Dal flow, dopo che tutti hanno puntato si apre una schermata che mostra
   *insieme* la classifica precedente e il form dei punti. Sono due stati o
   uno solo? Da questo dipende quanti passaggi di UI devi sincronizzare.
3. **Si può entrare in una stanza a partita già iniziata?** Se sì, quel
   giocatore parte con quanti punti — zero, o la media? Se no, cosa vede chi
   apre il link a metà partita? (collegato a `D03`)
4. **La modalità può essere cambiata dopo la creazione della stanza?**
   Cambiare da classica a espansione a metà partita invalida i punteggi già
   calcolati. Suggerimento: renderla immutabile dopo il primo round.
5. **Numero minimo di giocatori per iniziare.** Skull King ne vuole almeno 2.
   Vale la pena impedire l'avvio con 1 solo giocatore, o lasciar fare per il
   test?
