#!/usr/bin/env nu

def main [] {}

def "main toggle-outputs" [state: bool] {
    toggle-outputs $state
}

def toggle-outputs [state: bool] {
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
