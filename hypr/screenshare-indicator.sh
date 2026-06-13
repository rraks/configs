#!/usr/bin/env bash
# Reads Hyprland's IPC event socket and outputs waybar JSON on screencast events.
# Hyprland emits: screencast>>1,<owner_type> (started) and screencast>>0,<owner_type> (stopped)

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Initial state: hidden
echo '{"text":"","class":"","tooltip":""}'

socat - UNIX-CONNECT:"$SOCKET" 2>/dev/null | while IFS= read -r event; do
    case "$event" in
        screencast>>1,*)
            echo '{"text":"󰖠 Sharing","class":"screenshare","tooltip":"Screen is being shared"}'
            ;;
        screencast>>0,*)
            echo '{"text":"","class":"","tooltip":""}'
            ;;
    esac
done
