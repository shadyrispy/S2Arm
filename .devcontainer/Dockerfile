# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 S2Arm contributors
# Linux build host for GitHub Codespaces. Player builds still target Apple /
# Android; this image supplies the repository's Linux build toolchain.
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Runtime state (Feishu auth, keys) is deliberately outside the repository and
# outside the image. It lives under /workspaces so a container rebuild keeps it.
ENV LARKSUITE_CLI_CONFIG_DIR=/workspaces/.codespace-state/lark/config \
    LARKSUITE_CLI_DATA_DIR=/workspaces/.codespace-state/lark/data \
    DOTNET_ROOT=/usr/share/dotnet \
    PATH=/workspaces/.codespace-state/tools/lark-cli/node_modules/.bin:${PATH}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        git \
        glslc \
        jq \
        libicu74 \
        libjsoncpp-dev \
        libvulkan-dev \
        mesa-vulkan-drivers \
        ninja-build \
        pkg-config \
        python3 \
        python3-jsonschema \
        python3-pip \
        python3-pyparsing \
        python3-venv \
        rsync \
        unzip \
        vulkan-tools \
        vulkan-validationlayers \
        xxd \
        zip \
        zstd \
    && rm -rf /var/lib/apt/lists/*

# .NET 10.0.403 is the version locked by compat/tree/global.json.
RUN curl -fsSL --retry 3 https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh \
    && bash /tmp/dotnet-install.sh --version 10.0.403 --install-dir /usr/share/dotnet --no-path \
    && ln -sfn /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && rm -f /tmp/dotnet-install.sh \
    && dotnet --version
