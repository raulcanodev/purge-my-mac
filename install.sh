#!/usr/bin/env bash

set -eu

REPOSITORY="${PURGE_MY_MAC_REPOSITORY:-raulcanodev/purge-my-mac}"
BRANCH="${PURGE_MY_MAC_BRANCH:-main}"
INSTALL_DIR="${PURGE_MY_MAC_INSTALL_DIR:-$HOME/.local/bin}"
SOURCE_URL="https://raw.githubusercontent.com/${REPOSITORY}/${BRANCH}/purge-my-mac"
TARGET="$INSTALL_DIR/purge-my-mac"
TEMP_FILE=$(mktemp "${TMPDIR:-/tmp}/purge-my-mac-install.XXXXXX")

cleanup() {
  rm -f "$TEMP_FILE"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'purge-my-mac está diseñado para macOS.\n' >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  printf 'Se necesita curl para instalar purge-my-mac.\n' >&2
  exit 1
fi

printf '\n  Instalando purge-my-mac…\n'
curl -fsSL "$SOURCE_URL" -o "$TEMP_FILE"
mkdir -p "$INSTALL_DIR"
install -m 0755 "$TEMP_FILE" "$TARGET"

printf '  ✓ Instalado en %s\n' "$TARGET"

case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    printf '\n  Añade esta línea a tu ~/.zshrc y abre una terminal nueva:\n\n'
    printf '    export PATH="%s:$PATH"\n' "$INSTALL_DIR"
    ;;
esac

printf '\n  Ejecuta: purge-my-mac --dry-run\n\n'
