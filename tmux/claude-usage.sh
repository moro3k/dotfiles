#!/bin/bash
# Claude Code usage bar for tmux (Linux/WSL)
# Usage: claude-usage.sh [5h|7d|all]

MODE="${1:-all}"
CACHE_DIR="$HOME/.cache"
API_CACHE_FILE="$CACHE_DIR/claude-api-response.json"
LOCK_FILE="$CACHE_DIR/claude-usage.lock"
CREDS_FILE="$HOME/.claude/.credentials.json"

C_RED="#[fg=colour203]"
C_YELLOW="#[fg=colour220]"
C_GRAY="#[fg=colour245]"
C_RESET="#[default]"

[[ ! -d "$CACHE_DIR" ]] && mkdir -p "$CACHE_DIR"

get_pct_color() {
  local pct="$1"
  if [[ $pct -gt 80 ]]; then echo "$C_RED"
  elif [[ $pct -gt 60 ]]; then echo "$C_YELLOW"
  else echo "$C_GRAY"; fi
}

make_bar() {
  local pct="$1" color="$2" width=10
  local filled=$((pct * width / 100))
  local empty=$((width - filled))
  [[ $filled -gt $width ]] && filled=$width
  [[ $filled -lt 0 ]] && filled=0
  [[ $empty -lt 0 ]] && empty=0
  local bar_filled=$(printf '%*s' "$filled" '' | tr ' ' '#')
  local bar_empty=$(printf '%*s' "$empty" '' | tr ' ' '-')
  printf "${C_GRAY}[${C_RESET}${color}${bar_filled}${C_GRAY}${bar_empty}]${C_RESET}"
}

get_file_age() {
  local file="$1"
  local mod_time=$(stat -c '%Y' "$file" 2>/dev/null)
  local now=$(date +%s)
  echo $((now - mod_time))
}

format_time() {
  local seconds="$1"
  [[ $seconds -le 0 ]] && echo "0m" && return
  local hours=$((seconds / 3600)) mins=$(((seconds % 3600) / 60))
  if [[ $hours -gt 0 ]]; then echo "${hours}h${mins}m"
  else echo "${mins}m"; fi
}

format_time_days() {
  local seconds="$1"
  [[ $seconds -le 0 ]] && echo "0m" && return
  local days=$((seconds / 86400)) hours=$(((seconds % 86400) / 3600))
  local mins=$(((seconds % 3600) / 60))
  if [[ $days -gt 0 ]]; then echo "${days}d${hours}h"
  elif [[ $hours -gt 0 ]]; then echo "${hours}h${mins}m"
  else echo "${mins}m"; fi
}

parse_reset_time() {
  local iso_date="$1"
  local clean=$(echo "$iso_date" | sed 's/\.[0-9]*//; s/+00:00//; s/Z$//')
  local reset_ts=$(date -u -d "${clean}" "+%s" 2>/dev/null)
  if [[ -n "$reset_ts" ]]; then
    echo $((reset_ts - $(date +%s)))
  fi
}

fetch_api_data() {
  if [[ -f "$API_CACHE_FILE" ]]; then
    local age=$(get_file_age "$API_CACHE_FILE")
    [[ $age -lt 60 ]] && cat "$API_CACHE_FILE" && return 0
  fi
  if [[ -f "$LOCK_FILE" ]]; then
    local lock_age=$(get_file_age "$LOCK_FILE")
    if [[ $lock_age -lt 30 ]]; then
      [[ -f "$API_CACHE_FILE" ]] && cat "$API_CACHE_FILE"
      return 0
    fi
  fi
  touch "$LOCK_FILE"

  [[ ! -f "$CREDS_FILE" ]] && { [[ -f "$API_CACHE_FILE" ]] && cat "$API_CACHE_FILE"; return 0; }

  local token
  token=$(python3 -c "import json; print(json.load(open('$CREDS_FILE'))['claudeAiOauth']['accessToken'])" 2>/dev/null)
  [[ -z "$token" ]] && { [[ -f "$API_CACHE_FILE" ]] && cat "$API_CACHE_FILE"; return 0; }

  local response
  response=$(curl -s --max-time 5 "https://api.anthropic.com/api/oauth/usage" \
    -H "Authorization: Bearer $token" \
    -H "anthropic-beta: oauth-2025-04-20" 2>/dev/null)

  if [[ -n "$response" ]]; then
    echo "$response" | tee "$API_CACHE_FILE"
  else
    [[ -f "$API_CACHE_FILE" ]] && cat "$API_CACHE_FILE"
  fi
}

format_5h() {
  local response="$1"
  local pct=$(echo "$response" | python3 -c "import sys,json; print(int(float(json.load(sys.stdin).get('five_hour',{}).get('utilization',0))))" 2>/dev/null)
  [[ -z "$pct" || "$pct" == "0" ]] && return
  local color=$(get_pct_color "$pct")
  local bar=$(make_bar "$pct" "$color")
  local reset_at=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin).get('five_hour',{}).get('resets_at',''))" 2>/dev/null)
  local time_fmt="5h"
  if [[ -n "$reset_at" && "$reset_at" != "None" ]]; then
    local secs=$(parse_reset_time "$reset_at")
    [[ -n "$secs" ]] && time_fmt=$(format_time "$secs")
  fi
  printf "%s: %s %s%s%%%s" "$time_fmt" "$bar" "$color" "$pct" "$C_RESET"
}

format_7d() {
  local response="$1"
  local pct=$(echo "$response" | python3 -c "import sys,json; print(int(float(json.load(sys.stdin).get('seven_day',{}).get('utilization',0))))" 2>/dev/null)
  [[ -z "$pct" || "$pct" == "0" ]] && return
  local color=$(get_pct_color "$pct")
  local bar=$(make_bar "$pct" "$color")
  local reset_at=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin).get('seven_day',{}).get('resets_at',''))" 2>/dev/null)
  local time_fmt="7d"
  if [[ -n "$reset_at" && "$reset_at" != "None" ]]; then
    local secs=$(parse_reset_time "$reset_at")
    [[ -n "$secs" ]] && time_fmt=$(format_time_days "$secs")
  fi
  printf "%s%s:%s %s %s%s%%%s" "$C_GRAY" "$time_fmt" "$C_RESET" "$bar" "$color" "$pct" "$C_RESET"
}

RESPONSE=$(fetch_api_data)
[[ -z "$RESPONSE" ]] && exit 0

# Проверка max подписки
has_5h=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print('yes' if d.get('five_hour',{}).get('utilization') is not None else 'no')" 2>/dev/null)
has_7d=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print('yes' if d.get('seven_day',{}).get('utilization') is not None else 'no')" 2>/dev/null)
[[ "$has_5h" != "yes" && "$has_7d" != "yes" ]] && echo "${C_GRAY}∞ Max${C_RESET}" && exit 0

case "$MODE" in
  5h) format_5h "$RESPONSE" ;;
  7d) format_7d "$RESPONSE" ;;
  all|*)
    out5=$(format_5h "$RESPONSE")
    out7=$(format_7d "$RESPONSE")
    [[ -n "$out5" && -n "$out7" ]] && echo "${out5} ${C_GRAY}│${C_RESET} ${out7}" && exit 0
    [[ -n "$out5" ]] && echo "$out5"
    [[ -n "$out7" ]] && echo "$out7"
    ;;
esac
