# [A03] Design system: tema, tipografia e componenti base

**Epic:** Fondamenta · **Milestone:** M0 · **Stima:** M
**Labels:** `epic:foundations` `type:feat` `size:M`

## Obiettivo

Un set minimo di componenti riusabili (bottone, pannello, testo, sfondo) e un
tema centralizzato, in modo che le schermate successive si compongano invece di
reinventare stili.

## Valore

Ogni schermata del flow (menu, form stanza, lobby, puntata, classifica) usa gli
stessi 5-6 mattoni. Farli una volta bene riduce ogni ticket successivo da
"disegna una schermata" a "componi una schermata".

## Criteri di accettazione

- [ ] `ThemeData` unico: colori, tipografia, spaziature come token, non valori magici sparsi
- [ ] Componenti base coperti da widget test e da una galleria navigabile in debug
- [ ] Ogni componente si adatta alla larghezza disponibile (nessuna dimensione fissa in pixel)
- [ ] Il layout regge da 320 px (iPhone SE) a tablet, in portrait e landscape
- [ ] Testi e contrasti leggibili: contrasto ≥ 4.5:1 sul testo di contenuto
- [ ] Nessun widget nel design system conosce Supabase o il dominio di gioco

## Note tecniche

- Struttura suggerita: atomi → molecole → organismi, con gli organismi che
  ricevono dati via costruttore e non li vanno a cercare.
- Se l'estetica è "mappa del tesoro / pergamena", gli asset raster dominano il
  peso del bundle: comprimili e valuta WebP.

## Fuori scope

Le schermate vere e proprie (Epic D/E). Qui solo i mattoni.

## ⚠️ Domande critiche

1. **Quanti giocatori deve reggere il tavolo, al massimo?** Cambia tutto nel
   layout: 6 ritratti attorno a un ovale è un problema di design diverso da 8.
   E il numero massimo dipende dalle regole (→ `B01`), non dalla grafica.
2. **Asset raster o vettoriali?** Le pergamene/ritratti in PNG sono belli ma
   pesano sul primo caricamento della PWA (`A02`). Hai un budget di peso?
   Suggerimento: fissane uno esplicito ora (es. < 3 MB al primo load).
3. **Accessibilità: quanto lontano vuoi andare?** Minimo ragionevole: target
   touch ≥ 44 px, rispetto di "riduci movimento" per le animazioni, label
   semantiche sui controlli. Su un gioco da tavolo giocato in penombra il
   contrasto conta più della finezza estetica.
4. **Font custom decorativo su tutta l'app o solo sui titoli?** Un display font
   sui numeri di punteggio è una pessima idea: `1`, `7` e i segni meno devono
   essere inequivocabili. Consiglio: font decorativo per i titoli, font di
   sistema per i numeri.
