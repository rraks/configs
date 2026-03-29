#!/bin/sh

FOCUSED_JSON=$(hyprctl activewindow -j)
FOCUSED_CLASS=$(printf '%s' "$FOCUSED_JSON" | jq -r '.class // empty')
FOCUSED_PID=$(printf '%s' "$FOCUSED_JSON" | jq -r '.pid // empty')

if [ "$FOCUSED_CLASS" = "kitty" ]; then
  if [ -n "$FOCUSED_PID" ] && [ -d "/proc/$FOCUSED_PID" ]; then
    SHELL_PID=$(ps -o pid=,comm= --ppid "$FOCUSED_PID" | awk '$2 ~ /^(zsh|bash|fish|sh|tmux|nu)$/ {print $1; exit}')

    if [ -n "$SHELL_PID" ]; then
      CWD=$(readlink -e "/proc/$SHELL_PID/cwd")
    else
      CWD=$(readlink -e "/proc/$FOCUSED_PID/cwd")
    fi

    if [ -n "$CWD" ]; then
      kitty --directory "$CWD" >/dev/null 2>&1 &
      exit 0
    fi
  fi
fi

kitty >/dev/null 2>&1 &
exit 0
