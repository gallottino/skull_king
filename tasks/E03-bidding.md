# [E03] Fase di puntata

**Epic:** Loop di gioco · **Milestone:** M4 · **Stima:** M
**Labels:** `epic:gameplay` `type:feat` `size:M` `needs-decision`

## Obiettivo

Il nodo "Scommetti" del flow: ogni giocatore dichiara quante prese pensa di
fare in questo round, dal proprio device.

## Valore

È il cuore rituale di Skull King. Se questa interazione è veloce e chiara, il
tracker accelera il gioco; se è lenta, la gente torna al foglio di carta.

## Criteri di accettazione

- [ ] La puntata va da 0 al numero di carte del round, e nient'altro è selezionabile
- [ ] Inserimento con un solo tocco (selettore, non tastiera numerica)
- [ ] La puntata è modificabile finché non è confermata; dopo la conferma è bloccata
- [ ] Chi ha già puntato lo comunica agli altri senza rivelare il valore (se le puntate sono segrete → `C03`)
- [ ] Il round corrente e il numero di carte sono sempre visibili
- [ ] La puntata sopravvive a un refresh: chi ricarica non deve ripuntare

## ⚠️ Domande critiche

1. **Le puntate sono segrete fino a che tutti hanno puntato?** (→ `C03`,
   domanda 1) È una domanda di regole *e* di architettura. Nel gioco reale le
   puntate si rivelano simultaneamente con la mano: se l'app le mostra man
   mano, cambia il gioco.
2. **Si può cambiare la propria puntata dopo aver confermato ma prima che
   abbiano puntato tutti?** Se le puntate sono segrete non fa danno; se sono
   visibili, permette di barare. Coerenza con la domanda 1.
3. **Chi non punta blocca tutti.** Serve una via d'uscita: l'host può puntare
   al posto di un assente? Può forzare l'avanzamento? Senza questo, un
   telefono scarico congela la partita. **Questo caso capita davvero.**
4. **Il selettore fino a quanto arriva?** Al round 10 servono 11 valori (0-10):
   una riga di pulsanti smette di funzionare. Ruota, slider, o griglia?
   Va progettato per il caso peggiore, non per il round 1.
5. **La puntata a 0 va evidenziata?** Vale punti diversi (`10 × round`) ed è
   una scelta strategica: forse merita un trattamento visivo distinto.
