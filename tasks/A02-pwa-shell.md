# [A02] Shell PWA installabile

**Epic:** Fondamenta · **Milestone:** M0 · **Stima:** M
**Labels:** `epic:foundations` `type:feat` `size:M`

## Obiettivo

L'app si installa sulla home screen di Android e iOS, si apre a schermo intero
senza barra del browser, e in portrait chiede di ruotare il telefono invece
di mostrare un layout rotto.

## Valore

È il presupposto di tutta la UX: la gente gioca a Skull King attorno a un
tavolo, col telefono in mano. Se ogni volta devono aprire Chrome e ricordarsi
un URL, il tracker non viene usato. Questo ticket ha valore da solo, anche con
un'app vuota dentro.

## Criteri di accettazione

- [x] `manifest.json` completo: `name`, `short_name`, `start_url`, `display: standalone`, `orientation: landscape`, `theme_color`, `background_color`, `scope`
- [x] Icone 192, 512 e 512 `maskable` generate da `assets/icons/icon_1024x1024.png`; su iOS `apple-touch-icon` 180x180 nel `<head>`
- [ ] Installabile: manifest senza errori in DevTools > Application > Manifest, e installazione verificata **a mano** su Android (Chrome) e iOS (Safari > Aggiungi a Home)
- [ ] Installata, si apre senza barra indirizzi
- [x] Uno splash / loader personalizzato copre il caricamento del bundle Flutter (niente schermo bianco)
- [x] **Nessun service worker**: build con `--pwa-strategy=none`; una nuova versione entra in vigore al prossimo avvio, mai a partita in corso
- [x] In portrait un overlay bloccante invita a ruotare il telefono: sotto non si interagisce
- [ ] Lo schermo **non si spegne** durante l'uso (Wake Lock, con fallback silenzioso)
- [x] Un tunnel HTTPS (`cloudflared`) documentato nel README per provare l'app da telefoni veri

> Restano da spuntare i tre criteri verificabili solo su telefoni veri
> (installazione da Chrome/Safari, apertura senza barra indirizzi, Wake Lock):
> il codice c'è, serve una sessione di prova con un tunnel HTTPS.

## Note tecniche

- Build: `flutter build web --release --pwa-strategy=none`. Senza service worker
  ogni avvio prende i file dalla rete: l'app è sempre aggiornata, ma il deploy
  (-> `F05`) deve servire `index.html` con `Cache-Control: no-cache` e gli asset
  con hash a cache lunga, altrimenti il secondo avvio è lento.
- Icone: rigenerabili con `./tool/generate_web_icons.sh` (ImageMagick). La
  variante `maskable` ha l'icona all'80% su fondo pieno, altrimenti Android ne
  taglia il bordo; l'icona iOS è senza trasparenza, che Safari renderebbe nera.
- Colori dal brand dell'icona: legno scuro come `background_color`, oro/pergamena
  per il loader (-> `A03` li formalizza nel tema).
- Landscape: `orientation: landscape` nel manifest copre Android; iOS lo ignora,
  quindi l'overlay in portrait è la vera implementazione, non un fallback.
- Wake Lock API: `navigator.wakeLock.request('screen')`, da ri-acquisire
  sull'evento `visibilitychange`. Non supportata ovunque -> `try/catch` e
  degradazione silenziosa.
- Il primo caricamento di un'app Flutter web è pesante (CanvasKit + font +
  asset). Misuralo su 4G reale, non su localhost.

## Fuori scope

Qualsiasi funzionamento offline: senza rete l'app non si apre, e il messaggio
di errore quando la connessione cade è di `F04`. Tema e componenti sono di `A03`:
qui si fissano solo i colori del manifest e del loader.

## ✅ Decisioni prese

1. **Aggiornamento della PWA: solo al prossimo avvio.** Niente banner, niente
   reload forzato. In pratica si ottiene rinunciando al service worker (vedi 3):
   ogni apertura carica l'ultima build, e chi sta giocando non viene mai
   interrotto a metà round. Il prezzo: un giocatore che tiene l'app aperta per
   ore resta su una build vecchia finché non la riapre -> `F04` dovrà gestire
   il caso di uno schema dati incompatibile mostrando un errore chiaro.
2. **Landscape obbligatorio.** Il layout è pensato in orizzontale. Nel manifest
   `orientation: landscape` (rispettato da Android), e in portrait un overlay
   bloccante "ruota il telefono": sotto non si interagisce. iOS ignora il
   manifest, quindi l'overlay è l'unica cosa che conta davvero lì.
3. **Niente cache offline.** Nessun service worker: l'app richiede rete, ed è
   coerente con un tracker realtime che senza rete non può sincronizzare
   niente. Verificato: l'installabilità **non** ne risente, perché da
   Chrome 108 (mobile) / 112 (desktop) il service worker non è più un
   requisito di installazione — bastano HTTPS e un manifest valido.
4. **Test su device reali con un tunnel HTTPS** (`cloudflared`/`ngrok`): zero
   certificati da installare sui telefoni, e funziona anche fuori dalla LAN.
   URL diverso a ogni avvio, accettabile per lo sviluppo.

### Nota su Lighthouse

Il criterio originale "Lighthouse -> categoria Installable" non è più
eseguibile: **Lighthouse ha rimosso la categoria PWA in v12** (maggio 2024),
proprio in seguito al cambio dei criteri di installabilità di Chrome. Al suo
posto: DevTools > Application > Manifest (nessun errore) più l'installazione
provata a mano sui due sistemi.
