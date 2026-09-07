# [A01] Setup repository, CI e qualità del codice

**Epic:** Fondamenta · **Milestone:** M0 · **Stima:** S
**Labels:** `epic:foundations` `type:chore` `size:S`

## Obiettivo

Ogni push ha una verifica automatica: analisi statica, test e build web.
Da qui in poi nessun ticket si chiude con la CI rossa.

## Valore

È l'unico ticket che rende sicuri tutti gli altri. Su un progetto dove la
logica di punteggio è la feature (e un bug di punteggio si scopre solo a fine
partita, quando è troppo tardi), la rete di test non è opzionale.

## Criteri di accettazione

- [ ] `flutter analyze` non produce warning (lint attivi almeno `flutter_lints`)
- [ ] `flutter test` gira in CI su ogni push e PR verso `main`
- [ ] `flutter build web --release` gira in CI e fallisce la pipeline se rompe
- [ ] La coverage viene prodotta e pubblicata come artefatto (anche senza soglia bloccante)
- [ ] `main` è protetto: no push diretto, PR con CI verde obbligatoria
- [ ] `README.md` spiega in 10 righe: cos'è, come si avvia, come si testa

## Note tecniche

- GitHub Actions: `subosito/flutter-action`, versione Flutter **pinnata** in
  `.github/workflows/ci.yml` e nel `pubspec.yaml` (`environment: flutter:`).
- Cache di `~/.pub-cache` per non pagare la risoluzione a ogni run.
- Aggiungi `dart format --set-exit-if-changed .` come step: elimina per sempre
  le PR con diff di formattazione.

## Fuori scope

Deploy (→ `F05`), test end-to-end su browser reale (→ `F05`).

## ⚠️ Domande critiche

1. **Pinnare Flutter a una versione fissa o seguire `stable`?**
   Seguire `stable` significa che una release di Flutter può rompere la tua CI
   in un giorno in cui non hai toccato nulla. Con Flutter web questo è successo
   più volte (rimozione del renderer HTML, cambi al service worker generato).
   Consiglio: **pinnare**, e aggiornare con una PR dedicata.
2. **Vuoi una soglia di coverage bloccante?** Suggerimento: no all'inizio, ma
   sì **solo su `lib/domain/`** (il motore di punteggio) appena esiste `B02`.
   Bloccare la coverage sulla UI produce solo test finti.
3. **Conventional commits + release automatica, o versionamento manuale?**
   Per una PWA che si aggiorna da sola il numero di versione conta poco per
   l'utente, ma serve tantissimo per capire *quale build* aveva in mano chi ti
   segnala un bug (vedi `F04`).
