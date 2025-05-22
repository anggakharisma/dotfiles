#!/bin/bash

# Function to get available sinks (output devices)
get_sinks() {
    pactl list short sinks | cut -f2
}

# Function to get available sources (input devices)
get_sources() {
    pactl list short sources | grep -v ".monitor" | cut -f2
}

# Function to set default sink
set_default_sink() {
    pactl set-default-sink "$1"
    # Also move all current streams to the new sink
    for stream in $(pactl list short sink-inputs | cut -f1); do
        pactl move-sink-input "$stream" "$1"
    done
}

# Function to set default source
set_default_source() {
    pactl set-default-source "$1"
}

# Get current default sink and source
DEFAULT_SINK=$(pactl get-default-sink)
DEFAULT_SOURCE=$(pactl get-default-source)
WIDTH=480

case "$1" in
    output)
        # Select output device using wofi
        SELECTED_SINK=$(get_sinks | wofi --dmenu --insensitive --prompt "Select Audio Output" --width $WIDTH --style ~/.config/wofi/style.css --allow-images)
        if [ -n "$SELECTED_SINK" ]; then
            set_default_sink "$SELECTED_SINK"
        fi
        ;;
    input)
        # Select input device using wofi
        SELECTED_SOURCE=$(get_sources | wofi --dmenu --insensitive --prompt "Select Audio Input" --width $WIDTH --style ~/.config/wofi/style.css --allow-images)
        if [ -n "$SELECTED_SOURCE" ]; then
            set_default_source "$SELECTED_SOURCE"
        fi
        ;;
    *)
        # If no argument provided, show menu to choose between input and output
        CHOICE=$(echo -e "Audio Output\nAudio Input" | wofi --dmenu --insensitive --prompt "Audio Device Selection" --width $WIDTH --allow-images --style ~/.config/wofi/style.css)
        case "$CHOICE" in
            "Audio Output")
                exec "$0" output
                ;;
            "Audio Input")
                exec "$0" input
                ;;
        esac
        ;;
esac

# Refresh Waybar to update the status
pkill -SIGRTMIN+1 waybar
