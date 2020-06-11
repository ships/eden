#!/bin/bash

ergodox_config_file="$(find "$(dirname $0)/../assets" -name 'ergodox_ez_*')"
slug="$(echo "$ergodox_config_file" | cut -d'_' -f4 )"

echo $slug

open "https://configure.ergodox-ez.com/ergodox-ez/layouts/${slug}/latest/0"
