# [D05] Condivisione della stanza (link e QR)

**Epic:** Onboarding · **Milestone:** M3 · **Stima:** S
**Labels:** `epic:onboarding` `type:feat` `size:S`

## Obiettivo

L'host condivide la stanza con un link o un QR, così gli altri entrano senza
digitare nulla.

## Valore

Riduce l'attrito d'ingresso da "apri il browser, scrivi l'URL, scrivi il
codice" a "inquadra". Con 5 persone attorno a un tavolo, sono minuti
risparmiati ogni partita — e meno errori di battitura.

## Criteri di accettazione

- [ ] Un URL del tipo `/join/ABCD` apre l'app direttamente sul flusso di ingresso, con codice precompilato
- [ ] Pulsante di condivisione nativa (Web Share API) con fallback "copia link"
- [ ] QR generato in-app, leggibile a distanza di tavolo e con contrasto sufficiente
- [ ] Il link funziona anche per chi non ha mai aperto l'app (primo caricamento → join)
- [ ] Link a una stanza inesistente/chiusa → messaggio chiaro, non schermata bianca

## Note tecniche

- Il routing deve essere basato su URL veri (path routing) perché il deep link
  funzioni; questo richiede un fallback lato hosting su `index.html` (→ `F05`).
- Il QR va generato localmente, non tramite servizio esterno: la PWA deve
  funzionare anche con rete scarsa.

## ⚠️ Domande critiche

1. **Path routing o hash routing?** Il path (`/join/ABCD`) è più pulito ma
   richiede configurazione dell'hosting; l'hash (`/#/join/ABCD`) funziona
   ovunque ma è brutto nei messaggi condivisi. Va deciso insieme a `F05`.
2. **Il link è un segreto?** Chi ha il link entra. Se finisce in una chat di
   gruppo sbagliata, entra un estraneo. Serve un modo per l'host di espellere
   qualcuno (→ `F03`) o di "chiudere" la lobby.
3. **Web Share API non è disponibile ovunque** (in particolare su desktop
   Firefox). Il fallback "copia negli appunti" va testato, non dato per
   scontato.
4. **Il QR contiene il link o solo il codice?** Il link funziona anche da
   fotocamera di sistema, il codice no. Consiglio: il link.
