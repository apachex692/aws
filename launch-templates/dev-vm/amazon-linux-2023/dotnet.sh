#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 04/11/2023
RELEASE_SERVER="2023.4.20240429"

# Update System
dnf upgrade --releasever="$RELEASE_SERVER" -y

# Install .NET Framework
rpm --import https://packages.microsoft.com/keys/microsoft.asc
wget \
  -O /etc/yum.repos.d/microsoft-prod.repo \
  https://packages.microsoft.com/config/fedora/37/prod.repo
dnf install -y dotnet-sdk-8.0

# Install VS Code
wget \
  -O ./code.tar.gz \
  "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64"

tar -x -z -f ./code.tar.gz
mkdir -p ./.local/bin/ && mv ./code ./.local/bin/
rm ./code.tar.gz

echo "alias vscode='code serve-web \
--host 0.0.0.0 \
--port 8080 \
--without-connection-token > /dev/null 2>&1 &'" >> ./.bashrc
