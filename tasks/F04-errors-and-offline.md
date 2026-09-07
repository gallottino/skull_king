# [F04] Stati di errore, caricamento e offline

**Epic:** Robustezza · **Milestone:** M5 · **Stima:** M
**Labels:** `epic:hardening` `type:feat` `size:M`

## Obiettivo

Ogni schermata ha uno stato di caricamento, uno stato vuoto e uno stato di
errore con una via d'uscita. Nessun crash silenzioso, nessuno spinner infinito.

## Valore

La differenza percepita fra "prototipo" e "app" sta quasi tutta qui. È anche
ciò che rende diagnosticabile un problema segnalato da un amico via messaggio.

## Criteri di accettazione

- [ ] Nessuna schermata può restare in caricamento indefinito: c'è sempre un timeout con azione di riprova
- [ ] I messaggi di errore sono in italiano, comprensibili, e dicono cosa fare — mai un codice Postgrest grezzo
- [ ] Banner di stato offline, che sparisce da solo al ritorno della rete
- [ ] Gli errori non gestiti vengono catturati e mostrati come schermata di errore recuperabile, non come schermo grigio
- [ ] La versione della build è visibile da qualche parte nell'app (serve per i bug report)
- [ ] Quando esce una nuova versione della PWA, l'utente lo sa e può aggiornare — senza essere interrotto a metà round

## ⚠️ Domande critiche

1. **Serve un servizio di error tracking?** Senza, un bug che capita solo sul
   telefono di un amico è impossibile da diagnosticare: non hai i log.
   Sentry ha un piano free ed è probabilmente la scelta giusta — ma è
   telemetria su persone reali: va detto, almeno nel README.
2. **Come gestisci l'aggiornamento della PWA a partita in corso?**
   (→ `A02`, domanda 1). Consiglio: rilevare la nuova versione, ma applicarla
   solo fuori da una partita attiva, o al prossimo avvio.
3. **Cosa fai se il client ha uno schema più vecchio del database?**
   Serve almeno un numero di versione dello schema scambiato all'ingresso in
   stanza, con un messaggio "aggiorna l'app" invece di errori incomprensibili.
4. **Quanto insistere sul retry automatico?** Riprovare all'infinito su un
   errore di permessi (RLS) genera solo traffico. Distingui errori transitori
   da errori definitivi.
