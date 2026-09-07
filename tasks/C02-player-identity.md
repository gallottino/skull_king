# [C02] Identità del giocatore e sessione persistente

**Epic:** Backend · **Milestone:** M2 · **Stima:** M
**Labels:** `epic:backend` `type:feat` `size:M` `needs-decision`

## Obiettivo

Ogni device ha un'identità stabile che sopravvive a un refresh, alla chiusura
della PWA e a un cambio di rete, così che rientrando si torni al proprio posto
al tavolo invece di crearne uno nuovo.

## Valore

Senza questo, chiunque ricarichi la pagina diventa un fantasma: un giocatore in
più al tavolo, e i suoi punti persi. In una partita da 45 minuti su telefoni che
si spengono, succede *ogni* partita.

## Criteri di accettazione

- [ ] Al primo avvio viene creata un'identità e salvata localmente
- [ ] Un refresh della pagina riporta lo stesso giocatore nella stessa stanza, allo stesso posto
- [ ] La sessione sopravvive alla chiusura e riapertura della PWA
- [ ] Il rientro in stanza è idempotente: non crea duplicati
- [ ] Se l'identità locale non corrisponde a nessuna stanza attiva, l'app torna alla schermata iniziale senza errori
- [ ] Test: due tab dello stesso browser sono lo stesso giocatore o due giocatori distinti — comportamento definito e verificato

## Opzioni

| | Auth anonima Supabase | `device_id` in `localStorage` |
|---|---|---|
| RLS | `auth.uid()` usabile, policy pulite | policy basate su un valore che il client dichiara |
| Setup | va abilitata nel progetto | zero |
| Sicurezza | reale | fiducia (chiunque può dichiararsi un altro) |
| Utenti fantasma | crea un utente per device | nessuno |

## ⚠️ Domande critiche

1. **Quanta sicurezza serve davvero?** Il modello di minaccia è: "un amico
   modifica i suoi punti dalla console". È una partita fra amici — ma se
   qualcuno *può* barare in 30 secondi, prima o poi lo fa per scherzo e il
   tracker perde credibilità. L'auth anonima costa poco e chiude il tema:
   la consiglio.
2. **`localStorage` in una PWA iOS può essere ripulito** dopo periodi di
   inattività o in navigazione privata. Se l'identità sta solo lì, il giocatore
   viene espulso. Serve un fallback: rientro tramite codice stanza + nickname?
3. **Un utente anonimo Supabase per device: quanti ne accumuli?** Con auth
   anonima ogni telefono che apre l'app crea una riga in `auth.users`, per
   sempre. Serve una policy di pulizia degli anonimi inattivi.
4. **Stesso device, due partite consecutive**: mantieni lo stesso player id o
   ne generi uno nuovo? Se lo mantieni ottieni gratis lo storico (→ `C01`,
   domanda 4); se lo rigeneri, ogni partita è isolata.
5. **Cosa succede se la stessa persona apre l'app su due device?** Diventa due
   giocatori. Va impedito, o è un caso che semplicemente ignoriamo?
