#!/usr/bin/env nu

# unmaps/minimizes these windows
# so it feels snappier and intended
let MINIMIZE_WINDOWS = [
    "Steam"
    "thunderbird"
    "tutanota-desktop"
    "vesktop"
]

def main [] {}

def "main kill-active" [] {
    let current_class = hyprctl activewindow -j | from json | get class
    if ($current_class in $MINIMIZE_WINDOWS) {
        xdotool getactivewindow windowunmap
    } else {
        hyprctl dispatch killactive ""
    }
}
