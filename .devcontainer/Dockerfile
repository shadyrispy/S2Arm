# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 S2Arm contributors
# Linux build host for GitHub Codespaces. The player-facing targets stay Apple /
# Android; this image only supplies the tools used by the repository's Linux
# Android checks and the Docker-backed APK build.
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

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
        zip \
    && rm -rf /var/lib/apt/lists/*
