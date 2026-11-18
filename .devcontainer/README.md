# S2Arm Linux Codespace

This devcontainer is for build verification in GitHub Codespaces. It uses the
repository's Linux Android path; it does not make Linux a supported player
platform.

The image provides:

- .NET SDK 10.0.403 (`compat/tree/global.json`)
- Node.js 20 and `lark-cli 1.0.100`
- `xxd`, `zstd`, CMake, Vulkan/lavapipe, Python 3.12
- Python packaging dependencies and generated open-source `.bfttf` fonts
- Docker-in-Docker plus the pinned `s2arm-android-build:1` image

## Runtime data

Game images, `prod.keys`, Feishu login state and generated build outputs are
never baked into the image or committed to the repository. They live outside
the checkout:

```text
/workspaces/game-input/              # NSP/XCI input
/workspaces/.codespace-state/keys/   # prod.keys
/workspaces/.codespace-state/lark/   # lark-cli config and encrypted tokens
```

## Build

```sh
cd /workspaces/S2Arm
S2A_PYTHON="$PWD/build/venv/bin/python3" \
bash pack/oneclick/oneclick.sh /workspaces/game-input/pokemon \
  --target android \
  --keys /workspaces/.codespace-state/keys/prod.keys \
  --fonts /workspaces/S2Arm/build/openfonts \
  --out /workspaces/game-build/pokemon
```

The Mac launcher and iOS targets require Xcode and cannot be compiled here.

GitHub Codespaces offers `standardLinux32gb` (4 cores, 16 GB RAM, 32 GB storage)
for this account; no 64 GB storage machine is available.
