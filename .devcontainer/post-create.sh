#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 S2Arm contributors
# Idempotent Codespaces setup. Never installs into the system Python.
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
venv="$root/build/venv"

python3 -m venv "$venv"
"$venv/bin/python3" -m pip install --disable-pip-version-check --upgrade pip wheel
"$venv/bin/python3" -m pip install --disable-pip-version-check -r "$root/tools/rewriter-requirements.txt"

echo "S2Arm Codespace ready: $venv"
echo "Linux native checks: bash android/linux_ctest.sh"
echo "ARM64 APK: docker build -t s2arm-android-build:1 android/docker && bash android/docker/build.sh"
