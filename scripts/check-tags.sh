#!/usr/bin/env bash
# Deterministic tag lint for experiments.json (see "Tags" in README.md).
# 1. Every tag must be a lowercase kebab-case slug.
# 2. No two distinct tags may collapse to the same key after lowercasing and
#    stripping ".", "@", "/", "-", spaces and a trailing "s" — that catches
#    case, punctuation and singular/plural variants (three.js vs threejs,
#    shader vs shaders). Synonyms (text vs typography) are left to Greptile review.
set -euo pipefail

file="${1:-experiments.json}"
status=0

invalid=$(jq -r '
  .experiments[] | .slug as $slug | (.tags // [])[]
  | select(test("^[a-z0-9]+(-[a-z0-9]+)*$") | not)
  | "\($slug): \(.)"
' "$file")
if [ -n "$invalid" ]; then
  while IFS= read -r line; do echo "::error::Tag is not a lowercase kebab-case slug — $line"; done <<< "$invalid"
  status=1
fi

collisions=$(jq -r '
  [.experiments[] | (.tags // [])[]] | unique
  | group_by(ascii_downcase | gsub("[.@/ -]"; "") | sub("s$"; ""))
  | map(select(length > 1) | join(", "))
  | .[]
' "$file")
if [ -n "$collisions" ]; then
  while IFS= read -r line; do echo "::error::Near-duplicate tags, pick one canonical spelling — $line"; done <<< "$collisions"
  status=1
fi

[ "$status" -eq 0 ] && echo "Tags OK"
exit "$status"
