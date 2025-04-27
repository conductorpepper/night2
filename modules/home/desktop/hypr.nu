#!/usr/bin/env nu

let MINIMIZE_WINDOWS = [
    "Steam"
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
