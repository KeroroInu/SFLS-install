#!/bin/bash
set -euo pipefail
if [ "$(uname -s)" != Darwin ]; then echo 'This command is for macOS.'; exit 1; fi
SFLS_DOWNLOAD_DIR="$(mktemp -d "${TMPDIR:-/tmp}/sfls-online.XXXXXX")"
echo 'Downloading the SFLS installer...'
/usr/bin/curl --proto '=https' --proto-redir '=https' --tlsv1.2 --fail --location --retry 2 --connect-timeout 20 --max-time 300 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.17/SFLS-0.1.17-mac.zip' -o "$SFLS_DOWNLOAD_DIR/sfls.zip"
SFLS_DOWNLOADED_SHA="$(/usr/bin/shasum -a 256 "$SFLS_DOWNLOAD_DIR/sfls.zip")"
if [ "${SFLS_DOWNLOADED_SHA%% *}" != '6752e49b07a52f9540628d3022873c3db03df804d2ff46b89726e836de217d69' ]; then echo 'Checksum failed. Installer not executed.'; exit 1; fi
/usr/bin/ditto -x -k "$SFLS_DOWNLOAD_DIR/sfls.zip" "$SFLS_DOWNLOAD_DIR/package"
/bin/bash "$SFLS_DOWNLOAD_DIR/package/Install.command"
