#!/bin/bash
set -eu

REPO="Vlex127/Animevault-releases"
APP_NAME="animevault"
INSTALL_DIR="$HOME/.local/${APP_NAME}.app"
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/512x512/apps"

LOCAL_TARBALL="${1:-}"

arch="$(uname -m)"
case "$arch" in
    x86_64|amd64)  ARCH="x64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $arch"; exit 1 ;;
esac

TEMP=$(mktemp -d)
trap "rm -rf $TEMP" EXIT

if [ -n "$LOCAL_TARBALL" ]; then
    if [ ! -f "$LOCAL_TARBALL" ]; then
        echo "File not found: $LOCAL_TARBALL"
        exit 1
    fi
    echo "Using local tarball: $LOCAL_TARBALL"
    cp "$LOCAL_TARBALL" "$TEMP/animevault.tar.gz"
    VERSION="local"
else
    echo "Fetching latest release..."
    LATEST=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest")
    VERSION=$(echo "$LATEST" | grep '"tag_name"' | head -1 | sed 's/.*"v\(.*\)".*/\1/')
    TARBALL_URL=$(echo "$LATEST" | grep "browser_download_url.*tar.gz" | head -1 | sed 's/.*"browser_download_url": "\(.*\)".*/\1/')

    if [ -z "$TARBALL_URL" ]; then
        echo "No tarball found for v${VERSION}. Check GitHub releases."
        exit 1
    fi

    echo "Downloading v${VERSION}..."
    curl -fSL "$TARBALL_URL" -o "$TEMP/animevault.tar.gz"
fi

echo "Extracting..."
mkdir -p "$TEMP/extracted"
tar -xzf "$TEMP/animevault.tar.gz" -C "$TEMP/extracted"

if [ -d "$INSTALL_DIR" ]; then
    echo "Updating (rsync diff)..."
    rsync -a --delete --checksum "$TEMP/extracted/" "$INSTALL_DIR/"
else
    echo "Fresh install to ${INSTALL_DIR}..."
    mkdir -p "$INSTALL_DIR"
    cp -a "$TEMP/extracted/"* "$INSTALL_DIR/"
fi

mkdir -p "$BIN_DIR"
ln -sf "$INSTALL_DIR/anime" "$BIN_DIR/anime"

# Extract icon from app.asar.unpacked to a stable location
ICON_PATH="$INSTALL_DIR/icon.png"
if [ ! -f "$ICON_PATH" ] && [ -f "$INSTALL_DIR/resources/app.asar.unpacked/resources/icon.png" ]; then
    cp "$INSTALL_DIR/resources/app.asar.unpacked/resources/icon.png" "$ICON_PATH"
fi

# Install icon to hicolor for MPRIS/media integration
mkdir -p "$ICON_DIR"
if [ -f "$ICON_PATH" ]; then
    cp "$ICON_PATH" "$ICON_DIR/com.animevault.app.png"
fi

# Create .desktop entry
mkdir -p "$DESKTOP_DIR"
cat > "$DESKTOP_DIR/com.animevault.app.desktop" << EOF
[Desktop Entry]
Name=AnimeVault
Exec=$INSTALL_DIR/anime %U
Icon=com.animevault.app
Type=Application
Terminal=false
StartupWMClass=AnimeVault
Categories=AudioVideo;
EOF

# Update desktop database and icon cache
if command -v update-desktop-database &>/dev/null; then
    update-desktop-database -q "$DESKTOP_DIR" 2>/dev/null || true
fi
if command -v gtk-update-icon-cache &>/dev/null; then
    gtk-update-icon-cache -q -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
fi

echo ""
echo "AnimeVault${VERSION:+ v${VERSION}} installed!"
echo "Run with: anime"
echo "Or find it in your application menu."
