# [A02] Shell PWA installabile

**Epic:** Fondamenta · **Milestone:** M0 · **Stima:** M
**Labels:** `epic:foundations` `type:feat` `size:M`

## Obiettivo

L'app si installa sulla home screen di Android e iOS, si apre a schermo intero
senza barra del browser, e mostra qualcosa di sensato anche senza rete.

## Valore

È il presupposto di tutta la UX: la gente gioca a Skull King attorno a un
tavolo, col telefono in mano. Se ogni volta devono aprire Chrome e ricordarsi
un URL, il tracker non viene usato. Questo ticket ha valore da solo, anche con
un'app vuota dentro.

## Criteri di accettazione

- [ ] `manifest.json` completo: `name`, `short_name`, `start_url`, `display: standalone`, `theme_color`, `background_color`, `scope`
- [ ] Icone: 192, 512 e 512 `maskable`; su iOS `apple-touch-icon` 180×180 nel `<head>`
- [ ] Lighthouse → categoria "Installable" senza errori
- [ ] Installata da Android (Chrome) e da iOS (Safari → *Aggiungi a Home*) si apre senza barra indirizzi
- [ ] Uno splash / loader personalizzato copre il caricamento del bundle Flutter (niente schermo bianco)
- [ ] Il service worker serve la shell da cache al secondo avvio
- [ ] Lo schermo **non si spegne** durante l'uso (Wake Lock, con fallback silenzioso)

## Note tecniche

- Il service worker lo genera Flutter (`flutter_service_worker.js`); il punto
  delicato è la **strategia di aggiornamento**, non la generazione.
- Wake Lock API: `navigator.wakeLock.request('screen')`, da ri-acquisire
  sull'evento `visibilitychange`. Non supportata ovunque → `try/catch` e
  degradazione silenziosa.
- Il primo caricamento di un'app Flutter web è pesante (CanvasKit + font +
  asset). Misuralo su 4G reale, non su localhost.

## Fuori scope

Funzionamento offline *dei dati* di partita (→ `F04`). Qui si mette in cache
solo la shell.

## ⚠️ Domande critiche

1. **Come gestisci l'aggiornamento della PWA a metà partita?** È il problema
   più sottovalutato delle PWA. Se pubblichi una nuova versione mentre una
   partita è in corso, alcuni giocatori possono restare su una build vecchia
   con uno schema dati diverso. Serve una decisione esplicita:
   ricarica forzata? banner "nuova versione disponibile"? blocco durante una
   partita attiva? (collegato a `F04`)
2. **iOS ignora `orientation` nel manifest.** Se il layout del tavolo è
   pensato in landscape, su iPhone devi gestirlo tu: o supporti il portrait,
   o mostri un invito a ruotare. Quale?
3. **Serve davvero l'offline?** Un tracker di punteggio realtime senza rete non
   può sincronizzare nulla. Forse la risposta onesta è: la shell si apre
   offline e mostra "sei offline", ma la partita richiede connessione.
   Deciderlo ora evita di costruire un layer di sync che non serve.
4. **Su HTTPS/LAN**: i service worker girano solo su origini sicure.
   In sviluppo su un telefono nella stessa rete servirà un certificato
   (mkcert) o un tunnel. Vale la pena metterlo a punto ora, perché altrimenti
   non potrai testare il realtime con due device veri.
