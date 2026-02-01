#!/bin/bash
# Status line hook for WezTerm integration

INPUT=$(cat)

# Extract numeric fields
read -r CTX MAX IN_TOK OUT_TOK CACHE COST ADD DEL < <(
  echo "$INPUT" | jq -r '[
    .context_window.used_percentage // 0,
    .context_window.context_window_size // 200000,
    .context_window.total_input_tokens // 0,
    .context_window.total_output_tokens // 0,
    .context_window.current_usage.cache_read_input_tokens // 0,
    .cost.total_cost_usd // 0,
    .cost.total_lines_added // 0,
    .cost.total_lines_removed // 0
  ] | @tsv'
)

# Extract string fields separately
MODEL=$(echo "$INPUT" | jq -r '.model.display_name // "claude"')
VER=$(echo "$INPUT" | jq -r '.version // ""')

# Write JSON for WezTerm
cat > ~/.claude/wezterm-status.json <<EOF
{"ctx":$CTX,"max":$MAX,"in":$IN_TOK,"out":$OUT_TOK,"cache":$CACHE,"cost":$COST,"add":$ADD,"del":$DEL,"model":"$MODEL","ver":"$VER","ts":$(date +%s)}
EOF
