# [F05] Deploy della PWA e ambienti

**Epic:** Robustezza · **Milestone:** M5 · **Stima:** M
**Labels:** `epic:hardening` `type:chore` `size:M`

## Obiettivo

L'app è raggiungibile a un URL pubblico stabile, aggiornata automaticamente al
merge in `main`, con un ambiente di staging separato.

## Valore

Chiude il cerchio: senza deploy, tutto il lavoro precedente vive solo sul tuo
portatile. È anche il ticket che rende testabile il realtime con persone vere.

## Criteri di accettazione

- [ ] Merge in `main` → build e deploy automatici in produzione
- [ ] Ambiente di staging separato, con il proprio progetto Supabase
- [ ] URL e chiavi Supabase iniettati come secret in CI, mai committati
- [ ] Fallback dell'hosting su `index.html` per tutte le route (necessario ai deep link di `D05`)
- [ ] Header di cache corretti: `index.html` e il service worker **mai** in cache lunga, gli asset con hash sì
- [ ] HTTPS attivo (requisito per PWA e service worker)
- [ ] Lighthouse PWA + Performance eseguiti sull'URL di produzione e allegati alla PR

## ⚠️ Domande critiche

1. **Dove ospiti?** Vercel, Netlify, Cloudflare Pages e GitHub Pages fanno
   tutti il lavoro. GitHub Pages è il più semplice ma ha limiti sui redirect
   (impatta le route di `D05`). Cloudflare Pages è probabilmente il miglior
   compromesso gratuito.
2. **Cache dell'`index.html`: è il bug numero uno delle PWA.** Se viene
   cachata a lungo, gli utenti restano su una versione vecchia per giorni
   senza capire perché. Va verificato esplicitamente, non assunto.
3. **Le migrazioni del database vanno in CI?** (→ `A04`, domanda 1)
   Se sì, l'ordine conta: migrazione **prima** del deploy del client, e le
   migrazioni devono essere retrocompatibili di una versione.
4. **Serve un dominio custom?** Un URL memorabile è ciò che decide se l'app
   viene aperta la seconda volta. Costa poco ed è probabilmente la cosa con
   più impatto in questo ticket.
5. **Budget**: hai stimato cosa succede se l'app piace e la usano in 200?
   (→ `A04`, domanda 3). Meglio saperlo prima di scoprirlo con un progetto
   Supabase in pausa.
