#!/bin/bash

export PATH="$HOME/bin:$PATH"
export XDG_CACHE_HOME="$HOME/.cache"

TEMPLATE='{{$i:=false}}{{$r:=false}}{{$w:=false}}{{$s:=false}}{{range .Signals}}{{if eq .State "idle"}}{{$i = true}}{{end}}{{if eq .State "running"}}{{$r = true}}{{end}}{{if eq .State "waiting"}}{{$w = true}}{{end}}{{if eq .State "started"}}{{$s = true}}{{end}}{{end}}{{if $i}}\033[36m●\033[0m{{else}}\033[37m●\033[0m{{end}}{{if $r}}\033[32m●\033[0m{{else}}\033[37m●\033[0m{{end}}{{if $w}}\033[33m●\033[0m{{else}}\033[37m●\033[0m{{end}}{{if $s}}\033[34m●\033[0m{{else}}\033[37m●\033[0m{{end}}'

HEADER=$(beacon scan --env none --template "$TEMPLATE" 2>/dev/null)
if [ -n "$HEADER" ]; then
  echo -e "$HEADER | ansi=true"
else
  echo -e "\033[37m●●●●\033[0m | ansi=true"
fi

echo "---"

beacon scan --env none --color=always 2>/dev/null | while IFS= read -r line; do echo "$line | ansi=true"; done || echo "No active sessions"
echo "---"
echo "Refresh | refresh=true"
