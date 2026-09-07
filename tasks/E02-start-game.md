# [E02] Avvio della partita da parte dell'host

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** S
**Labels:** `epic:gameplay` `type:feat` `size:S`

## Obiettivo

Quando la ciurma è al completo, l'host avvia la partita: la stanza passa da
`lobby` a `bidding` sul round 1, e tutti i device seguono.

## Valore

È la transizione che chiude l'onboarding e apre il gioco. È anche il primo
comando riservato all'host: il modello di autorità del sistema si stabilisce
qui.

## Criteri di accettazione

- [ ] Solo l'host vede e può usare il comando di avvio (imposto anche dalle RLS, non solo dalla UI)
- [ ] Il comando è disabilitato sotto il numero minimo di giocatori, con motivo esplicito
- [ ] All'avvio vengono creati il round 1 e le entry vuote per tutti i giocatori, in modo atomico
- [ ] Tutti i device passano alla fase di puntata entro ~1s, senza azione manuale
- [ ] Un doppio invio non crea due round
- [ ] Dopo l'avvio, la stanza non accetta nuovi ingressi (o li accetta secondo la regola decisa in `B01`)

## ⚠️ Domande critiche

1. **La transizione è atomica?** Creare round + N entry + aggiornare lo stato
   stanza sono più scritture. Se una fallisce a metà, la partita resta in uno
   stato impossibile. Serve una funzione Postgres (RPC) che faccia tutto in
   una transazione — non tre chiamate dal client.
2. **Chi decide che "ci sono tutti"?** L'host a occhio, o il sistema con un
   numero di giocatori dichiarato alla creazione? Il flow dice "non ci sono
   ancora tutti i giocatori" come condizione di attesa: implica che il sistema
   sappia quanti sono attesi. Da dove viene quel numero?
3. **Serve un countdown o una conferma?** Avviare per sbaglio con un giocatore
   ancora nel form del personaggio è irreversibile senza `F02`.
4. **L'host può essere anche un giocatore?** Sì presumibilmente, ma verifica
   che il flusso funzioni anche se l'host è *solo* segnapunti e non gioca —
   è uno scenario comune ai tavoli reali.
