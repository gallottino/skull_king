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
- [ ] La coverage viene prodotta e pubblicata come artefatto (senza soglia bloccante)
- [ ] La versione di Flutter è **pinnata a `3.47.2`** in CI e in `pubspec.yaml`,
      e un aggiornamento richiede una PR dedicata
- [ ] I commit seguono **Conventional Commits**, verificati automaticamente in PR
- [ ] Un merge su `main` produce da solo tag, `CHANGELOG.md` e bump di versione
      in `pubspec.yaml` (nessun bump manuale)
- [ ] `main` è protetto: no push diretto, PR con CI verde obbligatoria
- [ ] `README.md` spiega in 10 righe: cos'è, come si avvia, come si testa

## Note tecniche

- GitHub Actions: `subosito/flutter-action` con `flutter-version: 3.47.2` e
  `channel: stable`; stessa versione in `pubspec.yaml`
  (`environment: flutter: 3.47.2`, `sdk: ^3.13.2`).
- Cache di `~/.pub-cache` per non pagare la risoluzione a ogni run.
- Aggiungi `dart format --set-exit-if-changed .` come step: elimina per sempre
  le PR con diff di formattazione.
- Release: `googleapis/release-please-action` con `release-type: dart` — legge i
  Conventional Commits, apre una "release PR" che aggiorna `pubspec.yaml` e
  `CHANGELOG.md`, e al merge crea tag e GitHub Release.
- Lint dei commit: merge in **squash**, così il titolo della PR diventa il
  messaggio di commit; validalo con `amannn/action-semantic-pull-request`
  (tipi ammessi: `feat` `fix` `chore` `docs` `refactor` `test` `perf` `ci`).

## Fuori scope

Deploy (→ `F05`), test end-to-end su browser reale (→ `F05`).
Soglia di coverage bloccante (→ rimandata a `B01`/`B02`, vedi decisione 2).

## ✅ Decisioni prese

1. **Versione di Flutter: pinnata a `3.47.2`** (stable, Dart 3.13.2 — la
   versione oggi installata in locale). Seguire `stable` significa che una
   release di Flutter può rompere la CI in un giorno in cui non hai toccato
   nulla. L'aggiornamento si fa con una PR dedicata, mai di soppiatto.
2. **Nessuna soglia di coverage bloccante, per ora.** La coverage si produce e
   si pubblica come artefatto. Il gate bloccante su `lib/domain/` (il motore di
   punteggio) si aggiungerà come criterio di accettazione quando inizierà il
   lavoro sul dominio → `B01`/`B02`. Bloccare la coverage sulla UI produce solo
   test finti.
3. **Conventional Commits + release automatica.** Il numero di versione serve a
   capire *quale build* aveva in mano chi segnala un bug (→ `F04`): deve quindi
   essere generato dalla pipeline, non scritto a mano. Ogni merge su `main`
   aggiorna `CHANGELOG.md`, `pubspec.yaml` e crea un tag.
