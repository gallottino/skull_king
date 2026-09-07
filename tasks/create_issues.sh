#!/usr/bin/env bash
# Crea un issue GitHub per ogni ticket in tasks/.
#
#   ./tasks/create_issues.sh          # dry-run: stampa i comandi
#   ./tasks/create_issues.sh --run    # crea davvero gli issue
#
# Richiede `gh auth login` e le label/milestone già create (vedi tasks/README.md).
set -euo pipefail

RUN=false
[ "${1:-}" = "--run" ] && RUN=true

milestone_for() {
  case "$1" in
    M0) echo "M0 Fondamenta" ;;
    M1) echo "M1 Regole del gioco" ;;
    M2) echo "M2 Backend" ;;
    M3) echo "M3 Onboarding" ;;
    M4) echo "M4 Loop di gioco" ;;
    M5) echo "M5 Robustezza e rilascio" ;;
    *)  echo "milestone sconosciuta per '$1'" >&2; return 1 ;;
  esac
}

for file in "$(dirname "$0")"/[A-F][0-9][0-9]-*.md; do
  # "# [A01] Titolo" -> "[A01] Titolo"
  title=$(head -1 "$file" | sed 's/^# //')

  # "**Labels:** `epic:x` `type:y`" -> x,y
  labels=$(grep -m1 '^\*\*Labels:\*\*' "$file" \
    | grep -o '`[^`]*`' | tr -d '`' | paste -sd, -)

  # "**Epic:** ... · **Milestone:** M0 · ..." -> M0
  key=$(grep -m1 '^\*\*Epic:\*\*' "$file" \
    | sed -n 's/.*\*\*Milestone:\*\* \(M[0-9]\).*/\1/p')
  milestone=$(milestone_for "$key")

  if $RUN; then
    gh issue create \
      --title "$title" \
      --body-file "$file" \
      --label "$labels" \
      --milestone "$milestone"
  else
    printf 'gh issue create --title %q --body-file %q --label %q --milestone %q\n' \
      "$title" "$file" "$labels" "$milestone"
  fi
done
