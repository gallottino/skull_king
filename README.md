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

L'app è una PWA installabile: si aggiunge alla home da Chrome (Android) e da
Safari (iOS → *Aggiungi a Home*) e si apre a schermo intero. È pensata **solo in
orizzontale**: in portrait mostra un invito a ruotare il telefono. Non ha service
worker, quindi richiede rete e ogni avvio carica l'ultima versione pubblicata.

```sh
flutter build web --release --pwa-strategy=none
```

### Provarla da un telefono vero

L'installazione come PWA e il Wake Lock richiedono un'origine sicura:
`localhost` lo è, l'IP della LAN no. Per il test con due device serve un tunnel HTTPS:

```sh
flutter run -d web-server --web-port 8080
cloudflared tunnel --url http://localhost:8080   # stampa un URL https:// pubblico
```

## Test e qualità

```sh
flutter test --coverage    # coverage/lcov.info
flutter analyze --fatal-infos
dart format .
```

Gli stessi tre comandi girano in CI su ogni PR verso `main`, insieme a
`flutter build web --release --pwa-strategy=none`: una PR non si merge-a con la CI rossa.

## Contribuire

`main` è protetto: si lavora su un branch e si apre una PR. Il merge è in
**squash** e il titolo della PR deve seguire i
[Conventional Commits](https://www.conventionalcommits.org) (`feat:`, `fix:`,
`chore:`…): è da lì che [release-please](https://github.com/googleapis/release-please)
calcola la versione, aggiorna `CHANGELOG.md` e crea il tag.

Il backlog vive in [`tasks/`](tasks/): un file per issue, con criteri di
accettazione e domande critiche da chiudere prima di scrivere codice.
