# S2Arm Linux Codespace

This devcontainer is for build verification in GitHub Codespaces. It uses the
repository's existing Linux Android path; it does not make Linux a supported
player platform.

## Compile

```sh
# Host-native Android runtime CTest with Mesa lavapipe.
bash android/linux_ctest.sh

# ARM64 Android APK, built inside the repository's pinned Linux image.
docker build -t s2arm-android-build:1 android/docker
bash android/docker/build.sh
```

The Mac launcher and iOS targets require Xcode and cannot be compiled here.

The smallest Codespace machine with enough memory for the Docker build is
`standardLinux32gb` (4 cores, 16 GB RAM, 32 GB storage). GitHub Codespaces does
not currently offer a 64 GB storage variant for this account.
