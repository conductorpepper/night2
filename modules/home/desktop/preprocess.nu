#!/usr/bin/env nu

def main [term_string: string, command: string] {
    if $term_string == "term" {
        app2unit-term -e $command
    } else if $term_string == "no-term" {
        app2unit -- $command
    }
}
