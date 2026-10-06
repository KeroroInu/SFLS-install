#!/bin/bash
set -euo pipefail
if [ "$(uname -s)" != Darwin ]; then echo 'This command is for macOS.'; exit 1; fi
SFLS_DOWNLOAD_DIR="$(mktemp -d "${TMPDIR:-/tmp}/sfls-online.XXXXXX")"
echo 'Downloading the SFLS installer...'
/usr/bin/curl --proto '=https' --proto-redir '=https' --tlsv1.2 --fail --location --retry 2 --connect-timeout 20 --max-time 300 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.2/SFLS-0.1.2-mac.zip' -o "$SFLS_DOWNLOAD_DIR/sfls.zip"
SFLS_DOWNLOADED_SHA="$(/usr/bin/shasum -a 256 "$SFLS_DOWNLOAD_DIR/sfls.zip")"
if [ "${SFLS_DOWNLOADED_SHA%% *}" != '48dc57200f06a3cfe7c651d1572ccd0b44b19581addd0e0e3e7a9d12522ad2cb' ]; then echo 'Checksum failed. Installer not executed.'; exit 1; fi
/usr/bin/ditto -x -k "$SFLS_DOWNLOAD_DIR/sfls.zip" "$SFLS_DOWNLOAD_DIR/package"
/bin/bash "$SFLS_DOWNLOAD_DIR/package/Install.command"
