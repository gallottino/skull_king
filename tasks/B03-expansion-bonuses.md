# [B03] Bonus dell'espansione nel motore di punteggio

**Epic:** Dominio e punteggio · **Milestone:** M1 · **Stima:** S
**Labels:** `epic:domain` `type:feat` `size:S` `needs-decision`

## Obiettivo

Estendere il motore di `B02` con i punti bonus della modalità espansione,
mantenendo le due modalità isolate e testate separatamente.

## Valore

È la differenza fra le due modalità che l'utente sceglie in `D02`. Senza
questo, la scelta "Espansione" nel form è una bugia.

## Bonus tipici da modellare

- Cattura delle carte numeriche più alte (14) — valore diverso per il seme atout
- Sirena che cattura lo Skull King
- Skull King che cattura i pirati (per pirata)
- Tesori / carte speciali della propria edizione

**Regola chiave:** i bonus si sommano **solo se la puntata è stata indovinata**
(verificare rispetto all'edizione scelta in `B02`).

## Criteri di accettazione

- [ ] I bonus sono dati, non `if` sparsi: una struttura dichiarativa per modalità
- [ ] In modalità classica i bonus non sono calcolabili né inseribili
- [ ] Test dedicati per ogni bonus, più i casi combinati (più bonus nello stesso round)
- [ ] Test esplicito: puntata sbagliata + bonus ⇒ i bonus non vengono contati
- [ ] Il bonus totale del round è tracciato separatamente dal punteggio base (serve a `E07` per spiegare il conteggio)

## ⚠️ Domande critiche

1. **Quanti dettagli vuoi davvero far inserire?** Il conflitto è netto:
   modellare ogni bonus dà punteggi esatti ma trasforma il form di fine round
   in un modulo fiscale, giocato da persone che vogliono tornare a giocare.
   Alternativa pragmatica: **un unico campo "bonus" numerico** che il giocatore
   compila a occhio, e i bonus dettagliati solo come aiuto/promemoria.
   Questa è probabilmente la decisione di prodotto più importante del progetto.
2. **Kraken e Balena come li tratti?** Non danno punti ma alterano la presa
   (il Kraken la annulla): impattano la validazione della somma delle prese
   (→ `B02`, domanda 2), non il punteggio.
3. **Se rispondi "un campo bonus unico" alla domanda 1, questo ticket si
   riduce a XS** — e va bene così. Ma allora `B02` deve accettare un `bonus`
   arbitrario e le due modalità differiscono solo per la presenza del campo.
4. **I bonus possono essere negativi?** In alcune varianti sì (penalità).
   Se il campo è libero, l'input deve accettare il segno meno.
