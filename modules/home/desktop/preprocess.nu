#!/usr/bin/env nu

# A preprocess script for use by Anyrun.
# It uses app2unit since stuff like Podman Desktop
# would just exit the uwsm session.
# This isn't used anymore since the execution
# isn't what I thought it would be.
def main [term_string: string, command: string] {
    if $term_string == "term" {
        return $"app2unit-term -e ($command)"
    } else if $term_string == "no-term" {
        return $"app2unit -- ($command)"
    }
}
