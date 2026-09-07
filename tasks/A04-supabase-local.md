# [A04] Ambiente Supabase locale e workflow migrazioni

**Epic:** Fondamenta · **Milestone:** M0 · **Stima:** S
**Labels:** `epic:foundations` `type:chore` `size:S`

## Obiettivo

Chiunque cloni il repo può avviare uno stack Supabase locale, applicare le
migrazioni e far partire l'app puntata su di esso con un comando.

## Valore

Rende sviluppabile e testabile tutto l'Epic C senza toccare il progetto di
produzione, e mette le migrazioni sotto controllo di versione fin dal primo
giorno — cioè prima che ci siano dati veri da rimpiangere.

## Criteri di accettazione

- [ ] `supabase start` avvia lo stack locale; `supabase db reset` ricrea il DB da zero
- [ ] Le migrazioni sono file SQL versionati in `supabase/migrations/`
- [ ] Un seed (`supabase/seed.sql`) popola una stanza di prova con giocatori finti
- [ ] URL e chiave Supabase arrivano da `--dart-define`, non hardcoded nel sorgente
- [ ] Esistono almeno due ambienti distinti (locale + remoto) e cambiarli non richiede modifiche al codice
- [ ] Documentato nel README: come si avvia, come si applica una migrazione, come si punta l'app a un dispositivo in LAN

## Note tecniche

- Un telefono sulla stessa Wi-Fi non raggiunge `127.0.0.1`: serve l'indirizzo
  LAN della macchina, passato via `--dart-define=SUPABASE_URL=...`.
- La chiave `anon`/publishable è pensata per stare nel client: la sicurezza sta
  nelle RLS (→ `C03`), non nel nascondere la chiave. La `service_role` invece
  non deve mai finire in un build client, per nessun motivo.

## Fuori scope

Lo schema vero e proprio (→ `C01`), le policy RLS (→ `C03`).

## ⚠️ Domande critiche

1. **Come applichi le migrazioni in produzione?** Manualmente da CLI o da CI su
   merge in `main`? La seconda è meglio, ma richiede un token in GitHub Secrets
   e una regola chiara: **le migrazioni devono essere retrocompatibili**,
   perché una PWA in cache può avere client vecchi che parlano con schema nuovo
   (→ `A02`, domanda 1).
2. **Ti serve un ambiente di staging separato?** Con un progetto solo, ogni
   esperimento sullo schema tocca i dati veri. Supabase free permette 2
   progetti attivi: usarne uno per staging è probabilmente la scelta giusta.
3. **Hai già stimato i limiti del piano free?** Realtime su free ha un tetto di
   connessioni concorrenti e di messaggi. Con 6 giocatori per stanza il numero
   di stanze simultanee sostenibili è finito — meglio saperlo ora che scoprirlo
   la sera in cui l'app funziona.
4. **Retention dei dati**: i progetti Supabase free vengono messi in pausa dopo
   un periodo di inattività. Per un'app usata "ogni tanto la sera" è un rischio
   concreto di trovarla morta proprio quando serve.
