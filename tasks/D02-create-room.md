# [D02] Creazione stanza: modalità e codice

**Epic:** Onboarding · **Milestone:** M3 · **Stima:** M
**Labels:** `epic:onboarding` `type:feat` `size:M`

## Obiettivo

L'host sceglie la modalità (classica / espansione), crea la stanza su Supabase
e ottiene un codice condivisibile. Diventa host della stanza.

## Valore

È il primo momento in cui l'app scrive sul backend e produce qualcosa di reale
e condivisibile. Da qui in poi il progetto smette di essere un prototipo locale.

## Criteri di accettazione

- [ ] Il form mostra per ogni modalità cosa cambia (numero di round, regole attive)
- [ ] Alla conferma viene creata una riga `rooms` con codice univoco generato dal DB
- [ ] Il creatore viene inserito in `room_players` con `is_host = true`
- [ ] Il codice è mostrato in grande e leggibile a distanza, e copiabile con un tocco
- [ ] Doppio tocco sul pulsante non crea due stanze (protezione contro il doppio submit)
- [ ] Errore di rete → messaggio comprensibile e possibilità di riprovare, senza perdere la selezione
- [ ] Test: la creazione fallita non lascia l'utente in una lobby inesistente

## ⚠️ Domande critiche

1. **La creazione del personaggio viene prima o dopo la creazione della
   stanza?** Nel flow la stanza si crea *poi* si crea il personaggio. Ma se
   l'utente abbandona in mezzo, resti con una stanza orfana senza giocatori.
   Alternativa: crea personaggio prima, stanza in un'unica transazione dopo.
2. **Quali parametri deve poter scegliere l'host oltre alla modalità?**
   Candidati: numero di round (→ `B01`, domanda 1), numero massimo di
   giocatori, se le puntate sono segrete (→ `C03`, domanda 1).
   Ogni opzione in più è un'opzione da spiegare: quali valgono davvero?
3. **Che succede se l'host crea una stanza e non ci entra nessuno?**
   Stanza zombie nel DB. Serve la policy di scadenza di `C01`, domanda 2.
4. **Un utente può avere più stanze attive contemporaneamente?**
   Se no, cosa succede quando ne crea una seconda: la prima si chiude?
