#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 S2Arm contributors
# Idempotent Codespaces setup. Build tools live in the image; user state lives
# under /workspaces/.codespace-state and is never committed.
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
state=/workspaces/.codespace-state
venv="$root/build/venv"
fonts="$root/build/openfonts"

mkdir -p "$venv" "$fonts" \
    "$state/keys" "$state/lark/config" "$state/lark/data" "$state/tools/lark-cli"
chmod 700 "$state" "$state/keys" "$state/lark" "$state/lark/config" "$state/lark/data"

python3 -m venv "$venv"
"$venv/bin/python3" -m pip install --disable-pip-version-check --upgrade pip wheel
"$venv/bin/python3" -m pip install --disable-pip-version-check \
    -r "$root/tools/rewriter-requirements.txt" \
    -r "$root/launchers/macos/requirements-runtime.txt" \
    -r "$root/pack/fonts/requirements.txt"

if ! compgen -G "$fonts/*.bfttf" > /dev/null; then
    "$venv/bin/python3" "$root/pack/fonts/make_open_fonts.py" "$fonts"
fi

if [ ! -x "$state/tools/lark-cli/node_modules/.bin/lark-cli" ]; then
    npm install --prefix "$state/tools/lark-cli" --no-audit --no-fund --save-exact \
        @larksuite/cli@1.0.100
fi
"$state/tools/lark-cli/node_modules/.bin/lark-cli" --version

if ! docker image inspect s2arm-android-build:1 > /dev/null 2>&1; then
    docker build --tag s2arm-android-build:1 "$root/android/docker"
fi

echo "S2Arm Codespace ready"
echo "  Python: $venv"
echo "  Fonts:  $fonts"
echo "  Lark:   lark-cli $(lark-cli --version)"
echo "  Android image: s2arm-android-build:1"
