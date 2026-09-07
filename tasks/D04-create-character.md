# [D04] Creazione del personaggio

**Epic:** Onboarding · **Milestone:** M3 · **Stima:** S
**Labels:** `epic:onboarding` `type:feat` `size:S`

## Obiettivo

Prima di sedersi al tavolo, il giocatore sceglie un nickname e un avatar da
pirata. Nodo condiviso del flow: ci arrivano sia chi crea sia chi si unisce.

## Valore

È ciò che rende riconoscibili i giocatori attorno al tavolo. Senza, la lobby è
una lista di UUID.

## Criteri di accettazione

- [ ] Nickname: lunghezza minima e massima, trim, validazione mostrata mentre si scrive
- [ ] Selezione avatar visuale, con anteprima di come apparirà al tavolo
- [ ] Gli avatar già presi nella stanza sono indisponibili o marcati come tali, in tempo reale
- [ ] Nickname e avatar vengono precompilati dall'ultima scelta salvata localmente
- [ ] Alla conferma il giocatore appare in lobby su tutti i device entro ~1s
- [ ] Il form non si può inviare due volte

## ⚠️ Domande critiche

1. **Gli avatar devono essere univoci nella stanza?** Due pirati identici
   rendono il tavolo illeggibile, ma con più giocatori che avatar disponibili
   l'unicità diventa impossibile. Quanti avatar hai, e qual è il massimo di
   giocatori? Se `avatar < giocatori`, serve un secondo tratto distintivo
   (colore del bordo, iniziale).
2. **La scelta dell'avatar è modificabile dopo?** In lobby probabilmente sì,
   a partita iniziata probabilmente no (cambiare faccia a metà partita
   confonde chi legge la classifica).
3. **Moderazione dei nickname?** Fra amici il tema non esiste; se un giorno il
   link circola, esiste eccome. Almeno un limite di lunghezza e un filtro sui
   caratteri di controllo/emoji che rompono il layout.
4. **Che succede a chi rientra dopo aver perso la sessione?** Se deve
   ricreare il personaggio, rischia di occupare un secondo posto al tavolo
   (→ `C02`, `D03`).
