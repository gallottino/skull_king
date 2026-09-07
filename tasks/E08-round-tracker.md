# [E08] Indicatore di avanzamento della partita

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** S
**Labels:** `epic:gameplay` `type:feat` `size:S`

## Obiettivo

Un indicatore sempre visibile: a che round siamo, quante carte si giocano,
quanto manca alla fine.

## Valore

Risponde alla domanda che qualcuno fa a ogni round ("a che punto siamo?") e
dà il senso di progressione che tiene viva una partita da 45 minuti.

## Criteri di accettazione

- [ ] Round corrente e totale sempre visibili in ogni fase di gioco
- [ ] Il numero di carte del round è derivato dalle regole, non inserito a mano
- [ ] L'avanzamento si aggiorna automaticamente alla chiusura del round
- [ ] Funziona per qualunque numero di round configurato (→ `B01`, domanda 1)
- [ ] Rispetta "riduci movimento": senza animazioni resta comunque comprensibile
- [ ] Non ruba spazio verticale alle schermate dense (`E05`, `E07`)

## ⚠️ Domande critiche

1. **È navigabile o solo informativo?** Toccare un round passato per vederne il
   dettaglio è utile (→ `E07`, domanda 1), ma apre la porta alla modifica
   retroattiva (→ `F02`). Decidi se è di sola lettura.
2. **Con 10+ round l'indicatore diventa affollato** su schermi stretti.
   Serve un fallback testuale ("Round 7 / 10") sotto una certa larghezza.
3. **Deve mostrare anche di chi è il turno di mazziere?** Skull King ruota il
   mazziere e il primo di mano: se il tracker lo ricorda, risolve un'altra
   discussione ricorrente al tavolo. È fuori dal flow disegnato, ma costa poco.
