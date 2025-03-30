#!/usr/bin/env nu

def main [] {}

def "main toggle-outputs-wlr" [state: bool] {
    toggle-outputs-wlr $state
}

def toggle-outputs-wlr [state: bool] {
    print $state
    let outputs: list<string> = wlr-randr --json | from json | get name
    for o in outputs {
        if $state {
            wlr-randr --output $o --on
        } else {
            wlr-randr --output $o --off
        }
    }
}

def "main toggle-outputs-hypr" [state: bool] {
    toggle-outputs-hypr $state
}

def toggle-outputs-hypr [state: bool] {
    if $state {
        hyprctl dispatch dpms on
    } else {
        hyprctl dispatch dpms off
    }
}