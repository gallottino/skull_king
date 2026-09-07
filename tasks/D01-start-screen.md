# [D01] Schermata iniziale: crea o unisciti

**Epic:** Onboarding · **Milestone:** M3 · **Stima:** XS
**Labels:** `epic:onboarding` `type:feat` `size:XS`

## Obiettivo

Il primo nodo del flow: l'utente sceglie fra *nuova stanza* e *unisciti a
stanza*. Due sole azioni, nient'altro.

## Valore

È la porta d'ingresso. Va fatta presto perché è il punto in cui si aggancia
tutta la navigazione, e perché è testabile senza backend.

## Criteri di accettazione

- [ ] Due azioni chiare e distinguibili, entrambe raggiungibili con il pollice a una mano
- [ ] Le callback sono iniettate dall'esterno: la schermata non conosce la destinazione
- [ ] Widget test: tocco su ciascuna azione invoca la callback corretta
- [ ] Regge da 320 px in su, portrait e landscape
- [ ] Se esiste una sessione attiva (→ `C02`), compare una terza via: "riprendi partita"

## Fuori scope

Cosa succede dopo il tocco (→ `D02`, `D03`).

## ⚠️ Domande critiche

1. **"Riprendi partita" va qui o è un redirect automatico?** Se l'app rientra
   da sola nella stanza attiva, chi voleva iniziarne una nuova si trova
   intrappolato. Se non lo fa, ogni riapertura costa due tocchi. Consiglio:
   mostrarla come opzione evidente, non come redirect.
2. **Serve un onboarding / spiegazione delle regole?** Chi apre l'app la prima
   volta non sa cosa sia "modalità classica". Anche solo un `?` con due righe
   di testo cambia molto per un nuovo gruppo.
3. **Deep link**: se arrivi da un link con codice stanza (→ `D05`), questa
   schermata va saltata? Probabilmente sì, ma va gestito il caso "link a una
   stanza che non esiste più".
