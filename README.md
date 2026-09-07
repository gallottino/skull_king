# Skull King Score Tracker

Segnapunti condiviso per [Skull King](https://en.wikipedia.org/wiki/Skull_King):
si crea una stanza, gli altri entrano con un codice, ognuno inserisce puntata e
prese e l'app calcola i punteggi round dopo round. Flutter, distribuito come PWA.

## Avvio

```sh
flutter --version          # atteso: 3.47.2 (versione pinnata, vedi pubspec.yaml)
flutter pub get
flutter run -d chrome
```

## Test e qualità

```sh
flutter test --coverage    # coverage/lcov.info
flutter analyze --fatal-infos
dart format .
```

Gli stessi tre comandi girano in CI su ogni PR verso `main`, insieme a
`flutter build web --release`: una PR non si merge-a con la CI rossa.

## Contribuire

`main` è protetto: si lavora su un branch e si apre una PR. Il merge è in
**squash** e il titolo della PR deve seguire i
[Conventional Commits](https://www.conventionalcommits.org) (`feat:`, `fix:`,
`chore:`…): è da lì che [release-please](https://github.com/googleapis/release-please)
calcola la versione, aggiorna `CHANGELOG.md` e crea il tag.

Il backlog vive in [`tasks/`](tasks/): un file per issue, con criteri di
accettazione e domande critiche da chiudere prima di scrivere codice.
