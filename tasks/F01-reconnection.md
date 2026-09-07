# [F01] Riconnessione e ripresa dello stato

**Epic:** Robustezza · **Milestone:** M5 · **Stima:** M
**Labels:** `epic:hardening` `type:feat` `size:M`

## Obiettivo

Chi perde la rete, blocca lo schermo, cambia app o ricarica la pagina rientra
esattamente dov'era, senza perdere né dati né posto al tavolo.

## Valore

**Questo non è un caso limite: è la normalità.** Una partita dura 45 minuti,
i telefoni si bloccano, il Wi-Fi salta, qualcuno risponde a un messaggio.
Se l'app non regge questo, non regge una partita vera.

## Criteri di accettazione

- [ ] Refresh della pagina in **ogni** fase (lobby, puntata, attesa, inserimento, classifica) riporta allo stato corretto
- [ ] Riportare l'app in foreground dopo minuti in background riallinea lo stato senza intervento
- [ ] La perdita di rete mostra un indicatore non invadente; il ritorno lo rimuove e risincronizza
- [ ] Le sottoscrizioni realtime si riagganciano da sole, con backoff
- [ ] I dati inseriti e non ancora inviati non vengono persi durante una disconnessione
- [ ] Test manuale documentato: modalità aereo per 30s a metà round, su ogni fase

## ⚠️ Domande critiche

1. **Al ritorno in foreground: re-fetch completo o si fida degli eventi
   realtime?** Gli eventi persi durante il background non vengono recapitati.
   L'unica strada sicura è un re-fetch completo su `resume`. Costa una query,
   evita un'intera classe di bug fantasma.
2. **Cosa fai con una scrittura in sospeso quando la rete torna?**
   La reinvii (rischio: duplicati) o la scarti chiedendo conferma?
   Con chiavi idempotenti (`unique(round_id, player_id)`) reinviare è sicuro:
   vale la pena averle previste in `C01`.
3. **Come distingui "disconnesso" da "uscito"?** Per l'attesa di `E04` è
   cruciale: aspettare all'infinito uno che ha chiuso l'app è il modo più
   comune in cui una sessione muore.
4. **Su iOS la PWA in background viene sospesa aggressivamente**, e le
   WebSocket cadono. Va testato su iPhone vero, non solo in simulatore.
