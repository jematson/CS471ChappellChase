#!/bin/sh
printf '\033c\033]0;%s\a' ChappellChase
base_path="$(dirname "$(realpath "$0")")"
"$base_path/chappellchase_linux.x86_64" "$@"
