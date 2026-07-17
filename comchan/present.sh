#!/usr/bin/env bash

if ! command -v wezterm &>/dev/null; then
  echo "wezterm is not installed. Please install it first."
  exit 1
fi

if ! command -v presenterm &>/dev/null; then
  echo "installing presenterm..."
  cargo install --git https://github.com/mfontanini/presenterm
  exit 1
fi

[ -z "$PRESENT_MODE" ] && args="" || args="-p"

# Check if we are already running inside WezTerm
if [ -n "$WEZTERM_EXECUTABLE" ]; then
  # Run directly in the current terminal
  presenterm "$PWD"/presentation.md --config-file "$PWD"/config/presenterm.yml -X $args
else
  # Spawn a new WezTerm window
  wezterm \
    start presenterm \
    "$PWD"/presentation.md \
    --config-file "$PWD"/config/presenterm.yml \
    -X $args &
fi
