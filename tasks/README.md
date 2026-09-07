# Backlog — Skull King Score Tracker

Backlog di sviluppo derivato dal flow `skull_king_flow.png`.
Ogni file `*.md` in questa cartella è **un issue GitHub**: incremento piccolo,
rilasciabile e con valore autonomo.

## Come leggere un ticket

| Campo | Significato |
|---|---|
| **Epic** | Raggruppamento logico → usa una label `epic:*` |
| **Milestone** | M0…M5, l'ordine in cui il prodotto diventa usabile |
| **Stima** | XS (≤2h) · S (½ giorno) · M (1-2 giorni) · L (3+ giorni, valuta se spezzarlo) |
| **Criteri di accettazione** | Cosa deve essere vero perché l'issue si chiuda |
| **Domande critiche** | ⚠️ Da risolvere **prima** di iniziare: rispondi nei commenti dell'issue |

## Milestone

| # | Nome | Obiettivo dimostrabile |
|---|---|---|
| **M0** | Fondamenta | Il progetto build-a, testa, si installa come PWA |
| **M1** | Regole del gioco | Il punteggio di Skull King è calcolato correttamente, offline |
| **M2** | Backend | Una stanza esiste su Supabase e due device la vedono |
| **M3** | Onboarding | Due persone entrano nella stessa stanza da telefoni diversi |
| **M4** | Loop di gioco | Una partita intera giocabile end-to-end |
| **M5** | Robustezza & rilascio | Riconnessione, correzioni, deploy pubblico |

## Ordine consigliato

```
M0  A01 → A02 → A03 → A04
M1  B01 → B02 → B03
M2  C01 → C02 → C03 → C04
M3  D01 → D02 → D03 → D04 → D05
M4  E01 → E02 → E03 → E04 → E05 → E06 → E07 → E08 → E09
M5  F01 → F02 → F03 → F04 → F05
```

B01/B02 sono parallelizzabili con A02/A03: non toccano né rete né UI.

## Setup della board su GitHub

### 1. Labels

```sh
gh label create "epic:foundations"  --color 5319E7
gh label create "epic:domain"       --color 0E8A16
gh label create "epic:backend"      --color 1D76DB
gh label create "epic:onboarding"   --color FBCA04
gh label create "epic:gameplay"     --color D93F0B
gh label create "epic:hardening"    --color B60205

gh label create "type:feat"  --color A2EEEF
gh label create "type:chore" --color EDEDED
gh label create "type:bug"   --color D73A4A

gh label create "size:XS" --color EEEEEE
gh label create "size:S"  --color DDDDDD
gh label create "size:M"  --color CCCCCC
gh label create "size:L"  --color BBBBBB

gh label create "needs-decision" --color FEF2C0 \
  --description "Ha domande critiche aperte: non iniziare finché non sono risolte"
```

### 2. Milestone

```sh
for m in "M0 Fondamenta" "M1 Regole del gioco" "M2 Backend" \
         "M3 Onboarding" "M4 Loop di gioco" "M5 Robustezza e rilascio"; do
  gh api repos/:owner/:repo/milestones -f title="$m" >/dev/null
done
```

### 3. Progetto (board)

```sh
gh project create --owner @me --title "Skull King Tracker"
```

Colonne consigliate: `Backlog` → `Needs decision` → `Ready` → `In progress` → `In review` → `Done`.

> **Regola**: un ticket resta in `Needs decision` finché le sue domande critiche
> non hanno risposta scritta nel thread dell'issue. È lì che sta il rischio vero
> di questo progetto, non nel codice.

### 4. Creare gli issue

```sh
./tasks/create_issues.sh          # dry-run: stampa i comandi
./tasks/create_issues.sh --run    # crea davvero
```

## Decisioni trasversali ancora aperte

Queste attraversano più ticket. Vale la pena chiuderle **prima di M2**:

1. **Chi inserisce i punteggi?** Ogni giocatore i propri, oppure solo l'host per
   tutti? Il flow (*"Proprietario della stanza dichiara fine round"*) suggerisce
   il primo, ma cambia radicalmente RLS, realtime e UX. → `E05`
2. **L'app conosce le regole o è solo un foglio di carta condiviso?** Cioè:
   validiamo che la somma delle prese sia coerente col round, o accettiamo
   qualsiasi numero? → `B02`, `E05`
3. **Quanti round dura una partita**, e dipende dal numero di giocatori? → `B01`
4. **Autenticazione**: anonima Supabase o `device_id` in `localStorage`? → `C02`
5. **Cosa succede se l'host se ne va a metà partita?** → `F03`
